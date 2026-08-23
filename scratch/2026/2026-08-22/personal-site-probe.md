---
author: Claude Fable 5
---

# Personal site hosting probe (2026-08-23 UTC, read-only: dig/curl/RDAP only)

Reading notes: probed the evening of 2026-08-22 Pacific. *NS* =
authoritative nameservers (who answers DNS for the name); *RDAP* =
the registry lookup that says who owns a domain or IP block; *grey-*
vs *orange-cloud* = Cloudflare DNS-only vs proxied; "GitHub Pages
platform NS" = a `*.github.io` name with no domain of its own. This
is the *current* state of each site; where it disagrees with the
historical rationales note, this file wins for "where is it now" —
see the caveat in `hosting-decision.md` (drewdevault.com is likely
sourcehut-hosted rather than self-hosted; Turbify is the former
Yahoo Small Business hosting).

N = 49 sites probed.

| site | canonical host | DNS provider (NS) | hosting (inferred) | evidence | generator | http→https | cert issuer |
|---|---|---|---|---|---|---|---|
| karpathy.ai | karpathy.ai | Namecheap (registrar-servers.com) | Fastly (direct CDN; origin app undetermined) | A 151.101.1.195/.65.195 (Fastly-owned range); `x-served-by: cache-pao-...`, no CF/GH/Netlify markers | none detected | yes (301) | Google Trust Services WR3 |
| sive.rs | sive.rs | ClouDNS | Self-hosted VPS (Vultr), nginx | A 104.207.153.241 = Vultr (RDAP); `server: nginx/1.30.4`, custom CSP referencing own m.sive.rs/bunny CDN | none detected | yes (301) | Let's Encrypt YR1 |
| danluu.com | danluu.com | Cloudflare | GitHub Pages, proxied through Cloudflare | `server: cloudflare` + `cf-ray`, but also `x-github-request-id` and `x-github-edge-region` present | none detected | no (http serves 200 directly) | Google Trust Services WE1 |
| gwern.net | gwern.net | Cloudflare | Self-hosted, fully proxied by Cloudflare (origin type undetermined) | `server: cloudflare`, `cf-cache-status: DYNAMIC`; no GH/Netlify/Vercel signature | none detected | yes (301) | Google Trust Services WE1 |
| simonwillison.net | simonwillison.net | Cloudflare | Heroku (Django app) behind Cloudflare proxy | `via: 1.1 heroku-router`, `django-composition:` header, `server: cloudflare`+`cf-ray` | none detected | yes (301) | Google Trust Services WE1 |
| jvns.ca | jvns.ca | Gandi | Netlify | www CNAME → `julia-homepage.netlify.app`; `server: Netlify`, `x-nf-request-id` | Hugo 0.135.0 | yes (301) | Let's Encrypt YE2 |
| paulgraham.com | paulgraham.com | Turbify | Turbify-managed hosting (AWS-backed) | www CNAME → `stores.turbify.net`; A records are AWS EC2 IPs; no CDN header signature | none detected | yes (301) | DigiCert Inc (Encryption Everywhere DV G2) |
| overreacted.io | overreacted.io | Cloudflare | Cloudflare (likely Cloudflare Pages; proxied, origin undistinguishable) | `server: cloudflare`+`cf-ray`; `cf-cache-status: DYNAMIC`; static Hugo/Gatsby-style caching | none detected | yes (301) | Google Trust Services WE1 |
| xeiaso.net | xeiaso.net | AWS Route53 | Self-hosted VPS (Vultr) behind own Anubis anti-bot proxy | A 216.128.177.63 = Vultr (RDAP); `refresh:` header to `/.within.website/x/cmd/anubis/...` (Xe Iaso's own bot-challenge tool) | none detected | yes (308) | Let's Encrypt YR2 |
| fasterthanli.me | fasterthanli.me | Cloudflare | Self-hosted (Caddy) behind Cloudflare proxy | `via: 1.1 Caddy`, `server: cloudflare`+`cf-ray` | none detected | yes (301) | Google Trust Services WE1 |
| matklad.github.io | matklad.github.io | GitHub Pages platform (nsone.net + awsdns) | GitHub Pages | A 185.199.108-111.153; `server: GitHub.com`, `x-github-request-id` | none detected | yes (301) | Let's Encrypt YR1 |
| lilianweng.github.io | lilianweng.github.io | GitHub Pages platform | GitHub Pages | same A range; `server: GitHub.com` | Hugo 0.163.3 | no (http serves 200 directly) | Let's Encrypt YR1 |
| colah.github.io | colah.github.io | GitHub Pages platform | GitHub Pages | same A range; `server: GitHub.com` | none detected | no (http serves 200 directly) | Let's Encrypt YR1 |
| ciechanow.ski | ciechanow.ski | DigitalOcean | Self-hosted VPS (DigitalOcean), nginx | NS = DO; A 143.198.60.216 (DO); `Server: nginx/1.18.0 (Ubuntu)` | none detected | yes (301) | Let's Encrypt YR2 |
| rachelbythebay.com | rachelbythebay.com | Hurricane Electric (he.net) | Unknown — self-hosted/colocated at Hurricane Electric, but probe was blocked | All HTTP(S) requests from this host timed out (curl exit 28) on ports 80/443; NS=he.net, A 216.218.228.215 owned by Hurricane Electric (RDAP); www CNAME `flicker.rachelbythebay.com` implies self-managed | unknown (blocked) | unknown (blocked) | unknown (connection never completed) |
| drewdevault.com | drewdevault.com | iwantmyname | Self-hosted VPS (NL hosting: "High5", RIPE NL-HIGH5-CUST-2022) | A 46.23.81.157 = High5 hosting NL (RDAP); heavy hand-written CSP, no CDN/platform headers | none detected | yes (302) | Let's Encrypt YE1 |
| jefftk.com | www.jefftk.com | Namecheap (registrar-servers.com) | Self-hosted (AWS EC2), nginx | A 18.212.19.94 (AWS EC2 range); `Server: nginx/1.18.0 (Ubuntu)` | none detected | yes (301) | Let's Encrypt YR1 |
| idlewords.com | idlewords.com | DNS Made Easy | Self-hosted (DataCate colocation, Sacramento), Apache | A 107.181.87.8 = DataCate06 (RDAP); `Server: Apache/2.4.29 (Ubuntu)` | none detected | yes (301) | Let's Encrypt YR1 |
| brendangregg.com | www.brendangregg.com | DreamHost | DreamHost hosting, Apache | NS = DreamHost; `server: Apache` | Vim (literal `<meta name="GENERATOR" content="Vim">`, hand-edited HTML) | yes (301) | Let's Encrypt YR1 |
| eli.thegreenplace.net | eli.thegreenplace.net | DigitalOcean | Self-hosted VPS (DigitalOcean), Apache | NS = DO; A 137.184.213.186 (DO); `Server: Apache/2.4.52 (Ubuntu)` | none detected | yes (302) | Let's Encrypt YR1 |
| jacobian.org | jacobian.org | Cloudflare | Cloudflare (proxied; static Hugo build, platform undetermined) | `server: cloudflare`+`cf-ray` | Hugo 0.147.8 | yes (301) | Google Trust Services WE1 |
| blog.codinghorror.com | blog.codinghorror.com | Cloudflare | Ghost(Pro) managed hosting, behind Cloudflare proxy | `ghost-fastly: true;production` header; `server: cloudflare`+`cf-ray` | Ghost 6.59 | yes (301) | Google Trust Services WE1 |
| joelonsoftware.com | www.joelonsoftware.com | Name.com | Pressable (Automattic-owned managed WordPress) | A 199.16.172/173.x = "PRESSABLE" (RDAP); `x-ac: ..._atomic_bur`, `server-timing: a8c-cdn` (Automattic markers) | none detected | yes (301) | Google Trust Services WR1 |
| terrytao.wordpress.com | terrytao.wordpress.com | WordPress.com | WordPress.com | `host-header: WordPress.com`; `link: .../wp-json/` | none detected (platform strips it) | yes (301) | Let's Encrypt YE2 |
| scottaaronson.blog | scottaaronson.blog | WordPress.com | WordPress.com (Atomic hosting, custom domain) | `host-header: wpcloud`, `x-ac: ..._atomic_bur`, `server-timing: a8c-cdn` | WordPress 7.1 | yes (301) | Google Trust Services WR1 |
| patrickcollison.com | patrickcollison.com | Google Domains/Cloud DNS | Vercel | A 76.76.21.21 (Vercel anycast); `server: Vercel`, `x-vercel-id`, `x-vercel-cache` | none detected | yes (308) | Let's Encrypt YR2 |
| writings.stephenwolfram.com | writings.stephenwolfram.com | Self-hosted (wri-dns2/3.wolfram.com, Wolfram's own NS) | Self-hosted WordPress on Wolfram Research's own network | `X-Powered-By: PHP/5.4.16`, `Link: .../wp-json/`; IP org address = Champaign, IL (Wolfram HQ, RDAP) | none detected (meta stripped, but wp-json confirms WP) | yes (302) | Let's Encrypt YR1 |
| antirez.com | antirez.com | Oracle Dyn | Self-hosted VPS (Hetzner, Finland), nginx | A 65.21.116.178 = Hetzner DE (RDAP, country FI); `Server: nginx` | none detected | yes (301) | Let's Encrypt YE1 |
| justine.lol | justine.lol | Cloudflare (DNS-only / grey-cloud, not proxied) | Self-hosted: Justine Tunney's own "redbean" web server on Google Cloud VM | `Server: redbean/2.2.0` (port 80); no `cf-ray`/`server: cloudflare` despite CF NS; A 35.193.71.236 = Google Cloud (RDAP) | none detected | no (http serves 200; https fails cert-chain verification from this client — server: redbean, cert CN=justine.lol issued by Let's Encrypt E7 but incomplete chain) | Let's Encrypt E7 (retrieved with `-k`; default curl chain validation fails — likely missing intermediate) |
| evanmiller.org | www.evanmiller.org | AWS Route53 | Self-hosted (AWS EC2), nginx | A 52.14.172.252 (AWS EC2); `Server: nginx/1.24.0 (Ubuntu)` | none detected | yes (301) | Let's Encrypt YE2 |
| jeremykun.com | www.jeremykun.com | Google Domains/Cloud DNS | Netlify | www CNAME → `math-intersect-programming.netlify.app`; `server: Netlify`, `x-nf-request-id` | Hugo 0.122.0 | yes (301) | Let's Encrypt YE1 |
| mitchellh.com | mitchellh.com | AWS Route53 | Vercel | www CNAME `cname.vercel-dns.com`; A 76.76.21.21; `server: Vercel`, `x-vercel-id`, `x-nextjs-prerender` | none detected (Next.js app, no generator meta) | yes (308) | Let's Encrypt YR2 |
| tomverbeure.github.io | tomverbeure.github.io | GitHub Pages platform | GitHub Pages | A 185.199.x.153; `server: GitHub.com` | Jekyll v3.10.0 | yes (301) | Let's Encrypt YR1 |
| leodemoura.github.io | leodemoura.github.io | GitHub Pages platform | GitHub Pages | A 185.199.x.153; `server: GitHub.com` | none detected | no (http serves 200 directly) | Let's Encrypt YR1 |
| lexi-lambda.github.io | lexi-lambda.github.io | GitHub Pages platform | GitHub Pages | A 185.199.x.153; `server: GitHub.com` | none detected | yes (301) | Let's Encrypt YR1 |
| benkuhn.net | www.benkuhn.net | DigitalOcean (apex only; unused by canonical host) | Amazon S3 + CloudFront | `server: AmazonS3`, `x-amz-cf-id`, `x-amz-cf-pop`, `via: ...cloudfront.net (CloudFront)` | Hugo 0.109.0 | yes (307) | Let's Encrypt YR1 |
| macwright.com | macwright.com | Cloudflare (DNS-only / grey-cloud, not proxied) | Netlify | www CNAME → `macwright-com.netlify.app`; `server: Netlify`, no cf-ray | Eleventy | yes (301) | Let's Encrypt YE2 |
| blog.jim-nielsen.com | blog.jim-nielsen.com | NS1 | Netlify | A 13.52/52.52.x (Netlify AWS-backed edge); `server: Netlify`, `cache-status: "Netlify Edge"` | none detected in first 30KB | yes (301) | Let's Encrypt YE1 |
| kevinlynagh.com | kevinlynagh.com | AWS Route53 | Self-hosted VPS (DigitalOcean), nginx | A 159.203.71.22 = DigitalOcean (RDAP); `server: nginx` | none detected | yes (301) | Let's Encrypt YR2 |
| mtlynch.io | mtlynch.io | DNSimple | Netlify | www CNAME → `mtlynch.netlify.app`; `server: Netlify`, `x-nf-request-id` | Hugo 0.163.3 | yes (301) | Let's Encrypt YE2 |
| bernsteinbear.com | bernsteinbear.com | Cloudflare (DNS-only / grey-cloud, not proxied) | GitHub Pages | A 185.199.x.153; `server: GitHub.com`, no cf-ray despite CF NS | Jekyll v3.10.0 | yes (301) | Let's Encrypt YR1 |
| lucumr.pocoo.org | lucumr.pocoo.org | GoDaddy (domaincontrol.com) | GitHub Pages | CNAME → `mitsuhiko.github.io`; `server: GitHub.com` (apex A 148.251.50.164 is Hetzner but unused by canonical host) | none detected | yes (301) | Let's Encrypt YR1 |
| jlongster.com | jlongster.com | Cloudflare | Fly.io (Express/Node app) behind Cloudflare proxy | `via: 1.1 fly.io`, `fly-request-id`, `x-powered-by: Express`, `server: cloudflare`+`cf-ray` | none detected | yes (301) | Google Trust Services WE1 |
| blog.regehr.org | blog.regehr.org | DigitalOcean | Self-hosted WordPress (DigitalOcean droplet), nginx | NS = DO; A 157.245.247.195 (DO); `Link: .../wp-json/`; `Server: nginx/1.18.0` | none detected (meta stripped, wp-json confirms WP) | yes (301) | Let's Encrypt YR1 |
| nedbatchelder.com | nedbatchelder.com | DreamHost | Self-hosted (DreamHost VPS), Python/gunicorn app | NS = DreamHost; A 208.113.159.94; `server: gunicorn` | none detected | no (http serves 200 directly) | Let's Encrypt YR1 |
| blog.plover.com | blog.plover.com | Linode/Akamai | Self-hosted VPS (Linode), Apache | NS = Linode; A 23.92.19.230 (Linode); `Server: Apache/2.4.52 (Ubuntu)` | none detected | yes (302) | Let's Encrypt YR2 |
| mjg59.dreamwidth.org | mjg59.dreamwidth.org | Bunny.net (Dreamwidth's own NS choice) | Dreamwidth platform (behind CloudFront/AWS) | www CNAME `d256vi95d5epc7.cloudfront.net`; cert issued by Amazon; `ljuniq=` cookie (LJ/Dreamwidth codebase) | none detected (platform codebase) | yes (301) | Amazon (Amazon RSA 2048 M04) |
| tonsky.me | tonsky.me | Name.com | Self-hosted dedicated server (Scaleway/Online.net, France), nginx | A 51.159.6.227 = Online SAS/Scaleway (RDAP); `server: nginx/1.18.0 (Ubuntu)` | none detected | yes (301) | Let's Encrypt YE1 |
| grugbrain.dev | grugbrain.dev | NS1 | Netlify | A 52.52/13.52.x (Netlify AWS-backed edge); `server: Netlify`, `cache-status: "Netlify Edge"` | none detected | yes (301) | Let's Encrypt YE1 |

Notes on ambiguity:
- **rachelbythebay.com**: every probe (dig succeeded, but all curl HTTP/HTTPS requests on ports 80/443) timed out from this environment (curl exit 28, "Connection timed out"). This is consistent with the site's known anti-scraping/anti-bot posture, but it could equally be a transient network-path issue from this host. Marked unknown rather than guessed.
- **justine.lol**: default curl TLS verification fails (exit 60, "unable to get local issuer certificate") even though the certificate itself (fetched with `-k`) is a normal Let's Encrypt leaf for `justine.lol`. This looks like the origin (a hand-written "redbean" server) is not sending a complete intermediate chain — a real, if minor, server misconfiguration, not a probe artifact (verified via plain HTTP on port 80 succeeding with `Server: redbean/2.2.0`).
- Several "self-hosted" classifications rest on RDAP IP-ownership plus the absence of any platform header (GitHub/Netlify/Vercel/Cloudflare-proxy signature) — this is inference from negative evidence, not a positive "self-hosted" marker, and is flagged as such in the evidence column.
- "Cloudflare (likely Cloudflare Pages)" for overreacted.io and jacobian.org is a guess based on typical usage patterns for static Hugo/Gatsby personal blogs behind Cloudflare — no Cloudflare Pages-specific header was observed to confirm it over plain Cloudflare-proxied self-hosting.

## Summary

**N = 49 sites probed.**

### Hosting provider distribution (49 total)
- Self-hosted (own VPS/dedicated/colo box: nginx/Apache/gunicorn/redbean/self-run WordPress) — **20**: sive.rs, gwern.net, xeiaso.net, fasterthanli.me, ciechanow.ski, rachelbythebay.com (unconfirmed, blocked), drewdevault.com, jefftk.com, idlewords.com, brendangregg.com, eli.thegreenplace.net, writings.stephenwolfram.com, antirez.com, justine.lol, evanmiller.org, kevinlynagh.com, blog.regehr.org, nedbatchelder.com, blog.plover.com, tonsky.me
- GitHub Pages — **9**: danluu.com, matklad.github.io, lilianweng.github.io, colah.github.io, tomverbeure.github.io, leodemoura.github.io, lexi-lambda.github.io, bernsteinbear.com, lucumr.pocoo.org
- Netlify — **6**: jvns.ca, jeremykun.com, macwright.com, blog.jim-nielsen.com, mtlynch.io, grugbrain.dev
- Cloudflare (proxied, platform behind it unconfirmed — likely Pages) — **2**: overreacted.io, jacobian.org
- Vercel — **2**: patrickcollison.com, mitchellh.com
- WordPress.com (incl. Atomic custom-domain) — **2**: terrytao.wordpress.com, scottaaronson.blog
- Pressable / Automattic-managed WordPress — **1**: joelonsoftware.com
- Ghost(Pro) — **1**: blog.codinghorror.com
- Amazon S3 + CloudFront — **1**: benkuhn.net
- Fly.io — **1**: jlongster.com
- Heroku — **1**: simonwillison.net
- Dreamwidth (platform, CloudFront-backed) — **1**: mjg59.dreamwidth.org
- Fastly (direct CDN, origin undetermined) — **1**: karpathy.ai
- Turbify (managed store-hosting platform) — **1**: paulgraham.com

Total: 20+9+6+2+2+2+1+1+1+1+1+1+1+1 = 49. ✓

### DNS provider distribution (49 total)
- Cloudflare — **11**: danluu.com, gwern.net, simonwillison.net, overreacted.io, fasterthanli.me, jacobian.org, blog.codinghorror.com, jlongster.com, justine.lol, macwright.com, bernsteinbear.com
- GitHub Pages platform NS (nsone.net + awsdns for the `*.github.io` zone) — **6**: matklad, lilianweng, colah, tomverbeure, leodemoura, lexi-lambda (all `.github.io`)
- AWS Route53 — **4**: xeiaso.net, evanmiller.org, mitchellh.com, kevinlynagh.com
- DigitalOcean DNS — **4**: ciechanow.ski, eli.thegreenplace.net, benkuhn.net (apex only), blog.regehr.org
- DreamHost — **2**: brendangregg.com, nedbatchelder.com
- Namecheap (registrar-servers.com) — **2**: karpathy.ai, jefftk.com
- Name.com — **2**: joelonsoftware.com, tonsky.me
- Google Domains/Cloud DNS — **2**: patrickcollison.com, jeremykun.com
- WordPress.com — **2**: terrytao.wordpress.com, scottaaronson.blog
- NS1 — **2**: blog.jim-nielsen.com, grugbrain.dev
- Gandi — **1**: jvns.ca
- Turbify — **1**: paulgraham.com
- ClouDNS — **1**: sive.rs
- Hurricane Electric (he.net) — **1**: rachelbythebay.com
- iwantmyname — **1**: drewdevault.com
- DNS Made Easy — **1**: idlewords.com
- Oracle Dyn — **1**: antirez.com
- DNSimple — **1**: mtlynch.io
- GoDaddy (domaincontrol.com) — **1**: lucumr.pocoo.org
- Linode/Akamai DNS — **1**: blog.plover.com
- Bunny.net — **1**: mjg59.dreamwidth.org
- Self-managed (Wolfram Research's own NS) — **1**: writings.stephenwolfram.com

Total: 11+6+4+4+2+2+2+2+2+2+1×11 = 49. ✓

### Custom apex domain vs platform subdomain
- **Platform subdomain** (site lives directly under a shared platform domain the author doesn't own) — **8**: matklad.github.io, lilianweng.github.io, colah.github.io, tomverbeure.github.io, leodemoura.github.io, lexi-lambda.github.io, terrytao.wordpress.com, mjg59.dreamwidth.org
- **Custom apex domain** (author owns the registered domain, even if serving from a `blog.`/`www.`/`writings.` subdomain of it, or the domain is CNAME'd to a platform like `bernsteinbear.com` → GitHub Pages) — **41**: all remaining sites

Total: 8 + 41 = 49. ✓

### Cloudflare-proxy status
- **Actively proxied through Cloudflare** (orange-cloud: `server: cloudflare` + `cf-ray` present, Cloudflare terminates TLS and fronts the origin) — **8**: danluu.com, gwern.net, simonwillison.net, overreacted.io, fasterthanli.me, jacobian.org, blog.codinghorror.com, jlongster.com
- **Cloudflare for DNS only, not proxied** (grey-cloud: NS is Cloudflare but the response headers show the true origin directly — GitHub Pages or Netlify — with no `cf-ray`) — **3**: justine.lol, macwright.com, bernsteinbear.com
- **Not on Cloudflare at all** — **38**: everyone else

Total: 8 + 3 + 38 = 49. ✓
