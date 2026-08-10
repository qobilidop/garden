# Claims and qualification ledger

This file owns the survey's current `Cxx` synthesis propositions and their
qualifications. It does not store individual source findings (`evidence.md`),
cross-paper explanatory prose (`syntheses/`), or manuscript wording. The
evidence ledger supplies anchored support.

## Record schema

- **Status** — `hypothesis` while under examination; `survey synthesis`,
  optionally followed by a qualifier, once settled; or `rejected` while a
  defeated proposition remains as a temporary guardrail.
- **Statement** — the proposition maintained by the survey.
- **Scope** — the domain within which it is asserted.
- **Prior frontier** — the closest established result and the remaining
  survey-authored interpretation.
- **Qualification** or **Presentation rule** — limits needed to prevent
  overstatement.

Fields are prose and contain no delimiter-encoded lists. Identifiers are stable
`Cxx` labels, so they survive status changes. Listing a claim never establishes
novelty.

## Current survey synthesis claims

### C01 — Screening remains the largest map category

- **Status:** survey synthesis; map interpretation
- **Statement:** In the retained 776-work map, screening is the largest
  primary-focus category (256), while appraisal (33) and reporting (23) are
  the smallest. The present coding also identifies 47 guideline contributions
  and 96 end-to-end rows; van Dinter et al.'s differently scoped baseline has
  no directly comparable categories for those values.
- **Scope:** This survey's single-pass abstract-level coding; a description of
  the retained map, not population prevalence or adoption trends.
- **Prior frontier:** van Dinter et al. found all 41 studies in their 2006–2020
  automation review inside conducting-the-review, with screening dominant and
  planning/reporting untouched; Napoleão et al. measured a medicine-versus-SE
  practice-adoption gap. The LLM-era comparison is this survey's map.
- **Qualification:** The catalog is medicine-heavy and its facets are
  unvalidated. Counts say where this search and coding placed works, not how
  common a practice is worldwide.

### C02 — Performance verdicts depend on measurement choices

- **Status:** survey synthesis; evidence-quality interpretation
- **Statement:** The selected studies show that class imbalance, aggregation,
  prompt choice, reference labels, and study effects can materially change
  performance verdicts. In one benchmark, study effects exceeded differences
  among the larger tested models. Accuracy-style metrics can reverse rankings
  and hide lost evidence; human reference decisions are also imperfect.
- **Scope:** Selected evidence notes across screening, extraction, and appraisal;
  no pooled effect estimate or formal risk-of-bias appraisal.
- **Prior frontier:** Madeyski et al. make the measurement critique for LLM
  screening; Huotala et al. demonstrate aggregation and study effects in one
  benchmark. The cross-stage interpretation and human-baseline calibration are
  this survey's synthesis.
- **Qualification:** Oami et al. and Madeyski et al. prescribe different ways
  to trade missed evidence against workload. The manuscript stages that
  disagreement rather than selecting a metric standard.

### C03 — Disclosure elements recur while instruments and roles diverge

- **Status:** survey synthesis; organizing interpretation
- **Statement:** Tool identity and version, task or stage, human role,
  configuration, and verification recur across selected guidance, but no one
  item set is common to every instrument. Four unvalidated instruments span
  disclosure reporting and reproducible storage, while guidance differs on
  whether AI may perform first-pass work or should remain a secondary checker.
- **Scope:** Guidance, instrument, consensus, and exemplar works among the
  selected evidence notes; a comparison of content and reported evidence, not a
  quality ranking.
- **Prior frontier:** Each proposal states its own reporting or conduct gap.
  The recurring-elements, two-genre, and role-divergence comparison is this survey's
  synthesis.
- **Qualification:** "Unvalidated" means that the evidence notes report no
  piloting, field validation, or adoption study. It does not prove that no
  external use exists. Two sources disagree on PRISMA-AI's history but agree
  that no usable instrument was available.

### C04 — Agent-reviewer independence is undefined in the selected set

- **Status:** survey synthesis; bounded gap observation
- **Statement:** No selected evidence record identifies a definition of when
  two agent reviewers count as independent. One study measures inter-agent
  score correlation and finds debate raises correlation while reducing the
  voting ensemble's advantage; the selected ensemble and deferral designs
  otherwise report configurations without isolating a causal mechanism.
- **Scope:** Strictly the evidence-bound selected set. The searches and
  taxonomy contain no independence facet, so this is not a literature-wide
  absence claim.
- **Prior frontier:** Hamel et al. specify independence and oversight for human
  reviewers. The selected agent studies supply correlation, voting, OR,
  same-family aggregation, and deferral results without a transferred
  independence definition.
- **Qualification:** Vendor, scale, training data, run count, aggregation rule,
  and corpus are confounded across the positive studies. A matched design is
  required before attributing gains to model-family diversity.

### C05 — The taxonomy responds to genuine vocabulary divergence

- **Status:** survey synthesis; taxonomy construction
- **Statement:** Selected sources use non-equivalent stage models ranging from
  four phases to twelve steps, and one living-evidence inventory states that
  its own terminology may undercount publication-update tools. The survey's
  single-valued four-dimensional scheme is a constructed normalization of that
  divergence.
- **Scope:** The divergent source vocabularies are evidence-backed; the
  taxonomy itself is a survey construction judged by clarity and use.
- **Prior frontier:** Kitchenham and Charters, PRISMA 2020, and Petersen et al.
  supply the process and mapping vocabulary; Petersen et al. supply keywording
  as the scheme-construction method.
- **Qualification:** The taxonomy was applied once to truncated abstracts.
  Full-text note facets remain authoritative for individual works and sometimes
  disagree with the map.

### C06 — Genre nouns and stage granularity vary more than stage names

- **Status:** survey synthesis; terminology correction
- **Statement:** Across the sources registered for the terminology comparison
  and the method canon, the field uses at least four umbrella nouns and
  multiple study genres, while stage models range from four phases to twelve
  steps. Their stage names are recognizably similar; the clearest terminology
  split is at appraisal, where quality assessment, risk-of-bias judgment, and
  appraisal-instrument scoring denote overlapping but distinct tasks.
- **Scope:** Titles, abstracts, and note prose in the sources bound by E027,
  not an audit of every selected note or a full-text term-frequency study.
- **Prior frontier:** Petersen et al. distinguish mapping studies from
  Kitchenham and Charters' systematic-review model. No selected source supplies
  the cross-community lexical comparison maintained here.
- **Qualification:** The earlier claim of a medicine-versus-SE stage-name split
  is rejected. Software-engineering terminology rests on a small stratum of the
  medicine-heavy map.
