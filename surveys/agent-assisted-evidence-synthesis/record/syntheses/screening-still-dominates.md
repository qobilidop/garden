# Screening still dominates; the empty categories moved

Status: current through the 2026-08-09 update batch.

## Current conclusion

The LLM era did not redistribute attention across the review pipeline;
it thickened the same skew while opening categories that were empty
before. Screening is the modal primary focus in both generations —
leading step in the 2006–2020 corpus, 256 of 776 rows (33%) in this
map — and appraisal and reporting are the thinnest in both. What is
genuinely new is the existence, not the size, of two categories:
end-to-end systems (96 rows) and guideline/norms contributions (47
rows), both absent from the pre-LLM corpus. The map's
medicine-heaviness (463 medicine vs 23 SE rows) is a fact about this
retained coding, not a widening-adoption-gap measurement.

The 2026-08-09 update grew the include-level map from 646 to 776 rows
(1,975 catalog rows screened) and changed none of the above. That is
the update's whole result here, and it is weaker than it looks: see
the next section for what an unchanged ordering does and does not
license. One claim in the previous version is retracted — the SE ×
guideline cell is no longer empty.

## What the proportional update does and does not show

Recomputed from `../catalog.tsv` (2026-08-09), old → new at
include level, corpus +20.1% (646 → 776):

- Stage: screen 216 → 256 (+18.5%), meta 107 → 134 (+25.2%),
  extract 107 → 121 (+13.1%), end-to-end 85 → 96 (+12.9%), search
  48 → 64 (+33.3%), synthesize 36 → 49 (+36.1%), appraise 25 → 33
  (+32.0%), report 22 → 23 (+4.5%).
- Contribution: evaluation 324 → 363 (+12.0%), method 127 → 171
  (+34.6%), system 105 → 132 (+25.7%), position 56 → 63 (+12.5%),
  guideline 34 → 47 (+38.2%).
- Evidence: none 245 → 315 (+28.6%), human-agree 249 → 303 (+21.7%),
  benchmark 152 → 158 (+3.9%).
- Setting: med 394 → 463 (+17.5%), general 235 → 290 (+23.4%), se
  17 → 23 (+35.3%).

Every rank order is unchanged except one: extract and meta were tied
at 107 and the tie broke toward meta (134 vs 121). Meta is not a
pipeline stage — it counts surveys and maps *about* the field — so no
pipeline claim moves with it.

The temptation is to read guideline's +38% as the update's signal. It
does not survive inspection. In absolute terms it is 13 rows, against
method's 44; three other cells grew at comparable rates from small
bases (synthesize +36%, se +35%, search +33%, appraise +32%), which is
what small denominators do. Nothing distinguishes guideline's move
from sampling noise in a corpus that grew 20%.

More to the point, the new rows are not a random enlargement. They
came from three genre-gap query families added this batch (systematic
mapping, scoping review, living evidence), from citation chases off
existing deep-read seeds, and from re-screening parked rows —
i.e. from where the campaign chose to look. Cell-level growth rates
therefore measure search direction at least as much as they measure
the field, and no growth rate in the list above should be cited as a
trend. What the update does establish is narrower and worth stating
plainly: a 20%-larger corpus, retrieved partly under new vocabulary,
reproduced the same shape. That raises the row count each claim rests
on; it does not make the claims more independent, because the same
single-pass coder applied the same eight-value facet to all of them.

The one directional change worth flagging is in the evidence facet:
`benchmark` grew 3.9% while `none` grew 28.6%, so the added works
are disproportionately ones with no reported comparison at all
(315 of 776, 40.6%, up from 37.9%). That is a fact about what the
new queries surfaced — position pieces, guidance, and meta-literature
under the genre-gap vocabulary — and it is carried in
`reliability-is-mismeasured.md`, where the evidence facet is
load-bearing.

## The two skews compared

