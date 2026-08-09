---
citekey: vandinter2021-automation-of-systematic-literature-reviews
work:
  title: "Automation of systematic literature reviews: A systematic literature review"
  author: "Raymon van Dinter, Bedir Tekinerdogan, Cagatay Catal"
  venue: "Information and Software Technology"
  date: 2021
  doi: 10.1016/j.infsof.2021.106589
read: full-text
source: "transcript at shadow/library/papers/2021/vandinter2021-automation-of-systematic-literature-reviews/transcript.md (green OA accepted-manuscript copy via Wageningen University repository, Taverne Amendment; PDF in Drive store)"
facets:
  stage: "meta"
  contribution: "evaluation"
  setting: "se"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "pre-LLM landscape SLR of SLR-automation studies (41 primary studies, 2006-2020)"
---

# Automation of systematic literature reviews: A systematic literature review

## Evidence

- Scope: automated search of ScienceDirect, ACM DL, IEEE Xplore, Springer,
  Wiley, PubMed, Jan 2000–June 2020, SE/Medicine venues only. Funnel: 1291
  hits (ScienceDirect 493, IEEE 348, Springer 220, ACM 97, Wiley 114,
  PubMed 19) → 59 after title/abstract → 41 after full-text → **41 after
  quality assessment** (nothing scored below the 4/8 cutoff).
- Taxonomy: Kitchenham & Charters' 12 SLR steps (SLR1–12), 3 categories —
  Need for a review (SLR1–4), Conducting the review (SLR5–9), Reporting
  the review (SLR10–12).
- **Headline: all 41 studies automate a step from Conducting-the-review
  (SLR5–9) only.** Zero automate any planning step (SLR1–4) or reporting
  step (SLR10–12) — a total gap at both ends of the pipeline as of 2020.
- Within Conduct of review, attention is uneven: **Selection of Primary
  Studies (SLR6)**, screening, is the leading automated step; **Identifying
  research (SLR5)** (search-query formulation) is second; 3 studies
  automate SLR5+SLR6 together; **Data Extraction (SLR8)** automated in 5
  studies; **Study Quality Assessment (SLR7)** is least automated — 1
  study (Felizardo et al. 2012).
- Domains: only two found — Software Engineering (40%) and Medicine (60%,
  with sub-domains like Pharmacy/Public health). Study mix: 60%+ journal
  articles, 38% conference, 2% book chapters. First study: Cohen et al.
  2006 (SLR6, also most-cited at 219 citations); 2016 peak year (n=8).
- Technique landscape (pre-LLM, shallow-ML era): supervised classification
  dominates (SLR6, SLR8); ranking primary for SLR5; clustering the only
  task for SLR7. SVM and Naïve Bayes are the most-used algorithms;
  representation is BoW/TF-IDF-era. **Only 1 of 41 studies uses deep
  learning** (Kontonatsios et al. 2020: autoencoder+DNN feeding an SVM) —
  no CNN/LSTM/RNN anywhere in the corpus ("a noticeable lack of evidence
  on Deep Learning techniques").
- Evaluation norms: Work Saved over Sampling (WSS) is the dominant
  non-ML metric (9 studies), alongside precision/recall/F-measure; 11
  studies use 10-fold or 5×2 cross-validation, only 3 use held-out splits.
- Top challenge: class imbalance in SLR6 screening (11 studies), addressed
  via 6 solution families (cost-sensitive classifiers, resampling, SMOTE,
  feature enrichment, cost assignment, precision@95%recall).
- Economic backdrop cited from related work (not this paper's own data,
  via Michelson & Reuter 2019): single-reviewer SLR ~1.72 years,
  ~$141,194.80; ~$18.66M/yr across 10 major academic institutions;
  ~$16.76M/yr per pharma company; Marshall & Wallace: ~67 weeks/SLR.
  SLR6-automation elsewhere suggests 30–70% workload savings at ~95%
  recall. Conclusion states "a lack of tool support" remains.

## Bearing on RQs

Primary RQ1 anchor: this is the pre-LLM baseline snapshot the LLM-era
literature builds on. It fixes, with counts, exactly what "automated" meant
before generative LLMs — narrowly, shallow-ML classification/ranking for
screening (SLR6) and search-query formulation (SLR5), almost nothing for
appraisal (SLR7: n=1) or extraction (SLR8: n=5), and *nothing* for planning
or reporting stages. Any LLM-era source in this survey that claims progress
on appraisal, extraction, planning, or reporting automation should be read
against this near-zero pre-LLM baseline. Also feeds RQ2: the WSS/
precision-recall/F-measure/cross-validation evaluation norms documented
here are the metric vocabulary later LLM-screening papers inherit or
depart from. Bears weakly on RQ4: the corpus is single-model,
single-technique tooling throughout — no ensembling or cross-model
independence designs appear, consistent with RQ4's gap framing.

## Evidence limits

- Restricted to SE and Medicine venues/domains by the search protocol
  itself — absence of other domains is a search-scope artifact, not
  necessarily evidence that other fields had no SLR-automation work by
  2020.
- Narrative/tabular synthesis only (no meta-analysis or pooled effect
  sizes); accuracy/agreement numbers are reported per-study in the source
  papers, not harmonized into a single comparable figure by this SLR.
- Window ends June 2020, so it cannot speak to the 2020–2021 GPT-era
  inflection directly — it is a boundary marker, not a trend line into
  the LLM period.
- Quality assessment excluded zero studies (all scored ≥4/8), which the
  authors note themselves; this may reflect a low discriminating floor
  in the checklist rather than uniformly high study quality.
