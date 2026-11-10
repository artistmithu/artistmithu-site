-- Client links can be switched off (and back on) without deleting them or their bids.
alter table public.client_collections add column if not exists active boolean not null default true;
alter table public.client_collections add column if not exists updated_at timestamptz;

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
  where c.token = p_token and c.active and (c.expires_at is null or c.expires_at > now())
$$;
grant execute on function public.get_collection(text) to anon, authenticated;

create or replace function public.place_bid(p_token text, p_artwork_id uuid, p_name text, p_contact text, p_amount numeric, p_note text default null)
returns json language plpgsql security definer set search_path = public as $$
declare c client_collections; a artworks; top numeric; start numeric;
begin
  select * into c from client_collections
    where token = p_token and active and mode = 'bidding' and (expires_at is null or expires_at > now());
  if not found then return json_build_object('ok', false, 'error', 'closed'); end if;
  if not (p_artwork_id = any(c.artwork_ids)) then return json_build_object('ok', false, 'error', 'not_in_room'); end if;
  select * into a from artworks where id = p_artwork_id;
  if a.status in ('sold','nfs') then return json_build_object('ok', false, 'error', 'unavailable'); end if;
  if coalesce(trim(p_name), '') = '' or length(trim(coalesce(p_contact, ''))) < 3 then return json_build_object('ok', false, 'error', 'details'); end if;
  start := bid_start(c, a);
  select max(amount) into top from bids where collection_id = c.id and artwork_id = a.id;
  if p_amount is null or p_amount <= 0 or (start is not null and p_amount < start) then
    return json_build_object('ok', false, 'error', 'too_low', 'min', start);
  end if;
  if c.show_top_bid and top is not null and p_amount <= top then
    return json_build_object('ok', false, 'error', 'too_low', 'min', top + 1, 'top', top);
  end if;
  insert into bids (collection_id, artwork_id, bidder_name, contact, amount, currency, note)
    values (c.id, a.id, left(trim(p_name), 120), left(trim(p_contact), 160), round(p_amount), c.bid_currency, nullif(left(trim(coalesce(p_note, '')), 1000), ''));
  return json_build_object('ok', true, 'top', case when c.show_top_bid then greatest(coalesce(top, 0), round(p_amount)) end);
end $$;
grant execute on function public.place_bid(text, uuid, text, text, numeric, text) to anon, authenticated;
