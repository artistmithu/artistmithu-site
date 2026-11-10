// Static site generator for artistmithu.com.
// Reads the catalogue from Supabase at build time and writes plain HTML to ./dist.
// Cloudflare Pages: build command `npm run build`, output directory `dist`.
import { mkdir, writeFile, cp, rm } from "node:fs/promises";
import { dirname, join } from "node:path";

const SUPABASE_URL = process.env.SUPABASE_URL || "https://msbgnvltxoxrnvuriiez.supabase.co";
// Publishable key: safe to ship in the browser; row level security protects the data.
const SUPABASE_KEY = process.env.SUPABASE_PUBLISHABLE_KEY || "sb_publishable_vxt7vC2yHGGhMON90ZFnBw_PehR5Qod";
const SITE = "https://artistmithu.com";
const WHATSAPP = process.env.WHATSAPP_NUMBER || ""; // e.g. 8801XXXXXXXXX
const OUT = "dist";

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

function page({ title, desc, path, body, image, jsonld }) {
  const url = SITE + path;
  return `<!doctype html>
<html lang="en" data-lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>${esc(title)}</title>
<meta name="description" content="${esc(desc)}">
<link rel="canonical" href="${url}">
<meta property="og:type" content="website"><meta property="og:title" content="${esc(title)}">
<meta property="og:description" content="${esc(desc)}"><meta property="og:url" content="${url}">
${image ? `<meta property="og:image" content="${image}"><meta name="twitter:card" content="summary_large_image">` : ""}
<link rel="manifest" href="/manifest.webmanifest"><meta name="theme-color" content="#18203a">
<link rel="icon" href="/assets/icon.svg" type="image/svg+xml"><link rel="apple-touch-icon" href="/assets/icon-192.png">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anek+Bangla:wght@300;500;700;800&family=Hind+Siliguri:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500&display=swap">
<link rel="stylesheet" href="/assets/site.css">
${jsonld ? `<script type="application/ld+json">${JSON.stringify(jsonld)}</script>` : ""}
</head>
<body>
<header class="top"><div class="wrap">
  <a class="brand" href="/">Tanvirul Islam Mithu<small>${bi(["Painter · Dhaka", "চিত্রশিল্পী · ঢাকা"])}</small></a>
  <nav class="main">
    <a href="/works/">${bi(["Works", "কাজ"])}</a>
    <a href="/chapters/">${bi(["Chapters", "অধ্যায়"])}</a>
    <a href="/shows/">${bi(["Shows", "প্রদর্শনী"])}</a>
    <a href="/videos/">${bi(["Videos", "ভিডিও"])}</a>
    <a href="/about/">${bi(["About", "পরিচিতি"])}</a>
    <a href="/contact/">${bi(["Contact", "যোগাযোগ"])}</a>
  </nav>
  <button class="lang" id="langBtn" type="button"><span lang="bn">English</span><span lang="en">বাংলা</span></button>
</div></header>
<main>${body}</main>
<footer><div class="wrap">
  <form class="subscribe" id="subscribe"><label for="subEmail">${bi(["New works and shows by email", "নতুন কাজ ও প্রদর্শনীর খবর ইমেইলে"])}</label>
    <div><input id="subEmail" type="email" required placeholder="you@example.com"><button type="submit">${bi(["Subscribe", "সাবস্ক্রাইব"])}</button></div>
    <p class="note" id="subNote" hidden></p></form>
  <div class="social"><a href="https://www.facebook.com/artistmithu2022" rel="noopener">Facebook</a> · <a href="https://www.instagram.com/artistmithu/" rel="noopener">Instagram</a> · <a href="https://twitter.com/artistmithu" rel="noopener">X</a> · <a href="https://www.youtube.com/@artistmithu" rel="noopener">YouTube</a>
  <p class="note">© ${new Date().getFullYear()} Tanvirul Islam Mithu · <a href="/admin/" rel="nofollow" style="color:inherit">${bi(["Studio login", "স্টুডিও লগইন"])}</a></p></div>
</div></footer>
<div class="tray" id="tray" hidden><div class="wrap"><strong id="trayCount"></strong><a class="btn light" id="trayEnquire" href="/contact/">${bi(["Enquire about these", "এগুলো নিয়ে জিজ্ঞাসা"])}</a><button type="button" class="btn ghost" id="trayClear">${bi(["Clear", "মুছুন"])}</button></div></div>
<script>window.CFG=${JSON.stringify({ url: SUPABASE_URL, key: SUPABASE_KEY, wa: WHATSAPP })}</script>
<script src="/assets/site.js" defer></script>
</body></html>`;
}

