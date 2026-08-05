= Known approaches and comparative analysis <sec-related>

The target is one exact selection-observation record per nonempty caller-input
fiber. Prior approaches become comparable only after fixing that contract.
Some can enumerate the fibers directly after instrumentation, some compile the
same finite observer into a shared representation, and some solve restricted
special cases with stronger guarantees. @tab-approaches summarizes six
recurring, non-exclusive research traditions and implementation routes. They
mix mechanisms, representations, and restrictions rather than forming a flat
taxonomy.

#figure(
  block(breakable: false)[
    #text(size: 8.2pt)[
      #table(
      columns: (1.05fr, 1.15fr, 1.2fr, 1.25fr, 1.4fr),
      align: left,
      inset: 3.5pt,
      stroke: (x: none, y: 0.4pt + rgb("c8ced6")),
      table.header(
        [*Route*], [*Discovery object*], [*Natural output*],
        [*Route to target*], [*Principal boundary*],
      ),
      [Guarded symbolic execution], [Feasible path or merged symbolic state],
        [Guarded residual], [Log demanded site outcomes],
        [Paths may refine or cross the target partition],
      [Projected model enumeration], [Selected coordinate image],
        [Models, cubes, or compiled cover],
        [Project totalized reachability/outcome coordinates],
        [Cubes may group observations; projection supplies no residual],
      [Decision structures], [Compiled finite observer],
        [Tree, BDD, ADD, or related DAG],
        [Compile the totalized observer and residual labels],
        [Compilation size and variable order can dominate],
      [Demand-guided search], [Forced inputs, choices, or values],
        [Partial map or value stream],
        [Align demand with requested-root enabled closure],
        [Often lacks exact fiber guards or residuals],
      [Geometric/parametric enumeration], [Cells, modes, or critical regions],
        [Polyhedral guard and affine map],
        [Dense signs: direct; critical regions: correspondence needed],
        [Different observers; affine and dimensional assumptions],
      [Compositional summaries], [Component relation or guarded pieces],
        [Reusable guarded summary],
        [Parameterize summaries by requested outputs],
        [Exact composition does not imply compact reuse],
      )
    ]
  ],
  caption: [Recurring solution routes expressed in the unified framework.],
  kind: table,
) <tab-approaches>

== Guarded symbolic execution

Classical symbolic execution associates path conditions with symbolic states
or substitutions. Denotational treatments make this correspondence exact
@voogd2025compositional, while multi-path execution merges paths into guarded
symbolic values @sen2015multise. Solver-aided libraries and reusable merging
semantics preserve the same basic separation between guards and residual
values @porncharoenwase2022merging @lu2023grisette.

These systems supply two parts of the target record almost directly: a
feasibility guard and a residual. They do not by themselves choose the
selection observer. Conventional paths may distinguish branches outside the
requested enabled closure, merge histories that retain different requested
events, or split one observation because of unrelated control flow. To solve
the target problem, evaluation must be demanded from the requested roots,
record contextual selection outcomes, preserve graph sharing, and block the
entire resulting fiber rather than one execution model. Output-directed and
dependence-guided symbolic execution already demonstrate that exploration can
be organized around queried values rather than complete paths
@denaro2012allvalues @wang2017dependence; the remaining obligation is exact
agreement with the declared observer.

The local generator formalized in @sec-algorithms is therefore not a new symbolic
execution paradigm. It is the target observer instantiated in a standard
guard-and-residual evaluator. Its useful property is the exact observed-outcome guard:
structurally unobserved sites require no absence literal because enabled
reachability is already fixed by the observed outcomes.

== Projected model enumeration

Phan's AllSMT enumerates satisfying assignments to designated important
Boolean coordinates while returning sampled values for relevant theory
variables @phan2015allsmtr. A finite theory-valued coordinate needs an engine
whose projection contract explicitly enumerates its values. Recent projected
SAT and SMT methods can emit disjoint partial models and avoid a
growing family of ordinary blocking clauses @spallitta2024disjoint
@spallitta2025projected. Knowledge compilation similarly supports disjoint
partial-model enumeration after d-DNNF compilation
@lagniez2024decisiondnnf.

This is the most direct generic reduction. Give every contextual selection site
a finite coordinate whose values are its outcomes plus an explicit
`unobserved` sentinel. Reachability equations connect that sentinel to
requested-root reachability. Projecting the graph formula onto those
coordinates then enumerates exactly the totalized selection observer. The
construction is conceptually complete but charges the whole-graph value, classifier,
case-membership, and reachability encodings.

The output contract still matters. Enumerating every complete projected tuple
produces one element per selection observation. A short partial cube can cover
many tuples and is therefore a compact cover of the observer image rather than
the requested record stream. Disjoint short-model methods make such covers
precise, but a consumer that requires one residual and witness per complete
observation must refine or annotate the cubes accordingly.

== Compiled decision structures

