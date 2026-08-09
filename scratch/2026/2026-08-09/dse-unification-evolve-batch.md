---
author: Claude Fable 5
---

# Survey unification session: /evolve outcomes

Lessons mined from the dataflow-selection-enumeration record unification
and update (2026-08-09), gated and applied the same day. Evidence lives
in the session's commits (`1ab8e00`..`00d1f0c`) and this note.

## Applied

1. **Fan-out isolation decision rule** (AGENTS.md). Writing fan-outs
   default to worktree isolation; read-only fan-outs share the tree;
   residual shared-tree writers get an explicit git-state-ops ban.
   Reframed from a bare ban after Bili's suggestion: the two agents
   that ran `git stash` under five concurrent writers were both
   *seeking a clean baseline* — worktrees remove the motive, not just
   the symptom. Three more agents burned effort diagnosing sibling
   churn as "pre-existing errors", the same root cause.
2. **Screening tier calibration** (run-survey §2). The exclusion-first
   smaller-tier pass over-coded exclusions ~4× vs the mid tier (158 of
   271 soft disagreements); label-only disagreements lean
   drop-unless-both-coded; the adjudicator holds the memory bar.
3. **`while read` trailing-newline hazard** (both mirrored global
   configs, synced to live copies). One retirement silently skipped;
   caught by recount, not by the loop.
4. **Site build line corrected** (AGENTS.md). The old "build with Node
   from the dev image" line contradicted tend-site and caused the
   exact documented native-binary failure; now: CI in the image,
   local on the host.
5. **Migrations are material revisions** (run-survey §3): distilling
   or authoring any prose appends the reviser to `notes-by` — Bili
   had to request this for the 123 migrated notes.
6. **Skill directory placement** (evolve §3): `assets/` for templates
   the agent instantiates, `references/` for docs it reads,
   `scripts/` for executables — after the note template landed in
   `references/` and was corrected to `assets/`.
7. **Subtraction** (run-survey §2): the "caps documented in the record
   README" claim was false on both reference records (both use the
   protocol); corrected to match reality.
8. **Memory**: multi-item proposals/reports render as per-item visual
   blocks with labeled sub-lines, never paragraph runs
   (`scannable-item-reports`).

## Staged (awaiting recurrence or demand)

- **Declared-quantities validator assertion.** Prose counts drifted
  twice in one session (deep-read total, cited-works tally); the
  review panel caught both, the validator could. Needs an annotation
  convention or a generated-numbers include — build when the drift
  recurs or on request.
- **Load the governing skill before the first domain command.** The
  root cause here (the misleading AGENTS.md line) is fixed; promote
  only if the miss recurs with an accurate rule in place.

## Rejected

- None this round.

## Post-retrospective addendum (same day)

Two further work items closed their own loops inline — no unmined
lessons remain from them:

- **run-survey restructure** (progressive disclosure; heavy mode
  dissolved): the two-direction audit surfaced 17 findings (5
  surgery losses, 12 practiced-but-unwritten conventions), all
  applied to the skill, tend-wiki, and the aarm record in the same
  pass.
- **create-skill** created from three-source prior-art research;
  /evolve §3 now routes the how there. The disclosure threshold,
  description-budget cap, and person-wording nuance were encoded at
  creation.

Staged items unchanged and still awaiting recurrence: the
declared-quantities validator assertion; load-the-governing-skill
before the first domain command. One rule-compliance miss to watch,
not a rule gap: the persisting-`cd` trap recurred (codex sync push).