function card(w) {
  const im = w.images[0];
  return `<article class="card" data-size="${w.size_class || "unknown"}" data-series="${w.series?.slug || ""}" data-status="${w.status}" data-id="${w.id}">
  <a class="frame" href="/works/${w.slug}/">${im ? `<img src="${img(im.path)}" alt="${esc(w.title_en)}" loading="lazy"${im.width ? ` width="${im.width}" height="${im.height}"` : ""}>` : ""}</a>
  <button type="button" class="fav" aria-pressed="false" aria-label="Shortlist">+</button>
  <div class="meta"><h3><a href="/works/${w.slug}/">${esc(w.title_en)}</a>${w.title_bn ? `<small lang="bn">${esc(w.title_bn)}</small>` : ""}</h3><span class="yr">${w.year || ""}</span></div>
  <div class="sub">${esc(w.medium || "")}${w.height_cm ? ` · ${+w.height_cm} × ${+w.width_cm} cm` : ""}</div>
  <div class="sub"><span class="pill ${w.status}">${bi(STATUS[w.status])}</span><span class="price">${priceText(w)}</span></div>
</article>`;
}

const filters = () => `<div class="controls"><div class="wrap">
 <div class="group" data-filter="size"><span class="label">${bi(["Size", "আকার"])}</span>
  <button class="chip" data-v="all" aria-pressed="true">${bi(["All", "সব"])}</button>
  <button class="chip" data-v="small" aria-pressed="false">${bi(SIZE.small)} &lt;40cm</button>
  <button class="chip" data-v="medium" aria-pressed="false">${bi(SIZE.medium)} 40–90</button>
  <button class="chip" data-v="large" aria-pressed="false">${bi(SIZE.large)} &gt;90cm</button></div>
 <div class="group" data-filter="series"><span class="label">${bi(["Chapter", "অধ্যায়"])}</span>
  <button class="chip" data-v="all" aria-pressed="true">${bi(["All", "সব"])}</button>
  ${series.filter((s) => works.some((w) => w.series_id === s.id)).map((s) => `<button class="chip" data-v="${s.slug}" aria-pressed="false">${bi([esc(s.title_en), esc(s.title_bn || s.title_en)])}</button>`).join("")}</div>
 <div class="group" data-filter="status"><span class="label">${bi(["Status", "অবস্থা"])}</span>
  <button class="chip" data-v="all" aria-pressed="true">${bi(["All", "সব"])}</button>
  <button class="chip" data-v="available" aria-pressed="false">${bi(["For sale", "বিক্রির জন্য"])}</button></div>
 <span class="count" id="count"></span>
</div></div>`;

const files = {};
const featured = works.filter((w) => w.featured).slice(0, 6);
const heroImg = featured[0]?.images[0];

files["index.html"] = page({
  title: "Tanvirul Islam Mithu | Bangladeshi Painter & Visual Artist",
  desc: "Paintings and drawings by Bangladeshi artist Tanvirul Islam Mithu: forty years of lines, from Dhaka streets to the Janogon series. View sizes and prices, and enquire directly.",
  path: "/",
  image: heroImg ? img(heroImg.path) : undefined,
  jsonld: { "@context": "https://schema.org", "@type": "Person", name: "Tanvirul Islam Mithu", alternateName: "Artist Mithu", jobTitle: "Visual Artist", url: SITE, alumniOf: "University of Dhaka", sameAs: ["https://www.facebook.com/artistmithu2022", "https://www.instagram.com/artistmithu/", "https://twitter.com/artistmithu", "https://www.youtube.com/@artistmithu"] },
  body: `<section class="hero"><div class="wrap">
  <div><h1>${bi(["Forty years of <b>lines</b>, in one place", "চল্লিশ বছরের <b>রেখা</b>, এক জায়গায়"])}</h1>
  <p>${bi(["Pen, watercolor, oil and acrylic: the people, streets and life of Dhaka. See size, medium, year and price for every work, shortlist what you like and talk to the artist directly.", "কাগজে কলম, জলরং, তেলরং আর অ্যাক্রিলিকে ঢাকার মানুষ, রাস্তা ও জীবনের ছবি। প্রতিটি কাজের মাপ, মাধ্যম, সাল ও দাম দেখুন, পছন্দের কাজ বেছে সরাসরি শিল্পীর সাথে কথা বলুন।"])}</p>
  <div class="facts"><div><strong>40+</strong>${bi(["years of practice", "বছরের চর্চা"])}</div><div><strong>2013</strong>${bi(["Bangladesh's first solo web show", "দেশের প্রথম একক ওয়েব শো"])}</div><div><strong>${works.length}</strong>${bi(["works online", "কাজ অনলাইনে"])}</div></div>
  <p><a class="btn" href="/works/">${bi(["See the works", "কাজগুলো দেখুন"])}</a></p></div>
  ${heroImg ? `<a class="hero-img" href="/works/${featured[0].slug}/"><img src="${img(heroImg.path)}" alt="${esc(featured[0].title_en)}"></a>` : ""}
  </div></section>
  <section class="wrap"><h2 class="sec">${bi(["Selected works", "নির্বাচিত কাজ"])}</h2><div class="grid">${featured.map(card).join("")}</div></section>
  <section class="wrap"><h2 class="sec">${bi(["Chapters of a life", "জীবনের অধ্যায়"])}</h2><div class="chapters">
  ${series.map((s) => { const n = works.filter((w) => w.series_id === s.id); const cover = n[0]?.images[0]; return `<a class="chapter" href="/chapters/${s.slug}/">${cover ? `<img src="${img(cover.path)}" alt="" loading="lazy">` : `<span class="empty"></span>`}<strong>${esc(s.title_en)}</strong><small lang="bn">${esc(s.title_bn || "")}</small><span class="note">${n.length} ${n.length === 1 ? "work" : "works"}</span></a>`; }).join("")}
  </div></section>`,
});

