= RQ4 — Independence: an exploratory deep-read gap <sec-rq4>

The 31 selected deep reads contain four designed multi-model or
human–model comparisons, two indirect signals, and one system with no
redundancy. This is an exploratory subset, not an exhaustively searched
class:

- A cross-vendor OR ensemble (GPT-5 Thinking + Gemini 2.5 Pro, two runs
  each, 736 Cochrane citations) reached 99.7% sensitivity and 49.3%
  specificity on the authors' adjudicated labels; against the original
  Cochrane labels its sensitivity was 94.0–94.5% @fagerberg2025. All
  18 relabels ran Include→Exclude, were decided by two same-team
  adjudicators, and every one of them moved measured sensitivity
  upward; the authors flag the specificity figure as a conservative
  lower bound. The
  preprint's post-hoc vaccine subgroup had seven positives: GPT-5
  sensitivity was 43% while Gemini flagged the same ambiguous records.
  The design has no matched same-family arm and does not isolate model
  family, model identity, duplicate runs, and the OR rule as causes.
- A 9-run consistency ensemble reached appraisal accuracy whose
  confidence interval overlapped human performance, only on items
  surviving near-unanimous agreement, deferring 74–88%
  of items; the _deferral_ design — human + LLM score, send
  disagreements to a second human — beat humans-alone in 8 of 10
  human–LLM pairings on the two easier retrospective appraisal
  instruments (best pairs 95–96% accuracy, range 89–96%) while sparing
  \~65–70% of second-reviewer item count; on PRECIS-2 it beat
  humans-alone in 1 of 10 pairings, reaching 80–86% while sparing
  about 29% @woelfle2024. The reference was two-rater consensus, prompts differed
  by model, and time savings were not measured. This supports deferral
  for these instruments, not a general design law.
- A cross-vendor three-agent vote (GPT-4o Mini, Claude 3 Haiku,
  Gemini 1.5 Flash, with a fourth model adjudicating) beat every
  constituent — mean average precision 0.341 against 0.271, 0.266, and
  0.182 — and beat its own debate variants; one adjudication variant
  matched it (0.345) at many times the cost @akinseloyin2026. Alone among the selected works it measures a
  proxy for independence, reporting Spearman correlations of 0.48–0.56
  between its agents' scores and concluding that model heterogeneity is
  what makes aggregating weak screeners work. Its three agents differ
  in vendor, size, and training corpus at once, with no same-family
  arm, so the causal claim outruns the design.
- A five-model same-family ensemble reached F1 89.16% against a best
  standalone 88.53% and reports no correlation or error-overlap
  statistic between its members at all @knafou2023 — a configuration
  documented without a mechanism.
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

None of the 31 selected deep reads defines what makes two agent passes
_independent_ in the sense dual human review requires — a criterion for
when one pass counts as independent of another. The nearest thing to
one is procedural rather than architectural: a registered protocol
stipulates that two different people each run the model in separate
sessions @rose2025, defining operator independence while leaving
sampling, context isolation, and session leakage unaddressed. The 2026-08-09 update
narrowed this finding without closing it: the first such measurement among the
selected deep reads has arrived @akinseloyin2026, and with it the most suggestive
evidence in the set that independence is the operative quantity.
Allowing that study's agents to debate raised their inter-agent
correlation and lowered ensemble performance relative to voting them
independently — interaction consuming the diversity the ensemble was
exploiting. That is a within-study comparison supporting a mechanism,
not a definition, and no selected work reports the quantity a theory
would need: error correlation measured within versus across model
families.

Neither wave ran a targeted independence query or coded an
independence facet, so this observation cannot establish a
literature-wide absence — and one incidental finding shows how the
frame binds. Chasing the newest of these works forward surfaced one
clinical-AI oversight preprint, out of scope here and read only at
abstract level (doi:10.64898/2026.02.08.26345860), whose abstract
describes deferring uncertain model outputs to humans by triangulating
model heterogeneity, stochastic inconsistency, and reasoning critique
— the three signals this set otherwise keeps apart. It is a pointer
for a targeted follow-up, not evidence about coverage. The finding
motivates a targeted follow-up to the human-independence concerns in
earlier guidance @hamel2021.
