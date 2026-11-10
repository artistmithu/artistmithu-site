-- 004: editable About/CV content, studio photos and a journal (blog). No drop statements.

-- Text blocks for the About / CV page, edited in admin. Keys: statement, bio, education, awards, collections, cv_pdf, portrait.
create table if not exists public.site_content (
  key text primary key,
  en text,
  bn text,
  updated_at timestamptz not null default now()
);
alter table public.site_content enable row level security;

create table if not exists public.studio_photos (
  id uuid primary key default gen_random_uuid(),
  path text not null,
  caption_en text,
  caption_bn text,
  sort int not null default 0,
  created_at timestamptz not null default now()
);
alter table public.studio_photos enable row level security;

create table if not exists public.posts (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  title_en text not null,
  title_bn text,
  body_en text,
  body_bn text,
  cover_path text,
  images text[] not null default '{}',
  youtube_url text,
  published boolean not null default false,
  published_at date not null default current_date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.posts enable row level security;

do $$ begin
  if not exists (select 1 from pg_policies where tablename = 'site_content' and policyname = 'public read site content') then
    create policy "public read site content" on public.site_content for select using (true);
    create policy "admin write site content" on public.site_content for all using (public.is_admin()) with check (public.is_admin());
  end if;
  if not exists (select 1 from pg_policies where tablename = 'studio_photos' and policyname = 'public read studio photos') then
    create policy "public read studio photos" on public.studio_photos for select using (true);
    create policy "admin write studio photos" on public.studio_photos for all using (public.is_admin()) with check (public.is_admin());
  end if;
  if not exists (select 1 from pg_policies where tablename = 'posts' and policyname = 'public read posts') then
    create policy "public read posts" on public.posts for select using (published or public.is_admin());
    create policy "admin write posts" on public.posts for all using (public.is_admin()) with check (public.is_admin());
  end if;
end $$;

-- Start the About page from the text already on the site, so nothing disappears before the artist edits it.
insert into public.site_content (key, en, bn) values
 ('bio', 'Tanvirul Islam Mithu began drawing as a child, copying illustrations from books. In 1991 he met S.M. Sultan in Narail, who gave him a signed pencil sketch. He studied Drawing and Painting at the University of Dhaka from 1992 and graduated in 2001, the year of his first solo exhibition.

Around 2000 he moved into graphic design and media. In 2013 he took part in the USA Media Fellowship, and on 16 December 2013 he opened Transparent Boundary, Bangladesh''s first solo web show. He launched Lines of Life in 2017 and has since held seven web shows.', null),
 ('education', 'MFA, Drawing and Painting, Faculty of Fine Arts, University of Dhaka', 'এমএফএ, ড্রইং ও পেইন্টিং, চারুকলা অনুষদ, ঢাকা বিশ্ববিদ্যালয়')
on conflict (key) do nothing;
