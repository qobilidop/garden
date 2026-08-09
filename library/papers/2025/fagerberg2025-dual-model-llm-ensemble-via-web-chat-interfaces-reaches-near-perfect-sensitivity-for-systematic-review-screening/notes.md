---
citekey: fagerberg2025-dual-model-llm-ensemble-via-web-chat-interfaces-reaches-near-perfect-sensitivity-for-systematic-review-screening
work:
  title: "Dual-Model LLM Ensemble via Web Chat Interfaces Reaches Near-Perfect Sensitivity for Systematic-Review Screening: A Multi-Domain Validation with Equivalence to API Access"
  author: "Petter Fagerberg et al. (7 authors)"
  venue: "medRxiv (preprint, not peer-reviewed)"
  date: 2025-11-06  # v1, the only posted version as of retrieval
  doi: 10.1101/2025.11.03.25339455
sources:
  pdf:
    url: https://www.medrxiv.org/content/medrxiv/early/2025/11/06/2025.11.03.25339455.full.pdf
    archived: https://web.archive.org/web/20260809053101/https://www.medrxiv.org/content/medrxiv/early/2025/11/06/2025.11.03.25339455.full.pdf
retrieved: 2026-08-08
notes-by: Claude Fable 5 (claude-fable-5)
notes-date: 2026-08-08
synthesis: "OR-ensembling two model families buys near-perfect screening sensitivity because each model's errors are systematic and repeat across its own runs (κ 0.78–0.93), so diversity must come from outside the model — but no same-family ensemble arm was run, and the headline number rests on LLM-triggered relabeling of the reference standard."
---

# Dual-Model LLM Ensemble via Web Chat Interfaces Reaches Near-Perfect Sensitivity for Systematic-Review Screening: A Multi-Domain Validation with Equivalence to API Access

Diagnostic-test-accuracy-style validation study (medRxiv preprint, not
peer-reviewed) from Sweden's National Board of Health and Welfare — the
same group's follow-up to their batch-size paper (ref [10]), in the
LLM-abstract-screening lineage (Cao et al.; Sanghera et al.'s ensemble
work). Two claimed contributions: (1) a zero-shot, large-batch, two-model
OR-ensemble (GPT-5 Thinking + Gemini 2.5 Pro) generalizes across 16
Cochrane reviews spanning diverse medical domains at 99.1–99.7%
sensitivity; (2) the first direct GUI-vs-API comparison, showing the
no-code web-chat workflow is statistically equivalent to API access
(TOST within ±2 pp) — democratization for non-programming review teams.
Reporting is clean and unusually complete (pre-specified analyses,
Clopper–Pearson CIs, McNemar, TOST, per-run supplementary tables against
both the adjudicated and the original reference standard), which also
makes its main correctness worry inspectable: the "near-perfect" headline
depends on an adjudication step, triggered by LLM disagreement, that
relabeled 18 reference records — against the unadjusted Cochrane
libraries the same ensemble is 94.5%, not 99.7%.

## Design

736 titles/abstracts from 16 Cochrane reviews (May–June 2025, chosen
partly to postdate model training cutoffs), all records that the original
authors advanced to full-text review and then included (348) or excluded
(388). Reference standard is the **full-text** decision, so specificity is
by construction a conservative lower bound for abstract-stage screening —
and every negative is a hard negative that had already survived human
abstract screening. Each model screened the full set four times (2
duplicate runs × 2 modalities, GUI and API; 8 runs total), zero-shot, with
per-review PICOS criteria in the prompt and large batches (2–85
abstracts per prompt; reviews over 100 records split in two), fresh
session per run, three-way output labels (include / exclude / full-text)
with "full-text" mapped to positive. The pre-specified primary ensemble is
maximally inclusive: within a modality, positive if **any** of the four
runs said include or full-text.

A pre-specified adjudication then reshaped the reference standard: records
where both runs of both models contradicted the reference label (n=18,
2.3%), or where all runs and Cochrane agreed on exclude (n=23, 3.1%), went
to two in-team adjudicators judging against the review's own PICOS
criteria. All 18 criterion-1 records were ruled EndNote-library
misclassifications and flipped Include→Exclude (Figure 1: 18→0
asymmetry), yielding the final 330/406 gold standard used for all headline
results.

## Results

