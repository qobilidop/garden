---
citekey: legate2024
work:
  title: "(Semi)automated approaches to data extraction for systematic reviews and meta-analyses in social sciences: A living review"
  author: "Amanda Legate, Kim Nimon, Ashlee Noblin"
  venue: "F1000Research"
  date: 2024
  doi: 10.12688/f1000research.151493.2
read: full-text
source: "transcript at shadow/library/papers/2024/legate2024-semiautomated-approaches-to-data-extraction-for-systematic-reviews-and-meta-analyses-in-social-sciences/transcript.md"
facets:
  stage: "extract"
  contribution: "evaluation"
  setting: "general"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "baseline living review of (semi)automated data-extraction tools for social-science SRs"
---

# (Semi)automated approaches to data extraction for systematic reviews and meta-analyses in social sciences: A living review

## Evidence

- LSR of (semi)automated data-extraction tools/techniques **outside**
  clinical medicine, methodology adapted directly from Schmidt et al.'s
  clinical LSR (the `doi:10.12688/f1000research.51117.x` series already
  in this survey's catalog) — search strategy and ACL/arXiv/DBLP
  search+dedup code reused from Schmidt et al. (2020, 2021).
- PRISMA search: 11,336 records → 10,644 after dedup → 46 full-text →
  **23 included studies** (baseline iteration). Authors contrast this
  directly with the sibling clinical LSR (Schmidt et al., 2023), which
  yielded 76 included studies from the same methodology applied to
  PICO/RCT literature — read as evidence social-science extraction
  automation lags clinical automation in maturity/volume.
- Included-study mix: 12 present a tool/system, 9 develop novel methods,
  2 evaluate existing tools' performance, **0** apply existing tools to
  conduct actual secondary research (no found case of a social-science
  team using one of these 23 in a real review). Technique prevalence
  across the 23: tokenization/segmentation 83%
  (n=19); PDF parsing 65% (n=15); rule/heuristic approaches 70% (n=16,
  regex n=7); word embeddings most common feature method (GloVe n=4,
  ELMo n=2; BoW n=5, TF-IDF n=4); SVM = 50% of binary classifiers; NER
  in 6/23; transformer approaches (BERT, SciBERT, BioBERT, distilBERT)
  show "rapid growth since 2020."
- Accessibility: only **1 of 23** tools (SysRev) was live/accessible
  online at review time; **6/23 (26%)** open-sourced code; 50 distinct
  open-source technologies identified, 8/23 (35%) using Python NLTK.
- Extraction targets: no unifying framework exists (unlike PICO); authors
  map tools post hoc against APA JARS elements (Methods: sample/design/
  measures/psychometrics; Results: descriptive/inferential stats, model
  fit, effect sizes). Only 2 of 12 UI-having tools extracted from
  **tables** as well as text; 1 (TableSeer) was table-specific, the rest
  text-only. Flagged gap: "few solutions considered extraction of data
  from tables, which is where many elements (e.g., effect sizes) reside."
- Quantitative accuracy findings are sparse and per-tool, not pooled: no
  cross-tool precision/recall/F1 or agreement benchmark is computed by
  the review authors — those metrics (plus Kappa) are inventoried only
  as what individual primary studies reported for their own systems. One
  concrete efficiency figure: DASyR's UI let "five experts add
  approximately 30,000 annotations at a speed of 4s/annotation" (Piroi
  et al., 2015).
- Review's own methodology: Rayyan screening by 3 researchers (1000
  abstracts/week each), weekly consensus; extraction via Google form
  independently in triplicate, weekly reconciliation. Authors state they
  **originally intended formal IRR assessment** at each stage but did
  not execute it this baseline iteration (exploratory open-coding scope,
  no prior IRR framework to adapt) — deferred to future updates.

## Bearing on RQs

RQ1 (landscape) primarily: structured 23-tool survey organized by
pipeline stage (preprocessing → feature engineering → architecture →
rule-bases → evaluation), useful for cluster-anchoring RQ1's extraction
stage outside PICO/RCT. Secondary, mostly negative bearing on RQ2
(reliability): no cross-tool benchmark comparison and no completed IRR
for the review's own process (explicitly deferred); accuracy reported
per-primary-study, not pooled. The 76-vs-23 contrast with the clinical
sibling LSR is the closest thing to a reliability/maturity signal, and
it's indirect (study-count comparison, not an accuracy measurement).

## Evidence limits

Baseline (first) LSR iteration — authors flag limited corpus
generalizability, omitted snowballing, English-only/limited-database
search, no grey literature, and no IRR/agreement statistics for their
own screening or extraction (deferred). All claims transcript-supported;
tables 4–5 (APA-element/tool crosswalk) had column/row scrambling in the
raw pymupdf4llm markdown, cross-checked against surrounding prose.
