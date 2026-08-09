# luo2024-potential-roles-of-large-language-models-in-the-production-of-systematic-reviews-and-meta-analyses — stage-by-stage LLM role map for SR/MA production, with a call for a reporting guideline

- **Status:** G1 deep-read
- **Work:** doi:10.2196/56780 — Luo, Chen, Zhu, Wang, Wang, Liu, Lyu, Wang,
  Wang & Chen (2024), "Potential Roles of Large Language Models in the
  Production of Systematic Reviews and Meta-Analyses" (JMIR, Viewpoint,
  gold OA)
- **Source:** transcript at
  shadow/library/papers/2024/luo2024-potential-roles-of-large-language-models-in-the-production-of-systematic-reviews-and-meta-analyses/transcript.md
- **Facets:** stage=meta (end-to-end map, 9 stages), contribution=position
  (Viewpoint article; no original empirical evaluation), setting=med
  (worked examples and venue are medical/EBM)

## Evidence

- Table 1 (lines 87-100) is a 9-row stage-by-stage role map: research
  topic/question, register+proposal, inclusion/exclusion criteria, search
  strategy, screen literature, extract data, assess risk of bias,
  analyze data/meta-analysis, draft manuscript, submit/publish — each row
  lists 2-4 concrete sub-tasks LLMs can assist with and citations. This
  granularity (9 stages, not the survey's 6) is a useful cross-check for
  the RQ1 stage taxonomy — it splits "search" into question-formulation,
  registration, criteria, and search-strategy as separate stages, and adds
  submission/publication as a stage the survey's scheme doesn't track.
- Per-stage detail beyond the table (lines 116-171): screening — "using
  ChatGPT in the literature selection process for a meta-analysis
  substantially diminishes the workload while preserving a recall rate on
  par with manual curation" (cites refs 28, 44-47, no original numbers);
  data extraction — "high accuracy" extracting from PDFs but "caution is
  still required when extracting data from figures or tables," manual
  verification still deemed necessary; risk of bias — chatbot accuracy
  "comparable to human evaluations" (citing ref 23), contrasted with the
  manual RoB/RoB2 baseline of "10-15 minutes per trial"; data analysis —
  LLMs judged unable to "fully execute data analysis independently,"
  useful only for extraction feeding into Stata/RevMan/R or the ChatGPT
  Code Interpreter; manuscript drafting — explicit recommendation *against*
  using chatbots for full composition, restricted to language polishing.
- Cost/time baseline cited for the un-assisted process (line 63): average
  SR takes 67.3 weeks, 5 researchers, ~US$140,000 (citing Borah 2017,
  Michelson & Reuter 2019); contrasted with a cited automation case study
  completing a full SR in 2 weeks (Clark et al. 2020). Both figures are
  secondary citations, not measurements by this paper.
- Risk catalog (lines 174, 178): hallucination/fabricated citations, need
  for human verification given "poor reliability," non-replicability when
  LLM steps aren't disclosed, data-privacy/ethical-approval obligations for
  patient data passed to a chatbot, stale training cutoffs (e.g. GPT-3.5's
  2021 cutoff), context-window limits, "indiscriminate overuse" degrading
  accuracy. Demonstrations are 9 multimedia appendices (screenshots of
  ChatGPT-4/Claude 3 sessions for search-strategy generation, PROSPERO
  registration, criteria, PDF extraction, RoB assessment, journal
  selection) — illustrative only, not quantitatively analyzed.
- Norms position (line 198): PRISMA 2020 "briefly addresses the use of
  automation technologies" but only for screening, with "a lack of
  comprehensive guidance on the broader spectrum of applications";
  concludes "developing a reporting guideline is warranted" — a call for
  one, not a proposal (contrast degen2024's FRAISR, an actual template).

## Bearing on RQs

RQ1 primarily — Table 1 is a second, independently derived stage
taxonomy (9 stages vs. the survey's 6), usable to cross-check stage
coverage and as a citation-cluster anchor (each row's bracketed refs are
candidate snowball targets, e.g. [28,44-47] screening, [47-50]
extraction, [51-53] risk of bias). Secondary bearing on RQ3: citable
evidence that as of mid-2024 no comprehensive AI-disclosure reporting
guideline for SR/MA existed and PRISMA 2020's automation coverage was
screening-only — corroborates degen2024's gap claim independently. No
bearing on RQ2 or RQ4 (no agreement/reliability measurement; no
discussion of independence or model-ensembling).

## Evidence limits

Viewpoint/position paper: stage-map citations were gathered narratively
("various studies [11,25-32] indicate...") rather than through a disclosed
systematic search, so Table 1 is expert synthesis, not a mapped literature
review. All quantitative figures (cost/time baseline, recall-preservation
claim, RoB timing) are secondary citations, not measurements by these
authors. The 9 multimedia-appendix demonstrations are single-session
screenshots with no accuracy assessment. No content inferred beyond the
transcript.
