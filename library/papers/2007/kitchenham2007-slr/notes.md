---
citekey: kitchenham2007-slr
work:
  title: Guidelines for performing Systematic Literature Reviews in Software Engineering
  author: Barbara Kitchenham and Stuart Charters
  venue: EBSE Technical Report EBSE-2007-01, Version 2.3 (Keele University and University of Durham)
  date: 2007-07
  # title page says 9 July 2007; the version-control table dates v2.3 20 July — month precision kept
sources:
  pdf: https://legacyfileshare.elsevier.com/promis_misc/525444systematicreviewsguide.pdf  # → shadow
    # no publisher URL exists for this tech report; this is an Elsevier-hosted courtesy copy
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "The SE systematic-review standard: protocol before review, question-first structure, two-person extraction with measured agreement, documented search with saved raw results — itself gray literature cited five figures deep, and the closest thing the survey layer has to a constitution."
---

# Guidelines for performing Systematic Literature Reviews in Software Engineering

The standard reference for systematic literature reviews (SLRs) in
software engineering: a book-length technical report adapting medical
review methodology (Cochrane Handbook, Australian NHMRC, CRD
guidelines) and social-science review practice (Petticrew & Roberts,
Fink) to a field with little empirical research, weaker methods, and
proprietary data. The adaptation direction is the report's quiet
thesis: Budgen et al.'s discipline-comparison table rates SE research
practice far closer to education, psychology, and organic chemistry
(0.66–0.83 agreement) than to clinical medicine (0.17), so v2.3
deliberately rebalanced from medical toward social-science
methodology — no randomized trials, no blinding, aggregate across
heterogeneous study types instead. The document is itself versioned
like software (v0.1 2004 → v2.3 2007, with a change log and named
internal/external reviewers), and opens by quoting Hamming's 1968
Turing lecture — "we stand on each other's feet" — as the rationale
for secondary studies.

## The process

Three phases, each decomposed into stages with a mandatory/optional
marking and explicit iteration warnings:

- **Planning**: confirm the need (check existing reviews first);
  research questions drive everything — search must find what answers
  them, extraction must collect what answers them, synthesis must
  combine it so they get answered. Questions are structured by PICOC
  (population, intervention, comparison, outcomes, context), with the
  SE-specific caveats that populations may need to stay unrestricted
  (too few primary studies) and that "not using the intervention" is
  an inadequate control (training confounds). The **protocol** —
  background, questions, search strategy, selection criteria and
  procedures, quality checklists, extraction strategy, synthesis
  strategy — is written and evaluated *before* the review, explicitly
  to prevent expectation-driven selection; piloting every piece is
  the repeated lesson.
- **Conducting**: search (facet-derived boolean strings, multiple
  engines since none suffices, manual searches of key venues, gray
  literature and author contact against publication bias), with the
  search documented as it happens and **unfiltered results saved for
  reanalysis**; selection by piloted inclusion/exclusion criteria,
  two assessors with Cohen's kappa reported and disagreements
  resolved — a single researcher substitutes test–retest on a random
  sample; quality assessment via bias/validity checklists, with the
  medical hierarchy-of-evidence explicitly softened (design types
  suit questions, per Petticrew & Roberts — though observational
  studies' vitamin-C reversal is retold as a warning for SE's
  correlation-heavy literature); extraction by an extractor plus an
  independent checker, never a study's own co-author; synthesis
  descriptive by default (tabulate to expose heterogeneity), with
  effect-measure and forest/funnel-plot machinery for the quantitative
  case and Noblit & Hare's translation approaches for the qualitative
  one, plus sensitivity analysis throughout.
- **Reporting**: a full structure table (through conflict-of-interest
  declarations and excluded-study lists with rationale); journal
  papers must reference a technical report or thesis carrying the
  full detail.

Section 8 defines mapping studies by contrast — broader questions,
coarser classification-not-extraction, summary-not-synthesis
analysis — and §9 closes with a "light" single-researcher variant
scoped for PhD students.

## Assessment

- **Durable:** protocol-before-review as bias control; questions
  driving search, extraction, and synthesis; documented search with
  raw results retained; independent dual extraction with measured
  agreement and arbitration; sensitivity analysis as standing
  obligation; the review/mapping distinction; dissemination beyond
  academic venues.
- **Era-bound:** the database roster and search-engine complaints;
  the absence of registration infrastructure (PROSPERO-style
  registries postdate it); no treatment of automation of any kind.
- **Caveats:** deliberately high-level — it defers meta-analysis
  entirely and says different question types deserve different
  procedures it does not provide; its examples lean heavily on the
  authors' own cost-estimation reviews.
- **In this library:** the protocol template for the survey layer
  this repo is designing — the dataflow survey's protocol.md,
  audited search logs, and dual-pass screening are this document's
  discipline, transmitted through two decades of SE practice. Its
  own form argues the layer's citability case: a versioned,
  never-journal-published technical report cited five figures deep.
  [[petersen2008-mapping]]
  elaborates the mapping branch §8 sketches;
  [[wohlin2014-snowballing]]
  supplies the search procedure §6.1 lists but does not specify;
  [[page2021-prisma]] is the reporting phase
  matured into an enforced checklist. The Hamming epigraph closes a
  loop: [[hamming1986-your-research]] was this library's
  first ingestion.
