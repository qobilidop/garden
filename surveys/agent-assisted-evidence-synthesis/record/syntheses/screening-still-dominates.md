# Screening still dominates; the empty categories moved

Status: current through the 2026-08-08 baseline.

## Current conclusion

The LLM era did not redistribute attention across the review pipeline;
it thickened the same skew while opening categories that were empty
before. Screening is the modal primary focus in both generations —
leading step in the 2006–2020 corpus, 216 of 646 rows (about a third)
in this map — and appraisal and reporting are the thinnest in both.
What is genuinely new is the existence, not the size, of two
categories: end-to-end systems (85 rows) and guideline/norms
contributions (34 rows), both absent from the pre-LLM corpus. The
map's medicine-heaviness (394 medicine vs 17 SE rows) is a fact about
this retained coding, not a widening-adoption-gap measurement.

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

This map (single-pass abstract coding of 646 works, 2020–2026):
screening 216, extraction 107, meta 107, end-to-end 85, search 48,
synthesis 36, appraisal 25, reporting 22. By contribution:
evaluation/benchmark 324, method 127, system/tool 105, position 56,
guideline 34.

The comparison is directional, not quantitative: the two corpora were
built by different searches, different taxonomies (Kitchenham's 12
steps vs this survey's 8-value stage facet), and different screening
depths. What survives the incommensurability is the shape: screening
first, appraisal/reporting last, in both generations — and the
transition of appraisal (1 → 25), reporting (0 → 22), end-to-end
(0 → 85), and guidelines (0 → 34) from empty to small.

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
- No included row is jointly coded SE + guideline; the SE setting
  (17 rows) has essentially no norms literature of its own in this map.

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
  facets for 8 of 25 deep reads. The map is as coded; notes are
  authoritative for those works.
- The search was LLM-motivated but admitted the broader AI/ML lineage;
  it is neither LLM-only nor a comprehensive pre-LLM search, so
  cross-generation counts mix retrieval regimes.
- napoleao2021 measured practice adoption; this map measures
  publication volume. 394-vs-17 does not show the Napoleão adoption
  gap widened.

## Consequences for the manuscript

The manuscript's RQ1 section states the skew, the new categories, and
the incommensurability caveat, and this synthesis supports all three.
The manuscript prints only the largest and smallest huang2026
ablations (−14.9, −3.3); the middle value (−7.6, tournament reranking)
is in the note and kept here.

## What would change this

- A population-representative or dual-pass-validated re-coding of the
  map (the single-pass facet labels are the finding's weakest link).
- A pre-LLM corpus re-coded under this survey's own scheme, making the
  two-generation comparison quantitative instead of directional.
- Evidence of a substantial appraisal/reporting/update literature
  under vocabulary this campaign's queries missed (song2026's
  terminology caveat generalizes: stage names gate retrieval).
- Independent replication of huang2026, or a second end-to-end system
  with strong per-stage numbers, which would change "end-to-end exists
  but is thin" to "end-to-end works."
