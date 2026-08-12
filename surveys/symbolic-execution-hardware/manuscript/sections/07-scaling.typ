= Scaling path-conditioned hardware execution <sec-scaling>

If each of $n$ effective choices is independent, explicit path exploration can
expose $2^n$ executions. Hardware supplies new choices every cycle and can
combine independently controlled processes, symbolic addresses, environment
transactions, and state-dependent loops. Practical systems therefore decide
which paths to construct now, which constraints to reuse, and which prefix or
suffix to leave concrete.

== Guidance and one-path reconstruction

Directed concolic testing ranks candidate branch diversions by their relation
to a target rather than enumerating paths uniformly @ahmed2018directed.
Scalable RTL concolic testing strengthens this with contribution analysis and
reuse @lyu2021scalable. SEIF uses a static information-flow graph as an
overapproximate route, segments it at clock boundaries, and performs bounded
symbolic search for an executable RTL witness @ryan2023seif. These mechanisms
improve time to selected evidence; unless every target and diversion is
scheduled to completion, they do not establish absence.

Reconstructing only an observed path also limits formula size. Qin and Mishra
specialize dynamic array indices to a trace and reuse unsatisfiable cores
@qin2014interleaving. The saving comes with an obligation: constraint deletion
and trace specialization must preserve the branch diversion being claimed.

== Backward search, fragments, and summaries

Backward execution avoids enumerating every reset-to-target prefix by starting
from a security condition and constructing predecessor cycles
@zhang2018coppelia. Fragment-based execution explores blocks or modules
independently before solver-checked composition @ryan2023sylvia. Both postpone
part of the global product. Their summaries must retain enough state, time,
and interface conditions that a stitched path corresponds to a realizable
execution.

In the simple case of $N$ blocks with $b$ local binary choices, building local
trees can cost on the order of $N dot 2^b$ rather than constructing $2^(N b)$
whole paths immediately. The compatible fragment tuple space can still reach
$2^(N b)$. Construction reduction is valuable, but it should not be reported
as elimination of the composition product.

== Time abstraction and selective suffixes

HLS TCP execution replaces many concrete idle cycles with a symbolic packet
gap, reducing repeated clock paths while adding an abstraction obligation
@hu2024tcp. FuSS uses a concrete fuzzer for long prefixes and asks a solver for
only a nearby CFG suffix @jayasena2025fuss. Both succeed by preserving the
distinctions important to their observer while compressing or concretizing
others.

Hybrid handoffs add their own costs: detecting a plateau, mapping coverage to
a target, reconstructing a faithful state, solving the suffix, and replaying
the resulting test. A local solver speedup can be outweighed by these phases,
while an unreachable snapshot can yield a nonreplayable witness.

== Four cost ledgers

#figure(
  table(
    columns: (20%, 38%, 42%),
    [*Ledger*], [*Growth*], [*Representative controls*],
    [Executor], [active paths, fragments, cycles], [guidance, backward search, composition],
    [Formula], [predicate size, aliasing, theory], [slicing, caching, incremental solving],
    [Concrete frontier], [traces, seeds, coverage state], [ranking, fuzzing, handoff policies],
    [Semantic bridge], [translation, replay, harness work], [supported subsets, differential validation],
  ),
  caption: [Scaling mechanisms move cost among four observable ledgers.],
) <tab-ledgers>

The synthesis is a conservation principle, not an impossibility theorem.
Tools scale when they stop distinguishing behaviors irrelevant to the current
observer, reuse stable summaries, or spend solver effort only at difficult
boundaries. A credible claim reports all four ledgers, end-to-end time and
memory, completion status, and the distinctions deliberately omitted.
