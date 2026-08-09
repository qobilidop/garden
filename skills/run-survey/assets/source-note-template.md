# Source-note contract

The one note template for every survey's `record/sources/`. A survey
declares deviations (extra frontmatter fields, omitted optional
fields) in its record README's Shape note; the record validator
enforces the contract.

```markdown
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
facets: <assessed note-level facets; may be partial; omit when the survey keeps facets in the catalog only>
retrieved: YYYY-MM-DD
notes-by: <writer (phase); preserve prior writers, append material revisers, "; "-separated, chronological; a fan-out fleet is named by tier, e.g. "Claude Sonnet-class (survey deep-read pipeline)">
notes-date: YYYY-MM-DD
synthesis: <one-line take>
---

# Title

## Evidence

## Bearing on RQs

## Evidence limits
```

- `## Evidence` holds extracted findings anchored to sections,
  tables, theorems, or pages of the primary work. A dense note (a
  theory-mode deep read) may structure it with `###` subsections
  (definitions, results and guarantees, complexity, evidence
  locations); evidence records may anchor to any heading level.
- `## Bearing on RQs` relates the work to the survey's research
  questions — for theory-mode surveys, including whether the work
  subsumes or specializes the survey's target contract.
- `## Evidence limits` bounds what the note's evidence can support
  (version read, abstract-only caveats, benchmark provenance,
  unproved claims) — limits of the evidence, not general critique.
- At least one of `work.doi` / `work.arxiv` / `source` must locate
  the version read. `retrieved` may be `-` when the acquisition date
  was not recorded (historical migrations, declared in the README).
