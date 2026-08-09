// Shared metadata for the paged (manuscript.typ) and HTML
// (manuscript-html.typ) wrappers — single source for title, byline,
// and abstract so the two renders cannot drift.

#let title = "Agent-Assisted Evidence Synthesis"
#let subtitle = "A Survey"
#let byline = "Bili Dong"
#let author-note = [
  Following the no-AI-authorship convention this survey maps (RQ3),
  the byline names the accountable human author. The agent
  contribution was primary: Claude Fable 5 executed the initial
  campaign — search, screening, classification, deep reads — and
  drafted the manuscript; Codex GPT-5.6 Sol performed the second
  adversarial review, catalog-integrity correction, evidence rechecks,
  and revisions; Claude Fable 5 and Claude Opus 5 ran the 2026-08-09
  update batch and its manuscript revision, with screening and
  deep-read passes delegated to Claude Sonnet 5 and Claude Haiku 4.5.
  The author directed every pass, approved the protocol, gated the
  update before any record state advanced, and takes responsibility
  for the content; the minimal public record is linked below.
]
#let draft = "Draft 2026-08-09"
#let landing = "https://qobilidop.github.io/sys0/surveys/agent-assisted-evidence-synthesis/"
#let record = "https://github.com/qobilidop/sys0/tree/main/surveys/agent-assisted-evidence-synthesis/record"

#let abstract-body = [
  Large language models are moving into every stage of evidence
  synthesis. We present an exploratory map of the AI-assisted and
  automated literature in the LLM era: 776 works retained from a
  1,975-row catalog assembled over two waves (2020–2026) from four
  scholarly indexes, citation chases seeded from twelve designated
  closest works, and publisher-deposited bibliographies where the
  citation index failed; 31 works were deep-read. Single-pass
  abstract coding places screening at the centre of the map and
  appraisal and reporting at its thin end, an ordering the second
  wave left unchanged. The evidence labels are common but are not
  quality ratings, and they record the comparison a work claims
  rather than one verified to have occurred. The selected studies
  expose heterogeneous performance and recurring metric failures
  under class imbalance — in the sharpest case, one pre-LLM appraisal
  tool agreeing with human judgment at $kappa = 0.60$ on one domain
  and $0.04$ on another within a single nursing corpus (abstract-only
  evidence). Disclosure proposals now span two genres, reporting and
  reproducible storage, none reporting validation or adoption; in the
  one consensus exercise the map contains, a preprint panel's own
  account places its weakest agreement on actionable automation use.
  No selected work defines what makes two agent reviewers independent,
  though one now measures inter-agent correlation and finds that
  letting its agents debate raises that correlation and costs the
  ensemble the margin independent voting gave it. The survey
  contributes consistent terminology, a four-dimensional taxonomy over
  single-pass abstract-level coding, and a curated reading list; it
  was compiled with LLM-agent assistance under human direction, with a
  minimal public record and its own failure modes disclosed —
  including two screening passes that returned keyword heuristics
  rather than judgments and had to be discarded.
]
