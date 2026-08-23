---
author: Claude Fable 5
---

# Garden setup session: domain, cutover, hosting

One evening, 2026-08-22 (Pacific), continuing the rename record of
2026-08-21. Everything below is committed and live; the two decision
notes in this directory are canonical and this note only points.

## What landed

- qobilidop.com registered (Cloudflare Registrar, 10 y); qobilidop.dev
  set to lapse 2027-04-01, Squarespace account to follow. Record:
  `domain-and-site-cutover.md`.
- Repo-side cutover: site at the domain root, full sys0→garden sweep,
  dev image republished under the new name, Pages custom domain +
  account-level domain verification, profile folded into the landing
  page, `qobilidop.github.io` deleted outright (no stub — old links
  don't matter, and the `www` CNAME target never needed the repo).
- Hosting re-decided the same night after a research pass (49-site
  probe, authors' rationales, option/incident survey): Cloudflare
  Workers static assets primary, GitHub Pages dormant standby, one
  address, CI and host both able to publish. Record:
  `hosting-decision.md` (+ three research notes beside it).
- Harness updated in the same change: AGENTS.md §Site, tend-site
  deploy loop. An explainer artifact of the deploy path was produced
  for Bili's understanding and retired once it served.

## Decisions settled

- Date of registration is special because of what the repo did that
  day; no waiting for a calendar date.
- Global reach: mainland China is the only hard region (ICP), not
  pursued; the hedge is portability plus no third-party runtime
  origins (rule still to codify in tend-site).
- "Two URLs per page" is not duplication when the second is a 301;
  the Worker removes even that (no default hostname), and the
  canonical link makes the one address explicit.
- Registrar + DNS + hosting at one vendor is acceptable because DNS
  already made Cloudflare a serial dependency; GitHub Pages stays as a
  parallel standby, not a link in the chain.

## Process residue for /evolve

- Repo rename broke the live site silently on two axes the rename
  record didn't list: Pages kept serving at the new path while the
  build used the old base, and GHCR packages do not follow renames
  (CI's image vanished). A rename runbook should include "republish
  images; pull with credentials".
- Pages' custom-domain redirect activates before DNS exists → a dark
  window; order is DNS first, then cname.
- My early `dig`s before the records existed seeded negative caches
  in the router and mDNSResponder; "site unreachable" was local for
  ~30 min. Probe new names against `@1.1.1.1` / `--resolve`, never the
  system resolver, and don't look a name up before it exists.
- Browser-mediated setup worked as a staged handoff: agent fills
  forms to one click; human clicks Create/Delete and handles every
  credential value (token created by Bili, pasted by Bili; bulk-delete
  confirm typed by Bili after the auto-mode classifier blocked it).
  Worth stating in AGENTS.md §Fan-out or a browser rule: stage, never
  confirm destructive or credential actions.
- Wrangler refuses to attach a custom domain while A/AAAA records
  exist; delete first, deploy twice. HTTPS comes up instantly on the
  zone's certificate — a hidden benefit over Pages' ACME wait.
- The artifact viewer's iframe ignores automation scroll; visual
  review of an artifact means serving the same HTML on localhost.
- Three research agents ran in parallel; the probe agent's partition
  counts were recomputed (49 = 49 on both splits) before use — the
  check the fan-out rule asks for, and it held.
