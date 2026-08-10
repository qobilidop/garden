# Screening remains the largest map category

## Current conclusion

Single-pass primary-focus coding assigns 256 of 776 include-level works to
screening. Appraisal (33) and reporting (23) are the smallest operational
categories. This resembles the conducting-the-review skew in the selected
pre-LLM baseline, while the present map also contains 96 end-to-end works and
47 guideline contributions.

The comparison is descriptive. It does not show that screening is the most
common practice worldwide, that underrepresented stages are neglected in
practice, or that any stage grew faster over time.

## Current map

| Stage | Medicine | SE | General | Total | Human agreement | Benchmark | None |
|---|---:|---:|---:|---:|---:|---:|---:|
| Search | 32 | 2 | 30 | 64 | 15 | 19 | 30 |
| Screen | 153 | 10 | 93 | 256 | 141 | 64 | 51 |
| Extract | 90 | 2 | 29 | 121 | 61 | 39 | 21 |
| Appraise | 30 | 0 | 3 | 33 | 21 | 5 | 7 |
| Synthesize | 25 | 2 | 22 | 49 | 14 | 9 | 26 |
| Report | 12 | 3 | 8 | 23 | 9 | 4 | 10 |
| End-to-end | 54 | 2 | 40 | 96 | 32 | 10 | 54 |
| Meta | 67 | 2 | 65 | 134 | 10 | 8 | 116 |
| **Total** | **463** | **23** | **290** | **776** | **303** | **158** | **315** |

`meta` is not an operational stage. The evidence columns record whether an
abstract describes a human/reference-label comparison, a nonhuman benchmark,
or neither; they are not quality ratings. At least one protocol is coded
`human-agree` for a planned comparison that has not yet occurred, showing why
the facet cannot be read as empirical evidence.

## Comparison with established maps

van Dinter et al. (`vandinter2021`) reviewed 41 automation studies from
2006–2020 and placed all of them in Kitchenham's conducting phase. Screening
was dominant, study-quality assessment appeared once, extraction five times,
and planning/reporting not at all. Napoleão et al. (`napoleao2021`) found eight
practice-adopted screening tools in medicine and two in software engineering.
Those searches and units differ from this map, so only the broad skew is
comparable.

The current map differs in two visible ways:

- end-to-end systems and guideline contributions are now populated categories;
- the evidence-synthesis umbrella admits mapping, scoping, rapid, and living
  review work as well as systematic reviews.

Song et al. (`song2026`) independently show how terminology affects a thin
category: one of 34 tools in their living-evidence inventory served the
publication-update phase, and the authors warn that their own search vocabulary
may undercount it.

## Scope and limitations

- The map is relevance-capped, English-only, and not saturation-iterated.
- Facets were assigned once from truncated abstracts and were not validated.
- The search is medicine-heavy (463 rows) and has only 23 SE rows.
- Search vocabulary and critical-work chases shape cell sizes; differences
  between retained batches are not field-growth estimates.
- Full-text note facets disagree with some abstract-level map assignments. The
  notes are authoritative for those works, but the original map remains as
  coded and the disagreement is disclosed.

## Consequence for presentation

Print exact counts as properties of the retained map. Pair the pre-LLM baseline
with its own search scope, keep `meta` outside any pipeline-stage ranking, and
never convert the medicine/SE imbalance into an adoption claim.
