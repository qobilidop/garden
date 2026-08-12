= Verification goals and result contracts <sec-contracts>

The same path engine can generate tests, close coverage, expose an exploit,
compare two models, or check an assertion. The application label does not
determine the strength of the result. Output type, environment, and completion
do.

== Replayable positive witnesses

A concrete input sequence replayed on the design is a portable
conclusive positive outcome. SE4RDV solves generated-code paths and measures the tests again in
RTL simulation @zhang2016rtltests. Directed concolic testing observes the
target during concrete RTL re-execution @ahmed2018directed. FuSS returns
symbolically extended programs to the fuzzer and measures them on the
Verilated design @jayasena2025fuss. Coppelia goes further by turning a
processor-design condition into an executable program and replaying exploits
@zhang2018coppelia.

Replay establishes an existential claim: under this reset, clock, environment,
and implementation, the supplied input exhibits the behavior. It does not
prove translation equivalence, validate every symbolic intermediate state, or
show that another behavior is absent. A portable witness must include the
initialization and transaction protocol, not only the symbolic bytes.

== Coverage and repair evidence

Branch, statement, condition, assertion, information-flow, and toggle coverage
have different denominators. Generated C++ branches may not correspond
one-to-one with RTL branches, and excluded or unreachable targets can inflate
or depress a percentage. A coverage claim therefore needs the instrumented
artifact, denominator, reachability policy, temporal budget, and replay rate.

Concolic and selective-hybrid work commonly uses coverage as a target or
handoff signal and as the outcome. Qin and Mishra divert concrete traces toward uncovered HDL
branches @qin2014interleaving; FuSS invokes symbolic suffix execution at a
fuzzing plateau @jayasena2025fuss. AutoVeriFix+ uses concolic branch discovery
to improve differential tests and propose RTL repair or pruning
@tan2026autoverifix. None of these mechanisms turns a residual uncovered branch
into a proof of unreachability or semantic redundancy.

== Bounded completion and negative outcomes

Exhaustion by a sound executor can establish all modeled executions only within
its initial-state, time, environment, supported-language, translation,
approximation, and solver contract. An empty worklist alone is not a soundness
argument.
Timeouts, memory limits, solver limits, heuristic exhaustion, and targets never
scheduled are incomplete outcomes even when no counterexample appears.

SEIF is unusually explicit: a static candidate can be globally contradictory,
fail only under a bounded search, be rejected by a semantic-flow check, yield a
replayable path, or remain unaccounted @ryan2023seif. EISec's under-constrained
initial netlist state broadens possible information flows but can admit states
not reachable from reset @fowze2022eisec. Such partitions should replace the
binary “found/not found” reporting common in testing papers.

== Equivalence and coupled-model claims

Cross-level results need a relation between states, time, and observations.
COVERIF makes a coupled hardware/software path the execution object
@mukherjee2020coverif. The RISC-V study compares Verilated RTL with an ISS at
retirement boundaries @bruns2023processor. Cross-level SystemC checking uses a
transaction-level peripheral as an oracle for a lower-level implementation
@rudkowski2026crosslevel. A mismatch is a useful witness; agreement is only as
strong as the reference model, alignment, assumptions, and completed bounds.

The same qualification applies at the HLS edge. Hu's generated tests expose
failures in the hardware-specific HLS source model, but without generated-RTL
validation they do not establish the behavior of every synthesis result
@hu2024tcp.

== Minimum reporting tuple

Every reported result should be readable as

$ (A, S, T, E, X, R, C), $

where $A$ is the executed artifact and translation chain; $S$ the reset or
initial state; $T$ clock, scheduling, and temporal bound; $E$ the environment
and harness; $X$ semantic conformance, exactness, abstraction, concretization,
and supported subset; $R$ the returned witness, coverage, or conclusion; and
$C$ whether search merely terminated or achieved justified bounded exhaustion.
For a combinational design, temporal fields may be “not applicable”; they
should not silently disappear. “Exhaustive,” “safe,” or “verified” is
interpretable only with the complete tuple.