Adjudicated standard, Table S1: GUI ensemble 99.7% sensitivity (329/330;
95% CI 98.3–100.0) at 49.3% specificity; API ensemble 99.1% (327/330) at
the same 49.3%; McNemar p=0.625, TOST equivalence met. A one-run-per-model
ensemble trades ~0.6 pp sensitivity for ~4–7 pp specificity (GUI R1s:
99.1% / 56.2%). The constituent profiles are complementary and consistent
across modalities: Gemini 2.5 Pro higher sensitivity (94.5–98.2% per run),
GPT-5 Thinking higher specificity (65.0–67.0%) but sensitivity only
86.4–88.2%. Duplicate runs of the same model agree strongly (Figure 5:
κ = 0.776 Gemini API, 0.813 Gemini GUI, 0.889 GPT-5 GUI, 0.927 GPT-5 API).
The cited human single-reviewer baseline is 87–92% sensitivity (range
42–100%) — i.e., each single model run is roughly at or below a lone
human, and the ensemble's value is the union.

The mechanism exhibit is SR7 (vaccines in haematological malignancies):
GPT-5 single-run sensitivity fell to 43% (3/7) because it systematically
excluded general-population studies, confidently assuming the target
subgroup was absent — an error stable across its own repeat runs — while
Gemini flagged the same records as ambiguous for full-text. One model's
caution covering another's confident error is the paper's explicit analogy
to dual human review.

## What it does and does not establish about family diversity

This is the field's strongest current evidence *for* cross-family
ensembling, but the support is mechanistic rather than a controlled
comparison. For it: (a) the SR7 failure is systematic, not stochastic —
rerunning GPT-5 would not have caught it; (b) high within-model κ means
duplicate runs of one model mostly repeat the same errors, so most of the
ensemble's lift over the best single run must come from cross-model
complementarity, not from sampling noise; (c) the discussion adds an
operational argument — two vendors means one silent model update can't
compromise the whole workflow. Against it: there is **no same-family
ensemble arm** — no GPT-5+GPT-5-variant or two-prompt-framings-one-model
condition — so "second family" is never isolated from "any second
screener," and the within-model two-run OR is not even reported as a row
(its FN count, the intersection of e.g. Gemini GUI's 13 and 18 misses, is
unpublished; with κ = 0.813 the overlap is plausibly large, implying
GPT-5 rescued on the order of ten records despite its lower sensitivity —
but that is inference from marginals, not a reported result). One
model-pair, one prompt, medicine only. For a pass-structure rule like
"two passes on different tiers and prompt framings within one family,"
this paper neither validates nor refutes it: it shows identical-prompt
same-model repeats are insufficient against systematic errors, and it
shows a second family suffices — everything between those poles is
untested.

## Assessment

- **Durable:** the error-structure finding — per-model screening errors
  are systematic and survive rerunning (high κ), so redundancy must be
  sourced outside the model; complementary sensitivity/specificity
  profiles as the justification for OR-ensembles; sensitivity-first
  framing for screening (a miss biases the review, a false positive
  costs one full-text read); the GUI≈API equivalence pattern; the
  adjudication design (LLM-reference disagreement as a probe that finds
  reference-standard errors, not only model errors).
- **Era-bound:** all numbers are a snapshot of two specific mid/late-2025
  models behind mutable public interfaces the authors themselves flag for
  drift; batch-size ceilings tied to current context limits; the GUI
  workflow's manual copy-paste operational shape; the cost/throughput gap
  left to future work.
- **Weaknesses:** the reference-standard relabeling is
  LLM-disagreement-triggered and consensus-based (two adjudicators whose
  independence from the author team is not stated; no blinding
  described), and all 18 changes moved in the direction that
  raises measured LLM performance — the honest headline range is
  94.5–99.7% depending on which standard you accept (Table S2 vs S1);
  no same-family control arm (above); specificity 49.3% means half the
  hard negatives are forwarded, and how that nets out on workload is
  unmeasured; single dataset family (Cochrane, medicine), single prompt,
  same-group replication of their own prior protocol; abstract-internal
  slip — it gives GPT-5 specificity as "62.3%–67.0%" where the results
  text and Table S1 say 65.0–67.0% (62.3% is a Gemini GUI run's value).
- **Caveats:** preprint, uncertified; contamination not fully excluded
  for one openly accessible record; GUI/API parity imperfect (temperature
  and vendor-side updates uncontrolled); several reviews contribute ≤3
  positives, so per-review sensitivity CIs are wide.
- **In this library:** the direct evidence base for the survey-skill
  question of what a second screening pass must vary to be worth running —
  this paper says varying the *seed* is nearly worthless (κ 0.78–0.93)
  and varying the *model family* catches systematic blind spots, while
  leaving the middle ground (same family, different tier or prompt
  framing) unmeasured; it also models the adjudication move sys0 surveys
  can reuse: treat agent-reference disagreement as a queue for auditing
  the reference, not just the agent.

The transferable claim is not "99.7%": it is that a screening model's
misses are reproducible features of the model, so sensitivity is bought by
unioning decorrelated screeners — and the cheapest known decorrelation is
a different model family.
