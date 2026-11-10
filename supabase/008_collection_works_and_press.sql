-- 008: works by other artists from the collection, shown only in private client / bidding links.
-- artist_name null = Tanvirul Islam Mithu. A work with an artist name can never be published,
-- and the public view leaves it out as well.
alter table public.artworks add column if not exists artist_name text;
do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'other_artist_never_public') then
    alter table public.artworks add constraint other_artist_never_public check (artist_name is null or not published);
  end if;
end $$;

create or replace view public.artworks_public with (security_invoker = true) as
  select id, inv_no, slug, title_en, title_bn, series_id, year, medium, support,
         height_cm, width_cm, depth_cm, size_class, framed, status, edition,
         description_en, description_bn, featured, sort,
         case when price_mode <> 'on_request' or show_price then price_bdt end as price_bdt,
         case when price_mode <> 'on_request' or show_price then price_usd end as price_usd,
         case when price_mode <> 'on_request' or show_price then price_mode else 'on_request' end as price_mode,
         case when price_mode = 'range' then price_bdt_max end as price_bdt_max,
         case when price_mode = 'range' then price_usd_max end as price_usd_max,
         kind
  from public.artworks where published and artist_name is null;
grant select on public.artworks_public to anon, authenticated;

create or replace function public.get_collection(p_token text)
returns json language sql stable security definer set search_path = public as $$
  select json_build_object(
    'client_name', c.client_name, 'note', c.note, 'mode', c.mode,
    'intro_en', c.intro_en, 'intro_bn', c.intro_bn, 'currency', c.bid_currency,
    'closes_at', c.expires_at, 'show_top_bid', c.show_top_bid,
    'artworks', coalesce((select json_agg(json_build_object(
        'id', a.id, 'inv_no', a.inv_no, 'artist_name', a.artist_name, 'description_en', case when a.artist_name is not null then a.description_en end, 'slug', a.slug, 'title_en', a.title_en, 'title_bn', a.title_bn,
        'year', a.year, 'medium', a.medium, 'support', a.support, 'published', a.published,
        'height_cm', a.height_cm, 'width_cm', a.width_cm, 'status', a.status,
        'price_mode', case when c.show_prices then a.price_mode else 'on_request' end,
        'price_bdt', case when c.show_prices then a.price_bdt end,
        'price_usd', case when c.show_prices then a.price_usd end,
        'price_bdt_max', case when c.show_prices then a.price_bdt_max end,
        'price_usd_max', case when c.show_prices then a.price_usd_max end,
        'start_bid', case when c.mode = 'bidding' then bid_start(c, a) end,
        'top_bid', case when c.mode = 'bidding' and c.show_top_bid then (select max(b.amount) from bids b where b.collection_id = c.id and b.artwork_id = a.id) end,
        'bid_count', case when c.mode = 'bidding' then (select count(*) from bids b where b.collection_id = c.id and b.artwork_id = a.id) end,
        'images', (select json_agg(i.path order by i.sort) from artwork_images i where i.artwork_id = a.id)
      ) order by array_position(c.artwork_ids, a.id))
      from artworks a where a.id = any(c.artwork_ids)), '[]'::json))
  from client_collections c
  where c.token = p_token and (c.expires_at is null or c.expires_at > now())
$$;
grant execute on function public.get_collection(text) to anon, authenticated;

-- 009 (applied): press clippings and sponsor on shows.
alter table public.exhibitions add column if not exists press jsonb not null default '[]'::jsonb, add column if not exists sponsor_en text, add column if not exists sponsor_bn text;
-- Data (applied): home hero = Self Portrait TIM-1997-1481 (removed from Evolving Lines); wall photo unset; Media Life hidden as an empty chapter.
-- Data (applied): Experiments, 1996–97 chapter (series 'experiments', sort 2) with TIM-EXP-001..014 under experiments/.

-- 010 (applied): where a work is held.
alter table public.artworks add column if not exists collection_en text, add column if not exists collection_bn text;
-- artworks_public re-created with collection_en, collection_bn appended (same where clause as above).
-- Data: Station -2 and Untitled -> Bangladesh National Museum; Landscape and new My Room-1 -> Ekushey Television;
-- new Drawing 6 (catalogue image) opens the first solo show page; catalogue cover added to its press list.
-- Helper edge function "thumbs" (token-guarded) was deployed to compare images; remove with the import token.
-- Data (applied): first solo show works TIM-2001-FS-003..009 added from Vaab's photos (no duplicates found by fingerprint)
