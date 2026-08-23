---
author: Claude Fable 5
---

# Hosting: Cloudflare Workers primary, GitHub Pages standby

**Amended later the same night — standby removed.** Bili weighed
setup simplicity above hedging against Cloudflare's own outages, so
GitHub Pages was disabled entirely (Pages setting, `github-pages`
environment, verified domain, and the TXT record removed; `site.yml`
deploys only to the Worker). `qobilidop.github.io/garden/` no longer
exists in any form. The "Standby" bullets and runbook step below are
kept as the record of what was built and why; the live topology is:
repo → GitHub Actions (or the host) → Worker `garden` → qobilidop.com.
Restoring Pages is minutes of settings plus re-adding a deploy step;
the static output is host-agnostic by design.

Written after the cutover note; supersedes its "GitHub Pages" framing.
Trigger: Bili's sense that GitHub has grown less stable, and a wish to
hedge. Evidence in three sibling notes (same directory):
`personal-site-probe.md` (49 notable personal sites, live-probed),
`personal-site-rationales.md` (what longevity-minded authors wrote),
`static-hosting-options.md` (current option facts + 2025–26 incident
record). Dates: the work happened the evening of 2026-08-22 Pacific,
which is 2026-08-23 UTC — the probe note's title and registry
timestamps read 08-23 for that reason.

Terms, for a reader new to this: a Cloudflare *Worker* is a unit
deployed to Cloudflare's edge under your account; here it holds no
code and only serves the static files in `site/dist`. *wrangler* is
Cloudflare's command-line tool; `npm run deploy` in `site/` is just
`wrangler deploy`. `workers_dev = false` turns off the default
`garden.<account>.workers.dev` hostname. A Worker *custom domain* is
a DNS record Cloudflare creates and locks for the Worker. The *apex*
is the bare domain; *A/AAAA* records map it to IPv4/IPv6 addresses;
*proxied* means Cloudflare sits in front of the traffic (needed for
its *Redirect Rules*). *301* is a permanent redirect, *307* a
temporary one. GitHub Pages' *custom-domain setting* is a field in
GitHub's API (named `cname`), not a file in the repo.

## What the evidence said

- Of 49 notable personal sites: 20 self-host, 9 GitHub Pages, 6
  Netlify, the rest scattered; 41 own their apex; Cloudflare is the
  most common DNS provider (11) but only 8 proxy through it. Caveat:
  the probe reports where sites are *now*; the rationales note quotes
  historical writing, so the two disagree on a few sites (jvns.ca
  Netlify now vs a 2022 droplet; xeiaso.net Vultr now vs Fly in
  2023; karpathy.ai Fastly vs an inferred Pages). drewdevault.com is
  counted self-hosted by IP ownership, but his build file publishes
  to sourcehut pages — likely platform-hosted, so read "20
  self-hosted" as 19–20.
- The longevity-minded (Gwern, Huang, Steren, MacWright) argue
  durability at the content/format layer — static text in git, plain
  HTML, few dependencies, domain as identity — and treat hosts as
  disposable. Nobody in the set runs availability failover for a
  personal site; Evans and Nielsen explicitly accept some downtime.
- GitHub 2026: rising monthly incident counts and multi-hour
  Pages/Actions outages (5h53m Feb 2, 9h18m Jul 9, 10h42m Aug 6–7,
  7h47m site-wide Aug 17). Cloudflare: rarer but global (Nov 18 2025
  ~3h all proxied traffic; Dec 5 2025 25 min). Netlify's free tier now
  pauses sites at a credit cap; Vercel Hobby serves content on
  `*.vercel.app` and forbids commercial use.

## First principles

Four things a personal site can lose: identity (domain — owned 10 y,
done), content (git, copies local + shadow — done), renderability
(the Astro dependency tree; mitigated by pinned image + lockfile +
plain-HTML output — this is the real decades-scale risk, not any
host), availability (the only layer GitHub's instability touches, and
the cheapest to hedge because static output is host-agnostic).

Two constraints: (1) authoritative DNS is at Cloudflare regardless, so
hosting on GitHub puts two vendors in series; hosting on Cloudflare
puts one — fewer serial vendors beats diversification unless the
second vendor is a parallel standby; (2) continuity: a VPS dies with
the card, a free static host keeps serving an untouched repo — for
den/nest/hearth-style continuity (the access-tier scheme in the
08-21 rename record), zero-payment hosting is a feature.

## Decision

- Primary: Cloudflare Workers static assets — Worker `garden`
  (`site/wrangler.jsonc`), custom domain `qobilidop.com`,
  `workers_dev = false` (no default hostname; one address serves).
  Static asset requests are free and unlimited. Deploy runs from
  `site.yml` (`npm run deploy` with `CLOUDFLARE_API_TOKEN`) and from
  the host (`wrangler login` OAuth) — publishing never depends on
  GitHub Actions being up.
- Standby: the existing `deploy-pages` job keeps running on every
  push; Pages keeps its custom-domain setting (`cname` field in
  GitHub's API, no file in the repo), so `github.io/garden/` stays a
  301 to the apex (to `http://`, which Cloudflare then upgrades — no
  duplicate content) and the standby is always current.
- `www` → apex via a Cloudflare Redirect Rule; the `www` record is a
  proxied CNAME to the apex (retargeted from `qobilidop.github.io` so
  nothing in DNS names GitHub), and the rule is the whole mechanism —
  without it `www` would error rather than fall through. Always Use
  HTTPS on; `<link rel="canonical">` in every page.
- Residual, accepted: a Cloudflare-wide outage takes DNS too; only
  secondary DNS elsewhere would help, and no one in the sample does
  that for a personal site.

## Executed (2026-08-22 Pacific evening)

Token `garden-ci-deploy` created by Bili (scopes: Account · Workers
Scripts · Edit; Zone · Workers Routes · Edit, zone qobilidop.com) and
stored as repo secret `CLOUDFLARE_API_TOKEN`; `wrangler login` on the
host. First deploy uploaded 372 files; custom-domain attach required
deleting the 8 apex A/AAAA GitHub records first (Bili confirmed the
bulk delete); second deploy attached the domain; HTTPS came up at once
on Cloudflare's certificate (GitHub's pending cert became moot).
Verified: apex 200 on https, http→https 301, trailing-slash 307,
404 page, `www` 301 with query preserved, `github.io/garden/…` 301.

## Runbook

(Failover below was retired with the standby — kept as record. What
remains live: the "publish when Actions is down" and "token" items.)

Failover to GitHub Pages (Cloudflare hosting broken, DNS up):
1. Cloudflare → Workers & Pages → `garden` → Settings → Domains &
   Routes: remove the `qobilidop.com` custom domain (this deletes the
   locked DNS record wrangler created; the DNS page cannot delete it
   directly). Then in DNS, import the apex A/AAAA records (GitHub
   Pages' published IPs: 185.199.108–111.153 and
   2606:50c0:8000–8003::153, DNS-only).
2. Pages already has the custom-domain setting; wait for its
   certificate (HTTP works immediately; the TXT verification record
   is still in place).
3. Back: delete the A/AAAA records, `npm run deploy` re-attaches the
   Worker domain.

Publish when GitHub Actions is down: `cd site && npm run build &&
npm run deploy` on the host (OAuth session from `wrangler login`).

Token lost or leaked: Cloudflare → API Tokens → roll or recreate with
the two scopes above → paste into the repo secret. Nothing deployed
depends on the token; it only gates future CI deploys.
