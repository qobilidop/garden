---
author: Claude Fable 5
---

# Survey unification session: lessons batched for /evolve

Raised during the dataflow-selection-enumeration record unification and
update (2026-08-09); candidates for the next /evolve retrospective, not
applied point-wise.

1. **Shared-tree fan-out must ban git state operations.** Two note-migration
   subagents ran `git stash`/`git stash pop` in the shared working tree while
   five siblings were writing — recoverable this time, roulette in general.
   Candidate: AGENTS.md Fan-out section (alongside the existing gated-capability
   rule) and the run-survey screening/migration prompts.
2. **Dual-pass screening tier calibration.** The exclusion-first pass on the
   smallest model tier over-coded E-codes roughly 4× relative to the
   eligibility-first pass on the mid tier (158 of 271 soft disagreements were
   small-tier E-codes on ordinary ML papers). The adjudicator absorbed it, but
   the skill could note the asymmetry and a drop-unless-agreed lean for
   coded-memory decisions.
3. **`while read` drops a trailing-newline-less final line.** One retirement
   was silently skipped because the list file lacked a final newline; caught
   only by a set-difference audit. Candidate for the global shell-discipline
   list: iterate files with a tool that reads to EOF, or verify by recount.
4. **Load the site skill before the first site command, not after the first
   failure.** The documented dev.sh/npm trap was hit verbatim despite the
   skill documenting it.
5. **Derived counts want one more guard.** Manuscript prose counts drifted
   twice within one session (deep-read total, cited-works tally) between
   record edits and reconciliation; both were caught by re-derivation, not by
   the validator. Candidate: a validator assertion comparing declared prose
   quantities against derived counts, or a generated-numbers include for the
   method section.
