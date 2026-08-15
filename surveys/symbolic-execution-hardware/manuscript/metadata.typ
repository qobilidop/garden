// Shared metadata for paged and HTML wrappers.

#let title = "Symbolic Execution of Digital Hardware Designs"
#let subtitle = "A Systematic Map of Path-Conditioned Design Execution"
#let byline = "Bili Dong"
#let author-note = [
  The byline names the accountable human author, who directed the scope and
  takes responsibility for the manuscript. OpenAI Codex systems (through
  GPT-5.6 Sol and GPT-5.6 Luna) provided substantial assistance with search,
  blinded agent screening, evidence organization, synthesis, drafting,
  adversarial review, and repository tooling. AI output is not treated as
  evidence; literature claims rest on the cited sources. The linked survey
  record preserves the protocol, catalog, decisions, and evidence trail.
]
#let draft = "Draft 2026-08-12"
#let landing = "https://qobilidop.github.io/sys0/surveys/symbolic-execution-hardware/"
#let record = "https://github.com/qobilidop/sys0/tree/main/surveys/symbolic-execution-hardware/record"

#let abstract-body = [
  “Symbolic execution” is used broadly in hardware verification, sometimes
  for path exploration and sometimes for any solver-backed propagation of
  symbolic values. This survey adopts a narrower operational boundary: an
  included method executes a digital design or claimed-faithful executable
  representation, carries symbolic hardware values, constructs predicates for
  alternatives distinguished by that representation, uses feasibility to
  choose or reconstruct execution, and makes that mechanism load-bearing in
  its result. 17 broad searches through 10 August, 4 strict-boundary
  searches through 11 August, and critical citation chases through 12 August
  2026 yield 31 full-text-qualified publication records, including preprints,
  after agent adjudication with no item-level human screening; 1 strict query
  failed and the map makes no closure or population claim. Under an explicit
  reproducible classification rule, 14 are classical, 15 concolic, and 2 selective-hybrid.
  RTL is the design target for 20; SystemC/TLM, mixed-level, netlist, another
  HDL, and 1 hardware-specific HLS study form the remainder. Operational
  artifacts and their semantic bridges are analyzed separately. Symbolic simulation, STE,
  BMC, and trace-only search are treated as adjacent, not counted. The corpus
  shows that hardware path execution is defined as much by clocking and process
  composition, plus scheduling where it is semantically real, reset,
  translation, and environment as by the solver. Target guidance,
  backward execution, fragment composition, caching, symbolic time
  abstractions, and fuzzing handoffs reduce selected work but may shift cost to
  paths, summaries, formulas, concrete corpora, handoffs, or semantic
  validation. Across the deep reads, heterogeneous bounds and harnesses
  prevent a quantitative ranking. The bounded map identifies a coherent,
  specialized slice of hardware verification. We conclude with a common reporting contract and an agenda for
  semantic validation, benchmarks, completion accounting, and cross-level
  composition.
]