Pre-LLM (vandinter2021; 41 automation studies, 2006–2020, SE and
medicine venues only): every study automates a conducting-the-review
step; zero automate planning or reporting. Within conducting,
screening (SLR6) leads, search-query formulation (SLR5) is second,
extraction n=5, appraisal n=1. Exactly one study uses deep learning.
napoleao2021 (66 studies, 33 SE / 33 medicine, through Dec 2020) adds
the adoption dimension: 8 practice-adopted screening tools in medicine
vs 2 in SE, and WSS@95% used in 11 medicine studies vs 1 SE study —
the maturity gap was in evaluation practice as well as tooling.

This map (single-pass abstract coding of 776 works, 2020–2026):
screening 256, meta 134, extraction 121, end-to-end 96, search 64,
synthesis 49, appraisal 33, reporting 23. By contribution:
evaluation/benchmark 363, method 171, system/tool 132, position 63,
guideline 47.

The comparison is directional, not quantitative: the two corpora were
built by different searches, different taxonomies (Kitchenham's 12
steps vs this survey's 8-value stage facet), and different screening
depths. What survives the incommensurability is the shape: screening
first, appraisal/reporting last, in both generations — and the
transition of appraisal (1 → 33), reporting (0 → 23), end-to-end
(0 → 96), and guidelines (0 → 47) from empty to small. The 2026-08-09
update moved all four counts upward without moving the contrast: the
pre-LLM corpus still has zero rows in three of these four categories,
and reporting remains the smallest category in both generations (0
there, 23 here), with appraisal next (1 there, 33 here). The contrast
holds as stated; it is not now better evidenced, only counted over
more rows.

## Within the new categories, thinness persists

- End-to-end exists but is not uniformly strong: huang2026
  (MedSR-Copilot; preprint, author-built benchmark, author-run
  baselines) reports 63.6% end-to-end conclusion accuracy vs 45.3%
  best baseline, while its own screening F1 is about 0.44–0.51 — an
  "end-to-end" label resting on a weak middle stage. Its ablations
  attribute −14.9 pp to removing two-stage extraction, −7.6 pp to
  removing tournament reranking, and −3.3 pp to removing retrieval
  augmentation; human review and redundancy were not ablated.
- The update end of the pipeline is nearly untouched even inside its
  own niche: song2026's living-evidence inventory finds 1 of 34 tools
  serving the publication-update phase (RobotReviewer LIVE, also the
  only tool spanning all four phases), with the authors' own caveat
  that their "living evidence" search vocabulary may undercount that
  phase.
- **Retracted this batch.** The previous version stated that no
  included row is jointly coded SE + guideline. One now is:
  doi:10.1145/3786149.3788298 (2026), a practitioner's brief report on
  using an LLM to support a systematic mapping study, coded
  `stage=end2end`, `contribution=guideline`, `evidence=none`,
  `setting=se`. The corrected claim is weaker but still pointed: SE
  (23 rows) has exactly one guideline-coded row in this map, and it is
  an experience report rather than an instrument or a norms proposal —
  so the surviving finding is that no SE-native *instrument* appears
  here, not that the cell is empty. SE × appraise remains empty (0 of
  33 appraisal rows).
- The appraisal stage grew (25 → 33 rows) without its evidence base
  growing. Two of the batch's appraisal deep reads illustrate why the
  count is the wrong measure: hirt2021 is abstract-only and rose2025 is
  a protocol with zero results. See `reliability-is-mismeasured.md` —
  arno2022 remains the only RCT-grade appraisal-automation study in the
  set. Stage counts track publication volume, not evidential weight,
  and this cell is where the two diverge most.

## Taxonomies disagree about what the stages are

The survey's 6-stage vocabulary (+ end-to-end, meta) is one of at
least three live decompositions among the deep reads: luo2024 uses 9
stages (splitting question formulation, registration, criteria, and
search strategy; adding submission/publication), and song2026 uses 4
living-evidence phases (its phase 4, publication update, has no
counterpart in Kitchenham's steps). Stage-count claims are therefore
taxonomy-relative; the survey's counts cannot be directly compared
against either without re-coding.

## Scope conditions

- Single-pass coding from truncated abstracts (600–900 chars),
  unvalidated labels; full-text notes disagree with abstract-level
  facets for 9 of 31 deep reads (the batch added six reads, one of
  which — rose2025 — flags a disagreement). The map is as coded; notes
  are authoritative for those works. The proportion is essentially
  flat (32% → 29%), which is the relevant point: the update did not
  improve the coding's reliability, it extended it.
- The search was LLM-motivated but admitted the broader AI/ML lineage;
  it is neither LLM-only nor a comprehensive pre-LLM search, so
  cross-generation counts mix retrieval regimes.
- The 2026-08-09 growth is query-directed (three new genre-gap
  vocabularies, seed-anchored citation chases, parked re-screening),
  not a random enlargement; per-cell growth rates are not prevalence
  trends.
- napoleao2021 measured practice adoption; this map measures
  publication volume. 463-vs-23 does not show the Napoleão adoption
  gap widened.

## Consequences for the manuscript

The manuscript's RQ1 section states the skew, the new categories, and
the incommensurability caveat, and this synthesis supports all three —
the argument is unchanged, the arithmetic is not. Required edits:

1. `@tab-map` (05-rq1.typ) must be rebuilt at 776 rows. Recomputed
   stage × setting × evidence, in the table's own row order —
   Search 32/2/30 = 64, hum 15, bench 19, none 30; Screen
   153/10/93 = 256, 141/64/51; Extract 90/2/29 = 121, 61/39/21;
   Appraise 30/0/3 = 33, 21/5/7; Synthesize 25/2/22 = 49, 14/9/26;
   Report 12/3/8 = 23, 9/4/10; End-to-end 54/2/40 = 96, 32/10/54;
   Meta 67/2/65 = 134, 10/8/116; Total 463/23/290 = 776, 303/158/315.
2. Prose in 05-rq1.typ: "216 of 646" → "256 of 776"; reporting (22) →
   (23); appraisal (25) → (33); "34 guideline-contribution works and
   85 end-to-end rows" → 47 and 96; contribution list 324/127/105/56/34
   → 363/171/132/63/47; "394 works to medicine and 17 to software
   engineering" → 463 and 23.
3. 05-rq1.typ must retract "No included row is jointly coded
   `setting=se` and `contribution=guideline`." Replacement claim: one
   such row exists (a practitioner experience report); SE contributes
   no norms *instrument* to this map, and SE × appraise is still empty.
4. 09-discussion.typ threat rows: "216 of 646" → "256 of 776";
   "medicine-heavy (394 rows)" → (463 rows).
5. 04-method.typ / 01-introduction.typ: the "646 works" corpus figure
   and the integrity-correction table row must move to 776 (1,975
   catalog rows screened). This synthesis does not own the method
   section's provenance narrative; it only flags the dependency.
6. Limitations: "8 of 25 deep reads" → "9 of 31" (claims.md carries
   the same figure and must move with it).
7. Nothing in RQ1 should present the update's per-cell growth rates as
   findings. If the manuscript mentions the update at all, the
   defensible sentence is that a 20%-larger, partly re-vocabularied
   corpus reproduced the same ordering.

The manuscript prints only the largest and smallest huang2026
ablations (−14.9, −3.3); the middle value (−7.6, tournament reranking)
is in the note and kept here.

## What would change this

- A population-representative or dual-pass-validated re-coding of the
  map (the single-pass facet labels are the finding's weakest link,
  and the 2026-08-09 update did nothing to strengthen it).
- A pre-LLM corpus re-coded under this survey's own scheme, making the
  two-generation comparison quantitative instead of directional.
- Evidence of a substantial appraisal/reporting/update literature
  under vocabulary this campaign's queries missed. The batch is a
  partial test of this and a partial confirmation of the mechanism:
  three new genre-gap vocabularies were added, appraisal grew 32% and
  search 33%, and the ordering still did not move — but the same
  batch's targeted growth shows how directly query vocabulary drives
  cell size (song2026's terminology caveat generalizes: stage names
  gate retrieval).
- An SE-native norms instrument, or a second SE guideline row that is
  not an experience report — the retracted-cell claim above is now
  resting on a single row's genre.
- Independent replication of huang2026, or a second end-to-end system
  with strong per-stage numbers, which would change "end-to-end exists
  but is thin" to "end-to-end works." The end-to-end cell grew to 96
  rows this batch without adding such a system to the deep reads.
