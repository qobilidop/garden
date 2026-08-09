# Survey protocol

The rules of this survey, always in their current form; the README
is the map and the operating procedure. The original campaign
predates this document — it was reconstructed from the campaign's
retained rules on 2026-08-09. Material method changes update these
rules in place and are logged in plain language in `status.md`'s
Method changes section (append-only), with event-level audit rows in
`log.tsv`.

## Objective and study type

Maintain an exploratory systematic map of AI-assisted and automated
methods, systems, evaluations, benchmarks, and guidance for
secondary studies (systematic reviews, maps, and related evidence
syntheses). The search was motivated by LLMs and agents but its
model-side vocabulary also admitted generic automation, artificial
intelligence, machine learning, deep learning, and neural methods;
the map therefore includes some narrow-ML lineage and is not an
LLM-only denominator. Facets are single-pass abstract-level coding,
not risk-of-bias or certainty assessments.

- **Window:** 2020-01-01 through the recorded cutoff, English only.
  Earlier lineage enters through existing reviews.
- **Genre limits:** relevance-sorted searches capped at 50 results;
  counts describe the retained catalog, not the complete literature.

## Search rules

1. Run one request for each distinct qid in `queries.tsv`, using its
   last query text and the source template below. Do not replay
   historical FAILED rows as separate queries.
2. Fetch the inclusive interval from each query's `last_reconciled`
   date (the window start, 2020-01-01, for a query never yet
   reconciled) through a new explicit upper cutoff — the shared
   update tool stages exactly this. Post-filter every source to
   `from_date <= publication_date <= new_cutoff`; arXiv requires
   this locally because its template has no date parameter. The
   inclusive boundary day is absorbed by identifier/title
   deduplication.
3. A request gets at most three attempts, separated by 10 and 30
   seconds. Append one log row per attempt with the same qid/date. A
   terminal failure is `FAILED:<HTTP/status reason>` and is
   disclosed in the wave ledger and manuscript limitations; it is
   never counted as a successful query.
4. Retain the 50-result, relevance-sorted cap unless an update
   chooses and records a different limit. The cap is a coverage
   limitation, not a claim of saturation.

Source templates (the shared search clients in
`skills/run-survey/scripts/` implement them):

- OpenAlex: `api.openalex.org/works?filter=title_and_abstract.search:<q>,from_publication_date:<start>,to_publication_date:<end>&per-page=50&sort=relevance_score:desc`
- Semantic Scholar: `api.semanticscholar.org/graph/v1/paper/search?query=<q>&year=<startyear>-<endyear>&limit=50&fields=title,year,venue,abstract,externalIds,url`
- Crossref: `api.crossref.org/works?query.bibliographic=<q>&filter=from-pub-date:<start>,until-pub-date:<end>&rows=50&select=DOI,title,issued,container-title,abstract`
- arXiv: `export.arxiv.org/api/query?search_query=<q>&start=0&max_results=50&sortBy=relevance` followed by the exact local date post-filter

## Key and version rules

Canonical keys are lowercase `doi:<doi>` or `arxiv:<id>`; use
`t:<title-slug>` only when neither exists. Normalize as follows:

1. Strip `https://doi.org/`, `http://dx.doi.org/`, and bare `doi:`
   from a DOI, percent-decode it, trim whitespace, and lowercase it.
2. Collapse `https://arxiv.org/abs/<id>`, `arxiv:<id>`, and
   arXiv-issued DOI forms to `arxiv:<id>`; strip a trailing version
   suffix (`vN`).
3. For a `t:` fallback, Unicode-NFKD normalize the full title, drop
   combining marks, lowercase, keep only ASCII alphanumerics, and
   truncate to 80 characters.
4. `legacy:` is reserved for an already-retained malformed historical
   alias whose identity cannot be represented without colliding with
   its canonical row; never mint it for a new candidate.

Examples: `https://doi.org/10.2196/48996` → `doi:10.2196/48996`;
`https://arxiv.org/abs/2310.17526v2` → `arxiv:2310.17526`.

Deduplicate a new candidate by exact key against the catalog. Then
compare its full normalized title to included display prefixes.
Because 529 of the original display titles were truncated at 70
characters, a prefix match is a candidate match, not proof: resolve
the stored DOI/arXiv key through its registrar, compare full
normalized titles and authors, and adjudicate ambiguous pairs.
Version aliases of exclusions are retained as
E6-duplicate-or-superseded. When a published version replaces an
included preprint, replace the included key and add the superseded
identifier as an excluded catalog row with code
E6-duplicate-or-superseded. For a candidate matching a retained `t:`
row, compare its
normalized full title with both the stored slug and display prefix,
then adjudicate from the candidate's authors, year, and venue; if
those metadata do not establish identity, keep the records separate
or park the candidate.

## Snowball rules

Resolve each included seed to an OpenAlex work. For a DOI use
`GET /works/https://doi.org/<doi>`. For an arXiv-only seed, search
its full title, then accept only an exact normalized-title and year
match; ambiguous seeds are logged and skipped rather than guessed.
For each resolved OpenAlex ID: backward candidates are the complete
`referenced_works` list; forward candidates come from
`filter=cites:<id>` with cursor pagination; deduplicate by the key
and title rules above before counting a candidate
(`search_openalex.py snowball` implements this).

