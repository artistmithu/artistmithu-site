# Generates SQL that imports the web-show archive (shows.json) into exhibitions, artworks, images and exhibition_works.
# Safe to re-run: rows are matched by slug / inv_no.
import json, re, sys, os
S = json.load(open(sys.argv[1]))["shows"]
q = lambda v: "null" if v is None else "'" + str(v).replace("'", "''") + "'"
num = lambda v: "null" if v is None else str(v)
slugify = lambda t: re.sub(r"[^a-z0-9]+", "-", t.lower()).strip("-")
rel = lambda p: os.path.relpath(p, "/mnt/project-files/archive/") if p else None

NEW_SERIES = [  # slug, title_en, title_bn, sort
  ("transparent-boundary", "Transparent Boundary", "স্বচ্ছ সীমানা", 5),
  ("expression-of-color-and-line", "Expression of Color and Line", "রঙ ও রেখার অভিব্যক্তি", 6),
  ("ramadan-lines", "Ramadan Lines", "রমজানের রেখা", 7),
  ("lines-of-image", "Lines of Image", "লাইনস অফ ইমেজ", 8),
  ("lines-of-color", "Lines of Color", "রঙের রেখা", 9),
]
def series_for(show, w):
  s = (w["series"] or "")
  if show == "transparent-boundary-2013": return "transparent-boundary"
  if s.startswith("Jonogon") or s.startswith("Lines of Life"): return "lines-of-life"
  if s.startswith("Expression"): return "expression-of-color-and-line"
  if s.startswith("Ramadan"): return "ramadan-lines"
  if s.startswith("Lines of Image"): return "lines-of-image"
  if s.startswith("Lines of Color"): return "lines-of-color"
  return None
CODE = {"transparent-boundary-2013": "TB", "expression-of-color-and-line-2014": "ECL", "lines-of-life-2014": "LOL", "ramadan-lines-2018": "RL",
        "lines-of-image-2019": "LOI", "lines-of-image-61-120-2019": "LOI", "lines-of-life-2022": "LOL", "metamorphosis-of-hues-2023": "MOH", "dhaka-london-2024": "DL"}

out = ["begin;"]
for slug, en, bn, sort in NEW_SERIES:
  out.append(f"insert into series (slug, title_en, title_bn, chapter, sort) values ({q(slug)}, {q(en)}, {q(bn)}, {q(en)}, {sort}) on conflict (slug) do nothing;")

used_slugs, counters = set(), {}
for i, s in enumerate(S):
  yt = s["youtube_url"][0] if isinstance(s["youtube_url"], list) else s["youtube_url"]
  desc = "\n\n".join(x for x in [s.get("claim"), s.get("testimonial") if isinstance(s.get("testimonial"), str) else None] if x)
  cover = rel(s["cover"])
  fixd = lambda d: d + "-01-01" if d and len(d) == 4 else d  # year-only dates; the site shows just the year for 1 January
  out.append(f"""insert into exhibitions (slug, title, title_bn, kind, start_date, end_date, venue, city, country, statement_en, statement_bn, youtube_url, cover_path, original_url, url, wayback_url, description, published, sort)
values ({q(s['slug'])}, {q(s['title_en'])}, {q(s['title_bn'])}, {q(s['kind'])}, {q(fixd(s['start_date']))}, {q(fixd(s['end_date']))}, {q(s['venue'])}, {q(s['city'])}, {q(s['country'])}, {q(s['statement_en'])}, {q(s['statement_bn'])}, {q(yt)}, {q(cover)}, {q(s['original_url'])}, {q(s['original_url'])}, {q(s['wayback_url'])}, {q(desc or None)}, true, {i})
on conflict (slug) do update set title = excluded.title, title_bn = excluded.title_bn, kind = excluded.kind, start_date = excluded.start_date, end_date = excluded.end_date, venue = excluded.venue, city = excluded.city, country = excluded.country, statement_en = excluded.statement_en, statement_bn = excluded.statement_bn, youtube_url = excluded.youtube_url, cover_path = excluded.cover_path, original_url = excluded.original_url;""")
  for j, w in enumerate(s["works"]):
    code = CODE[s["slug"]]; yr = w["year"] or (s["start_date"] or "0000")[:4]
    key = (code, yr); counters[key] = counters.get(key, 0) + 1
    inv = f"TIM-{yr}-{code}-{counters[key]:03d}"
    base = slugify(w["title_en"]) or slugify(inv); ws = base; k = 2
    while ws in used_slugs: ws = f"{base}-{k}"; k += 1
    used_slugs.add(ws)
    notes = w["notes"] or ""
    # Hold back works that may duplicate others: the second image set of the 2022 show and the Jonogon drawings
    # (the site already has 38 Janogon drawings from artistmithu.com). Everything else is published.
    draft = notes.startswith("Second image set") or (w["series"] or "").startswith("Jonogon")
    sr = series_for(s["slug"], w)
    desc = None
    out.append(f"""insert into artworks (inv_no, slug, title_en, title_bn, series_id, year, medium, height_cm, width_cm, status, published, sort, description_en)
values ({q(inv)}, {q(ws)}, {q(w['title_en'])}, {q(w['title_bn'])}, {f"(select id from series where slug = {q(sr)})" if sr else "null"}, {num(w['year'])}, {q(w['medium'])}, {num(w['height_cm'])}, {num(w['width_cm'])}, 'available', {'false' if draft else 'true'}, {j}, null)
on conflict (inv_no) do nothing;""")
    out.append(f"insert into artwork_images (artwork_id, path, sort, alt_en) select id, {q(rel(w['image']))}, 0, {q(w['title_en'])} from artworks where inv_no = {q(inv)} and not exists (select 1 from artwork_images i where i.artwork_id = artworks.id);")
    out.append(f"insert into exhibition_works (exhibition_id, artwork_id, sort) select e.id, a.id, {j} from exhibitions e, artworks a where e.slug = {q(s['slug'])} and a.inv_no = {q(inv)} on conflict do nothing;")
    if notes: out.append(f"insert into import_notes (inv_no, note) values ({q(inv)}, {q(notes)}) on conflict (inv_no) do update set note = excluded.note;")
out.append("commit;")
print("\n".join(out))
