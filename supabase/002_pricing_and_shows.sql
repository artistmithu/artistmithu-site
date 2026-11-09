-- 002: price modes (fixed / range / on request) and the web-show archive.

-- Pricing -------------------------------------------------------------------
alter table public.artworks
  add column if not exists price_mode text not null default 'on_request'
    check (price_mode in ('fixed','range','on_request')),
  add column if not exists price_bdt_max numeric(12,0),
  add column if not exists price_usd_max numeric(10,0);

-- Works that already had a visible price become 'fixed'.
update public.artworks set price_mode = 'fixed'
  where show_price and price_bdt is not null and price_mode = 'on_request';

-- Shows (web shows, solo and group exhibitions) -------------------------------
alter table public.exhibitions
  add column if not exists slug text unique,
  add column if not exists title_bn text,
  add column if not exists statement_en text,
  add column if not exists statement_bn text,
  add column if not exists youtube_url text,
  add column if not exists cover_path text,
  add column if not exists original_url text,
  add column if not exists wayback_url text,
  add column if not exists published boolean not null default true,
  add column if not exists sort int not null default 0;

create table if not exists public.exhibition_works (
  exhibition_id uuid not null references public.exhibitions(id) on delete cascade,
  artwork_id uuid not null references public.artworks(id) on delete cascade,
  sort int not null default 0,
  primary key (exhibition_id, artwork_id)
);
create index if not exists exhibition_works_artwork on public.exhibition_works (artwork_id);
alter table public.exhibition_works enable row level security;
drop policy if exists "public read exhibition works" on public.exhibition_works;
create policy "public read exhibition works" on public.exhibition_works for select using (true);
drop policy if exists "admin write exhibition works" on public.exhibition_works;
create policy "admin write exhibition works" on public.exhibition_works for all
  using (public.is_admin()) with check (public.is_admin());

drop policy if exists "public read exhibitions" on public.exhibitions;
create policy "public read exhibitions" on public.exhibitions for select using (published or public.is_admin());

-- Public view: prices only when the work is priced (fixed or range).
drop view if exists public.artworks_public;
create view public.artworks_public with (security_invoker = true) as
  select id, inv_no, slug, title_en, title_bn, series_id, year, medium, support,
         height_cm, width_cm, depth_cm, size_class, framed, status, edition,
         description_en, description_bn, featured, sort,
         case when price_mode <> 'on_request' or show_price then price_mode else 'on_request' end as price_mode,
         case when price_mode <> 'on_request' or show_price then price_bdt end as price_bdt,
         case when price_mode <> 'on_request' or show_price then price_usd end as price_usd,
         case when price_mode = 'range' then price_bdt_max end as price_bdt_max,
         case when price_mode = 'range' then price_usd_max end as price_usd_max
  from public.artworks where published;
grant select on public.artworks_public to anon, authenticated;

-- Client links: include price mode and range so the client room shows the same price as the site.
create or replace function public.get_collection(p_token text)
returns json language sql stable security definer set search_path = public as $$
  select json_build_object(
    'client_name', c.client_name, 'note', c.note,
    'artworks', coalesce((select json_agg(json_build_object(
        'id', a.id, 'inv_no', a.inv_no, 'slug', a.slug, 'title_en', a.title_en, 'title_bn', a.title_bn,
        'year', a.year, 'medium', a.medium, 'support', a.support, 'published', a.published,
        'height_cm', a.height_cm, 'width_cm', a.width_cm, 'status', a.status,
        'price_mode', case when c.show_prices then a.price_mode else 'on_request' end,
        'price_bdt', case when c.show_prices then a.price_bdt end,
        'price_usd', case when c.show_prices then a.price_usd end,
        'price_bdt_max', case when c.show_prices then a.price_bdt_max end,
        'price_usd_max', case when c.show_prices then a.price_usd_max end,
        'images', (select json_agg(i.path order by i.sort) from artwork_images i where i.artwork_id = a.id)
      ) order by array_position(c.artwork_ids, a.id))
      from artworks a where a.id = any(c.artwork_ids)), '[]'::json))
  from client_collections c
  where c.token = p_token and (c.expires_at is null or c.expires_at > now())
$$;
grant execute on function public.get_collection(text) to anon, authenticated;
