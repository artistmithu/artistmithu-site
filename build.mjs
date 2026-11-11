// Static site generator for artistmithu.com.
// Reads the catalogue from Supabase at build time and writes plain HTML to ./dist.
// Cloudflare Pages: build command `npm run build`, output directory `dist`.
import { mkdir, writeFile, cp, rm } from "node:fs/promises";
import { dirname, join } from "node:path";

const SUPABASE_URL = process.env.SUPABASE_URL || "https://msbgnvltxoxrnvuriiez.supabase.co";
// Publishable key: safe to ship in the browser; row level security protects the data.
const SUPABASE_KEY = process.env.SUPABASE_PUBLISHABLE_KEY || "sb_publishable_vxt7vC2yHGGhMON90ZFnBw_PehR5Qod";
// Public address used in share previews (Facebook reads og:url and goes there), canonical links and the sitemap.
// Set SITE_URL to https://artistmithu.com in the Cloudflare build settings once the domain points at this site.
const SITE = (process.env.SITE_URL || "https://artistmithu-site.artistmithu.workers.dev").replace(/\/$/, "");
const WHATSAPP = process.env.WHATSAPP_NUMBER || "8801714133725"; // studio WhatsApp, from the artist's portfolio
const OUT = "dist";
const BUILD = Date.now().toString(36); // added to asset URLs so browsers fetch fresh CSS/JS after each publish

