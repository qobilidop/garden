# Symbolic execution

Symbolic execution runs programs over symbolic inputs and accumulates
constraints that describe sets of concrete behaviors. The shelf, by role:
[[sen2015-multise]] (incremental path merging through guarded value
summaries) and [[yang2026-forbench]] (hardware symbolic simulation that
forks on testbench decisions rather than design branches).

## Path explosion moves between representations

The execution tree is not the only place alternatives can live.
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

## What the shelf needs next

The missing bridge is a contemporary comparison of guarded value summaries,
ITE-heavy symbolic simulation, and path-based execution under the same
programs, solver, memory budget, and end-task metric. The shelf also lacks the
foundational DART/KLEE lineage and a study of harness-construction effort.
Those additions would test whether the two current works describe a durable
representation spectrum or merely successful points in different domains.
