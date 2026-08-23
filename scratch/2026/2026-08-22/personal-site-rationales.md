---
author: Claude Fable 5
---

# How thoughtful people host their personal sites — rationales (web survey, 2026-08-22)

Method: WebSearch/WebFetch only. "Not found" = not in fetched primary text; [inferred]/[3rd-party] flagged. indieweb.org (403) and xeiaso.net (Anubis) could not be fetched directly.

## 1. Per author

| Author | Setup (stated) | Rationale (stated) | Source |
|---|---|---|---|
| Dan Luu | Octopress static; GitHub Pages, then Cloudflare in front (c.2014). Web-bloat post: 55–75% of traffic served from CDN cache. Current host not stated. | Moved to Cloudflare because "Github Pages doesn't put content on a CDN for bare domains unless you use a DNS alias record"; needs "Cache Everything" rule. Perf, not longevity. | danluu.com/octopress-speedup/, danluu.com/web-bloat/ |
| Gwern | Hakyll static. NFSN 2010–12 (pay-as-you-go) → S3+Cloudflare 2012–19 (cheaper bandwidth) → Hetzner dedicated 2020– (~$50/mo, uncapped bandwidth; S3 bandwidth had hit >$600/yr). Whether Cloudflare still fronts Hetzner: not confirmed. Git + WebCite/IA link archiving. | "Long Site": "100% FLOSS software, open standards for data, textual human-readability, avoiding external dependencies, and staticness"; "A static text-source site has many advantages for Long Content". Each move was cost-driven. | gwern.net/about, gwern.net/design |
| Derek Sivers | OpenBSD on a Vultr VPS ($10/mo), OpenBSD httpd (ti page) / Nginx (uses page), Porkbun or Netim registrar (pages disagree by date), Bunny CDN for media. | "Tech independence is not depending on any particular company or software"; "If a company turns evil or goes out of business… set up a new server anywhere else in an hour, point your domain name to the new IP address". | sive.rs/ti, sive.rs/uses, sive.rs/openbsd |
| Rachel Kroll | Own box ("flicker"), moved May 2023 off SoftLayer/IBM; Apache [3rd-party]. | Left because IBM-era management "increasingly problematic" despite acceptable rates/IPv6 (post fetch failed; summary from search snippet — verify). | rachelbythebay.com/w/2023/05/27/newbox/ |
| Simon Willison | Custom Django on Heroku + PostgreSQL, behind Cloudflare; content backed up to JSON in GitHub → Datasette. | Cloudflare absorbs HN spikes so the "tiny little cheap Heroku instance doesn't even notice". Explicit "why not static" not found [inferred: dynamic features, Django admin]. | simonwillison.net/about/, mtlynch.io/notes/simon-willison-software-misadventures/ |
| Julia Evans | Hugo; Netlify → $5 DigitalOcean droplet + nginx, local Docker build, rsync (2022). | Bandwidth "$1/100GB… (20x less)" than Netlify; 7 s deploys vs ~1 min; "I can just look at the nginx logs!"; honest: "I don't really know what this will be like to maintain". | jvns.ca/blog/2022/01/24/hosting-my-static-sites-with-nginx/ |
| Xe Iaso | Go server on Fly.io (Toronto) + own CDN "XeDN" in 35 Fly regions, assets on Backblaze B2 (Nov 2023); later "xesite v4" = static generator still on Fly (direct page blocked). | Fly anycast: "If any individual XeDN server goes down, I can rely on the other XeDN servers"; scale-to-zero cost. Availability/cost, not longevity. | fly.io/blog/how-i-fly/, xeiaso.net/blog/xesite-v4/ |
| Drew DeVault | `zine release` → `hut pages publish` (sourcehut pages), per `.build.yml`. | No own-words rationale found. | git.sr.ht/~sircmpwn/drewdevault.com |
| Jeff Kaufman | Dynamic VPS (Amazon Lightsail, $10/mo, 2023) after prior VPS had 3 outages in 2023; some projects on GitHub Pages. | "I enjoy being able to play around with dynamic bits"; on domains: "make sure you're willing to take on the cost and hassle of keeping the domain registered indefinitely." | jefftk.com/p/moving-vps-again, jefftk.com/p/dont-let-personal-domains-expire |
| Tom MacWright | Jekyll→Eleventy (2026); GitHub → Netlify (left GH Pages 2017 for HTTPS); Cloudflare registrar + R2; domain ~$20/yr. | Priorities "Simplicity, Longevity, Speed"; Lindy effect; dependency count (Eleventy 116 vs Astro 246); "I've used simple tools to make something simple and it has been unproblematic"; in 2017: "the whole system requires trust". | macwright.com/2026/04/17/eleventy, /2017/05/08/https, /2017/07/20/decentralize-your-website.html, zacharykai.net/notes/pb/tom |
| Michael Lynch | Hugo; Firebase → Netlify $19/mo manual-build mode (2021). | Firebase $0.15/GB on ~150 GB/mo; "I want to use a CI vendor for CI, and I want to use a hosting provider for hosting." | mtlynch.io/retrospectives/2021/12/ |
| Jim Nielsen | Metalsmith→Web Origami; Netlify; $0; iPhone Shortcut hits build hook daily (2026). | "If I go off grid for a few days and my website doesn't refresh, I'm ok with that trade-off." (URL-longevity claim seen only in search snippet — unverified.) | blog.jim-nielsen.com/2026/new-year-new-website-same-me/, zacharykai.net/notes/pb/jim |
| Kev Quirk | VPS at Ionos. | Distinguishes renting a VPS from self-hosting. | kevquirk.com/what-is-self-hosting |
| Karpathy | "pure HTML and CSS in two static files"; host not stated [inferred GitHub Pages from karpathy.github.io]. | "allergic to 500-pound websites". | karpathy.ai |
| Paul Graham / Cegłowski | Nothing in own writing found; PG served from Amazon IP, Yahoo NS [3rd-party whois]. | — | — |
| Jeff Huang (bonus) | Single vanilla HTML file, no hotlinks, system fonts, two uptime monitors. | "Medium, Twitter, and even hosting services like GitHub Pages will be plundered then discarded when they can no longer grow." | jeffhuang.com/designed_to_last/ (2019) |
| Steren Giannini (bonus) | Raw HTML+CSS in git, GitHub Pages, custom domain. | "custom domain in order for my URLs to be insensitive to a change of host"; "The best tool is no tool, the best build step is no build step." | blog.steren.fr/2020/my-stack-will-outlive-yours/ |

