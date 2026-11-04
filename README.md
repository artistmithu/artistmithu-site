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
