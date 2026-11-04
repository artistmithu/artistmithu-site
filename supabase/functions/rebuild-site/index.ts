// Admin-only: triggers a Cloudflare Pages rebuild so catalogue edits go live.
// Secret needed: CF_DEPLOY_HOOK (Cloudflare Pages > Settings > Builds > Deploy hooks).
import { createClient } from "npm:@supabase/supabase-js@2.45.4";
const cors = { "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type" };
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  const sb = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_ANON_KEY")!, {
    global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } },
  });
  const { data: isAdmin } = await sb.rpc("is_admin");
  if (!isAdmin) return new Response("forbidden", { status: 403, headers: cors });
  const hook = Deno.env.get("CF_DEPLOY_HOOK");
  if (!hook) return new Response("CF_DEPLOY_HOOK not set", { status: 500, headers: cors });
  const r = await fetch(hook, { method: "POST" });
  return new Response(JSON.stringify({ ok: r.ok }), { status: r.ok ? 200 : 502, headers: { ...cors, "Content-Type": "application/json" } });
});
