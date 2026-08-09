---
author: Claude Fable 5
---

# aes update batch — staged harness lessons

Raw material for the post-campaign /evolve; not yet rules.

- **Screening agents will write classifiers if not forbidden.** Two
  of six Haiku exclusion-first passes returned keyword-heuristic
  output (one literal script, one 7-distinct-template-reasons file).
  An explicit "your own judgment, no deciding scripts, one specific
  sentence per work" clause fixed it on re-run. The orchestrator-side
  detector that worked: distinct-reason count ≈ row count, plus
  spot-reads. Candidate rule for run-survey: screening/facet prompts
  carry the prohibition + the reports carry a genuineness check.
- **Log-row grammar is engine-defined but only discoverable from
  source.** Decided-key cells are comma-separated; snowball rows bind
  to seeds via `seed-key:<catalog-key>` in notes; defect markers in
  notes trigger the primary-complete requirement. None of this is in
  the skill or a README — first authoring of update log rows required
  reading `survey_check.py`. Candidate fix: a log-row reference block
  in the skill, or an engine subcommand that emits template rows.
- **Never-reconciled queries crashed the shared tooling** (empty
  `last_reconciled` → invalid `--from-date`; engine rejected the
  empty cell). Fixed in d0d210c (`--initial-from-date` + engine
  acceptance); the gap existed because v1 never added queries
  post-campaign.
- **Registrar reference-position pseudo-DOIs** (`<doi>_b7` in
  Crossref bibliography `source_id`) normalize as plausible DOIs;
  the pipeline agent caught it by verification, not by design.
  Candidate: note in the fetch tool's output schema or key grammar.
- **Adjudicator scale asymmetry reproduced v1's measurement**: the
  exclusion-first smaller-tier pass over-included on domain reviews
  this time (opposite direction from v1's over-exclusion) — the
  systematic error direction depends on the corpus mix (snowball
  waves pull in domain reviews), not just the tier.
- **Session-scoped protocol conventions landed mid-campaign**:
  method-change log lives in status.md (campaign-scoped, dissolves
  at close), protocol.md stays final-state — already codified in the
  skill this session; /evolve should verify dse adopts on next touch.
