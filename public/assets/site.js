// Front-end behaviour: language toggle, filters, shortlist, enquiries, client rooms, PWA.
(() => {
  const { url, key, wa } = window.CFG;
  const root = document.documentElement;
  const store = { get(k, d) { try { return JSON.parse(localStorage.getItem(k)) ?? d; } catch { return d; } }, set(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch {} } };
  const rest = (path, opts = {}) => fetch(`${url}/rest/v1/${path}`, { ...opts, headers: { apikey: key, Authorization: `Bearer ${key}`, "Content-Type": "application/json", ...(opts.headers || {}) } });
  const bn = () => root.dataset.lang === "bn";
  const say = (en, b) => (bn() ? b : en);
  const esc = (v) => String(v ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));

  // Language
  root.dataset.lang = store.get("lang", "en");
  root.lang = root.dataset.lang;
  document.getElementById("langBtn")?.addEventListener("click", () => {
    root.dataset.lang = bn() ? "en" : "bn"; root.lang = root.dataset.lang; store.set("lang", root.dataset.lang); updateCount();
  });

  // Filters and arrangement on /works/
  const state = { size: "all", kind: "all", status: "all" };
  const grid = document.getElementById("grid");
  const cards = () => [...document.querySelectorAll("#grid .card")];
  function updateCount() {
    const el = document.getElementById("count"); if (!el) return;
    const n = cards().filter((c) => !c.hidden).length;
    el.textContent = say(`${n} works`, `${n}টি কাজ`);
  }
  function applyFilters() {
    cards().forEach((c) => {
      c.hidden = !((state.size === "all" || c.dataset.size === state.size) && (state.kind === "all" || c.dataset.kind === state.kind) && (state.status === "all" || c.dataset.status === state.status));
    });
    document.querySelectorAll("#grid .wgroup").forEach((g) => (g.hidden = !g.querySelector(".card:not([hidden])")));
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
  // "By series" is the page as built. "By year" moves the same cards into year sections, newest first.
  const seriesView = grid ? [...grid.children] : [];
  let yearView = null;
  function arrange(mode) {
    if (!grid) return;
    const all = cards();
    if (mode === "year") {
      if (!yearView) {
        const by = {};
        all.forEach((c) => (by[c.dataset.year || "—"] ||= []).push(c));
        yearView = Object.keys(by).sort((a, b) => (b === "—") - (a === "—") || b - a).map((y) => {
          const sec = document.createElement("section"); sec.className = "wgroup";
          sec.innerHTML = `<header><h2>${y === "—" ? say("Undated", "সাল অজানা") : y}</h2><span class="note">${by[y].length} ${say("works", "টি কাজ")}</span></header><div class="grid"></div>`;
          sec._cards = by[y]; return sec;
        });
      }
      yearView.forEach((sec) => sec.querySelector(".grid").append(...sec._cards));
      grid.replaceChildren(...yearView);
    } else {
      seriesView.forEach((sec) => { const g = sec.querySelector(".grid"); if (g && sec._cards) g.append(...sec._cards); });
      grid.replaceChildren(...seriesView);
    }
    document.querySelector(".jump")?.toggleAttribute("hidden", mode === "year");
    store.set("arrange", mode); applyFilters();
  }
  seriesView.forEach((sec) => (sec._cards = [...sec.querySelectorAll(".card")]));
  const arr = document.querySelector(".group[data-arrange]");
  arr?.addEventListener("click", (e) => {
    const b = e.target.closest(".chip"); if (!b) return;
    arr.querySelectorAll(".chip").forEach((x) => x.setAttribute("aria-pressed", x === b));
    arrange(b.dataset.v);
  });
  if (arr && store.get("arrange", "series") === "year") arr.querySelector('[data-v="year"]')?.click();
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
    const s = e.target.closest(".share"); if (s) { const u = s.dataset.url || location.href; if (navigator.share) navigator.share({ title: document.title, url: u }).catch(() => {}); else navigator.clipboard?.writeText(u).then(() => (s.textContent = say("Link copied", "লিংক কপি হয়েছে"))); }
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
    const about = new URLSearchParams(location.search).get("about");
    if (about && f.message && !f.message.value) f.message.value = `About: ${about}\n`;
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
      const nB = (n) => Number(n).toLocaleString("en-IN"), nU = (n) => Number(n).toLocaleString("en-US");
      const amt = (min, max, f, sym, r) => (min == null ? "" : r && max ? `${sym}${f(min)}–${f(max)}` : `${sym}${f(min)}`);
      const priceOf = (a) => {
        if (a.status === "sold" || a.status === "nfs") return "";
        const m = a.price_mode || (a.price_bdt ? "fixed" : "on_request");
        if (m === "on_request" || (a.price_bdt == null && a.price_usd == null)) return say("Price on request", "দাম জানতে যোগাযোগ");
        const b = amt(a.price_bdt, a.price_bdt_max, nB, "৳ ", m === "range"), u = amt(a.price_usd, a.price_usd_max, nU, "US$ ", m === "range");
        return (bn() ? [b, u] : [u, b]).filter(Boolean).join(" · ");
      };
      const bidding = data.mode === "bidding";
      const cur = data.currency === "USD" ? "US$ " : "৳ ", fmt = data.currency === "USD" ? nU : nB;
      if (bidding) {
        document.getElementById("cTitle").textContent = data.client_name ? say(`Private bidding for ${data.client_name}`, `${data.client_name}-এর জন্য ব্যক্তিগত বিডিং`) : say("Private bidding", "ব্যক্তিগত বিডিং");
        const intro = document.getElementById("cIntro");
        const text = (bn() ? data.intro_bn || data.intro_en : data.intro_en || data.intro_bn) || "";
        intro.hidden = false;
        const allOthers = data.artworks.length && data.artworks.every((x) => x.artist_name);
        const collText = say("These works by other artists come from the private collection of the painter Tanvirul Islam Mithu, Dhaka. The artist, title, medium, size and story of each work are given under its picture.", "এই কাজগুলো ঢাকার চিত্রশিল্পী তানভীরুল ইসলাম মিঠুর ব্যক্তিগত সংগ্রহের, অন্য শিল্পীদের আঁকা। প্রতিটি ছবির নিচে শিল্পীর নাম, কাজের নাম, মাধ্যম, মাপ আর বিবরণ দেওয়া আছে।");
        intro.innerHTML = `<img src="/assets/logo.jpg" alt="" width="64" height="64"><div><strong>${data.artworks.some((x) => x.artist_name) ? say("From the collection of Tanvirul Islam Mithu", "তানভীরুল ইসলাম মিঠুর সংগ্রহ থেকে") : "Tanvirul Islam Mithu"}</strong><p>${esc(text) || (allOthers ? collText : say("Painter and visual artist, Dhaka. MFA in Drawing and Painting, University of Dhaka. First solo exhibition in 2001; Bangladesh's first solo web show in 2013.", "চিত্রশিল্পী, ঢাকা। ঢাকা বিশ্ববিদ্যালয় থেকে ড্রইং ও পেইন্টিংয়ে স্নাতকোত্তর। প্রথম একক প্রদর্শনী ২০০১, দেশের প্রথম একক ওয়েব শো ২০১৩।"))}</p><a href="/about/" target="_blank" rel="noopener">${say("About the artist", "শিল্পী সম্পর্কে")} ↗</a></div>`;
        const rules = document.getElementById("cRules"); rules.hidden = false;
        const closes = data.closes_at ? new Date(data.closes_at).toLocaleString(bn() ? "bn-BD" : "en-GB", { day: "numeric", month: "long", year: "numeric", hour: "numeric", minute: "2-digit" }) : "";
        // Short rules: three lines a collector can take in at a glance.
        const usd = data.currency === "USD";
        rules.innerHTML = `<strong>${say("How to bid", "কীভাবে দাম দেবেন")}</strong><ol>${[
          say(`Write your offer in ${usd ? "US dollars" : "taka"} under the work you like.`, `পছন্দের কাজের নিচে ${usd ? "ডলারে" : "টাকায়"} আপনার দাম লিখুন।`),
          data.show_top_bid ? say("It must be higher than the top bid shown.", "দেখানো সর্বোচ্চ দামের চেয়ে বেশি হতে হবে।") : say("Bids are private: only the artist sees them.", "দাম গোপন থাকবে, শুধু শিল্পী দেখবেন।"),
          say(`The highest bid${closes ? ` on ${closes}` : ""} wins. The artist will call you.`, `${closes ? `${closes}-এ ` : ""}সর্বোচ্চ দাম যাঁর, শিল্পী তাঁকে ফোন করবেন।`),
        ].map((x) => `<li>${x}</li>`).join("")}</ol>`;
      }
      const bidBox = (a) => {
        if (a.status === "sold" || a.status === "nfs") return "";
        const min = a.top_bid != null ? a.top_bid + 1 : a.start_bid;
        const top = `<dl class="bidinfo">${a.start_bid != null ? `<dt>${say("Starting bid", "শুরুর দাম")}</dt><dd>${cur}${fmt(a.start_bid)}</dd>` : ""}
          ${data.show_top_bid ? `<dt>${say("Top bid now", "এখন সর্বোচ্চ দাম")}</dt><dd>${a.top_bid != null ? `<b>${cur}${fmt(a.top_bid)}</b> <small>(${a.bid_count} ${say(a.bid_count === 1 ? "bid" : "bids", "টি দাম")})</small>` : say("No bids yet", "এখনো কোনো দাম পড়েনি")}</dd>` : ""}
          ${min != null ? `<dt>${say("You can bid from", "আপনি দিতে পারেন")}</dt><dd><b>${cur}${fmt(min)}</b>${say(" or more", " বা বেশি")}</dd>` : ""}</dl>`;
        return `<form class="bid" data-id="${a.id}"><div class="top">${top}</div>
          <input name="amount" type="number" inputmode="numeric" min="1" required placeholder="${say("Your offer", "আপনার দাম")} (${cur.trim()})">
          <input name="name" required placeholder="${say("Your name", "আপনার নাম")}" autocomplete="name"><input name="contact" required placeholder="${say("Phone or email", "ফোন বা ইমেইল")}" autocomplete="tel">
          <button class="btn" type="submit">${say("Place bid", "দাম জমা দিন")}</button><p class="note msg" hidden></p></form>`;
      };
      cGrid.innerHTML = data.artworks.map((a) => `<article class="card"><a class="frame" href="${a.images?.[0] ? img(a.images[0]) : "#"}" target="_blank" rel="noopener">${a.images?.[0] ? `<img src="${img(a.images[0])}" alt="${esc(a.title_en)}">` : ""}</a>
        ${(a.images || []).length > 1 ? `<div class="thumbs">${a.images.map((p, i) => `<button type="button" data-src="${img(p)}" class="${i ? "" : "on"}" aria-label="${say("Picture", "ছবি")} ${i + 1}"><img src="${img(p)}" alt="" loading="lazy"></button>`).join("")}</div>` : ""}
        ${a.artist_name ? `<div class="artistline"><span class="label">${say("Artist", "শিল্পী")}</span><strong>${esc(a.artist_name)}</strong>${a.artist_note ? `<p>${esc(a.artist_note)}</p>` : ""}</div>` : ""}<div class="meta"><h3>${esc(a.title_en)}</h3><span class="yr">${a.year || ""}</span></div>
        <dl class="facts">${a.medium ? `<dt>${say("Medium", "মাধ্যম")}</dt><dd>${esc(a.medium)}</dd>` : ""}${a.height_cm ? `<dt>${say("Size", "মাপ")}</dt><dd>${+a.height_cm} × ${+a.width_cm} cm <small>(${(a.height_cm / 2.54).toFixed(1)} × ${(a.width_cm / 2.54).toFixed(1)} in)</small></dd>` : ""}${a.year ? `<dt>${say("Year", "সাল")}</dt><dd>${a.year}</dd>` : ""}</dl>
        ${a.description_en ? (() => { const ps = String(a.description_en).split(/\n\s*\n/).map((x) => x.trim()).filter(Boolean).map((x) => `<p>${esc(x).replace(/\n/g, "<br>")}</p>`); return `<div class="desc">${ps[0]}${ps.length > 1 ? `<details><summary>${say("Read more", "আরও পড়ুন")}</summary>${ps.slice(1).join("")}</details>` : ""}</div>`; })() : ""}
        <div class="sub"><span class="pill ${a.status}">${({ available: say("Available", "উপলব্ধ"), reserved: say("Reserved", "সংরক্ষিত"), sold: say("Sold", "বিক্রিত"), nfs: say("Not for sale", "বিক্রির জন্য নয়") })[a.status] || a.status}</span>${bidding ? "" : `<span class="price">${priceOf(a)}</span>`}</div>
        ${bidding ? bidBox(a) : `<a class="btn" href="https://wa.me/${wa}?text=${encodeURIComponent(`About ${a.artist_name ? `${a.artist_name}, ` : ""}${a.title_en} (${a.inv_no})`)}">WhatsApp</a>`}</article>`).join("");
      // More than one picture of a work: tap a small one to see it large.
      cGrid.addEventListener("click", (e) => {
        const t = e.target.closest(".thumbs button"); if (!t) return;
        const card = t.closest(".card"), fr = card.querySelector(".frame");
        fr.href = t.dataset.src; fr.querySelector("img").src = t.dataset.src;
        card.querySelectorAll(".thumbs button").forEach((b) => b.classList.toggle("on", b === t));
      });
      if (bidding) {
        // Remember the bidder's name and contact for the next bid on this device.
        const me = store.get("bidder", {});
        cGrid.querySelectorAll("form.bid").forEach((f) => { if (me.name) f.elements.namedItem("name").value = me.name; if (me.contact) f.contact.value = me.contact; });
        cGrid.addEventListener("submit", async (e) => {
          const f = e.target.closest("form.bid"); if (!f) return; e.preventDefault();
          const msg = f.querySelector(".msg"), btn = f.querySelector("button"); btn.disabled = true;
          const body = { p_token: t, p_artwork_id: f.dataset.id, p_name: f.elements.namedItem("name").value, p_contact: f.contact.value, p_amount: +f.amount.value };
          const r = await rest("rpc/place_bid", { method: "POST", body: JSON.stringify(body) });
          const res = r.ok ? await r.json() : { ok: false, error: "network" };
          btn.disabled = false; msg.hidden = false; msg.classList.remove("ok");
          if (res.ok) {
            // Thank-you note for 3 seconds, then the form is fresh again (name and contact are remembered on this device).
            store.set("bidder", { name: f.elements.namedItem("name").value, contact: f.contact.value });
            msg.classList.add("ok"); msg.textContent = say("✓ Thank you, your bid is in. The artist will contact you.", "✓ ধন্যবাদ, আপনার দাম জমা হয়েছে। শিল্পী আপনার সাথে যোগাযোগ করবেন।");
            if (res.top != null) { const a = data.artworks.find((x) => x.id === f.dataset.id); a.top_bid = res.top; a.bid_count = (a.bid_count || 0) + 1; const tmp = document.createElement("div"); tmp.innerHTML = bidBox(a); f.querySelector(".top").innerHTML = tmp.querySelector(".top").innerHTML; }
            f.amount.value = ""; btn.disabled = true;
            setTimeout(() => { msg.hidden = true; msg.classList.remove("ok"); msg.textContent = ""; btn.disabled = false; f.amount.blur(); }, 3000);
          } else msg.textContent = ({
            too_low: say(`Please offer at least ${cur}${fmt(res.min)}.`, `অনুগ্রহ করে কমপক্ষে ${cur}${fmt(res.min)} লিখুন।`),
            closed: say("Bidding for this link has closed.", "এই লিংকের বিডিং শেষ হয়ে গেছে।"),
            details: say("Please write your name and a phone number or email.", "আপনার নাম আর ফোন বা ইমেইল লিখুন।"),
            unavailable: say("This work is no longer available.", "এই কাজটি আর পাওয়া যাচ্ছে না।"),
          })[res.error] || say("Could not send. Please try again.", "পাঠানো যায়নি, আবার চেষ্টা করুন।");
        });
      }
    })();
  }

  // Sketchbook viewer: one page at a time, arrows, keys, swipe, thumbnail strip, #p5 links.
  const book = document.getElementById("book");
  if (book) {
    const pages = JSON.parse(document.getElementById("bookData").textContent);
    const im = document.getElementById("bookImg"), cap = document.getElementById("bookCap"), no = document.getElementById("bookNo");
    const strip = document.getElementById("bookStrip"), thumbs = [...strip.querySelectorAll("button")];
    const title = im.alt.replace(/, page \d+$/, "");
    let n = 0; const kept = [];
    im.addEventListener("load", () => book.classList.remove("turning")); im.addEventListener("error", () => book.classList.remove("turning"));
    const go = (k, push) => {
      n = Math.max(0, Math.min(pages.length - 1, k));
      const p = pages[n];
      if (im.getAttribute("src") !== p.src) { book.classList.add("turning"); im.src = p.src; }
      im.alt = `${title}, page ${n + 1}`;
      cap.innerHTML = p.en || p.bn ? `<span lang="en">${p.en || p.bn}</span><span lang="bn">${p.bn || p.en}</span>` : "";
      no.textContent = n + 1;
      thumbs.forEach((t, i) => t.classList.toggle("on", i === n));
      thumbs[n].scrollIntoView({ block: "nearest", inline: "center", behavior: "smooth" });
      [n + 1, n + 2].forEach((i) => { if (pages[i] && !kept[i]) { kept[i] = new Image(); kept[i].src = pages[i].src; } });
      book.querySelector(".prev").disabled = n === 0; book.querySelector(".next").disabled = n === pages.length - 1;
      if (push !== false) history.replaceState(null, "", n ? `#p${n + 1}` : location.pathname);
    };
    book.querySelector(".prev").onclick = () => go(n - 1);
    book.querySelector(".next").onclick = () => go(n + 1);
    strip.addEventListener("click", (e) => { const b = e.target.closest("button"); if (b) go(+b.dataset.n); });
    document.addEventListener("keydown", (e) => { if (e.target.closest("input,textarea")) return; if (e.key === "ArrowRight") go(n + 1); if (e.key === "ArrowLeft") go(n - 1); });
    let x0 = null;
    im.addEventListener("touchstart", (e) => { x0 = e.touches[0].clientX; }, { passive: true });
    im.addEventListener("touchend", (e) => { if (x0 == null) return; const dx = e.changedTouches[0].clientX - x0; x0 = null; if (Math.abs(dx) > 40) go(n + (dx < 0 ? 1 : -1)); });
    im.addEventListener("click", (e) => { const r = im.getBoundingClientRect(); go(n + (e.clientX - r.left > r.width / 2 ? 1 : -1)); });
    const h = location.hash.match(/^#p(\d+)$/);
    go(h ? +h[1] - 1 : 0, false);
  }

  // PWA: installable on phones
  if ("serviceWorker" in navigator) navigator.serviceWorker.register("/sw.js").catch(() => {});
})();
