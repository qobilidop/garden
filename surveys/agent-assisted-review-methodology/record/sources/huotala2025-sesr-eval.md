---
citekey: huotala2025-sesr-eval
work:
  title: "SESR-Eval: Dataset for Evaluating LLMs in the Title-Abstract Screening of Systematic Reviews"
  author: "Aleksi Huotala, Miikka Kuutila, Mika Mäntylä"
  venue: "2025 ACM/IEEE International Symposium on Empirical Software Engineering and Measurement (ESEM)"
  date: 2025
  doi: 10.1109/esem64174.2025.00053
read: full-text
source: "shadow/library/papers/2025/huotala2025-sesr-eval/transcript.md"
facets:
  stage: "screen"
  contribution: "evaluation"
  setting: "se"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "SESR-Eval: a 24-study, 9-LLM benchmark for SE title-abstract screening"
---

# SESR-Eval: Dataset for Evaluating LLMs in the Title-Abstract Screening of Systematic Reviews

## Evidence

- **Dataset composition:** 34,528 labeled primary studies sourced from 24 SE secondary studies (out of 169 candidate research artifacts reviewed from a prior systematic mapping [31]; 11/169 (6.5%) inaccessible, 24/169 (14.2%) suitable). Total across the 24 studies before exclusion: 39,946 studies, 4,573 included / 35,373 excluded (11:89 ratio); 5,418 (13.6%) primary studies dropped for missing abstracts after automatic (Scopus API) + manual (Google Scholar, capped at <200 missing/study) retrieval, leaving the final 34,528 (4,197 included / 30,331 excluded, 12:88 ratio, 0 missing abstracts). Per-study size ranges from 69 to 10,454 primary studies; I/E ratio ranges from 100:0 (2 studies) to 1:99 (1 study). Median inclusion/exclusion criteria per study: 3 / 4.5.
- **Ground-truth provenance:** manually extracted per study from research-artifact data fields plus full-text reading of the secondary study to locate screening decisions; correctness cross-checked by re-verifying that included/excluded counts in the artifact matched the paper. Research-artifact-selection reliability: double-coded 20 randomized artifacts, 90%/95% agreement, Krippendorff's alpha 0.786/0.831.
- **Models evaluated (9):** o3-mini (reasoning, "high" effort), GPT-4o, GPT-4.1, GPT-4.1 mini, GPT-4.1 nano (all OpenAI, direct API), Claude 3.7 Sonnet, DeepSeek R1 (671B, reasoning, open-weight), Llama 4 Maverick (400B, open-weight), Ministral 8B (open-weight) — latter four via OpenRouter. Config: temperature=0.0, top_p=0.1. Zero-shot prompt requiring three parallel judgment types per criterion and overall relevance: binary (true/false), probability (0.000–1.000), and 7-point Likert; structured JSON output. Total screening decisions run: text states 302,787 (given as "9 * 34,528") while the process diagram (Fig. 1) separately labels 310,752 — the transcript does not reconcile the two figures.
- **Headline results (Table VII, averaged across all 34,528 primary studies / across the 24 secondary studies):** top 7 LLMs performed similarly; accuracy 0.83–0.90 (primary) / 0.72–0.74 (secondary) for the 7 largest models. Best F1 (primary): Llama 4 Maverick 0.53. Best accuracy (primary): GPT-4.1 mini 0.90. Best accuracy (secondary): Llama 4 Maverick 0.74. The two smallest models badly underperformed: Ministral 8B (primary accuracy 0.13, recall 1.00, precision 0.12, F1 0.22) and GPT-4.1 nano (accuracy 0.56, F1 0.31) — both driven by near-blanket-inclusion behavior.
- **No model reached the paper's "deemed useful" bar** (recall ≥0.95 with precision ~0.50): at Likert threshold sweep (1–7), recall fell from 1.00 to 0.23 while precision rose from 0.12 to 0.50, never co-occurring at the target levels (Fig. 3).
- **Cross-study variance exceeds cross-model variance:** per-secondary-study accuracy ranges 0.34–0.85, F1 ranges 0.07–0.92 (Table IX) — wider spread than between LLMs. Logistic regression (correctness ~ LLM + study, reference = GPT-4.1 mini / study [53]): intercept log-odds 3.18 (OR≈24.08, p<2e-16). LLM effects: Claude 3.7 Sonnet OR≈0.94, DeepSeek R1 OR≈0.93 (close to reference); GPT-4o OR≈0.58, GPT-4.1 OR≈0.54, Llama 4 Maverick OR≈0.74, o3-mini OR≈0.69; GPT-4.1 nano OR≈0.13, Ministral 8B OR≈0.01 (large negative). Study effects range far wider, e.g. study [42] OR≈0.04, [57] OR≈0.06, vs. [52] OR≈0.83, [60] OR≈0.78 — supporting the "study effect dominates model effect" conclusion.
- **Cost analysis (Table XI, priced as of April 2025):** cost per secondary study ranged $0.4 (Ministral 8B) to $36.7 (o3-mini, most expensive); most expensive model's full-dataset cost ≈24×$36.7≈$881 across all 24 studies. Cost-efficient standouts: Llama 4 Maverick ($1.4–1.9/study) and GPT-4.1 mini ($2.2/study) matched larger/pricier models' performance. Time (P95 per paper): fastest GPT-4.1 nano 7.2s, slowest o3-mini 86.1s; human expert baseline (cited from prior work [3]) is 85.95s/paper — every LLM except o3-mini was faster than the human screener. GPT-4.1 mini was the most token-efficient top performer (comparable to o3-mini using ~10x fewer output tokens).
- **Prior-SE-work comparison:** paper is the largest SE title-abstract-screening benchmark by secondary-study count (24 vs. 1–2 in prior SE work [3],[4]); second-largest by #LLMs (9) and #primary studies (34,528) among all domains surveyed (Table I).

## Bearing on RQs

- **RQ2 (measurement methodology):** reports accuracy/precision/recall/F1 at both primary-study level (pooled, dominated by large studies) and secondary-study level (equal-weighted per study) — an explicit methodological choice the paper argues matters for what a researcher should read off the results. Defines a "deemed useful" operating threshold (recall≥0.95, precision≈0.50) as a deployment bar, which no model/study combination met. Uses logistic regression with reference-category odds ratios to decompose LLM-vs-study contribution to correctness — a reusable methodology for isolating measurement variance sources. Note: this paper is itself the target of a later reanalysis by madeyski2025-llm4screenlit, which argues its own primary metrics (accuracy/precision/recall/F1) are insufficient under class imbalance and reruns MCC/WMCC on this same SESR-Eval data, finding ranking flips in 55% of evaluable studies.
- **SE-setting anchor:** purpose-built for and evaluated entirely within software engineering secondary studies (24 SE journals/venues, SWEBOK-mapped domains), explicitly motivated by the shortage of SE-specific screening benchmarks (prior SE work: 1–2 studies each) versus larger biomedical/medical benchmarks (Table I) — a direct SE-setting anchor point for the survey.

## Evidence limits

Zero-shot prompting only (no few-shot/chain-of-thought), justified by dataset scale and by including two reasoning models as a partial substitute — explicitly flagged by the authors as a limitation and future-work opening. Ground truth extracted manually by the authors from heterogeneous, often undocumented research artifacts (case-by-case reverse-engineering); no independent author contact to verify. Missing-abstract removal (13.6% of studies) could bias results in unmeasured ways. Inclusion/exclusion criteria in secondary studies were not filtered for criteria unanswerable from title/abstract alone (kept as-is to avoid introducing bias), which may deflate all models' apparent performance on some studies.
