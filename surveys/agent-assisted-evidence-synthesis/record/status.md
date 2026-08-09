# Current survey status

- **Coverage through:** 2026-08-09
- **Catalog:** 1,975 works (745 included, 31 deep-read, 1,123
  excluded, 76 parked); include-level total 776
- **Maintenance state:** 2026-08-09 update batch reconciled and
  human-gated; updates on demand
- **Manuscript:** revised for the 2026-08-09 batch and passed through
  a four-reviewer adversarial panel with a verification round; under
  continuing human review

Counts are mechanical — regenerate with the shared update tool's
`status` command or `check.py` rather than editing them here
after every small change.

## Method changes

Campaign-scoped, append-only, newest last; `protocol.md` always
reads as the current rules, this log records how they are changing
during the open campaign. At campaign close the log dissolves: its
content is already absorbed into the protocol's final state, the
permanent audit rows in `log.tsv`, and the manuscript's method and
limitations disclosures; git keeps the log itself.

- **2026-08-09 — retitle.** "Agent-Assisted Systematic Review
  Methodology" → "Agent-Assisted Evidence Synthesis" (slug
  `agent-assisted-review-methodology` →
  `agent-assisted-evidence-synthesis`). The declared scope was
  already secondary studies broadly; the executed query vocabulary
  was review-centric relative to it, so this update added
  mapping-study, scoping-review, and living-review qids
  (`queries.tsv` theme `genre-gap`). The old title named the field's
  dominant genre; the new one names the declared scope.
- **2026-08-09 — update-window semantics.** The reconstructed search
  rule 2 promised an overlap start one calendar year before the
  previous cutoff; the unified update tooling (shared with
  dataflow-selection-enumeration) fetches the inclusive interval
  since each query's `last_reconciled` date, and rule 2 now states
  the semantics actually run. Delayed indexing beyond the inclusive
  boundary is accepted as a coverage limitation. A never-reconciled
  query takes the survey window start (2020-01-01) as its first
  from-date.
- **2026-08-09 — screening-pass quality failure.** Two exclusion-first
  passes on the smaller tier returned keyword heuristics rather than
  judgments (one an explicit classifier program, one 97 decisions
  sharing 7 template justifications). Both were discarded and re-run
  with an explicit no-heuristic instruction. The detector that caught
  them — distinct justifications per decision — is now part of how
  screening output is accepted, and the episode is disclosed in the
  manuscript rather than only fixed.
- **2026-08-09 — title-prefilter recall gap disclosed.** Designating
  akinseloyin2026 critical and chasing it surfaced a work whose
  abstract is on-topic but whose title carries no genre term, so the
  snowball title vocabulary had dropped it before the abstract was
  read. The work itself is out of scope on its merits (clinical
  decision support), but the gap is real: `protocol.md` now states
  the limitation and the manuscript discloses it. The prefilter was
  not widened — reading every chase abstract does not scale — so this
  is a disclosed bound on snowball recall, not a fixed defect.
- **2026-08-09 — snowball model vocabulary.** The batch rejected an
  on-topic "Generative AI" work that never uses a matched literal
  phrase; the model-side vocabulary gained
  `\bai\b|\bgenai\b|\bgai\b|generative ai|foundation model` and the
  batch's snowball prefilter was re-run under the amended list
  before screening. Earlier stages and the v1 campaign ran without
  these tokens.

## Deferred to the next update

- **Register the remaining manuscript citations as evidence
  records.** `evidence.md` covers the findings-bearing citations;
  the method-canon citations (their notes live as library pages, not
  record notes) and full section-by-section coverage are not yet
  registered.
- **Reconcile the two remaining manuscript compressions.** The
  2026-08-09 revision folded in three of the five the syntheses
  flagged: hamel2021's graded risk-ranking, the direction of
  fagerberg2025's adjudication relabels with its specificity lower
  bound, and huang2026's middle ablation. Two remain summarized only
  in the limitations rather than in the sections that make the
  claims — the PRISMA-AI status discrepancy between holst2025 and
  fernandes2026, and the unstaged oami2025-vs-madeyski2025 metric
  dispute.
- **Grade evidence certainty.** `evidence.md` supports the optional
  GRADE-inspired **Certainty** field; grade the 27 records on the
  next evidence touch.
- **Fill per-row decided keys.** Campaign-era log rows carry counts
  only; update rows from 2026-08-09 onward record their
  `included_keys`/`excluded_keys` per the unified write contract.
- **Generalize the batch pipeline into the shared tooling.** Dedup,
  abstract enrichment, the snowball vocabulary filter, and the
  primary-complete handler were written per-batch under `.scratch/`,
  which git does not keep. The rules are now in `protocol.md`, but the
  next update rebuilds the tools. Promoting them to
  `skills/run-survey/scripts/` alongside `update.py` would remove the
  largest rebuild cost from every future batch.
- **Re-test the terminology synthesis against the appraisal notes.**
  `syntheses/terminology.md` was drafted against the 25 notes present
  at the time; hirt2021 and rose2025 arrived during drafting and bear
  on its appraisal-vocabulary strand. The manuscript states this scope
  explicitly; the re-test is owed.
- **Fold in the last two manuscript compressions.** The PRISMA-AI
  status discrepancy and the oami2025-vs-madeyski2025 metric dispute
  are summarized in the limitations rather than in the sections that
  make the claims.
