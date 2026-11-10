-- 007: chapter photos. A studio photo with a series_id shows on that chapter's page instead of the About page.
alter table public.studio_photos add column if not exists series_id uuid references public.series(id) on delete set null;
-- Data (applied via SQL): 32 early works TIM-ROOTS-001..032 in series 'roots' with images under roots/,
-- S. M. Sultan / Narail 1991 photos moved to the Roots chapter, series renamed "Roots & Early Years" with a description.
