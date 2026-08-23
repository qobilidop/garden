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
  Workers static assets, one address, CI and host both able to
  publish. A GitHub Pages standby was built first and then removed
  within the hour — Bili chose setup simplicity over hedging
  Cloudflare's own outages — so the Worker is the sole host and
  GitHub Pages is fully disabled. Record: `hosting-decision.md`
  (+ three research notes beside it).
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
  already made Cloudflare a serial dependency; a parallel GitHub
  Pages standby was judged not worth its explanation debt for a
  personal site and removed.

## Process residue for /evolve

- Repo rename broke the live site silently on two axes the rename
  record didn't list: Pages kept serving at the new path while the
  build used the old base, and GHCR packages do not follow renames
  (CI's image vanished — GHCR is GitHub's container registry). A
  rename runbook should include "republish images; pull with
  credentials".
- Pages' custom-domain redirect activates before DNS exists → a dark
  window; order is DNS first, then cname.
- My early `dig`s before the records existed seeded negative caches
  ("no such name", remembered for up to 30 min) in the home router
  and in macOS's local resolver (mDNSResponder); "site unreachable"
  was a local artefact. Probe new names against a public resolver
  (`dig @1.1.1.1`) or pin the IP (`curl --resolve`), never the system
  resolver, and don't look a name up before it exists.
- Browser-mediated setup worked as a staged handoff: agent fills
  forms to one click; human clicks Create/Delete and handles every
  credential value (token created by Bili, pasted by Bili; bulk-delete
  confirm typed by Bili after Claude Code's auto-mode permission
  classifier blocked it).
  Worth stating in AGENTS.md §Fan-out or a browser rule: stage, never
  confirm destructive or credential actions.
- Wrangler refuses to attach a custom domain while A/AAAA records
  exist; delete first, deploy twice. HTTPS comes up instantly on the
  zone's certificate — a hidden benefit over Pages' ACME wait.
- Two "inert leftovers" were caught only by Bili asking why: the
  `www` record still targeting `qobilidop.github.io`, and the
  standby itself. Lesson: after a topology change, sweep every
  record/setting for names of the retired vendor, not just for
  function.
- The explainer artifact (a published HTML page from this session,
  since retired) could not be scrolled by browser automation inside
  its viewer frame; visual review meant serving the same HTML on
  localhost.
- Three research agents ran in parallel; the probe agent's four
  partitions (hosting, DNS provider, apex vs platform subdomain,
  proxy status) were each re-summed to 49 before use — the check the
  fan-out rule asks for, and it held. The cold-read review later
  found one likely misclassification (drewdevault.com), recorded as
  a caveat in the hosting note.

## Evolve outcome (run at session end)

Accepted and applied: (1) AGENTS.md §Conventions — retired-identity
sweep rule; (2) global rule in both mirrored configs — browser-mediated
setup handoff (stage to one click, human confirms destructive/
credential actions, no screenshot with a secret on screen); (3)
tend-site — no third-party runtime origins; (4) memory hygiene —
`sys0-website` → `garden-website`, profile/résumé memory trimmed to
the living fact; (5) evolve skill names the `Process residue for
/evolve` section and the multi-session read; (7) ingest-post — HN
Algolia is https-only (from the 08-17 staging).

Held: (6) ingest-paper `discussions:` template field — the 08-17 note
claimed two papers use it; only klowden2026-human-thought does. Stays
staged until a second.

Staged (single occurrence): DNS probing hygiene (never `dig` a name
before its records exist; verify via `@1.1.1.1` / `--resolve`); rename
runbook gaps (GHCR packages don't follow renames, Pages path); artifact
visual review = serve the HTML locally; cold-read of notes by a fresh
agent as QA (found real issues tonight); the research-fan-out →
first-principles pattern (second occurrence after the 08-21 TLD pass —
a skill candidate on the third); Bili found a visual explainer useful
for infra topology.

Dropped: Pages DNS-before-cname ordering and wrangler's delete-A-first
quirk — Pages is gone; both remain in the hosting note as record.

Hygiene noted, not acted on: the live Claude settings.json carried two
stale `rclone` permission entries from the retired store tier and an
auto-mode environment block Claude Code wrote; pulled into the repo
copy as-is per the config rule. Removing the rclone entries is Bili's
call.
