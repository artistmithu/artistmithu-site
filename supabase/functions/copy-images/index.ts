// One-time importer: copies images from the public GitHub branch "import-images" into the artworks bucket.
// Called from the database with pg_net. Guarded by a one-time token stored in public.import_tokens.
import { createClient } from "npm:@supabase/supabase-js@2.45.4";
const BASE = "https://raw.githubusercontent.com/artistmithu/artistmithu-site/import-images/";
const TYPES: Record<string, string> = { jpg: "image/jpeg", jpeg: "image/jpeg", png: "image/png", webp: "image/webp" };
Deno.serve(async (req) => {
  const { token, paths } = await req.json().catch(() => ({}));
  if (!token || !Array.isArray(paths)) return new Response("bad request", { status: 400 });
  const sb = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
  const { data: ok } = await sb.from("import_tokens").select("token").eq("token", token).maybeSingle();
  if (!ok) return new Response("forbidden", { status: 403 });
  const results: Record<string, string> = {};
  for (const p of paths.slice(0, 60)) {
    try {
      const r = await fetch(BASE + p.split("/").map(encodeURIComponent).join("/"));
      if (!r.ok) { results[p] = `fetch ${r.status}`; continue; }
      const ext = p.split(".").pop()!.toLowerCase();
      const { error } = await sb.storage.from("artworks").upload(p, await r.arrayBuffer(), { contentType: TYPES[ext] || "application/octet-stream", upsert: true, cacheControl: "31536000" });
      results[p] = error ? `upload ${error.message}` : "ok";
    } catch (e) { results[p] = `error ${e}`; }
  }
  return new Response(JSON.stringify(results), { headers: { "Content-Type": "application/json" } });
});
