# artistmithu.com

Website of painter Tanvirul Islam Mithu. Plain static HTML generated from a Supabase catalogue, hosted on Cloudflare Pages.

## How it fits together
- **Supabase** (project `artistmithu`): artworks, images (Storage bucket `artworks`), chapters, enquiries, newsletter subscribers, client links. Schema: `supabase/001_init.sql`.
- **`build.mjs`**: reads published works from Supabase and writes `dist/` (home, works with size/chapter/status filters, one page per work, chapters, about, contact, client room `/c/?t=…`, sitemap, redirects from the old WordPress URLs). No dependencies.
- **`/admin/`**: studio panel. Log in, edit size/price/status, upload photos, mark sold, answer enquiries, create private client links, and press "Publish" to rebuild the site.
- **PWA**: `manifest.webmanifest` + `sw.js` make the site installable on phones ("Add to Home screen").

## Cloudflare Pages settings
- Framework preset: None
- Build command: `npm run build`
- Output directory: `dist`
- Environment variables (optional): `WHATSAPP_NUMBER` (e.g. `8801XXXXXXXXX`)

## Publish button
Create a deploy hook in Cloudflare Pages (Settings → Builds → Deploy hooks) and save it as the Supabase Edge Function secret `CF_DEPLOY_HOOK`. The admin "Publish" button calls the `rebuild-site` function, which checks the user is an admin and triggers the hook.

## Make yourself admin
1. Supabase → Authentication → Users → Add user (email + password).
2. SQL editor: `insert into admins (user_id) select id from auth.users where email = 'YOUR_EMAIL';`

## Local test without network
`FIXTURE=snapshot.json node build.mjs` builds from a saved JSON snapshot (`{series, works, images, exhibitions}`).

## হিসাব (accounts) tab
The studio panel has a private "হিসাব" tab: monthly income and spending with a daily chart and category totals, পাওনা/দেনা (money owed to or by the artist), projects with an optional budget (e.g. বাড়ি বানানো, যশোরের খরচ), and an import box that takes pasted CSV/JSON (for moving data over from the old "আমার দিন" page). Data lives in the admin-only `ledger` and `ledger_projects` tables; run `supabase/013_ledger.sql` once in the SQL editor before using it. Nothing from it is ever built into the public site.

## Login
The admin login keeps the session in the browser (refreshed automatically), so each device stays logged in until "লগআউট". Options: Google, an emailed login link (the address is remembered on the device), or password.
To turn on Google: create an OAuth client (Web) in Google Cloud Console with the redirect URI `https://msbgnvltxoxrnvuriiez.supabase.co/auth/v1/callback`, then paste its Client ID and secret in Supabase → Authentication → Sign In / Providers → Google. In Supabase → Authentication → URL Configuration, add `https://artistmithu.com/admin/` to Redirect URLs. A Google account with the same email as the admin user links to it automatically.