## 2. Cross-cutting themes

- **Longevity is argued at the content/format layer, not the host layer.** Gwern, Huang, Steren, MacWright, healeycodes all converge on: static text source in git, plain HTML output, minimal/Lindy dependencies, no hotlinking. Hosts are treated as disposable; the domain is the identity (Steren, Sivers, Kaufman).
- **Explicitly rejected:** platforms (Medium/Substack), frameworks/JS for documents, hotlinked assets/fonts, coupling CI to host (Lynch), per-GB bandwidth pricing (Gwern, Evans, Lynch all moved for that reason), and — for the most longevity-minded — free tiers of growth companies (Huang).
- **Two camps on where the bits live:** "own box" (Sivers, Kroll, Evans, Kaufman, Gwern) for control/cost/logs vs "git-push to a static host" (MacWright, Nielsen, Lynch, DeVault) for zero-ops. Both keep a local copy that "could re-publish anywhere" (MacWright).
- **Availability hedging is rare and mostly absent.** Only Xe (Fly anycast) and Willison (Cloudflare shielding Heroku) discuss it, and as traffic-spike resilience. No seeded author describes dual-host/DNS-failover for a personal static site; HN threads mention "host across multiple platforms" only in passing. Huang's substitute is monitoring, not redundancy.
- **Honest uncertainty:** Evans and Nielsen explicitly accept maintenance/downtime trade-offs rather than engineering them away.

## 3. Empirical distribution data

- HN "Ask HN: What do you use for your personal blog?" (Sept 2024, item 41608459), approx. mentions: GitHub Pages 5, Netlify 4, self-hosted/VPS 3, Cloudflare Pages 2, Fly 1; SSGs Hugo 5, Jekyll 4, Astro 4, Zola 3. Small, self-selected.
- HN "How to build a website that will last 30 years?" (Oct 2022, 33164027): static HTML ~15 mentions, archive.org ~8, GitHub Pages ~4, self-host ~4. HN "static page that would last forever" (Nov 2024, 42099469): GitHub Pages called "the only sensible answer" by several; IA as backstop; "Just put it on your own domain and keep it there while you're alive."
- Jamstack Community Survey 2022 (~7,000 devs, Netlify-run; not personal-site-specific, no host shares): 11ty 19%, Jekyll 14%, Hugo 13% usage.
- No survey of personal-site hosting shares for 2025–26 was found; the 2025 "Blog Questions Challenge" has no tally. indieweb.org/web_hosting and /longevity exist but returned 403.

## 4. Most useful primary sources for a decades-horizon static site

1. gwern.net/about — 15-year hosting ledger with costs and the "Long Site" principles.
2. jeffhuang.com/designed_to_last/ — concrete 7 rules; skeptical of every host.
3. blog.steren.fr/2020/my-stack-will-outlive-yours/ — domain-as-identity, no-build-step argument.
4. macwright.com/2026/04/17/eleventy (+ 2017 decentralize post) — simplicity/longevity/speed tradeoff, Lindy, dependency counting.
5. sive.rs/ti — the "rebuild anywhere in an hour" portability stance; jvns.ca 2022 nginx post as the pragmatic VPS counterpart.
