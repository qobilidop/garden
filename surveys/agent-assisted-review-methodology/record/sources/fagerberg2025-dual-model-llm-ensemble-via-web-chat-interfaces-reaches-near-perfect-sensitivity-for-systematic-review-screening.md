---
citekey: fagerberg2025-dual-model-llm-ensemble-via-web-chat-interfaces-reaches-near-perfect-sensitivity-for-systematic-review-screening
work:
  title: "Dual-Model LLM Ensemble via Web Chat Interfaces Reaches Near-Perfect Sensitivity for Systematic-Review Screening: A Multi-Domain Validation with Equivalence to API Access"
  author: "Petter Fagerberg, Oscar Sallander, Kim Vikhe Patil, Anders Berg, Anastasia Nyman, Natalia Borg, Thomas Lindén"
  venue: "openRxiv"
  date: 2025
  doi: 10.1101/2025.11.03.25339455
read: full-text
source: "shadow/store/library/papers/2025/fagerberg2025-dual-model-llm-ensemble-via-web-chat-interfaces-reaches-near-perfect-sensitivity-for-systematic-review-screening/"
facets:
  stage: "screen"
  contribution: "evaluation"
  evidence: "human-agree"
  setting: "med"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "GUI-based dual-LLM ensemble for abstract screening"
---

# Dual-Model LLM Ensemble via Web Chat Interfaces Reaches Near-Perfect Sensitivity for Systematic-Review Screening: A Multi-Domain Validation with Equivalence to API Access

## Evidence
- Two models: OpenAI GPT-5 Thinking (gpt-5-2025-08-07, Oct 2024 cutoff, 400K API token limit) and Google Gemini 2.5 Pro (gemini-2.5-pro, Jan 2025 cutoff, 1,048,576 API token limit). Each run via both public web chat GUI and public API — 2 models × 2 duplicate runs × 2 modalities = 8 runs total per citation.
- Ensemble rule: inclusive "OR" — a citation is positive if ANY of the four runs (2 GPT-5 + 2 Gemini) in a given modality labeled it "Include" or "Full-text review" (uncertain cases mapped to positive).
- Dataset: 736 titles/abstracts from 16 Cochrane reviews (Issue 6, May–June 2025), spanning autism, opioid dependence, cancer, hypertension, MI, schizophrenia, infections, tendinopathy, AAA, lung cancer/EGFR, glaucoma, heart failure, otitis media (×2), unplanned hospital presentations, sepsis. Zero-shot prompting; large batches (2–85 abstracts/batch per Table 1, split at >100 records to stay under GUI token limits); PICOS criteria extracted per review.
- Reference standard: original Cochrane full-text inclusion/exclusion decisions (348 include / 388 exclude), then a pre-specified targeted-adjudication protocol reclassified 18 records (all Include→Exclude, judged original library misclassifications) yielding final adjudicated gold standard of 330 include / 406 exclude (N=736).
- Ensemble (adjudicated standard): GUI ensemble = 99.7% sensitivity (95% CI 98.3–100.0%; 329/330 TP, 1 FN) and 49.3% specificity (95% CI 44.3–54.2%). API ensemble = 99.1% sensitivity (95% CI 97.4–99.8%; 327/330 TP, 3 FN), same 49.3% specificity. McNemar p=0.625 (no significant GUI-vs-API difference); TOST equivalence within ±2 pp met (p-lower=1.1×10⁻⁵, p-upper=0.011).
- Single-run ensemble (one run per model, sensitivity analysis): GUI R1s = 99.1% sensitivity (327/330), 56.2% specificity (95% CI 51.2–61.0%); API R1s = 98.5% sensitivity (325/330), 53.9% specificity (95% CI 49.0–58.9%).
- Individual model performance (adjusted standard, range across the 4 GUI+API runs each): Gemini 2.5 Pro sensitivity 94.5–98.2%, specificity 59.1–63.1%. GPT-5 Thinking sensitivity 86.4–88.2%, specificity 65.0–67.0%. Complementary profile: Gemini higher sensitivity, GPT-5 higher specificity — motivating the cross-family ensemble.
- Duplicate-run reliability (same model/modality, run 1 vs run 2): Cohen's κ = 0.78–0.93 ("substantial" to "almost perfect").
- Domain variability: GPT-5 Thinking single-run sensitivity dropped to 43% (3/7 TP) on SR7 (vaccines in haematological-malignancy patients) — traced to GPT-5 wrongly assuming absence of the target subgroup; Gemini instead flagged those records as ambiguous/full-text.
- Human baseline cited (from prior literature, not this study): single-reviewer sensitivity ~87–92% (range 42–100% across individual reviewers).
- No cost or processing-time/throughput data reported — explicitly named as a limitation and left to future prospective studies. No dollar or latency figures given anywhere in the text.
- Full Table S1 (adjudicated standard) per-run TP/FN/TN/FP/sensitivity/specificity for all 8 individual runs + 4 ensemble variants; Table S2 repeats vs. the original (pre-adjudication) Cochrane standard, where ensemble sensitivity is lower (94.0–94.5%) since it counts the 18 reclassified records as misses.

## Bearing on RQs
Directly targets RQ4 (multi-model ensemble design): demonstrates a simple OR-rule, cross-vendor (OpenAI/Google) two-model ensemble with complementary sensitivity/specificity profiles, and shows model-family diversity catches model-specific blind spots (the SR7 vaccine-subgroup failure case) — a concrete mechanism argument for diversity, not just an ensemble-vs-single-model comparison. Also bears on RQ2 (metrics): reports sensitivity, specificity, Cohen's κ inter-run reliability, McNemar and TOST equivalence testing as a fairly complete metrics stack, though omits cost/time/workload metrics by the authors' own admission.

## Evidence limits
- Preprint, not peer-reviewed (medRxiv, posted 2025-11-06; explicit "not certified by peer review" notice).
- Single institutional setting (Sweden's National Board of Health and Welfare); same author group's second paper in a series (cites their own prior medRxiv preprint, ref [10], for prompt/methodology details) — limited independent replication.
- Domain restricted to medicine (Cochrane reviews only); generalization to other SR domains untested.
- Reference standard is full-text inclusion, not abstract-level truth, so specificity is explicitly flagged by the authors as a conservative lower bound (many LLM "false positives" would have been correctly excluded at abstract stage too).
- Adjudication of discrepant records was performed by only two adjudicators from the same author team, using consensus — some risk of circularity/self-serving reference-standard correction (18 of 736 records relabeled Include→Exclude, all in the LLMs' favor toward higher measured sensitivity).
- Possible training-data contamination cannot be fully excluded for one ambiguous record noted as openly accessible pre-training.
- GUI vs. API parity imperfect (temperature/session settings not fully harmonized; unannounced vendor-side model updates cannot be ruled out during the study window).