A decision tree asks only its representation tests along a root-to-leaf route.
This is not the same as a graph selection site being unobserved: a compiler may
choose entirely different input predicates. Reduced BDDs share Boolean
subfunctions canonically under a fixed variable order @bryant1986bdd, and ADDs
extend terminals beyond Boolean values @bahar1997add. Finite observer
partitions can also be generated directly as exact input-equivalence classes
or satisfiable atoms of a declared observation alphabet
@krafczyk2017effective @huang2024exhaustive.

For finite encoded inputs, compiling the function
$x mapsto overline(T)_G(x,R)$ yields an exact representation of the target
partition. Leaves or terminals may additionally carry residual identifiers and
witnesses. A tree exposes the sparse sequence of tests made along one route; a
diagram exposes shared predicates and subfunctions across many routes. Either
can be exponentially smaller or larger than a flat guard list, so a comparison
must state whether the output is a stream of records or one shared compiled
object.

Compilation also exposes a semantic choice. Reducing nodes that have equal
successors preserves the compiled observer, but compiling only the requested
output value may erase equal-valued selection events. Neural decision-tree
extraction and affine decision structures make this contrast concrete. Nguyen
et al. construct EC-DTs and report exact empirical fidelity with contradiction
pruning @nguyen2020ecdt; Affinitree proves semantic preservation and simplifies
infeasible or entailed tests @affinitree2024. They solve the selection-observation task only
when their terminals or internal labels retain the declared selection events.

== Demand-guided evaluation and search

Functional-logic implementations use stable choice identities and
demand-populated decision maps so that shared nondeterministic choices remain
consistent @brassel2007tighter @brassel2011thesis. Pull-tabbing and fair
evaluation address exhaustive value production in shared term graphs
@antoy2011pull @jost2023fairscheme. Lazy SmallCheck refines just the partial
input demanded by a Boolean observation and remains exhaustive over its bounded
domain @runciman2008smallcheck. Classical dataflow analyses compute least or
reverse demand for a fixed requested result @avron1994stability
@pingali1985efficient, and modern bidirectional demand semantics can characterize
minimal sufficient partial inputs @xia2024demand.

These results establish that dynamically sparse choices and requested-result
demand are not new. Their natural output, however, is commonly a value stream,
a partial input, a choice fingerprint, or a fixed-input demand set. The target
enumerator additionally requires the complete inverse-image guard and a
residual valid over that entire guard. A demand system becomes a direct
solution only after its demand judgment is proved equal to the enabled closure
and its fair search is grouped by complete observation fibers.

The comparison also prevents a terminology error. The base graph is not called
lazy: ordinary nodes expose all operands under a declared observation policy, while
selection sites demand only the cases chosen by their outcomes. “Demand” here
is graph-relative support for a requested observer, not an operational
evaluation strategy.

== Geometric and parametric specializations

When every selection is observed, each classifier is the strict sign of a
distinct nonconstant affine form, and the caller domain is the ambient space
with all classifier boundaries removed, a complete observation is a sign
vector and each nonempty fiber is a full-dimensional hyperplane-arrangement
cell. Reverse-search and incremental
algorithms enumerate those cells exactly with output-sensitive guarantees
@avis1996reverse @ferrez2005fixedrank @rada2018new. Exact ReLU analyses likewise
enumerate activation patterns or polyhedral regions and often attach affine
output maps @serra2018bounding @vincent2021reachable.

Multiparametric programming provides a closely related guard-and-residual
contract. Critical-region algorithms emit polyhedral parameter guards together
with affine optimizers and have explicit LP-oracle-relative bounds
@jones2006parametric @columbano2009sufficient. Piecewise-affine systems compose
upstream affine maps into downstream guards and can minimize regions with equal
behavior relative to a supplied arrangement and representation class
@geyer2010mode @geyer2008optimal.

The full-dimensional hyperplane and dense activation-pattern methods are direct
specializations under the stated observer and domain restrictions. Assigning
boundary points to a side produces closed or lower-dimensional strata and
requires separate face or ownership machinery; the cited open-cell guarantees
do not transfer automatically. Parametric critical regions instead observe an
optimizer basis or active set. They are direct only after an explicit model
shows that this identity is exactly the graph's selection observer; otherwise
they are strong guard-and-residual comparators. The full-dimensional cell
algorithms analyzed here no longer instantiate the target when nested
selections make sites unobserved, the caller predicate cuts across cells, or
equal affine maps are merged despite different observed outcomes.

== Compositional guarded summaries

Compositional symbolic execution summarizes component behavior with guarded
relations, preconditions, postconditions, or path fragments
@godefroid2007compositional @anand2008demand @voogd2025compositional. Guarded
piecewise-affine composition substitutes an upstream residual into downstream
guards and residuals while discarding infeasible conjunctions
@geyer2010mode. Selective computations supply an abstract interface for
statically visible, dynamically chosen effects @mokhov2019selective.

