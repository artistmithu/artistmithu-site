-- Sketchbooks: whole books shown page by page (/sketchbooks/<slug>/). Pages are not for sale on their own.
create table if not exists public.sketchbooks (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  title_en text not null,
  title_bn text,
  period text,                 -- free text, e.g. "2002–2004"
  description_en text,
  description_bn text,
  sort int not null default 0,
  published boolean not null default true,
  created_at timestamptz not null default now()
);
create table if not exists public.sketchbook_pages (
  id uuid primary key default gen_random_uuid(),
  sketchbook_id uuid not null references public.sketchbooks(id) on delete cascade,
  path text not null,          -- storage path in the artworks bucket
  page_no int not null default 0,
  caption_en text,
  caption_bn text,
  hidden boolean not null default false,
  created_at timestamptz not null default now()
);
create index if not exists sketchbook_pages_book on public.sketchbook_pages (sketchbook_id, page_no);
alter table public.sketchbooks enable row level security;
alter table public.sketchbook_pages enable row level security;
do $$ begin
  if not exists (select 1 from pg_policies where tablename = 'sketchbooks' and policyname = 'public read sketchbooks') then
    create policy "public read sketchbooks" on public.sketchbooks for select using (published or public.is_admin());
    create policy "admin write sketchbooks" on public.sketchbooks for all using (public.is_admin()) with check (public.is_admin());
    create policy "public read sketchbook pages" on public.sketchbook_pages for select using (
      (not hidden and exists (select 1 from public.sketchbooks b where b.id = sketchbook_id and b.published)) or public.is_admin());
    create policy "admin write sketchbook pages" on public.sketchbook_pages for all using (public.is_admin()) with check (public.is_admin());
  end if;
end $$;
