# Claims ledger

This file owns the survey's interpretive propositions. Literature findings
that support them live in `evidence.md`; source-specific facts and limitations
live in `sources/`; the manuscript presents the resulting argument.

Statuses are `survey synthesis` for an evidence-backed cross-work conclusion
and `survey proposal` for a reporting or research recommendation motivated by
the mapped evidence but not claimed as an established result.

## Current survey synthesis claims

### C01 — Path-conditioned execution is the useful boundary

- **Status:** survey synthesis
- **Statement:** A focused hardware-symbolic-execution corpus requires execution of a digital design or a documented derived representation, symbolic hardware values, predicates for alternatives distinguished by that design representation over control and—when sequential—time, feasibility-guided execution choice or reconstruction, and a load-bearing verification result. A derived or HLS representation also needs a semantic bridge adequate to the design-level claim. Symbolic simulation, STE, and transition-formula solving are adjacent but do not enter merely because they propagate symbols or use SAT/SMT; testbench-only path forks do not establish design-path execution.
- **Scope:** The bounded digital-design corpus; not a definition imposed on all uses of “symbolic execution.”
- **Prior frontier:** The software taxonomy supplies the canonical path-condition account, while individual hardware systems expose the scheduling, trace, and solver mechanisms needed to instantiate it.
- **Consequence:** Self-labeling is insufficient, and the map denominator remains interpretable rather than expanding to formal hardware verification generally.

### C02 — Concolic and selective execution belong, but remain distinct

- **Status:** survey synthesis
- **Statement:** Concolic execution belongs within the survey because it maintains or reconstructs the symbolic path predicate of a concrete hardware execution and solves it to generate another execution. Selective-hybrid systems also belong when that same symbolic mechanism is load-bearing, but their concrete/symbolic handoff is an additional source of incompleteness and cost.
- **Scope:** Hardware concolic and selective-hybrid systems that pass all five inclusion conditions; not trace-only search, fuzzing, or genetic testing.
- **Prior frontier:** Included systems explicitly couple concrete RTL/SystemC traces to path constraints, while other nominally concolic systems use concrete simulation plus heuristic search without symbolic feasibility.
- **Consequence:** The one-value catalog reserves `selective-hybrid` for an independent non-symbolic engine with its own evolving frontier or corpus; concrete replay inside a trace-and-solve loop remains `concolic`, making the aggregate bins reproducible.

### C03 — The operational representation determines the semantic obligation

- **Status:** survey synthesis
- **Statement:** Direct RTL, generated C/C++, SystemC/TLM, HLS source, netlists, and coupled models are not interchangeable front ends. Each moves responsibility for clocks, scheduling, state, datatypes, translation, and environment to a different semantic bridge.
- **Scope:** Claims about a digital design made through the representation actually executed.
- **Prior frontier:** Individual systems document direct HDL semantics, Verilator or netlist translations, SystemC schedulers, HLS datatypes and streams, and cross-level observation relations; their comparison as semantic obligations is this survey's synthesis.
- **Consequence:** Every result must name the operational artifact and the relation back to the design of interest.

### C04 — Local scaling gains require end-to-end accounting

- **Status:** survey synthesis
- **Statement:** Target guidance, one-path reconstruction, backward execution, fragments, caching, slicing, and fuzzing handoffs can reduce selected construction or solver work. They may shift work to summaries, compatibility checks, solver formulas, concrete corpora, or semantic validation, or may deliberately stop distinguishing behavior; no conserved cost quantity is claimed.
- **Scope:** The path-conditioned systems in this corpus; not an impossibility theorem for a restricted observer or design.
- **Prior frontier:** Included works establish the individual mechanisms and their measured benefits; the cross-mechanism cost account is the survey's synthesis.
- **Consequence:** A scaling result should report end-to-end resources, completion, solver work, handoff and validation costs, and the distinctions deliberately deferred or discarded.

### C05 — Positive witnesses survive incomplete search; absence requires sound completion

- **Status:** survey synthesis
- **Statement:** Replayed tests, counterexamples, and exploits establish concrete existential behaviors under a harness even when the surrounding search is incomplete. Coverage plateaus, exhausted heuristics, and timeouts do not establish absence. A negative result becomes conclusive only when a sound executor exhausts the declared semantic subset and bound; it remains qualified by reset, time, environment, translation, and approximation.
- **Scope:** Functional, coverage, security, and equivalence results produced by the included systems.
- **Prior frontier:** Critical studies return replayed tests or explicitly partition incomplete outcomes, but use heterogeneous bounds and environments.
- **Consequence:** “Exhaustive,” “safe,” and “verified” require an explicit completion and model contract.

### C06 — The bounded map identifies a coherent specialized slice

- **Status:** survey synthesis
- **Statement:** The strict bounded corpus exposes recurring regimes, design targets, semantic bridges, scaling mechanisms, and result contracts. Under this protocol it is a specialized slice of hardware verification; the map does not estimate the size or maturity of an underlying field.
- **Scope:** The 31 full-text-qualified works surfaced by 17 broad queries reconciled through 2026-08-10, four strict queries reconciled on 2026-08-11, one failed strict query, and critical citation chases through 2026-08-12; not a population estimate or closure claim.
- **Prior frontier:** The publications establish a sustained line of SystemC, RTL, security, concolic, HLS, and cross-level work; the bounded distributions and recurring themes come from this survey's catalog.
- **Consequence:** A focused survey is justified, while symbolic simulation and broader formal hardware methods remain separate scopes rather than being merged only to enlarge this map.

### C07 — Evaluation requires a common result contract

- **Status:** survey proposal
- **Statement:** Reporting `(artifact, initial state, time, environment, exactness, result, completion)` together with structural scale, solver and end-to-end resources, witness replay, and setup effort is a minimal cross-system comparison contract.
- **Scope:** Reporting and comparison, not a new algorithm or formal semantics.
- **Prior frontier:** Existing evaluations expose these fields unevenly; no shared benchmark and outcome schema spans the mapped systems.
- **Consequence:** The tuple makes it possible to distinguish a faster search from a weaker or incomplete claim without forcing architectural uniformity.
