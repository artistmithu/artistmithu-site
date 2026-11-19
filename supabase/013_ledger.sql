-- 013: হিসাব (personal accounts) for the studio panel. Only admins can read or write it; nothing here is ever shown on the public site.
create table if not exists public.ledger (
  id uuid primary key default gen_random_uuid(),
  entry_date date not null default (now() at time zone 'Asia/Dhaka')::date,
  -- expense = খরচ, income = আয়, receivable = পাওনা (someone owes me), payable = দেনা (I owe someone)
  kind text not null check (kind in ('expense', 'income', 'receivable', 'payable')),
  category text,
  party text,            -- কার কাছে / কাকে / কোথায়
  amount numeric(14, 2) not null check (amount > 0),
  method text,           -- নগদ, বিকাশ, নগদ (Nagad), ব্যাংক ...
  note text,
  due_date date,         -- for পাওনা / দেনা
  settled boolean not null default false,
  settled_on date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists ledger_date_idx on public.ledger (entry_date desc);
create index if not exists ledger_open_idx on public.ledger (kind) where not settled;

alter table public.ledger enable row level security;
drop policy if exists "admin manage ledger" on public.ledger;
create policy "admin manage ledger" on public.ledger for all using (public.is_admin()) with check (public.is_admin());
