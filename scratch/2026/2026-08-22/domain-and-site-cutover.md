---
author: Claude Fable 5
---

# Domain registered; site cut over to qobilidop.com

Executes the first three items of the execution queue in the rename
record (`scratch/2026/2026-08-21/garden-rename.md`); written after
the registration completed.

**Superseded the same night:** hosting moved from GitHub Pages to
Cloudflare Workers — see `hosting-decision.md`. The DNS and HTTPS
details below describe the GitHub Pages setup that existed for about
two hours; the registration, reachability, and sweep sections stand.

Terms, for a reader new to this: the *apex* is the bare domain
(`qobilidop.com`, no `www`); *A/AAAA records* map a name to IPv4/IPv6
addresses; a *CNAME* makes one name an alias of another; a *TXT*
record holds arbitrary text (used here as an ownership proof);
*DNS-only* vs *proxied* ("grey" vs "orange cloud") is whether
Cloudflare merely answers the lookup or also sits in front of the
traffic; GitHub Pages' *custom-domain setting* is what makes Pages
answer for a hostname (GitHub's API calls the field `cname`; it is
not a file in this repo); *GHCR* is GitHub's container registry,
where the dev image lives; an *ICP filing* is China's licence for
serving a website to its residents.

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
- Pages answers `qobilidop.github.io/garden/…` with a 301 to the
  custom domain as soon as the setting is saved — before DNS exists,
  which left the site briefly unreachable (order is DNS first, then
  the setting); `…/sys0/…` links are the accepted loss.

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

## Outcome (same session, after the queue above)

Queue items 1–5 done the same evening, browser-mediated
with Bili's explicit go-ahead: DNS imported (DNS-only, BIND upload),
domain verified on GitHub (TXT challenge), `garden/dev` already
public, `sys0/dev` deleted, Squarespace auto-renew off (Bili),
and the profile folded into the site (brand/title "Bili Dong",
garden as tagline, social links as a plain-text footer line) —
after which `qobilidop.github.io` was DELETED outright, no redirect
stub: Bili does not care about old links, and the `www` CNAME
target works without a user-site repo. Enforce HTTPS was still
waiting on GitHub's certificate when hosting moved (pointer at the
top), which made it moot. Remaining: delete the Squarespace account
after 2027-04-01; tend-site rule (item 6).
