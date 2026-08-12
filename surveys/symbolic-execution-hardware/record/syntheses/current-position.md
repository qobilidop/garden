# Current position

The survey should remain narrowly about path-conditioned symbolic execution of
digital hardware designs. A work belongs only when it executes a hardware
design or claimed-faithful representation, carries symbolic hardware values,
constructs path predicates for distinguishable design executions, uses their
feasibility to choose or reconstruct execution, and makes that mechanism
load-bearing in its result. The alternatives must be distinguished by the
executed design representation, not only by an external procedural testbench;
derived and HLS artifacts also require a documented semantic bridge adequate
to the claimed result. Symbolic simulation, STE, BMC, trace-only search, and
generic HLS-source analysis remain boundary context rather than denominator.

The catalog uses one reproducible primary regime. Selective/hybrid is reserved
for a non-symbolic search engine that maintains its own evolving frontier or
corpus, makes progress between symbolic invocations, and exchanges candidates
with the symbolic executor. A simulator that only supplies and replays the
trace in a solve-and-replay loop remains concolic; direct symbolic-state
exploration is classical. An LLM or repair loop that consumes concolic results
is not itself an independent search engine.

The adversarially corrected bounded map contains 31
full-text-qualified publication records from 2011 through 2026, including
preprints and agent-adjudicated records: 14 classical, 15 concolic, and 2
selective-hybrid under that rule. RTL is the claimed design target
for 20; four SystemC/TLM, four mixed-level, and one each of another HDL, HLS,
and netlist form the rest. Operational artifacts differ within those target
labels: direct HDL semantics, generated C/C++, lifted IR, netlist translations,
HLS source, and coupled models impose different semantic-bridge obligations.
This bounded, non-closed result justifies a focused survey but supports no
population-size or field-maturity inference.

The main synthesis is that hardware makes the path predicate temporal and
representational. Clock cycles, scheduling where it is semantically real,
reset, concurrency, translation, and environmental transactions decide what a
path means. Ordinary synchronous RTL processes contribute coupled same-cycle
constraints, not arbitrary scheduling choices; scheduler paths arise in
SystemC kernels, asynchronous or multi-clock interactions, and racy harnesses.

Guidance, backward search, fragments, caching, symbolic packet gaps, and
fuzzing handoffs reduce particular work by reusing summaries, focusing an
observer, or declining to distinguish behavior. Their gains can shift work to
other ledgers, but there is no conserved quantity; end-to-end accounting is the
defensible conclusion.

Results should therefore be read as `(artifact, initial state, time,
environment, exactness, result, completion)`. A replayed witness establishes
one behavior even when search is incomplete. A negative conclusion requires
exhaustion by a sound executor for the declared semantic subset and horizon. A
timeout, coverage plateau, or exhausted heuristic establishes neither absence
nor unbounded correctness. This contract, plus structural scale,
solver/end-to-end resources, replay, and setup effort, is the survey's central
reporting proposal.
