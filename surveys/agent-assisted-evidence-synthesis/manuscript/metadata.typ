// Shared metadata for the paged (manuscript.typ) and HTML
// (manuscript-html.typ) wrappers — single source for title, byline,
// and abstract so the two renders cannot drift.

#let title = "Agent-Assisted Evidence Synthesis"
#let subtitle = "A Survey"
#let byline = "Bili Dong"
#let author-note = [
  The byline names the accountable human author, who directed and gated the
  work and takes responsibility for its content.
  OpenAI Codex systems (through GPT-5.6 Sol) provided substantial assistance with
  evidence organization, adversarial review, synthesis, manuscript drafting
  and editing, and repository tooling. Anthropic Claude systems (through
  Fable 5) provided
  substantial assistance with search, screening, classification, deep reading,
  synthesis, and manuscript drafting and revision.
  AI output is not treated as evidence; literature claims rest on the cited
  sources. The survey record linked in the title metadata documents
  the working evidence and synthesis trail.
]
#let draft = "Draft 2026-08-09"
#let landing = "https://qobilidop.github.io/sys0/surveys/agent-assisted-evidence-synthesis/"
#let record = "https://github.com/qobilidop/sys0/tree/main/surveys/agent-assisted-evidence-synthesis/record"

#let abstract-body = [
  AI systems now target every stage of evidence synthesis. This exploratory
  systematic map organizes 776 included works from a 1,975-row catalog
  covering 2020–2026, with structured evidence notes for 31 selected works
  (25 full-text, 5 abstract-only, 1 secondary-only). A
  four-dimensional, single-pass abstract coding places screening at the centre
  of the retained map and appraisal and reporting at its thin end; these counts
  describe the map, not population prevalence or evidence quality. Across the
  selected studies, reported performance is heterogeneous and common metrics
  can obscure failures under class imbalance. Guidance repeatedly addresses
  tool identity, task, human role, configuration, and verification, while four
  unvalidated instruments cover different subsets across reporting and
  reproducible storage. Multi-model studies document ensemble and deferral
  configurations, but no selected evidence record identifies a definition of
  independent agent reviewers or isolates the source of ensemble gains with a
  matched design. The survey contributes a consistent terminology, a taxonomy,
  a scoped synthesis of performance and governance evidence, and a curated
  reading list. Its search and coding limits, AI assistance, and evidence trail
  are disclosed in a minimal public record.
]
