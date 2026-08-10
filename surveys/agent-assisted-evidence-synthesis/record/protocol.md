# Survey protocol

This file records only choices specific to this survey. The current
`run-survey` skill is canonical for shared search, screening, snowballing,
logging, evidence, update, and bounded-closure procedure. Local commands and
file ownership are in `README.md`; current state is in `status.md`; event
history is in `log.tsv`; current interpretation is in `syntheses/`.

## Objective and study type

Maintain an exploratory, LLM-centered systematic map of AI-assisted methods,
systems, evaluations, benchmarks, and guidance for evidence synthesis. The
subject includes systematic reviews, systematic maps, scoping reviews, rapid
reviews, and living evidence synthesis. Adjacent AI, ML, deep-learning, and
automation work can enter through screening and citation chasing, but the
standing queries do not support a comprehensive broader-automation denominator.
The survey performs no formal risk-of-bias appraisal.

## Research questions

- **RQ1:** How are retained works distributed across workflow stage,
  contribution type, evidence type, and setting?
- **RQ2:** What do the selected evidence notes show about performance
  measurement and reported results?
- **RQ3:** What norms and disclosure instruments appear among the selected
  evidence notes?
- **RQ4:** Among the selected evidence notes, which designs address reviewer
  independence and multi-model ensembling?

RQ4 is exploratory: the standing searches and taxonomy have no independence
facet, so the survey reports only what appears in the selected evidence notes and
makes no literature-wide absence claim.

## Scope and discovery choices

- **Window:** 2020-01-01 through the recorded cutoff, English only. Earlier
  method foundations and pre-LLM lineage enter through selected reviews and
  method-canon sources, not the map denominator.
- **Sources:** OpenAlex, Crossref, Semantic Scholar, and arXiv. Exact standing
  searches, source-native syntax, limits, and reconciliation dates live only
  in `queries.tsv`.
- **Depth:** relevance-sorted query results are capped at 50. This produces a
  bounded catalog, not a completeness or saturation claim.
- **Citation filter:** backward and forward chases first require a review-genre
  title token (`review|screening|synthesis|extraction|meta-analys|survey|systematic|evidence|literature|prisma|appraisal`),
  then a model/automation token in the reconstructed title and abstract
  (`large language model|language model|llm|gpt|agent|automat|artificial intelligence|machine learning|deep learning|neural|ai|genai|gai|generative ai|foundation model`).
  Missing abstracts are parked rather than silently rejected.
- **Defective bibliographies:** an empty, truncated, or largely unresolved
  citation-index bibliography is replaced by the primary version's
  publisher-deposited reference list and marked `primary-complete` in
  `log.tsv`.

The title-first citation filter is a deliberate recall bound: a relevant
abstract whose title carries no genre term is removed before its abstract is
read. The initial campaign's exact model-side vocabulary and candidate-level
provenance were not retained. Those are permanent historical limitations, not
properties to reconstruct from memory.

## Selection boundaries

Include a peer-reviewed work or preprint whose central subject is an
AI-assisted or automated contribution to one or more evidence-synthesis stages,
or a method/guidance work needed to answer an RQ.

This survey declares these exclusion codes:

- `E1-primary-research-automation` — automation whose central product is
  primary research rather than evidence synthesis;
- `E2-generic-nlp-no-synthesis-framing` — generic NLP, RAG, or summarization
  without evidence-synthesis framing;
- `E3-opinion-without-guidance` — commentary without actionable method or
  guidance;
- `E4-before-window` — map candidate published before 2020;
- `E5-insufficient-metadata` — scope remains undecidable after identifier,
  landing-page, and abstract checks;
- `E6-duplicate-or-superseded` — duplicate or superseded identifier/version;
  and
- `E7-retracted-or-withdrawn` — formally retracted or withdrawn.

Undecidable candidates take `parked` and are re-screened on update. A generic
literature-QA or paper-summarization system with no secondary-study framing is
E2; an LLM screening titles and abstracts against a systematic review's
eligibility criteria is included. A system spanning evidence review and
primary hypothesis generation is E1 when the primary-research product is
central; park it when available metadata cannot establish that priority.

## Taxonomy and coding

Every include carries one abstract-level primary-focus value per dimension.
The values describe the work's stated subject and comparison, not study quality
or certainty.

- **Stage:** `search|screen|extract|appraise|synthesize|report|end2end|meta`.
  `end2end` requires at least four operational stages; `meta` is for work about
  the process or field. Otherwise use the main objective or evaluation endpoint.
- **Contribution:** `method|system|evaluation|guideline|position`, with
  evaluation taking precedence when comparative assessment is the main result.
- **Evidence:** `human-agree|benchmark|none`, with precedence
  `human-agree > benchmark > none`. This records a described or planned
  comparison; a protocol can therefore carry `human-agree` before results
  exist.
- **Setting:** `med|se|general`. Venue alone never determines setting.

The facets are single-pass coding from truncated abstracts. Full-text note
facets are authoritative for the individual work but do not silently rewrite
the map; disagreements are disclosed as a limitation.

## Survey-specific record choices

- The scrutiny scale is `included`, `deep-read`, `excluded`, and `parked`.
  `included + deep-read` is the include-level map; only `deep-read` requires a
  source note. `deep-read` names the higher scrutiny level, not full-text
  access: read depth is recorded separately in each note.
- The 31 evidence-note works were chosen purposively and iteratively to cover
  the RQs, taxonomy contrasts, closest maps, quantitative anchors, disclosure
  instruments, and multi-model designs. There was no fixed score, random
  sample, or saturation rule, so frequencies and negative findings must not be
  inferred from this selected set. Twenty-five notes use full text, five use
  only the primary abstract, and one preserves secondary-only screening memory
  and supports no finding.
- `priority=critical` marks the twelve closest or load-bearing works and
  activates the shared bidirectional-chase duties; other deep reads are `high`
  and remaining rows are `medium` unless reclassified.
- The first campaign's log rows carry aggregate counts without per-row decided
  keys. Current and future rows use the shared log grammar. Historical display
  titles truncated at 70 characters are candidate duplicate signals, never
  proof of identity.
- Four method-canon citations have canonical notes in `library/` and are named
  as local citation-closure exemptions in `check.py`. All findings-bearing
  citations must close through `sources/` and `evidence.md`.

## Publication qualifications

The manuscript may publish a dated exploratory-map snapshot with parked rows
and incomplete saturation as long as it reports those bounds and makes no
population-prevalence, adoption-trend, or literature-wide absence inference.
Map counts derive from `catalog.tsv`; claims about selected studies derive from
anchored source notes and carry abstract-only, preprint, benchmark, and
adjudication caveats wherever used.
