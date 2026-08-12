= Interpretation and research agenda <sec-synthesis>

== Why the field is small

The corpus is under-studied for understandable reasons. Hardware verification
already has mature simulation, constrained-random testing, BMC, equivalence,
theorem proving, and symbolic-simulation ecosystems. Classical path execution
must justify itself against those tools while facing a worse path product:
branch choices recur across cycles and interact with concurrency and
environment. An RTL executor also needs difficult language and scheduler
semantics, while a translated executor inherits a trust and traceability gap.

The technique is most attractive when a concrete witness matters and the
target is narrow: a hard RTL branch, Trojan trigger, processor exploit,
information-flow path, assertion, or cross-level mismatch. Directed and
scalable concolic systems make this niche explicit @ahmed2018directed
@lyu2021scalable. Coppelia and SEIF show the value of turning an abstract
security concern into an executable path @zhang2018coppelia @ryan2023seif.
FuSS shows why symbolic execution is often most useful as selective assistance
rather than the sole engine @jayasena2025fuss.

This is not a dead end. It explains the field's shape: recurring useful
mechanisms, limited breadth, and few claims of unbounded proof. A survey can
make that niche legible without inflating it.

== Semantic conformance

Direct executors need executable suites for HDL widths, four-state values,
nonblocking assignments, memories, clocks, reset, scheduling, and process
interactions. Translation-based systems need differential replay and declared
preservation boundaries. The SystemC work especially shows that C++ execution
without a scheduler model is not enough @lin2016systemc
@rudkowski2026crosslevel. Conformance failures should be reported separately
from path-search failures.

== Common benchmarks and outcomes

The field needs versioned RTL, SystemC, HLS, and mixed-level tasks with complete
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

== Better selective handoffs

Selective execution needs principled handoff contracts: why a target is
chosen, which concrete state is transferred, how reachability from reset is
preserved, what slice is symbolized, and whether the output replays. FuSS
provides a concrete snapshot/suffix architecture @jayasena2025fuss; Qin and
Mishra provide trace-derived constraints @qin2014interleaving. Future work
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
semantic conformance tests, and full outcome partitions would do more for the
field than another isolated coverage percentage. AutoVeriFix+ also raises a
new oracle problem: an LLM-generated reference can guide useful concolic tests
while remaining an uncertain specification @tan2026autoverifix. Oracle
provenance belongs in the result contract.
