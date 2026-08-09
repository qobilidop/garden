# song2026-the-phases-of-living-evidence-synthesis-using-ai — phase model for AI/semiautomated tools in living evidence synthesis

- **Status:** G1 deep-read
- **Work:** doi:10.2196/76130 — Song, Lian, Wang, et al. (2026), "The Phases
  of Living Evidence Synthesis Using AI: Living Evidence Synthesis (Version
  1)" (J Med Internet Res 28:e76130, JMIR, gold OA CC-BY)
- **Source:** transcript at
  shadow/library/papers/2026/song2026-the-phases-of-living-evidence-synthesis-using-ai/transcript.md
- **Facets:** stage=end2end, contribution=method, setting=med

## Evidence

- Phase model (adopted from Thomas et al. 2017, not new here): LE synthesis
  has 4 phases — (1) database searching and eligibility assessment, (2)
  data extraction/collection and risk-of-bias assessment, (3) synthesis and
  analysis, (4) publication update. The paper maps AI/semiautomated tool
  use across 24 included studies onto these phases.
- Tool inventory: 34 distinct tools across the 24 studies — 12 (35.3%) "AI
  tools" (autonomous, no human intervention) vs 22 (64.7%) "semiautomated"
  (human review at critical stages). Most frequent: ML classifiers (n=5),
  LIvE platform (n=3), AD-SOLES/Covidence/MAGICapp (n=2 each).
- Automation level per phase (tool counts): Phase 1 = 18, Phase 2 = 20,
  Phase 3 = 10, Phase 4 (publication update) = only 1 tool (RobotReviewer
  LIVE — also the only tool spanning all 4 phases). LLMs (GPT-4-turbo,
  Claude-3-Opus) concentrate in Phase 2.
- Update triggers (this LE synthesis's own protocol): 12-month living-
  update registration, 4 retirement triggers — evidence reaches
  conclusiveness; loses decision-making value; no new eligible studies in a
  12-month window; funding unavailable. Post-publication authors keep it
  living (no trigger fired) to feed downstream working groups.
- Human gates: dual independent reviewers + third-reviewer adjudication for
  screening/extraction/quality throughout. Quality graded per study type:
  modified QUADAS-2 (10 studies, DTA-framed, "AI"="index test"), JBI
  Checklist (5 tool-dev studies), AMSTAR 2 (9 studies, scores 11-15/16,
  mostly "moderate").
- Evaluation WITH NUMBERS (pooled from the 24 studies, not new measurement):
  efficiency reported by 10/24 (41.7%) — time saved 45.9% (per-abstract) or
  2.0-13.2h; workload 68% tool-completed, or 23%→55% (~140% relative gain);
  conflict rate 8.32%→3.64%. Accuracy — recall (9 studies) mean 96.24% (all
  >87%, 3 at 100%); F1 (6 studies) mean 92.17% (range 80.47-99%); precision
  (8 studies) 0.2-100%, by far the most variable metric; one AUC-ROC
  94.25-94.77%. Pooling formula: simple mean of per-study values (single
  value, or range midpoint). Utility (3 studies, all Phase 1): satisfaction
  4.2/5; inter-reviewer consistency 79.0-96.0% agreement, Kappa 0.40-0.63;
  relevance 50.49%, quality 64.53%. Accuracy evidence concentrates in
  Phases 1-2; Phase 4 has no efficiency/accuracy/utility evidence beyond
  the single RobotReviewer LIVE citation.

## Bearing on RQs

Directly relevant to RQ1 as a cluster-anchoring landscape source: a
systematic map of AI/semiautomated tooling across the full LE lifecycle,
inventorying 34 named tools by phase — maps roughly onto this survey's own
stage taxonomy (phase 1≈search+screen, phase 2≈extract+appraise, phase 3≈
synthesize, phase 4≈report/update). Also bears on RQ2 via pooled
recall/F1/precision (96.24%/92.17%/0.2-100%), though secondary meta-
synthesis of others' numbers (simple mean, no formal meta-analysis) — an
aggregate sanity-check, not primary data. Most novel for RQ1/RQ4-adjacent
design: publication update is the near-unautomated stage (1/34 tools), and
the paper models its own living-review maintenance — retirement triggers,
dual-reviewer QA, monthly database subscriptions via Covidence — as a
concrete template this survey layer could imitate for its own upkeep.

## Evidence limits

- Review-of-reviews: all efficiency/accuracy/utility numbers are pulled
  from the 24 primary studies screened, not independently re-measured.
- Small, uneven denominators per metric (2/24 time-saving, 2/24 workload,
  1/24 conflict-rate, 3/24 utility, authors' own %s) — headline recall/F1
  means (n=9, n=6) are not representative of the full set or wider field.
- No formal meta-analysis: authors explicitly skip statistical pooling,
  sensitivity analysis, reporting-bias/certainty assessment, and
  heterogeneity investigation — pooled means are unadjusted averages
  across heterogeneous tools/tasks/phases.
- Search bounded by "living evidence" terminology (authors' stated limit)
  — AI-review-updating work under other terms may be undercounted, which
  could specifically undercount Phase 4, the sparsest phase in this note.
- Snapshot only: itself an open, still-living review (v1, search cutoff
  April 2, 2025); phase/tool counts will change on update.
