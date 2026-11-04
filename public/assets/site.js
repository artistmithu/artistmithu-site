// Front-end behaviour: language toggle, filters, shortlist, enquiries, client rooms, PWA.
(() => {
  const { url, key, wa } = window.CFG;
  const root = document.documentElement;
  const store = { get(k, d) { try { return JSON.parse(localStorage.getItem(k)) ?? d; } catch { return d; } }, set(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch {} } };
  const rest = (path, opts = {}) => fetch(`${url}/rest/v1/${path}`, { ...opts, headers: { apikey: key, Authorization: `Bearer ${key}`, "Content-Type": "application/json", ...(opts.headers || {}) } });
  const bn = () => root.dataset.lang === "bn";
  const say = (en, b) => (bn() ? b : en);

  // Language
  root.dataset.lang = store.get("lang", "bn");
  root.lang = root.dataset.lang;
  document.getElementById("langBtn")?.addEventListener("click", () => {
    root.dataset.lang = bn() ? "en" : "bn"; root.lang = root.dataset.lang; store.set("lang", root.dataset.lang); updateCount();
  });

  // Filters on /works/
  const state = { size: "all", series: "all", status: "all" };
  const cards = () => [...document.querySelectorAll("#grid .card")];
  function updateCount() {
    const el = document.getElementById("count"); if (!el) return;
    const n = cards().filter((c) => !c.hidden).length;
    el.textContent = say(`${n} works`, `${n}টি কাজ`);
  }
  function applyFilters() {
    cards().forEach((c) => {
      c.hidden = !((state.size === "all" || c.dataset.size === state.size) && (state.series === "all" || c.dataset.series === state.series) && (state.status === "all" || c.dataset.status === state.status));
    });
    updateCount();
  }
  document.querySelectorAll(".group[data-filter]").forEach((g) => {
    g.addEventListener("click", (e) => {
      const b = e.target.closest(".chip"); if (!b) return;
      state[g.dataset.filter] = b.dataset.v;
      g.querySelectorAll(".chip").forEach((x) => x.setAttribute("aria-pressed", x === b));
      applyFilters();
    });
  });
  applyFilters();

  // Shortlist (per visitor) -> enquiry
  let sel = store.get("shortlist", []);
  function renderSel() {
    document.querySelectorAll(".card").forEach((c) => { const on = sel.includes(c.dataset.id); const f = c.querySelector(".fav"); if (f) { f.setAttribute("aria-pressed", on); f.textContent = on ? "✓" : "+"; } });
    const tray = document.getElementById("tray"); if (!tray) return;
    tray.hidden = !sel.length;
    document.getElementById("trayCount").textContent = say(`${sel.length} shortlisted`, `${sel.length}টি পছন্দ করা হয়েছে`);
    document.getElementById("trayEnquire").href = `/contact/?works=${sel.join(",")}`;
  }
  const toggle = (id) => { sel = sel.includes(id) ? sel.filter((x) => x !== id) : [...sel, id]; store.set("shortlist", sel); renderSel(); };
  document.addEventListener("click", (e) => {
    const f = e.target.closest(".fav"); if (f) toggle(f.closest(".card").dataset.id);
    const d = e.target.closest(".fav-detail"); if (d) { toggle(d.closest(".detail").dataset.id); d.textContent = sel.includes(d.closest(".detail").dataset.id) ? "✓" : say("Add to shortlist", "পছন্দের তালিকায়"); }
    const s = e.target.closest(".share"); if (s) { const u = location.href; if (navigator.share) navigator.share({ title: document.title, url: u }).catch(() => {}); else navigator.clipboard?.writeText(u).then(() => (s.textContent = say("Link copied", "লিংক কপি হয়েছে"))); }
  });
  document.getElementById("trayClear")?.addEventListener("click", () => { sel = []; store.set("shortlist", sel); renderSel(); });
  renderSel();

  // Scale drawing: artwork next to a 170 cm person
  document.querySelectorAll(".scale[data-h]").forEach((el) => {
    const h = +el.dataset.h, w = +el.dataset.w, maxH = Math.max(195, 150 + h / 2 + 18), k = 215 / maxH, g = 230, px = 40, ax = 110;
    const ah = h * k, aw = w * k, ay = g - 150 * k - ah / 2;
    el.insertAdjacentHTML("beforeend", `<svg viewBox="0 0 ${Math.max(260, ax + aw + 20)} 240" role="img" aria-label="${h} × ${w} cm">
      <line x1="0" y1="${g}" x2="100%" y2="${g}" stroke="var(--line)" stroke-width="2"/>
      <g fill="var(--ink-soft)"><circle cx="${px}" cy="${g - 160 * k}" r="${10 * k}"/><rect x="${px - 14 * k}" y="${g - 149 * k}" width="${28 * k}" height="${70 * k}" rx="${8 * k}"/>
      <rect x="${px - 12 * k}" y="${g - 80 * k}" width="${10 * k}" height="${80 * k}"/><rect x="${px + 2 * k}" y="${g - 80 * k}" width="${10 * k}" height="${80 * k}"/></g>
      <rect x="${ax}" y="${ay}" width="${aw}" height="${ah}" fill="var(--accent-soft)" stroke="var(--accent)" stroke-width="2"/>
      <text x="${ax}" y="${ay - 6}" font-size="11" font-family="IBM Plex Mono,monospace" fill="var(--ink)">${h} × ${w} cm</text></svg>`);
  });

  // Enquiry forms -> inquiries table
  document.querySelectorAll("form.enq").forEach((f) => {
    f.addEventListener("submit", async (e) => {
      e.preventDefault();
      const fd = new FormData(f), contact = String(fd.get("contact")).trim(), note = f.querySelector(".note");
      const works = new URLSearchParams(location.search).get("works");
      const body = {
        name: fd.get("name"), message: [fd.get("message"), works ? `Shortlist: ${works}` : ""].filter(Boolean).join("\n"),
        email: contact.includes("@") ? contact : null, phone: contact.includes("@") ? null : contact,
        artwork_id: f.dataset.artwork || null, source: "website",
      };
      const r = await rest("inquiries", { method: "POST", body: JSON.stringify(body), headers: { Prefer: "return=minimal" } });
      note.hidden = false;
      note.textContent = r.ok ? say("Thank you. The artist will reply soon.", "ধন্যবাদ। শিল্পী শিগগির উত্তর দেবেন।") : say("Could not send. Please try WhatsApp instead.", "পাঠানো যায়নি। অনুগ্রহ করে WhatsApp-এ লিখুন।");
      if (r.ok) f.reset();
    });
  });

  // Newsletter
  document.getElementById("subscribe")?.addEventListener("submit", async (e) => {
    e.preventDefault();
    const email = document.getElementById("subEmail").value.trim(), note = document.getElementById("subNote");
    const r = await rest("subscribers", { method: "POST", body: JSON.stringify({ email, lang: root.dataset.lang }), headers: { Prefer: "return=minimal,resolution=ignore-duplicates" } });
    note.hidden = false; note.textContent = r.ok || r.status === 409 ? say("Subscribed. Thank you.", "সাবস্ক্রাইব হয়েছে। ধন্যবাদ।") : say("Could not subscribe, please try again.", "সাবস্ক্রাইব হয়নি, আবার চেষ্টা করুন।");
  });

  // Client viewing room: /c/?t=TOKEN
  const cGrid = document.getElementById("cGrid");
  if (cGrid) {
    const t = new URLSearchParams(location.search).get("t");
    (async () => {
      const r = t ? await rest("rpc/get_collection", { method: "POST", body: JSON.stringify({ p_token: t }) }) : null;
      const data = r && r.ok ? await r.json() : null;
      if (!data) { cGrid.innerHTML = `<p class="note">${say("This link has expired or is not valid.", "লিংকটির মেয়াদ শেষ বা সঠিক নয়।")}</p>`; return; }
      if (data.client_name) document.getElementById("cTitle").textContent = say(`Selected for ${data.client_name}`, `${data.client_name}-এর জন্য নির্বাচিত`);
      document.getElementById("cNote").textContent = data.note || "";
      const img = (p) => `${url}/storage/v1/object/public/artworks/${p}`;
      cGrid.innerHTML = data.artworks.map((a) => `<article class="card"><a class="frame" href="/works/${a.slug}/">${a.images?.[0] ? `<img src="${img(a.images[0])}" alt="">` : ""}</a>
        <div class="meta"><h3><a href="/works/${a.slug}/">${a.title_en}</a></h3><span class="yr">${a.year || ""}</span></div>
        <div class="sub">${a.medium || ""}${a.height_cm ? ` · ${+a.height_cm} × ${+a.width_cm} cm` : ""}</div>
        <div class="sub"><span class="pill ${a.status}">${a.status}</span>${a.price_bdt ? `<span class="price">৳ ${Number(a.price_bdt).toLocaleString("en-IN")}${a.price_usd ? ` · US$ ${a.price_usd}` : ""}</span>` : ""}</div>
        <a class="btn" href="https://wa.me/${wa}?text=${encodeURIComponent(`About ${a.title_en} (${a.inv_no})`)}">WhatsApp</a></article>`).join("");
    })();
  }

  // PWA: installable on phones
  if ("serviceWorker" in navigator) navigator.serviceWorker.register("/sw.js").catch(() => {});
})();
