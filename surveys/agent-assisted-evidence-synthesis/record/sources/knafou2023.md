---
citekey: knafou2023
work:
  title: "Ensemble of deep learning language models to support the creation of living systematic reviews for the COVID-19 literature"
  author: "Julien Knafou, Quentin Haas, Nikolay Borissov, Michel Counotte, Nicola Low, Hira Imeri, Aziz Mert Ipekci, Diana Buitrago-Garcia, Leonie Heron, Poorya Amini, Douglas Teodoro"
  venue: "Systematic Reviews"
  date: 2023
  doi: 10.1186/s13643-023-02247-9
read: full-text
source: "https://pmc.ncbi.nlm.nih.gov/articles/PMC10240481/ (open access)"
facets:
  stage: "screen"
  contribution: "method"
  evidence: "human-agree"
  setting: "med"
retrieved: 2026-08-09
notes-by: "Claude Sonnet 5"
notes-date: 2026-08-09
synthesis: "A five-model BERT-family ensemble (voting or probability-sum) modestly and significantly beats its best standalone member, but reports zero correlation, agreement, or diversity statistic between constituent models — the plainest 'configuration documented, mechanism not isolated' case in the set"
---

# Ensemble of deep learning language models to support the creation of living systematic reviews for the COVID-19 literature

## Evidence
- Ensemble of five pretrained BERT-family transformer classifiers (each: transformer encoder plus a fully connected perceptron head): RoBERTa-base (110M params, general corpus), RoBERTa-large (340M params, general corpus), COVID-Twitter-BERT (110M, COVID-19-specific corpus), BioBERT (110M, biomedical corpus), PubMedBERT (110M, biomedical corpus). All five share the same base architecture family; the only stated sources of diversity are pretraining corpus (general vs. COVID-specific vs. biomedical) and, for RoBERTa-large alone, parameter count. No architecturally distinct model (e.g., classical ML, LSTM, generative LLM) is in the ensemble.
- Each model independently fine-tuned in a 5-fold cross-validation setting (70% train / 10% dev / 20% test per fold) on the same 6,365-publication dataset.
- Two combination rules, precisely stated:
  - **Probability-sum** (default): "The idea is to sum the probabilities of the classifiers for all the categories and then take the most probable category as the ensemble classification" — "always gives a unique prediction in every situation."
  - **Voting**: final category = plurality of the five models' votes, with variants — dynamic majority, static majority (threshold t=3/5), static unanimity (t=5/5), and per-vote probability thresholds (t_v = 0.5 or 0.99) layered on the vote-count threshold.
- **No independence or diversity measurement anywhere in the paper.** No Spearman/Pearson correlation, no Q-statistic or other disagreement index, and no error-overlap analysis between any pair of the five models is reported at any label level. Pretraining-corpus and parameter-count differences are named qualitatively as the source of variation between models but are never quantified, and no ablation (e.g., an all-biomedical vs. a mixed-corpus ensemble) tests whether cross-corpus diversity is what drives the ensemble's gain. The paper's own summary of its result is flat performance language only: "The ensemble model significantly outperformed the standalone classifiers" / "The ensemble consistently and significantly outperforms any standalone model" — no mechanism claim accompanies it.
- Dataset: COVID-19 Open Access Project (COAP) living-evidence database, 6,365 publications (PubMed, Embase, medRxiv, bioRxiv; annotated Jan 7–Dec 10, 2020), manually labeled by "a crowdsourced team of people with training in epidemiology and systematic reviews" into a 3-level hierarchy — 2 classes (ORIGINAL 70.1% / NON-ORIGINAL 29.9%), 3 subclasses (EPI 57.6%, BASIC 12.6%, OTHER), 22 sub-subclasses. Models feed an "epidemiological triage" / literature-screening step intended to keep a living systematic review current as new publications appear.
- Performance (F1, class level, binary ORIGINAL/NON-ORIGINAL): best standalone PubMedBERT 88.53%; ensemble (probability-sum) 89.16% — statistically significant by McNemar test. Subclass level (3-way): best standalone PubMedBERT micro-F1 84.99% / macro-F1 82.51%; ensemble micro-F1 86.10% / macro-F1 83.97% (significant). Sub-subclass level (22-way): best standalone PubMedBERT micro-F1 67.40% / macro-F1 52.19%; ensemble micro-F1 69.50% / macro-F1 54.84% (significant). AUC-ROC with 95% CI, best-standalone (BioBERT) vs. ensemble, non-overlapping at all three levels: class 91.77 (90.95–92.50) → 94.33 (93.70–94.88); subclass 91.35 (90.66–92.01) → 94.25 (93.72–94.76); sub-subclass 92.06 (91.56–92.54) → 94.77 (94.38–95.12). Top-3 ranking retrieval: ensemble P@1 70.57% vs. BioBERT 68.55%; R@3 89.07% vs. 85.89%; MAP@3 78.92% vs. 76.16%.
- Voting-strategy accuracy/coverage tradeoff (class level): plain majority vote ≈93% F1 on 100% of the data; static unanimity (5/5 agree) ≈97% F1 on ~80% of the data; unanimity plus a per-vote probability threshold of 0.99 → 98.5% F1 / ~99% recall on ~50% of the data — a coverage-for-accuracy tradeoff structurally similar to woelfle2024's consistency-gated deferral, here applied to fine-tuned BERT classifiers rather than prompted LLM chat agents.
- Proposed but unevaluated workload-reduction workflow: if the ensemble's top-3 predicted categories contain the human annotator's chosen category, auto-validate; otherwise route to a senior annotator for the remaining ~10% of cases — authors project this "could reduce the number of human resources required by at least 50%," stated as a projection, not a measured result.
- No cost, wall-clock time, or throughput (documents/hour) figures are reported; the paper states only that training and evaluation ran on "a Linux machine with a TPU (V3–8)."
- Authors' own limitations: single dataset/knowledge base — "it is unclear how the proposed methodology will generalize to corpora and categories used in other reviews and living evidence knowledge bases"; full text unused (paywall access plus quadratic time-complexity cost of longer documents), so classification is title/abstract-only; a multi-label alternative at the sub-subclass level is suggested but not tested. No limitation names the missing diversity/causal-isolation analysis — it is a silence, not an acknowledged gap.

