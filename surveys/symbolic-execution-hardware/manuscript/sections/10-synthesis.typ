= Interpretation and research agenda <sec-synthesis>

== Why the mapped niche is technically demanding

The bounded corpus does not establish the size or maturity of an underlying
field. It does expose technical pressures that recur across the deep reads.
Branch choices recur across cycles and interact with concurrency and
environment; an RTL executor needs language and same-cycle composition
semantics, while SystemC can add scheduler semantics and a translated executor
inherits a trust and traceability gap. These are interpretations of the mapped
mechanisms, not a causal publication-volume study.

The technique is especially useful when a concrete witness matters and the
target is narrow: a hard RTL branch, Trojan trigger, processor exploit,
information-flow path, assertion, or cross-level mismatch. Directed and
scalable concolic systems make this niche explicit @ahmed2018directed
@lyu2021scalable. Coppelia and SEIF show the value of turning an abstract
security concern into an executable path @zhang2018coppelia @ryan2023seif.
FuSS shows how symbolic execution can be useful as selective assistance
rather than the sole engine @jayasena2025fuss.

These cases explain why the bounded slice is coherent: each uses path
feasibility to obtain selected evidence under a hardware semantic contract. A
survey can make that niche legible without inferring field maturity or padding
the denominator.

== Findings summary

#figure(
  table(
    columns: (19%, 25%, 27%, 29%),
    table.header(
      [*Finding*], [*Evidence scope*], [*Qualification*], [*Consequence*],
    ),
    [Operational boundary],
    [Full-text deep reads plus named symbolic-simulation and testbench-path comparators],
    [Classifies native design-path execution, not tool value or solver use],
    [Require design-distinguished predicates and feasibility-guided execution],
    [Semantic bridge],
    [Direct HDL/SystemC, translated RTL, netlist, HLS, and coupled-model studies],
    [Replay validates a witness, not every source/derived correspondence],
    [Report target and operational representation separately],
    [Execution regimes],
    [Classical, concolic, and two independently progressing selective hybrids],
    [Concrete replay alone remains concolic; handoffs can omit behavior],
    [Classify by the engine that owns the evolving frontier],
    [Scaling],
    [Guidance, reconstruction, fragments, caching, time abstraction, and fuzzing suffixes],
    [Local reductions can move work into formulas, compatibility, corpora, or validation],
    [Account for executor, formula, concrete-frontier, and bridge costs],
    [Result strength],
    [Recurring replayable tests and witnesses among the 17 deep reads],
    [Absence needs sound bounded completion; heterogeneous experiments prevent ranking],
    [Publish the full result tuple and separate witnesses from incomplete search],
  ),
  caption: [Principal findings, their evidence scope, and the qualifications
  that travel with them.],
) <tab-findings>

== Semantic conformance

Direct executors need executable suites for HDL widths, four-state values,
nonblocking assignments, memories, clocks, reset, scheduling, and process
interactions. Translation-based systems need differential replay and declared
preservation boundaries. The SystemC work especially shows that C++ execution
without a scheduler model is not enough @lin2016systemc
@rudkowski2026crosslevel. Conformance failures should be reported separately
from path-search failures.

== Common benchmarks and outcomes

Future evaluations need versioned RTL, SystemC, HLS, and mixed-level tasks with complete
harnesses, reachable and unreachable targets, expected witnesses, and several
temporal horizons. Hard negative cases and timeouts should remain in the suite.
Outcome schemas should distinguish proved infeasible, boundedly unexplored,
abstraction-inconclusive, nonreplayable, and not scheduled. SEIF's explicit
unaccounted class is a useful precedent @ryan2023seif.

== Compositional and incremental execution

Fragment, module, and cycle summaries should name state, time, assumptions,
and observables. Research should separate the cost of constructing reusable
local paths from checking global compatibility. Cross-level systems add a
second composition problem: aligning implementation and reference semantics
@bruns2023processor @rudkowski2026crosslevel. Incremental solvers and cached
path predicates are promising only when their reuse keys include the hardware
history that affects feasibility.

== Better concrete–symbolic handoffs

Concolic and selective-hybrid execution need principled handoff contracts: why
a target is chosen, which concrete state is transferred, how reachability from
reset is preserved, what slice is symbolized, and whether the output replays.
FuSS provides a concrete snapshot/suffix architecture @jayasena2025fuss; Qin
and Mishra provide trace-derived constraints in a solve-and-replay loop
@qin2014interleaving. Future work
should report the cost and failure modes of reconstruction, not only solver
time after the handoff.

== HLS and language breadth

One HLS-source thesis cannot support a general HLS conclusion. Its
hardware-specific datatype, stream, and timing work shows the right inclusion
logic, while its lack of generated-RTL validation exposes the missing bridge
@hu2024tcp. VHDL, Chisel, Bluespec, HLS IRs, multi-clock RTL, and broader
SystemVerilog remain search and research targets. New work should either model
their hardware semantics directly or validate the relation to the generated
artifact.

== Evidence and effort

Future evaluations should measure harness and model-building effort alongside
runtime. Repeated stochastic trials, public artifacts, independent replay,
semantic conformance tests, and full outcome partitions would do more for
comparability than another isolated coverage percentage. AutoVeriFix+ also raises a
new oracle problem: an LLM-generated reference can guide useful concolic tests
while remaining an uncertain specification @tan2026autoverifix. Oracle
provenance belongs in the result contract.
