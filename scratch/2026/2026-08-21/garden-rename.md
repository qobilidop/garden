---
author: Claude Fable 5
---

# Renaming sys0 to garden

Bili is reorganizing his repos into domains defined by audience: den
(self), nest and hearth (widening private circles), and a fourth,
world-facing tier — this repo. The name garden was chosen for that
tier: it completes the dwelling metaphor (the grounds where the home
meets the street), names the genre this repo already practices, and
the tending verbs were here first (tend-site, tend-wiki).

Full circle, deliberately: this repo was garden until 2026-08-07,
when it was renamed sys0 under an "incarnation 0 of sys" framing.
Returning is not indecision — the framing changed. The repo is now a
tier in a domain scheme, not a generation in a numbered series. This
supersedes the 2026-08-08 "keep sys0, don't re-raise" identity
decision; Bili re-raised it himself.

## Generational numbering retired

The sysN scheme existed for one fear: bloat forcing a
rebuild-from-scratch. Examined 2026-08-21, the fear splits in two and
neither part justifies numbering:

- Git-history bloat is prevented by construction — text-only content,
  hooks capping file size, blobs in shadow. Text history compresses;
  a lifetime of markdown never approaches git's limits. If measured
  pain ever appears, shallow clones and `git-filter-repo` are
  incremental remedies; the trigger is felt pain, not elapsed years
  (same principle as the store fold).
- Worktree bloat (stale notes, dead structure) is real but is
  answered by per-layer lifecycles, not repo rebirth: scratch expires
  by rule, library is an append-only catalog immune to bloat, wiki
  pages are rewritten in place, surveys live in spoke repos. Rule 1
  (value lives in the worktree, history is the archive) makes
  deletion safe — a reseed is a mass `git rm` plus losing every
  inbound link, and the repo has since become an address (site,
  DOIs, citekeys) whose value compounds with permanence.

The mechanism also failed its only field test: the one generation
transition that happened (garden → sys0) chose continuous identity
over copy-reseed. Fork-and-archive stays in reserve for a genuine
paradigm shift — an identity event, unpredictable, not worth
numbering for in advance. The reseed *discipline* (distill scratch,
prune hard) survives under any name.

## Website folds in; domain settled

The personal website (previously its own repo at qobilidop.github.io)
becomes part of garden: a personal site is definitionally
world-facing content, so a separate repo was an artifact of history.

Canonical address: **qobilidop.com** (available as of 2026-08-21, to
be registered by Bili after this note). qobilidop.dev, already owned
but never published on (verified: zero references across local
repos), will be allowed to lapse — an alias earns its keep only when
links or habits point at it. Reasoning, distilled from a
research pass over notable personal sites and TLD incident history:

- Own the address layer. Both github.io options are rented (platform,
  username, repo name); a custom domain survives every migration
  beneath it, and a custom domain on a project-pages site serves at
  the domain root — the base path disappears and repo renames stop
  breaking links forever.
- .com over .dev: the TLD is the one part of the address that can't
  be renamed out of; .com is scope-neutral where .dev has settled
  into "developer tooling docs" (a survey of 35 notable personal
  sites found ~74% on .com/.net/.org and zero on .dev). Registry
  durability equal-ish; legibility universal.
- Novelty TLDs declined with evidence: three documented failure modes
  — registry repricing (Uniregistry 2017, .io/.ai ongoing),
  sovereignty (queer.af 2024, .wed EBERO 2017, .io/Chagos pending),
  spam reputation (.top/.xyz). Google-registry gTLDs (.dev) are the
  exception with boring-TLD risk, which made .dev the keepable one.
  qobilidop.garden declined: a cool TLD earns its place only when it
  completes the name (sive.rs, karpathy.ai); this one decorates.
  (.dev's safety made it the keepable alias, but keepable is not a
  reason to keep — see above.)
- qobilidop.net declined; revisit only if actual confusion occurs.

Accepted loss: existing `qobilidop.github.io/sys0/…` links die
(Pages URLs don't redirect across renames). Bili: the site hasn't
been promoted; the links barely exist.

## Execution queue (nothing below is done yet)

1. Register qobilidop.com (Bili): at-cost registrar, auto-renew,
   multi-year. Disable auto-renew on qobilidop.dev and let it lapse.
2. Rename repo sys0 → garden; sweep in-repo references (README
   framing loses "incarnation 0", AGENTS.md, site config).
3. Point the domain: DNS apex + www, CNAME file, Pages settings.
4. Fold the profile page into the site (content allowlist change;
   masthead identity is a tend-site taste call).
5. Retire the qobilidop.github.io repo to a redirect stub.
6. Move the local checkout (`~/i/sys0` → `~/i/garden`) and migrate
   the path-keyed agent memory store.
7. nest and hearth: named, not created — first real artifact is the
   trigger.
