# gargari2023-enhancing-title-and-abstract-screening-for-systematic-reviews-with-gpt-35-turbo — GPT-3.5 Turbo prompt-engineering case study for title/abstract screening

- **Status:** deep-read
- **Work:** doi:10.1136/bmjebm-2023-112678
- **Source:** shadow/store/library/papers/2023/gargari2023-enhancing-title-and-abstract-screening-for-systematic-reviews-with-gpt-35-turbo/
- **Facets:** stage=screen, contribution=evaluation, evidence=human-agree, setting=med

## Evidence
- Format: BMJ EBM "Letter" — a 2-page single-case study, not a full research article; no separate methods/results sections, no supplementary data independently verified (referenced online supplemental tables 1–2 with prompt texts and per-prompt metrics were not accessed in this reading).
- Design: single systematic review used as testbed — Chambe et al.'s "Light Therapy in Insomnia Disorder: A Systematic Review and Meta-Analysis," re-run by querying the same databases with the original paper's search keywords. Chosen for a moderate citation count and subjective/hard-to-discern eligibility criteria, explicitly to stress-test the model.
- N: 330 citations from the initial search (imported into EndNote X20, exported RTF → TXT for processing).
- Screeners: 3 humans — (1) expert with 20+ prior SRs, (2) senior researcher with 10 prior SRs, (3) junior researcher with no prior screening experience; senior and junior screeners were blinded to the study's objective. All screened per criteria in supplemental table 1.
- Model: GPT-3.5 Turbo via OpenAI API, iteratively prompted across 8 prompt variants (code at github.com/mamishere/Article-Relevancy-Extraction-GPT3.5-Turbo). Reference standard = the original SR's final included-study list (not the human screeners' calls) — so the comparison is prompt-variant vs. published gold standard, with human screener results reported alongside as a separate benchmark.
- Metrics (accuracy, sensitivity, specificity, F1) computed per prompt but the full table (online supplemental table 2) was not in the main text; only prose highlights are numeric:
  - Prompt 1 (original paper's criteria, replicated): 80% accuracy, 62% sensitivity.
  - Prompt 2 (broadened population, "sleep troubles" vs. specific definition): reduced accuracy, sensitivity, and specificity vs. Prompt 1.
  - Prompt 3 ("Experienced Systematic Researcher" role): increased accuracy, decreased sensitivity vs. prior prompts.
  - Prompt 4 (adds "inclusivity sentence" instructing inclusion of uncertain studies): increased sensitivity, reduced specificity.
  - Prompt 5 (original criteria + inclusivity sentence): highest sensitivity of all prompts tested — described as similar to the junior researcher and surpassing the senior researcher (no exact numbers given for either).
  - Prompt 6 (descriptive sentence replacing segmented criteria): significant sensitivity reduction — authors conclude GPT responds better to segmented/classic criteria than free-text descriptions.
  - Prompt 7 (rephrased inclusivity language, more detail): substantially increased sensitivity vs. Prompt 6.
  - Prompt 8 (4-question screening tool, include if all answered "Yes"/"Unsure"): performed poorly, "potentially due to the technical structure of GPT" — no root-cause diagnosis given.
- Human comparison: stated qualitatively only for Prompt 5 (matches junior, beats senior); no full human-vs-best-prompt table in the main text. Authors explicitly note even human screeners did not reach "exemplary performance," attributed to subjective/undefined eligibility criteria (e.g., ambiguity in what counts as "sleep troubles").

## Bearing on RQs
Bears on RQ2 (reliability/agreement metrics) as a prompt-sensitivity case study: demonstrates that accuracy/sensitivity/specificity for the same base model (GPT-3.5 Turbo) on the same task swing substantially (62%→highest-observed sensitivity) purely from prompt wording — role framing, segmented vs. descriptive criteria, and an explicit "inclusivity sentence" for uncertain cases. Useful as a qualitative counterpoint to model-comparison studies (e.g. oami2025): it isolates prompt design rather than model capability as the reliability lever, and its "inclusivity sentence" finding (raises sensitivity, trades specificity) is a reusable practitioner-facing pattern. Only lightly touches RQ1 (workflow is single-pass zero-shot classification, no broader agent architecture) and does not touch RQ3/RQ4 (no reporting-standard discussion, no ensembling/multi-agent design).

## Evidence limits
- N=1 systematic review, single domain (insomnia/light therapy), single search (330 citations) — explicitly flagged by the authors as a non-generalizable single-case study.
- Most per-prompt metrics are reported only as directional prose ("increased," "reduced," "highest") rather than numbers in the main text; only Prompt 1's accuracy (80%) and sensitivity (62%) are given precisely. Full quantitative table is in an unverified online supplement.
- Reference standard is the original SR's published inclusion list, not adjudicated re-screening — conflates "matches a prior paper's decisions" with ground truth, and the human screeners are benchmarked against the same standard rather than against each other for inter-rater agreement.
- No cost or latency figures reported.
- Superseded model (GPT-3.5 Turbo only; no GPT-4 or later comparison) — directly relevant historically but dated for present-day (2026) agentic-review capability claims.
- Short letter format: no formal methods/results separation, no CI/significance testing on the metric differences described, no explicit discussion of prompt-order or learning effects across the 8 sequential prompt iterations.
