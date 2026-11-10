-- Works by other artists: a short note about the artist, shown on private client links.
alter table public.artworks add column if not exists artist_note text;

create or replace function public.get_collection(p_token text)
returns json language sql stable security definer set search_path = public as $$
  select json_build_object(
    'client_name', c.client_name, 'note', c.note, 'mode', c.mode,
    'intro_en', c.intro_en, 'intro_bn', c.intro_bn, 'currency', c.bid_currency,
    'closes_at', c.expires_at, 'show_top_bid', c.show_top_bid,
    'artworks', coalesce((select json_agg(json_build_object(
        'id', a.id, 'inv_no', a.inv_no, 'artist_name', a.artist_name, 'artist_note', case when a.artist_name is not null then a.artist_note end, 'description_en', case when a.artist_name is not null then a.description_en end, 'slug', a.slug, 'title_en', a.title_en, 'title_bn', a.title_bn,
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
  where c.token = p_token and c.active and (c.expires_at is null or c.expires_at > now())
$$;
grant execute on function public.get_collection(text) to anon, authenticated;
-- Data (applied): COL-MWAMVVL9 artist name split into name + artist_note; title bracket fixed.
-- Data (applied): Roots corrections from Vaab: Branch in a pot first (first class work), Bottles second, ROOTS-020 retitled New Market chicken bazaar, pencil media for 004/010-013.
