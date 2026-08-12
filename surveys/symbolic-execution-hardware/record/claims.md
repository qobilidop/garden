# Claims ledger

This file owns the survey's interpretive propositions. Literature findings
that support them live in `evidence.md`; source-specific facts and limitations
live in `sources/`; the manuscript presents the resulting argument.

## Current survey synthesis claims

### C01 — Path-conditioned execution is the useful boundary

- **Status:** survey synthesis
- **Statement:** A focused hardware-symbolic-execution corpus requires a digital design execution, symbolic hardware values, explicit control- or time-indexed path predicates, feasibility-guided execution choice or reconstruction, and a load-bearing verification result. Symbolic simulation, STE, and transition-formula solving are adjacent but do not enter merely because they propagate symbols or use SAT/SMT.
- **Scope:** The bounded digital-design corpus; not a definition imposed on all uses of “symbolic execution.”
- **Prior frontier:** The software taxonomy supplies the canonical path-condition account, while individual hardware systems expose the scheduling, trace, and solver mechanisms needed to instantiate it.
- **Consequence:** Self-labeling is insufficient, and the map denominator remains interpretable rather than expanding to formal hardware verification generally.

### C02 — Concolic and selective execution belong, but remain distinct

- **Status:** survey synthesis
- **Statement:** Concolic execution belongs within the survey because it maintains or reconstructs the symbolic path predicate of a concrete hardware execution and solves it to generate another execution. Selective-hybrid systems also belong when that same symbolic mechanism is load-bearing, but their concrete/symbolic handoff is an additional source of incompleteness and cost.
- **Scope:** Hardware concolic and selective-hybrid systems that pass all five inclusion conditions; not trace-only search, fuzzing, or genetic testing.
- **Prior frontier:** Included systems explicitly couple concrete RTL/SystemC traces to path constraints, while other nominally concolic systems use concrete simulation plus heuristic search without symbolic feasibility.
- **Consequence:** Classical, concolic, and selective-hybrid are sibling map values under one operational boundary, not synonyms.

### C03 — The executed artifact determines the semantic obligation

- **Status:** survey synthesis
- **Statement:** Direct RTL, generated C/C++, SystemC/TLM, HLS source, netlists, and coupled models are not interchangeable front ends. Each moves responsibility for clocks, scheduling, state, datatypes, translation, and environment to a different semantic bridge.
- **Scope:** Claims about a digital design made through the representation actually executed.
- **Prior frontier:** Individual systems document direct HDL semantics, Verilator or netlist translations, SystemC schedulers, HLS datatypes and streams, and cross-level observation relations; their comparison as semantic obligations is this survey's synthesis.
- **Consequence:** Every result must name the operational artifact and the relation back to the design of interest.

### C04 — Scaling methods relocate rather than abolish path cost

- **Status:** survey synthesis
- **Statement:** Target guidance, one-path reconstruction, backward execution, fragments, caching, slicing, and fuzzing handoffs reduce selected construction or solver work, but generally leave a product over inputs, branch choices, concurrent processes, and cycles somewhere in the executor, summaries, solver, or concrete corpus.
- **Scope:** The path-conditioned systems in this corpus; not an impossibility theorem for a restricted observer or design.
- **Prior frontier:** Included works establish the individual mechanisms and their measured benefits; the cross-mechanism cost account is the survey's synthesis.
- **Consequence:** A scaling result should report end-to-end resources, completion, solver work, and the distinctions deliberately deferred or discarded.

### C05 — Positive witnesses are stronger than negative search outcomes

- **Status:** survey synthesis
- **Statement:** Replayed tests, counterexamples, and exploits establish concrete existential behaviors under a harness. Coverage plateaus, exhausted heuristics, timeouts, and bounded failures do not establish absence; even completed symbolic execution is qualified by reset, time, environment, translation, and approximation.
- **Scope:** Functional, coverage, security, and equivalence results produced by the included systems.
- **Prior frontier:** Critical studies return replayed tests or explicitly partition incomplete outcomes, but use heterogeneous bounds and environments.
- **Consequence:** “Exhaustive,” “safe,” and “verified” require an explicit completion and model contract.

### C06 — The topic is surveyable precisely because it is small and coherent

- **Status:** survey synthesis
- **Statement:** The strict corpus is large enough to expose recurring regimes, artifacts, scaling mechanisms, and result contracts, but small enough that symbolic execution is better described as a specialized hardware-verification niche than a mature standalone field.
- **Scope:** The 31 full-text-qualified works surfaced by standing searches through 2026-08-11 and critical citation chases through 2026-08-12; not a population estimate or closure claim.
- **Prior frontier:** The publications establish a sustained line of SystemC, RTL, security, concolic, HLS, and cross-level work; the size and concentration result comes from this survey's catalog.
- **Consequence:** A focused survey is justified, while symbolic simulation or all formal hardware methods should remain separate scopes rather than padding the denominator.

### C07 — Evaluation requires a common result contract

- **Status:** survey proposal
- **Statement:** Reporting `(artifact, initial state, time, environment, exactness, result, completion)` together with structural scale, solver and end-to-end resources, witness replay, and setup effort is a minimal cross-system comparison contract.
- **Scope:** Reporting and comparison, not a new algorithm or formal semantics.
- **Prior frontier:** Existing evaluations expose these fields unevenly; no shared benchmark and outcome schema spans the mapped systems.
- **Consequence:** The tuple makes it possible to distinguish a faster search from a weaker or incomplete claim without forcing architectural uniformity.
