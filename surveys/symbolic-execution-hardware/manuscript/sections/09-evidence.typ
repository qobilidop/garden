= Evaluation practice <sec-evidence>

The critical deep-read set contains promising systems evidence, but its
comparisons rarely share a common unit. These studies choose different design
families, cycle bounds, harnesses,
coverage metrics, defect sets, and timeout policies. A speedup can measure
executor construction, solver time, or end-to-end test generation; a path
count can mean active states, completed traces, fragments, or target-specific
attempts.

== What the critical studies measure

The early SE4RDV case study reports roughly four thousand generated tests,
wall time, resource percentages, and high statement/branch coverage on one
OpenCores floating-point unit @zhang2016rtltests. It has no competing baseline
and cannot establish general scalability. Directed concolic testing evaluates
target reachability across RTL designs and compares guidance strategies
@ahmed2018directed. Scalable concolic testing broadens the benchmark set and
reports coverage, test generation, and runtime improvements, but results still
depend on branch targets and chosen temporal settings @lyu2021scalable.

Sylvia studies five designs and 84 properties, separating local path-fragment
construction from feasibility of composed paths @ryan2023sylvia. Its fragment
reduction is real, while the full fragment cross-product remains the relevant
worst-case solver boundary. SEIF reports sampled-path accounting, bounded
search strategies, cycle depth, wall time, and two full source-signal security
case studies on four designs @ryan2023seif. Its three-way accounted,
unaccounted, and falsified classification makes partial completion visible.

The hybrid studies measure the complementarity of fuzzing and concolic search.
GreyConE reports branch coverage and time across compiled SystemC designs
@debnath2022greycone. FuSS reports coverage progress, target resolution, and
bug-related outcomes for selective symbolic assistance on RTL models
@jayasena2025fuss. Among the critical studies, Rudkowski et al. provide an
unusually broad cross-level metric set: two implementations, multiple
peripherals, functionality and interface
tests, mutation analysis, paths, solver fraction, memory, queries, timeouts,
and ablations @rudkowski2026crosslevel. This evidence comes from the full arXiv
pre-publication text aligned with the 2026 journal article; its negative
scalability results are as informative as its completed cases.

The 2026 Forbench preprint compares symbolic simulation, STE, model checking or search tools,
and concrete simulators on datapath and processor designs
@yang2026-forbench. It also contrasts testbench-level forking with a prior
path-oriented processor setup. The reported runtime and coverage results
support an implementation claim; the central usability claim remains
unmeasured because there is no user study or harness-effort comparison.

== Four recurrent comparability failures

First, *scale* is underspecified. Source lines, gates, registers, branches,
modules, and generated instructions are not interchangeable. At minimum,
papers should report a structural vector and the unrolled temporal depth.

Second, *completion* is blurred. Paths reached before a timeout and paths
proved infeasible belong in different columns. A 24-hour run that explores a
large frontier is evidence of progress, not exhaustive coverage.

Third, *harness labor* is absent from the critical studies' reported metrics.
Testbench conditions, target annotations,
properties, environment models, abstractions, and manual slices can dominate
adoption cost. Tool runtime alone does not measure verification effort.

Fourth, *baselines solve different contracts*. Concrete simulation samples one
trace, BMC may prove a bounded property, concolic execution pursues branches,
and merged symbolic simulation covers valuations without preserving every
path. A fair comparison states the shared output goal before comparing time.

== Recommended evaluation bundle

A reusable benchmark result should publish design/version and license;
executed representation and translation commands; reset and environment
harness; symbolic inputs and cycle depth; target/coverage denominator;
completed, infeasible, timed-out, and unaccounted outcomes; executor, solver,
and end-to-end time; peak memory; query count and solver share; witness replay
rate; and human setup effort. Repeated stochastic runs need dispersion and
seed policy. Mutation studies need the mutation operators, excluded mutants,
and relation between a kill and a real defect claim.

These fields would not force architectural uniformity. They would make it
possible to distinguish faster construction from a weaker contract and to
compare like evidence across path, merged-state, and hybrid systems.
