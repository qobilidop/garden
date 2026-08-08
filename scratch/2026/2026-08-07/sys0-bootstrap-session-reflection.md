---
author: Claude Fable 5
---

# sys0 bootstrap session reflection

2026-08-07. Written by Claude Fable 5 at Bili's request, closing the session
that took sys0 from post-rename cleanup to a working system: minimalization;
config/claude and config/codex with explicit sync; shadow and store tiers
live; three papers ingested; tooling consolidated behind a dev container;
the first sys skill written from the evidence of its own three runs.

## Principles that emerged

- **Writer count decides the sync mechanism.** Two writers (Claude Code
  rewrites settings.json) → copies with explicit diff/pull/push; one writer
  (skills, statusline) → symlinks are strictly better. The config/ and
  skills/ decisions look opposite but are the same rule.
- **Structure follows evidence, in both directions.** .devcontainer/ and
  .github/ were deleted as unused in the morning and resurrected in the
  evening for concrete needs. Both moves were correct; neither invalidates
  the other. Deleting without prejudice is what makes resurrecting cheap.
- **Absence can be the configuration.** Claude's commit attribution
  interpolates the model only in its default; any explicit value freezes it.
  The deliberate absence is documented where the config lives — otherwise a
  future cleanup "makes it explicit" and silently breaks it.
- **Determinism must be a toolchain property, not trust.** Mechanical
  transcripts (never agent-retyped), version-pinned extractors, immutable
  URLs (arXiv vN, never bare /pdf/), and the byte-identical cross-platform
  regeneration test that proved the pin is what matters.
- **Public verifiability and private durability are different problems.**
  store/shadow already protect us; the Wayback fields exist for readers of a
  public repo whose cited sources will rot. Neither substitutes for the
  other.
- **Challenge-driven refinement worked.** Every "why do we need X?" ended in
  a sharper justification (store nested under shadow; the wayback field) or
  a deletion (the repo-level attribution rule; scratch/README). Both
  outcomes improved the system; the failure mode would have been X surviving
  on inertia.

## Errors worth remembering

- The README retitle was reported as pushed when it had never been staged —
  commit claims must come from `git status`/`log` evidence, not from intent.
- Co-author emails were first derived from bot-account principles when the
  pakeles history already held the ground truth (readable emails link).
  Local evidence beats first-principles derivation where both exist.
- `file(1)` reported a 77-page PDF as 9 pages; two concatenated git statuses
  read as one caused a phantom shadow directory. Surprising output gets
  verified before it gets acted on.

## Open threads

GHCR package visibility flip (manual, Bili); rclone client_id before the
2026 shared-id retirement; Codex skills wiring when wanted; .bib generator
on first need; library types beyond papers when the first book/post/talk
arrives.

## Addendum (same evening: leak guards, dev.sh)

The session continued past this note. Further learnings:

- **Enforce at the irreversibility boundary.** For a public repo that is
  the push, not the commit: pre-push scans the whole outgoing range;
  pre-commit is ergonomics; server-side push protection is the only
  unbypassable layer; CI is audit. Guards sorted by decidability — secrets
  (regex), structure (shell), private context (judgment only, now an
  AGENTS.md rule).
- **Test the guards adversarially, and distrust passing tests.** gitleaks
  silently allowlists obvious dummy tokens (a sequential-alphabet PAT
  passed); only a random token proved the gate. And a "passing" test that
  scanned stale index content nearly certified a broken gate.
- **Fallbacks must not mask explicit pins.** dev.sh's pull-or-build
  fallback, given a pinned missing image, silently built something else
  under the pinned name — found only by testing the failure path.
- Of the open threads above, three closed the same evening: GHCR flipped
  public (verified by anonymous pull), rclone client_id got a scheduled
  cloud reminder (2026-10-01), and the garden journal logs in public
  history were reviewed and accepted.
