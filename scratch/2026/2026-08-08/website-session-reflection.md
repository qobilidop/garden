---
author: Claude Fable 5
---

# Website session reflection

One session took `site/` from nothing to a live, designed, lint-guarded
projection of the wiki and library (qobilidop.github.io/sys0), fixed the
gitleaks CI failures, and rebuilt the dev-image pipeline on native arm64
runners. This note records what the session taught, per skills/evolve.

## Principles that emerged

- **Decisions from research, not training memory.** The session's first
  correction ("It's already Quartz 5 BTW") was a recommendation made
  from stale knowledge. Every decision accepted afterward followed one
  loop: background research with primary sources cited and unverified
  claims flagged → precedented options → one recommendation with honest
  costs. Stack choice, typography, catalog ordering, date granularity,
  and title casing all went through it. Ecosystems move faster than
  cutoffs; the loop is the fix.
- **Unwritten conventions drift.** Three same-mechanism failures: the
  "Notes:" H1 prefix, ad-hoc short display titles, bare unlinked
  citekeys — each a convention that existed only by imitation. Each fix
  was the same: codify in the governing skill, machine-check where
  checkable. Now an AGENTS.md rule.
- **A gate is verified by its outcome, not its error text.** The
  "unresolved wikilinks fail the build" invariant was asserted after
  seeing the error message; the build actually exited 0, and the
  invariant was false for three commits. Astro logs markdown-pipeline
  errors without failing; build-failing checks must throw at config
  load. Verify enforcement end to end: inject a violation, check the
  exit code.
- **Guards must agree with themselves.** CI ran gitleaks 8.24.3 while
  hooks and the dev image ran 8.30.1; root-level `[[allowlists]]`
  (added in 8.25.0) was silently ignored in CI only. Version-pin every
  multi-site guard and cross-reference the pins. Now an AGENTS.md rule.

## Staged (once-seen, promote on recurrence)

- Test injections into files carrying unstaged work: appending a lint
  violation to `wiki/ai4math.md` and `git checkout`-ing it destroyed
  that file's real uncommitted fixes. Inject test content only into
  clean files, or remove the exact appended lines instead of
  checkout-restoring.

## Negative results worth keeping

- No publication archive found doing progressive date granularity
  (months for recent years, years for old) — the pattern lives in file
  managers and mail clients only. Uniform month labels chosen.
- No rigorous readability study separates Title Case from sentence
  case; the casing decision stands on information-carrying capitals and
  wiki link mechanics, not reading speed.
- Readability guidance converges on 45–75 characters per line (ceiling
  80); wider needs gwern-style sidenote justification.

## Open threads

- Deferred site items: publishing `scratch/` (decided no for now),
  authored vs generated landing page (authored for now), self-hosted
  Source Serif 4, hover popovers for wiki-to-wiki links.
- The dev.sh/host `node_modules` clash (shared mount, per-platform
  binaries) is worked around, not solved; a container-scoped modules
  directory would solve it properly.
- Session procedures now codified: skills/tend-site (site loop).
