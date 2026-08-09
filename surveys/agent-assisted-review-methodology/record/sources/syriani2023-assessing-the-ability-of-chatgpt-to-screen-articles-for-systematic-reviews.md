---
citekey: syriani2023-assessing-the-ability-of-chatgpt-to-screen-articles-for-systematic-reviews
work:
  title: "Screening articles for systematic reviews with ChatGPT"
  author: "Eugene Syriani, Istvan David, Gauransh Kumar"
  venue: "Journal of Computer Languages"
  date: 2024
  doi: 10.1016/j.cola.2024.101287
  arxiv: 2307.06464
read: full-text
source: "shadow/store/library/papers/2023/syriani2023-assessing-the-ability-of-chatgpt-to-screen-articles-for-systematic-reviews/"
facets:
  stage: "screen"
  contribution: "evaluation"
  setting: "se"
retrieved: 2026-08-08
notes-by: "Claude Sonnet-class (survey deep-read pipeline); Codex GPT-5.6 Sol (adversarial review)"
notes-date: 2026-08-08
synthesis: "early SE-setting ChatGPT screening evaluation"
---

# Screening articles for systematic reviews with ChatGPT

## Evidence
- Datasets: 5 ReLiS-hosted SE systematic-review/mapping-study corpora (DSMLCompo N=2683, MobileMDE N=292, MPM4CPS N=205, RL4SE N=1089, UpdateCollabMDE N=875; total N=5222, 467 included/4755 excluded); ground truth = expert reviewer decisions with recorded conflicts (avg. 19% conflict rate across datasets).
- Model: GPT-3.5 Turbo via ChatGPT API, temperature=0, max_tokens=3, one-word Include/Exclude output; zero-shot prompt with topic context, "be lenient" instruction, title+abstract inputs (full template given, Listing 1).
- Baselines: Logistic Regression, Complement Naive Bayes, SVC, Random Forest (scikit-learn, Word2Vec features, 80:20 split, 5-fold repeated CV, grid-search-tuned per dataset, optimized on F2) plus a random classifier.
- Consistency (RQ1, 10 runs each, RL4SE and DSMLCompo only): GPT-3.5 MCC std. dev. 0.002/0.001 vs. 0.028–0.048 for traditional classifiers. Fleiss' kappa across 10 runs: GPT-3.5 = 0.821 (RL4SE) and 0.973 (DSMLCompo) — "almost perfect agreement" — vs. 0.22–0.55 for traditional classifiers. Disagreement rate across runs: 18% of RL4SE articles, 3% of DSMLCompo articles had at least one dissenting run, mostly false-positive (over-inclusive) disagreements, not false negatives.
- Classification performance (RQ2, per-dataset, GPT-3.5 vs. best traditional classifier): RL4SE — recall 0.821, precision 0.199, specificity 0.688, NPV 0.976, balanced accuracy 0.755, F2 0.505, MCC 0.649 (bAcc ~72% for traditional classifiers, 75% for GPT-3.5). DSMLCompo — recall 0.869, precision 0.133, specificity 0.666, NPV 0.988, bAcc 0.767, F2 0.413, MCC 0.628 (GPT-3.5 highest on all metrics except specificity). UpdateCollabMDE — recall 0.947 (highest), precision 0.108, specificity 0.455 (low), NPV 0.992, bAcc 0.701, MCC 0.600 (1 run only, per RQ1 justification). MobileMDE (atypical, 52.7% conflict rate) — recall 0.327 (worse than random baseline's 0.505), precision 0.514 (highest), specificity 0.928 (highest), bAcc 0.628 (lowest of all classifiers). MPM4CPS (balanced 52.2% inclusion) — recall 0.738, precision 0.664, bAcc 0.665 (best), F2 0.722 (best), MCC 0.667.
- ANOVA significance (α=0.05): GPT-3.5 significantly beats Random on every metric in both large datasets; vs. traditional classifiers, significantly better than Logistic Regression/Random Forest on recall+NPV (RL4SE), and significantly better than all four on NPV/F2/bAcc/MCC (DSMLCompo).
- Generalizability (RQ3): only balanced accuracy generalizes consistently across all 5 datasets (mean 70.3%, std. dev. 0.059); other metrics vary widely (e.g., recall 0.327–0.947, precision 0.108–0.664) tracking each dataset's inclusion/conflict-ratio profile — three "regular" low-inclusion/low-conflict datasets cluster similarly; MobileMDE (high conflict) and MPM4CPS (balanced classes) each diverge differently.
- Effort/cost: WSS-based savings — GPT-3.5 best or near-best across 4/5 datasets (e.g., RL4SE: WSS=0.644, 701/1089 papers saved, 11.7h saved, beating the best traditional classifier's 7.5h). Token cost: ~323 tokens/paper average, total cost across all 5 datasets' experiments <$1.5 combined (largest single dataset $0.775) at GPT-3.5 pricing of $0.002/1k tokens.

## Bearing on RQs
RQ2 (early SE screening evidence, pre-agentic single-LLM baseline): concrete SE-domain accuracy/consistency/cost numbers against traditional ML baselines, useful as a low anchor predating agent-based or ensemble approaches. RQ1 (SE-setting anchor): one of the few SR-screening evaluations conducted entirely on software-engineering (not medical) corpora, via the ReLiS platform.

## Evidence limits
Numbers are from the arXiv-version transcript; DOI
10.1016/j.cola.2024.101287 identifies the 2024 journal publication,
but this review did not perform a line-by-line version comparison. N=1
run (no consistency stats) for 3 of 5 datasets. Single vendor/model
version (GPT-3.5 Turbo, April–June 2023), no ensemble or agentic design
— a pre-agent baseline, not itself an agent-review method. SE-only
external validity claimed by the authors but restricted to ReLiS-hosted
projects.
