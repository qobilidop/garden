---
author: Claude Opus 5
---

# aes update session: /evolve outcomes

Lessons from renaming, migrating, updating, and review-hardening the
agent-assisted-evidence-synthesis survey (2026-08-09, commits
`d3f2d01`..`a46d599`), gated and applied the same day. Evidence lives
in those commits, in the four review agents' reports, and in
`aes-update-batch-harness-lessons.md` alongside this note.

## Applied

1. **Declared-quantities validator check** (shared engine +
   run-survey docstring + aes `check.py`). Promoted from staged — the
   2026-08-09 dse batch staged it after two prose-count drifts with
   "promote when the drift recurs", and this session recurred hard:
   the consistency auditor found roughly ten stale published figures
   across manuscript, record, and syntheses. A survey now declares
   `declared_quantities` — name, derived value, surfaces, and the
   exact phrasings that assert it — and any mismatch fails the
   validator. Verified by outcome, not by log: injecting `776 → 646`
   into RQ1 made `check.py` exit 1 with the file, the pattern, and
   both values; reverting returned it to 0.
2. **Delegated judgment must be per-item and genuineness-checked**
   (AGENTS.md, Fan-out). Two of six exclusion-first screening passes
   returned keyword classifiers — one an explicit program, one 97
   decisions sharing 7 template reasons. Both were plausible in
   aggregate and invisible from decision counts. The prompt now
   forbids scripted classification and requires per-item
   justification; the orchestrator checks distinct justifications
   against item count before consuming results.
3. **A subagent's statistic is a claim, not primary output**
   (AGENTS.md, Fan-out; and the `evidence-before-assertion` memory).
   A published "49 of 66" came from a subagent's self-report. The
   audit disagreed. My correction (54 and 8) was *also* wrong — it
   used exact-code matching where the claim was about direction — and
   nobody noticed that 54 + 8 fails to partition 66 until two
   reviewers independently reached 56 and 10. The rule has two
   halves: recompute a delegated statistic before persisting it, and
   check that a decomposition sums to its total. The second half
   would have caught both wrong answers with no reviewer at all.
4. **Remove the motive for the persisting-`cd` trap** (both mirrored
   global configs, synced live). Third recurrence, and the last one
   was already logged as "a rule-compliance miss, not a rule gap".
   Restating the prohibition twice did not work, so the rule now
   removes the motive: never `cd` to shorten a path; scope a required
   working directory inside its one call and treat the shell as
   resetting. Same shape as the worktree fix — remove the reason the
   error is tempting.
5. **The delta round hunts regressions** (run-survey §6). Asking
   reviewers for new defects introduced by the fixes — improvised
   here — caught a corrected number that was still wrong, two
   sections left contradicting each other, and two hedges that had
   replaced an overclaim with a phrase saying nothing.
6. **Scratch holds data, not mechanics** (run-survey §7). The
   resumability reviewer's most serious finding: dedup, enrichment,
   the vocabulary filter, and the defective-bibliography handler were
   written under a gitignored `.scratch/`, so policy survived in the
   protocol while the tools vanished. A procedure expected to recur
   now ships in the skill's `scripts/`.
7. **Subtractions.** AGENTS.md's fan-out rule cited "decision 0007,
   in git history" — decision logs that were themselves pruned;
   trimmed to the lesson. Two memories still named the old survey
   slug; corrected. And the staged item "load the governing skill
   before the first domain command" is dropped: its root cause was
   fixed, and two sessions have passed without recurrence.

## Staged (awaiting recurrence or demand)

- **`declared_quantities` for dataflow-selection-enumeration.** The
  engine capability is live and aes is its reference implementation;
  dse stays conformant without it. Picking safe patterns needs a pass
  over dse's own prose, which belongs to its next touch rather than a
  blind guess from here.
- **Promote the batch pipeline into `skills/run-survey/scripts/`.**
  The rule now says where such tools belong; the four tools
  themselves still need generalizing (record-path arguments, the
  Crossref citing-position hazard encoded rather than rediscovered).
  Recorded in the survey's own deferred list too.
- **Human-gate artifact retention.** The gate's disagreement set and
  agreement sample are discarded with the rest of scratch, so the
  ledger keeps an attestation no auditor can inspect. Declared a
  deliberate bound in the record README; revisit if an audit ever
  wants the evidence.

## Rejected

- None this round; every proposal was accepted.

## Principles that emerged

- **A correction is unreviewed text.** Twice this session the fix was
  wrong in a new way — the adjudication number, and two hedges that
  traded an overclaim for vacuity. Fixes deserve the same adversarial
  pass as the original.
- **Arithmetic closure beats vigilance.** The single cheapest check in
  the session was noticing that a partition must sum to its
  denominator. It would have caught a number that survived a subagent,
  me, and one full audit round.
- **The panel finds what the author cannot.** Four reviewers over one
  survey produced roughly thirty findings including several factual
  errors, and the verification round found more. The resumability
  reviewer — the one that executes the record as a stranger — was the
  highest-yield of the four, because its failure mode is invisible
  from inside the session that created the knowledge.