The unified framework adds two parameters needed by the target observer:
requested output roots determine boundary demand, and contextual prefixes
distinguish multiple component occurrences while retaining sharing within an
occurrence. Under full-domain component summaries, guard substitution and
namespaced observation union agree with flattened graph evaluation. This is an
exact compositional presentation of the same partition.

Exactness does not imply compactness. A component with many outputs can require
one summary family per demand mask, caller predicates can split component
fibers differently at different occurrences, and residual substitution can
duplicate large terms unless sharing is retained. Compositional summaries are
therefore a representation and reuse strategy, not a general improvement in
enumeration complexity.

== Cross-approach analysis

=== Observer agreement

Projected enumeration is a direct reduction after reachability instrumentation.
Candidate-local symbolic execution is a direct presentation after demanded
evaluation and grouping by exact fibers. Decision structures are direct when
they compile the totalized selection observer rather than only the output
function. Demand-guided methods are direct only after their demand relation and
grouping contract are aligned with the framework. Dense-sign geometric methods
are direct restricted specializations; parametric critical regions use a
different observer unless an explicit correspondence is established.
Compositional summaries preserve the observer only with
requested-root demand, contextual identity, and explicit interface support.

This classification is more informative than asking whether a method emits a
“partial assignment.” Structural absence is an observer value. Existential
projection hides coordinates from a formula. A logical don't-care permits
either value while preserving a represented set. Equal-residual coalescing
changes the observer through a quotient. The four operations can yield similar
syntax while inducing different fibers.

=== Guarantees and representations

The exact record contract has four independent obligations: complete
duplicate-free observation coverage, guard/fiber equivalence, residual correctness
throughout the guard, and a feasibility witness. Projected image enumeration
primarily supplies the first; symbolic evaluation supplies residuals; model
production supplies witnesses; and the framework's guard theorem connects the
local record to the semantic fiber. No route inherits all four obligations
merely from its name.

Representation is orthogonal. Flat guards favor streaming and simple APIs but
can repeat shared predicates and residuals. Trees preserve encountered-test
structure. BDDs, ADDs, d-DNNFs, and related DAGs share subproblems but charge
compilation and representation choices. Polyhedral complexes expose adjacency
that flat formulas omit. Consequently, record count alone cannot compare two
implementations that serialize different objects.

=== Complexity and applicability

The general problem has exponentially many observations, NP-hard
single-outcome feasibility, and \#P-hard counting special cases. One successful
model query per observation plus a final exhaustion query is only an oracle-call
accounting. It gives no OutputP, incremental-polynomial, polynomial-delay, or
wall-clock theorem. Geometric and parametric restrictions have genuine
output-sensitive algorithms; compiled methods may amortize enumeration after
potentially expensive preprocessing; local methods may avoid unobserved cones
but repeat solver and residual work. These are tradeoffs, not a universal
ranking.

== Adjacent reduction problems

Several broad literatures informed the observer vocabulary without providing
alternative implementations of the target contract. Partial-order reduction
omits redundant interleavings while preserving reachable states or temporal
properties @holzmann1992coverage @alur2001partialorder. Petri-net unfoldings
represent concurrent configurations, and goal-directed prefixes can preserve
all minimal configurations reaching a requested marking while omitting
irrelevant transitions @bonet2014recent @chatain2017goaldriven. Observer- and
property-guided state reduction preserves a declared event language, state
quotient, or coverage objective @aronis2018observers
@bugrara2013redundant. These works confirm the general lesson that omission is
observer-relative, but their outputs are runs, markings, states, or search
objectives rather than caller-input fibers with residual functions.

Whole-network dataflow semantics similarly supplies important boundaries for
determinism, stability, and compositionality, but usually observes streams,
traces, or network behavior rather than finite requested-root selection maps.
The main comparison therefore uses fixed-input least-demand results where they
directly explain enabled closure and leaves the broader semantic lineage in the
repository synthesis.

== Answers to the comparison questions

*RQ1.* The common object is a finite observer on caller inputs. Its nonempty
inverse images are fibers, and an exact record attaches a guard, residual, and
witness to each fiber. This distinguishes semantic partitioning from the
algorithm and data structure used to expose it.

*RQ2.* The included approaches organize into six recurring, overlapping routes. Local
guarded evaluation and global projected enumeration are equivalent general
presentations; decision structures compile the observer; demand-guided methods
supply sparse discovery mechanisms; dense-sign geometric methods solve a
restricted affine specialization; and guarded summaries provide composition.

*RQ3.* General exactness follows only after all four record obligations are
proved. General output-sensitive complexity does not follow from sparse demand
or one model per fiber. Stronger bounds belong to restricted geometric,
parametric, or compiled inputs and must charge their representations.

*RQ4.* Approaches induce the same fibers when their observer kernels agree
after explicit instrumentation. Their labeled images and record schemas then
correspond only after an explicit image bijection. Coordinate projection,
equal-behavior merging, path
refinement, and property-guided search otherwise produce coarser, finer, or
incomparable partitions. This observer test is the framework's primary rule for
transferring results across terminology.
