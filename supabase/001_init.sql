-- artistmithu.com: core schema
create extension if not exists pgcrypto;

-- Admins (the artist and helpers). Add a row after signing up in Supabase Auth.
create table public.admins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);
create or replace function public.is_admin() returns boolean
language sql stable security definer set search_path = public as
$$ select exists (select 1 from public.admins where user_id = auth.uid()) $$;

create type public.artwork_status as enum ('available','reserved','sold','nfs');
create type public.image_kind as enum ('main','detail','wall','signature','process');

create table public.series (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  title_en text not null,
  title_bn text,
  chapter text,                    -- Roots / Evolving Lines / Media Life / Lines of Life
  description_en text,
  description_bn text,
  sort int not null default 0
);

create table public.artworks (
  id uuid primary key default gen_random_uuid(),
  inv_no text unique not null,     -- e.g. TIM-2019-009
  slug text unique not null,
  title_en text not null,
  title_bn text,
  series_id uuid references public.series(id) on delete set null,
  year int,
  medium text,                     -- Oil, Acrylic, Watercolor, Pen...
  support text,                    -- canvas, paper...
  height_cm numeric(6,1),
  width_cm numeric(6,1),
  depth_cm numeric(6,1),
  size_class text generated always as (
    case when height_cm is null or width_cm is null then null
         when greatest(height_cm, width_cm) < 40 then 'small'
         when greatest(height_cm, width_cm) <= 90 then 'medium'
         else 'large' end) stored,
  framed boolean not null default false,
  signed text,
  price_bdt numeric(12,0),
  price_usd numeric(10,0),
  show_price boolean not null default false,  -- false = "Price on request"
  status public.artwork_status not null default 'available',
  edition text,                    -- for prints: '12/50'
  description_en text,
  description_bn text,
  featured boolean not null default false,
  published boolean not null default false,
  sort int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index on public.artworks (published, size_class);
create index on public.artworks (series_id);

create table public.artwork_images (
  id uuid primary key default gen_random_uuid(),
  artwork_id uuid not null references public.artworks(id) on delete cascade,
  path text not null,              -- storage path in bucket 'artworks'
  kind public.image_kind not null default 'main',
  alt_en text,
  alt_bn text,
  width int, height int,
  sort int not null default 0
);
create index on public.artwork_images (artwork_id, sort);

create table public.exhibitions (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  kind text not null default 'solo',   -- solo / group / web-show / art-fair
  venue text, city text, country text,
  start_date date, end_date date,
  url text,
  description text
);

create table public.inquiries (
  id uuid primary key default gen_random_uuid(),
  artwork_id uuid references public.artworks(id) on delete set null,
  name text not null,
  email text,
  phone text,
  country text,
  message text,
  source text,                         -- website / app / client-link
  handled boolean not null default false,
  created_at timestamptz not null default now(),
  constraint contact_present check (email is not null or phone is not null)
);

create table public.subscribers (
  email text primary key,
  lang text default 'bn',
  created_at timestamptz not null default now()
);

-- Private selections the artist shares with a client ("viewing room").
create table public.client_collections (
  id uuid primary key default gen_random_uuid(),
  token text unique not null default encode(gen_random_bytes(9),'hex'),
  client_name text,
  note text,
  artwork_ids uuid[] not null default '{}',
  show_prices boolean not null default true,
  expires_at timestamptz,
  created_at timestamptz not null default now()
);

create or replace function public.touch_updated_at() returns trigger language plpgsql as
$$ begin new.updated_at = now(); return new; end $$;
create trigger artworks_touch before update on public.artworks
  for each row execute function public.touch_updated_at();

-- Client link: anyone with the token sees that selection (incl. unpublished works the artist chose).
create or replace function public.get_collection(p_token text)
returns json language sql stable security definer set search_path = public as $$
  select json_build_object(
    'client_name', c.client_name, 'note', c.note,
    'artworks', coalesce((select json_agg(json_build_object(
        'id', a.id, 'inv_no', a.inv_no, 'slug', a.slug, 'title_en', a.title_en, 'title_bn', a.title_bn,
        'year', a.year, 'medium', a.medium, 'support', a.support,
        'height_cm', a.height_cm, 'width_cm', a.width_cm, 'status', a.status,
        'price_bdt', case when c.show_prices then a.price_bdt end,
        'price_usd', case when c.show_prices then a.price_usd end,
        'images', (select json_agg(i.path order by i.sort) from artwork_images i where i.artwork_id = a.id)
      ) order by array_position(c.artwork_ids, a.id))
      from artworks a where a.id = any(c.artwork_ids)), '[]'::json))
  from client_collections c
  where c.token = p_token and (c.expires_at is null or c.expires_at > now())
$$;
grant execute on function public.get_collection(text) to anon, authenticated;

-- Public view hides prices unless show_price is on.
create view public.artworks_public with (security_invoker = true) as
  select id, inv_no, slug, title_en, title_bn, series_id, year, medium, support,
         height_cm, width_cm, depth_cm, size_class, framed, status, edition,
         description_en, description_bn, featured, sort,
         case when show_price then price_bdt end as price_bdt,
         case when show_price then price_usd end as price_usd
  from public.artworks where published;

-- Row level security
alter table public.admins enable row level security;
alter table public.series enable row level security;
alter table public.artworks enable row level security;
alter table public.artwork_images enable row level security;
alter table public.exhibitions enable row level security;
alter table public.inquiries enable row level security;
alter table public.subscribers enable row level security;
alter table public.client_collections enable row level security;

create policy "admins read self" on public.admins for select using (user_id = auth.uid());

create policy "public read series" on public.series for select using (true);
create policy "admin write series" on public.series for all using (public.is_admin()) with check (public.is_admin());

create policy "public read published works" on public.artworks for select using (published or public.is_admin());
create policy "admin write works" on public.artworks for all using (public.is_admin()) with check (public.is_admin());

create policy "public read images" on public.artwork_images for select using (
  public.is_admin() or exists (select 1 from public.artworks a where a.id = artwork_id and a.published));
create policy "admin write images" on public.artwork_images for all using (public.is_admin()) with check (public.is_admin());

create policy "public read exhibitions" on public.exhibitions for select using (true);
create policy "admin write exhibitions" on public.exhibitions for all using (public.is_admin()) with check (public.is_admin());

create policy "anyone can send inquiry" on public.inquiries for insert with check (true);
create policy "admin manage inquiries" on public.inquiries for all using (public.is_admin()) with check (public.is_admin());

create policy "anyone can subscribe" on public.subscribers for insert with check (true);
create policy "admin manage subscribers" on public.subscribers for all using (public.is_admin()) with check (public.is_admin());

create policy "admin manage collections" on public.client_collections for all using (public.is_admin()) with check (public.is_admin());

-- Image storage (public read, admin upload)
insert into storage.buckets (id, name, public) values ('artworks','artworks', true)
  on conflict (id) do nothing;
create policy "admin upload artworks" on storage.objects for insert to authenticated
  with check (bucket_id = 'artworks' and public.is_admin());
create policy "admin update artworks" on storage.objects for update to authenticated
  using (bucket_id = 'artworks' and public.is_admin());
create policy "admin delete artworks" on storage.objects for delete to authenticated
  using (bucket_id = 'artworks' and public.is_admin());

-- Starting chapters
insert into public.series (slug, title_en, title_bn, chapter, sort) values
 ('roots','Roots / Early Years','শিকড় / প্রথম দিন','Roots',1),
 ('evolving-lines','Evolving Lines','বিবর্তিত রেখা','Evolving Lines',2),
 ('media-life','Media Life','মিডিয়া জীবন','Media Life',3),
 ('lines-of-life','Lines of Life','জীবনের রেখা','Lines of Life',4);
