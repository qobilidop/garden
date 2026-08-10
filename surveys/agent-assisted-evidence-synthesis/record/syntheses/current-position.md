# Current position

This file is the compact entry point to the survey's current interpretation. It
owns the high-level cross-paper conclusions, not method, dated status, update
procedure, evidence records, or manuscript wording.

## Subject and evidence boundary

The survey is an exploratory systematic map of AI-assisted and automated
evidence synthesis. Its 776 include-level works are single-pass,
primary-focus-coded from truncated abstracts; 31 selected works have structured
evidence notes (25 full-text, 5 abstract-only, 1 secondary-only). Findings about the catalog
describe the retained coding. Findings about performance, norms, and reviewer
design describe this selected set. Neither supports population prevalence or a
literature-wide absence claim.

## Stable conclusions

### Landscape

Screening is the largest primary-focus category (256 of 776), while appraisal
(33) and reporting (23) are the smallest. The map contains 96 end-to-end works
and 47 guideline contributions; the selected pre-LLM baseline has no directly
comparable categories for those values. Medicine supplies 463 rows and software engineering 23; that skew is
a property of this search and coding, not an adoption-trend measurement.

### Performance and measurement

The selected evidence is heterogeneous in corpus, reference labels, operating
point, and metric. Madeyski et al. show accuracy, MCC, and weighted MCC choosing
different models on the same imbalanced data; Huotala et al. show aggregation
and study effects changing comparisons. Hirt et al. supply the clearest
within-tool warning: agreement with human judgments ranges from $kappa = 0.60$
to $0.04$ across domains in one corpus (abstract-only). Human references are
also imperfect, and the only selected randomized appraisal-automation study
establishes noninferiority rather than superiority.

Oami et al. treat specificity as the workload metric when sensitivity is
similar; Madeyski et al. reject specificity as a primary metric under imbalance
and recommend lost evidence plus chance-anchored, cost-sensitive metrics. The
survey records that conflict rather than choosing a field standard.

### Norms

Tool identity and version, stage or task, human role, configuration,
verification, and accountability recur across selected guidance, but no item
set is common to every instrument. Three reporting instruments and one
reproducible-storage checklist cover different subsets, and none reports field
validation or adoption. Guidance also differs on role:
Cochrane-family sources keep AI as a secondary checker, whereas HAICO-SLR allows
first-pass work under human validation. Holst et al. and Fernandes et al.
disagree on whether PRISMA-AI was merely unpublished or never developed; both
describe it as unavailable for use.

### Reviewer independence

No selected evidence record identifies a definition of when two agent
reviewers count as independent.
One study reports inter-agent score correlations of 0.48–0.56 and finds debate
raises correlation while reducing the advantage of independent voting. Other
selected work documents cross-vendor OR, same-family aggregation, and
human–LLM deferral. Vendor, scale, training data, run count, aggregation rule,
and corpus remain confounded, so configuration results do not isolate a general
mechanism.

### Terminology

Genre nouns and stage granularity vary more than the shared stage names. The
survey uses _evidence synthesis_ as the umbrella and _secondary study_ for one
review, map, scoping review, rapid review, or living review; it is itself an
updatable systematic map. Its six operational stages are a local collapse of
models ranging from four phases to twelve steps. The clearest term boundary is
at appraisal: quality assessment, risk-of-bias judgment, and
appraisal-instrument scoring are related but not interchangeable.

## What would change the interpretation

- Validated dual-pass facet coding or broader uncapped retrieval could change
  the map distribution.
- Full text or replication of abstract-only and preprint anchors could change
  the strength of the performance and ensemble conclusions.
- A validated or adopted disclosure instrument would weaken the fragmentation
  conclusion.
- A targeted independence study with matched same-family and cross-family arms
  and correlated-error measurement would replace the bounded gap observation
  with an evaluated construct.
- A deliberate full-text lexical study could overturn the terminology
  synthesis, which is currently read from titles, abstracts, and notes.
