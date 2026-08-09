# Survey record

The minimal resumable state of this survey. An agent redoing or
updating it needs this directory and the
[manuscript](https://qobilidop.github.io/sys0/surveys/agent-assisted-review-methodology/manuscript.html)
(taxonomy in §3; method sketch in §4). Process history lives in git
and the private shadow mirror; none of it is needed to resume.

- `searches.tsv` — the queries run, verbatim, with dates and yields
- `included.tsv` — the 672 included works with taxonomy facets
- `excluded.tsv` — screening memory: excluded keys with codes
- `sources/` — evidence notes for the 25 deep-read anchor works

## Scope

- **Subject:** methods, systems, evaluations, benchmarks, and
  guidance for automating or assisting the stages of secondary
  studies (systematic reviews, maps, and related evidence syntheses)
  with LLMs or agents.
- **Window searched:** 2020-01-01 through 2026-08-08. Pre-LLM lineage
  enters as background via its existing reviews, not re-screened
  primary studies.
- **Sources:** OpenAlex, Crossref, Semantic Scholar, arXiv. English
  only. Query families pair review-side vocabulary ("systematic
  review", "literature review", "evidence synthesis", "citation
  screening", "data extraction") with model-side vocabulary ("large
  language model", LLM, GPT, agent, automation), plus targeted probes
  for reporting guidance; exact strings in `searches.tsv`.

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
  - U — undecidable on available metadata (resolve before accepting)
- **Keys:** `<doi:...|arxiv:...>` normalized — arXiv-DOIs collapse to
  `arxiv:` ids, version suffixes stripped, lowercase — so the same
  work never enters twice.

## Classification and curation

- Classify every include on the four taxonomy dimensions defined in
  manuscript §3 (stage, contribution, evidence, setting); facets live
  in `included.tsv`.
- The landing-page reading list is curated, not exhaustive: works
  that anchor a taxonomy section — the strongest evidence, the
  defining system, or the guidance of record — each with a one-line
  annotation and a link to its evidence note in `sources/`.
- Evidence notes in `sources/` use the library note frontmatter
  (citekey, work metadata, `synthesis:` one-liner) with an extraction
  body (`## Evidence`, anchored to sections/tables of the work).

## To update

1. Rerun the `searches.tsv` query families with the window starting
   at the last search date; add any new targeted probes.
2. Deduplicate candidates against `included.tsv` and `excluded.tsv`
   by normalized key; screen only what is new.
3. Screen by the selection rules above; record new exclusions in
   `excluded.tsv`, new includes with facets in `included.tsv`.
4. Deep-read and write evidence notes for new anchor-grade works;
   add them to the reading list.
5. Update the manuscript where findings shift; regenerate the
   bibliography via `../manuscript/make-references.py` after adding
   identifiers to `../manuscript/references.tsv`; bump the draft
   date in `../manuscript/meta.typ`.
6. Bump this README's window date and work counts to match.
