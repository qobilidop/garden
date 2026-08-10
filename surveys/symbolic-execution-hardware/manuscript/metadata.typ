// Shared metadata for paged and HTML wrappers.

#let title = "Symbolic Execution of Digital Hardware Designs"
#let subtitle = "A Systematic Map of Artifacts, Execution Models, and Verification Contracts"
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
#let draft = "Draft 2026-08-10"
#let landing = "https://qobilidop.github.io/sys0/surveys/symbolic-execution-hardware/"
#let record = "https://github.com/qobilidop/sys0/tree/main/surveys/symbolic-execution-hardware/record"

#let abstract-body = [
  Symbolic execution of hardware is often presented as a transfer of a
  software-testing technique to RTL. We instead organize the selected
  literature around two lineages whose mechanisms sometimes coexist: hardware
  symbolic simulation represents many circuit behaviors inside symbolic
  values, while path-oriented and concolic systems execute HDL control flow,
  generated software models, or cross-level models under path conditions;
  symbolic trajectory evaluation is retained selectively as adjacent lineage.
  This survey systematically maps work through 10
  August 2026, with RTL at the center and other HDLs, HLS models, SystemC/TLM,
  and mixed-level designs included when a digital hardware design is itself a
  symbolic participant. It organizes the field by the executed artifact, the
  location of behavioral alternatives, the scaling mechanism, and the
  verification contract. The central finding is that "symbolic execution" is
  a useful umbrella only when papers state where alternatives live and what
  semantic bridge connects the executed representation to the design of
  interest. Path splitting, expression merging, fragments, abstraction,
  concrete/symbolic alternation, and testbench-directed forking move work
  among executor, solver, and harness; none removes the underlying behavioral
  product in general. Among the critical deep reads, reported outcomes range
  from replayable tests and counterexamples to bounded coverage and qualified
  proofs, but evaluations are difficult to compare because cycle bounds, reset
  assumptions, harness labor, design scale, and timeout policies vary. We conclude with a reporting
  contract and research agenda for semantic validation, common benchmarks,
  effort measurement, and compositional cross-level execution.
]
