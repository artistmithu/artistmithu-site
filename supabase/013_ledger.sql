-- 013: হিসাব (personal accounts) for the studio panel: daily/monthly income and spending, পাওনা/দেনা, and per-project costs
-- (e.g. যশোরের খরচ, বাড়ি বানানো). Only admins can read or write it; nothing here is ever shown on the public site.

create table if not exists public.ledger_projects (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  budget numeric(14, 2),          -- optional: how much I plan to spend
  note text,
  start_date date,
  done boolean not null default false,
  sort int not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.ledger (
  id uuid primary key default gen_random_uuid(),
  entry_date date not null default (now() at time zone 'Asia/Dhaka')::date,
  -- expense = খরচ, income = আয়, receivable = পাওনা (someone owes me), payable = দেনা (I owe someone)
  kind text not null check (kind in ('expense', 'income', 'receivable', 'payable')),
  category text,
  party text,            -- কার কাছে / কাকে / কোথায়
  amount numeric(14, 2) not null check (amount > 0),
  method text,           -- নগদ, বিকাশ, Nagad, ব্যাংক ...
  note text,
  project_id uuid references public.ledger_projects (id) on delete set null,
  due_date date,         -- for পাওনা / দেনা
  settled boolean not null default false,
  settled_on date,
  source text,           -- where an imported row came from, e.g. 'amar-din'
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists ledger_date_idx on public.ledger (entry_date desc);
create index if not exists ledger_project_idx on public.ledger (project_id);
create index if not exists ledger_open_idx on public.ledger (kind) where not settled;

alter table public.ledger enable row level security;
alter table public.ledger_projects enable row level security;
drop policy if exists "admin manage ledger" on public.ledger;
create policy "admin manage ledger" on public.ledger for all using (public.is_admin()) with check (public.is_admin());
drop policy if exists "admin manage ledger projects" on public.ledger_projects;
create policy "admin manage ledger projects" on public.ledger_projects for all using (public.is_admin()) with check (public.is_admin());
