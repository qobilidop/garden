# Claims and qualification ledger

This file records the survey's current synthesis claims. A claim
enters as `hypothesis` and moves to `supported`, `known-result`, or
`rejected` as evidence accumulates. Every current claim is
`supported`: each is an evidence-backed synthesis across others'
work — the survey's organizing findings — not a novelty or priority
claim for any underlying result. Each claim carries an explicit
scope, the closest established statement of the same point, an
assessment of why its status holds, and the caveats that must
travel with it.

## Current survey synthesis claims

The `Cxx` identifiers below are stable synthesis-claim IDs. The
**Supports:** field of `evidence.md` connects source-note evidence
to them; evidence rows have their own `Exxx` identifiers so that a
source's claim cannot be mistaken for this survey's synthesis.

### C01 — LLM-era stage distribution reproduces the pre-LLM skew

- **Status:** supported
- **Statement:** In the retained 776-work map, screening is the largest
  primary-focus category (216) while appraisal (25) and reporting (22)
  are the smallest — the same conducting-the-review skew documented
  before LLMs — alongside guideline (34) and end-to-end (85)
  categories that the pre-LLM corpus lacked.
- **Scope:** This survey's retained catalog under single-pass
  abstract-level coding; a description of the map, not of population
  prevalence or adoption trends.
- **Closest established:** van Dinter et al. found all 41 pre-LLM
  automation studies (2006–2020) inside conducting-the-review —
  screening dominant, appraisal nearly empty, planning and reporting
  untouched; Napoleão et al. measured the medicine-vs-SE
  practice-adoption gap. The LLM-era side of the comparison is this
  survey's map.
- **Assessment:** Supported — the pre-LLM baseline is anchored in two
  full-text deep reads and the LLM-era side in the corrected catalog;
  the claim is distributional, not causal.
- **Caveats:** The map counts come from `catalog.tsv`, not from the
  evidence ledger; facet labels are unvalidated single-pass
  abstract-level codes; the medicine-heavy catalog (463/776 vs 23 SE)
  does not show that the adoption gap widened.

### C02 — Reliability evidence is abundant but mismeasured

- **Status:** supported
- **Statement:** The map labels 249 works human-agreement and 152
  benchmark, yet the selected deep reads show that common measurement
  practice under heavy class imbalance obscures what those comparisons
  mean: accuracy-style metrics flip model rankings, aggregation
  choices change model comparisons, study effects exceed model
  effects, prompt variants move sensitivity materially, and results
  must be calibrated against imperfect human baselines.
- **Scope:** Measurement practice and results in the selected deep
  reads across screening, extraction, and appraisal; thresholds and
  examples are medicine-calibrated.
- **Closest established:** Madeyski et al. state the mismeasurement
  thesis for LLM screening evaluations; Huotala et al. raise the
  aggregation and study-effect points for their own benchmark. The
  survey's synthesis extends the pattern across stages and pairs it
  with human-baseline calibration.
- **Assessment:** Supported — the strongest records (E005, E006) are
  full-text deep reads with reanalysis-grade numbers; limiting records
  (E013, E014) qualify rather than contradict.
- **Caveats:** The survey performed no formal quality appraisal; the
  deep-read subset is facet-guided, not random; two supporting sources
  are abstract-only and carry that marker in the manuscript.

### C03 — Disclosure norms converge on content while instruments fragment

- **Status:** supported
- **Statement:** The selected guidance shares a disclosure core — name
  the tool and version, state which stage the AI performed and what
  the human did, describe verification — and conduct guidance keeps a
  human decision in every stage; yet three deep-read instruments (a
  14-item checklist with a human/AI-split flow diagram, a
  machine-readable per-stage table, dual conduct-and-reporting tables)
  coexist with no reported validation or adoption evidence, while
  disclosure in practice remains rare.
- **Scope:** The guidance and exemplar works among the deep reads;
  content convergence and instrument fragmentation, not instrument
  quality.
- **Closest established:** Each proposal itself claims to fill the gap
  left by PRISMA 2020's selection-only automation coverage and the
  unpublished PRISMA-AI; the convergence-with-fragmentation reading
  across them is this survey's synthesis.
- **Assessment:** Supported — content convergence and validation
  absence are both checkable in the three proposals' notes; the
  rare-disclosure evidence is weaker (secondhand relay) and is scoped
  accordingly.
- **Caveats:** Coexistence alone does not establish a standards race;
  "no validation" records the absence of reported evidence in the
  notes, not proof that none exists anywhere.

### C04 — Reviewer independence for agents is undefined; ensemble and deferral evidence is the best available

- **Status:** supported
- **Statement:** None of the 25 selected deep reads defines what makes
  two agent passes independent in the sense dual human review
  requires, or measures correlated error from shared training data.
  The best available designs — a cross-vendor OR ensemble and
  human–LLM agreement-gated deferral — report strong
  configuration-level results without isolating model family, model
  identity, run count, or combination rule as the cause; one strong
  end-to-end system uses no redundancy at all.
- **Scope:** Strictly the 31 deep reads. Neither wave ran a targeted
  independence/ensemble query and coded no independence facet, so
  this is not a literature-wide absence claim.
- **Closest established:** Hamel et al.'s pre-LLM guidance works out
  reviewer independence for humans only (reviewer compatibility,
  dual-independent screening); no deep read transfers the concept to
  agents.
- **Assessment:** Supported for the deep-read subset — the definitional
  gap is verifiable against every note; the corresponding
  literature-wide claim would be a `hypothesis` and is deliberately
  not made.
- **Caveats:** The two key positive studies are single-team and one is
  an unreviewed preprint with in-team label adjudication; one
  supporting signal is abstract-only with no extractable numbers.

### C05 — The four-dimensional taxonomy answers a demonstrated vocabulary divergence

- **Status:** supported
- **Statement:** The deep reads carry at least three non-equivalent
  stage vocabularies — Kitchenham's twelve SLR steps, a nine-stage
  LLM role map, and a four-phase living-evidence model — and
  terminology choices demonstrably change what gets counted (the
  living-evidence inventory's own authors warn their vocabulary may
  undercount a phase). The survey's single-valued four-dimensional
  scheme is a constructed response to that divergence.
- **Scope:** The premise (divergence and its counting costs) is the
  evidenced part; the scheme itself is a construction judged by use,
  and the manuscript claims only a framing difference among the deep
  reads, not literature-wide novelty.
- **Closest established:** Kitchenham's guidelines and PRISMA 2020
  supply the canonical stage vocabulary the scheme normalizes to;
  Petersen's keywording procedure supplies the construction method.
- **Assessment:** Supported for the premise — the divergent
  vocabularies are checkable in the notes; the taxonomy's adequacy is
  not an empirical claim and is not graded here.
- **Caveats:** The scheme was applied single-pass from truncated
  abstracts, and full-text notes disagree with abstract-level facets
  for 9 of 31 deep reads (manuscript, Limitations).
