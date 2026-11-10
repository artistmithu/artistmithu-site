-- 003: work type (drawing / painting ...) and private bidding rooms.
-- Written without drop statements so it runs without a confirmation prompt.

-- Work type ------------------------------------------------------------------
alter table public.artworks
  add column if not exists kind text check (kind in ('drawing','painting','print','mixed','other'));

update public.artworks set kind = case
    when medium ~* 'mixed' then 'mixed'
    when medium ~* 'print|etching|woodcut|litho|screen' then 'print'
    when medium ~* 'acrylic|oil|watercolou?r|gouache|tempera' then 'painting'
    when medium ~* 'pen|ink|charcoal|pencil|pastel|drawing|conte|marker' then 'drawing'
  end
  where kind is null and medium is not null;

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
  from public.artworks where published;
grant select on public.artworks_public to anon, authenticated;

-- Bidding rooms ----------------------------------------------------------------
-- A client link is either a viewing room ('view') or a private bidding room ('bidding').
alter table public.client_collections
  add column if not exists mode text not null default 'view' check (mode in ('view','bidding')),
  add column if not exists intro_en text,
  add column if not exists intro_bn text,
  add column if not exists bid_currency text not null default 'BDT' check (bid_currency in ('BDT','USD')),
  add column if not exists show_top_bid boolean not null default true;

create table if not exists public.bids (
  id uuid primary key default gen_random_uuid(),
  collection_id uuid not null references public.client_collections(id) on delete cascade,
  artwork_id uuid not null references public.artworks(id) on delete cascade,
  bidder_name text not null check (length(bidder_name) between 1 and 120),
  contact text not null check (length(contact) between 3 and 160),
  amount numeric(14,0) not null check (amount > 0),
  currency text not null check (currency in ('BDT','USD')),
  note text check (note is null or length(note) <= 1000),
  created_at timestamptz not null default now()
);
create index if not exists bids_room_work on public.bids (collection_id, artwork_id, amount desc);
alter table public.bids enable row level security;
do $$ begin
  if not exists (select 1 from pg_policies where tablename = 'bids' and policyname = 'admin manage bids') then
    create policy "admin manage bids" on public.bids for all using (public.is_admin()) with check (public.is_admin());
  end if;
end $$;

-- Starting bid for a work in a room: the work's price in the room's currency, if the room shows prices.
create or replace function public.bid_start(c public.client_collections, a public.artworks)
returns numeric language sql stable as $$
  select case when c.show_prices then (case when c.bid_currency = 'USD' then a.price_usd else a.price_bdt end) end
$$;

-- Visitors place bids only through this function: it checks the link, the work and the amount.
create or replace function public.place_bid(p_token text, p_artwork_id uuid, p_name text, p_contact text, p_amount numeric, p_note text default null)
returns json language plpgsql security definer set search_path = public as $$
declare c client_collections; a artworks; top numeric; start numeric;
begin
  select * into c from client_collections
    where token = p_token and mode = 'bidding' and (expires_at is null or expires_at > now());
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

-- Client links: add room mode, intro and (for bidding rooms) the current top bid per work.
create or replace function public.get_collection(p_token text)
returns json language sql stable security definer set search_path = public as $$
  select json_build_object(
    'client_name', c.client_name, 'note', c.note, 'mode', c.mode,
    'intro_en', c.intro_en, 'intro_bn', c.intro_bn, 'currency', c.bid_currency,
    'closes_at', c.expires_at, 'show_top_bid', c.show_top_bid,
    'artworks', coalesce((select json_agg(json_build_object(
        'id', a.id, 'inv_no', a.inv_no, 'slug', a.slug, 'title_en', a.title_en, 'title_bn', a.title_bn,
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

-- Works imported without a medium: type taken from the archive's gallery name.
update public.artworks set kind = 'drawing' where kind is null and inv_no in ('TIM-2013-TB-038','TIM-2013-TB-039','TIM-2013-TB-040','TIM-2013-TB-041','TIM-2013-TB-042','TIM-2013-TB-043','TIM-2013-TB-044','TIM-2013-TB-045','TIM-2013-TB-046','TIM-2013-TB-047','TIM-2013-TB-048','TIM-2013-TB-049','TIM-2013-TB-050','TIM-2013-TB-051','TIM-2013-TB-052','TIM-2013-TB-053','TIM-2013-TB-054','TIM-2013-ECL-001','TIM-2013-ECL-002','TIM-2013-ECL-003','TIM-2013-ECL-004','TIM-2013-ECL-005','TIM-2013-ECL-006','TIM-2013-ECL-007','TIM-2013-ECL-008','TIM-2013-ECL-009','TIM-2013-ECL-010','TIM-2013-ECL-011','TIM-2013-ECL-012','TIM-2013-ECL-013','TIM-2013-ECL-014','TIM-2013-ECL-015','TIM-2013-ECL-016','TIM-2013-ECL-017','TIM-2013-ECL-018','TIM-2013-ECL-019','TIM-2013-ECL-020','TIM-2013-ECL-021','TIM-2013-ECL-022','TIM-2013-ECL-023','TIM-2013-ECL-024','TIM-2013-ECL-025','TIM-2013-ECL-026','TIM-2013-ECL-027','TIM-2013-ECL-028','TIM-2013-ECL-029','TIM-2013-ECL-030','TIM-2013-ECL-031','TIM-2013-ECL-032','TIM-2013-ECL-033','TIM-2013-ECL-034','TIM-2013-ECL-035','TIM-2013-ECL-036','TIM-2013-ECL-037','TIM-2013-ECL-038','TIM-2013-ECL-039','TIM-2013-ECL-040','TIM-2013-ECL-041','TIM-2013-ECL-042');
update public.artworks set kind = 'painting' where kind is null and inv_no in ('TIM-2013-TB-017','TIM-2013-TB-018','TIM-2013-TB-019','TIM-2013-TB-020','TIM-2013-TB-021','TIM-2013-TB-022','TIM-2013-TB-023','TIM-2013-TB-024','TIM-2013-TB-025','TIM-2013-TB-026','TIM-2013-TB-027','TIM-2013-TB-028','TIM-2013-TB-029','TIM-2013-TB-030','TIM-2013-TB-031','TIM-2013-TB-032','TIM-2013-TB-033','TIM-2013-TB-034','TIM-2013-TB-035','TIM-2013-TB-036','TIM-2013-TB-037');