files["works/index.html"] = page({
  title: "Works | Tanvirul Islam Mithu",
  desc: "All available and archived works by Tanvirul Islam Mithu, filterable by size, chapter and availability.",
  path: "/works/",
  body: `<div class="wrap"><h1 class="page-title">${bi(["Works", "কাজ"])}</h1></div>${filters()}<div class="wrap"><div class="grid" id="grid">${works.map(card).join("")}</div></div>`,
});

files["chapters/index.html"] = page({
  title: "Chapters | Tanvirul Islam Mithu",
  desc: "Four chapters of Tanvirul Islam Mithu's practice: Roots, Evolving Lines, Media Life and Lines of Life.",
  path: "/chapters/",
  body: `<div class="wrap"><h1 class="page-title">${bi(["Chapters", "অধ্যায়"])}</h1><div class="chapters">${series.map((s) => { const n = works.filter((w) => w.series_id === s.id); const cover = n[0]?.images[0]; return `<a class="chapter" href="/chapters/${s.slug}/">${cover ? `<img src="${img(cover.path)}" alt="" loading="lazy">` : `<span class="empty"></span>`}<strong>${esc(s.title_en)}</strong><small lang="bn">${esc(s.title_bn || "")}</small><span class="note">${n.length} works</span></a>`; }).join("")}</div></div>`,
});

for (const s of series) {
  const list = works.filter((w) => w.series_id === s.id);
  files[`chapters/${s.slug}/index.html`] = page({
    title: `${s.title_en} | Tanvirul Islam Mithu`,
    desc: s.description_en || `${s.title_en}: ${list.length} works by Tanvirul Islam Mithu.`,
    path: `/chapters/${s.slug}/`,
    body: `<div class="wrap"><p class="eyebrow"><a href="/chapters/">${bi(["Chapters", "অধ্যায়"])}</a></p><h1 class="page-title">${esc(s.title_en)} <small lang="bn">${esc(s.title_bn || "")}</small></h1>
    ${s.description_en ? `<p class="lead">${esc(s.description_en)}</p>` : ""}
    ${list.length ? `<div class="grid">${list.map(card).join("")}</div>` : `<p class="note">${bi(["Works for this chapter are being added.", "এই অধ্যায়ের কাজ যোগ করা হচ্ছে।"])}</p>`}</div>`,
  });
}