const api = async (path) => {
  const r = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    headers: { apikey: SUPABASE_KEY, Authorization: `Bearer ${SUPABASE_KEY}` },
  });
  if (!r.ok) throw new Error(`${path}: ${r.status} ${await r.text()}`);
  return r.json();
};
const img = (p) => `${SUPABASE_URL}/storage/v1/object/public/artworks/${p}`;
const esc = (s) => String(s ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
const inch = (cm) => (cm / 2.54).toFixed(1);
const fmtBDT = (n) => "৳ " + Number(n).toLocaleString("en-IN");
const fmtUSD = (n) => "US$ " + Number(n).toLocaleString("en-US");
const fmtBDTn = (n) => Number(n).toLocaleString("en-IN");
const fmtUSDn = (n) => Number(n).toLocaleString("en-US");

// FIXTURE=path.json builds from a saved snapshot instead of Supabase (for offline testing).
const fx = process.env.FIXTURE ? JSON.parse(await (await import("node:fs/promises")).readFile(process.env.FIXTURE, "utf8")) : null;
const [series, works, images, exhibitions] = fx ? [fx.series, fx.works, fx.images, fx.exhibitions || []] : await Promise.all([
  api("series?select=*&order=sort"),
  api("artworks_public?select=*&order=sort,year"),
  api("artwork_images?select=artwork_id,path,kind,alt_en,width,height,sort&order=sort"),
  api("exhibitions?select=*&order=start_date.desc.nullslast").catch(() => []),
]);
// YouTube channel index (data/videos.json, collected from youtube.com/@artistmithu).
const VID = JSON.parse(await (await import("node:fs/promises")).readFile("data/videos.json", "utf8"));
const showLinks = fx ? fx.exhibition_works || [] : await api("exhibition_works?select=*&order=sort").catch(() => []);
// About / CV text, studio photos and journal posts (edited in admin). Missing tables just mean empty sections.
const [contentRows, studio, posts] = fx ? [fx.site_content || [], fx.studio_photos || [], fx.posts || []] : await Promise.all([
  api("site_content?select=*").catch(() => []),
  api("studio_photos?select=*&order=sort,created_at").catch(() => []),
  api("posts?select=*&published=eq.true&order=published_at.desc").catch(() => []),
]);
const C = Object.fromEntries(contentRows.map((r) => [r.key, r]));
// Sketchbooks: whole books shown page by page.
const [books, bookPages] = fx ? [fx.sketchbooks || [], fx.sketchbook_pages || []] : await Promise.all([
  api("sketchbooks?select=*&published=eq.true&order=sort").catch(() => []),
  api("sketchbook_pages?select=sketchbook_id,path,page_no,caption_en,caption_bn&hidden=eq.false&order=page_no").catch(() => []),
]);
const pagesOf = (b) => bookPages.filter((p) => p.sketchbook_id === b.id);
const booksShown = () => books.filter((b) => pagesOf(b).length);
const paras = (t) => esc(t || "").split(/\n\s*\n/).filter((x) => x.trim()).map((x) => `<p>${x.trim().replace(/\n/g, "<br>")}</p>`).join("");
const lines = (t) => esc(t || "").split(/\n/).map((x) => x.trim()).filter(Boolean);
// Text in both languages: shows the Bangla only if it was written, otherwise the English for both.
const biText = (r, fmt) => !r ? "" : r.bn && r.bn.trim() && r.en ? `<div lang="en">${fmt(r.en)}</div><div lang="bn">${fmt(r.bn)}</div>` : fmt(r.en || r.bn);
const biList = (r) => biText(r, (t) => `<ul class="cv">${lines(t).map((l) => `<li>${l}</li>`).join("")}</ul>`);
const seriesById = Object.fromEntries(series.map((s) => [s.id, s]));
for (const w of works) {
  w.images = images.filter((i) => i.artwork_id === w.id);
  w.series = seriesById[w.series_id] || null;
}
console.log(`Building ${works.length} works, ${series.length} chapters`);

const STATUS = { available: ["Available", "উপলব্ধ"], reserved: ["Reserved", "সংরক্ষিত"], sold: ["Sold", "বিক্রিত"], nfs: ["Not for sale", "বিক্রির জন্য নয়"] };
const SIZE = { small: ["Small", "ছোট"], medium: ["Medium", "মাঝারি"], large: ["Large", "বড়"] };
const bi = ([en, bn]) => `<span lang="en">${en}</span><span lang="bn">${bn}</span>`;

const sizeText = (w) => (w.height_cm && w.width_cm ? `${+w.height_cm} × ${+w.width_cm} cm <small>(${inch(w.height_cm)} × ${inch(w.width_cm)} in)</small>` : bi(["Size on request", "মাপ জানতে যোগাযোগ"]));
// Price display. Bangla shows taka first, English shows dollars first. No automatic currency conversion:
// each currency appears only if the artist entered it.
const mode = (w) => (w.price_mode ? w.price_mode : w.price_bdt ? "fixed" : "on_request");
const amount = (min, max, fmtN, sym, isRange) => (min == null ? "" : isRange && max ? `${sym}${fmtN(min)}–${fmtN(max)}` : `${sym}${fmtN(min)}`);
function priceText(w, { note = false } = {}) {
  if (w.status === "sold" || w.status === "nfs") return "";
  const m = mode(w);
  if (m === "on_request" || (w.price_bdt == null && w.price_usd == null)) return bi(["Price on request", "দাম জানতে যোগাযোগ"]);
  const r = m === "range";
  const bdt = amount(w.price_bdt, w.price_bdt_max, fmtBDTn, "৳ ", r);
  const usd = amount(w.price_usd, w.price_usd_max, fmtUSDn, "US$ ", r);
  const en = [usd, bdt].filter(Boolean).join(" · ");
  const bn = [bdt, usd].filter(Boolean).join(" · ");
  const ship = note ? `<small class="ship">${bi(["Framing and international shipping quoted separately.", "ফ্রেম ও বিদেশে পাঠানোর খরচ আলাদা।"])}</small>` : "";
  return bi([en, bn]) + ship;
}

function page({ title, desc, path, body, image, imageW, imageH, imageAlt, ogType = "website", jsonld, bare = false }) {
  const url = SITE + path;
  return `<!doctype html>
<html lang="en" data-lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>${esc(title)}</title>
<meta name="description" content="${esc(desc)}">
<link rel="canonical" href="${url}">
<meta property="og:type" content="${ogType}"><meta property="og:site_name" content="Artistmithu: Tanvirul Islam Mithu"><meta property="og:title" content="${esc(title)}">
<meta property="og:description" content="${esc(desc)}"><meta property="og:url" content="${url}">
${image ? `<meta property="og:image" content="${image}"><meta property="og:image:secure_url" content="${image}">${imageW ? `<meta property="og:image:width" content="${imageW}"><meta property="og:image:height" content="${imageH}">` : ""}<meta property="og:image:alt" content="${esc(imageAlt || title)}"><meta name="twitter:card" content="summary_large_image"><meta name="twitter:title" content="${esc(title)}"><meta name="twitter:description" content="${esc(desc)}"><meta name="twitter:image" content="${image}">` : ""}
<link rel="manifest" href="/manifest.webmanifest"><meta name="theme-color" content="#18203a">
<link rel="icon" href="/assets/logo.jpg" type="image/jpeg"><link rel="apple-touch-icon" href="/assets/logo.jpg">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anek+Bangla:wght@300;500;700;800&family=Hind+Siliguri:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500&display=swap">
<link rel="stylesheet" href="/assets/site.css?v=${BUILD}">
${jsonld ? `<script type="application/ld+json">${JSON.stringify(jsonld)}</script>` : ""}
</head>
<body>
<header class="top"><div class="wrap">
  ${bare ? `<span class="brand"><img src="/assets/logo.jpg" alt="" width="44" height="44"><span>Artistmithu<small>${bi(["Tanvirul Islam Mithu", "তানভীরুল ইসলাম মিঠু"])}</small></span></span>` : `<a class="brand" href="/"><img src="/assets/logo.jpg" alt="" width="44" height="44"><span>Artistmithu<small>${bi(["Tanvirul Islam Mithu", "তানভীরুল ইসলাম মিঠু"])}</small></span></a>`}
  ${bare ? "" : `<nav class="main">
    <a href="/works/">${bi(["Works", "কাজ"])}</a>
    <a href="/chapters/">${bi(["Chapters", "অধ্যায়"])}</a>
    <a href="/shows/">${bi(["Shows", "প্রদর্শনী"])}</a>
    <a href="/videos/">${bi(["Videos", "ভিডিও"])}</a>
    ${posts.length ? `<a href="/journal/">${bi(["Journal", "জার্নাল"])}</a>` : ""}
    <a href="/about/">${bi(["About", "পরিচিতি"])}</a>
    <a href="/contact/">${bi(["Contact", "যোগাযোগ"])}</a>
  </nav>`}
  <button class="lang" id="langBtn" type="button"><span lang="bn">English</span><span lang="en">বাংলা</span></button>
</div></header>
<main>${body}</main>
${bare ? `<footer><div class="wrap"><p class="note">${bi(["This page is private: only people with this link can see it.", "এই পাতাটি ব্যক্তিগত: শুধু যাঁর কাছে লিংক আছে তিনিই দেখতে পারেন।"])} <a href="/" target="_blank" rel="noopener">artistmithu.com ↗</a></p></div></footer>` : `<footer><div class="wrap">
  <form class="subscribe" id="subscribe"><label for="subEmail">${bi(["New works and shows by email", "নতুন কাজ ও প্রদর্শনীর খবর ইমেইলে"])}</label>
    <div><input id="subEmail" type="email" required placeholder="you@example.com"><button type="submit">${bi(["Subscribe", "সাবস্ক্রাইব"])}</button></div>
    <p class="note" id="subNote" hidden></p></form>
  <div class="social"><a href="https://www.facebook.com/artistmithu2022" rel="noopener">Facebook</a> · <a href="https://www.instagram.com/artistmithu/" rel="noopener">Instagram</a> · <a href="https://twitter.com/artistmithu" rel="noopener">X</a> · <a href="https://www.youtube.com/@artistmithu" rel="noopener">YouTube</a>
  <p class="note">© ${new Date().getFullYear()} Tanvirul Islam Mithu · <a href="/admin/" rel="nofollow" style="color:inherit">${bi(["Studio login", "স্টুডিও লগইন"])}</a></p></div>
</div></footer>`}
<div class="tray" id="tray" hidden><div class="wrap"><strong id="trayCount"></strong><a class="btn light" id="trayEnquire" href="/contact/">${bi(["Enquire about these", "এগুলো নিয়ে জিজ্ঞাসা"])}</a><button type="button" class="btn ghost" id="trayClear">${bi(["Clear", "মুছুন"])}</button></div></div>
<script>window.CFG=${JSON.stringify({ url: SUPABASE_URL, key: SUPABASE_KEY, wa: WHATSAPP })}</script>
<script src="/assets/site.js?v=${BUILD}" defer></script>
</body></html>`;
}

function card(w, { plain = false } = {}) { // plain: picture, title and medium only (home page)
  const im = w.images[0];
  return `<article class="card" data-size="${w.size_class || "unknown"}" data-series="${w.series?.slug || ""}" data-status="${w.status}" data-kind="${w.kind || ""}" data-year="${w.year || ""}" data-id="${w.id}">
  <a class="frame" href="/works/${w.slug}/">${im ? `<img src="${img(im.path)}" alt="${esc(w.title_en)}" loading="lazy"${im.width ? ` width="${im.width}" height="${im.height}"` : ""}>` : ""}</a>
  ${plain ? "" : `<button type="button" class="fav" aria-pressed="false" aria-label="Shortlist">+</button>`}
  <div class="meta"><h3><a href="/works/${w.slug}/">${esc(w.title_en)}</a>${w.title_bn ? `<small lang="bn">${esc(w.title_bn)}</small>` : ""}</h3><span class="yr">${w.year || ""}</span></div>
  <div class="sub">${esc(w.medium || "")}${w.height_cm ? ` · ${+w.height_cm} × ${+w.width_cm} cm` : ""}</div>
  ${plain ? "" : `<div class="sub"><span class="pill ${w.status}">${bi(STATUS[w.status])}</span><span class="price">${priceText(w)}</span></div>`}
</article>`;
}

const KINDS = { painting: ["Paintings", "পেইন্টিং"], drawing: ["Drawings", "ড্রইং"], mixed: ["Mixed media", "মিশ্র মাধ্যম"], print: ["Prints", "প্রিন্ট"] };
// Works are shown the way galleries present an artist: grouped into bodies of work (series), oldest series first,
// each series in date order. Visitors can switch to a plain year-by-year view.
const byYearThenSort = (a, b) => (a.year || 9999) - (b.year || 9999) || (a.sort || 0) - (b.sort || 0) || String(a.inv_no).localeCompare(String(b.inv_no));
const span = (list) => { const ys = list.map((w) => w.year).filter(Boolean); if (!ys.length) return ""; const a = Math.min(...ys), b = Math.max(...ys); return a === b ? `${a}` : `${a}–${b}`; };
// Captioned photo grid: studio photos (no chapter) on About, chapter photos on their chapter page.
const photoGrid = (list, heading) => list.length ? `<h2 class="sec">${bi(heading)}</h2><div class="studio">${list.map((p) => `<figure><a href="${img(p.path)}" target="_blank" rel="noopener"><img src="${img(p.path)}" alt="${esc(p.caption_en || heading[0])}" loading="lazy"></a>${p.caption_en || p.caption_bn ? `<figcaption>${bi([esc(p.caption_en || p.caption_bn), esc(p.caption_bn || p.caption_en)])}</figcaption>` : ""}</figure>`).join("")}</div>` : "";
// Chapters with no works yet stay hidden from the chapter lists.
const chaptersShown = () => series.filter((s) => works.some((w) => w.series_id === s.id));
const seriesGroups = () => {
  const groups = series.map((s) => ({ s, list: works.filter((w) => w.series_id === s.id).sort(byYearThenSort) })).filter((g) => g.list.length);
  // Roots is the earliest chapter even where works are undated; another undated chapter sits after the chapter before it in the admin order.
  const first = (g) => { if (g.s.slug === "roots") return 0; const y = Math.min(...g.list.map((w) => w.year || 9999)); if (y < 9999) return y; const prev = groups.filter((x) => (x.s.sort || 99) < (g.s.sort || 99) && x.list.some((w) => w.year)).pop(); return prev ? Math.min(...prev.list.map((w) => w.year || 9999)) + 0.5 : 9999; };
  const key = new Map(groups.map((g) => [g, first(g)]));
  groups.sort((a, b) => key.get(a) - key.get(b) || (a.s.sort || 99) - (b.s.sort || 99));
  const other = works.filter((w) => !w.series).sort(byYearThenSort);
  if (other.length) groups.push({ s: { slug: "other", title_en: "Other works", title_bn: "অন্যান্য কাজ" }, list: other });
  return groups;
};
const filters = () => `<div class="controls"><div class="wrap">
 <div class="group" data-arrange><span class="label">${bi(["Arrange", "সাজান"])}</span>
  <button class="chip" data-v="series" aria-pressed="true">${bi(["By series", "সিরিজ অনুযায়ী"])}</button>
  <button class="chip" data-v="year" aria-pressed="false">${bi(["By year", "সাল অনুযায়ী"])}</button></div>
 <div class="group" data-filter="size"><span class="label">${bi(["Size", "আকার"])}</span>
  <button class="chip" data-v="all" aria-pressed="true">${bi(["All", "সব"])}</button>
  <button class="chip" data-v="small" aria-pressed="false">${bi(SIZE.small)} &lt;40cm</button>
  <button class="chip" data-v="medium" aria-pressed="false">${bi(SIZE.medium)} 40–90</button>
  <button class="chip" data-v="large" aria-pressed="false">${bi(SIZE.large)} &gt;90cm</button></div>
 <div class="group" data-filter="kind"><span class="label">${bi(["Type", "ধরন"])}</span>
  <button class="chip" data-v="all" aria-pressed="true">${bi(["All", "সব"])}</button>
  ${Object.entries(KINDS).filter(([k]) => works.some((w) => w.kind === k)).map(([k, t]) => `<button class="chip" data-v="${k}" aria-pressed="false">${bi(t)}</button>`).join("")}</div>
 <div class="group" data-filter="status"><span class="label">${bi(["Status", "অবস্থা"])}</span>
  <button class="chip" data-v="all" aria-pressed="true">${bi(["All", "সব"])}</button>
  <button class="chip" data-v="available" aria-pressed="false">${bi(["For sale", "বিক্রির জন্য"])}</button></div>
 <span class="count" id="count"></span>
</div></div>`;

const files = {};
// Home page: the hero work is chosen in admin (site_content "hero" = inventory number); the self-portrait
// opens the journey section further down. Neither repeats in "Selected works".
const isSelf = (w) => /self.?portrait/i.test(w.title_en || "");
const heroWork = works.find((w) => w.inv_no === C.hero?.en?.trim()) || works.find((w) => w.featured && !isSelf(w) && w.images[0]);
const selfWork = works.find((w) => w.featured && isSelf(w)) || works.find((w) => isSelf(w) && w.images[0]);
const featured = works.filter((w) => w.featured && w !== heroWork && w !== selfWork).slice(0, 6);
const heroPhoto = C.hero_image?.en; // a photo uploaded in admin wins over the hero work
const heroImg = heroPhoto ? { path: heroPhoto } : heroWork?.images[0];
// Journey timeline: one line per step, "YEAR  text" (two spaces or a tab between them), edited in admin.
// Picture beside the journey timeline: a photo chosen in admin, else the self-portrait when it is not already the hero.
const journeyPic = (() => {
  const ph = C.journey_image?.en, cap = C.journey_caption;
  if (ph) return `<a class="portrait" href="/chapters/roots/"><img src="${img(ph)}" alt="${esc(cap?.en || "Tanvirul Islam Mithu")}" loading="lazy">${cap?.en || cap?.bn ? `<small>${bi([esc(cap.en || cap.bn), esc(cap.bn || cap.en)])}</small>` : ""}</a>`;
  return selfWork?.images[0] && selfWork !== heroWork ? `<a class="portrait" href="/works/${selfWork.slug}/"><img src="${img(selfWork.images[0].path)}" alt="${esc(selfWork.title_en)}" loading="lazy"><small>${esc(selfWork.title_en)}${selfWork.year ? `, ${selfWork.year}` : ""}</small></a>` : "";
})();
const journeyList = (t) => `<ol class="journey">${lines(t).map((l) => { const m = l.match(/^(\S+)(?:\s{2,}|\t)(.+)$/); return m ? `<li><b>${m[1]}</b><span>${m[2]}</span></li>` : `<li><span>${l}</span></li>`; }).join("")}</ol>`;

files["index.html"] = page({
  title: "Tanvirul Islam Mithu | Bangladeshi Painter & Visual Artist",
  desc: "Paintings and drawings by Bangladeshi artist Tanvirul Islam Mithu: thirty-five years of lines, from student drawings and a 1991 meeting with S. M. Sultan to Bangladesh's first solo web show and the Lines of Life scrolls.",
  path: "/",
  image: heroImg ? img(heroImg.path) : undefined,
  jsonld: { "@context": "https://schema.org", "@type": "Person", name: "Tanvirul Islam Mithu", alternateName: ["Artistmithu", "Artist Mithu", "তানভীরুল ইসলাম মিঠু"], jobTitle: "Visual Artist", url: SITE, alumniOf: "University of Dhaka", sameAs: ["https://www.facebook.com/artistmithu2022", "https://www.instagram.com/artistmithu/", "https://twitter.com/artistmithu", "https://www.youtube.com/@artistmithu"] },
  body: `<section class="hero"><div class="wrap">
  <div><h1>${bi(["Thirty-five years of <b>lines</b>, in one place", "পঁয়ত্রিশ বছরের <b>রেখা</b>, এক জায়গায়"])}</h1>
  <p>${bi(["A boy copying illustrations from books. A meeting with S. M. Sultan in Narail. Life drawing at the Faculty of Fine Arts in Dhaka. Bangladesh's first solo web show, and long scroll drawings made a little every day. This is one artist's journey, told in line.", "বই থেকে ছবি দেখে আঁকা এক কিশোর। নড়াইলে এস এম সুলতানের সাথে দেখা। ঢাকা চারুকলায় জীবন থেকে আঁকা। দেশের প্রথম একক ওয়েব শো, আর প্রতিদিন একটু একটু করে আঁকা দীর্ঘ স্ক্রল। রেখায় বলা একজন শিল্পীর যাত্রা।"])}</p>
  <div class="facts"><div><strong>35+</strong>${bi(["years of practice", "বছরের চর্চা"])}</div><div><strong>2013</strong>${bi(["Bangladesh's first solo web show", "দেশের প্রথম একক ওয়েব শো"])}</div><div><strong>${works.length}</strong>${bi(["works online", "কাজ অনলাইনে"])}</div></div>
  <p><a class="btn" href="#journey">${bi(["Follow the journey", "যাত্রাটা দেখুন"])}</a></p></div>
  ${heroPhoto ? `<a class="hero-img" href="/works/"><img src="${img(heroPhoto)}" alt="Works by Tanvirul Islam Mithu on an exhibition wall"></a>` : heroImg ? `<a class="hero-img" href="/works/${heroWork.slug}/"><img src="${img(heroImg.path)}" alt="${esc(heroWork.title_en)}"></a>` : ""}
  </div></section>
  ${(() => { // Current practice first: a jury wants to see what the artist is doing now.
    const recent = works.filter((w) => w.year >= 2020 && w.images[0] && w !== heroWork).sort((a, b) => (b.year - a.year) || ((b.featured ? 1 : 0) - (a.featured ? 1 : 0)) || ((a.sort ?? 0) - (b.sort ?? 0))).slice(0, 6);
    const now = exhibitions.filter((x) => x.slug && x.published !== false && x.start_date).sort((x, y) => String(y.start_date).localeCompare(String(x.start_date))).slice(0, 3);
    if (!recent.length && !now.length) return "";
    const vid = C.process_video?.en, vcap = C.process_video_caption;
    return `<section class="wrap" id="now"><h2 class="sec">${bi(["Current work", "এখনকার কাজ"])}</h2>
    ${vid ? `<figure class="process"><video controls playsinline muted preload="none" poster="${img(vid.replace(/\.mp4$/, ".jpg"))}" src="${img(vid)}"></video>${vcap?.en ? `<figcaption>${bi([esc(vcap.en), esc(vcap.bn || vcap.en)])}</figcaption>` : ""}</figure>` : ""}
    ${recent.length ? `<div class="grid">${recent.map((w) => card(w, { plain: true })).join("")}</div>` : ""}
    ${now.length ? `<h3 class="minor">${bi(["Recent exhibitions", "সাম্প্রতিক প্রদর্শনী"])}</h3><div class="shows">${now.map((e) => `<a class="show" href="/shows/${e.slug}/">${e.cover_path ? `<img src="${img(e.cover_path)}" alt="" loading="lazy">` : `<span class="empty"></span>`}<span class="eyebrow">${e.start_date.slice(0, 4)}</span><strong>${esc(e.title)}</strong><span class="note">${esc(e.venue || "")}</span></a>`).join("")}</div>` : ""}
    <p><a class="btn" href="/shows/">${bi(["All exhibitions", "সব প্রদর্শনী"])}</a> <a class="btn alt" href="/cv/">${bi(["CV", "সিভি"])}</a></p></section>`;
  })()}
  <section class="wrap" id="journey"><h2 class="sec">${bi(["The journey", "যাত্রা"])}</h2><div class="journey-wrap${journeyPic ? "" : " solo"}">
  ${journeyPic}
  <div>${biText(C.journey, journeyList)}<p><a href="/about/">${bi(["Full biography and CV", "পূর্ণ জীবনী ও সিভি"])} →</a></p></div></div></section>
  ${(() => { // From the archive: the earliest show with press coverage, led by its first clipping.
    const e = exhibitions.filter((x) => x.slug && x.published !== false && (x.press || []).some((c) => c.kind !== "sponsor")).sort((x, y) => String(x.start_date).localeCompare(String(y.start_date)))[0];
    if (!e) return "";
    const c = e.press.find((x) => x.kind !== "sponsor"), n = e.press.filter((x) => x.kind !== "sponsor").length;
    return `<section class="wrap"><h2 class="sec">${bi(["From the archive", "আর্কাইভ থেকে"])}</h2><a class="archive" href="/shows/${e.slug}/"><img src="${img(c.path)}" alt="${esc(c.source || "")}" loading="lazy"><div><span class="eyebrow">${e.start_date ? e.start_date.slice(0, 4) : ""} · ${esc(e.venue || "")}</span><strong>${bi([esc(e.title), esc(e.title_bn || e.title)])}</strong>${c.headline ? `<p>“${esc(c.headline)}”<br><small>${esc(c.source || "")}${c.date ? `, ${esc(c.date)}` : ""}</small></p>` : ""}${e.sponsor_en ? `<p class="note">${bi([esc(e.sponsor_en), esc(e.sponsor_bn || e.sponsor_en)])}</p>` : ""}<span class="btn">${bi([`Read the story and ${n} press clippings`, `পুরো গল্প ও ${n}টি পত্রিকার খবর`])}</span></div></a></section>`;
  })()}
  <section class="wrap"><h2 class="sec">${bi(["Chapters of a life", "জীবনের অধ্যায়"])}</h2><div class="chapters">
  ${chaptersShown().map((s) => { const n = works.filter((w) => w.series_id === s.id).sort(byYearThenSort); const cover = n[0]?.images[0]; return `<a class="chapter" href="/chapters/${s.slug}/">${cover ? `<img src="${img(cover.path)}" alt="" loading="lazy">` : `<span class="empty"></span>`}<strong>${esc(s.title_en)}</strong><small lang="bn">${esc(s.title_bn || "")}</small><span class="note">${n.length} ${n.length === 1 ? "work" : "works"}</span></a>`; }).join("")}
  </div>${bookShelf()}</section>
  <section class="wrap"><h2 class="sec">${bi(["From the earlier years", "আগের বছরগুলো থেকে"])}</h2><div class="grid">${featured.map((w) => card(w, { plain: true })).join("")}</div><p><a class="btn" href="/works/">${bi(["See all works", "সব কাজ দেখুন"])}</a></p></section>
  ${posts.length ? `<section class="wrap"><h2 class="sec">${bi(["From the journal", "জার্নাল থেকে"])}</h2><div class="shows">${posts.slice(0, 3).map((p) => `<a class="show" href="/journal/${p.slug}/">${p.cover_path ? `<img src="${img(p.cover_path)}" alt="" loading="lazy">` : `<span class="empty"></span>`}<strong>${esc(p.title_en)}</strong></a>`).join("")}</div></section>` : ""}`,
});

files["works/index.html"] = page({
  title: "Works | Tanvirul Islam Mithu",
  desc: "All available and archived works by Tanvirul Islam Mithu, filterable by size, chapter and availability.",
  path: "/works/",
  body: `<div class="wrap"><h1 class="page-title">${bi(["Works", "কাজ"])}</h1>
  <p class="lead">${bi([`${works.length} works in ${seriesGroups().length} series, from the earliest drawings to the latest web shows.`, `${works.length}টি কাজ, ${seriesGroups().length}টি সিরিজে: প্রথম দিকের ড্রইং থেকে সাম্প্রতিক ওয়েব শো পর্যন্ত।`])}</p>
  <nav class="jump">${seriesGroups().map((g) => `<a href="#s-${g.s.slug}">${bi([esc(g.s.title_en), esc(g.s.title_bn || g.s.title_en)])}</a>`).join("")}</nav></div>
  ${filters()}<div class="wrap" id="grid">${seriesGroups().map((g) => `<section class="wgroup" id="s-${g.s.slug}"><header><h2>${bi([esc(g.s.title_en), esc(g.s.title_bn || g.s.title_en)])}</h2><span class="note">${span(g.list) ? `${span(g.list)} · ` : ""}${g.list.length} ${bi(["works", "টি কাজ"])}${g.s.slug !== "other" ? ` · <a href="/chapters/${g.s.slug}/">${bi(["About this series", "এই সিরিজ সম্পর্কে"])}</a>` : ""}</span></header>${g.s.description_en ? `<p class="lead">${bi([esc(g.s.description_en), esc(g.s.description_bn || g.s.description_en)])}</p>` : ""}<div class="grid">${g.list.map(card).join("")}</div></section>`).join("")}</div>`,
});

files["chapters/index.html"] = page({
  title: "Chapters | Tanvirul Islam Mithu",
  desc: "The series and chapters of Tanvirul Islam Mithu's practice, from Roots and the early drawings to Lines of Life and Lines of Image.",
  path: "/chapters/",
  body: `<div class="wrap"><h1 class="page-title">${bi(["Chapters of a life", "জীবনের অধ্যায়"])}</h1><div class="chapters">${chaptersShown().map((s) => { const n = works.filter((w) => w.series_id === s.id).sort(byYearThenSort); const cover = n[0]?.images[0]; return `<a class="chapter" href="/chapters/${s.slug}/">${cover ? `<img src="${img(cover.path)}" alt="" loading="lazy">` : `<span class="empty"></span>`}<strong>${esc(s.title_en)}</strong><small lang="bn">${esc(s.title_bn || "")}</small><span class="note">${n.length} works</span></a>`; }).join("")}</div>${bookShelf()}</div>`,
});

for (const s of chaptersShown()) {
  const list = works.filter((w) => w.series_id === s.id).sort(byYearThenSort);
  files[`chapters/${s.slug}/index.html`] = page({
    title: `${s.title_en} | Tanvirul Islam Mithu`,
    desc: s.description_en || `${s.title_en}: ${list.length} works by Tanvirul Islam Mithu.`,
    path: `/chapters/${s.slug}/`,
    body: `<div class="wrap"><p class="eyebrow"><a href="/chapters/">${bi(["Chapters", "অধ্যায়"])}</a></p><h1 class="page-title">${esc(s.title_en)} <small lang="bn">${esc(s.title_bn || "")}</small></h1>
    ${s.description_en ? `<p class="lead">${bi([esc(s.description_en), esc(s.description_bn || s.description_en)])}</p>` : ""}
    ${photoGrid(studio.filter((p) => p.series_id === s.id), ["Photographs", "ছবি ও স্মৃতি"])}
    ${list.length ? `<h2 class="sec">${bi(["Works", "কাজ"])}</h2>` : ""}
    ${list.length ? `<div class="grid">${list.map(card).join("")}</div>` : `<p class="note">${bi(["Works for this chapter are being added.", "এই অধ্যায়ের কাজ যোগ করা হচ্ছে।"])}</p>`}</div>`,
  });
}

// Sketchbooks --------------------------------------------------------------------------
function bookShelf() {
  const bs = booksShown(); if (!bs.length) return "";
  return `<h2 class="sec" id="sketchbooks">${bi(["Sketchbooks", "স্কেচখাতা"])}</h2><p class="lead">${bi(["Whole sketchbooks, page by page, as they were drawn.", "পুরো স্কেচখাতা, যেভাবে আঁকা হয়েছিল, পাতার পর পাতা।"])}</p><div class="chapters">${bs.map((b) => { const ps = pagesOf(b); return `<a class="chapter book" href="/sketchbooks/${b.slug}/"><img src="${img(ps[0].path)}" alt="" loading="lazy"><strong>${esc(b.title_en)}</strong><small lang="bn">${esc(b.title_bn || "")}</small><span class="note">${b.period ? `${esc(b.period)} · ` : ""}${ps.length} ${bi(["pages", "পাতা"])}</span></a>`; }).join("")}</div>`;
}
if (booksShown().length) files["sketchbooks/index.html"] = page({
  title: "Sketchbooks | Tanvirul Islam Mithu",
  desc: "Tanvirul Islam Mithu's sketchbooks and experiment notebooks, page by page.",
  path: "/sketchbooks/",
  body: `<div class="wrap"><p class="eyebrow"><a href="/chapters/">${bi(["Chapters", "অধ্যায়"])}</a></p><h1 class="page-title">${bi(["Sketchbooks", "স্কেচখাতা"])}</h1>${bookShelf().replace(/^<h2[^>]*>.*?<\/h2>/, "")}</div>`,
});
booksShown().forEach((b, i, all) => {
  const ps = pagesOf(b), prev = all[i - 1], next = all[i + 1];
  const data = ps.map((p) => ({ src: img(p.path), en: p.caption_en || "", bn: p.caption_bn || "" }));
  files[`sketchbooks/${b.slug}/index.html`] = page({
    title: `${b.title_en} | Tanvirul Islam Mithu`,
    desc: b.description_en || `${b.title_en}: ${ps.length} pages from Tanvirul Islam Mithu's sketchbook.`,
    path: `/sketchbooks/${b.slug}/`,
    image: img(ps[0].path),
    body: `<div class="wrap"><p class="eyebrow"><a href="/sketchbooks/">${bi(["Sketchbooks", "স্কেচখাতা"])}</a></p>
    <h1 class="page-title">${esc(b.title_en)} <small lang="bn">${esc(b.title_bn || "")}</small></h1>
    ${b.description_en ? `<p class="lead">${bi([esc(b.description_en), esc(b.description_bn || b.description_en)])}</p>` : ""}
    <section class="book" id="book" aria-roledescription="sketchbook" aria-label="${esc(b.title_en)}">
      <div class="leaf"><button type="button" class="turn prev" aria-label="Previous page">‹</button><figure><img id="bookImg" src="${img(ps[0].path)}" alt="${esc(b.title_en)}, page 1"><figcaption id="bookCap"></figcaption></figure><button type="button" class="turn next" aria-label="Next page">›</button></div>
      <p class="pageno mono"><span id="bookNo">1</span> / ${ps.length}</p>
      <div class="strip" id="bookStrip">${ps.map((p, n) => `<button type="button" data-n="${n}" aria-label="Page ${n + 1}"><img src="${img(p.path)}" alt="" loading="lazy"></button>`).join("")}</div>
      <script type="application/json" id="bookData">${JSON.stringify(data).replace(/</g, "\\u003c")}</script>
    </section>
    <p class="note">${bi(["Interested in a page or the whole book?", "কোনো পাতা বা পুরো খাতা নিয়ে আগ্রহী?"])} <a href="/contact/?about=${encodeURIComponent(b.title_en)}">${bi(["Get in touch", "যোগাযোগ করুন"])}</a></p>
    <nav class="prevnext">${prev ? `<a href="/sketchbooks/${prev.slug}/">← ${esc(prev.title_en)}</a>` : "<span></span>"}${next ? `<a href="/sketchbooks/${next.slug}/">${esc(next.title_en)} →</a>` : ""}</nav></div>`,
  });
});

for (const w of works) {
  const main = w.images[0];
  const about = w.description_en && w.description_en !== w.title_en && !/\|/.test(w.description_en) ? ` ${w.description_en.replace(/\s+/g, " ").slice(0, 160)}${w.description_en.length > 160 ? "…" : ""}` : "";
  const desc = `${w.title_en}${w.year ? ` (${w.year})` : ""}, ${w.medium || "artwork"}${w.height_cm ? `, ${+w.height_cm} × ${+w.width_cm} cm` : ""} by Tanvirul Islam Mithu.${about}`;
  const pageUrl = `${SITE}/works/${w.slug}/`;
  const waText = encodeURIComponent(`Hello, I am interested in "${w.title_en}" (${w.inv_no}). ${SITE}/works/${w.slug}/`);
  const related = works.filter((x) => x.series_id === w.series_id && x.id !== w.id).slice(0, 4);
  files[`works/${w.slug}/index.html`] = page({
    title: `${w.title_en}${w.year ? `, ${w.year}` : ""} | Tanvirul Islam Mithu`,
    desc,
    path: `/works/${w.slug}/`,
    image: main ? img(main.path) : undefined, imageW: main?.width, imageH: main?.height, imageAlt: `${w.title_en} by Tanvirul Islam Mithu`, ogType: "article",
    jsonld: { "@context": "https://schema.org", "@type": "VisualArtwork", name: w.title_en, creator: { "@type": "Person", name: "Tanvirul Islam Mithu" }, dateCreated: w.year || undefined, artMedium: w.medium || undefined, height: w.height_cm ? { "@type": "Distance", name: `${+w.height_cm} cm` } : undefined, width: w.width_cm ? { "@type": "Distance", name: `${+w.width_cm} cm` } : undefined, image: main ? img(main.path) : undefined, url: `${SITE}/works/${w.slug}/` },
    body: `<div class="wrap"><p class="eyebrow"><a href="/works/">${bi(["Works", "কাজ"])}</a>${w.series ? ` / <a href="/chapters/${w.series.slug}/">${esc(w.series.title_en)}</a>` : ""}</p>
    <div class="detail" data-id="${w.id}">
      <div class="big">${w.images.map((i, n) => `<a href="${img(i.path)}" target="_blank" rel="noopener"><img src="${img(i.path)}" alt="${esc(i.alt_en || w.title_en)}"${n ? ' loading="lazy"' : ""}${i.width ? ` width="${i.width}" height="${i.height}"` : ""}></a>`).join("")}</div>
      <div class="info">
        <h1>${esc(w.title_en)}</h1>${w.title_bn ? `<div class="bn" lang="bn">${esc(w.title_bn)}</div>` : ""}
        <dl class="spec">
          <dt>${bi(["Inventory", "ইনভেন্টরি"])}</dt><dd class="mono">${esc(w.inv_no)}</dd>
          ${w.year ? `<dt>${bi(["Year", "সাল"])}</dt><dd>${w.year}</dd>` : ""}
          ${w.collection_en || w.collection_bn ? `<dt>${bi(["Collection", "সংগ্রহ"])}</dt><dd>${bi([esc(w.collection_en || w.collection_bn), esc(w.collection_bn || w.collection_en)])}</dd>` : ""}
          ${w.medium ? `<dt>${bi(["Medium", "মাধ্যম"])}</dt><dd>${esc(w.medium)}</dd>` : ""}
          <dt>${bi(["Size", "মাপ"])}</dt><dd>${sizeText(w)}${w.size_class ? ` · ${bi(SIZE[w.size_class])}` : ""}</dd>
          ${w.edition ? `<dt>${bi(["Edition", "সংস্করণ"])}</dt><dd>${esc(w.edition)}</dd>` : ""}
          <!--SHOWS-->
          <dt>${bi(["Status", "অবস্থা"])}</dt><dd><span class="pill ${w.status}">${bi(STATUS[w.status])}</span></dd>
          ${priceText(w) ? `<dt>${bi(["Price", "দাম"])}</dt><dd class="price">${priceText(w, { note: true })}</dd>` : ""}
        </dl>
        ${w.description_en && w.description_en !== w.title_en && !/\|/.test(w.description_en) ? `<p class="lead">${esc(w.description_en)}</p>` : ""}
        <div class="actions">
          <a class="btn" href="https://wa.me/${WHATSAPP}?text=${waText}" rel="noopener">${bi(["Enquire on WhatsApp", "WhatsApp-এ জিজ্ঞাসা"])}</a>
          <button type="button" class="btn alt fav-detail">${bi(["Add to shortlist", "পছন্দের তালিকায়"])}</button>
        </div>
        <div class="sharebar"><span class="note">${bi(["Share this work", "কাজটি শেয়ার করুন"])}</span>
          <a href="https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(pageUrl)}" target="_blank" rel="noopener">Facebook</a>
          <a href="https://wa.me/?text=${encodeURIComponent(`${w.title_en} by Tanvirul Islam Mithu ${pageUrl}`)}" target="_blank" rel="noopener">WhatsApp</a>
          ${main ? `<a href="${img(main.path)}" download="${esc(w.slug)}.jpg" target="_blank" rel="noopener" title="For Instagram: save the picture and post it, with this page's link in your bio or story">${bi(["Picture for Instagram", "ইনস্টাগ্রামের জন্য ছবি"])}</a>` : ""}
          <button type="button" class="share" data-url="${pageUrl}">${bi(["Copy link", "লিংক কপি"])}</button></div>
        ${w.height_cm ? `<div class="scale" data-h="${+w.height_cm}" data-w="${+w.width_cm}"><h4>${bi(["Size next to a 170 cm person", "১৭০ সেমি মানুষের পাশে আকার"])}</h4></div>` : ""}
        <form class="enq" data-artwork="${w.id}"><strong>${bi(["Or send a message", "অথবা বার্তা পাঠান"])}</strong>
          <input name="name" required placeholder="Name / নাম"><input name="contact" required placeholder="Email or phone / ইমেইল বা ফোন">
          <textarea name="message" rows="3" placeholder="Message / বার্তা"></textarea><button class="btn" type="submit">${bi(["Send", "পাঠান"])}</button><p class="note" hidden></p></form>
      </div>
    </div>
    ${related.length ? `<h2 class="sec">${bi(["More from this chapter", "এই অধ্যায়ের আরও কাজ"])}</h2><div class="grid">${related.map(card).join("")}</div>` : ""}
    </div>`,
  });
}

files["contact/index.html"] = page({
  title: "Contact | Tanvirul Islam Mithu",
  desc: "Contact Tanvirul Islam Mithu about artworks, commissions and exhibitions.",
  path: "/contact/",
  body: `<div class="wrap prose"><h1 class="page-title">${bi(["Contact", "যোগাযোগ"])}</h1>
  <p>${bi(["Ask about a work, a commission or an exhibition. Replies usually within a day.", "কোনো কাজ, অর্ডারে আঁকা বা প্রদর্শনী নিয়ে জানতে লিখুন। সাধারণত এক দিনের মধ্যে উত্তর দেওয়া হয়।"])}</p>
  ${C.email?.en || WHATSAPP ? `<p>${C.email?.en ? `<a class="btn" href="mailto:${esc(C.email.en.trim())}">${esc(C.email.en.trim())}</a> ` : ""}${WHATSAPP ? `<a class="btn alt" href="https://wa.me/${WHATSAPP}" rel="noopener">WhatsApp</a>` : ""}</p>` : ""}
  <form class="enq" id="contactForm"><input name="name" required placeholder="Name / নাম"><input name="contact" required placeholder="Email or phone / ইমেইল বা ফোন">
  <textarea name="message" rows="5" placeholder="Message / বার্তা"></textarea><button class="btn" type="submit">${bi(["Send", "পাঠান"])}</button><p class="note" hidden></p></form></div>`,
});

files["c/index.html"] = page({
  title: "Selected for you | Tanvirul Islam Mithu",
  desc: "A private selection of works.",
  path: "/c/",
  bare: true, // private links: no site menu, so a bidder never leaves the bidding page by accident
  body: `<div class="wrap"><p class="eyebrow">${bi(["Selected for you by the artist", "শিল্পী আপনার জন্য বাছাই করেছেন"])}</p><h1 class="page-title" id="cTitle">${bi(["Works chosen for you", "আপনার জন্য নির্বাচিত কাজ"])}</h1><p class="lead" id="cNote"></p><div id="cIntro" class="intro" hidden></div><div class="rules" id="cRules" hidden></div><div class="grid" id="cGrid"><p class="note">Loading…</p></div></div>`,
});

files["404.html"] = page({ title: "Page not found | Tanvirul Islam Mithu", desc: "Page not found", path: "/404", body: `<div class="wrap prose"><h1 class="page-title">${bi(["Page not found", "পাতাটি পাওয়া যায়নি"])}</h1><p><a href="/works/">${bi(["See all works", "সব কাজ দেখুন"])}</a></p></div>` });

// Videos --------------------------------------------------------------------------
const fmtDate = (d) => (d ? new Date(d + "T00:00:00Z").toLocaleDateString("en-GB", { day: "numeric", month: "short", year: "numeric", timeZone: "UTC" }) : "");
const vcard = (v) => `<a class="vcard" href="https://www.youtube.com/watch?v=${v.id}" rel="noopener" target="_blank">
  <span class="thumb"><img src="https://i.ytimg.com/vi/${v.id}/hqdefault.jpg" alt="" loading="lazy" width="480" height="360">${v.duration ? `<span class="dur">${esc(v.duration)}</span>` : ""}</span>
  <span class="vt">${esc(v.title)}</span><span class="note">${[v.channel, fmtDate(v.upload_date)].filter(Boolean).join(" · ")}</span></a>`;
const VCATS = [
  ["interview-press", ["TV interviews and news", "টিভি সাক্ষাৎকার ও সংবাদ"]],
  ["web-show-film", ["Web show films", "ওয়েব শো-এর ভিডিও"]],
  ["exhibition-film", ["Exhibition films", "প্রদর্শনীর ভিডিও"]],
  ["artwork-review", ["Works up close", "কাছ থেকে কাজ"]],
  ["drawing-series", ["Drawing series: Transform your thoughts and emotions through art", "ড্রয়িং সিরিজ"]],
  ["process-short", ["Drawing process (Shorts)", "আঁকার প্রক্রিয়া (Shorts)"]],
  ["other", ["Other", "অন্যান্য"]],
];
const byDate = (a, b) => String(a.upload_date || "").localeCompare(String(b.upload_date || ""));
files["videos/index.html"] = page({
  title: "Videos and press | Tanvirul Islam Mithu",
  desc: "TV interviews, news reports and films about Tanvirul Islam Mithu's web shows and paintings, 2001 to today.",
  path: "/videos/",
  body: `<div class="wrap"><h1 class="page-title">${bi(["Videos and press", "ভিডিও ও সংবাদ"])}</h1>
  <p class="lead">${bi(["When Transparent Boundary opened in December 2013 as Bangladesh's first solo web show, national TV channels covered it. These are those interviews and reports, with films of the shows and the work.", "২০১৩ সালের ডিসেম্বরে দেশের প্রথম একক ওয়েব শো \"Transparent Boundary\" খোলার পর জাতীয় টিভি চ্যানেলগুলো এ নিয়ে সংবাদ ও সাক্ষাৎকার প্রচার করে। এখানে সেগুলোর পাশাপাশি প্রদর্শনী ও কাজের ভিডিও রয়েছে।"])} <a href="${VID.channel}" rel="noopener">YouTube</a></p>
  <nav class="vnav">${VCATS.filter(([k]) => VID.videos.some((v) => v.category === k)).map(([k, l]) => `<a href="#${k}">${bi(l)}</a>`).join("")}</nav>
  ${VCATS.map(([k, l]) => { const list = VID.videos.filter((v) => v.category === k).sort(byDate); if (!list.length) return "";
    if (k === "interview-press") { const chans = [...new Set(list.map((v) => v.channel || "Other"))];
      return `<section id="${k}"><h2 class="sec">${bi(l)}</h2>${chans.map((c) => `<h3 class="chan">${esc(c)}</h3><div class="vgrid">${list.filter((v) => (v.channel || "Other") === c).map(vcard).join("")}</div>`).join("")}</section>`; }
    return `<section id="${k}"><h2 class="sec">${bi(l)}</h2><div class="vgrid">${list.map(vcard).join("")}</div></section>`; }).join("")}
  </div>`,
});

// Shows: web shows and exhibitions ---------------------------------------------
const KIND = { "web-show": ["Web show", "ওয়েব শো"], solo: ["Solo exhibition", "একক প্রদর্শনী"], group: ["Group exhibition", "যৌথ প্রদর্শনী"], "art-fair": ["Art fair", "আর্ট ফেয়ার"] };
const shows = exhibitions.filter((e) => e.slug && e.published !== false);
const worksById = Object.fromEntries(works.map((w) => [w.id, w]));
const yt = (u) => { const m = String(u || "").match(/(?:youtu\.be\/|v=|embed\/|shorts\/)([\w-]{11})/); return m ? m[1] : null; };
const showCover = (e) => e.cover_path ? img(e.cover_path) : (() => { const l = showLinks.find((x) => x.exhibition_id === e.id && worksById[x.artwork_id]?.images[0]); return l ? img(worksById[l.artwork_id].images[0].path) : null; })();
// A show known only by its year is stored as 1 January with no end date: show just the year.
const dateRange = (e) => !e.end_date && /-01-01$/.test(e.start_date || "") ? e.start_date.slice(0, 4) : [e.start_date, e.end_date].filter(Boolean).map((d) => new Date(d + "T00:00:00Z").toLocaleDateString("en-GB", { day: "numeric", month: "short", year: "numeric", timeZone: "UTC" })).join(" – ");
const byYear = {};
for (const e of shows) (byYear[e.start_date ? e.start_date.slice(0, 4) : "—"] ||= []).push(e);

const soloShows = shows.filter((e) => e.kind !== "group" && e.kind !== "art-fair");
const groupShows = shows.filter((e) => e.kind === "group" || e.kind === "art-fair");
const yearsOf = (list) => { const by = {}; for (const e of list) (by[e.start_date ? e.start_date.slice(0, 4) : "—"] ||= []).push(e); return by; };
const showCard = (e) => { const c = showCover(e); const n = showLinks.filter((x) => x.exhibition_id === e.id && worksById[x.artwork_id]).length; return `<a class="show" href="/shows/${e.slug}/">${c ? `<img src="${c}" alt="" loading="lazy">` : `<span class="empty"></span>`}<span class="eyebrow">${bi(KIND[e.kind] || [e.kind, e.kind])}</span><strong>${esc(e.title)}</strong>${e.title_bn ? `<small lang="bn">${esc(e.title_bn)}</small>` : ""}<span class="note">${dateRange(e)}${n ? ` · ${n} works` : ""}</span></a>`; };
const showLine = (e) => `<li><span class="mono">${dateRange(e)}</span> <a href="/shows/${e.slug}/">${esc(e.title)}</a>${[e.venue, e.city, e.country].filter(Boolean).length ? `, ${esc([e.venue, e.city, e.country].filter(Boolean).join(", "))}` : ""}</li>`;
files["shows/index.html"] = page({
  title: "Shows | Tanvirul Islam Mithu",
  desc: "Solo exhibitions, web shows and group exhibitions by Tanvirul Islam Mithu, from Transparent Boundary (2013), Bangladesh's first solo web show, to today.",
  path: "/shows/",
  body: `<div class="wrap"><h1 class="page-title">${bi(["Shows", "প্রদর্শনী"])}</h1>
  <p class="lead">${bi(["Since 2013 Mithu has opened his solo shows on the web first. Each show keeps its statement, works and video.", "২০১৩ সাল থেকে মিঠু তাঁর একক প্রদর্শনী প্রথমে ওয়েবে খুলে আসছেন। প্রতিটি শো-তে আছে তার বক্তব্য, কাজ ও ভিডিও।"])}</p>
  <nav class="jump"><a href="#solo">${bi(["Solo exhibitions and web shows", "একক প্রদর্শনী ও ওয়েব শো"])}</a>${groupShows.length ? `<a href="#group">${bi(["Group exhibitions", "যৌথ প্রদর্শনী"])}</a>` : ""}</nav>
  <section class="wgroup" id="solo"><header><h2>${bi(["Solo exhibitions and web shows", "একক প্রদর্শনী ও ওয়েব শো"])}</h2><span class="note">${soloShows.length}</span></header>
  ${soloShows.length ? Object.entries(yearsOf(soloShows)).sort(([a], [b]) => b.localeCompare(a)).map(([y, l]) => `<h3 class="mono-year">${y}</h3><div class="shows">${l.map(showCard).join("")}</div>`).join("") : `<p class="note">${bi(["The show archive is being added.", "প্রদর্শনীর আর্কাইভ যোগ করা হচ্ছে।"])}</p>`}</section>
  ${groupShows.length ? `<section class="wgroup" id="group"><header><h2>${bi(["Group exhibitions", "যৌথ প্রদর্শনী"])}</h2><span class="note">${groupShows.length}</span></header>
  ${groupShows.some((e) => showCover(e)) ? `<div class="shows">${groupShows.filter((e) => showCover(e)).map(showCard).join("")}</div>` : ""}
  <ul class="ex">${groupShows.map(showLine).join("")}</ul></section>` : ""}
  </div>`,
});

// Press clippings and sponsor material for a show (exhibitions.press, edited in admin).
const clips = (e, kind, cls) => { const l = (e.press || []).filter((x) => (x.kind || "press") === kind); return l.length ? `<div class="${cls}">${l.map((x) => `<figure><a href="${img(x.path)}" target="_blank" rel="noopener"><img src="${img(x.path)}" alt="${esc([x.source, x.headline].filter(Boolean).join(": ") || e.title)}" loading="lazy"></a>${x.source || x.headline || x.date ? `<figcaption>${x.source ? `<b>${esc(x.source)}</b>` : ""}${x.date ? ` <span class="mono">${esc(x.date)}</span>` : ""}${x.headline ? `<span${x.lang === "bn" ? ' lang="bn"' : ""}>${esc(x.headline)}</span>` : ""}</figcaption>` : ""}</figure>`).join("")}</div>` : ""; };
const ordered = [...shows].sort((a, b) => String(a.start_date).localeCompare(String(b.start_date)));
ordered.forEach((e, i) => {
  const list = showLinks.filter((x) => x.exhibition_id === e.id).sort((a, b) => a.sort - b.sort).map((x) => worksById[x.artwork_id]).filter(Boolean);
  const vid = yt(e.youtube_url), prev = ordered[i - 1], next = ordered[i + 1], c = showCover(e);
  files[`shows/${e.slug}/index.html`] = page({
    title: `${e.title}${e.start_date ? `, ${e.start_date.slice(0, 4)}` : ""} | Tanvirul Islam Mithu`,
    desc: (e.statement_en || `${e.title}: ${(KIND[e.kind] || [e.kind])[0]} by Tanvirul Islam Mithu.`).slice(0, 160),
    path: `/shows/${e.slug}/`,
    image: c || undefined,
    jsonld: { "@context": "https://schema.org", "@type": "ExhibitionEvent", name: e.title, startDate: e.start_date || undefined, endDate: e.end_date || undefined, eventAttendanceMode: e.kind === "web-show" ? "https://schema.org/OnlineEventAttendanceMode" : "https://schema.org/OfflineEventAttendanceMode", location: e.kind === "web-show" ? { "@type": "VirtualLocation", url: `${SITE}/shows/${e.slug}/` } : { "@type": "Place", name: e.venue || e.city || "", address: [e.city, e.country].filter(Boolean).join(", ") }, organizer: e.kind === "group" ? undefined : { "@type": "Person", name: "Tanvirul Islam Mithu" }, performer: { "@type": "Person", name: "Tanvirul Islam Mithu" }, image: c || undefined, url: `${SITE}/shows/${e.slug}/` },
    body: `<div class="wrap"><p class="eyebrow"><a href="/shows/">${bi(["Shows", "প্রদর্শনী"])}</a> / ${bi(KIND[e.kind] || [e.kind, e.kind])}</p>
    <h1 class="page-title">${esc(e.title)}${e.title_bn ? ` <small lang="bn">${esc(e.title_bn)}</small>` : ""}</h1>
    <p class="note">${dateRange(e)}${e.venue ? ` · ${esc(e.venue)}` : ""}${e.city ? `, ${esc(e.city)}` : ""}</p>
    <div class="show-head">
      ${e.video_path ? `<div class="video own"><video controls playsinline preload="none" poster="${img(e.video_path.replace(/\.mp4$/, ".jpg"))}" src="${img(e.video_path)}"></video></div>` : vid ? `<div class="video"><iframe src="https://www.youtube-nocookie.com/embed/${vid}" title="${esc(e.title)}" loading="lazy" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture; fullscreen" allowfullscreen></iframe></div>` : c ? `<img class="show-cover" src="${c}" alt="${esc(e.title)}">` : ""}
      <div class="prose">
        ${e.statement_en ? `<div lang="en">${esc(e.statement_en).split(/\n{2,}/).map((p) => `<p>${p}</p>`).join("")}</div>` : ""}
        ${e.statement_bn ? `<div lang="bn">${esc(e.statement_bn).split(/\n{2,}/).map((p) => `<p>${p}</p>`).join("")}</div>` : ""}
        <p class="links">${e.wayback_url ? `<a href="${esc(e.wayback_url)}" rel="noopener">${bi(["Archived copy of the original page", "মূল পাতার আর্কাইভ কপি"])}</a>` : ""}</p>
      </div>
    </div>
    ${e.sponsor_en || e.sponsor_bn ? `<aside class="sponsor"><span class="eyebrow">${bi(["Sponsor", "পৃষ্ঠপোষক"])}</span><p>${bi([esc(e.sponsor_en || e.sponsor_bn), esc(e.sponsor_bn || e.sponsor_en)])}</p>${clips(e, "sponsor", "sponsor-photos")}</aside>` : ""}
    ${(() => { // Where works from this show are held now.
      const held = {}; list.filter((w) => w.collection_en || w.collection_bn).forEach((w) => (held[w.collection_en || w.collection_bn] ||= { bn: w.collection_bn || w.collection_en, l: [] }).l.push(w));
      const ks = Object.keys(held); if (!ks.length) return "";
      return `<aside class="sponsor"><span class="eyebrow">${bi(["In collections", "যেখানে সংরক্ষিত"])}</span>${ks.map((k) => `<p><b>${bi([esc(k), esc(held[k].bn)])}:</b> ${held[k].l.map((w) => `<a href="/works/${w.slug}/">${esc(w.title_en)}</a>`).join(", ")}</p>`).join("")}</aside>`;
    })()}
    ${list.length ? `<h2 class="sec">${bi(["Works in this show", "এই শো-এর কাজ"])}</h2><div class="grid">${list.map(card).join("")}</div>` : ""}
    ${(e.press || []).some((x) => x.kind !== "sponsor") ? `<h2 class="sec">${bi(["In the press", "পত্রিকায়"])}</h2>${clips(e, "press", "press")}` : ""}
    ${(e.images || []).length ? `<h2 class="sec">${bi(["Photos from the exhibition", "প্রদর্শনীর ছবি"])}</h2><div class="studio">${e.images.map((x) => `<figure><a href="${img(x)}" target="_blank" rel="noopener"><img src="${img(x)}" alt="${esc(e.title)}" loading="lazy"></a></figure>`).join("")}</div>` : ""}
    ${(() => { const vs = VID.videos.filter((v) => v.related_show === e.slug && v.id !== vid).sort(byDate); return vs.length ? `<h2 class="sec">${bi(["Videos and press", "ভিডিও ও সংবাদ"])}</h2><div class="vgrid">${vs.map(vcard).join("")}</div>` : ""; })()}
    <nav class="prevnext">${prev ? `<a href="/shows/${prev.slug}/">← ${esc(prev.title)}</a>` : "<span></span>"}${next ? `<a href="/shows/${next.slug}/">${esc(next.title)} →</a>` : ""}</nav>
    </div>`,
  });
});

// Work pages list the shows each work was in (filled after shows are known).
for (const w of works) {
  const inShows = showLinks.filter((x) => x.artwork_id === w.id).map((x) => shows.find((e) => e.id === x.exhibition_id)).filter(Boolean);
  const f = `works/${w.slug}/index.html`;
  if (inShows.length && files[f]) files[f] = files[f].replace("<!--SHOWS-->", `<dt>${bi(["Shown in", "প্রদর্শিত"])}</dt><dd>${inShows.map((e) => `<a href="/shows/${e.slug}/">${esc(e.title)}</a>`).join(", ")}</dd>`);
}

const urls = ["/", "/works/", "/chapters/", "/shows/", "/videos/", ...shows.map((e) => `/shows/${e.slug}/`), "/about/", "/cv/", "/contact/", ...(posts.length ? ["/journal/", ...posts.map((p) => `/journal/${p.slug}/`)] : []), ...chaptersShown().map((s) => `/chapters/${s.slug}/`), ...(booksShown().length ? ["/sketchbooks/", ...booksShown().map((b) => `/sketchbooks/${b.slug}/`)] : []), ...works.map((w) => `/works/${w.slug}/`)];
files["sitemap.xml"] = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">${urls.map((u) => `<url><loc>${SITE}${u}</loc></url>`).join("")}</urlset>`;
files["robots.txt"] = `User-agent: *\nDisallow: /admin/\nDisallow: /c/\nSitemap: ${SITE}/sitemap.xml\n`;
// Old WordPress URLs -> new pages
files["_redirects"] = [
  "/index.php/archive/* /works/ 301",
  "/index.php/archive /works/ 301",
  "/index.php/chapters/* /chapters/ 301",
  "/index.php/roots-early-years/* /chapters/roots/ 301",
  "/index.php/evolving-lines/* /chapters/evolving-lines/ 301",
  "/index.php/media-life/* /chapters/ 301",
  "/index.php/lines-of-life/* /chapters/lines-of-life/ 301",
  "/index.php/biography/* /about/ 301",
  "/index.php/exhibitions/* /shows/ 301",
  "/index.php/journal/* /about/ 301",
  "/index.php/contact/* /contact/ 301",
  "/index.php/* / 301",
  // linesof.life is forwarded here with its path kept: each old show page goes to the same show on this site.
  ...[...new Map(shows.filter((e) => e.original_url).map((e) => [new URL(e.original_url).pathname, e.slug])).entries()].filter(([p]) => p.length > 1).map(([p, slug]) => `${p} /shows/${slug}/ 301`),
  "/category/shows/* /shows/ 301",
  "/category/* /shows/ 301",
].join("\n") + "\n";
files["_headers"] = "/assets/*\n  Cache-Control: public, max-age=86400\n/admin/*\n  X-Robots-Tag: noindex\n/c/*\n  X-Robots-Tag: noindex\n";

// About / CV ------------------------------------------------------------------------
const portrait = C.portrait?.en;
files["about/index.html"] = page({
  title: "About and CV | Tanvirul Islam Mithu",
  desc: "Biography and CV of Bangladeshi painter Tanvirul Islam Mithu (Artistmithu): education, solo exhibitions and web shows, group exhibitions, awards and collections.",
  path: "/about/",
  image: portrait ? img(portrait) : undefined,
  body: `<div class="wrap about"><h1 class="page-title">${bi(["About", "পরিচিতি"])}</h1>
  <div class="about-top">${portrait ? `<img class="portrait" src="${img(portrait)}" alt="Tanvirul Islam Mithu">` : ""}
  <div class="prose">${C.statement ? `<blockquote class="statement">${biText(C.statement, paras)}</blockquote>` : ""}${biText(C.bio, paras)}
  <p><a class="btn" href="/cv/">${bi(["CV (one page, PDF)", "সিভি (এক পাতায়, PDF)"])}</a>${C.cv_pdf?.en ? ` <a class="btn alt" href="${img(C.cv_pdf.en)}" download>${bi(["Download CV file", "সিভি ফাইল ডাউনলোড"])}</a>` : ""}</p></div></div>
  ${C.studio_video?.en ? `<figure class="studio-video"><video controls playsinline preload="none" poster="${img(C.studio_video.en.replace(/\.mp4$/, ".jpg"))}" src="${img(C.studio_video.en)}"></video>${C.studio_video_caption?.en ? `<figcaption>${bi([esc(C.studio_video_caption.en), esc(C.studio_video_caption.bn || C.studio_video_caption.en)])}</figcaption>` : ""}</figure>` : ""}
  ${photoGrid(studio.filter((p) => !p.series_id), ["In the studio", "স্টুডিওতে"])}
  <div class="cvgrid">
  ${C.education ? `<section><h2 class="sec">${bi(["Education", "শিক্ষা"])}</h2>${biList(C.education)}</section>` : ""}
  <section><h2 class="sec">${bi(["Solo exhibitions and web shows", "একক প্রদর্শনী ও ওয়েব শো"])}</h2><ul class="ex">${soloShows.map(showLine).join("")}</ul></section>
  ${groupShows.length ? `<section><h2 class="sec">${bi(["Group exhibitions", "যৌথ প্রদর্শনী"])}</h2><ul class="ex">${groupShows.map(showLine).join("")}</ul></section>` : ""}
  ${C.awards ? `<section><h2 class="sec">${bi(["Awards and fellowships", "পুরস্কার ও ফেলোশিপ"])}</h2>${biList(C.awards)}</section>` : ""}
  ${C.collections ? `<section><h2 class="sec">${bi(["Collections", "সংগ্রহ"])}</h2>${biList(C.collections)}</section>` : ""}
  ${C.workshops ? `<section><h2 class="sec">${bi(["Workshops", "কর্মশালা"])}</h2>${biList(C.workshops)}</section>` : ""}
  </div></div>`,
});

// CV: one printable page in English, the form fellowship juries ask for. "Save as PDF" prints it.
{
  const yr = (e) => (e.start_date || "").slice(0, 4);
  const place = (e) => [e.venue, e.city, e.country].filter(Boolean).join(", ");
  const exLine = (e) => `<li><span class="y">${yr(e)}</span><span><a href="${SITE}/shows/${e.slug}/"><i>${esc(e.title)}</i></a>${place(e) ? `, ${esc(place(e))}` : ""}</span></li>`;
  const yrList = (r) => r?.en ? `<ul class="cvl">${lines(r.en).map((l) => { const m = l.match(/^(\S+)(?:\s{2,}|\t)(.+)$/); return m ? `<li><span class="y">${m[1]}</span><span>${m[2]}</span></li>` : `<li><span class="y"></span><span>${l}</span></li>`; }).join("")}</ul>` : "";
  const byDate = (a, b) => String(b.start_date).localeCompare(String(a.start_date));
  const email = C.email?.en?.trim();
  files["cv/index.html"] = page({
    title: "CV | Tanvirul Islam Mithu",
    desc: "Curriculum vitae of Bangladeshi visual artist Tanvirul Islam Mithu: education, solo exhibitions and web shows, group exhibitions, fellowships and collections.",
    path: "/cv/",
    body: `<div class="wrap cv"><p class="noprint"><button type="button" class="btn" onclick="print()">${bi(["Save as PDF / Print", "PDF হিসেবে সেভ / প্রিন্ট"])}</button> <a class="btn alt" href="/about/">${bi(["Biography", "জীবনী"])}</a></p>
    <h1>Tanvirul Islam Mithu</h1><p class="who">Visual artist · Dhaka, Bangladesh · Born 1970s</p>
    <p class="contact">${email ? `<a href="mailto:${esc(email)}">${esc(email)}</a> · ` : ""}<a href="${SITE}/">${SITE.replace(/^https?:\/\//, "")}</a>${WHATSAPP ? ` · +${WHATSAPP}` : ""}</p>
    ${C.education ? `<h2>Education</h2>${yrList(C.education)}` : ""}
    ${soloShows.length ? `<h2>Solo exhibitions and web shows</h2><ul class="cvl">${[...soloShows].sort(byDate).map(exLine).join("")}</ul>` : ""}
    ${groupShows.length ? `<h2>Selected group exhibitions</h2><ul class="cvl">${[...groupShows].sort(byDate).map(exLine).join("")}</ul>` : ""}
    ${C.awards ? `<h2>Fellowships and awards</h2>${yrList(C.awards)}` : ""}
    ${C.collections ? `<h2>Collections</h2>${yrList(C.collections)}` : ""}
    ${C.workshops ? `<h2>Workshops</h2>${yrList(C.workshops)}` : ""}
    <h2>Online</h2><ul class="cvl"><li><span class="y"></span><span>Portfolio and archive: <a href="${SITE}/">${SITE.replace(/^https?:\/\//, "")}</a> (${works.length} works)</span></li><li><span class="y"></span><span>Web shows: linesof.life</span></li></ul>
    </div>`,
  });
}

// Journal ----------------------------------------------------------------------------
const postDate = (p) => fmtDate(p.published_at);
const postCard = (p) => `<a class="show" href="/journal/${p.slug}/">${p.cover_path ? `<img src="${img(p.cover_path)}" alt="" loading="lazy">` : `<span class="empty"></span>`}<span class="eyebrow">${postDate(p)}</span><strong>${esc(p.title_en)}</strong>${p.title_bn ? `<small lang="bn">${esc(p.title_bn)}</small>` : ""}</a>`;
if (posts.length) {
  files["journal/index.html"] = page({
    title: "Journal | Tanvirul Islam Mithu",
    desc: "News, new works, exhibitions and studio notes from Tanvirul Islam Mithu.",
    path: "/journal/",
    body: `<div class="wrap"><h1 class="page-title">${bi(["Journal", "জার্নাল"])}</h1><div class="shows">${posts.map(postCard).join("")}</div></div>`,
  });
  posts.forEach((p, i) => {
    const v = yt(p.youtube_url);
    files[`journal/${p.slug}/index.html`] = page({
      title: `${p.title_en} | Tanvirul Islam Mithu`,
      desc: (p.body_en || p.title_en).replace(/\s+/g, " ").slice(0, 155),
      path: `/journal/${p.slug}/`,
      image: p.cover_path ? img(p.cover_path) : undefined,
      jsonld: { "@context": "https://schema.org", "@type": "BlogPosting", headline: p.title_en, datePublished: p.published_at, author: { "@type": "Person", name: "Tanvirul Islam Mithu" }, image: p.cover_path ? img(p.cover_path) : undefined, url: `${SITE}/journal/${p.slug}/` },
      body: `<article class="wrap prose post"><p class="eyebrow"><a href="/journal/">${bi(["Journal", "জার্নাল"])}</a> · ${postDate(p)}</p>
      <h1 class="page-title">${bi([esc(p.title_en), esc(p.title_bn || p.title_en)])}</h1>
      ${p.cover_path ? `<img class="cover" src="${img(p.cover_path)}" alt="">` : ""}
      ${biText({ en: p.body_en, bn: p.body_bn }, paras)}
      ${v ? `<div class="video"><iframe src="https://www.youtube-nocookie.com/embed/${v}" title="${esc(p.title_en)}" loading="lazy" allowfullscreen></iframe></div>` : ""}
      ${(p.images || []).map((x) => `<img class="cover" src="${img(x)}" alt="" loading="lazy">`).join("")}
      <nav class="prevnext">${posts[i + 1] ? `<a href="/journal/${posts[i + 1].slug}/">← ${esc(posts[i + 1].title_en)}</a>` : "<span></span>"}${posts[i - 1] ? `<a href="/journal/${posts[i - 1].slug}/">${esc(posts[i - 1].title_en)} →</a>` : ""}</nav></article>`,
    });
  });
}

await rm(OUT, { recursive: true, force: true });
await cp("public", OUT, { recursive: true });
await cp("admin", join(OUT, "admin"), { recursive: true });
// The artist's logo (moved from the old WordPress site into storage) becomes the site icon.
try {
  if (fx) throw new Error("offline");
  const r = await fetch(img("site/logo-270.jpg"));
  if (!r.ok) throw new Error(String(r.status));
  await writeFile(join(OUT, "assets/logo.jpg"), Buffer.from(await r.arrayBuffer()));
} catch (e) { console.log("Logo not fetched, using the placeholder icon:", e.message); await cp("public/assets/icon-512.png", join(OUT, "assets/logo.jpg")); }
for (const [p, content] of Object.entries(files)) {
  const f = join(OUT, p);
  await mkdir(dirname(f), { recursive: true });
  await writeFile(f, content);
}
console.log(`Wrote ${Object.keys(files).length} files to ${OUT}/`);
