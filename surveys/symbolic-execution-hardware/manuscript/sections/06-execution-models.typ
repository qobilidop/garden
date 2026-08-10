= Where alternatives live <sec-execution-models>

The most informative architectural question is not "does the tool use SMT?"
but "where does it store mutually possible behaviors?" The solver is common;
the representation offered to it is not.

== Whole paths

A classical executor maintains states such as $(ell, sigma, pi, t)$: program
location, symbolic store, path condition, and hardware time. A symbolic branch
creates successor states with $pi and c$ and $pi and not c$; infeasible
successors are pruned. This representation makes witness reconstruction and
target guidance natural. It also duplicates shared work and exposes the
product of branches across processes and cycles.

Translation-based RTL execution uses whole paths through generated code
@zhang2016rtltests. Direct concolic testing often records only the current
concrete path and generates a successor by changing a selected branch
constraint @ahmed2018directed. Online and offline styles have different memory
profiles, but both identify alternatives by path predicates.

== Path fragments

Fragments delay the cross-product. Sylvia explores one tree per sequential RTL
block and composes a tuple of fragments only when checking full-design
feasibility @ryan2023sylvia. If $N$ blocks each contain $b$ independent binary
branches, fragment construction can scale like $N 2^b$ instead of
$2^(b N)$. The feasible tuple space can still be $2^(b N)$; composition and
solver work therefore remain separate costs. Fragments save construction and
enable reuse without turning an exponential behavioral product into a linear
one.

Cross-level systems can also use fragments, summaries, or staged models around
component boundaries @rudkowski2026crosslevel. Their correctness requires a
composition rule: compatible local path conditions, stores, time indices, and
interface observations must correspond to a realizable global execution.

== Guarded symbolic values

Symbolic simulation represents alternatives inside expressions. An assignment
under condition $g$ can update $v$ to $"ite"(g, v_"new", v_"old")$; an event queue can
merge compatible executions by disjoining their controls @kolbl2001rtl.
Functional-space partitioning makes the same choice explicit as a list of
mutually exclusive guard/data pairs @feng2004dynamic. This can exploit shared
structure and solver simplification, especially in datapaths.

Merging changes the observable identity of paths. Two branch histories that
produce the same simplified value may become indistinguishable unless the tool
retains provenance separately. That is often desirable for functional
verification and undesirable for branch-coverage accounting. Expression size,
BDD order, ITE nesting, and query difficulty replace active-state count as the
resource bottleneck.

== Abstract symbolic states

We retain *abstract symbolic state* as a descriptive map category for selected
STE and related records, not as a survey-backed soundness theorem. It denotes
an execution state intentionally coarser than individual concrete valuations;
the guarantee of any such system depends on its own abstraction relation and
must be read from that system's semantics.

Forbench combines word-level symbolic state with explicit testbench forks
@yang2026-forbench. Its key choice is to keep design branches merged and split
only when a testbench condition affects procedural control. This architecture
reminds us that the observer determines the partition: design branch coverage,
output correctness, and testbench progress need not require the same splits.

== Concrete/symbolic hybrids

Concolic and fuzzing hybrids keep one or a population of concrete traces as the
cheap frontier, then invoke symbolic reasoning selectively. Directed concolic
testing targets an uncovered RTL branch @ahmed2018directed. GreyConE hands
stalled SystemC-model coverage from fuzzing to concolic solving
@debnath2022greycone;
FuSS selects a logic cone or target for symbolic assistance
@jayasena2025fuss. The representation is distributed among concrete corpus,
coverage map, symbolic slice, and solver query.

A hybrid's guarantee is the union of its phases, not the strongest phase in
isolation. If target selection or slicing omits a behavior, exact constraint
solving inside the chosen slice does not recover global completeness. A paper
should therefore state which transitions cause mode changes and whether
concretized choices can later be reconsidered.
