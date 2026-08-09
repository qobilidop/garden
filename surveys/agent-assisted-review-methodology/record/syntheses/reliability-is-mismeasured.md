# Reliability is real but mismeasured

Status: current through the 2026-08-08 baseline.

## Current conclusion

Three claims survive cross-reading of the selected evidence. (1)
Screening performance is heterogeneous, and the heterogeneity is
dominated by the dataset/review, not the model: in the one systematic
SE benchmark, study effects exceed differences among the larger tested
models. (2) The field's common metrics misstate performance under the
class imbalance that defines screening: accuracy-style reporting can
crown a model that loses most of the relevant evidence. (3) The right
comparator is the imperfect human baseline (single-reviewer screening
sensitivity ~87–92%, human extraction errors reported up to 50% — both
secondhand estimates), not an idealized perfect reviewer; against that
baseline the strongest configurations are competitive, but no selected
single-model result meets a stated deployment bar.

## Strongest supporting results

- **Metric choice changes rankings.** madeyski2025 (29-paper
  convenience sample, single-extractor): 7/29 (24%) report complete
  confusion matrices, 3/29 (10%) report MCC, 17/29 (59%) use accuracy;
  none of 5 workload-savings papers priced false-negative cost. In one
  9,695-article reanalysis the accuracy-best, MCC-best, and WMCC-best
  models are three different LLMs, losing 63.3%, 43.9%, and 5.8% of
  relevant evidence respectively. On SESR-Eval data, MCC and WMCC
  disagree on the best LLM in 55% of evaluable studies.
- **Aggregation choice changes rankings too.** huotala2025 reports
  results at pooled primary-study level and per-review level and the
  best model differs between them (GPT-4.1 mini best pooled accuracy,
  Llama 4 Maverick best per-review) — same data, different comparison.
- **Study effect > model effect.** huotala2025 (34,528 labeled
  records, 24 SE reviews, 9 models): per-review accuracy ranges
  0.34–0.85 and F1 0.07–0.92 — wider than the spread across the seven
  larger models; logistic-regression study odds ratios range far wider
  than model odds ratios. No nondegenerate operating point met the
  authors' bar of recall ≥ 0.95 at precision ≈ 0.50.
- **Model capability moves specificity more than sensitivity.**
  oami2025 (five sepsis questions, 0.24% positive rate, one fixed
  sensitivity-optimized prompt): GPT-3.5→GPT-4 Turbo left sensitivity
  statistically unchanged (0.83 → 0.85) while specificity rose 0.51 →
  0.98 (significant). Under extreme imbalance that specificity move is
  the workload story, yet absolute FP/FN counts were not reported.
- **Prompt sensitivity is real but poorly quantified.** gargari2023
  (single review, N=330, letter format): eight prompt variants moved
  GPT-3.5 from 62% sensitivity (prompt 1) to a level the authors
  compare with a junior reviewer (prompt 5) — but most per-prompt
  numbers are directional prose in an unverified supplement, with no
  significance testing and possible order effects.
- **Corpus character predicts failure.** syriani2023: recall 0.327 on
  the one corpus with 52.7% recorded human conflict (MobileMDE) vs
  0.738–0.947 on the other four; only balanced accuracy generalized
  across the five corpora (mean 70.3%). The conflict–recall
  association is observational, not causal.
- **Appraisal is harder than screening for both humans and models.**
  woelfle2024: every individual LLM scored below every individual
  human on all three instruments, and human inter-rater κ itself fell
  from 0.84 (PRISMA) to 0.29 (PRECIS-2) — the reference standard
  degrades exactly where the models do.

## Limiting results and counter-evidence

- The pooled picture can look far rosier than the per-study picture:
  song2026's living-evidence review pools recall across 9 primary
  studies to a 96.24% mean (F1 mean 92.17%, n=6) — but these are
  unadjusted simple means over heterogeneous tools and denominators
  (precision ranged 0.2–100%), explicitly without meta-analysis. Cite
  as a secondhand aggregate, never as a field-level performance claim.
- Extraction evidence in the selected set is thin: one SE
  proof-of-concept at 87.83% accuracy (felizardo2024, abstract-only,
  single mapping study, no metric breakdown), a 23-study
  social-science inventory with no pooled benchmark and zero found
  real-review applications (legate2024), and secondhand error ranges
  of 4–31% (median 14%) relayed by gartlehner2025 from Clark et al.
- The one RCT-grade result is deflationary: arno2022 (abstract-only,
  pre-LLM RobotReviewer, 7 of 15 recruited teams completed) found
  ML-assisted risk-of-bias assessment noninferior (88.8% vs 90.2%),
  with inconclusive ~1.4-minute time savings — an equivalence result,
  not an efficiency demonstration.
- Contamination is almost never checked: 1 of madeyski2025's 29 papers
  did; public-benchmark reuse leaves training-data leakage open across
  most of the selected evidence.

## A live metric disagreement

oami2025's authors argue specificity is the deciding metric when
sensitivities are comparable (it governs downstream workload).
madeyski2025 flags specificity as misleading under imbalance (a
degenerate exclude-everything model scores perfect specificity) and
builds WMCC to price the same trade-off inside a chance-anchored
metric. These are not reconcilable by scope alone: they are competing
prescriptions for the same decision, and the survey should present
them as such. (The positions do agree that sensitivity/recall alone is
insufficient.)

Note also a structural echo: huotala2025's own primary metrics
(accuracy/precision/recall/F1) are among those madeyski2025 deprecates
— and madeyski2025's reanalysis of SESR-Eval is the demonstration.
The benchmark and the metrics critique are entangled: the same data
underlies both, so their agreement is not independent confirmation.

## Scope conditions

- All screening thresholds and most corpora are medicine-calibrated;
  SE evidence is one benchmark (huotala2025), one early GPT-3.5 study
  (syriani2023), and abstract-only items.
- madeyski2025's 29-paper pool is a convenience sample with
  single-researcher extraction; its terciles (MCC small <0.21, etc.)
  are calibration references from SE data, not standards.
- Evidence-label counts in the map (249 human-agree, 152 benchmark)
  record comparison type, not quality; no formal appraisal was done.
- gargari2023 and oami2025 are letter-format publications; several
  key numbers live in unverified supplements.

## Consequences for the manuscript

The manuscript's RQ2 section carries the load-bearing numbers with
their caveats and this synthesis confirms each against its note. Two
things held here but compressed there: the specificity-vs-WMCC
prescription conflict (the manuscript reports both works without
staging the disagreement), and the entanglement of SESR-Eval with the
madeyski2025 critique.

## What would change this

- Full text of safarpour2026 (25,149-title open-vs-proprietary
  comparison; abstract promises numbers it withholds).
- Any prospective deployment study reporting complete confusion
  matrices at a pre-registered operating point — the evidence class
  madeyski2025 calls for and the selected set lacks entirely.
- Independent validation (or refutation) of WMCC and its w=10 default
  outside the SESR-Eval data used to justify it.
- A screening study with contamination controls showing materially
  different results, which would undercut the retrospective corpus
  wholesale.
- An appraisal-stage study with a stronger reference standard than
  two-rater consensus (woelfle2024's own stated limit).