## Bearing on RQs
Bears on RQ4 (ensemble design) as a same-family, non-LLM counterpoint to fagerberg2025's cross-vendor LLM OR-ensemble and akinseloyin2026's cross-vendor multi-agent ensemble: a modest, statistically significant gain from combining five same-architecture-family classifiers whose only distinguishing sources of diversity are pretraining corpus and parameter count, combined via probability-sum or voting, with zero diversity or correlation measurement between any pair of constituent models anywhere in the paper. Of the three ensemble deep reads now in this set, this is the plainest "configuration documented, mechanism not isolated" instance — it does not even offer a post hoc correlation figure the way akinseloyin2026 does. Also bears on RQ2 (metrics): reports F1 (micro/macro), AUC-ROC with CIs, and top-k ranking metrics (P/R/MAP@k) across a 3-level label hierarchy with McNemar-tested significance, and its voting-threshold coverage/accuracy tradeoff (97–98.5% F1 at 50–80% coverage) is a second concrete instance, after woelfle2024, of an accuracy-vs-deferred-coverage design — here for a screening/triage classifier rather than an appraisal tool.

## Evidence limits
- Single dataset/domain (COVID-19 COAP living-evidence database, 6,365 publications, Jan–Dec 2020); authors explicitly flag generalization to other living-evidence knowledge bases as untested.
- All five ensemble members are BERT-family transformer classifiers; no architecturally distinct model type is included, which narrows what "diversity" could mean here even before the missing-measurement gap.
- No correlation, agreement, or error-overlap statistic between any pair of the five models is reported at any label level; the causal contribution of pretraining-corpus or parameter-count diversity to the ensemble's F1/AUC gains is never measured or ablated — it is asserted only by omission.
- Reference labels come from a single crowdsourced annotation team (epidemiology/systematic-review trained); the paper does not describe independent dual-coding or adjudication of these labels.
- Preprint of record: doi:10.1101/2023.01.18.524571 (bioRxiv, posted 2023-01-18; v1 subtitled "a retrospective study"; a v2 also exists) is the preprint of this journal paper. This note reads the peer-reviewed *Systematic Reviews* version (PMC10240481, published 2023-06-05) as the version of record; repeated bioRxiv fetch attempts during this note's preparation were rate-limited (HTTP 429), so material differences between the preprint and journal text, if any, were not independently confirmed here.
- No full-text mining (titles/abstracts only); authors cite paywall access and quadratic time-complexity as reasons full text was excluded.
- No cost or throughput figures reported; the proposed 50%-workload-reduction workflow is an unevaluated projection, not a measured result.
