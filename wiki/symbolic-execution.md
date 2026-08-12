# Symbolic execution

Symbolic execution runs programs over symbolic inputs and accumulates
constraints that describe sets of concrete behaviors. The shelf, by role:
[[baldoni2016-symbolic]] (field architecture
and taxonomy), [[sen2015-multise]] (incremental path merging through guarded
value summaries), and [[yang2026-forbench]] (hardware symbolic simulation
that forks on testbench decisions rather than design branches),
[[jayasena2025-fuss]] (RTL fuzzing that purchases short symbolic suffixes from
concrete frontier states), with
[[jayasena2023-directed]] as the adjacent hardware-validation map that places
symbolic and concolic systems among other directed-test generators, and
[[kong2026-nextmap]] as the negative boundary case: symbolic retention of
equivalent hardware implementations without symbolic execution of their
behaviors. Practitioner accounts mark the larger formal-methods neighborhood:
[[wayne2019-formal-methods]] (adoption and artifact types),
[[verbeure2019-under-hood]] (RTL cover traces and assertion automata),
[[gisselquist2024-verification]] (a complementary verification portfolio), and
[[shaughnessy2023-cryptol-saw]] (specification-to-IR equivalence across
software and hardware).

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

[[jayasena2025-fuss]] chooses a third placement rather than another symbolic
representation. Most alternatives remain concrete programs in a fuzzing
corpus. Symbolic path constraints appear only after coverage plateaus, start
from a fuzzer-reached simulator snapshot, and span a nearby CFG frontier. This
does not compress or exhaust the omitted paths; it uses empirical coverage to
decide when a small symbolic search is worth buying.

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

FuSS sharpens the difference between a coverage witness and a proof. Its
Verilog design and testbench pass through Verilator and VEX; a concrete
snapshot supplies the symbolic start state, and a generated suffix is replayed
to measure branch or toggle coverage. Successful replay witnesses activation,
but uncovered logic does not become unreachable. The reported gains across
four RISC-V SoCs are evidence for this hybrid schedule, while the claimed
always-faster result remains conditional on an empirically assumed success-
probability ordering and omits symbolic-solving cost.

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

The word *symbolic* is not enough to establish the category.
[[kong2026-nextmap]] keeps many equivalent RTL implementations in a semantic
e-graph and uses an ILP solver to extract one technology-constrained design.
Those alternatives are synthesis candidates intended to denote the same
behavior, not paths induced by symbolic inputs or testbench decisions. The
contrast with [[yang2026-forbench]] is structural: both delay commitment by
sharing alternatives, but only Forbench executes a transition system and
characterizes behaviors under a harness and cycle bound.

## The practitioner boundary is broader than symbolic execution

The adjacent accounts explain why deployed work is often described as
*formal verification* rather than by one engine mechanism.
[[wayne2019-formal-methods]] separates code proof from design verification
and model checking, then locates different adoption barriers in proof cost,
specification validity, changing requirements, and the weak coupling between a
design model and executable code. The lesson for taxonomy is economic as well
as semantic: types, contracts, theorem proving, model checking, symbolic
execution, and disciplined testing can target related failures without being
interchangeable methods.

The hardware accounts make that composition concrete.
[[verbeure2019-under-hood]] uses a `cover` goal as an implicit directed-test
generator: the solver finds bus stimulus and an unexpected legal ordering,
exposing a missing assumption. Rich temporal assertions compile into
nondeterministic automata and then deterministic RTL state, so parallel
sequence matching can create exponential growth before a solver sees the
problem. That is symbolically generated behavior at the user interface, but an
implementation may be more precisely classified as assertion compilation plus
bounded or inductive checking.

[[gisselquist2024-verification]] shows why the distinction matters in a real
workflow. Formal contracts, cover, induction, parameter sweeps, mutation
coverage, signal/code coverage, self-checking simulation, and generated
interconnects each detect a different blind spot. Component proof scales by
narrowing scope and therefore leaves integration and driver behavior for other
harnesses. A survey centered on symbolic execution should record these
complements because an engine's reported bug yield depends on which failures
the surrounding portfolio delegates to it.

[[shaughnessy2023-cryptol-saw]] starts at a different abstraction level:
Cryptol states algorithmic meaning, while SAW lifts LLVM, JVM, machine-code,
or HDL representations and compares them through common IR and SAT/SMT
obligations. It may use symbolic reasoning internally, but its survey-relevant
identity is the specification–implementation bridge. This broadens "hardware"
beyond executing RTL paths: an HDL artifact can be one compilation target
whose equivalence to an algorithmic model is the property under test.

## What the shelf needs next

The software field survey supplies a durable taxonomy, and the hardware
directed-testing survey supplies a broad adjacent map. FuSS adds a substantial
four-SoC experiment for one hybrid point, but the shelf still lacks a
controlled quantitative comparison. Jayasena and Mishra's final 1–5 plot for
coverage, scalability, effort, and guarantee is an expert synthesis without a
reported scoring protocol, not a meta-analysis. The missing bridge is a
contemporary experiment on guarded value summaries, ITE-heavy symbolic
simulation, and path-based execution under the same designs, solver, memory
budget, harness, and end-task metric. The shelf also lacks primary ingestions
of the foundational DART/KLEE lineage and a study of harness-construction
effort. Those additions would test which points on the representation
spectrum work under which conditions.
