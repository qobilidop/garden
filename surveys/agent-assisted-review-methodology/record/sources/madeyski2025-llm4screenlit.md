---
citekey: madeyski2025-llm4screenlit
work:
  title: "LLM4SCREENLIT: Recommendations on Assessing the Performance of Large Language Models for Screening Literature in Systematic Reviews"
  author: "Lech Madeyski, Barbara Kitchenham, Martin Shepperd"
  date: 2026
  arxiv: 2511.12635
read: full-text
source: "shadow/library/papers/2025/madeyski2025-llm4screenlit/transcript.md"
facets:
  stage: "screen"
  contribution: "guideline"
  setting: "general"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "LLM4SCREENLIT: recommendations for evaluating LLM screening in SRs"
---

# LLM4SCREENLIT: Recommendations on Assessing the Performance of Large Language Models for Screening Literature in Systematic Reviews

## Evidence

- **Mandated/prioritized metrics:** Lost Evidence (1-Recall) and MCC are the two required chance-anchored/imbalance-robust metrics; the paper proposes a new **Weighted MCC (WMCC)** that weights positive cases (TP, FN) by a factor `w` relative to negatives, to encode FN:FP cost asymmetry directly into MCC's chance-anchored framework (Sec 3.3). Reporting kit for deployment: full confusion matrix + Lost Evidence/Recall + MCC with CIs, ranked by WMCC among candidates meeting the Lost Evidence threshold.
- **Deprecated/discouraged metrics:** Accuracy and PABAK as primary metrics — both are misleading under class imbalance; PABAK is shown to be just a centred version of Accuracy (Sec 2.3, Appendix). Specificity is also flagged as misleading under imbalance (a model with TP=0 can score perfect Specificity). Precision/F1/Recall alone are "biased for imbalanced data" though Recall is retained because it directly tracks Lost Evidence.
- **Sensitivity vs workload tradeoff:** central theme — the paper argues FN (lost evidence) and FP (wasted screening workload) must be treated asymmetrically. None of 5 papers claiming "workload savings" priced FN cost (Sec 3.1 pt 4). WMCC is explicitly built to trade off Lost Evidence against workload: "WMCC can tolerate a small increase in Lost Evidence when workload reduction is large" (Sec 3.4).
- **Prevalence effects:** class imbalance is treated as one of four foundational features of the screening problem (Sec 1) — negative (irrelevant) class dominates; Accuracy/Specificity/PABAK all fail under this imbalance. Kappa variants are discussed as inappropriate to combine with standard gold-standard metrics (Kappa assumes no gold standard exists; standard metrics assume one does), except MCC (Sec 3.1 pt 3).
- **Kappa/agreement statistics:** PABAK (Prevalence Adjusted Bias Adjusted Kappa) explicitly deprecated as "not... a useful metric in any circumstances" — mathematically shown equivalent to centred Accuracy. Weighted Kappa noted as used by 2 papers but not endorsed as a primary recommendation.
- **Thresholds proposed:**
  - Default cost-ratio weight **w = 10** (positives 10x as costly to miss as negatives to over-include) as a "conservative default" for WMCC, empirically supported by sensitivity analysis across a 34,528-article SE reanalysis (SESR-Eval, 9 LLMs × 24 studies): median crossover w≈2.7, max ≈6.4, all <7 — meaning even modest cost asymmetry (3x) flips model rankings, so w=10 is conservative.
  - Deployment decision rule: deploy only if Lost Evidence lower-CI bound > threshold (paper's illustration uses e.g. "Lower CI >0.8" acceptable Lost Evidence and "95% lower CI of MCC > 0" for genuine-prediction check) (Sec 4.1); escalate to human review otherwise (R10).
  - Empirical MCC/WMCC(w=10) performance terciles derived from 183 evaluable LLM×study SE configurations (SESR-Eval): MCC small <0.21, medium 0.21–0.38, large >0.38; WMCC(w=10) small <0.19, medium 0.19–0.42, large >0.42 (Table 7) — offered as calibration reference, not fixed thresholds.
- **Meta-analysis of existing evaluations:** reviewed 29 papers (28 + motivating DC+ study) on LLM screening evaluation practice (Table 2/Figure 2/3). Findings: only 10% (3/29) reported MCC; only 24% (7/29) reported complete confusion matrices (4 more reconstructible); 17/29 used Accuracy; only 4/29 (14%) used Balanced Accuracy; 22/29 used Recall/Sensitivity but rarely paired with chance-anchored metrics; none of 5 workload-savings papers priced FN cost; only 10 of 29 explicitly addressed differential FN/FP costs, with wide variation (e.g., Khraisha et al. used FN weight 30x FP; Wang et al. mandated ≥95% recall threshold).
- **Confusion-matrix reporting as foundational practice (P1/R4):** argued as prerequisite for meta-analysis and for recomputing any metric (including MCC/WMCC) after the fact; DC+'s complete confusion matrices are what let this paper reanalyze and find Lost Evidence problems missed by the original accuracy-framed report.
- **Unclassifiable/null outputs (P5/R6):** recommends treating unclassifiable/"referred-back" outputs as positives requiring human review rather than dropping them from the confusion matrix (critiques DC+ for doing the latter).
- **Confidence intervals (P3/R5):** critiques binomial-based CIs and bootstrapping (both assume iid, inappropriate for screening abstracts) — recommends resampling **without replacement** from a validation sample when deciding whether to deploy an LLM on remaining unscreened abstracts.
- **Data leakage / contamination (P8/R8):** flags that public benchmark reuse risks LLM training-data contamination; only 1/29 papers explicitly checked this. Runs an orthogonal contamination-risk sensitivity check on DC+ (includes a 2021 SR predating most tested LLMs' training cutoffs) and argues the MCC/WMCC ranking-flip pattern is a property of the metrics, not a contamination artifact (flips require asymmetric error profiles that leakage would tend to erase, not produce).
- **Formal recommendations:** organizes 10 numbered recommendations (R1–R10) for researchers/practitioners, tagged by applicability to benchmarking vs. deployment studies, plus 8 parallel policymaker recommendations (R1PM–R8PM) for journals/conferences, and a reviewer/editor compliance checklist with a minimum reporting template (Table 8).
- **Worked reanalyses:** three SE-specific reanalyses (Felizardo et al. 2024, Syriani et al. 2023/2024, Huotala et al. 2025 SESR-Eval) show MCC and WMCC disagreeing on best LLM in 55% of evaluable SESR-Eval studies, and a single 9,695-article study where Accuracy-best, MCC-best, and WMCC-best are three different LLMs (Table 5) — Accuracy-best loses 63.3% of relevant evidence, MCC-best 43.9%, WMCC-best only 5.8%.

## Bearing on RQs

- **RQ2 (how reliability should be measured):** directly on-topic — proposes a concrete new metric (WMCC) purpose-built for LLM screening evaluation, argues Accuracy/PABAK/Specificity are invalid under class imbalance, and that plain MCC (though chance-anchored and imbalance-robust) is insufficient because it ignores FN:FP cost asymmetry. Gives a default cost weight (w=10) and an empirical grounding for it via sensitivity analysis. Directly engages kappa (rejects PABAK, is cautious about Kappa/Weighted Kappa co-use with gold-standard metrics).
- **RQ3 (assessment norms):** provides an explicit, structured normative framework — 10 researcher/practitioner recommendations + 8 policymaker recommendations + a reviewer/editor checklist + minimum reporting template — differentiated by study type (retrospective benchmarking vs. prospective deployment). Also supplies a meta-analytic baseline (29 papers) documenting how far current practice falls short of these norms (e.g., 90% don't report MCC, only 24% report full confusion matrices), which is directly citable evidence for how the field currently under-assesses LLM screening reliability.

## Evidence limits

Recommendations are derived primarily from title/abstract screening evidence; extension to full-text screening is judged "principled" (2 supporting non-SE papers) and extension to data-extraction tasks is "largely theoretical" (1 supporting non-SE paper plus authors' argument) — flagged by the authors themselves as needing empirical validation. Underlying paper pool (29 papers) is a convenience sample assembled via two prior SRs plus informal search, not itself a fully systematic search. Data extraction for the 29-paper review was performed by a single researcher (Kitchenham), with subjectivity concentrated in judging whether papers recognized FN/FP asymmetry.
