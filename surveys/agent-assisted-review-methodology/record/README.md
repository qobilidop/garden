# Survey record

The minimal resumable state of this exploratory systematic map. The
original campaign predates the current `run-survey` workflow. Future
updates should use the current workflow as a guide, exercising judgment
where the retained record or available services differ. Describe material
method changes here in plain language; the survey is not pinned to a
particular skill or repository commit.

An updater needs this directory, the
[manuscript](https://qobilidop.github.io/sys0/surveys/agent-assisted-review-methodology/manuscript.html)
(taxonomy in §3; method and historical funnel in §4), the repository's
`AGENTS.md`, and the current `run-survey` skill. Process history lives in
git and is not required to resume.

- `log.tsv` — the append-only event log: every initial request
  attempt with verbatim query vocabulary, dates, and yields
  (`kind=search`), plus `audit` rows for corrections and
  migrations
- `catalog.tsv` — one current row per surfaced work; status
  vocabulary `included` (646, with abstract-level primary-focus
  facets), `excluded` (634, coded screening memory), `parked`
  (12, undecidable now, re-screened each update)
- `sources/` — evidence notes for the 25 deep-read works
- `updates/` — registered queries (`queries.tsv`), their last
  reconciled executions (`state.tsv`), and periodic tasks
  (`tasks.tsv`); stage an update with the shared tool
  (`python3 skills/run-survey/scripts/update.py --record
  surveys/agent-assisted-review-methodology/record fetch --all`)
- `scripts/check.py` — structural checks and mechanically derived
  quantities

## Scope and status

- **Subject:** AI-assisted and automated methods, systems, evaluations,
  benchmarks, and guidance for secondary studies (systematic reviews,
  maps, and related evidence syntheses). The search was motivated by
  LLMs and agents but its model-side vocabulary also admitted generic
  automation, artificial intelligence, machine learning, deep learning,
  and neural methods. The map therefore includes some narrow-ML lineage
  and is not an LLM-only denominator.
- **Window searched:** 2020-01-01 through 2026-08-08, English only.
  Earlier lineage enters through existing reviews. A few 2020–2022
  primary automation studies and the 2022 RobotReviewer RCT entered
  through the broad vocabulary; this was not a comprehensive search of
  pre-LLM primary research.
- **Genre:** exploratory systematic map. Relevance-sorted searches were
  capped at 50 results, one of 11 logical queries never succeeded, and
  the single snowball wave was not iterated to saturation. Counts
  describe this retained catalog, not the complete literature.
- **Evidence status:** the map facets are single-pass abstract-level
  coding, not risk-of-bias or certainty assessments. The evidence notes
  are authoritative for the 25 deep reads and may disagree with their
  map rows.

## Integrity ledger

The campaign closed with 1,291 identifier rows and 672 included rows.
The 2026-08-08 adversarial review resolved 24 duplicate/version aliases
to their versions of record and moved two formally retracted works to
E7. One later journal publication (Madeyski et al.) added a canonical
DOI while retaining its arXiv identifier as E6 memory, so the retained
ledger now has 1,292 identifier rows: 646 included, 634 excluded,
and 12 parked.

Mechanical normalized-title grouping now leaves one apparent collision:
`10.1016/j.jclinepi.2025.111894` is the Stage I protocol and
`10.1016/j.jclinepi.2025.112102` is the distinct Stage II results paper.
Both are intentionally included. `check.py` verifies key uniqueness and
the current marginals; this paragraph records the only known display-
title collision.

Historical phase counts below are retained aggregates: the pruned record
does not contain candidate-level wave/source provenance and cannot
regenerate them. Current catalog and facet counts are mechanical.

| Event | Candidate rows | Included rows | Notes |
|---|---:|---:|---|
| Successful initial searches | 471 result rows | — | 419 unique before arXiv–DOI merging |
| Initial dedup | 412 | — | seven merged rows |
| Dual-pass screen + adjudication | 412 | 139 | historical aggregate |
| Snowball retrieval | 1,204 new | — | from 139 seeds; historical aggregate |
| Vocabulary pre-screen | 881 passed | — | 323 uncataloged rejects |
| Wave-2 screen + verification | 879 added | 533 | two of 881 merged on catalog entry |
| Campaign close | 1,291 | 672 | before integrity correction |
| Integrity correction | 1,292 | 646 | 24 aliases resolved, two retractions removed, one later publication migrated; 12 rows remain parked |

For every future update, append a row to this ledger. It is the retained
provenance for future funnel changes.

| Date | Prior cutoff | New cutoff | Qids succeeded / failed | Raw results | Unique new | Prefilter rejects | Screened | U | Aliases | Included | Human gate |
|---|---|---|---|---:|---:|---:|---:|---:|---:|---:|---|

## Search procedure

The 13 `search` rows in `log.tsv` are 11 logical qids plus retries. Initial
qid `s22` failed once and then succeeded; `s23` failed twice and never
succeeded. The successful initial requests returned 471 result rows.

On update:

1. Run one request for each distinct qid, using its last query text and
   the source template below. Do not replay historical FAILED rows as
   separate queries.
2. Use an overlap start one calendar year before the previous cutoff and
   a new explicit upper cutoff. Post-filter every source to
   `overlap_start <= publication_date <= new_cutoff`; arXiv requires this
   locally because its template has no date parameter. The overlap catches
   delayed indexing and is absorbed by identifier/title deduplication.
3. A request gets at most three attempts, separated by 10 and 30 seconds.
   Append one log row per attempt with the same qid/date. A terminal
   failure is `FAILED:<HTTP/status reason>` and is disclosed in the wave
   ledger and manuscript limitations; it is never counted as a successful
   query.
4. Retain the 50-result, relevance-sorted cap unless an update chooses and
   records a different limit. The cap is a coverage limitation, not a claim
   of saturation.

- OpenAlex: `api.openalex.org/works?filter=title_and_abstract.search:<q>,from_publication_date:<start>,to_publication_date:<end>&per-page=50&sort=relevance_score:desc`
- Semantic Scholar: `api.semanticscholar.org/graph/v1/paper/search?query=<q>&year=<startyear>-<endyear>&limit=50&fields=title,year,venue,abstract,externalIds,url`
- Crossref: `api.crossref.org/works?query.bibliographic=<q>&filter=from-pub-date:<start>,until-pub-date:<end>&rows=50&select=DOI,title,issued,container-title,abstract`
- arXiv: `export.arxiv.org/api/query?search_query=<q>&start=0&max_results=50&sortBy=relevance` followed by the exact local date post-filter

The shared fetchers in `skills/run-survey/scripts/` implement these
templates, and the snowball procedure below is codified there as
`snowball_openalex.py`; the parameters above remain the record of
what was run.

## Key and version rules

Canonical keys are lowercase `doi:<doi>` or `arxiv:<id>`; use
`t:<title-slug>` only when neither exists. Normalize as follows:

1. Strip `https://doi.org/`, `http://dx.doi.org/`, and bare `doi:` from a
   DOI, percent-decode it, trim whitespace, and lowercase it.
2. Collapse `https://arxiv.org/abs/<id>`, `arxiv:<id>`, and arXiv-issued
   DOI forms to `arxiv:<id>`; strip a trailing version suffix (`vN`).
3. For a `t:` fallback, Unicode-NFKD normalize the full title, drop
   combining marks, lowercase, keep only ASCII alphanumerics, and truncate
   to 80 characters.
4. `legacy:` is reserved for an already-retained malformed historical
   alias whose identity cannot be represented without colliding with its
   canonical row; never mint it for a new candidate.

Examples: `https://doi.org/10.2196/48996` → `doi:10.2196/48996`;
`https://arxiv.org/abs/2310.17526v2` → `arxiv:2310.17526`.

Deduplicate a new candidate by exact key against both TSVs. Then compare
its full normalized title to included display prefixes. Because 529 of
the original display titles were truncated at 70 characters, a prefix
match is a candidate match, not proof: resolve the stored DOI/arXiv key
through its registrar, compare full normalized titles and authors, and
adjudicate ambiguous pairs. Exclusions are deduplicated by exact key;
their version aliases are explicitly retained as E6. When a published
version replaces an included preprint, replace the included key and add
the superseded identifier as an excluded catalog row with code E6.

For a candidate matching a retained `t:` row, compare its normalized full
title with both the stored slug and display prefix, then adjudicate from
the candidate's authors, year, and venue. If those metadata do not
establish identity, keep the records separate or park the candidate as U.

## Snowball procedure

Resolve each included seed to an OpenAlex work. For a DOI use
`GET /works/https://doi.org/<doi>`. For an arXiv-only seed, search its
full title, then accept only an exact normalized-title and year match;
ambiguous seeds are logged and skipped rather than guessed.

For each resolved OpenAlex ID:

- backward candidates are the work object's complete
  `referenced_works` list;
- forward candidates come from
  `GET /works?filter=cites:<OpenAlexID>&per-page=200&cursor=*`, following
  `meta.next_cursor` until empty;
- request/retain `id,doi,title,publication_year,abstract_inverted_index,
  referenced_works`; fetch referenced-work IDs directly as needed;
- deduplicate by the key/title rules above before counting a candidate.

Apply the case-insensitive title vocabulary
`review|screening|synthesis|extraction|meta-analys|survey|systematic|evidence|literature|prisma|appraisal`.
Then test the reconstructed title plus abstract against
`large language model|language model|\bllm|gpt|agent|automat|artificial intelligence|machine learning|deep learning|neural`.
If the abstract is missing, test the title alone and send a vocabulary
miss to `parked` rather than silently discarding it. Count title-filter rejects,
model-vocabulary rejects, missing-data parked rows, merges, screened rows, and
includes in the update ledger. Run one backward+forward round from new
includes and a verification pass over everything it screens in.

The initial wave used the same title vocabulary, but its exact model-side
list was not retained; its 323 uncataloged prefilter rejects and other
phase quantities are therefore historical aggregates, not reproducible
candidate-level facts.

## Selection and screening

- **Include:** a peer-reviewed work or preprint whose subject matches the
  scope above.
- **Exclude:**
  - E1 — primary-research automation only
  - E2 — generic NLP/RAG without evidence-synthesis framing
  - E3 — opinion without actionable guidance
  - E4 — before the searched window
  - E5 — insufficient accessible metadata to determine subject after
    identifier, landing-page, and abstract checks
  - E6 — duplicate or superseded identifier/version
  - E7 — retracted or withdrawn
  - U — enough metadata to understand the work, but the scope decision is
    genuinely ambiguous; re-screen every U row on update

Boundary examples: a literature-QA system with no secondary-study framing
is E2; prompt advice for generic paper summarization is E2; an LLM
screening titles/abstracts for a systematic review is included. A closed
paper with an informative abstract can be included and deep-read as
abstract-only; E5 is for records lacking enough metadata even to decide
scope. A method spanning evidence review and primary hypothesis generation
is E1 when the primary-research product is its central contribution; use U
when that priority cannot be decided from the available abstract.

Each pass receives the full available title, abstract, year, venue, and
identifier. Pass A uses an eligibility-first framing: identify positive
evidence that the work contributes to a secondary-study stage, otherwise
return the best E-code. Pass B uses an exclusion-first framing: attempt to
prove E1–E5, otherwise include. Both return JSON
`{"decision":"include|E1|E2|E3|E4|E5|U","reason":"one sentence","confidence":"high|medium|low"}`.
Use different model tiers/vendors when available. The adjudicator sees the
candidate and both outputs, resolves disagreements, and emits the same
schema. The human gate reviews counts, all disagreements, every U, and a
random sample of agreements; record its approval in the update ledger.

## Taxonomy and coding

Every row carries one abstract-level primary-focus value per dimension.
These are descriptive labels, not quality or certainty judgments.

- **Stage:** `meta` if the work is about the review process/field rather
  than performing an operational stage; `end2end` only if it substantively
  implements at least four of search, screen, extract, appraise, synthesize,
  report; otherwise use the stage named by the primary objective or main
  evaluation endpoint. If two stages are co-primary and the abstract
  cannot break the tie, use U pending a deep read.
- **Contribution:** `evaluation` for a primarily comparative empirical
  assessment; otherwise `guideline` for prescriptive conduct/reporting,
  `system` for a released/integrated tool, `method` for a technique or
  algorithm, and `position` for an argument or agenda. Code the primary
  contribution, not every component.
- **Evidence:** `human-agree` when outputs are compared with human or
  human-derived reference labels; otherwise `benchmark` for a nonhuman
  benchmark and `none` when neither appears. Precedence is
  `human-agree > benchmark > none`.
- **Setting:** `med` for healthcare/biomedical review corpora, `se` for
  software-engineering secondary studies, and `general` for cross-domain
  or domain-independent work. Venue alone never determines setting.

The allowed tokens are: stage
`search|screen|extract|appraise|synthesize|report|end2end|meta`;
contribution `method|system|evaluation|guideline|position`; evidence
`human-agree|benchmark|none`; setting `med|se|general`.

## Evidence notes and reading list

Evidence notes use this compact contract:

```yaml
---
citekey: <filename stem>
work:
  title: <version read>
  author: <authors>
  venue: <optional>
  date: <year or date>
  doi: <optional>
  arxiv: <optional>
read: full-text | abstract-only
source: <shadow path when captured; otherwise public URL, acquisition note, or "none">
facets: <assessed note-level facets; may be partial>
retrieved: YYYY-MM-DD
notes-by: <writer; preserve prior writers and append material revisers separated by semicolons>
notes-date: YYYY-MM-DD
synthesis: <one-line take>
---

# Title

## Evidence
## Bearing on RQs
## Evidence limits
```

Note-level full-text facets are authoritative for that work but do not
silently rewrite the abstract-coded map; disclose disagreements. The
landing-page reading list is curated, not exhaustive: the strongest
evidence, defining system, or guidance anchor for each taxonomy section.
Deep-read does not imply listed (25 read, 23 listed). Every annotation
carries abstract-only, preprint, adjudication, and author-benchmark caveats
that qualify its claim.

## Bibliography and build

Add an anchor's canonical identifier to `../manuscript/references.tsv`,
then run from the repository root:

```sh
./dev.sh python3 surveys/agent-assisted-review-methodology/manuscript/make-references.py
./dev.sh python3 site/scripts/build-manuscripts.py
```

`make-references.py` validates duplicate keys/identifiers, accepts a
same-key fallback in `references-manual.bib`, and replaces
`references.bib` atomically only after every entry resolves. On any
failure it leaves the prior bibliography untouched. The build writes
`site/public/surveys/agent-assisted-review-methodology/manuscript.html`
and `.pdf`.

## Update and close checklist

1. Choose the new cutoff; execute the search and snowball procedures;
   append request attempts and the update-ledger row.
2. Deduplicate, screen, adjudicate, and human-gate; update the catalog and
   re-screen all 12 current parked rows.
3. Apply the taxonomy decision rules; deep-read new anchor candidates,
   preserving and appending `notes-by` attribution on material revisions.
4. Update the curated list, manuscript prose, historical/current funnel,
   abstract, limitations, and draft date wherever the derived report or
   findings changed.
5. Run `python3 surveys/agent-assisted-review-methodology/record/scripts/check.py`.
   Reconcile its catalog, exclusion-code, facet, note, curation, and
   citation totals against this README, `../index.md`,
   `../manuscript/meta.typ`, and every table/quantity in
   `../manuscript/content.typ`.
6. Regenerate the bibliography and build both manuscript formats using
   the commands above. Check citation closure, HTML anchors, PDF/HTML
   links, and `git diff --check`.
7. Bump the search window and draft date only after all checks pass; log
   the human gate and describe any material method change.
