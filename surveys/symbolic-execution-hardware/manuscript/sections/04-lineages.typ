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

Security work broadened both direction and output. Test-pattern construction
targeted hardware Trojans @shen2018trojan; recursive and backward execution
generated processor-level exploit witnesses @zhang2018recursive
@zhang2018coppelia. Later systems explored coupled hardware/software paths,
gate-level information flows, statically guided RTL flows, processor/ISS
mismatches, and independently constructed RTL fragments
@mukherjee2020coverif @fowze2022eisec @ryan2023seif @bruns2023processor
@ryan2023sylvia. The latest boundary expands to hardware-specific HLS source
and cross-level SystemC peripherals @hu2024tcp @rudkowski2026crosslevel.

== Concolic execution

The concolic line centers concrete traces as the path-selection mechanism.
QUEBS qualifies events for coverage-oriented diversion, while factored
execution reduces the constraints solved for each RTL test @lyu2017quebs
@pinto2017factored. SystemC and directed RTL variants then use branch targets,
CFG distance, and concrete scheduling traces to select the predicate to alter
@lin2018ctsc @ahmed2018directed. Multi-target activation extends that search
unit from one branch to a set, and selective SystemC execution applies it to
Trojan triggers @lyu2019multitarget @lin2020selective.

Subsequent work scales or repurposes the same loop: scalable RTL concolic
testing, asynchronous-reset security checking, concolic equivalence coverage,
and incremental RTL exploration all retain concrete execution plus symbolic
path feasibility @lyu2021scalable @lyu2021soccar @roy2023slec
@zheng2024incremental. AutoVeriFix+ embeds the mechanism inside an LLM-driven
RTL repair workflow: it records cycle-indexed paths, negates an uncovered
branch predicate, solves a test, and re-simulates it @tan2026autoverifix.

== Selective-hybrid execution

The selective-hybrid works make symbolic execution an expensive intervention
rather than the default engine. Trace reconstruction first appeared as
interleaving concrete HDL simulation with symbolic constraints
@qin2014interleaving. Restrictive execution selected one cycle and a relevant
trace slice @bagri2015restrictive. Security-oriented systems later alternate
concrete simulation and symbolic activation, target assertions, or combine
fuzzing with concolic solving @ahmed2018trojan @jayasena2021assertions
@lyu2021fuce. FuSS localizes symbolic work further: a fuzzing plateau selects a
nearby RTL-CFG target, a Verilated state snapshot supplies the prefix, and a
symbolic suffix returns a new program to the corpus @jayasena2025fuss.

== What the map says about field size

The corpus is sustained rather than accidental: it spans direct semantics,
translation-based reuse, testing, security, equivalence, HLS, and cross-level
checking. Yet it remains concentrated in a few research groups, artifacts, and
recurring toolchains. That combination is the right scale for a focused
survey. Enlarging it with every symbolic simulator or BMC paper would create a
bigger bibliography but destroy the common operational question.
