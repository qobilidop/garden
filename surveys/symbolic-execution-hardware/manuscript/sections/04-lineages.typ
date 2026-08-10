= Two lineages, then coexistence <sec-lineages>

== Symbolic simulation starts at the machine

Carter, Joyner, and Brand's 1979 paper is the earliest hardware-specific work
located by this campaign that explicitly relates its method to program
symbolic execution. It compares formal descriptions of a machine architecture
and its RTL implementation using symbolic values, aiming at correctness and
error discovery beyond ordinary test cases @carter1979symbolic. The important
historical point is not priority over every possible antecedent; it is that
machine design was already an independent home for symbolic execution ideas.

The hardware lineage usually avoids a separate executor state for every design
branch. Symbolic values encode many concrete valuations; Boolean controls
propagate through circuit structure. We use STE only as the field's neighboring
trajectory-evaluation label and do not infer its proof semantics from the
mapping-depth records. Symbolic RTL simulation later brings guarded values into
event-driven Verilog. Kölbl et al. carry a Boolean control condition through
branches, merge assignments with ITE, accumulate compatible scheduled events,
and retain enough guarded occurrence information to replay an error
@kolbl2001rtl. Worst-case growth remains exponential, but its location is an
expression or event representation rather than necessarily a visible path
tree.

Dynamic functional-space partitioning illustrates another point on this
lineage. It represents a circuit value as mutually exclusive guard/data pairs
and selectively splits at multiplexers when a monolithic BDD grows too large
@feng2004dynamic. The technique makes a recurring trade explicit: fewer
executor states can mean larger symbolic values, while partitioning symbolic
values can recreate a path-like product under another name.

== Path and concolic execution arrive through software tooling

The second lineage applies the classical software architecture more directly.
Zhang, Feng, and Huang translate Verilog with Verilator, construct a C++
harness, modify KLEE for arbitrary RTL bit widths, and replay generated tests
against the original RTL @zhang2016rtltests. Alternatives are paths through the
generated program, and time is a chosen number of calls to the generated
`eval()` function. This architecture gains mature solver and search machinery
but inherits a semantic bridge: the guarantee is relative to Verilator's
model, the harness, and the cycle bound.

Hardware concolic work combines fast concrete simulation with selective
symbolic constraint solving. Directed concolic testing can start from a
concrete RTL trace, locate a branch relevant to a target, negate or manipulate
its accumulated condition, and solve for the next test @ahmed2018directed.
Scalable variants reuse module-level behavior, cache or rank constraints, and
guide exploration toward uncovered statements or security-relevant targets
@lyu2021scalable. This lineage makes concrete tests the normal output; any
completeness claim is correspondingly a claim about the search schedule,
bound, and modeled branch semantics.

== Mechanisms coexist in the modern field

Recent systems recombine operations that a simple path-versus-merged-state
split would keep apart, but this is an organizing interpretation rather than a
claim that every system inherits both historical lineages. Sylvia executes RTL
paths but explores sequential blocks independently, then asks SMT whether
fragment combinations compose into feasible full-design executions
@ryan2023sylvia. SEIF overlays a static information-flow graph on RTL symbolic
execution, using graph paths as landmarks and retaining an explicit
"unaccounted" class for bounded searches @ryan2023seif. FuSS lets fuzzing cover
cheap behaviors and invokes selective symbolic execution on a cone around
stubborn targets @jayasena2025fuss. Forbench is the clearest bridge in the
critical set: it retains merged symbolic design states but adds explicit forks
when a procedural testbench must branch on a symbolic condition
@yang2026-forbench.

The resulting field is best understood as a design space, not a succession in
which newer path execution replaces older symbolic simulation. Modern tools
choose where to split, what to merge, which representation to execute, and
which obligations to discharge symbolically. The two lineages provide useful
extreme points; selected practical systems occupy positions between them
without establishing a universal historical convergence.
