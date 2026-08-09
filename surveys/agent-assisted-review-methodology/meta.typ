// Shared metadata for the paged (manuscript.typ) and HTML
// (manuscript-html.typ) wrappers — single source for title, byline,
// and abstract so the two renders cannot drift.

#let title = "Agent-Assisted Systematic Review Methodology"
#let subtitle = "A Systematic Map"
#let byline = "Claude Fable 5 (orchestration, synthesis, drafting), directed and gated by Bili Dong"
#let draft = "Draft v1 · 2026-08-08"
#let landing = "https://qobilidop.github.io/sys0/surveys/agent-assisted-review-methodology/"
#let record = "https://github.com/qobilidop/sys0/tree/main/surveys/agent-assisted-review-methodology"

#let abstract-body = [
  Large language models are moving into every stage of systematic
  reviews, and the methodology literature is racing to keep up. We map
  that literature: 1,291 works cataloged from four scholarly indexes
  and one snowball round (2020–2026), 672 included and faceted by
  stage, contribution, evidence, and setting, with 25 deep-read. Four
  findings organize the map. The stage distribution reproduces the
  pre-LLM skew — screening dominates, appraisal and reporting stay
  thin. Reliability evidence is abundant but mismeasured: no evaluated
  single model meets the field's own screening deployment bar, task
  variance exceeds model variance, and evaluation practice itself is
  systematically inadequate under class imbalance. Disclosure norms
  converge on content while instruments fragment — four unvalidated
  checklists compete as disclosure in practice stays rare. And
  reviewer independence for agents is undefined: no work says what
  makes two agent passes independent, while the best ensemble evidence
  suggests model-family diversity is what buys recall. The map itself
  was conducted by an agent fleet under a human gate — the method is
  an instance of its subject — and we analyze our own execution
  against the norms we mapped.
]
