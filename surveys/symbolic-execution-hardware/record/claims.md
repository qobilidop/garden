# Claims ledger

This file owns the survey's interpretive propositions. Literature findings
that support them live in `evidence.md`; source-specific facts and limitations
live in `sources/`; the manuscript presents the resulting argument.

## Current survey synthesis claims

### C01 — A mechanism-based umbrella is useful

- **Status:** survey synthesis
- **Statement:** Hardware symbolic execution can coherently compare path,
  concolic, fragment, merged-expression, and hybrid methods
  when the common core is an operational symbolic design state related to
  feasible concrete hardware executions; the paper must still name the
  specific mechanism. STE and other abstract-state systems remain selective
  lineage unless their operational relation meets the core definition.
- **Scope:** Digital design artifacts in the campaign boundary; not every
  solver-backed formal-hardware method.
- **Prior frontier:** The literature supplies the individual mechanisms and
  their self-descriptions; the umbrella and boundary are this survey's
  synthesis.
- **Consequence:** Literal path forking is neither necessary nor sufficient
  for inclusion, while BMC or equivalence checking without an operational
  executor remains outside the core.

### C02 — Two lineages organize the field without implying universal convergence

- **Status:** survey synthesis
- **Statement:** An older hardware symbolic-simulation lineage and a
  software-style path/concolic lineage provide useful organizing extremes;
  selected modern systems recombine operations across that distinction, but
  the evidence does not establish that every system inherits both lineages.
- **Scope:** The selected core and lineage corpus, with no claim to survey STE
  or symbolic simulation comprehensively.
- **Prior frontier:** Carter et al. explicitly connect machine symbolic
  simulation to program symbolic execution; later path and concolic systems
  execute RTL or generated models, while Forbench most clearly couples merged
  design states to explicit procedural forks.
- **Consequence:** Chronologies and taxonomies should retain both ancestry and
  represent modern tools as positions in a design space.

### C03 — The executed artifact creates a semantic bridge

- **Status:** survey synthesis
- **Statement:** Direct RTL, generated C/C++, SystemC/TLM, HLS, and mixed-level
  execution are not interchangeable front ends: each assigns different
  semantic obligations to translation, scheduling, time, state, and harness.
- **Scope:** Claims about a hardware design made through the representation
  actually executed.
- **Prior frontier:** Individual systems document direct RTL, Verilator/KLEE,
  SystemC, HLS, and cross-level architectures; their comparison as semantic
  bridges is the survey's organization.
- **Consequence:** A result must name the operational artifact and the chain
  relating it to the design of interest.

### C04 — Scaling redistributes behavioral products

- **Status:** survey synthesis
- **Statement:** Path guidance, fragments, ITE merging, abstraction, caching,
  slicing, fuzzing handoffs, and testbench-directed forking redistribute work
  among executor states, representation size, solver queries, and harnesses;
  they do not remove the underlying behavioral product in general.
- **Scope:** General scaling interpretation; not an impossibility theorem for
  a restricted design or observer.
- **Prior frontier:** The cited systems establish concrete construction,
  composition, merged-value, and hybrid mechanisms; the three-ledger account
  is the survey's cross-system synthesis.
- **Consequence:** A scaling claim should report end-to-end time and memory,
  completion, solver work, and the distinctions deliberately not tracked.

### C05 — Hardware time and environment qualify every applicable guarantee

- **Status:** survey synthesis
- **Statement:** Replay, coverage, bounded exhaustion, and proof conclusions
  are meaningful only relative to reset or initial state, clock/scheduling
  semantics, temporal bound, harness/environment, and approximation policy.
- **Scope:** Verification claims produced by hardware symbolic execution,
  especially negative and exhaustive language.
- **Prior frontier:** Critical systems expose these qualifications in
  different forms, including harness cycle loops, bounded stalls, cross-level
  simulation limits, and explicit unaccounted outcomes.
- **Consequence:** "No counterexample," "full coverage," and "verified" must
  identify whether the query completed and what model it completed over.

### C06 — Current evaluations are weakly commensurable

- **Status:** survey synthesis
- **Statement:** Existing evaluations demonstrate useful systems but cannot be
  ranked by path count, coverage, or runtime alone because design scale,
  temporal depth, harness labor, completion categories, and baseline contracts
  differ.
- **Scope:** The critical empirical studies deep-read in this campaign; not a
  formal meta-analysis of effect sizes.
- **Prior frontier:** Each work reports design-specific evidence; no shared
  benchmark/result schema spans the mapped execution architectures.
- **Consequence:** Benchmark reports should publish structural scale, temporal
  depth, outcome partitions, solver/end-to-end resources, witness replay, and
  human setup effort.

### C07 — A compact reporting tuple exposes the contract

- **Status:** survey proposal
- **Statement:** Reporting `(artifact, initial state, time, environment,
  exactness, result, completion)` is a minimal cross-architecture contract for
  interpreting hardware symbolic-execution results.
- **Scope:** Reporting and comparison, not a new execution algorithm or formal
  semantics.
- **Prior frontier:** The tuple consolidates qualifications already distributed
  across the surveyed systems; its exact grouping is this survey's proposal.
- **Consequence:** The tuple supports comparison without forcing path,
  symbolic-simulation, and hybrid tools into the same internal model.
