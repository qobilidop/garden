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
  distinguishable control- or time-indexed paths, uses feasibility to choose
  or reconstruct execution, and makes that mechanism load-bearing in its
  result. Standing searches through 11 August and critical citation chases
  through 12 August 2026 yield 31 works: 14 classical, 11 concolic, and 6
  selective-hybrid.
  RTL accounts for 20; SystemC/TLM, mixed-level, netlist, another HDL, and one
  hardware-specific HLS study form the remainder. Symbolic simulation, STE,
  BMC, and trace-only search are treated as adjacent, not counted. The corpus
  shows that hardware path execution is defined as much by clocks, scheduling,
  reset, translation, and environment as by the solver. Target guidance,
  backward execution, fragment composition, caching, symbolic time
  abstractions, and fuzzing handoffs move cost among paths, summaries,
  formulas, and concrete corpora; they do not generally remove the product of
  inputs, control choices, concurrent processes, and cycles. Most results are
  replayable tests, counterexamples, exploits, or coverage evidence rather
  than unbounded proofs, and heterogeneous bounds and harnesses prevent a
  quantitative ranking. The resulting topic is a coherent but specialized
  niche. We conclude with a common reporting contract and an agenda for
  semantic validation, benchmarks, completion accounting, and cross-level
  composition.
]
