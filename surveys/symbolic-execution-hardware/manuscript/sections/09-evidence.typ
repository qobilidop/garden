= Evaluation practice and evidence strength <sec-evidence>

The 17 deep-read studies demonstrate functioning implementations and reported
positive outcomes on their evaluated configurations. They do not establish
implementation correctness, general effectiveness, or a single quantitative
ranking. Designs, horizons, coverage definitions, setup effort, baselines, and
completion policies differ too much for a defensible meta-analysis.

== Range of evidence

Early translation-based work is feasibility evidence. V2C compares
path-symbolic execution with BMC and abstract interpretation on selected
hardware properties @mukherjee2015software. SESC evaluates several small
SystemC designs with path/test counts, coverage, time, and memory
@lin2016systemc. SE4RDV reports about 4,010 tests and 98.4 percent statement and
96.8 percent branch coverage on one OpenCores FPU, without a competing
test-generation baseline @zhang2016rtltests. These results establish workable
architectures, not industrial generality.

Among the deep reads, directed concolic work provides multi-design comparative
evidence. Ahmed et al.
measure iterations, time, and memory against bounded model checking and two
concolic strategies across benchmark targets, while preserving an explicit
cycle bound @ahmed2018directed. Scalable concolic testing broadens designs and
guidance comparisons @lyu2021scalable. AutoVeriFix+ reports near-complete
branch coverage on generated RTL benchmarks, but the preprint's “exhaustive”
language exceeds its timeout, state-explosion, and generated-oracle caveats
@tan2026autoverifix.

Several security deep reads have compelling positive outcomes. Coppelia reports
29 of 31 known vulnerabilities rediscovered and four new processor-design
vulnerabilities, with generated exploits replayed @zhang2018coppelia. SEIF
measures accounted, witnessed, rejected, and unaccounted information-flow
paths over four designs; one full source-signal analysis lasts 3.5 days
@ryan2023seif. EISec reports possible netlist-flow witnesses, but its
under-constrained initialization and translation limit the word “exhaustive”
@fowze2022eisec.

Concolic and selective-hybrid execution demonstrate complementarity rather
than completeness. Qin and Mishra compare trace-reconstructed solving with
random testing and a prior hybrid on bounded designs @qin2014interleaving. FuSS reports branch and
toggle coverage trajectories on four RISC-V SoCs @jayasena2025fuss. The HLS
TCP thesis generates 67 symbolic tests for 47.47 percent source coverage,
nearly the same final percentage as 2,150 random tests, while also exposing
specific failures and reducing paths with a clock abstraction @hu2024tcp.

Among the 17 deep reads, the cross-level SystemC study reports the widest
combination observed here of evaluation dimensions: two
implementations, four dual-level peripherals, functionality and interface
tests, 357 selected mutants, ablations, a prior-tool comparison, and five
larger modules @rudkowski2026crosslevel. Its negative evidence is important:
many larger cases hit 24-hour, memory, or solver-query limits. Paths at timeout
measure progress, not verification coverage. The RISC-V co-execution case
similarly finds real mismatches but includes a run lasting 586,905 seconds
@bruns2023processor.

== Recurrent comparability failures

First, *scale* is not a scalar. Source lines, gates, registers, branches,
processes, and generated instructions measure different structures; all must
be paired with temporal depth. Second, *completion* is blurred: feasible,
infeasible, timed-out, unaccounted, and never-scheduled paths need separate
columns. Third, *baselines solve different contracts*: simulation samples,
concolic search pursues branch diversions, and BMC asks a bounded property
query. Runtime alone does not equalize their outputs.

Fourth, *human and semantic effort* is largely absent. Testbench construction,
reset modeling, target annotation, translation repair, abstraction, and
reference-model debugging can dominate adoption cost. Fifth, stochastic
systems in the reviewed evidence omit repeated-run dispersion and seed policy.
Finally, artifact
availability and semantic conformance are rarely strong enough to separate a
search failure from a modeling failure.

== Recommended evaluation bundle

A reusable result should publish design/version and license; structural scale;
executed representation and translation commands; reset, clock, and
environment harness; symbolic inputs and temporal depth; target denominator;
feasible, infeasible, timed-out, unaccounted, and unscheduled outcomes;
executor, solver, and end-to-end time; peak memory and query count; replay
rate; stochastic seeds and dispersion; and human setup effort. The
seven-element result tuple from @sec-contracts should accompany these
metrics. This bundle enables like-for-like comparison without pretending that
all tools answer the same verification question.
