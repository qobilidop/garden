= RQ4 — Independence: an exploratory deep-read gap <sec-rq4>

The 25 selected deep reads contain two designed multi-model or
human–model comparisons, two indirect signals, and one system with no
redundancy. This is an exploratory subset, not an exhaustively searched
class:

- A cross-vendor OR ensemble (GPT-5 Thinking + Gemini 2.5 Pro, two runs
  each, 736 Cochrane citations) reached 99.7% sensitivity and 49.3%
  specificity on the authors' adjudicated labels; against the original
  Cochrane labels its sensitivity was 94.0–94.5% @fagerberg2025. The
  preprint's post-hoc vaccine subgroup had seven positives: GPT-5
  sensitivity was 43% while Gemini flagged the same ambiguous records.
  The design has no matched same-family arm and does not isolate model
  family, model identity, duplicate runs, and the OR rule as causes.
- A 9-run consistency ensemble reached human-level appraisal accuracy
  only on items surviving near-unanimous agreement, deferring 74–88%
  of items; the _deferral_ design — human + LLM score, send
  disagreements to a second human — beat both humans-alone and
  ensembles at 95–96% accuracy while sparing \~65–70% of
  second-reviewer item count on the two easier retrospective appraisal
  instruments; on PRECIS-2 it reached 80–86% while sparing about 29%
  @woelfle2024. The reference was two-rater consensus, prompts differed
  by model, and time savings were not measured. This supports deferral
  for these instruments, not a general design law.
- An abstract reports that open-weight models screened more
  conservatively than GPT-4.1 across 25k titles — a model-behavior
  contrast awaiting full-text numbers
  @safarpour2026[abstract-only].
- High self-consistency coexists with mediocre accuracy — run-to-run
  Fleiss κ 0.82–0.97 on the two corpora tested @syriani2023 —
  stability is not validity.
- One selected end-to-end preprint uses no redundancy @huang2026; that
  architecture is descriptive and supplies no comparison of independence
  mechanisms.

None of the 25 selected deep reads explicitly defines what makes two
agent passes _independent_ in the sense dual human review requires —
different prompts, tiers, vendors, or training corpora — or measures
correlated error from shared training data. The campaign had no targeted
independence/ensemble query and no independence facet, so this observation
cannot establish a literature-wide absence. It motivates a targeted
follow-up to the human-independence concerns in earlier guidance
@hamel2021.