Apply the case-insensitive title vocabulary
`review|screening|synthesis|extraction|meta-analys|survey|systematic|evidence|literature|prisma|appraisal`.
Then test the reconstructed title plus abstract against
`large language model|language model|\bllm|gpt|agent|automat|artificial intelligence|machine learning|deep learning|neural|\bai\b|\bgenai\b|\bgai\b|generative ai|foundation model`.
If the abstract is missing, test the title alone and send a
vocabulary miss to `parked` rather than silently discarding it.

The title stage is applied to the title only, so a work whose title
carries no genre term is dropped before its abstract is ever read.
This is a known recall limitation of the snowball prefilter, not a
scope judgment: it costs works that describe evidence-synthesis
assistance in the abstract under a title that names only the
technique or the application domain. It is retained because reading
every chase abstract does not scale, and it is disclosed in the
manuscript's limitations.
Count title-filter rejects, model-vocabulary rejects, missing-data
parked rows, merges, screened rows, and includes in the update
ledger. Run one backward+forward round from new includes and a
verification pass over everything it screens in.

The initial wave used the same title vocabulary, but its exact
model-side list was not retained; its 323 uncataloged prefilter
rejects and other phase quantities are historical aggregates, not
reproducible candidate-level facts.

## Selection and screening

- **Include:** a peer-reviewed work or preprint whose subject
  matches the scope above.
- **Exclude** (survey-declared codes, validator-enforced):
  - E1-primary-research-automation — primary-research automation only
  - E2-generic-nlp-no-synthesis-framing — generic NLP/RAG without
    evidence-synthesis framing
  - E3-opinion-without-guidance — opinion without actionable guidance
  - E4-before-window — before the searched window
  - E5-insufficient-metadata — insufficient accessible metadata to
    determine subject after identifier, landing-page, and abstract
    checks
  - E6-duplicate-or-superseded — duplicate or superseded
    identifier/version
  - E7-retracted-or-withdrawn — retracted or withdrawn
- Undecidable candidates take the `parked` status instead of a code
  and are re-screened on every update.

Boundary examples: a literature-QA system with no secondary-study
framing is E2-generic-nlp-no-synthesis-framing; prompt advice for
generic paper summarization is E2-generic-nlp-no-synthesis-framing;
an LLM screening titles/abstracts for a systematic review is
included. A closed paper with an informative abstract can be
included and deep-read as abstract-only;
E5-insufficient-metadata is for records lacking enough metadata even
to decide scope. A method spanning evidence review and primary
hypothesis generation is E1-primary-research-automation when the
primary-research product is its central contribution; park the
candidate when that priority cannot be decided from the available
abstract.

Each pass receives the full available title, abstract, year, venue,
and identifier. Pass A uses an eligibility-first framing: identify
positive evidence that the work contributes to a secondary-study
stage, otherwise return the best E-code. Pass B uses an
exclusion-first framing: attempt to prove
E1-primary-research-automation through E5-insufficient-metadata,
otherwise include. Both return JSON
`{"decision":"include|E1-primary-research-automation|E2-generic-nlp-no-synthesis-framing|E3-opinion-without-guidance|E4-before-window|E5-insufficient-metadata|parked","reason":"one sentence","confidence":"high|medium|low"}`.
Use different model tiers/vendors when available. The adjudicator
sees the candidate and both outputs, resolves disagreements, and
emits the same schema. The human gate reviews counts, all
disagreements, every parked row, and a random sample of agreements;
record its approval in the update ledger.

## Taxonomy and coding

Every included row carries one abstract-level primary-focus value
per dimension. These are descriptive labels, not quality or
certainty judgments.

- **Stage:** `meta` if the work is about the review process/field
  rather than performing an operational stage; `end2end` only if it
  substantively implements at least four of search, screen, extract,
  appraise, synthesize, report; otherwise use the stage named by the
  primary objective or main evaluation endpoint. If two stages are
  co-primary and the abstract cannot break the tie, park pending a
  deep read.
- **Contribution:** `evaluation` for a primarily comparative
  empirical assessment; otherwise `guideline` for prescriptive
  conduct/reporting, `system` for a released/integrated tool,
  `method` for a technique or algorithm, and `position` for an
  argument or agenda. Code the primary contribution, not every
  component.
- **Evidence:** `human-agree` when outputs are compared with human
  or human-derived reference labels; otherwise `benchmark` for a
  nonhuman benchmark and `none` when neither appears. Precedence is
  `human-agree > benchmark > none`.
- **Setting:** `med` for healthcare/biomedical review corpora, `se`
  for software-engineering secondary studies, and `general` for
  cross-domain or domain-independent work. Venue alone never
  determines setting.

Allowed tokens: stage
`search|screen|extract|appraise|synthesize|report|end2end|meta`;
contribution `method|system|evaluation|guideline|position`; evidence
`human-agree|benchmark|none`; setting `med|se|general`.

## Notes, syntheses, claims, and evidence

The note contract is the `run-survey` skill's
`assets/source-note-template.md`. Note-level full-text
facets are authoritative for that work but do not silently rewrite
the abstract-coded map; disclose disagreements. Each reading batch
names the syntheses it affects; understanding changes land in
`syntheses/` first, never manuscript-first. Any active synthesis
claim in `claims.md` must be supported by at least one evidence
record in `evidence.md`; evidence records anchor into note headings.
The landing-page reading list is curated, not exhaustive: the
strongest evidence, defining system, or guidance anchor for each
taxonomy section; deep-read does not imply listed. Every annotation
carries abstract-only, preprint, adjudication, and author-benchmark
caveats that qualify its claim.
