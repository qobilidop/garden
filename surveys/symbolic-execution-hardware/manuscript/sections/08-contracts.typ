= Verification goals and result contracts <sec-contracts>

The same execution engine can serve test generation, coverage closure,
functional checking, security analysis, equivalence, or general methodology.
The output type and its qualifications matter more than the application label.

== Replayable witnesses

The most robust common output is a concrete input or input sequence that can be
replayed on the design. SE4RDV replays generated vectors in RTL simulation and
measures statement and branch coverage @zhang2016rtltests. Directed and scalable
concolic systems solve for tests aimed at selected RTL targets
@ahmed2018directed @lyu2021scalable. SEIF returns design paths and inputs for
realizable information-flow candidates and separately checks reset
compatibility for security witnesses @ryan2023seif.

Replay validates one existential claim: under the replay environment, this
input produces this behavior. It does not validate all symbolic states, the
translation used to obtain the test, or absence of another behavior. A useful
artifact should include clock/reset protocol, initial state, nondeterminism
policy, and any environmental transactions needed for replay.

== Coverage claims

Coverage-directed work reports statements, branches, conditions, targets, or
mutants reached. Coverage is always relative to an instrumentation and a
harness. A generated C++ branch may not correspond one-to-one with an RTL
branch; an optimized or flattened representation can duplicate or erase
source decisions. A symbolic simulator that merges design branches may cover
all bounded input valuations while never enumerating branch histories.

GreyConE's SystemC experiments and FuSS's RTL fuzzing experiments use
coverage as the handoff signal and outcome @debnath2022greycone
@jayasena2025fuss. Their contribution is best read as more efficient discovery
under a budget, not as a proof that uncovered behavior is impossible. Coverage
percentage needs the denominator, the unreachable-target policy, cycle/time
budget, and whether results were replayed.

== Bounded and unbounded conclusions

A symbolic run can exhaust all modeled valuations up to a temporal bound. That
is stronger than sampling and weaker than an unbounded invariant proof.
Forbench's merged-state execution can cover all inputs within its selected
cycle horizon while its testbench defines which observations cause forks
@yang2026-forbench. Cross-level SystemC runs can completely explore small
scenarios yet time out on larger modules @rudkowski2026crosslevel. The correct
claim names the horizon and completion status.

Negative results require particular care. SEIF distinguishes globally
contradictory graph segments, bounded failure to find a design path, semantic
non-flow checks, and candidates left unaccounted @ryan2023seif. This explicit
taxonomy should be standard. "No counterexample found" may mean UNSAT for a
complete bounded query, search budget exhausted, abstraction inconclusive, or
target never selected.

== Equivalence and cross-level contracts

Equivalence-oriented work compares two representations or observations. The
contract must specify inputs, state correspondence, timing alignment, and
observable outputs. COVERIF makes paths across a hardware/software interaction
the object @mukherjee2020coverif. Cross-level SystemC methods compare low-level
peripheral behavior with a transaction-level reference
@rudkowski2026crosslevel. These methods can expose interface defects that
component-local checks miss, but a weak or mismatched reference can also hide
them.

== A minimum reporting tuple

We recommend that every result be readable as the following tuple:

$ (A, S, T, E, X, R, C) $

where $A$ is the executed artifact and translation chain; $S$ the initial
state/reset model; $T$ the clock, scheduling, and temporal bound; $E$ the
environment/harness assumptions; $X$ the exactness, abstraction, and
concretization policy; $R$ the returned evidence; and $C$ the completion
status. A claim of "exhaustive" or "verified" is interpretable only when these
fields are explicit.
