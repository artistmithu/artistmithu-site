insert into series (slug, title_en, title_bn, chapter, sort) values ('transparent-boundary', 'Transparent Boundary', 'স্বচ্ছ সীমানা', 'Transparent Boundary', 5) on conflict (slug) do nothing;
insert into series (slug, title_en, title_bn, chapter, sort) values ('expression-of-color-and-line', 'Expression of Color and Line', 'রঙ ও রেখার অভিব্যক্তি', 'Expression of Color and Line', 6) on conflict (slug) do nothing;
insert into series (slug, title_en, title_bn, chapter, sort) values ('ramadan-lines', 'Ramadan Lines', 'রমজানের রেখা', 'Ramadan Lines', 7) on conflict (slug) do nothing;
insert into series (slug, title_en, title_bn, chapter, sort) values ('lines-of-image', 'Lines of Image', 'লাইনস অফ ইমেজ', 'Lines of Image', 8) on conflict (slug) do nothing;
insert into series (slug, title_en, title_bn, chapter, sort) values ('lines-of-color', 'Lines of Color', 'রঙের রেখা', 'Lines of Color', 9) on conflict (slug) do nothing;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('transparent-boundary-2013', 'Transparent Boundary', 'স্বচ্ছ সীমানা', 'web-show', '2013-12-16', null, 'Online (linesof.life)', null, null, 'The competitive urban life often leaves us as prisoners, albeit unwittingly, of sustenance and we are becoming rather fond of these transparent prison cells. Though a few of us might revolt against such self-imposed invisible chains, most, it seems, prefer imprisonment over a rebellion, mostly because we are scared of the vastness of the world outside these self-erected lucid walls. It feels as if for each of us, the universe itself has shrunk into a transparent bottle, made of glass, like the ones I have drawn in the series of paintings, being exhibited here.
It all started with a sudden epiphany while I was line drawing on my canvas one day. Line drawing, being my favorite past times, has a great effect on me as it tends to stir unusual but vital thoughts in me; just like the one of us being the prisoners of our sustenance. I became concerned about self-restraining ourselves in a tiny space upon this vast and spacious world. This in turn, inspired me to start working on the before mentioned theme. Initially I came up with the drawings and then started to work on the paintings.
The human beings, trapped inside the drawn bottles, represent the very society that we live in. Some of them have one of their eyes closed while the other one left wide open, then a few of those eyes have irises, to signify that they have dreams too. There are a few rebels as well who try to break free from the invisible chains and some of them have even succeeded, partially. Especially when those trapped inside the bottles see the vastness of world outside and feel that it is waiting for them with all its colors and panorama, some of them become rebellious. They become restless for freedom, to embrace the omniscient nature and be enlightened thoroughly. This is what we all must do, for only love of nature can set us free from these transparent prison cells.', null, null, 'webshows/transparent-boundary-2013/lol1600x941.jpg', 'https://linesof.life/transparent-boundary/', 'https://linesof.life/transparent-boundary/', null, 'First web art show in Bangladesh (as stated on the original page)', true, 0)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-001', 'transparent-boundary-drawing-001', 'Transparent Boundary Drawing 001', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 0, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-1.jpeg', 0, 'Transparent Boundary Drawing 001' from artworks where inv_no = 'TIM-2013-TB-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 0 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-001' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-001', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-002', 'transparent-boundary-drawing-002', 'Transparent Boundary Drawing 002', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 1, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-2.jpeg', 0, 'Transparent Boundary Drawing 002' from artworks where inv_no = 'TIM-2013-TB-002' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-002' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-002', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-003', 'transparent-boundary-drawing-003', 'Transparent Boundary Drawing 003', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 2, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-3.jpeg', 0, 'Transparent Boundary Drawing 003' from artworks where inv_no = 'TIM-2013-TB-003' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 2 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-003' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-003', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-004', 'transparent-boundary-drawing-004', 'Transparent Boundary Drawing 004', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 3, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-4.jpeg', 0, 'Transparent Boundary Drawing 004' from artworks where inv_no = 'TIM-2013-TB-004' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 3 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-004' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-004', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-005', 'transparent-boundary-drawing-005', 'Transparent Boundary Drawing 005', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 4, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-5.jpeg', 0, 'Transparent Boundary Drawing 005' from artworks where inv_no = 'TIM-2013-TB-005' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 4 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-005' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-005', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-006', 'transparent-boundary-drawing-006', 'Transparent Boundary Drawing 006', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 5, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-6.jpeg', 0, 'Transparent Boundary Drawing 006' from artworks where inv_no = 'TIM-2013-TB-006' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 5 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-006' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-006', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-007', 'transparent-boundary-drawing-007', 'Transparent Boundary Drawing 007', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 6, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-7.jpeg', 0, 'Transparent Boundary Drawing 007' from artworks where inv_no = 'TIM-2013-TB-007' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 6 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-007' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-007', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-008', 'transparent-boundary-drawing-008', 'Transparent Boundary Drawing 008', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 7, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-8.jpeg', 0, 'Transparent Boundary Drawing 008' from artworks where inv_no = 'TIM-2013-TB-008' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 7 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-008' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-008', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-009', 'transparent-boundary-drawing-009', 'Transparent Boundary Drawing 009', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 8, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-9.jpeg', 0, 'Transparent Boundary Drawing 009' from artworks where inv_no = 'TIM-2013-TB-009' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 8 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-009' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-009', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-010', 'transparent-boundary-drawing-010', 'Transparent Boundary Drawing 010', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 9, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-10.jpeg', 0, 'Transparent Boundary Drawing 010' from artworks where inv_no = 'TIM-2013-TB-010' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 9 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-010' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-010', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-011', 'transparent-boundary-drawing-011', 'Transparent Boundary Drawing 011', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 10, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-11.jpeg', 0, 'Transparent Boundary Drawing 011' from artworks where inv_no = 'TIM-2013-TB-011' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 10 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-011' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-011', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-012', 'transparent-boundary-drawing-012', 'Transparent Boundary Drawing 012', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 11, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-12.jpeg', 0, 'Transparent Boundary Drawing 012' from artworks where inv_no = 'TIM-2013-TB-012' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 11 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-012' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-012', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-013', 'transparent-boundary-drawing-013', 'Transparent Boundary Drawing 013', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 12, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-13.jpeg', 0, 'Transparent Boundary Drawing 013' from artworks where inv_no = 'TIM-2013-TB-013' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 12 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-013' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-013', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-014', 'transparent-boundary-drawing-014', 'Transparent Boundary Drawing 014', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 13, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-14.jpeg', 0, 'Transparent Boundary Drawing 014' from artworks where inv_no = 'TIM-2013-TB-014' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 13 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-014' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-014', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-015', 'transparent-boundary-drawing-015', 'Transparent Boundary Drawing 015', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 14, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-15.jpeg', 0, 'Transparent Boundary Drawing 015' from artworks where inv_no = 'TIM-2013-TB-015' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 14 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-015' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-015', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-016', 'transparent-boundary-drawing-016', 'Transparent Boundary Drawing 016', null, (select id from series where slug = 'transparent-boundary'), 2013, 'Pen on paper', 30.5, 25.4, 'available', true, 15, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_D-16.jpeg', 0, 'Transparent Boundary Drawing 016' from artworks where inv_no = 'TIM-2013-TB-016' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 15 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-016' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-016', 'Size given on the page as "12 x 10" with no unit; inches assumed, confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-017', 'transparent-boundary-n-05', 'Transparent Boundary N-05', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 16, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-05.jpg', 0, 'Transparent Boundary N-05' from artworks where inv_no = 'TIM-2013-TB-017' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 16 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-017' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-017', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-018', 'transparent-boundary-transparent-boundary-p-9', 'Transparent Boundary Transparent-Boundary_p-9', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 17, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_p-9.jpeg', 0, 'Transparent Boundary Transparent-Boundary_p-9' from artworks where inv_no = 'TIM-2013-TB-018' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 17 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-018' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-018', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-019', 'transparent-boundary-transparent-boundary-p-10', 'Transparent Boundary Transparent-Boundary_p-10', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 18, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_p-10.jpeg', 0, 'Transparent Boundary Transparent-Boundary_p-10' from artworks where inv_no = 'TIM-2013-TB-019' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 18 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-019' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-019', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-020', 'transparent-boundary-transparent-boundary-p-4', 'Transparent Boundary Transparent-Boundary_p-4', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 19, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_p-4.jpeg', 0, 'Transparent Boundary Transparent-Boundary_p-4' from artworks where inv_no = 'TIM-2013-TB-020' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 19 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-020' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-020', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-021', 'transparent-boundary-transparent-boundary-p-25', 'Transparent Boundary Transparent-Boundary_p-25', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 20, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Transparent-Boundary_p-25.jpeg', 0, 'Transparent Boundary Transparent-Boundary_p-25' from artworks where inv_no = 'TIM-2013-TB-021' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 20 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-021' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-021', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-022', 'transparent-boundary-n-07', 'Transparent Boundary N-07', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 21, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-07.jpg', 0, 'Transparent Boundary N-07' from artworks where inv_no = 'TIM-2013-TB-022' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 21 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-022' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-022', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-023', 'transparent-boundary-n-02', 'Transparent Boundary N-02', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 22, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-02.jpg', 0, 'Transparent Boundary N-02' from artworks where inv_no = 'TIM-2013-TB-023' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 22 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-023' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-023', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-024', 'transparent-boundary-n-014', 'Transparent Boundary N-014', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 23, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-014.jpg', 0, 'Transparent Boundary N-014' from artworks where inv_no = 'TIM-2013-TB-024' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 23 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-024' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-024', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-025', 'transparent-boundary-n-06', 'Transparent Boundary N-06', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 24, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-06.jpg', 0, 'Transparent Boundary N-06' from artworks where inv_no = 'TIM-2013-TB-025' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 24 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-025' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-025', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-026', 'transparent-boundary-n-08', 'Transparent Boundary N-08', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 25, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-08.jpg', 0, 'Transparent Boundary N-08' from artworks where inv_no = 'TIM-2013-TB-026' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 25 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-026' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-026', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-027', 'transparent-boundary-n-09', 'Transparent Boundary N-09', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 26, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-09.jpg', 0, 'Transparent Boundary N-09' from artworks where inv_no = 'TIM-2013-TB-027' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 26 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-027' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-027', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-028', 'transparent-boundary-n-013', 'Transparent Boundary N-013', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 27, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-013.jpg', 0, 'Transparent Boundary N-013' from artworks where inv_no = 'TIM-2013-TB-028' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 27 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-028' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-028', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-029', 'transparent-boundary-n-012', 'Transparent Boundary N-012', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 28, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-012.jpg', 0, 'Transparent Boundary N-012' from artworks where inv_no = 'TIM-2013-TB-029' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 28 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-029' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-029', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-030', 'transparent-boundary-n-011', 'Transparent Boundary N-011', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 29, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-011.jpg', 0, 'Transparent Boundary N-011' from artworks where inv_no = 'TIM-2013-TB-030' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 29 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-030' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-030', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-031', 'transparent-boundary-n-010', 'Transparent Boundary N-010', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 30, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-010.jpg', 0, 'Transparent Boundary N-010' from artworks where inv_no = 'TIM-2013-TB-031' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 30 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-031' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-031', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-032', 'transparent-boundary-16', 'Transparent Boundary 16', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 31, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/16.jpg', 0, 'Transparent Boundary 16' from artworks where inv_no = 'TIM-2013-TB-032' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 31 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-032' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-032', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-033', 'transparent-boundary-14', 'Transparent Boundary 14', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 32, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/14.jpg', 0, 'Transparent Boundary 14' from artworks where inv_no = 'TIM-2013-TB-033' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 32 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-033' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-033', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-034', 'transparent-boundary-13', 'Transparent Boundary 13', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 33, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/13.jpg', 0, 'Transparent Boundary 13' from artworks where inv_no = 'TIM-2013-TB-034' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 33 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-034' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-034', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-035', 'transparent-boundary-12', 'Transparent Boundary 12', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 34, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/12.jpg', 0, 'Transparent Boundary 12' from artworks where inv_no = 'TIM-2013-TB-035' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 34 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-035' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-035', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-036', 'transparent-boundary-11', 'Transparent Boundary 11', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 35, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/11.jpg', 0, 'Transparent Boundary 11' from artworks where inv_no = 'TIM-2013-TB-036' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 35 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-036' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-036', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-037', 'transparent-boundary-n-03', 'Transparent Boundary N-03', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 36, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/N-03.jpg', 0, 'Transparent Boundary N-03' from artworks where inv_no = 'TIM-2013-TB-037' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 36 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-037' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-037', 'Title, medium and size not on the page; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-038', 'transparent-boundary-drawing-101', 'Transparent Boundary Drawing-101', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 37, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-101.jpg', 0, 'Transparent Boundary Drawing-101' from artworks where inv_no = 'TIM-2013-TB-038' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 37 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-038' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-038', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-039', 'transparent-boundary-drawing-8', 'Transparent Boundary Drawing-8', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 38, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-8.jpg', 0, 'Transparent Boundary Drawing-8' from artworks where inv_no = 'TIM-2013-TB-039' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 38 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-039' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-039', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-040', 'transparent-boundary-drawing-4', 'Transparent Boundary Drawing-4', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 39, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-4.jpg', 0, 'Transparent Boundary Drawing-4' from artworks where inv_no = 'TIM-2013-TB-040' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 39 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-040' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-040', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-041', 'transparent-boundary-drawing-1', 'Transparent Boundary Drawing-1', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 40, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-1.jpg', 0, 'Transparent Boundary Drawing-1' from artworks where inv_no = 'TIM-2013-TB-041' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 40 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-041' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-041', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-042', 'transparent-boundary-drawing-5', 'Transparent Boundary Drawing-5', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 41, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-5.jpg', 0, 'Transparent Boundary Drawing-5' from artworks where inv_no = 'TIM-2013-TB-042' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 41 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-042' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-042', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-043', 'transparent-boundary-drawing-9', 'Transparent Boundary Drawing-9', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 42, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-9.jpg', 0, 'Transparent Boundary Drawing-9' from artworks where inv_no = 'TIM-2013-TB-043' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 42 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-043' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-043', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-044', 'transparent-boundary-drawing-10', 'Transparent Boundary Drawing-10', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 43, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-10-2.jpg', 0, 'Transparent Boundary Drawing-10' from artworks where inv_no = 'TIM-2013-TB-044' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 43 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-044' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-044', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-045', 'transparent-boundary-drawing-7', 'Transparent Boundary Drawing-7', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 44, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-7.jpg', 0, 'Transparent Boundary Drawing-7' from artworks where inv_no = 'TIM-2013-TB-045' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 44 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-045' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-045', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-046', 'transparent-boundary-drawing-6', 'Transparent Boundary Drawing-6', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 45, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-6.jpg', 0, 'Transparent Boundary Drawing-6' from artworks where inv_no = 'TIM-2013-TB-046' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 45 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-046' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-046', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-047', 'transparent-boundary-drawing-16', 'Transparent Boundary Drawing-16', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 46, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-16-2.jpg', 0, 'Transparent Boundary Drawing-16' from artworks where inv_no = 'TIM-2013-TB-047' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 46 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-047' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-047', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-048', 'transparent-boundary-drawing-17', 'Transparent Boundary Drawing-17', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 47, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-17-2.jpg', 0, 'Transparent Boundary Drawing-17' from artworks where inv_no = 'TIM-2013-TB-048' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 47 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-048' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-048', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-049', 'transparent-boundary-drawing0', 'Transparent Boundary Drawing0', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 48, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-20-2.jpg', 0, 'Transparent Boundary Drawing0' from artworks where inv_no = 'TIM-2013-TB-049' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 48 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-049' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-049', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-050', 'transparent-boundary-drawing-19', 'Transparent Boundary Drawing-19', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 49, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-19-2.jpg', 0, 'Transparent Boundary Drawing-19' from artworks where inv_no = 'TIM-2013-TB-050' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 49 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-050' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-050', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-051', 'transparent-boundary-drawing-18', 'Transparent Boundary Drawing-18', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 50, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-18-2.jpg', 0, 'Transparent Boundary Drawing-18' from artworks where inv_no = 'TIM-2013-TB-051' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 50 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-051' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-051', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-052', 'transparent-boundary-drawing1', 'Transparent Boundary Drawing1', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 51, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-21-2.jpg', 0, 'Transparent Boundary Drawing1' from artworks where inv_no = 'TIM-2013-TB-052' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 51 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-052' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-052', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-053', 'transparent-boundary-drawing2', 'Transparent Boundary Drawing2', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 52, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-22-2.jpg', 0, 'Transparent Boundary Drawing2' from artworks where inv_no = 'TIM-2013-TB-053' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 52 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-053' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-053', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-TB-054', 'transparent-boundary-drawing4', 'Transparent Boundary Drawing4', null, (select id from series where slug = 'transparent-boundary'), 2013, null, null, null, 'available', true, 53, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/transparent-boundary-2013/Drawing-24-2.jpg', 0, 'Transparent Boundary Drawing4' from artworks where inv_no = 'TIM-2013-TB-054' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 53 from exhibitions e, artworks a where e.slug = 'transparent-boundary-2013' and a.inv_no = 'TIM-2013-TB-054' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-TB-054', 'Image appears in the show page gallery; title, medium, size not given; may duplicate the numbered drawings; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('expression-of-color-and-line-2014', 'Expression of Color and Line & Jonogon Series', 'রঙ ও রেখার অভিব্যক্তি ও জনগণ সিরিজ', 'web-show', '2014-03-26', null, 'Online (linesof.life)', null, null, 'Embark on a profound exploration of life’s journey through the captivating lens of our latest exhibition,Journey of Colors and Lines.’ Life, much like a winding road, propels us all toward a destination, each following its own unique trajectory. This collection of acrylic paintings on paper unfolds the intricacies of this universal voyage, where the canvas becomes a visual diary of experiences and emotions.
In the ebb and flow of life, the lines take on a mesmerizing dance—sometimes straight, sometimes curved, and occasionally patchy, mirroring the diverse chapters we encounter. Along this dynamic path, the expression of colors morphs and evolves, revealing the ever-changing hues of our experiences. This exhibition encapsulates the essence of life’s story—a vivid portrayal of the journey we’re all undertaking.
The canvases are not just paintings; they are stories told through a fusion of colors and lines with a sense of movement. Each stroke carries a narrative, and every hue is a reflection of a moment lived. These acrylic works, completed in an abstract style, transcend the boundaries of conventional art to capture the essence of life’s unpredictable beauty.
As you navigate through this visual narrative, immerse yourself in the abstract tapestry, and let the colors speak to your soul. The strokes tell tales of resilience, joy, and introspection, echoing the nuances of our shared human experience.
Join us in ‘Journey of Colors and Lines,’ where each artwork is a testament to the beauty found in the movement of life. The acrylic canvases beckon you to witness the symphony of existence—capturing both the harmony and discord that make our journeys uniquely our own.
This exhibition is an invitation to pause, reflect, and appreciate the vibrant hues and dynamic lines that paint the canvas of our lives. May these works resonate with your own journey, offering moments of contemplation and connection.
Step into the realm where life’s story unfolds in strokes of acrylic brilliance—because in every line and color, there is a chapter of our shared journey waiting to be discovered.
Welcome to ‘Journey of Colors and Lines,’ where the canvas becomes a mirror to life’s kaleidoscope.

Jonogon Series Web Art Exhibition: Chronicles of Contemporary Life
Embark on a visual journey through my second web art show, “Jonogon Series,” held on March 26, 2014. This collection captures the essence of everyday events during a pivotal period of contemporary times. As I immersed myself in daily drawings, the series emerged as a reflection of the prevailing political instability and societal unrest in late 2013.
The “People” series delves into the tapestry of common lives, portraying the struggles and resilience amidst a backdrop of political repression. These artworks serve as a testament to the collective spirit and shared experiences during a time of conflict within the opposition party.
Each piece is a brushstroke on the canvas of our shared history, capturing the nuances and stories of ordinary people navigating through extraordinary circumstances. Join me in exploring the intersections of art and societal narrative in this poignant exhibition.
Let these visual narratives transport you into the heart of societal complexities, inviting reflection and connection. Art, as a mirror to our world, stands as a powerful medium to convey both the struggles and triumphs of the human experience.', 'জনগণ সিরিজটি ড্রইংগুলি আঁকা হয়েছে সমসাময়িক সময়ের প্রতিদিনের ঘটনাকে উপজীব্য করে
আমি প্রতিদিন ড্রইং
সাথে যুক্ত ছিলাম
২০১৩ সালের শেষের দিকে রাজনৈতিক
অস্থিতিশীলতা তখন সমাজের সর্বত্র বিরাজ করছিল
মানুষ উপর দমন পীড়ন চলছিল |গাড়ীতে আগুন রেল লাইন উঠিয়ে ফেলা মানুষকে নানাভাবে হেনস্তা করা
সরকারি ও বিরোধী দলের এই দ্বন্দে সাধারণ ও জন জীবনের যে দূর্দশা চিত্র তখন বিরাজ করেছিল সেই সময় ড্রইং গুলি নিয়েই এই জনগণ সিরিজ শো এর আয়োজন করা হয়েছে', 'https://www.youtube.com/watch?v=A-88WeXKbTo', 'webshows/expression-of-color-and-line-2014/Paintings_011.jpg', 'https://linesof.life/expression-of-color-and-line-paintings-janogon-series-drawing/', 'https://linesof.life/expression-of-color-and-line-paintings-janogon-series-drawing/', null, null, true, 1)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-001', 'expression-of-color-and-line-01', 'Expression of Color and Line 01', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 0, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_011.jpg', 0, 'Expression of Color and Line 01' from artworks where inv_no = 'TIM-2014-ECL-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 0 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-001' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-001', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-002', 'expression-of-color-and-line-02', 'Expression of Color and Line 02', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 1, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_021.jpg', 0, 'Expression of Color and Line 02' from artworks where inv_no = 'TIM-2014-ECL-002' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-002' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-002', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-003', 'expression-of-color-and-line-03', 'Expression of Color and Line 03', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 2, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_031.jpg', 0, 'Expression of Color and Line 03' from artworks where inv_no = 'TIM-2014-ECL-003' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 2 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-003' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-003', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-004', 'expression-of-color-and-line-04', 'Expression of Color and Line 04', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 3, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_041.jpg', 0, 'Expression of Color and Line 04' from artworks where inv_no = 'TIM-2014-ECL-004' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 3 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-004' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-004', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-005', 'expression-of-color-and-line-05', 'Expression of Color and Line 05', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 4, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_051.jpg', 0, 'Expression of Color and Line 05' from artworks where inv_no = 'TIM-2014-ECL-005' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 4 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-005' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-005', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-006', 'expression-of-color-and-line-06', 'Expression of Color and Line 06', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 5, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_061.jpg', 0, 'Expression of Color and Line 06' from artworks where inv_no = 'TIM-2014-ECL-006' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 5 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-006' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-006', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-007', 'expression-of-color-and-line-07', 'Expression of Color and Line 07', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 6, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_071.jpg', 0, 'Expression of Color and Line 07' from artworks where inv_no = 'TIM-2014-ECL-007' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 6 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-007' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-007', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-008', 'expression-of-color-and-line-08', 'Expression of Color and Line 08', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 7, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_081.jpg', 0, 'Expression of Color and Line 08' from artworks where inv_no = 'TIM-2014-ECL-008' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 7 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-008' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-008', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-009', 'expression-of-color-and-line-09', 'Expression of Color and Line 09', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 8, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_091.jpg', 0, 'Expression of Color and Line 09' from artworks where inv_no = 'TIM-2014-ECL-009' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 8 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-009' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-009', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-010', 'expression-of-color-and-line-10', 'Expression of Color and Line 10', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 9, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_101.jpg', 0, 'Expression of Color and Line 10' from artworks where inv_no = 'TIM-2014-ECL-010' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 9 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-010' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-010', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-011', 'expression-of-color-and-line-11', 'Expression of Color and Line 11', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 10, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_111.jpg', 0, 'Expression of Color and Line 11' from artworks where inv_no = 'TIM-2014-ECL-011' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 10 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-011' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-011', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-012', 'expression-of-color-and-line-12', 'Expression of Color and Line 12', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 11, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_121.jpg', 0, 'Expression of Color and Line 12' from artworks where inv_no = 'TIM-2014-ECL-012' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 11 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-012' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-012', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-013', 'expression-of-color-and-line-13', 'Expression of Color and Line 13', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 12, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_131.jpg', 0, 'Expression of Color and Line 13' from artworks where inv_no = 'TIM-2014-ECL-013' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 12 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-013' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-013', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-014', 'expression-of-color-and-line-14', 'Expression of Color and Line 14', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 13, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_141.jpg', 0, 'Expression of Color and Line 14' from artworks where inv_no = 'TIM-2014-ECL-014' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 13 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-014' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-014', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-015', 'expression-of-color-and-line-15', 'Expression of Color and Line 15', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 14, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_151.jpg', 0, 'Expression of Color and Line 15' from artworks where inv_no = 'TIM-2014-ECL-015' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 14 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-015' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-015', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-016', 'expression-of-color-and-line-16', 'Expression of Color and Line 16', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 15, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_161.jpg', 0, 'Expression of Color and Line 16' from artworks where inv_no = 'TIM-2014-ECL-016' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 15 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-016' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-016', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-017', 'expression-of-color-and-line-17', 'Expression of Color and Line 17', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 16, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_171.jpg', 0, 'Expression of Color and Line 17' from artworks where inv_no = 'TIM-2014-ECL-017' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 16 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-017' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-017', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-ECL-018', 'expression-of-color-and-line-18', 'Expression of Color and Line 18', null, (select id from series where slug = 'expression-of-color-and-line'), 2014, 'Acrylic on paper', null, null, 'available', true, 17, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Paintings_181.jpg', 0, 'Expression of Color and Line 18' from artworks where inv_no = 'TIM-2014-ECL-018' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 17 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2014-ECL-018' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-ECL-018', 'Size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-001', 'jonogon-01', 'Jonogon 01', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 18, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-01.jpg', 0, 'Jonogon 01' from artworks where inv_no = 'TIM-2013-ECL-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 18 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-001' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-001', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-002', 'jonogon-02', 'Jonogon 02', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 19, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-02.jpg', 0, 'Jonogon 02' from artworks where inv_no = 'TIM-2013-ECL-002' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 19 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-002' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-002', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-003', 'jonogon-03', 'Jonogon 03', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 20, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-03.jpg', 0, 'Jonogon 03' from artworks where inv_no = 'TIM-2013-ECL-003' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 20 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-003' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-003', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-004', 'jonogon-04', 'Jonogon 04', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 21, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-04.jpg', 0, 'Jonogon 04' from artworks where inv_no = 'TIM-2013-ECL-004' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 21 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-004' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-004', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-005', 'jonogon-05', 'Jonogon 05', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 22, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-05.jpg', 0, 'Jonogon 05' from artworks where inv_no = 'TIM-2013-ECL-005' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 22 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-005' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-005', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-006', 'jonogon-06', 'Jonogon 06', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 23, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-06.jpg', 0, 'Jonogon 06' from artworks where inv_no = 'TIM-2013-ECL-006' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 23 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-006' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-006', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-007', 'jonogon-07', 'Jonogon 07', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 24, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-07.jpg', 0, 'Jonogon 07' from artworks where inv_no = 'TIM-2013-ECL-007' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 24 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-007' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-007', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-008', 'jonogon-08', 'Jonogon 08', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 25, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-08.jpg', 0, 'Jonogon 08' from artworks where inv_no = 'TIM-2013-ECL-008' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 25 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-008' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-008', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-009', 'jonogon-09', 'Jonogon 09', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 26, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-09.jpg', 0, 'Jonogon 09' from artworks where inv_no = 'TIM-2013-ECL-009' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 26 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-009' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-009', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-010', 'jonogon-10', 'Jonogon 10', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 27, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-10.jpg', 0, 'Jonogon 10' from artworks where inv_no = 'TIM-2013-ECL-010' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 27 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-010' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-010', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-011', 'jonogon-11', 'Jonogon 11', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 28, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-11.jpg', 0, 'Jonogon 11' from artworks where inv_no = 'TIM-2013-ECL-011' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 28 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-011' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-011', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-012', 'jonogon-12', 'Jonogon 12', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 29, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-12.jpg', 0, 'Jonogon 12' from artworks where inv_no = 'TIM-2013-ECL-012' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 29 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-012' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-012', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-013', 'jonogon-13', 'Jonogon 13', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 30, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-13.jpg', 0, 'Jonogon 13' from artworks where inv_no = 'TIM-2013-ECL-013' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 30 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-013' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-013', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-014', 'jonogon-14', 'Jonogon 14', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 31, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-14.jpg', 0, 'Jonogon 14' from artworks where inv_no = 'TIM-2013-ECL-014' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 31 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-014' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-014', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-015', 'jonogon-15', 'Jonogon 15', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 32, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-15.jpg', 0, 'Jonogon 15' from artworks where inv_no = 'TIM-2013-ECL-015' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 32 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-015' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-015', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-016', 'jonogon-16', 'Jonogon 16', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 33, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-16.jpg', 0, 'Jonogon 16' from artworks where inv_no = 'TIM-2013-ECL-016' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 33 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-016' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-016', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-017', 'jonogon-17', 'Jonogon 17', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 34, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-17.jpg', 0, 'Jonogon 17' from artworks where inv_no = 'TIM-2013-ECL-017' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 34 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-017' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-017', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-018', 'jonogon-18', 'Jonogon 18', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 35, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-18.jpg', 0, 'Jonogon 18' from artworks where inv_no = 'TIM-2013-ECL-018' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 35 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-018' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-018', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-019', 'jonogon-19', 'Jonogon 19', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 36, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-19.jpg', 0, 'Jonogon 19' from artworks where inv_no = 'TIM-2013-ECL-019' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 36 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-019' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-019', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-020', 'jonogon-20', 'Jonogon 20', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 37, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-20.jpg', 0, 'Jonogon 20' from artworks where inv_no = 'TIM-2013-ECL-020' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 37 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-020' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-020', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-021', 'jonogon-21', 'Jonogon 21', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 38, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-21.jpg', 0, 'Jonogon 21' from artworks where inv_no = 'TIM-2013-ECL-021' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 38 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-021' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-021', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-022', 'jonogon-24', 'Jonogon 24', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 39, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-24.jpg', 0, 'Jonogon 24' from artworks where inv_no = 'TIM-2013-ECL-022' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 39 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-022' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-022', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-023', 'jonogon-27', 'Jonogon 27', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 40, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-271.jpg', 0, 'Jonogon 27' from artworks where inv_no = 'TIM-2013-ECL-023' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 40 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-023' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-023', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014. Only a low-resolution image exists.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-024', 'jonogon-28', 'Jonogon 28', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 41, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-281.jpg', 0, 'Jonogon 28' from artworks where inv_no = 'TIM-2013-ECL-024' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 41 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-024' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-024', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014. Only a low-resolution image exists.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-025', 'jonogon-29', 'Jonogon 29', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 42, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-29.jpg', 0, 'Jonogon 29' from artworks where inv_no = 'TIM-2013-ECL-025' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 42 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-025' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-025', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-026', 'jonogon-31', 'Jonogon 31', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 43, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-31.jpg', 0, 'Jonogon 31' from artworks where inv_no = 'TIM-2013-ECL-026' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 43 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-026' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-026', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-027', 'jonogon-22', 'Jonogon 22', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 44, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-22.jpg', 0, 'Jonogon 22' from artworks where inv_no = 'TIM-2013-ECL-027' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 44 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-027' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-027', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-028', 'jonogon-23', 'Jonogon 23', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 45, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-23.jpg', 0, 'Jonogon 23' from artworks where inv_no = 'TIM-2013-ECL-028' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 45 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-028' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-028', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-029', 'jonogon-25', 'Jonogon 25', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 46, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-25.jpg', 0, 'Jonogon 25' from artworks where inv_no = 'TIM-2013-ECL-029' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 46 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-029' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-029', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-030', 'jonogon-26', 'Jonogon 26', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 47, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-26.jpg', 0, 'Jonogon 26' from artworks where inv_no = 'TIM-2013-ECL-030' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 47 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-030' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-030', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-031', 'jonogon-32', 'Jonogon 32', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 48, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-32.jpg', 0, 'Jonogon 32' from artworks where inv_no = 'TIM-2013-ECL-031' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 48 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-031' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-031', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-032', 'jonogon-33', 'Jonogon 33', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 49, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-33.jpg', 0, 'Jonogon 33' from artworks where inv_no = 'TIM-2013-ECL-032' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 49 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-032' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-032', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-033', 'jonogon-34', 'Jonogon 34', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 50, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-34.jpg', 0, 'Jonogon 34' from artworks where inv_no = 'TIM-2013-ECL-033' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 50 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-033' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-033', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-034', 'jonogon-35', 'Jonogon 35', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 51, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-35.jpg', 0, 'Jonogon 35' from artworks where inv_no = 'TIM-2013-ECL-034' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 51 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-034' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-034', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-035', 'jonogon-36', 'Jonogon 36', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 52, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-36.jpg', 0, 'Jonogon 36' from artworks where inv_no = 'TIM-2013-ECL-035' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 52 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-035' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-035', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-036', 'jonogon-37', 'Jonogon 37', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 53, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-37.jpg', 0, 'Jonogon 37' from artworks where inv_no = 'TIM-2013-ECL-036' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 53 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-036' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-036', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-037', 'jonogon-38', 'Jonogon 38', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 54, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-38.jpg', 0, 'Jonogon 38' from artworks where inv_no = 'TIM-2013-ECL-037' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 54 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-037' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-037', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-038', 'jonogon-39', 'Jonogon 39', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 55, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-39.jpg', 0, 'Jonogon 39' from artworks where inv_no = 'TIM-2013-ECL-038' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 55 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-038' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-038', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-039', 'jonogon-40', 'Jonogon 40', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 56, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-40.jpg', 0, 'Jonogon 40' from artworks where inv_no = 'TIM-2013-ECL-039' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 56 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-039' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-039', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-040', 'jonogon-41', 'Jonogon 41', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 57, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-41.jpg', 0, 'Jonogon 41' from artworks where inv_no = 'TIM-2013-ECL-040' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 57 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-040' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-040', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-041', 'jonogon-42', 'Jonogon 42', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 58, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-42.jpg', 0, 'Jonogon 42' from artworks where inv_no = 'TIM-2013-ECL-041' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 58 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-041' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-041', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2013-ECL-042', 'jonogon-43', 'Jonogon 43', null, (select id from series where slug = 'lines-of-life'), 2013, null, null, null, 'available', false, 59, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/expression-of-color-and-line-2014/Drawing-43.jpg', 0, 'Jonogon 43' from artworks where inv_no = 'TIM-2013-ECL-042' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 59 from exhibitions e, artworks a where e.slug = 'expression-of-color-and-line-2014' and a.inv_no = 'TIM-2013-ECL-042' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2013-ECL-042', 'Medium and size not on the page; drawn late 2013, shown 26 Mar 2014.') on conflict (inv_no) do update set note = excluded.note;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('lines-of-life-2014', 'Lines of Life', 'জীবনের রেখা', 'web-show', '2014-12-16', null, 'Online (linesof.life)', null, null, '“Lines of Life: A Charcoal Symphony”
Embark on a visual odyssey as I unveil “Lines of Life,” my latest collection of 32 images drawn through the evocative medium of charcoal. In this 3rd web show, the pages come alive with a series that transcends the mere strokes on paper—it’s an intimate exploration of existence, emotions, and the collective unrest that defines our contemporary era.
🖼️
In the Line of Life Series:
Each charcoal stroke is a deliberate reflection of the multifaceted impact that resonates through our society. This series, “In the Line of Life,” captures the nuances of unrest prevailing in every sector—social, political, personal. The lines etched on paper are not just artistic expressions; they are visual echoes of the quest for a world liberated from pain, yearning for freedom in its purest essence.
🌌
Drawing from Daily Realization:
This body of work is born from the daily realization of the unrest that permeates our times. The charcoal lines become conduits for the emotional currents flowing through my mind—a profound response to the desire for a world free from shackles, where liberty is more than an aspiration; it’s a fundamental right.
🎨
Various Expressions Unveiled:
“Lines of Life” unfolds as a narrative tapestry, weaving together various expressions—some intimate, some bold. Each image is a chapter, reflecting the kaleidoscope of human experiences. Through varied strokes and shades, the drawings capture resilience, hope, and the relentless pursuit of living authentically and unburdened.', null, 'https://www.youtube.com/watch?v=1PSoTpOIi1s', 'webshows/lines-of-life-2014/banner_3rd-_solo-.jpg', 'https://linesof.life/3rd-solo-web-art-show-lines-of-life-2014/', 'https://linesof.life/3rd-solo-web-art-show-lines-of-life-2014/', null, null, true, 2)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-001', 'lines-of-life-001', 'Lines of Life-001', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 0, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_001.jpg', 0, 'Lines of Life-001' from artworks where inv_no = 'TIM-2014-LOL-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 0 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-001' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-001', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-002', 'lines-of-life-002', 'Lines of Life-002', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 1, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_002.jpg', 0, 'Lines of Life-002' from artworks where inv_no = 'TIM-2014-LOL-002' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-002' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-002', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-003', 'lines-of-life-003', 'Lines of Life-003', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 2, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_003.jpg', 0, 'Lines of Life-003' from artworks where inv_no = 'TIM-2014-LOL-003' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 2 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-003' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-003', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-004', 'lines-of-life-004', 'Lines of Life-004', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 3, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_004.jpg', 0, 'Lines of Life-004' from artworks where inv_no = 'TIM-2014-LOL-004' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 3 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-004' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-004', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-005', 'lines-of-life-005', 'Lines of Life-005', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 4, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_005.jpg', 0, 'Lines of Life-005' from artworks where inv_no = 'TIM-2014-LOL-005' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 4 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-005' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-005', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-006', 'lines-of-life-006', 'Lines of Life-006', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 5, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_006.jpg', 0, 'Lines of Life-006' from artworks where inv_no = 'TIM-2014-LOL-006' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 5 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-006' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-006', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-007', 'lines-of-life-007', 'Lines of Life-007', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 6, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_007.jpg', 0, 'Lines of Life-007' from artworks where inv_no = 'TIM-2014-LOL-007' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 6 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-007' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-007', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-008', 'lines-of-life-008', 'Lines of Life-008', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 7, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_008.jpg', 0, 'Lines of Life-008' from artworks where inv_no = 'TIM-2014-LOL-008' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 7 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-008' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-008', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-009', 'lines-of-life-009', 'Lines of Life-009', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 8, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_009.jpg', 0, 'Lines of Life-009' from artworks where inv_no = 'TIM-2014-LOL-009' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 8 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-009' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-009', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-010', 'lines-of-life-010', 'Lines of Life-010', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 9, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_010.jpg', 0, 'Lines of Life-010' from artworks where inv_no = 'TIM-2014-LOL-010' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 9 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-010' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-010', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-011', 'lines-of-life-011', 'Lines of Life-011', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 10, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_011.jpg', 0, 'Lines of Life-011' from artworks where inv_no = 'TIM-2014-LOL-011' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 10 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-011' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-011', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-012', 'lines-of-life-012', 'Lines of Life-012', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 11, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_012.jpg', 0, 'Lines of Life-012' from artworks where inv_no = 'TIM-2014-LOL-012' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 11 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-012' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-012', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-013', 'lines-of-life-013', 'Lines of Life-013', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 12, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_013.jpg', 0, 'Lines of Life-013' from artworks where inv_no = 'TIM-2014-LOL-013' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 12 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-013' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-013', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-014', 'lines-of-life-014', 'Lines of Life-014', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 13, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_014.jpg', 0, 'Lines of Life-014' from artworks where inv_no = 'TIM-2014-LOL-014' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 13 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-014' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-014', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-015', 'lines-of-life-015', 'Lines of Life-015', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 14, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_015.jpg', 0, 'Lines of Life-015' from artworks where inv_no = 'TIM-2014-LOL-015' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 14 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-015' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-015', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-016', 'lines-of-life-016', 'Lines of Life-016', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 15, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_016.jpg', 0, 'Lines of Life-016' from artworks where inv_no = 'TIM-2014-LOL-016' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 15 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-016' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-016', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-017', 'lines-of-life-017', 'Lines of Life-017', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 16, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_017.jpg', 0, 'Lines of Life-017' from artworks where inv_no = 'TIM-2014-LOL-017' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 16 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-017' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-017', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-018', 'lines-of-life-018', 'Lines of Life-018', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 17, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_018.jpg', 0, 'Lines of Life-018' from artworks where inv_no = 'TIM-2014-LOL-018' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 17 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-018' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-018', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-019', 'lines-of-life-019', 'Lines of Life-019', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 18, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_019.jpg', 0, 'Lines of Life-019' from artworks where inv_no = 'TIM-2014-LOL-019' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 18 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-019' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-019', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-020', 'lines-of-life-020', 'Lines of Life-020', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 19, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_020.jpg', 0, 'Lines of Life-020' from artworks where inv_no = 'TIM-2014-LOL-020' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 19 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-020' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-020', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-021', 'lines-of-life-021', 'Lines of Life-021', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 20, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_021.jpg', 0, 'Lines of Life-021' from artworks where inv_no = 'TIM-2014-LOL-021' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 20 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-021' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-021', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-022', 'lines-of-life-022', 'Lines of Life-022', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 21, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_022.jpg', 0, 'Lines of Life-022' from artworks where inv_no = 'TIM-2014-LOL-022' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 21 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-022' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-022', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-023', 'lines-of-life-023', 'Lines of Life-023', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 22, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_023.jpg', 0, 'Lines of Life-023' from artworks where inv_no = 'TIM-2014-LOL-023' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 22 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-023' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-023', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-024', 'lines-of-life-024', 'Lines of Life-024', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 23, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_024.jpg', 0, 'Lines of Life-024' from artworks where inv_no = 'TIM-2014-LOL-024' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 23 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-024' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-024', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-025', 'lines-of-life-025', 'Lines of Life-025', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 24, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_025.jpg', 0, 'Lines of Life-025' from artworks where inv_no = 'TIM-2014-LOL-025' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 24 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-025' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-025', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-026', 'lines-of-life-026', 'Lines of Life-026', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 25, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_026.jpg', 0, 'Lines of Life-026' from artworks where inv_no = 'TIM-2014-LOL-026' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 25 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-026' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-026', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-027', 'lines-of-life-027', 'Lines of Life-027', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 26, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_027.jpg', 0, 'Lines of Life-027' from artworks where inv_no = 'TIM-2014-LOL-027' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 26 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-027' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-027', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-028', 'lines-of-life-028', 'Lines of Life-028', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 27, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_028.jpg', 0, 'Lines of Life-028' from artworks where inv_no = 'TIM-2014-LOL-028' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 27 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-028' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-028', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-029', 'lines-of-life-029', 'Lines of Life-029', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 28, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_029.jpg', 0, 'Lines of Life-029' from artworks where inv_no = 'TIM-2014-LOL-029' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 28 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-029' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-029', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-030', 'lines-of-life-030', 'Lines of Life-030', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 29, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_030.jpg', 0, 'Lines of Life-030' from artworks where inv_no = 'TIM-2014-LOL-030' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 29 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-030' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-030', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-031', 'lines-of-life-031', 'Lines of Life-031', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 30, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_031.jpg', 0, 'Lines of Life-031' from artworks where inv_no = 'TIM-2014-LOL-031' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 30 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-031' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-031', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2014-LOL-032', 'lines-of-life-032', 'Lines of Life-032', null, (select id from series where slug = 'lines-of-life'), 2014, 'Charcoal on paper', 76.2, 50.8, 'available', true, 31, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2014/lines-of-Life-charcol_032.jpg', 0, 'Lines of Life-032' from artworks where inv_no = 'TIM-2014-LOL-032' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 31 from exhibitions e, artworks a where e.slug = 'lines-of-life-2014' and a.inv_no = 'TIM-2014-LOL-032' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2014-LOL-032', 'Size given as 20" x 30" (orientation assumed portrait).') on conflict (inv_no) do update set note = excluded.note;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('ramadan-lines-2018', 'Ramadan Lines 2018', 'রমজানের রেখা ২০১৮', 'web-show', '2018-05-17', '2018-06-14', 'Online (linesof.life)', null, null, 'Ramadan The great month comes every year; a blessed month; a month in which is a night better than a thousand months; Artist’s lines of the holy and blessing month of Ramadan on Paper….
This Online Gallery represents the finest of the Lines throughout the Holy Month of Ramadan 2018…', null, null, 'webshows/ramadan-lines-2018/05052018.jpg', 'https://linesof.life/ramadan-lines-of-2018/', 'https://linesof.life/ramadan-lines-of-2018/', null, null, true, 3)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-001', 'ramadan-lines-05-05-2018', 'Ramadan Lines, 05-05-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 0, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/05052018.jpg', 0, 'Ramadan Lines, 05-05-2018' from artworks where inv_no = 'TIM-2018-RL-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 0 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-001' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-001', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-002', 'ramadan-lines-06-05-2018', 'Ramadan Lines, 06-05-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 1, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/06052018.jpg', 0, 'Ramadan Lines, 06-05-2018' from artworks where inv_no = 'TIM-2018-RL-002' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-002' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-002', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-003', 'ramadan-lines-10-05-2018', 'Ramadan Lines, 10-05-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 2, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/10052018.jpg', 0, 'Ramadan Lines, 10-05-2018' from artworks where inv_no = 'TIM-2018-RL-003' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 2 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-003' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-003', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-004', 'ramadan-lines-12-05-2018', 'Ramadan Lines, 12-05-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 3, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/12052018.jpg', 0, 'Ramadan Lines, 12-05-2018' from artworks where inv_no = 'TIM-2018-RL-004' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 3 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-004' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-004', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-005', 'ramadan-lines-16-05-2018', 'Ramadan Lines, 16-05-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 4, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/16052018.jpg', 0, 'Ramadan Lines, 16-05-2018' from artworks where inv_no = 'TIM-2018-RL-005' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 4 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-005' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-005', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-006', 'ramadan-lines-21-05-2018', 'Ramadan Lines, 21-05-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 5, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/21052018.jpg', 0, 'Ramadan Lines, 21-05-2018' from artworks where inv_no = 'TIM-2018-RL-006' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 5 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-006' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-006', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-007', 'ramadan-lines-24-05-2018', 'Ramadan Lines, 24-05-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 6, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/24052018.jpg', 0, 'Ramadan Lines, 24-05-2018' from artworks where inv_no = 'TIM-2018-RL-007' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 6 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-007' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-007', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-008', 'ramadan-lines-26-05-2018', 'Ramadan Lines, 26-05-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 7, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/26052018.jpeg', 0, 'Ramadan Lines, 26-05-2018' from artworks where inv_no = 'TIM-2018-RL-008' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 7 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-008' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-008', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-009', 'ramadan-lines-01-06-2018', 'Ramadan Lines, 01-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 8, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/01062018.jpg', 0, 'Ramadan Lines, 01-06-2018' from artworks where inv_no = 'TIM-2018-RL-009' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 8 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-009' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-009', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-010', 'ramadan-lines-02-06-2018', 'Ramadan Lines, 02-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 9, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/02062018.jpg', 0, 'Ramadan Lines, 02-06-2018' from artworks where inv_no = 'TIM-2018-RL-010' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 9 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-010' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-010', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-011', 'ramadan-lines-03-06-2018', 'Ramadan Lines, 03-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 10, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/03062018.jpg', 0, 'Ramadan Lines, 03-06-2018' from artworks where inv_no = 'TIM-2018-RL-011' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 10 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-011' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-011', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-012', 'ramadan-lines-04-06-2018', 'Ramadan Lines, 04-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 11, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/04062018.jpg', 0, 'Ramadan Lines, 04-06-2018' from artworks where inv_no = 'TIM-2018-RL-012' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 11 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-012' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-012', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-013', 'ramadan-lines-07-06-2018', 'Ramadan Lines, 07-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 12, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/07062018.jpg', 0, 'Ramadan Lines, 07-06-2018' from artworks where inv_no = 'TIM-2018-RL-013' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 12 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-013' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-013', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-014', 'ramadan-lines-09-06-2018', 'Ramadan Lines, 09-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 13, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/09062018.jpg', 0, 'Ramadan Lines, 09-06-2018' from artworks where inv_no = 'TIM-2018-RL-014' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 13 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-014' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-014', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-015', 'ramadan-lines-11-06-2018', 'Ramadan Lines, 11-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 14, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/11062018.jpg', 0, 'Ramadan Lines, 11-06-2018' from artworks where inv_no = 'TIM-2018-RL-015' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 14 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-015' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-015', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-016', 'ramadan-lines-12-06-2018', 'Ramadan Lines, 12-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 15, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/12062018.jpg', 0, 'Ramadan Lines, 12-06-2018' from artworks where inv_no = 'TIM-2018-RL-016' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 15 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-016' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-016', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-017', 'ramadan-lines-13-06-2018', 'Ramadan Lines, 13-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 16, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/13062018.jpg', 0, 'Ramadan Lines, 13-06-2018' from artworks where inv_no = 'TIM-2018-RL-017' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 16 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-017' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-017', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2018-RL-018', 'ramadan-lines-14-06-2018', 'Ramadan Lines, 14-06-2018', null, (select id from series where slug = 'ramadan-lines'), 2018, 'Drawing on paper', null, null, 'available', true, 17, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/ramadan-lines-2018/14062018.jpg', 0, 'Ramadan Lines, 14-06-2018' from artworks where inv_no = 'TIM-2018-RL-018' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 17 from exhibitions e, artworks a where e.slug = 'ramadan-lines-2018' and a.inv_no = 'TIM-2018-RL-018' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2018-RL-018', 'Size not on the page; only ~600px images exist online.') on conflict (inv_no) do update set note = excluded.note;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('lines-of-image-2019', 'Lines of Image (1–60)', 'লাইনস অফ ইমেজ (১–৬০)', 'web-show', '2019-02-21', null, 'Online (linesof.life)', null, null, 'Creating lines combined with many thoughts that came to my mind comprising of daily activities, topics that are expressed as frustration, fear, anger, friendship, pursuit, love, general chat etc., are presented through these lines of my life.
The feelings that we have in our daily life have been revealed through the works by using a pen with acrylic color as the medium.
The sanity of the mechanical Life we live now a day is lack of simple and straight forward thinking just like how we put lines on paper.
The main theme of this exhibition is to follow the dissimilar type of lines of LIFE…', 'অনেক বিন্দুর মিলন হতে সৃষ্ট রেখা সৃষ্টির শুরু থেকে নির্মাণ করে যাচ্ছে অবিরাম যার কল্যানে গুহা চিত্র থেকে শুরু করে বর্তমান বিশ্বের যাবতীয় আবিস্কারের মূল বিষয় হয়ে আছে রেখা। রেখার মাধ্যমে সৃষ্টির প্রাথমিক গঠন আমাদের দৃষ্টি গোচর হয় আমরা বুঝতে পারি বস্তুর অবয়ব ও আকার। রেখার সাথে আমার এই ভাব বিনিময় শুরু হয়েছে ছেলে বেলা থেকেই তাই আমি মূলত রেখা নির্ভর গঠনে প্রতি একাত্ম হয়ে আছি। এই প্রদর্শনীর মূল বিষয় রেখার ভিন্ন গতি প্রকৃতির অনুসরণ ও উপলব্ধি করা। এই গতি প্রকৃতির ভিন্নতায় নানা রকম ফর্মের গঠন প্রকাশ পেয়েছে। রঙ ব্যবহার হয়েছে ছবির ব্যাগ্রউন্ড হিসেবে । মূলত এই ব্যাকগ্রাউন্ড মোটা/ চওড়া স্তরের রঙ্গিন লাইন হিসেবে ব্যবহারিত হয়েছে।
বিষয় হিসেবে যান্ত্রিক শহরে নানা দিক সহজ সরল ভাবে উপস্থাপিত হয়েছে। মানুষের মধ্যে যে হতাশা, ভয়, ক্রোধ, বন্ধুত্ত্ব, সাধনা, সাধারণ আড্ডা ইত্যাদি বিষয় স্থান পেয়েছে। প্রতিদিন সময়ের সাথে যে অনুভূতি গুলি আমার শরীর ধারণ করে তাই প্রকাশ পেয়েছে এই কাজগুলিতে। মাধ্যম হিসেবে এক্রেলিক রঙ সাথে ভিন্ন রকম কলম এর ব্যবহার হয়েছে। Lines of Image শিরোনামে এই প্রদর্শনীতে ৬০টি ছবি আছে এর মধ্যে ৪৫টি রঙের চিত্রপটে পেনের কাজ ও বাকি ১৫ টি শুধু পেনে কাজ করা।
সময়ের সাথে সাথে রেখার গতি প্রকৃতি নিয়ে ৪র্থ প্রদর্শনীতে আপনাদের স্বাগত।', 'https://www.youtube.com/watch?v=IL7w2iTXXjU', 'webshows/lines-of-image-2019/Banner_fb_20-febjpg-1.jpg', 'https://linesof.life/4th-solo-web-art-show/', 'https://linesof.life/4th-solo-web-art-show/', null, null, true, 4)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-001', 'lines-of-image-01', 'Lines of Image 01', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 0, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-1.jpg', 0, 'Lines of Image 01' from artworks where inv_no = 'TIM-2019-LOI-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 0 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-001' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-002', 'lines-of-image-02', 'Lines of Image 02', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 1, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-2.jpg', 0, 'Lines of Image 02' from artworks where inv_no = 'TIM-2019-LOI-002' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-002' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-003', 'lines-of-image-03', 'Lines of Image 03', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 2, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-3.jpg', 0, 'Lines of Image 03' from artworks where inv_no = 'TIM-2019-LOI-003' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 2 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-003' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-004', 'lines-of-image-04', 'Lines of Image 04', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 3, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-4.jpg', 0, 'Lines of Image 04' from artworks where inv_no = 'TIM-2019-LOI-004' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 3 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-004' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-005', 'lines-of-image-05', 'Lines of Image 05', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 4, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-5.jpg', 0, 'Lines of Image 05' from artworks where inv_no = 'TIM-2019-LOI-005' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 4 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-005' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-006', 'lines-of-image-06', 'Lines of Image 06', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 5, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-6.jpg', 0, 'Lines of Image 06' from artworks where inv_no = 'TIM-2019-LOI-006' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 5 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-006' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-007', 'lines-of-image-07', 'Lines of Image 07', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 6, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-7.jpg', 0, 'Lines of Image 07' from artworks where inv_no = 'TIM-2019-LOI-007' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 6 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-007' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-008', 'lines-of-image-08', 'Lines of Image 08', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 7, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-8.jpg', 0, 'Lines of Image 08' from artworks where inv_no = 'TIM-2019-LOI-008' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 7 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-008' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-009', 'lines-of-image-09', 'Lines of Image 09', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 8, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-9.jpg', 0, 'Lines of Image 09' from artworks where inv_no = 'TIM-2019-LOI-009' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 8 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-009' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-010', 'lines-of-image-10', 'Lines of Image 10', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 9, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-10.jpg', 0, 'Lines of Image 10' from artworks where inv_no = 'TIM-2019-LOI-010' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 9 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-010' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-011', 'lines-of-image-11', 'Lines of Image 11', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 10, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-11.jpg', 0, 'Lines of Image 11' from artworks where inv_no = 'TIM-2019-LOI-011' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 10 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-011' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-012', 'lines-of-image-12', 'Lines of Image 12', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 11, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-12.jpg', 0, 'Lines of Image 12' from artworks where inv_no = 'TIM-2019-LOI-012' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 11 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-012' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-013', 'lines-of-image-13', 'Lines of Image 13', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 12, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-13.jpg', 0, 'Lines of Image 13' from artworks where inv_no = 'TIM-2019-LOI-013' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 12 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-013' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-014', 'lines-of-image-14', 'Lines of Image 14', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 13, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-14.jpg', 0, 'Lines of Image 14' from artworks where inv_no = 'TIM-2019-LOI-014' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 13 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-014' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-015', 'lines-of-image-15', 'Lines of Image 15', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 14, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-15.jpg', 0, 'Lines of Image 15' from artworks where inv_no = 'TIM-2019-LOI-015' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 14 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-015' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-016', 'lines-of-image-16', 'Lines of Image 16', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 15, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-16.jpg', 0, 'Lines of Image 16' from artworks where inv_no = 'TIM-2019-LOI-016' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 15 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-016' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-017', 'lines-of-image-17', 'Lines of Image 17', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 16, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-17.jpg', 0, 'Lines of Image 17' from artworks where inv_no = 'TIM-2019-LOI-017' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 16 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-017' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-018', 'lines-of-image-18', 'Lines of Image 18', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 17, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-18.jpg', 0, 'Lines of Image 18' from artworks where inv_no = 'TIM-2019-LOI-018' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 17 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-018' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-019', 'lines-of-image-19', 'Lines of Image 19', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 18, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-19.jpg', 0, 'Lines of Image 19' from artworks where inv_no = 'TIM-2019-LOI-019' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 18 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-019' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-020', 'lines-of-image-20', 'Lines of Image 20', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 19, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-20.jpg', 0, 'Lines of Image 20' from artworks where inv_no = 'TIM-2019-LOI-020' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 19 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-020' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-021', 'lines-of-image-21', 'Lines of Image 21', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 20, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-21.jpg', 0, 'Lines of Image 21' from artworks where inv_no = 'TIM-2019-LOI-021' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 20 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-021' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-022', 'lines-of-image-22', 'Lines of Image 22', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 21, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-22.jpg', 0, 'Lines of Image 22' from artworks where inv_no = 'TIM-2019-LOI-022' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 21 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-022' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-023', 'lines-of-image-23', 'Lines of Image 23', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 22, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-23.jpg', 0, 'Lines of Image 23' from artworks where inv_no = 'TIM-2019-LOI-023' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 22 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-023' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-024', 'lines-of-image-24', 'Lines of Image 24', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 23, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-24.jpg', 0, 'Lines of Image 24' from artworks where inv_no = 'TIM-2019-LOI-024' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 23 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-024' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-025', 'lines-of-image-25', 'Lines of Image 25', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 24, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-25.jpg', 0, 'Lines of Image 25' from artworks where inv_no = 'TIM-2019-LOI-025' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 24 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-025' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-026', 'lines-of-image-26', 'Lines of Image 26', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 25, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-26.jpg', 0, 'Lines of Image 26' from artworks where inv_no = 'TIM-2019-LOI-026' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 25 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-026' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-027', 'lines-of-image-27', 'Lines of Image 27', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 26, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-27.jpg', 0, 'Lines of Image 27' from artworks where inv_no = 'TIM-2019-LOI-027' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 26 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-027' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-028', 'lines-of-image-28', 'Lines of Image 28', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 27, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-28.jpg', 0, 'Lines of Image 28' from artworks where inv_no = 'TIM-2019-LOI-028' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 27 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-028' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-029', 'lines-of-image-29', 'Lines of Image 29', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 28, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-29.jpg', 0, 'Lines of Image 29' from artworks where inv_no = 'TIM-2019-LOI-029' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 28 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-029' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-030', 'lines-of-image-30', 'Lines of Image 30', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 29, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-30.jpg', 0, 'Lines of Image 30' from artworks where inv_no = 'TIM-2019-LOI-030' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 29 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-030' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-031', 'lines-of-image-31', 'Lines of Image 31', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 30, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-31.jpg', 0, 'Lines of Image 31' from artworks where inv_no = 'TIM-2019-LOI-031' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 30 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-031' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-032', 'lines-of-image-32', 'Lines of Image 32', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 31, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-32.jpg', 0, 'Lines of Image 32' from artworks where inv_no = 'TIM-2019-LOI-032' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 31 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-032' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-033', 'lines-of-image-33', 'Lines of Image 33', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 32, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-33.jpg', 0, 'Lines of Image 33' from artworks where inv_no = 'TIM-2019-LOI-033' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 32 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-033' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-034', 'lines-of-image-34', 'Lines of Image 34', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 33, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-34.jpg', 0, 'Lines of Image 34' from artworks where inv_no = 'TIM-2019-LOI-034' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 33 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-034' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-035', 'lines-of-image-35', 'Lines of Image 35', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 34, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-35.jpg', 0, 'Lines of Image 35' from artworks where inv_no = 'TIM-2019-LOI-035' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 34 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-035' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-036', 'lines-of-image-36', 'Lines of Image 36', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 35, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-36.jpg', 0, 'Lines of Image 36' from artworks where inv_no = 'TIM-2019-LOI-036' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 35 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-036' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-037', 'lines-of-image-37', 'Lines of Image 37', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 36, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-37.jpg', 0, 'Lines of Image 37' from artworks where inv_no = 'TIM-2019-LOI-037' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 36 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-037' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-038', 'lines-of-image-38', 'Lines of Image 38', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 37, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-38.jpg', 0, 'Lines of Image 38' from artworks where inv_no = 'TIM-2019-LOI-038' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 37 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-038' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-039', 'lines-of-image-39', 'Lines of Image 39', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 38, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-39.jpg', 0, 'Lines of Image 39' from artworks where inv_no = 'TIM-2019-LOI-039' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 38 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-039' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-040', 'lines-of-image-40', 'Lines of Image 40', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 39, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-40.jpg', 0, 'Lines of Image 40' from artworks where inv_no = 'TIM-2019-LOI-040' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 39 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-040' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-041', 'lines-of-image-41', 'Lines of Image 41', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 40, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-41.jpg', 0, 'Lines of Image 41' from artworks where inv_no = 'TIM-2019-LOI-041' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 40 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-041' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-042', 'lines-of-image-42', 'Lines of Image 42', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 41, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-42.jpg', 0, 'Lines of Image 42' from artworks where inv_no = 'TIM-2019-LOI-042' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 41 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-042' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-043', 'lines-of-image-43', 'Lines of Image 43', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 42, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-43.jpg', 0, 'Lines of Image 43' from artworks where inv_no = 'TIM-2019-LOI-043' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 42 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-043' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-044', 'lines-of-image-44', 'Lines of Image 44', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 43, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-44.jpg', 0, 'Lines of Image 44' from artworks where inv_no = 'TIM-2019-LOI-044' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 43 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-044' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-045', 'lines-of-image-45', 'Lines of Image 45', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen with colour on paper', 71, 58, 'available', true, 44, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-45.jpg', 0, 'Lines of Image 45' from artworks where inv_no = 'TIM-2019-LOI-045' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 44 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-045' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-046', 'lines-of-image-46', 'Lines of Image 46', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 45, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-46.jpg', 0, 'Lines of Image 46' from artworks where inv_no = 'TIM-2019-LOI-046' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 45 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-046' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-046', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-047', 'lines-of-image-47', 'Lines of Image 47', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 46, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-47.jpg', 0, 'Lines of Image 47' from artworks where inv_no = 'TIM-2019-LOI-047' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 46 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-047' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-047', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-048', 'lines-of-image-48', 'Lines of Image 48', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 47, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-48.jpg', 0, 'Lines of Image 48' from artworks where inv_no = 'TIM-2019-LOI-048' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 47 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-048' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-048', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-049', 'lines-of-image-49', 'Lines of Image 49', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 48, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-49.jpg', 0, 'Lines of Image 49' from artworks where inv_no = 'TIM-2019-LOI-049' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 48 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-049' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-049', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-050', 'lines-of-image-50', 'Lines of Image 50', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 49, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-50.jpg', 0, 'Lines of Image 50' from artworks where inv_no = 'TIM-2019-LOI-050' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 49 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-050' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-050', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-051', 'lines-of-image-51', 'Lines of Image 51', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 50, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-51.jpg', 0, 'Lines of Image 51' from artworks where inv_no = 'TIM-2019-LOI-051' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 50 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-051' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-051', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-052', 'lines-of-image-52', 'Lines of Image 52', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 51, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-52.jpg', 0, 'Lines of Image 52' from artworks where inv_no = 'TIM-2019-LOI-052' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 51 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-052' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-052', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-053', 'lines-of-image-53', 'Lines of Image 53', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 52, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-53.jpg', 0, 'Lines of Image 53' from artworks where inv_no = 'TIM-2019-LOI-053' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 52 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-053' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-053', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-054', 'lines-of-image-54', 'Lines of Image 54', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 53, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-54.jpg', 0, 'Lines of Image 54' from artworks where inv_no = 'TIM-2019-LOI-054' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 53 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-054' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-054', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-055', 'lines-of-image-55', 'Lines of Image 55', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 54, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-55.jpg', 0, 'Lines of Image 55' from artworks where inv_no = 'TIM-2019-LOI-055' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 54 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-055' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-055', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-056', 'lines-of-image-56', 'Lines of Image 56', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 55, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-56.jpg', 0, 'Lines of Image 56' from artworks where inv_no = 'TIM-2019-LOI-056' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 55 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-056' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-056', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-057', 'lines-of-image-57', 'Lines of Image 57', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 56, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-57.jpg', 0, 'Lines of Image 57' from artworks where inv_no = 'TIM-2019-LOI-057' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 56 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-057' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-057', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-058', 'lines-of-image-58', 'Lines of Image 58', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 57, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-58.jpg', 0, 'Lines of Image 58' from artworks where inv_no = 'TIM-2019-LOI-058' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 57 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-058' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-058', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-059', 'lines-of-image-59', 'Lines of Image 59', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 58, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-59.jpg', 0, 'Lines of Image 59' from artworks where inv_no = 'TIM-2019-LOI-059' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 58 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-059' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-059', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-060', 'lines-of-image-60', 'Lines of Image 60', null, (select id from series where slug = 'lines-of-image'), 2019, 'Pen on paper', null, null, 'available', true, 59, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-2019/Lines-of-Image-60.jpg', 0, 'Lines of Image 60' from artworks where inv_no = 'TIM-2019-LOI-060' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 59 from exhibitions e, artworks a where e.slug = 'lines-of-image-2019' and a.inv_no = 'TIM-2019-LOI-060' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-060', 'Pen-only work; size not on the page.') on conflict (inv_no) do update set note = excluded.note;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('lines-of-image-61-120-2019', 'Lines of Image (61–120)', 'লাইনস অফ ইমেজ (৬১–১২০)', 'web-show', '2019-04-14', null, 'Online (linesof.life)', null, null, 'Creating lines combined with many thoughts that came to my mind comprising of daily activities, topics that are expressed as frustration, fear, anger, friendship, pursuit, love, general chat etc., are presented through these lines of my life.
The feelings that we have in our daily life have been revealed through the works by using a pen with acrylic color as the medium.
The sanity of the mechanical Life we live now a day is lack of simple and straight forward thinking just like how we put lines on paper.
The main theme of this exhibition is to follow the dissimilar type of lines of LIFE…', 'অনেক বিন্দুর মিলিত হয়ে একটি রেখার সৃষ্টি। এই রেখা সৃষ্টির শুরু থেকে নির্মাণ করে যাচ্ছে অবিরাম যা কল্যানে গুহা চিত্র থেকে শুরু করে বর্তমান বিশ্বের যাবতীয় আবিস্কার মূল বিষয় হয়ে আছে। রেখার মাধ্যমে সৃষ্টির প্রাথমিক গঠন আমাদের দৃষ্টি গোচর হয় আমরা বুঝতে পারি বস্তুর অবয়ব ও গঠন। রেখার সাথে আমার এই ভাব বিনিময় শুরু হয়েছে ছোট বেলা থেকেই তাই আমি মূলত রেখা নির্ভর গঠনে প্রতি একাত্ম হয়ে আছি। এই প্রদর্শনীর মূল বিষয় রেখার বিভিন্ন গতি প্রকৃতির অনুসরণ করা।
এই গতি প্রকৃতির উপস্থাপনের প্রয়োজনে কখনও বিভিন্ন রকম ফর্মের ভিন্নতা এসেছে। রঙ ব্যবহার হয়েছে ছবির ব্যাগ্রউন্ড হিসেবে । মূলত এই ব্যাকগ্রাউন্ড মোটা/ চওড়া স্তরের রঙ্গিন লাইনের হিসেবে ব্যবহারিত হয়েছে।
বিষয় হিসেবে যান্ত্রিক শহরের নান বিষয় যা আমরা প্রতিদিন দেখছি তারই সহজ সরল উপস্থাপন ছবিতে এসেছে,  মানুষের মধে্য যে হতাশা, ভয়, ক্রোধ, বন্ধুত্ত্ব, সাধনা, সাধারণ আড্ডা ইত্যাদি বিষয় উপস্থাপিত হয়েছে। প্রতিদিনের সময়ের সাথে যে অনুভূতি আমার শরীরে ধারণ করে তাই প্রকাশ পেয়েছে এই কাজগুলিতে। মাধ্যম হিসেবে এক্রেলিক রঙ সাথে কলম এর ব্যবহার হয়েছে।
জীবনের নানা গতি প্রকৃতি ও অনুভূতি রেখার মাধ্যমে উপস্থাপিত হয়েছে এই প্রদর্শনীতে, ক্যানভাসে রঙের রেখার সাথে কলমের রেখার সংমিশ্রনে ভিন্ন ধর্মী অনুভূতি সৃষ্টি হয়েছে ; ভিন্ন এই যাত্রার কিছু কাজ নিয়ে শুরু করছি পহেলা বৈশাখ থেকে আমার ৫ম একক ওয়েব আর্ট শো। Lines of Image (61 to 120) শিরোনামে এই প্রদর্শনীতে ৪০ টি এক্রেলিক সাথে কলম ও ২০ টি ড্রইং এর কাজ আছে। নতুন বাংলা নববর্ষে সবাইকে শুভেচ্ছে জানিয়ে প্রদর্শনী শুরু করছি।', 'https://www.youtube.com/watch?v=K4XPfF2JhJY', 'webshows/lines-of-image-61-120-2019/5tholo.jpeg', 'https://linesof.life/5th-solo-web-art-show-14-april-2019/', 'https://linesof.life/5th-solo-web-art-show-14-april-2019/', null, null, true, 5)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-061', 'lines-of-image-61', 'Lines of Image 61', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 0, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_61.jpg', 0, 'Lines of Image 61' from artworks where inv_no = 'TIM-2019-LOI-061' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 0 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-061' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-061', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-062', 'lines-of-image-62', 'Lines of Image 62', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 1, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_62.jpg', 0, 'Lines of Image 62' from artworks where inv_no = 'TIM-2019-LOI-062' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-062' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-062', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-063', 'lines-of-image-63', 'Lines of Image 63', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 2, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_63.jpg', 0, 'Lines of Image 63' from artworks where inv_no = 'TIM-2019-LOI-063' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 2 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-063' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-063', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-064', 'lines-of-image-64', 'Lines of Image 64', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 3, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_64.jpg', 0, 'Lines of Image 64' from artworks where inv_no = 'TIM-2019-LOI-064' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 3 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-064' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-064', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-065', 'lines-of-image-65', 'Lines of Image 65', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 4, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_65.jpg', 0, 'Lines of Image 65' from artworks where inv_no = 'TIM-2019-LOI-065' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 4 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-065' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-065', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-066', 'lines-of-image-66', 'Lines of Image 66', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 5, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_66.jpg', 0, 'Lines of Image 66' from artworks where inv_no = 'TIM-2019-LOI-066' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 5 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-066' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-066', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-067', 'lines-of-image-67', 'Lines of Image 67', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 6, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_67.jpg', 0, 'Lines of Image 67' from artworks where inv_no = 'TIM-2019-LOI-067' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 6 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-067' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-067', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-068', 'lines-of-image-68', 'Lines of Image 68', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 7, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_68.jpg', 0, 'Lines of Image 68' from artworks where inv_no = 'TIM-2019-LOI-068' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 7 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-068' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-068', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-069', 'lines-of-image-69', 'Lines of Image 69', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 8, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_69.jpg', 0, 'Lines of Image 69' from artworks where inv_no = 'TIM-2019-LOI-069' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 8 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-069' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-069', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-070', 'lines-of-image-70', 'Lines of Image 70', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 9, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_70.jpg', 0, 'Lines of Image 70' from artworks where inv_no = 'TIM-2019-LOI-070' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 9 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-070' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-070', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-071', 'lines-of-image-71', 'Lines of Image 71', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 10, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_71.jpg', 0, 'Lines of Image 71' from artworks where inv_no = 'TIM-2019-LOI-071' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 10 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-071' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-071', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-072', 'lines-of-image-72', 'Lines of Image 72', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 11, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_72.jpg', 0, 'Lines of Image 72' from artworks where inv_no = 'TIM-2019-LOI-072' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 11 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-072' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-072', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-073', 'lines-of-image-73', 'Lines of Image 73', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 12, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_73.jpg', 0, 'Lines of Image 73' from artworks where inv_no = 'TIM-2019-LOI-073' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 12 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-073' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-073', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-074', 'lines-of-image-74', 'Lines of Image 74', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 13, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_74.jpg', 0, 'Lines of Image 74' from artworks where inv_no = 'TIM-2019-LOI-074' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 13 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-074' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-074', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-075', 'lines-of-image-75', 'Lines of Image 75', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 14, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_75.jpg', 0, 'Lines of Image 75' from artworks where inv_no = 'TIM-2019-LOI-075' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 14 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-075' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-075', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-076', 'lines-of-image-76', 'Lines of Image 76', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 15, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_76.jpg', 0, 'Lines of Image 76' from artworks where inv_no = 'TIM-2019-LOI-076' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 15 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-076' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-076', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-077', 'lines-of-image-77', 'Lines of Image 77', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 16, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_77.jpg', 0, 'Lines of Image 77' from artworks where inv_no = 'TIM-2019-LOI-077' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 16 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-077' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-077', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-078', 'lines-of-image-78', 'Lines of Image 78', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 17, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_78.jpg', 0, 'Lines of Image 78' from artworks where inv_no = 'TIM-2019-LOI-078' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 17 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-078' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-078', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-079', 'lines-of-image-79', 'Lines of Image 79', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 18, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_79.jpg', 0, 'Lines of Image 79' from artworks where inv_no = 'TIM-2019-LOI-079' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 18 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-079' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-079', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-080', 'lines-of-image-80', 'Lines of Image 80', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 19, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_80.jpg', 0, 'Lines of Image 80' from artworks where inv_no = 'TIM-2019-LOI-080' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 19 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-080' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-080', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-081', 'lines-of-image-81', 'Lines of Image 81', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 20, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_81.jpg', 0, 'Lines of Image 81' from artworks where inv_no = 'TIM-2019-LOI-081' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 20 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-081' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-081', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-082', 'lines-of-image-82', 'Lines of Image 82', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 21, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_82.jpg', 0, 'Lines of Image 82' from artworks where inv_no = 'TIM-2019-LOI-082' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 21 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-082' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-082', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-083', 'lines-of-image-83', 'Lines of Image 83', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 22, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_83.jpg', 0, 'Lines of Image 83' from artworks where inv_no = 'TIM-2019-LOI-083' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 22 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-083' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-083', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-084', 'lines-of-image-84', 'Lines of Image 84', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 23, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_84.jpg', 0, 'Lines of Image 84' from artworks where inv_no = 'TIM-2019-LOI-084' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 23 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-084' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-084', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-085', 'lines-of-image-85', 'Lines of Image 85', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 24, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_85.jpg', 0, 'Lines of Image 85' from artworks where inv_no = 'TIM-2019-LOI-085' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 24 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-085' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-085', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-086', 'lines-of-image-86', 'Lines of Image 86', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 25, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_86.jpg', 0, 'Lines of Image 86' from artworks where inv_no = 'TIM-2019-LOI-086' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 25 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-086' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-086', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-087', 'lines-of-image-87', 'Lines of Image 87', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 26, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_87.jpg', 0, 'Lines of Image 87' from artworks where inv_no = 'TIM-2019-LOI-087' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 26 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-087' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-087', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-088', 'lines-of-image-88', 'Lines of Image 88', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 27, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_88.jpg', 0, 'Lines of Image 88' from artworks where inv_no = 'TIM-2019-LOI-088' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 27 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-088' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-088', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-089', 'lines-of-image-89', 'Lines of Image 89', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 28, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_89.jpg', 0, 'Lines of Image 89' from artworks where inv_no = 'TIM-2019-LOI-089' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 28 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-089' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-089', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-090', 'lines-of-image-90', 'Lines of Image 90', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 29, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_90.jpg', 0, 'Lines of Image 90' from artworks where inv_no = 'TIM-2019-LOI-090' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 29 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-090' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-090', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-091', 'lines-of-image-91', 'Lines of Image 91', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 30, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_91.jpg', 0, 'Lines of Image 91' from artworks where inv_no = 'TIM-2019-LOI-091' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 30 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-091' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-091', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-092', 'lines-of-image-92', 'Lines of Image 92', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 31, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_92.jpg', 0, 'Lines of Image 92' from artworks where inv_no = 'TIM-2019-LOI-092' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 31 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-092' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-092', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-093', 'lines-of-image-93', 'Lines of Image 93', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 32, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_93.jpg', 0, 'Lines of Image 93' from artworks where inv_no = 'TIM-2019-LOI-093' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 32 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-093' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-093', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-094', 'lines-of-image-94', 'Lines of Image 94', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 33, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_94.jpg', 0, 'Lines of Image 94' from artworks where inv_no = 'TIM-2019-LOI-094' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 33 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-094' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-094', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-095', 'lines-of-image-95', 'Lines of Image 95', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 34, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_95.jpg', 0, 'Lines of Image 95' from artworks where inv_no = 'TIM-2019-LOI-095' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 34 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-095' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-095', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-096', 'lines-of-image-96', 'Lines of Image 96', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 35, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_96.jpg', 0, 'Lines of Image 96' from artworks where inv_no = 'TIM-2019-LOI-096' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 35 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-096' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-096', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-097', 'lines-of-image-97', 'Lines of Image 97', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 36, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_97.jpg', 0, 'Lines of Image 97' from artworks where inv_no = 'TIM-2019-LOI-097' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 36 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-097' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-097', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-098', 'lines-of-image-98', 'Lines of Image 98', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 37, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_98.jpg', 0, 'Lines of Image 98' from artworks where inv_no = 'TIM-2019-LOI-098' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 37 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-098' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-098', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-099', 'lines-of-image-99', 'Lines of Image 99', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 38, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_99.jpg', 0, 'Lines of Image 99' from artworks where inv_no = 'TIM-2019-LOI-099' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 38 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-099' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-099', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-100', 'lines-of-image-100', 'Lines of Image 100', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 39, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_100.jpg', 0, 'Lines of Image 100' from artworks where inv_no = 'TIM-2019-LOI-100' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 39 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-100' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-100', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-101', 'lines-of-image-101', 'Lines of Image 101', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 40, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_101.jpg', 0, 'Lines of Image 101' from artworks where inv_no = 'TIM-2019-LOI-101' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 40 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-101' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-101', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-102', 'lines-of-image-102', 'Lines of Image 102', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 41, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_102.jpg', 0, 'Lines of Image 102' from artworks where inv_no = 'TIM-2019-LOI-102' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 41 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-102' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-102', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-103', 'lines-of-image-103', 'Lines of Image 103', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 42, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_103.jpg', 0, 'Lines of Image 103' from artworks where inv_no = 'TIM-2019-LOI-103' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 42 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-103' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-103', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-104', 'lines-of-image-104', 'Lines of Image 104', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 43, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_104.jpg', 0, 'Lines of Image 104' from artworks where inv_no = 'TIM-2019-LOI-104' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 43 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-104' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-104', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-105', 'lines-of-image-105', 'Lines of Image 105', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 44, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_105.jpg', 0, 'Lines of Image 105' from artworks where inv_no = 'TIM-2019-LOI-105' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 44 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-105' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-105', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-106', 'lines-of-image-106', 'Lines of Image 106', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 45, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_106.jpg', 0, 'Lines of Image 106' from artworks where inv_no = 'TIM-2019-LOI-106' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 45 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-106' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-106', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-107', 'lines-of-image-107', 'Lines of Image 107', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 46, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_107.jpg', 0, 'Lines of Image 107' from artworks where inv_no = 'TIM-2019-LOI-107' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 46 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-107' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-107', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-108', 'lines-of-image-108', 'Lines of Image 108', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 47, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_108.jpg', 0, 'Lines of Image 108' from artworks where inv_no = 'TIM-2019-LOI-108' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 47 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-108' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-108', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-109', 'lines-of-image-109', 'Lines of Image 109', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 48, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_109.jpg', 0, 'Lines of Image 109' from artworks where inv_no = 'TIM-2019-LOI-109' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 48 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-109' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-109', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-110', 'lines-of-image-110', 'Lines of Image 110', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 49, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_110.jpg', 0, 'Lines of Image 110' from artworks where inv_no = 'TIM-2019-LOI-110' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 49 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-110' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-110', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-111', 'lines-of-image-111', 'Lines of Image 111', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 50, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_111.jpg', 0, 'Lines of Image 111' from artworks where inv_no = 'TIM-2019-LOI-111' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 50 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-111' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-111', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-112', 'lines-of-image-112', 'Lines of Image 112', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 51, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_112.jpg', 0, 'Lines of Image 112' from artworks where inv_no = 'TIM-2019-LOI-112' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 51 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-112' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-112', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-113', 'lines-of-image-113', 'Lines of Image 113', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 52, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_113.jpg', 0, 'Lines of Image 113' from artworks where inv_no = 'TIM-2019-LOI-113' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 52 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-113' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-113', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-114', 'lines-of-image-114', 'Lines of Image 114', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 53, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_114.jpg', 0, 'Lines of Image 114' from artworks where inv_no = 'TIM-2019-LOI-114' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 53 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-114' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-114', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-115', 'lines-of-image-115', 'Lines of Image 115', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 54, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_115.jpg', 0, 'Lines of Image 115' from artworks where inv_no = 'TIM-2019-LOI-115' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 54 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-115' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-115', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-116', 'lines-of-image-116', 'Lines of Image 116', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 55, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_116.jpg', 0, 'Lines of Image 116' from artworks where inv_no = 'TIM-2019-LOI-116' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 55 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-116' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-116', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-117', 'lines-of-image-117', 'Lines of Image 117', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 56, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_117.jpg', 0, 'Lines of Image 117' from artworks where inv_no = 'TIM-2019-LOI-117' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 56 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-117' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-117', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-118', 'lines-of-image-118', 'Lines of Image 118', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 57, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_118.jpg', 0, 'Lines of Image 118' from artworks where inv_no = 'TIM-2019-LOI-118' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 57 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-118' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-118', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-119', 'lines-of-image-119', 'Lines of Image 119', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 58, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_119.jpg', 0, 'Lines of Image 119' from artworks where inv_no = 'TIM-2019-LOI-119' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 58 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-119' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-119', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2019-LOI-120', 'lines-of-image-120', 'Lines of Image 120', null, (select id from series where slug = 'lines-of-image'), 2019, null, null, null, 'available', true, 59, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-image-61-120-2019/Lines_of_Image_120.jpg', 0, 'Lines of Image 120' from artworks where inv_no = 'TIM-2019-LOI-120' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 59 from exhibitions e, artworks a where e.slug = 'lines-of-image-61-120-2019' and a.inv_no = 'TIM-2019-LOI-120' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2019-LOI-120', 'Show has 40 acrylic-and-pen works and 20 drawings; which number is which is not on the page; size not given.') on conflict (inv_no) do update set note = excluded.note;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('lines-of-life-2022', 'Lines of Life', 'লাইনস অফ লাইফ', 'web-show', '2022-11-01', null, 'Online (linesof.life)', null, null, 'The nature of our life is ever changing with time. Humankind as a whole as progressed immensely over time with improved technology, living standards, newer and better inventions etc. Pausing for a moment to think, to look back on our daily activities seems to have become almost obsolete as we dash through life. Lines of Life, condensed using mere white lines on black paper, does not represent predetermined art. It represents the various ordeals I had, the numerous stories that took place and the different emotions like happiness, love, anger, loneliness etc. that stirred up in my day to day life. From my dynamic life, I keep some time for myself every day, accompanied by only pen and paper. There was no thought process regarding what to draw, only my daily acquaintances with life. This came out on paper through miscellaneous lines, exhibited in this web show, Lines of Life.', 'আমাদের জীবনের গতি প্রকৃতি সময়ের সাথে সাথে পরিবর্তনশীল | নানা গল্পের মধ্যদিয়ে ছুটে চলা এই জীবনের অভিজ্ঞতা, উপলব্ধি, শূন্যতা, যন্ত্রনা, ভালোবাসা, ইত্যাদি প্রতিদিনের উপলব্ধি নিয়ে কালো কাগজে সাদা রেখায় অঙ্কিত হয়েছে লাইনস অফ লাইফ শিরোনামে কিছু ছবি
প্রকৃতির কাছ থেকে মানুষ যে অভিজ্ঞতা অর্জন করেছে তা থেকে ক্রমান্বয়ে মানুষ এগিয়ে যাচ্ছে নতুন নতুন আবিস্কারের দিকে | মানুষের জীবন হয়ে উঠেছে টেকনোলজি নির্ভর। প্রচন্ড গতিতে এখন জীবন অতিবাহিত হচ্ছে |
কি ভাবে দিন, মাস ও বছর অতিবাহিত হচ্ছে বোঝা বড় কঠিন হয়ে উঠেছে |
এই গতিময় জীবনের মধ্য থেকে কিছুটা সময় প্রতিদিন নিজের সাথে একান্তভাবে কাটানো চেষ্টা করেছি সাথে কলম ও কাগজ নিয়ে | কি হবে কি আঁকব এমন কোনো চিন্তার বিষয় ছিল না, রেখার নিজস্ব গতি ভঙ্গিমায় সৃষ্ট, সময়ের সাথে সৃষ্টি হওয়া লাইনস অফ লাইফ শিরোনামে কিছু ছবি উপস্থাপিত হচ্ছে |', 'https://www.youtube.com/watch?v=5gDbrKhIH9c', 'webshows/lines-of-life-2022/Banner6th_fb-2.jpg', 'https://linesof.life/6th-solo-web-art-show-07-october-2022/', 'https://linesof.life/6th-solo-web-art-show-07-october-2022/', null, null, true, 6)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-001', 'lines-of-life-2020-001', 'Lines of Life 2020-001', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 0, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_001.jpg', 0, 'Lines of Life 2020-001' from artworks where inv_no = 'TIM-2020-LOL-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 0 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-001' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-002', 'lines-of-life-2020-002', 'Lines of Life 2020-002', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 1, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_002.jpg', 0, 'Lines of Life 2020-002' from artworks where inv_no = 'TIM-2020-LOL-002' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-002' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-003', 'lines-of-life-2020-003', 'Lines of Life 2020-003', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 2, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_003.jpg', 0, 'Lines of Life 2020-003' from artworks where inv_no = 'TIM-2020-LOL-003' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 2 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-003' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-004', 'lines-of-life-2020-004', 'Lines of Life 2020-004', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 3, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_004.jpg', 0, 'Lines of Life 2020-004' from artworks where inv_no = 'TIM-2020-LOL-004' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 3 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-004' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-005', 'lines-of-life-2020-005', 'Lines of Life 2020-005', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 4, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_005.jpg', 0, 'Lines of Life 2020-005' from artworks where inv_no = 'TIM-2020-LOL-005' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 4 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-005' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-006', 'lines-of-life-2020-006', 'Lines of Life 2020-006', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 5, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_006.jpg', 0, 'Lines of Life 2020-006' from artworks where inv_no = 'TIM-2020-LOL-006' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 5 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-006' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-007', 'lines-of-life-2020-007', 'Lines of Life 2020-007', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 6, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_007.jpg', 0, 'Lines of Life 2020-007' from artworks where inv_no = 'TIM-2020-LOL-007' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 6 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-007' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-008', 'lines-of-life-2020-008', 'Lines of Life 2020-008', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 7, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_008.jpg', 0, 'Lines of Life 2020-008' from artworks where inv_no = 'TIM-2020-LOL-008' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 7 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-008' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-009', 'lines-of-life-2020-009', 'Lines of Life 2020-009', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 8, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_009.jpg', 0, 'Lines of Life 2020-009' from artworks where inv_no = 'TIM-2020-LOL-009' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 8 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-009' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-010', 'lines-of-life-2020-010', 'Lines of Life 2020-010', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 9, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_0010.jpg', 0, 'Lines of Life 2020-010' from artworks where inv_no = 'TIM-2020-LOL-010' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 9 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-010' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-011', 'lines-of-life-2020-011', 'Lines of Life 2020-011', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 10, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_0011.jpg', 0, 'Lines of Life 2020-011' from artworks where inv_no = 'TIM-2020-LOL-011' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 10 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-011' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-012', 'lines-of-life-2020-012', 'Lines of Life 2020-012', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 11, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_0012.jpg', 0, 'Lines of Life 2020-012' from artworks where inv_no = 'TIM-2020-LOL-012' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 11 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-012' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-013', 'lines-of-life-2020-013', 'Lines of Life 2020-013', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 12, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_0013.jpg', 0, 'Lines of Life 2020-013' from artworks where inv_no = 'TIM-2020-LOL-013' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 12 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-013' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-014', 'lines-of-life-2020-014', 'Lines of Life 2020-014', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 13, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_0014.jpg', 0, 'Lines of Life 2020-014' from artworks where inv_no = 'TIM-2020-LOL-014' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 13 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-014' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-015', 'lines-of-life-2020-015', 'Lines of Life 2020-015', null, (select id from series where slug = 'lines-of-life'), 2020, 'White pen on black paper', 40.6, 30.5, 'available', true, 14, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/Lines_of_life-2020_0015.jpg', 0, 'Lines of Life 2020-015' from artworks where inv_no = 'TIM-2020-LOL-015' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 14 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-015' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-016', 'lines-of-life-3002-2020', 'Lines of Life, 3002-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 15, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/3002-2020.jpg', 0, 'Lines of Life, 3002-2020' from artworks where inv_no = 'TIM-2020-LOL-016' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 15 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-016' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-016', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-017', 'lines-of-life-28-07-2020', 'Lines of Life, 28-07-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 16, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/28-07-2020.png', 0, 'Lines of Life, 28-07-2020' from artworks where inv_no = 'TIM-2020-LOL-017' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 16 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-017' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-017', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-018', 'lines-of-life-27-07-2020', 'Lines of Life, 27-07-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 17, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/27-07-2020.jpg', 0, 'Lines of Life, 27-07-2020' from artworks where inv_no = 'TIM-2020-LOL-018' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 17 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-018' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-018', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-019', 'lines-of-life-24-07-2020', 'Lines of Life, 24-07-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 18, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/24-07-2020.jpg', 0, 'Lines of Life, 24-07-2020' from artworks where inv_no = 'TIM-2020-LOL-019' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 18 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-019' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-019', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-020', 'lines-of-life-18-07-2020', 'Lines of Life, 18-07-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 19, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/18-07-2020.jpg', 0, 'Lines of Life, 18-07-2020' from artworks where inv_no = 'TIM-2020-LOL-020' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 19 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-020' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-020', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-021', 'lines-of-life-17-08-2020', 'Lines of Life, 17-08-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 20, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/17-08-2020.jpg', 0, 'Lines of Life, 17-08-2020' from artworks where inv_no = 'TIM-2020-LOL-021' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 20 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-021' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-021', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-022', 'lines-of-life-15-08-2020', 'Lines of Life, 15-08-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 21, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/15-08-2020.jpg', 0, 'Lines of Life, 15-08-2020' from artworks where inv_no = 'TIM-2020-LOL-022' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 21 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-022' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-022', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-023', 'lines-of-life-14-08-2020', 'Lines of Life, 14-08-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 22, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/14-08-2020.jpg', 0, 'Lines of Life, 14-08-2020' from artworks where inv_no = 'TIM-2020-LOL-023' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 22 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-023' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-023', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2022-LOL-001', 'lines-of-life-12-08-2022', 'Lines of Life, 12-08-2022', null, (select id from series where slug = 'lines-of-life'), 2022, 'Pen on paper', 40.6, 30.5, 'available', false, 23, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/12-08-2022.jpg', 0, 'Lines of Life, 12-08-2022' from artworks where inv_no = 'TIM-2022-LOL-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 23 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2022-LOL-001' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2022-LOL-001', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-024', 'lines-of-life-12-07-2020', 'Lines of Life, 12-07-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 24, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/12-07-2020.jpg', 0, 'Lines of Life, 12-07-2020' from artworks where inv_no = 'TIM-2020-LOL-024' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 24 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-024' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-024', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-025', 'lines-of-life-10-08-2020', 'Lines of Life, 10-08-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 25, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/10-08-2020.jpg', 0, 'Lines of Life, 10-08-2020' from artworks where inv_no = 'TIM-2020-LOL-025' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 25 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-025' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-025', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-026', 'lines-of-life-10-07-2020', 'Lines of Life, 10-07-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 26, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/10-07-2020.jpg', 0, 'Lines of Life, 10-07-2020' from artworks where inv_no = 'TIM-2020-LOL-026' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 26 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-026' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-026', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-027', 'lines-of-life-06-08-2020', 'Lines of Life, 06-08-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 27, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/06-08-2020.jpg', 0, 'Lines of Life, 06-08-2020' from artworks where inv_no = 'TIM-2020-LOL-027' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 27 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-027' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-027', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-028', 'lines-of-life-02-08-2020', 'Lines of Life, 02-08-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 28, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/02-08-2020.jpg', 0, 'Lines of Life, 02-08-2020' from artworks where inv_no = 'TIM-2020-LOL-028' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 28 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-028' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-028', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2020-LOL-029', 'lines-of-life-01-08-2020', 'Lines of Life, 01-08-2020', null, (select id from series where slug = 'lines-of-life'), 2020, 'Pen on paper', 40.6, 30.5, 'available', false, 29, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/lines-of-life-2022/01-08-2020.jpg', 0, 'Lines of Life, 01-08-2020' from artworks where inv_no = 'TIM-2020-LOL-029' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 29 from exhibitions e, artworks a where e.slug = 'lines-of-life-2022' and a.inv_no = 'TIM-2020-LOL-029' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2020-LOL-029', 'Second image set on the page (titled by date); may be the same 15 works as the square images; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('metamorphosis-of-hues-2023', 'Metamorphosis of Hues', 'রঙের রূপান্তর', 'web-show', '2023-11-25', null, 'Online (linesof.life)', null, null, 'Greetings, art enthusiasts, and welcome to the digital realm where colors breathe, lines dance, and emotions find their voice. It is with immense pleasure and excitement that I extend an invitation to you for my 7th Solo Web Art Exhibition, “Metamorphosis of Hues,” set to unfold on the virtual canvas on November 25, 2023.
In this digital expanse, I invite you to witness the evolving tapestry of life—captured, celebrated, and immortalized through the brushstrokes of my artistic expression. “Metamorphosis of Hues” encapsulates the essence of time’s inexorable journey, a visual narrative of the myriad small stories that weave the fabric of our lives.
Every canvas in this collection serves as a testament to the ever-changing nature of existence. Each stroke of acrylic is a brush with the passage of time, and every line etched onto the canvas is a poetic dance of emotions. In the rhythm of everyday life, I have sought to encapsulate the diverse feelings and experiences that color our existence, creating a symphony of visual poetry that resonates with the soul.
The choice of acrylic as my medium is intentional—a vibrant and versatile vehicle that allows me to articulate the vibrancy of life itself. A pen, with its delicate precision, becomes my storyteller, adding layers of intricacy to the narrative. Across 34 paintings, the white pen emerges as a subtle yet powerful tool, embellishing select canvases with whispers of ethereal beauty.
This web exhibition is more than a showcase; it is an interactive voyage into the heart of emotions, an exploration of the subtle nuances that define the human experience. As you navigate through the digital gallery, I invite you to immerse yourself in the stories behind each canvas, unraveling the tales that unfold with every stroke and every shade.
“Metamorphosis of Hues” is not just an exhibition; it is a conversation—a dialogue between the artist and the audience, between colors and emotions. Thank you for being a part of this journey, and may this digital sojourn into the world of art leave an indelible imprint on your senses.', null, 'https://www.youtube.com/watch?v=ptTnGhrW0V0', 'webshows/metamorphosis-of-hues-2023/Banner7th_fb-3.jpg', 'https://linesof.life/7th-solo-web-art-show-25-november-2023/', 'https://linesof.life/7th-solo-web-art-show-25-november-2023/', null, null, true, 7)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-001', 'lines-of-color-024', 'Lines of Color-024', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 0, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-001.jpg', 0, 'Lines of Color-024' from artworks where inv_no = 'TIM-2023-MOH-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 0 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-001' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-002', 'lines-of-color-image-002', 'Lines of Color (image 002)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 1, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-002.jpg', 0, 'Lines of Color (image 002)' from artworks where inv_no = 'TIM-2023-MOH-002' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-002' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-002', 'Image file is "Framing-002"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-003', 'lines-of-color-image-003', 'Lines of Color (image 003)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 2, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-003.jpg', 0, 'Lines of Color (image 003)' from artworks where inv_no = 'TIM-2023-MOH-003' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 2 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-003' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-003', 'Image file is "Framing-003"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-004', 'lines-of-color-image-004', 'Lines of Color (image 004)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 3, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-004.jpg', 0, 'Lines of Color (image 004)' from artworks where inv_no = 'TIM-2023-MOH-004' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 3 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-004' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-004', 'Image file is "Framing-004"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-005', 'lines-of-color-image-005', 'Lines of Color (image 005)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 4, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-005.jpg', 0, 'Lines of Color (image 005)' from artworks where inv_no = 'TIM-2023-MOH-005' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 4 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-005' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-005', 'Image file is "Framing-005"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-006', 'lines-of-color-017', 'Lines of Color-017', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 5, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-006.jpg', 0, 'Lines of Color-017' from artworks where inv_no = 'TIM-2023-MOH-006' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 5 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-006' on conflict do nothing;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-007', 'lines-of-color-image-007', 'Lines of Color (image 007)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 6, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-007.jpg', 0, 'Lines of Color (image 007)' from artworks where inv_no = 'TIM-2023-MOH-007' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 6 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-007' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-007', 'Image file is "Framing-007"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-008', 'lines-of-color-image-008', 'Lines of Color (image 008)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 7, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-008.jpg', 0, 'Lines of Color (image 008)' from artworks where inv_no = 'TIM-2023-MOH-008' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 7 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-008' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-008', 'Image file is "Framing-008"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-009', 'lines-of-color-image-009', 'Lines of Color (image 009)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 8, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-009.jpg', 0, 'Lines of Color (image 009)' from artworks where inv_no = 'TIM-2023-MOH-009' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 8 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-009' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-009', 'Image file is "Framing-009"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-010', 'lines-of-color-image-010', 'Lines of Color (image 010)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 9, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-010.jpg', 0, 'Lines of Color (image 010)' from artworks where inv_no = 'TIM-2023-MOH-010' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 9 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-010' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-010', 'Image file is "Framing-010"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-011', 'lines-of-color-image-011', 'Lines of Color (image 011)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 10, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-011.jpg', 0, 'Lines of Color (image 011)' from artworks where inv_no = 'TIM-2023-MOH-011' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 10 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-011' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-011', 'Image file is "Framing-011"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-012', 'lines-of-color-image-012', 'Lines of Color (image 012)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 11, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-012.jpg', 0, 'Lines of Color (image 012)' from artworks where inv_no = 'TIM-2023-MOH-012' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 11 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-012' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-012', 'Image file is "Framing-012"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-013', 'lines-of-color-image-013', 'Lines of Color (image 013)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 12, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-013.jpg', 0, 'Lines of Color (image 013)' from artworks where inv_no = 'TIM-2023-MOH-013' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 12 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-013' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-013', 'Image file is "Framing-013"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-014', 'lines-of-color-image-014', 'Lines of Color (image 014)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 13, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-014.jpg', 0, 'Lines of Color (image 014)' from artworks where inv_no = 'TIM-2023-MOH-014' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 13 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-014' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-014', 'Image file is "Framing-014"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-015', 'lines-of-color-image-015', 'Lines of Color (image 015)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 14, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-015.jpg', 0, 'Lines of Color (image 015)' from artworks where inv_no = 'TIM-2023-MOH-015' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 14 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-015' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-015', 'Image file is "Framing-015"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-016', 'lines-of-color-image-016', 'Lines of Color (image 016)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 15, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-016.jpg', 0, 'Lines of Color (image 016)' from artworks where inv_no = 'TIM-2023-MOH-016' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 15 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-016' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-016', 'Image file is "Framing-016"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-017', 'lines-of-color-image-017', 'Lines of Color (image 017)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 16, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-017.jpg', 0, 'Lines of Color (image 017)' from artworks where inv_no = 'TIM-2023-MOH-017' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 16 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-017' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-017', 'Image file is "Framing-017"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-018', 'lines-of-color-image-018', 'Lines of Color (image 018)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 17, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-018.jpg', 0, 'Lines of Color (image 018)' from artworks where inv_no = 'TIM-2023-MOH-018' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 17 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-018' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-018', 'Image file is "Framing-018"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-019', 'lines-of-color-image-019', 'Lines of Color (image 019)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 18, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-019.jpg', 0, 'Lines of Color (image 019)' from artworks where inv_no = 'TIM-2023-MOH-019' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 18 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-019' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-019', 'Image file is "Framing-019"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-020', 'lines-of-color-image-020', 'Lines of Color (image 020)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 19, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-020.jpg', 0, 'Lines of Color (image 020)' from artworks where inv_no = 'TIM-2023-MOH-020' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 19 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-020' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-020', 'Image file is "Framing-020"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-021', 'lines-of-color-image-021', 'Lines of Color (image 021)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 20, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-021.jpg', 0, 'Lines of Color (image 021)' from artworks where inv_no = 'TIM-2023-MOH-021' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 20 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-021' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-021', 'Image file is "Framing-021"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-022', 'lines-of-color-image-022', 'Lines of Color (image 022)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 21, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-022.jpg', 0, 'Lines of Color (image 022)' from artworks where inv_no = 'TIM-2023-MOH-022' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 21 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-022' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-022', 'Image file is "Framing-022"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-023', 'lines-of-color-image-023', 'Lines of Color (image 023)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 22, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-023.jpg', 0, 'Lines of Color (image 023)' from artworks where inv_no = 'TIM-2023-MOH-023' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 22 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-023' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-023', 'Image file is "Framing-023"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-024', 'lines-of-color-image-024', 'Lines of Color (image 024)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 23, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-024.jpg', 0, 'Lines of Color (image 024)' from artworks where inv_no = 'TIM-2023-MOH-024' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 23 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-024' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-024', 'Image file is "Framing-024"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-025', 'lines-of-color-image-025', 'Lines of Color (image 025)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 24, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-025.jpg', 0, 'Lines of Color (image 025)' from artworks where inv_no = 'TIM-2023-MOH-025' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 24 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-025' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-025', 'Image file is "Framing-025"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-026', 'lines-of-color-image-026', 'Lines of Color (image 026)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 25, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-026.jpg', 0, 'Lines of Color (image 026)' from artworks where inv_no = 'TIM-2023-MOH-026' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 25 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-026' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-026', 'Image file is "Framing-026"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-027', 'lines-of-color-image-027', 'Lines of Color (image 027)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 26, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-027.jpg', 0, 'Lines of Color (image 027)' from artworks where inv_no = 'TIM-2023-MOH-027' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 26 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-027' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-027', 'Image file is "Framing-027"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-028', 'lines-of-color-image-028', 'Lines of Color (image 028)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 27, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-028.jpg', 0, 'Lines of Color (image 028)' from artworks where inv_no = 'TIM-2023-MOH-028' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 27 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-028' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-028', 'Image file is "Framing-028"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-029', 'lines-of-color-image-029', 'Lines of Color (image 029)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 28, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-029.jpg', 0, 'Lines of Color (image 029)' from artworks where inv_no = 'TIM-2023-MOH-029' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 28 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-029' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-029', 'Image file is "Framing-029"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-030', 'lines-of-color-image-030', 'Lines of Color (image 030)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 29, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-030.jpg', 0, 'Lines of Color (image 030)' from artworks where inv_no = 'TIM-2023-MOH-030' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 29 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-030' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-030', 'Image file is "Framing-030"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-031', 'lines-of-color-image-031', 'Lines of Color (image 031)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 30, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-031.jpg', 0, 'Lines of Color (image 031)' from artworks where inv_no = 'TIM-2023-MOH-031' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 30 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-031' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-031', 'Image file is "Framing-031"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-032', 'lines-of-color-image-032', 'Lines of Color (image 032)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 31, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-032.jpg', 0, 'Lines of Color (image 032)' from artworks where inv_no = 'TIM-2023-MOH-032' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 31 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-032' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-032', 'Image file is "Framing-032"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-033', 'lines-of-color-image-033', 'Lines of Color (image 033)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 32, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-033.jpg', 0, 'Lines of Color (image 033)' from artworks where inv_no = 'TIM-2023-MOH-033' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 32 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-033' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-033', 'Image file is "Framing-033"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2023-MOH-034', 'lines-of-color-image-034', 'Lines of Color (image 034)', null, (select id from series where slug = 'lines-of-color'), null, 'Acrylic and pen on canvas', 40.6, 35.6, 'available', true, 33, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/metamorphosis-of-hues-2023/Framing-034.jpg', 0, 'Lines of Color (image 034)' from artworks where inv_no = 'TIM-2023-MOH-034' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 33 from exhibitions e, artworks a where e.slug = 'metamorphosis-of-hues-2023' and a.inv_no = 'TIM-2023-MOH-034' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2023-MOH-034', 'Image file is "Framing-034"; which "Lines of Color" number it shows is not on the page; years 2015–2023 per the page list; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('dhaka-london-2024', '21 Contemporary Artists: Dhaka–London 2024 (15th London Bangla Book Fair & Art Exhibition)', '২১ সমসাময়িক শিল্পী: ঢাকা–লন্ডন ২০২৪', 'group', '2024-11-09', '2024-11-10', 'The Town Hall, Tower Hamlets', 'London', 'United Kingdom', 'The first show conducted by the 21 Artists Group on September 20–28, 2024, marked a milestone in their journey at Zainul Gallery-1, Faculty of Fine Arts, Dhaka University. This exhibition serves as a stepping stone to the next chapter in their creative journey, with plans to showcase their work both locally and abroad. In their collective vision, contemporary artists from Dhaka—making their debut in the art market—view art as a force that shapes society and culture, portraying experiences that capture the meaning of our time while offering hope to future generations.

To the 21 Artists Group, art is a language used to convey the vitality of a nation and its history, both past and present. Art also provides new ways of seeing and connecting to the environment, serving as a vehicle for unearthing many of the truths relevant to our time. Armed with a wide array of artistic talent, these artists work with brushstrokes, color, and texture to express aspects of themselves that cannot be conveyed except through paper or canvas.

The 21 Artists Group will host its second exhibition in London at the Town Hall, Tower Hamlets, on November 9 and 10, 2024. This event will run concurrently with the Bangla Book Fair at Capital Hill, where each artist will showcase two new works, extending their artistic endeavors across borders. This collaboration on the London exhibition is a testament to their dedication to expanding the reach and influence of their art in the global discourse.', null, null, 'webshows/dhaka-london-2024/Tower-hamlet-15-books-banner-.jpeg', 'https://linesof.life/dhaka-london-group-art-exhibition-2024/', 'https://linesof.life/dhaka-london-group-art-exhibition-2024/', null, null, true, 8)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2024-DL-001', 'tales-of-the-ancients-1', 'Tales of the Ancients 1', null, null, 2024, 'Acrylic and pen on canvas', 55.9, 38.1, 'available', true, 0, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/dhaka-london-2024/Mithu-01.jpg', 0, 'Tales of the Ancients 1' from artworks where inv_no = 'TIM-2024-DL-001' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 0 from exhibitions e, artworks a where e.slug = 'dhaka-london-2024' and a.inv_no = 'TIM-2024-DL-001' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2024-DL-001', 'Matching of image to title assumed by order; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2024-DL-002', 'tales-of-the-ancients-2', 'Tales of the Ancients 2', null, null, 2024, 'Acrylic and pen on canvas', 55.9, 38.1, 'available', true, 1, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/dhaka-london-2024/Mithu-02.jpeg', 0, 'Tales of the Ancients 2' from artworks where inv_no = 'TIM-2024-DL-002' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 1 from exhibitions e, artworks a where e.slug = 'dhaka-london-2024' and a.inv_no = 'TIM-2024-DL-002' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2024-DL-002', 'Matching of image to title assumed by order; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ('TIM-2024-DL-003', 'tales-of-the-ancients-3', 'Tales of the Ancients 3', null, null, 2024, 'Acrylic and pen on canvas', 55.9, 38.1, 'available', true, 2, null)
on conflict (inv_no) do nothing;
insert into artwork_images (artwork_id, path, sort, alt_en) select id, 'webshows/dhaka-london-2024/Mithu-03.jpeg', 0, 'Tales of the Ancients 3' from artworks where inv_no = 'TIM-2024-DL-003' and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);
insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, 2 from exhibitions e, artworks a where e.slug = 'dhaka-london-2024' and a.inv_no = 'TIM-2024-DL-003' on conflict do nothing;
insert into import_notes (inv_no, note) values ('TIM-2024-DL-003', 'Matching of image to title assumed by order; confirm.') on conflict (inv_no) do update set note = excluded.note;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('21-artists-dhaka-2024', '21 Artists Group: first exhibition', '২১ শিল্পী দল: প্রথম প্রদর্শনী', 'group', '2024-09-20', '2024-09-28', 'Zainul Gallery-1, Faculty of Fine Arts, University of Dhaka', 'Dhaka', 'Bangladesh', null, null, null, null, 'https://linesof.life/dhaka-london-group-art-exhibition-2024/', 'https://linesof.life/dhaka-london-group-art-exhibition-2024/', null, null, true, 9)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ('first-solo-2001', 'First solo exhibition', 'প্রথম একক প্রদর্শনী', 'solo', '2001-01-01', null, 'Zainul Gallery, Faculty of Fine Arts, University of Dhaka', 'Dhaka', 'Bangladesh', null, null, null, null, null, null, null, null, true, 10)
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;
