// Shared metadata for the paged (manuscript.typ) and HTML
// (manuscript-html.typ) wrappers — single source for title, byline,
// and abstract so the two renders cannot drift.

#let title = "Agent-Assisted Evidence Synthesis"
#let subtitle = "A Survey"
#let byline = "Bili Dong"
#let author-note = [
  Following the no-AI-authorship convention this survey maps (RQ3),
  the byline names the accountable human author. The agent
  contribution was primary: Claude Fable 5 (claude-fable-5) executed
  the initial campaign — search, screening, classification, deep reads
  — and drafted the manuscript; Codex GPT-5.6 Sol performed the second
  adversarial review, catalog-integrity correction, evidence rechecks,
  and revisions. The author directed both passes, approved the protocol,
  gated every stage, and takes responsibility for the content; the
  minimal public record is linked below.
]
#let draft = "Draft 2026-08-08"
#let landing = "https://qobilidop.github.io/sys0/surveys/agent-assisted-evidence-synthesis/"
#let record = "https://github.com/qobilidop/sys0/tree/main/surveys/agent-assisted-evidence-synthesis/record"

#let abstract-body = [
  Large language models are moving into every stage of systematic
  reviews. We present an exploratory map of the broader AI-assisted and
  automated literature in the LLM era: 646 works retained after a
  version/retraction integrity pass over a campaign catalog assembled
  from four scholarly indexes and one snowball round (2020–2026), with
  25 selected for deep reading. The single-pass abstract coding places
  screening at the center of the map and appraisal and reporting at its
  thin end. Its evidence labels are common but are not quality ratings;
  the selected studies instead expose heterogeneous performance and
  recurring metric failures under class imbalance. Three deep-read
  disclosure proposals coexist without validation or adoption evidence,
  while reported practice was rare in the two domains one source
  mapped. Among the 25 deep reads, none explicitly defined independence
  for agent reviewers. One cross-vendor ensemble preprint reports
  complementary model decisions and high recall, but does not isolate
  model-family diversity as the cause. The survey contributes consistent
  terminology, a four-dimensional taxonomy, and a curated reading list;
  it was compiled with LLM-agent assistance under human direction, with
  a minimal public record.
]
