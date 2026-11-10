-- 005: photo gallery for a show (opening, installation views, the artist with the works).
alter table public.exhibitions add column if not exists images text[] not null default '{}';
