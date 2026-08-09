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
  primary-focus category (256) while appraisal (33) and reporting (23)
  are the smallest — the same conducting-the-review skew documented
  before LLMs — alongside guideline (47) and end-to-end (96)
  categories that the pre-LLM corpus lacked. The 2026-08-09 update
  grew every cell and changed no ordering.
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
- **Statement:** The map labels 303 works human-agreement and 158
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
- **Statement:** None of the 31 selected deep reads defines what makes
  two agent passes independent in the sense dual human review
  requires. One work now measures a proxy — inter-agent score
  correlation of 0.48–0.56 — and argues from it that model
  heterogeneity drives ensemble gains, showing debate raising that
  correlation while lowering accuracy; its three agents vary in
  vendor, size, and corpus at once, so the claim outruns the design.
  The other designs — a cross-vendor OR ensemble, a same-family
  probability-sum ensemble, and human–LLM agreement-gated deferral —
  report configuration-level results without isolating any cause; one
  strong end-to-end system uses no redundancy at all.
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
  not made. The 2026-08-09 update narrowed the claim from "no
  mechanism measured" to "no definition given", which is the version
  now carried.
- **Caveats:** The key positive studies are single-team and one is
  an unreviewed preprint with in-team label adjudication; one
  supporting signal is abstract-only with no extractable numbers. The
  cross-family versus same-family margin contrast the two update
  ensembles suggest is confounded by corpus, task, metric, and model
  era, and is held as a hypothesis for a matched design, not printed
  as a result.

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

### C06 — The field's genre nouns are contested; its stage names are not

- **Status:** supported
- **Statement:** Across the deep reads and the method canon the field
  runs at least four umbrella nouns (evidence synthesis, knowledge
  synthesis, secondary studies, systematic literature studies) and six
  genre nouns for its own products, and its stage models range from
  four phases to twelve steps — while the shared stages are named
  recognizably alike. The one genuine stage-name split is at
  appraisal, where quality assessment, risk of bias, and
  appraisal-instrument scoring name three overlapping tasks. The
  earlier framing of a medicine-versus-software-engineering stage
  vocabulary split is not supported: both communities use screening
  and selection, and no live extraction-versus-collection dispute
  appears in the selected evidence.
- **Scope:** The 31 deep reads plus the four method-canon library
  pages, read off titles, abstracts, and note prose — not a term
  frequency study over full texts. "The selected notes do not use X"
  is a claim about the notes, not about the papers.
- **Closest established:** Petersen's mapping-study paper argues the
  genre boundary against Kitchenham's guidelines directly; no selected
  source compares the systematic map with the scoping review, which is
  the boundary this survey's own genre sits on.
- **Assessment:** Supported for the genre and granularity strands,
  which are checkable per source. The negative finding — no
  community stage-name split — is the stronger contribution here,
  because it retracts a claim the manuscript previously made without
  citation.
- **Caveats:** Software-engineering vocabulary claims rest on a small
  deep-read stratum (23 SE rows in a 776-row map). Five deep reads are
  abstract-only and one was reconstructed secondhand. The one measured
  community difference in the set is metric vocabulary, not stage
  vocabulary.