for (const w of works) {
  const main = w.images[0];
  const desc = `${w.title_en}${w.year ? ` (${w.year})` : ""}, ${w.medium || "artwork"}${w.height_cm ? `, ${+w.height_cm} × ${+w.width_cm} cm` : ""} by Tanvirul Islam Mithu.`;
  const waText = encodeURIComponent(`Hello, I am interested in "${w.title_en}" (${w.inv_no}). ${SITE}/works/${w.slug}/`);
  const related = works.filter((x) => x.series_id === w.series_id && x.id !== w.id).slice(0, 4);
  files[`works/${w.slug}/index.html`] = page({
    title: `${w.title_en}${w.year ? `, ${w.year}` : ""} | Tanvirul Islam Mithu`,
    desc,
    path: `/works/${w.slug}/`,
    image: main ? img(main.path) : undefined,
    jsonld: { "@context": "https://schema.org", "@type": "VisualArtwork", name: w.title_en, creator: { "@type": "Person", name: "Tanvirul Islam Mithu" }, dateCreated: w.year || undefined, artMedium: w.medium || undefined, height: w.height_cm ? { "@type": "Distance", name: `${+w.height_cm} cm` } : undefined, width: w.width_cm ? { "@type": "Distance", name: `${+w.width_cm} cm` } : undefined, image: main ? img(main.path) : undefined, url: `${SITE}/works/${w.slug}/` },
    body: `<div class="wrap"><p class="eyebrow"><a href="/works/">${bi(["Works", "কাজ"])}</a>${w.series ? ` / <a href="/chapters/${w.series.slug}/">${esc(w.series.title_en)}</a>` : ""}</p>
    <div class="detail" data-id="${w.id}">
      <div class="big">${w.images.map((i, n) => `<a href="${img(i.path)}" target="_blank" rel="noopener"><img src="${img(i.path)}" alt="${esc(i.alt_en || w.title_en)}"${n ? ' loading="lazy"' : ""}${i.width ? ` width="${i.width}" height="${i.height}"` : ""}></a>`).join("")}</div>
      <div class="info">
        <h1>${esc(w.title_en)}</h1>${w.title_bn ? `<div class="bn" lang="bn">${esc(w.title_bn)}</div>` : ""}
        <dl class="spec">
          <dt>${bi(["Inventory", "ইনভেন্টরি"])}</dt><dd class="mono">${esc(w.inv_no)}</dd>
          ${w.year ? `<dt>${bi(["Year", "সাল"])}</dt><dd>${w.year}</dd>` : ""}
          ${w.medium ? `<dt>${bi(["Medium", "মাধ্যম"])}</dt><dd>${esc(w.medium)}</dd>` : ""}
          <dt>${bi(["Size", "মাপ"])}</dt><dd>${sizeText(w)}${w.size_class ? ` · ${bi(SIZE[w.size_class])}` : ""}</dd>
          ${w.edition ? `<dt>${bi(["Edition", "সংস্করণ"])}</dt><dd>${esc(w.edition)}</dd>` : ""}
          <!--SHOWS-->
          <dt>${bi(["Status", "অবস্থা"])}</dt><dd><span class="pill ${w.status}">${bi(STATUS[w.status])}</span></dd>
          ${priceText(w) ? `<dt>${bi(["Price", "দাম"])}</dt><dd class="price">${priceText(w, { note: true })}</dd>` : ""}
        </dl>
        ${w.description_en && w.description_en !== w.title_en ? `<p class="lead">${esc(w.description_en)}</p>` : ""}
        <div class="actions">
          <a class="btn" href="https://wa.me/${WHATSAPP}?text=${waText}" rel="noopener">${bi(["Enquire on WhatsApp", "WhatsApp-এ জিজ্ঞাসা"])}</a>
          <button type="button" class="btn alt fav-detail">${bi(["Add to shortlist", "পছন্দের তালিকায়"])}</button>
          <button type="button" class="btn alt share">${bi(["Share", "শেয়ার"])}</button>
        </div>
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

files["about/index.html"] = page({
  title: "About | Tanvirul Islam Mithu",
  desc: "Biography of Bangladeshi painter Tanvirul Islam Mithu: University of Dhaka, first solo exhibition in 2001, Bangladesh's first solo web show in 2013.",
  path: "/about/",
  body: `<div class="wrap prose"><h1 class="page-title">${bi(["About", "পরিচিতি"])}</h1>
  <p>Tanvirul Islam Mithu began drawing as a child, copying illustrations from books. In 1991 he met S.M. Sultan in Narail, who gave him a signed pencil sketch. He studied Drawing and Painting at the University of Dhaka from 1992 and graduated in 2001, the year of his first solo exhibition.</p>
  <p>Around 2000 he moved into graphic design and media. In 2013 he took part in the USA Media Fellowship, and on 16 December 2013 he opened <em>Transparent Boundary</em>, Bangladesh's first solo web show. He launched <em>Lines of Life</em> in 2017 and has since held seven web shows.</p>
  <h2 class="sec">${bi(["Exhibitions and web shows", "প্রদর্শনী ও ওয়েব শো"])}</h2>
  ${exhibitions.length ? `<ul class="ex">${exhibitions.map((e) => `<li><span class="mono">${e.start_date ? e.start_date.slice(0, 4) : ""}</span> ${e.slug ? `<a href="/shows/${e.slug}/">${esc(e.title)}</a>` : esc(e.title)}${e.venue ? `, ${esc(e.venue)}` : ""}${e.city ? `, ${esc(e.city)}` : ""}</li>`).join("")}</ul>` : `<p class="note">List coming soon.</p>`}
  </div>`,
});

files["contact/index.html"] = page({
  title: "Contact | Tanvirul Islam Mithu",
  desc: "Contact Tanvirul Islam Mithu about artworks, commissions and exhibitions.",
  path: "/contact/",
  body: `<div class="wrap prose"><h1 class="page-title">${bi(["Contact", "যোগাযোগ"])}</h1>
  <p>${bi(["Ask about a work, a commission or an exhibition. Replies usually within a day.", "কোনো কাজ, অর্ডারে আঁকা বা প্রদর্শনী নিয়ে জানতে লিখুন। সাধারণত এক দিনের মধ্যে উত্তর দেওয়া হয়।"])}</p>
  ${WHATSAPP ? `<p><a class="btn" href="https://wa.me/${WHATSAPP}" rel="noopener">WhatsApp</a></p>` : ""}
  <form class="enq" id="contactForm"><input name="name" required placeholder="Name / নাম"><input name="contact" required placeholder="Email or phone / ইমেইল বা ফোন">
  <textarea name="message" rows="5" placeholder="Message / বার্তা"></textarea><button class="btn" type="submit">${bi(["Send", "পাঠান"])}</button><p class="note" hidden></p></form></div>`,
});

files["c/index.html"] = page({
  title: "Selected for you | Tanvirul Islam Mithu",
  desc: "A private selection of works.",
  path: "/c/",
  body: `<div class="wrap"><p class="eyebrow">${bi(["Selected for you by the artist", "শিল্পী আপনার জন্য বাছাই করেছেন"])}</p><h1 class="page-title" id="cTitle">${bi(["Works chosen for you", "আপনার জন্য নির্বাচিত কাজ"])}</h1><p class="lead" id="cNote"></p><div class="grid" id="cGrid"><p class="note">Loading…</p></div></div>`,
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

files["shows/index.html"] = page({
  title: "Shows | Tanvirul Islam Mithu",
  desc: "Web shows and exhibitions by Tanvirul Islam Mithu, from Transparent Boundary (2013), Bangladesh's first solo web show, to today.",
  path: "/shows/",
  body: `<div class="wrap"><h1 class="page-title">${bi(["Shows", "প্রদর্শনী"])}</h1>
  <p class="lead">${bi(["Since 2013 Mithu has opened his solo shows on the web first. Each show below keeps its statement, works and video.", "২০১৩ সাল থেকে মিঠু তাঁর একক প্রদর্শনী প্রথমে ওয়েবে খুলে আসছেন। নিচের প্রতিটি শো-তে আছে তার বক্তব্য, কাজ ও ভিডিও।"])}</p>
  ${shows.length ? Object.keys(byYear).sort().reverse().map((y) => `<h2 class="sec mono-year">${y}</h2><div class="shows">${byYear[y].map((e) => { const c = showCover(e); const n = showLinks.filter((x) => x.exhibition_id === e.id && worksById[x.artwork_id]).length; return `<a class="show" href="/shows/${e.slug}/">${c ? `<img src="${c}" alt="" loading="lazy">` : `<span class="empty"></span>`}<span class="eyebrow">${bi(KIND[e.kind] || [e.kind, e.kind])}</span><strong>${esc(e.title)}</strong>${e.title_bn ? `<small lang="bn">${esc(e.title_bn)}</small>` : ""}<span class="note">${dateRange(e)}${n ? ` · ${n} works` : ""}</span></a>`; }).join("")}</div>`).join("") : `<p class="note">${bi(["The show archive is being added.", "প্রদর্শনীর আর্কাইভ যোগ করা হচ্ছে।"])}</p>`}
  </div>`,
});

const ordered = [...shows].sort((a, b) => String(a.start_date).localeCompare(String(b.start_date)));
ordered.forEach((e, i) => {
  const list = showLinks.filter((x) => x.exhibition_id === e.id).sort((a, b) => a.sort - b.sort).map((x) => worksById[x.artwork_id]).filter(Boolean);
  const vid = yt(e.youtube_url), prev = ordered[i - 1], next = ordered[i + 1], c = showCover(e);
  files[`shows/${e.slug}/index.html`] = page({
    title: `${e.title}${e.start_date ? `, ${e.start_date.slice(0, 4)}` : ""} | Tanvirul Islam Mithu`,
    desc: (e.statement_en || `${e.title}: ${(KIND[e.kind] || [e.kind])[0]} by Tanvirul Islam Mithu.`).slice(0, 160),
    path: `/shows/${e.slug}/`,
    image: c || undefined,
    jsonld: { "@context": "https://schema.org", "@type": "ExhibitionEvent", name: e.title, startDate: e.start_date || undefined, endDate: e.end_date || undefined, eventAttendanceMode: e.kind === "web-show" ? "https://schema.org/OnlineEventAttendanceMode" : "https://schema.org/OfflineEventAttendanceMode", location: e.kind === "web-show" ? { "@type": "VirtualLocation", url: `${SITE}/shows/${e.slug}/` } : { "@type": "Place", name: e.venue || e.city || "", address: [e.city, e.country].filter(Boolean).join(", ") }, organizer: { "@type": "Person", name: "Tanvirul Islam Mithu" }, image: c || undefined, url: `${SITE}/shows/${e.slug}/` },
    body: `<div class="wrap"><p class="eyebrow"><a href="/shows/">${bi(["Shows", "প্রদর্শনী"])}</a> / ${bi(KIND[e.kind] || [e.kind, e.kind])}</p>
    <h1 class="page-title">${esc(e.title)}${e.title_bn ? ` <small lang="bn">${esc(e.title_bn)}</small>` : ""}</h1>
    <p class="note">${dateRange(e)}${e.venue ? ` · ${esc(e.venue)}` : ""}${e.city ? `, ${esc(e.city)}` : ""}</p>
    <div class="show-head">
      ${vid ? `<div class="video"><iframe src="https://www.youtube-nocookie.com/embed/${vid}" title="${esc(e.title)}" loading="lazy" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture; fullscreen" allowfullscreen></iframe></div>` : c ? `<img class="show-cover" src="${c}" alt="${esc(e.title)}">` : ""}
      <div class="prose">
        ${e.statement_en ? `<div lang="en">${esc(e.statement_en).split(/\n{2,}/).map((p) => `<p>${p}</p>`).join("")}</div>` : ""}
        ${e.statement_bn ? `<div lang="bn">${esc(e.statement_bn).split(/\n{2,}/).map((p) => `<p>${p}</p>`).join("")}</div>` : ""}
        <p class="links">${e.wayback_url ? `<a href="${esc(e.wayback_url)}" rel="noopener">${bi(["Archived copy of the original page", "মূল পাতার আর্কাইভ কপি"])}</a>` : ""}</p>
      </div>
    </div>
    ${list.length ? `<h2 class="sec">${bi(["Works in this show", "এই শো-এর কাজ"])}</h2><div class="grid">${list.map(card).join("")}</div>` : ""}
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

const urls = ["/", "/works/", "/chapters/", "/shows/", "/videos/", ...shows.map((e) => `/shows/${e.slug}/`), "/about/", "/contact/", ...series.map((s) => `/chapters/${s.slug}/`), ...works.map((w) => `/works/${w.slug}/`)];
files["sitemap.xml"] = `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">${urls.map((u) => `<url><loc>${SITE}${u}</loc></url>`).join("")}</urlset>`;
files["robots.txt"] = `User-agent: *\nDisallow: /admin/\nDisallow: /c/\nSitemap: ${SITE}/sitemap.xml\n`;
// Old WordPress URLs -> new pages
files["_redirects"] = [
  "/index.php/archive/* /works/ 301",
  "/index.php/archive /works/ 301",
  "/index.php/chapters/* /chapters/ 301",
  "/index.php/roots-early-years/* /chapters/roots/ 301",
  "/index.php/evolving-lines/* /chapters/evolving-lines/ 301",
  "/index.php/media-life/* /chapters/media-life/ 301",
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

await rm(OUT, { recursive: true, force: true });
await cp("public", OUT, { recursive: true });
await cp("admin", join(OUT, "admin"), { recursive: true });
for (const [p, content] of Object.entries(files)) {
  const f = join(OUT, p);
  await mkdir(dirname(f), { recursive: true });
  await writeFile(f, content);
}
console.log(`Wrote ${Object.keys(files).length} files to ${OUT}/`);
