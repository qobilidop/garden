# Performance depends on how it is measured

## Current conclusion

The selected studies do not support one field-level performance estimate.
Corpus, prevalence, reference labels, aggregation, prompt, and operating point
vary too much. They do support a measurement conclusion: common accuracy-style
reporting under class imbalance can hide lost evidence and reverse model
rankings, while human reference decisions are themselves imperfect.

## Strongest results

### Metric and aggregation choice change the verdict

- `madeyski2025` reviews a 29-paper convenience sample: 7/29 report complete
  confusion matrices, 3/29 report MCC, and 17/29 use accuracy. In one
  9,695-record reanalysis, the accuracy-best model loses 63.3% of relevant
  evidence, the MCC-best 43.9%, and the weighted-MCC-best 5.8%.
- `huotala2025` evaluates nine models on 24 SE reviews (34,528 records). No
  nondegenerate operating point meets the authors' proposed recall/precision
  bar. Per-review spread exceeds differences among the larger tested models,
  and pooled versus per-review aggregation changes the ranking.
- `hirt2021` holds tool and corpus fixed and changes only risk-of-bias domain:
  agreement with archival Cochrane judgments ranges from $kappa = 0.60$ to
  $0.04$, with sensitivity 0.44–0.88 and specificity 0.48–0.95. This is
  abstract-only evidence from one nursing corpus and a pre-LLM classifier.

### Model, prompt, and corpus effects remain conditional

- `oami2025` holds the prompt and pipeline fixed across five highly imbalanced
  sepsis questions. GPT-3.5 to GPT-4 Turbo changes specificity from 0.51 to
  0.98 while sensitivity remains statistically similar (0.83 to 0.85).
- `gargari2023` reports eight prompt variants on one 330-citation review, with
  sensitivity moving from 62% to a qualitatively stronger configuration; most
  per-prompt numbers remain in an unverified supplement.
- `syriani2023` reports recall 0.327 on the corpus with 52.7% recorded human
  conflict and 0.738–0.947 on four others. High run-to-run agreement on two
  corpora does not make the decisions valid.
- `woelfle2024` finds every individual LLM below every individual human rater
  across three appraisal instruments, while human inter-rater agreement also
  falls as instrument complexity rises.

### Selected extraction evidence does not form a benchmark

- `felizardo2024` is an abstract-only SE proof of concept reporting 87.8%
  extraction accuracy, without an extractable metric breakdown.
- `legate2024` inventories 23 social-science extraction studies but reports no
  pooled benchmark across them.
- `gartlehner2025` relays extraction-error ranges of 4–31% from Clark et al.;
  those are secondhand calibration figures, not the position statement's own
  measurements.

These records establish that extraction is being evaluated under different
designs; they do not support a stage-level performance estimate.

### Human baselines are not perfect ground truth

Selected sources relay single-reviewer screening sensitivity around 87–92%
and human extraction errors up to 50%; these are secondhand calibration
figures, not measurements by the surveyed studies. The strongest selected
appraisal experiment, `arno2022`, is a randomized noninferiority study:
ML-assisted judgments are noninferior to unassisted judgments, not superior,
and time savings are inconclusive. More than half the recruited teams did not
complete, and the source note is abstract-only.

## A live metric disagreement

Oami et al. treat specificity as the deciding workload metric once sensitivity
is comparable: false positives determine how much downstream screening remains.
Madeyski et al. reject specificity as a primary measure under imbalance because
an exclude-everything classifier can score it perfectly. They prescribe the
full confusion matrix, lost evidence, MCC, and cost-weighted MCC. Both reject
recall alone; they do not agree on how to rank acceptable systems. The survey
stages this as an unresolved methodological disagreement.

## Ensemble and deferral results do not share a scale

- `akinseloyin2026`: a cross-vendor three-agent vote reports mean average
  precision 0.341 against constituents at 0.271, 0.266, and 0.182, plus
  WSS@95% 0.680. These are rank/work-saved metrics with no reported confusion
  matrix.
- `knafou2023`: a same-family BERT ensemble reports F1 89.16% against the best
  member's 88.53%. Unanimity plus a confidence threshold reaches about 98.5%
  F1 while deciding roughly half the corpus.
- `woelfle2024`: near-unanimous appraisal ensembles defer 74–88% of items;
  human–LLM agreement-gated deferral reaches 95–96% accuracy on the easier
  instruments while sparing roughly 65–70% of second-reviewer item count.

The gains are reported within their studies, but MAP, WSS@95%, F1, accuracy,
and deferred coverage cannot be pooled or ranked as one effect. The recurring
pattern is that higher conditional performance can be purchased by routing a
large fraction of cases elsewhere.

## Evidence-facet boundary

The catalog labels 303 works `human-agree`, 158 `benchmark`, and 315 `none`.
Those labels describe a comparison claimed or planned in the abstract. They do
not encode study design, completion, reference quality, or certainty.
`rose2025` is the demonstrated boundary case: a protocol with no results is
correctly coded `human-agree` because that is the planned comparison.

## Scope and limitations

- The deep reads are facet-guided, not random or exhaustive.
- Screening thresholds and examples are mostly medicine-calibrated.
- Several load-bearing results are preprints or abstract-only.
- Public benchmark reuse leaves training-data contamination largely unchecked;
  only one paper in Madeyski et al.'s 29-paper sample examined it explicitly.
- The survey performed no formal quality appraisal and reports no pooled
  effect.

## Consequence for presentation

Every number travels with corpus, metric, reference-label provenance, and
preprint/abstract-only status. Cross-study synthesis names recurring measurement
failures and design patterns; it does not rank models or estimate average
performance.
