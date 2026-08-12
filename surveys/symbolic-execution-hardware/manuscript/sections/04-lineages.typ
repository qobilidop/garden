= Corpus map and development <sec-lineages>

The strict corpus begins with a scheduler-aware SystemC construction, not with
the older symbolic-simulation papers excluded by the operational test. It then
grows through several partly independent applications. The chronology below
is a mechanism map, not a claim that every paper directly descends from its
predecessor.

== Classical execution

The earliest verified include builds waiting-state automata from feasible
SystemC symbolic paths @harrath2011wsa. By 2015–2016, software analyzers were
being applied through synthesis-semantic Verilog-to-C translation and
SystemC-aware or Verilator-generated execution @mukherjee2015software
@lin2016systemc @zhang2016rtltests. These architectures establish a recurring
choice: implement HDL scheduling in the executor, or trust a translation and
execute its paths.

Security work broadened both direction and output. Among the deep reads,
Coppelia uses backward execution to generate replayed processor-level exploit
witnesses @zhang2018coppelia. Later deep-read systems explore coupled hardware/software paths,
gate-level information flows, statically guided RTL flows, processor/ISS
mismatches, and independently constructed RTL fragments
@mukherjee2020coverif @fowze2022eisec @ryan2023seif @bruns2023processor
@ryan2023sylvia. The latest boundary expands to hardware-specific HLS source
and cross-level SystemC peripherals @hu2024tcp @rudkowski2026crosslevel.

== Concolic execution

The concolic line centers concrete traces as the path-selection mechanism.
The catalog places mapping-depth publications on qualifying-event search,
factored RTL testing, SystemC testing, multi-target activation, and selective
SystemC testing in this chronology @lyu2017quebs @pinto2017factored @lin2018ctsc
@lyu2019multitarget @lin2020selective. Technical synthesis here rests on the
deep-read directed RTL work: it selects a target-related branch, alters the
trace predicate, solves, and replays @ahmed2018directed.

Subsequent mapping records extend the chronology to asynchronous-reset
security, equivalence coverage, and incremental RTL testing @lyu2021soccar
@roy2023slec @zheng2024incremental. The chronology also contains trace-restricted,
Trojan-activation, assertion-targeting, and interleaved HDL studies
@bagri2015restrictive @ahmed2018trojan @jayasena2021assertions
@qin2014interleaving. The deep-read scalable RTL study documents
hardware-aware guidance and reuse @lyu2021scalable. AutoVeriFix+ embeds the mechanism inside an LLM-driven
RTL repair workflow: it records cycle-indexed paths, negates an uncovered
branch predicate, solves a test, and re-simulates it @tan2026autoverifix.

== Selective-hybrid execution

Selective hybrids reserve symbolic execution as an intervention in an
independently progressing search. A mapping-depth fuzzing/concolic record marks
that chronology @lyu2021fuce; its detailed mechanism is not used in the
synthesis. FuSS provides the deep-read case: a fuzzing plateau selects a
nearby RTL-CFG target, a Verilated state snapshot supplies the prefix, and a
symbolic suffix returns a new program to the corpus @jayasena2025fuss.

== What the bounded map establishes

The bounded corpus spans direct semantics, translation-based reuse, testing,
security, equivalence, HLS, and cross-level checking. Those recurring themes
make a focused survey useful. The map is relevance-capped, has parked records
and an unreconciled query, and makes no population or maturity inference.
Enlarging it with every symbolic simulator or BMC paper would change the common
operational question rather than improve this map's closure.
