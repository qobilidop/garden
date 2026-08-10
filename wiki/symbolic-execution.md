# Symbolic execution

Symbolic execution runs programs over symbolic inputs and accumulates
constraints that describe sets of concrete behaviors. The shelf, by role:
[[baldoni2016-symbolic]] (field architecture
and taxonomy), [[sen2015-multise]] (incremental path merging through guarded
value summaries), and [[yang2026-forbench]] (hardware symbolic simulation
that forks on testbench decisions rather than design branches), with
[[jayasena2023-directed]] as the adjacent hardware-validation map that places
symbolic and concolic systems among other directed-test generators.

## Path explosion moves between representations

The execution tree is not the only place alternatives can live. The Baldoni
et al. survey shows the broader spectrum: an engine can fork states, encode
choices in if-then-else or array formulas, summarize repeated code, merge
selected states, or deliberately concretize and omit choices.
[[sen2015-multise]] factors a set of paths by variable: each variable and the
program counter map to guarded values, so identical values share one
expression and merging happens on every assignment. [[yang2026-forbench]]
makes the dual move for RTL: design branches remain inside symbolic
expressions, while concrete control forks only when a testbench condition can
go both ways. MultiSE merges after branching; Forbench avoids many branches
in the first place.

Neither representation removes the exponential boundary. MultiSE operations
can take the product of operand-summary sizes; Forbench expressions can grow
with the circuit and time bound. Both exchange a visible path count for
expression structure, guard manipulation, and solver work. “Path explosion”
is therefore partly an architectural choice about where alternatives are
materialized, but every placement has its own growth mode.

## The solver boundary is part of the architecture

MultiSE keeps path predicates inside the solver's integer/string theory while
allowing floating-point values, functions, objects, and addresses to remain
explicit payloads under those guards. This lets execution merge and continue
without inventing solver-visible variables of unsupported types.
Forbench instead compiles RTL into bit-vector transition relations and spends
its engineering budget on expression simplification, unreachable-ITE
pruning, word-level sweeping, and assumption-guided evaluation. In both
systems the solver is not a black-box backend: what it can represent cheaply
determines the state model in front of it.

The survey generalizes that observation beyond merging. Symbolic addresses
can become path forks, conditional expressions, array-theory terms, or
concrete commitments. Constraints can be rewritten, partitioned, cached,
asked eagerly or lazily, or avoided through concretization. These are not
interchangeable optimizations: each shifts precision and cost between the
executor, memory model, and solver.

[[phan2015-all-smt]] makes the observation
boundary explicit by enumerating theory-consistent valuations of designated
Boolean coordinates. [[spallitta2024-tabular]]
can instead emit a disjoint cover of projected partial models. Neither solver
contract decides which program events matter: branch variables, output bits,
and structurally observed selections induce different partitions. The solver
can exhaust the encoded observer without proving that it is the right one.

That boundary also determines where approximation enters. MultiSE
concretizes an unsupported symbolic operation and marks the execution
incomplete; Forbench offers user-supplied abstraction predicates when
testbench coroutines proliferate. One drops paths while preserving the
soundness of retained behaviors; the other over-approximates states after an
SMT check. The opposite directions reflect different end tasks—test-input
generation versus bounded hardware verification.

## Coverage is a contract with the harness

Neither paper's “all paths” means all behavior without qualification.
MultiSE's experiments symbolically execute author-built sequences of library
calls, cut off input-dependent loops when necessary, and measure sharing and
runtime rather than end-to-end bug yield. Forbench explores all input values
admitted by a testbench up to a chosen cycle bound, while branching only at
the decisions that testbench exposes. Each result is exhaustive only relative
to its harness, theory, approximation policy, and resource bound.

This makes harness design part of the verification claim rather than setup
boilerplate. A representation can compress the behaviors it is asked to
consider; it cannot establish that the harness expressed the right behaviors,
that the bound was deep enough, or that an omitted theory was irrelevant.

Hardware directed testing broadens that contract beyond path coverage.
[[jayasena2023-directed]] follows tests across specification, TLM, RTL,
gate-level, and post-silicon settings and across functional, security, and
non-functional goals. A target can be a branch, assertion, processor state,
Trojan trigger, observable fault effect, or peak-power scenario. Formal
counterexamples, concolic paths, learned search policies, constrained-random
samples, and ATPG vectors can all be “directed” while providing different
guarantees. The target, observer, and translation between abstraction levels
are therefore part of the result, not incidental details of test production.

Terminology can obscure that contract. The Baldoni et al. survey calls an
analysis *sound* when it has no false negatives and *complete* when it has no
false positives, the reverse of a convention common in logic and static
analysis. Claims should therefore be read through the stated behavior: which
unsafe executions may be missed, which reported executions may be spurious,
and what concretization or modeling step created that boundary.

## What the shelf needs next

The software field survey supplies a durable taxonomy, and the hardware
directed-testing survey supplies a broad adjacent map, but neither provides a
controlled quantitative comparison. Jayasena and Mishra's final 1–5 plot for
coverage, scalability, effort, and guarantee is an expert synthesis without a
reported scoring protocol, not a meta-analysis. The missing bridge is a
contemporary experiment on guarded value summaries, ITE-heavy symbolic
simulation, and path-based execution under the same designs, solver, memory
budget, harness, and end-task metric. The shelf also lacks primary ingestions
of the foundational DART/KLEE lineage and a study of harness-construction
effort. Those additions would test which points on the representation
spectrum work under which conditions.
