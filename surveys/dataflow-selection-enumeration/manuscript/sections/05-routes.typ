= Solution routes <sec-routes>

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
      columns: (17%, 19%, 20%, 21%, 23%),
      align: left,
      inset: 3.5pt,
      stroke: (x: none, y: 0.4pt + luma(200)),
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
or substitutions @king1976symbolic, while DART established the later
concrete-plus-symbolic, solver-directed test-generation lineage
@godefroid2005dart. Denotational treatments make this correspondence exact
under their stated language and merge conditions
@voogd2025compositional, while multi-path execution merges paths into guarded
symbolic values @sen2015multise. Variational execution similarly carries
conditional values under configuration contexts and shares computation across
many configurations, but its native result is a shared multi-configuration
execution rather than one exact inverse-fiber record @wong2018variational.
Solver-aided libraries and reusable merging semantics preserve the same basic
separation between guards and residual values @porncharoenwase2022merging
@lu2023grisette.

These systems supply two parts of the target record almost directly: a
feasibility guard and a residual. They do not by themselves choose the
selection observer. Conventional paths may distinguish branches outside the
requested enabled closure, merge histories that retain different requested
events, or split one observation because of unrelated control flow. To solve
the target problem, evaluation must be demanded from the requested roots,
record contextual selection outcomes, preserve graph sharing, and block the
entire resulting fiber rather than one execution model.

The closest published algorithms make this gap narrow. PESO enumerates
reordered relevant-slice conditions for requested output criteria, carries
symbolic outputs and solver-generated tests, and proves conditional exploration
completeness under a sound and complete solver @qi2013output. SPD constructs a
shared graph of dependence-relevant path families and guarded symbolic values
for queried uses @santelices2010dependencies. All-values and dependence-guided
execution provide further output/value-directed precedents
@denaro2012allvalues @wang2017dependence. What remains open is not whether
output-directed guarded exploration exists, but whether PESO's RSC quotient or
SPD's path-family graph, after site instrumentation, gives exactly one target
selection fiber rather than a refinement or fragmented cover.

SEDGE is the closest explicitly dataflow-named concolic testing comparator: it
uses SMT to synthesize high-level Pig inputs intended to exercise operator
cases. Its coverage target and accumulated example dataset are not a
duplicate-free exact partition with residuals @li2013sedge.

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
$x mapsto T^"tot"_G(x,R)$ yields an exact representation of the target
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

Functional-logic set functions and pull-tabbing establish the representation
lineage most directly: set functions record the nondeterministic steps actually
executed, the 2010 pull-tab transformation propagates immutable choice
identifiers so runtime copies make consistent decisions, and memoized
pull-tabbing finally exposes an explicit task-local partial choice map
@antoy2009setfunctions @alqaddoumi2010pulltab @hanus2021memoized. Other
pull-tabbing, translations, and memoization use
demand-populated decision maps or prove value-set preservation under their own
search assumptions @brassel2007tighter @antoy2011pull @brassel2011thesis
@hanus2021memoized @jost2023fairscheme.
Lazy SmallCheck refines just the partial input demanded by a Boolean observation
and remains exhaustive over its bounded domain @runciman2008smallcheck. SPLat
similarly discovers configuration variables on first read, uses SAT to prune
feature-model-infeasible partial assignments, and executes concrete witnesses
for distinct claimed test traces @kim2013splat. Classical dataflow analyses compute least or
reverse demand for a fixed requested result @avron1994stability
@pingali1985efficient, and modern bidirectional demand semantics can characterize
minimal sufficient partial inputs @xia2024demand.

These results establish that stable sparse choice maps, dynamically discovered
configuration decisions, and requested-result demand are not new. Their natural
output, however, is commonly a value stream, a partial input, a choice
fingerprint, a concrete test trace, or a fixed-input demand set. The target
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
output maps @serra2018bounding @vincent2021reachable; star-set reachability
and explicit piecewise-affine conversion emit exact guards with affine
images, and cell-complex, edge-subdivision, and parallel layerwise variants
recover richer exact structure @tran2019star @robinson2020dissecting
@masden2022algorithmic @berzins2023polyhedral @drammis2024parallel.

Multiparametric programming provides a closely related guard-and-residual
contract. Critical-region algorithms emit polyhedral parameter guards together
with affine optimizers and have explicit LP-oracle-relative bounds, building
on the positive-semidefinite pLCP precursor
@jones2006lcp @jones2006parametric @columbano2009sufficient. Piecewise-affine systems compose
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

These routes overlap rather than form a ranking. @sec-synthesis compares their
observers, guarantees, applicability, and closest established boundaries.
