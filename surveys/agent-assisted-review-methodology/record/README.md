# Survey record

The minimal resumable state of this survey. An agent redoing or
updating it needs this directory, the
[manuscript](https://qobilidop.github.io/sys0/surveys/agent-assisted-review-methodology/manuscript.html)
(taxonomy in §3; method sketch in §4), and the repo's build toolchain
(see "To rebuild"). Process history lives in git and the private
shadow mirror; none of it is needed to resume.

- `searches.tsv` — the queries run, verbatim, with dates and yields
- `included.tsv` — the 672 included works with taxonomy facets
  (`year` is the year at screening time; titles are display hints
  truncated at 70 chars — the bibliography carries the version of
  record)
- `excluded.tsv` — screening memory: excluded keys with codes
- `sources/` — evidence notes for the 25 deep-read works

## Scope

- **Subject:** methods, systems, evaluations, benchmarks, and
  guidance for automating or assisting the stages of secondary
  studies (systematic reviews, maps, and related evidence syntheses)
  with LLMs or agents.
- **Window searched:** 2020-01-01 through 2026-08-08. Pre-LLM lineage
  enters as background via its existing reviews, not re-screened
  primary studies.
- **Sources:** OpenAlex, Crossref, Semantic Scholar, arXiv. English
  only. The rows of `searches.tsv` are the query set — rerun them
  verbatim; they pair review-side vocabulary ("systematic review",
  "evidence synthesis", …) with model-side vocabulary ("large
  language model", LLM, GPT, agent, automation).

## Search parameters

Each query ran with a 50-result cap, relevance-sorted; yields overlap
across queries, and the harvest deduplicates rows by normalized key
(v1: 471 result rows → 419 unique records → 412 after arXiv–DOI
merging). In `searches.tsv`, a duplicate qid on the same date is a
retry and `FAILED:<reason>` rows record failed attempts (v1: qid s23
never succeeded). A query deviating from its source template logs
its full request URL in the query column.

- OpenAlex: `api.openalex.org/works?filter=title_and_abstract.search:<q>,from_publication_date:<start>&per-page=50&sort=relevance_score:desc`
- Semantic Scholar: `api.semanticscholar.org/graph/v1/paper/search?query=<q>&year=<startyear>-&limit=50&fields=title,year,venue,abstract,externalIds,url`
- Crossref: `api.crossref.org/works?query.bibliographic=<q>&filter=from-pub-date:<start>&rows=50&select=DOI,title,issued,container-title,abstract`
- arXiv: `export.arxiv.org/api/query?search_query=<q>&start=0&max_results=50&sortBy=relevance` (no date parameter; post-filter by year)

## Snowball

The search seeds a snowball round that contributed most of v1's
includes: from each include, fetch references and citing works via
OpenAlex; keep new candidates (deduplicated against the catalog)
whose titles match, case-insensitively,
`review|screening|synthesis|extraction|meta-analys|survey|systematic|evidence|literature|prisma|appraisal`;
pre-screen out candidates with no model-side vocabulary — v1's
exact list survived only in the session transcript; the go-forward
rule, set at v1.1, is the case-insensitive regex
`large language model|language model|\bllm|gpt|agent|automat|artificial intelligence|machine learning|deep learning|neural`
— then screen the rest and run a verification pass over everything
screened in.

## Selection

- **Include:** works (peer-reviewed or preprint) whose subject
  matches the scope above.
- **Exclude:**
  - E1 — primary-research automation only
  - E2 — generic NLP/RAG without evidence-synthesis framing
  - E3 — opinion without guidance content
  - E4 — pre-window
  - E5 — inaccessible
  - E6 — duplicate or superseded version
  - U — undecidable on available metadata; parked in `excluded.tsv`
    as screening memory and re-screened at each update
- **E2 boundary examples** (78% of v1 exclusions rode on this line):
  an LLM answering questions over medical literature with no review
  framing is E2; prompt techniques for summarizing papers outside any
  secondary-study workflow are E2; an LLM screening titles/abstracts
  for a specific systematic review, or an evaluation of that task, is
  in scope.
- **Pass structure:** two agent passes per candidate on different
  model tiers and prompt framings, disagreements adjudicated by the
  strongest available model; a single-pass wave is acceptable only
  with a verification pass over what it screens in; a human gates the
  result.
- **Keys:** `doi:<doi>` or `arxiv:<id>`, normalized — arXiv-DOIs
  collapse to `arxiv:` ids, version suffixes stripped, lowercase.
  Works with neither identifier get `t:<title-slug>` (lowercase,
  alphanumerics only, truncated at 80 chars). Also title-match new
  candidates against `included.tsv`: when the published version of an
  included preprint appears, replace the include's key with the
  published identifier and record the superseded key as E6 in
  `excluded.tsv`.

## Classification and curation

- Classify every include on the four taxonomy dimensions defined in
  manuscript §3; facets live in `included.tsv` using the short
  tokens: stage `search|screen|extract|appraise|synthesize|report|
  end2end|meta`; contribution `method|system|evaluation|guideline|
  position`; evidence `human-agree|benchmark|none`; setting
  `med|se|general`.
- The landing-page reading list is curated, not exhaustive: works
  that anchor a taxonomy section — the strongest evidence, the
  defining system, or the guidance of record — each with a one-line
  annotation and a link to its evidence note in `sources/`. Deep-read
  does not imply listed (v1 read 25, listed 23); sections stay small
  (two to six rows in v1), and a new anchor joins or displaces.
- Evidence notes in `sources/` use the library note frontmatter
  (citekey, work metadata, `synthesis:` one-liner) with an extraction
  body (`## Evidence`, anchored to sections/tables of the work).
  Note `source:` fields reference the private shadow tier; public
  verification goes through the work's DOI or arXiv link. Note
  facets come from full-text reads and may disagree with the
  abstract-level map in `included.tsv` — the note is authoritative
  for that work, but `included.tsv` is not silently corrected:
  genuine disagreements stand and are disclosed in the manuscript's
  limitations. Notes may omit facets the deep read did not assess.
  Bibliography keys in `../manuscript/` are the author-year prefixes
  of note citekeys.

## To update

1. Rerun the `searches.tsv` queries verbatim (parameters above) with
   the window start advanced to the last search date (templates are
   date- or year-granular; overlap is expected and absorbed by
   dedup).
2. Deduplicate candidates against `included.tsv` and `excluded.tsv`
   by normalized key and by title; screen only what is new, plus the
   parked `U` rows.
3. Screen by the selection rules above; record new exclusions in
   `excluded.tsv`, new includes with facets in `included.tsv`.
4. Snowball from the new includes (one round, as specified above);
   screen, verify, and record its yield the same way.
5. Deep-read and write evidence notes for new anchor-grade works;
   add them to the reading list.
6. Update the manuscript where findings shift; regenerate the
   bibliography via `../manuscript/make-references.py` after adding
   identifiers to `../manuscript/references.tsv`; bump the draft
   date in `../manuscript/meta.typ`.
7. Bump the window date and work counts here and in `../index.md`.

## To rebuild

`site/scripts/build-manuscripts.py` (repo root) compiles
`../manuscript/manuscript.typ` → `manuscript.pdf` and
`../manuscript/manuscript-html.typ` → `manuscript.html` into
`site/public/surveys/<slug>/`; run it as
`./dev.sh python3 site/scripts/build-manuscripts.py` (typst is
pinned in the dev image). `manuscript.typ` imports the shared
`surveys/style.typ`, outside this directory. Pushing to `main`
rebuilds and deploys the same way in CI.
