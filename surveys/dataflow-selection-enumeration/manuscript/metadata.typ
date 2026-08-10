// Shared metadata for the paged (manuscript.typ) and HTML
// (manuscript-html.typ) wrappers — single source for title, byline,
// and abstract so the two renders cannot drift.

#let title = "Exhaustive Enumeration of Selection Observations in Pure Dataflow Graphs"
#let subtitle = "A Survey and Unified Framework"
#let byline = "Bili Dong"
#let author-note = [
  The byline names the accountable human author, who directed the
  work, gated every stage, and takes responsibility for the content.
  OpenAI Codex (GPT-5.6 Sol) provided substantial assistance with
  literature-search planning, evidence organization, cross-paper
  synthesis, formal presentation, manuscript drafting and editing,
  and repository tooling. AI output is not treated as evidence;
  literature claims rest on the cited primary sources and the public
  working record in the repository.
]
#let draft = "Draft 2026-08-09"
#let landing = "https://qobilidop.github.io/sys0/surveys/dataflow-selection-enumeration/"
#let record = "https://github.com/qobilidop/sys0/tree/main/surveys/dataflow-selection-enumeration/record"

#let abstract-body = [
  Different inputs can make a shared graph consult different selection nodes.
  We group allowed inputs when the requested outputs consult the same graph
  occurrences and obtain the same outcomes. For each group, the target is an
  exact input formula, a symbolic expression for the requested outputs, and
  one sample input. We call the grouping function the selection observer and
  each group an observation fiber. The base model is a finite, acyclic,
  deterministic pure graph with total primitives. This paper surveys the established approaches
  that can solve, compile, or specialize this task: guarded symbolic execution,
  projected model enumeration, decision structures, demand-guided search,
  geometric region traversal, and compositional summaries. Its main synthesis
  is a unified terminology and theoretical framework that separates the
  observer being enumerated from the discovery algorithm and output
  representation. Within that framework, enabled reachability determines
  which site outcomes are included; sparse event maps, observed-outcome
  guards, and totalized reachability-and-outcome coordinates then determine
  the same input partition. The comparison explains
  which approaches enumerate the same fibers directly, which require
  instrumentation or quotienting, which provide stronger guarantees on
  restricted instances, and which solve only adjacent reduction problems. The
  result is a problem-centered survey and semantic contract, not a claim of a
  new generic enumeration paradigm or practical speedup.
]
