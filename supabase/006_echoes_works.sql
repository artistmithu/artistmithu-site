-- 2025-11: Lines of Life 005 linked to Echoes of Time (applied via SQL)
insert into public.exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from public.exhibitions e, public.artworks a where e.slug='echoes-of-time-2025' and a.inv_no='TIM-2025-LLS-005' on conflict do nothing;
