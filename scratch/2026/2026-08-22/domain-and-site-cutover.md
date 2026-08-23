---
author: Claude Fable 5
---

# Domain registered; site cut over to qobilidop.com

Executes items 1–3 of the queue in the 2026-08-21 rename record;
written after the registration completed.

## Registration

- **qobilidop.com** registered at Cloudflare Registrar (at-cost,
  Cloudflare nameservers required), 10-year term, auto-renew on.
  Registry timestamp 2026-08-23T04:58Z — the anniversary is Aug 23 UTC
  though the act was Aug 22 local. Bili: the date is special because of
  what happened in this repo that day (repo renamed, address acquired),
  not the other way round; a birthday anniversary was considered and
  declined as not worth a 3-month wait.
- Why 10 years: lapse-resistance for an identity domain (card expiry
  and account lockouts are how permanent domains get lost), with the
  wholesale-price lock a minor bonus. The expiry date cannot be moved
  later — registrars only add whole years.
- **qobilidop.dev** (Squarespace, ex-Google Domains; renewed
  2026-03-22, expires 2027-04-01): auto-renew to be turned off; the
  domain lapses; the Squarespace account is deleted after the domain is
  gone. Nameservers were NS1/Netlify — confirm nothing (email
  forwarding, logins) still depends on the name before it drops.

## Global reachability

Bili wants the site easily reachable worldwide. Findings:

- Registrar and TLD are neutral: Cloudflare's authoritative DNS
  resolves everywhere; .com is the most universally legible TLD.
- The only hard region is mainland China, and the constraint is legal,
  not technical: fast, reliable in-country delivery requires an ICP
  filing (Chinese entity, China-hosted or China-CDN delivery —
  Cloudflare's China Network requires it too). GitHub Pages is not
  blocked there, only slow/flaky; Cloudflare's non-China edge is
  similar. Not pursued for a personal site.
- The hedge is portability, which the site already has: plain static
  output, zero third-party runtime origins (no Google Fonts — blocked
  in China — no CDN scripts, no analytics; KaTeX fonts bundled from
  the package). If China reachability ever becomes a real need,
  hosting moves or gains a mirror under the same URLs. Rule to codify
  in tend-site: **no third-party runtime origins.**
- Cloudflare proxy (orange cloud) deferred: not a clear win over
  Fastly for China, and it adds an HTTPS-mode trap with Pages. DNS
  records start DNS-only so GitHub can issue the certificate.

## Cutover

- The 2026-08-22 repo rename had already broken the live site: Pages
  served `qobilidop.github.io/garden/` while the build still used
  `/sys0` as base, and CI's image `ghcr.io/qobilidop/garden/dev` did
  not exist (GHCR packages do not follow repo renames).
- Done in this change: `base` dropped to the domain root, `site` set
  to `https://qobilidop.com`; every tracked `sys0` reference swept to
  `garden` (URLs, brand, identifiers, user-agents, prose; scratch kept
  as historical record); `site.yml` pulls the image with explicit
  credentials so a private package cannot break the build; Pages
  custom domain set to `qobilidop.com` via the API; dev-image workflow
  dispatched to publish `garden/dev`.
- Pages redirects `qobilidop.github.io/garden/…` to the custom domain
  once DNS resolves; `…/sys0/…` links are the accepted loss.

## Queue

1. Bili, Cloudflare DNS (DNS-only): apex `A` → GitHub Pages' four
   IPv4 + `AAAA` → four IPv6; `www` `CNAME` → `qobilidop.github.io`.
   Then in Pages settings: wait for the certificate, enable Enforce
   HTTPS; verify the domain under account → Pages → verified domains
   (one TXT record) to prevent takeover.
2. Bili: flip `ghcr.io/qobilidop/garden/dev` public (anonymous
   `dev.sh` pulls); delete the orphaned `sys0/dev` package.
3. Bili: Squarespace — auto-renew off for qobilidop.dev; delete the
   account after 2027-04-01.
4. Profile fold (queue item 4 of the rename record): content
   allowlist change; masthead identity is a tend-site taste call —
   the brand string is a mechanical `qobilidop/garden` for now.
5. `qobilidop.github.io` repo → redirect stub after the profile fold
   (meta-refresh/JS to `https://qobilidop.com/`), then archive.
6. tend-site: codify the no-third-party-origins rule at the next
   touch (batched for /evolve, not a point edit).
