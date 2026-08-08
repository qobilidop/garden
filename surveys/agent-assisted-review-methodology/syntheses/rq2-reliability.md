# RQ2 — Reliability is abundant but mismeasured; the variance lives in the task, not the model

Map basis: 260 of 672 includes carry human-agreement evidence; 157 more
are benchmark-only. The problem is not evidence volume but measurement
practice and generalization.

## Measurement practice lags its own subject

madeyski2025 (LLM4SCREENLIT — Kitchenham among the authors) reviewed 29
LLM-screening evaluations: 24% report complete confusion matrices, 10%
report MCC, 59% lean on accuracy — which their reanalyses show is invalid
under screening's class imbalance (an accuracy-best model lost 63.3% of
relevant evidence where the WMCC-best lost 5.8%). Their reform kit: Lost
Evidence (1−recall) + MCC/WMCC with a default FN:FP cost weight w=10,
confusion matrices always, resampling-without-replacement CIs, and
treating unclassifiable outputs as positives. oconnor2024 records the
parallel community threads (WSS→TNR critique, outcome-weighted
evaluation, statistically grounded stopping criteria, CSMeD benchmark).
huotala2025 adds a subtle reporting choice with large effects: pooled
(primary-study-level) vs per-review (secondary-study-level) metrics give
different answers on the same data.

## What the numbers actually show

- **Screening, single model:** high-but-insufficient. No model in
  SESR-Eval's 9-LLM × 24-review sweep met the deployment bar
  (recall≥0.95 with precision≈0.50); GPT-3.5-era sensitivity ran
  0.62–0.95 depending on prompt (gargari2023: prompt wording alone
  swung sensitivity from 62% to junior-reviewer level).
- **Model upgrades move specificity, not sensitivity:** same prompt,
  same pipeline, GPT-3.5→GPT-4 Turbo: sensitivity 0.83→0.85 (ns),
  specificity 0.51→0.98 (oami2025) — the workload axis, not the
  evidence-loss axis, is what scale bought.
- **The task dominates the model:** cross-review variance exceeds
  cross-model variance (huotala2025's regression: study odds-ratios
  spread far wider than model ORs; syriani2023: balanced accuracy is
  the only metric stable across corpora, ~0.70; performance collapses
  exactly where human conflict rates were high — MobileMDE, 52.7%
  conflict, recall 0.33).
- **Complexity gradient:** appraisal < screening. On PRISMA/AMSTAR/
  PRECIS-2 appraisal, every individual LLM scored below every individual
  human, and both humans and models degrade together as the instrument
  gets harder (human inter-rater κ 0.84→0.29; woelfle2024).
- **Extraction:** thin — one SE proof-of-concept at 87.8% accuracy
  (felizardo2024, abstract-only), a 23-tool social-science inventory
  with no pooled benchmark (legate2024), and secondhand error-rate
  ranges (extraction 4–31%, median 14%; gartlehner2025 citing Clark).

## Human baselines temper both hype and alarm

Single human reviewers run ~87–92% screening sensitivity (range 42–100%;
cited in fagerberg2025); human extraction error reaches 50% of data
elements (cited in gartlehner2025); human appraisal agreement collapses
on hard instruments (κ 0.29, woelfle2024). The one RCT-grade automation
study (arno2022, RobotReviewer) found *noninferiority*, not superiority,
with inconclusive time savings — the calibrating precedent for efficiency
claims. Agent evidence should be read against these imperfect baselines,
not against an idealized perfect reviewer.
