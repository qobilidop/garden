= Related work and synthesis <sec-related>

The closest literature is not one lineage with changing terminology. It is a
set of constructions that preserve different observers while producing
superficially similar partial assignments, guards, or residuals. This section
organizes those constructions by the information they retain and states the
reduction or boundary in each case.

#block(breakable: false)[
  #text(size: 8.1pt)[
    #table(
      columns: (0.85fr, 1.25fr, 1.15fr, 1.4fr, 1.45fr),
      align: left,
      inset: 3.5pt,
      stroke: (x: none, y: 0.4pt + rgb("c8ced6")),
      table.header(
        [*Lineage*], [*Primary object*], [*Information omitted*],
        [*Established result*], [*Boundary here*],
      ),
      [Symbolic execution], [Path or guarded residual],
        [Merged or irrelevant paths], [Exact guarded behavior],
        [Different event observer],
      [Projected enumeration], [Selected-coordinate models],
        [Unprojected variables], [Complete projected image],
        [Sparse map requires totalization],
      [Demand-guided search], [Forced inputs or choices],
        [Unforced structure], [Complete or fair values],
        [Usually no exact fiber residual],
      [State/loop reduction], [Reduced markings, runs, or sibling states],
        [Symmetric/bisimilar states; redundant interleavings or patterns],
        [Exact quotient or heuristic postponement],
        [State space or search order, not input fiber],
      [Directed path search], [Branch under path context],
        [Repeated or target-failing contexts], [Coverage or target heuristic],
        [No exhaustive observer partition],
      [Trees and diagrams], [Reached tests or compiled function],
        [Skipped tests; shared subfunctions], [Exact finite observer],
        [Flat guards can lose sharing],
      [Neural trees/TADS], [Feasible PWL policy regions],
        [Infeasible or entailed tests], [Exact guard/map or action tree],
        [Fixed neural/PWL architecture],
      [BNN diagrams], [Requested class function],
        [Hidden activations], [Exact BDD/SDD compilation],
        [Finite binary extensional output],
      [Geometric/PWA], [Cells or affine modes],
        [Equal-map cells after quotient], [Exact region traversal/composition],
        [Affine, dimensional assumptions],
      [This synthesis], [Requested-root event fiber],
        [Unreached case cones], [Equivalent local/global presentations],
        [Finite typed pure DAG],
    )
  ]
]

== Symbolic execution and guarded residuals

Classical symbolic execution partitions inputs by feasible control-flow
histories. Denotational treatments make each path condition and symbolic
substitution a semantic piece @voogd2023denotational. MultiSE instead merges
paths into value summaries whose alternatives are guarded symbolic
expressions; in the exact setting those guards are disjoint and exhaustive
@sen2015multise. Reusable symbolic interpreters and compositional merging
frameworks further show that purity, library structure, and normalized guarded
values do not by themselves define a new semantic object
@porncharoenwase2022merging @lu2023grisette.
Conditional-compilation analysis and its conditional-value rewrite semantics
predate these systems: nested guarded macro values compute exact source-
presence conditions without enumerating feasible preprocessor paths
@hu2000conditional @latendresse2003conditional @latendresse2004rewrite. They supply an exact
conditional-value precedent, but its observer is compilation presence rather
than runtime selection behavior.
Much earlier, the global value graph compactly represented symbolic expression
values together with their flow across arbitrary control-flow graphs
@reif1977globalvalue. Dataflow-network semantics also studies schematological
equivalence, including partially interpreted networks
@rabinovich1996schematological @rabinovich1997partial. These are graph-native
symbolic sharing and network-equivalence precedents, not input partitions
indexed by requested internal observations.

Selection observations choose a particular intensional quotient of these
executions. They discard ordinary control history, retain the outcome of every
observed selection site even when alternatives have equal residuals, and omit
a site only when it lies outside the enabled closure. All-values symbolic
execution and dependence-guided multipath techniques can avoid exploring
branches irrelevant to selected program values @denaro2012allvalues
@wang2017dependence, but their requested variables, CFG paths, and equivalence
criteria differ from this graph observer. The contribution here is therefore
not disjoint guarded residuals; it is the explicit correspondence between one
declared site observer, its exact local fiber, and its projected encoding.
General symbolic path simulation has also been embedded as a feasibility
service inside path-sensitive interprocedural dataflow analysis
@hampapuram2005pathsimulation. That integration answers client path queries;
it does not emit the complete requested-event image and inverse input fibers.
Symbolic simulation has separately been applied directly to synchronous
programs @garriou2002synchronous and extended to synchronous dataflow programs
with timers @baudart2019timers. That language model is close to this paper's
dataflow setting, but its output remains symbolic executions rather than a
sparse requested-site observation partition.
Synchronous dataflow language design also has explicit transparency and
compositionality lines @cheung2021transparent @benveniste2000compositional.
Their semantic and compilation boundaries organize whole program networks;
they do not derive an input-indexed sparse map at one requested result.

Delayed-choice execution is an especially instructive neighbor. A bounded
nondeterministic value remains in a shared suspension until a non-copy use
forces a concrete alternative, preserving reachable visible states while
avoiding unused choices @gligoric2008delayed. Concrete forcing still separates
values that induce the same selector outcome and can enumerate values where
our residual remains symbolic. Structural observation, concrete forcing, and
logical relevance are consequently three different omission rules.

Heap symbolic execution supplies a stronger conditional-value predecessor.
Case-optimal bounded heap exploration already retained one non-isomorphic heap
configuration per strong-property case @deng2007caseoptimal.
Symbolic initialization places null, fresh-object, alias, and uninitialized
possibilities in guarded value sets inside one heap instead of forking the
generalized-symbolic-execution (GSE) tree; a bisimulation proves exactly the
same feasible control-flow sequences
@hillery2016heap. POSE later represents alias alternatives with `ite`-valued
fields and empirically targets one symbolic trace per program path
@braione2026pose. Its authors explicitly leave formal soundness and
completeness relative to GSE open, so the construction and experiments must not
be upgraded to an equivalence theorem. Both works establish up-front merging
of conditional input structure, but partition by program control rather than
the requested selection observer.
Conversely, path-minimal-object generation constructs only the object
properties needed to replay one selected TypeScript path
@menshutin2025pathminimal. That is sparse path-relative input synthesis, not an
exhaustive partition over all observations.

State-space and exploration quotients provide two further boundaries. The
well-formed colored-net symbolic-reachability lineage begins at least with the
1991 construction and its expanded journal treatment: it groups markings by
encoded color symmetries while preserving the represented reachability
analysis; constraint-based variants extend the quotient toward asymmetric
models, and partial-symmetry constructions interpolate between them
@chiola1991wellformed @chiola1997srg @haddad1995partial @capra2005colored. A recent symbolic-execution
framework instead explores canonical orbit representatives of symmetric
embedded-system states and states quotient-soundness and constraint-reuse
results, while limiting empirical validation to a toy prototype
@iavich2026symmetry.

Partial-order reduction supplies a much older and broader exact omission
lineage. Coverage-preserving reductions remove redundant concurrent sequences
while retaining full reachable-state coverage @holzmann1992coverage. Later
symbolic methods use BDDs or SAT/SMT independence conditions and can preserve
local properties, LTL without next, or a representative set with no redundant
interleavings under the method's declared optimality criterion
@alur2001partialorder @bhattacharya2005symbolicpor @kahlon2009mpor
@vandermeulen2011por. Concolic DPOR applies the same schedule quotient during
test generation @saarikivi2012dpor. SymPaths is closer still: it records
scheduling events in symbolic paths and proves correctness and completeness of
the reduced symbolic semantics relative to concrete multithreaded executions
@deboer2020sympaths. These are exact schedule quotients, not caller-input
fibers; approximate POR makes that boundary explicit by parameterizing
approximately commuting actions and nearby initial states @fan2018approxpor.
Lazy happens-before sharpens the same boundary by ignoring mutex-only edges to
obtain a more precise schedule-state equivalence than ordinary happens-before
@thomson2015lazy.
Other observer-sensitive POR precedents relax which actions count as visible
under a checked property, or soundly approximate may-happen-before from static
field accesses and the current dynamic state to omit unnecessary scheduling
choices @peled2001relaxedvisibility @parizek2014approxhb. Explicit task-level
happens-before constraints can instead be analyzed into a static abstraction
that classifies task pairs as sequential, exclusive, or parallel
@angerer2010schedule. These are property or schedule observers, not caller-
input partitions.
The same distinction persists in stubborn-set refinements: safety properties
or state-property questions drive the reduction @hansen2016safety
@kristensen2006question, transparent and optimal variants sharpen which
representatives can be omitted @siegel2012transparent @valmari2011optimal,
and property automata can direct both POR and search @jensen2022automata.
Earlier and parallel variants specialize stubborn sets to standard, linear-
time, simple linear-time, or combined state/event temporal properties
@schmidt1999standard @varpaaniemi2005linear @lehmann2012simplelinear
@benes2011stateevent.
Those methods preserve a model-checking question over schedules; they do not
derive an inverse partition of all caller inputs for a selected graph event.

More directly, optimal DPOR with observers makes dependencies conditional on
future reads or receives, covers every maximal observational-equivalence class,
and emits no equivalent maximal schedules twice @aronis2018observers. Its
context-sensitive journal successor combines that observer relation with
state-relative commutation and reports exponential reductions over either
ingredient alone @albert2023dpor. Thus exact observer-relative omission and
duplicate-free enumeration are established even beyond ordinary independence;
the quotient coordinate is still a concurrent schedule, not a caller input.
Reads-from and reads-value-from quotients sharpen the observation dimension:
they retain a representative according to which value a read sees, with the
latter sometimes exponentially coarser while preserving local-safety coverage
@abdulla2019readsfrom @agarwal2021rvf. Canonical symbolic configurations can
also group distributed states and interleavings together @pick2023psym.
Maximal-causality reduction claims one execution per largest causal class and
a provably minimal execution count @huang2015mcr. It has also been extended to
TSO and PSO, while a later variant uses static dependency analysis to reduce
the causal constraints without silently accepting the redundancy that the
analysis can introduce @huang2016mcrtso @huang2017staticmcr.
An independent weak-memory line models thread scheduling and store-buffer
nondeterminism together to give sound DPOR under TSO and PSO; its optional
buffer bound is explicitly incomplete @zhang2015relaxeddpor.
Value-happens-before instead
groups same-valued observations, can be exponentially coarser than happens-
before, and admits polynomial time per class for bounded threads
@chatterjee2019valuecentric.
Dynamic cone-of-influence reduction is closer to a requested-observer
criterion because relevance changes with the checked property, state, and
interleaving @telbisz2025coi; it preserves one property judgment rather than
enumerating every observer value and inverse input fiber.
At a component boundary, interface grammars compile allowed nested call
sequences and semantic constraints into environment stubs for modular model
checking @hughes2008interface. This is an analyst-supplied interface observer,
not a derived partition of caller inputs.

Colored-net symbolic unfoldings provide another true-concurrency
representation: they avoid materializing every independent-action interleaving
and commute with component product @chatain2010factorization. Color quotienting
and impossible-place-color removal can additionally produce a bisimilar
unfolded net @bilgram2023unfolding. Other state reductions replace an acyclic
implicit-transition subnet by basis markings or compute maximum bisimulation
through fully symbolic partition refinement @ma2017basis
@mumme2013bisimulation @dovier2002rank @wimmer2006sigref. The BDD lineage
predates those works @bouali1992symbolicbisim; later parallel signature
refinement improves quotient construction and representation
@vandijk2018multicore. Importantly, whole-system bisimulation minimization can
cost more than direct symbolic invariant checking @fisler2002bisimulation, so
exact quotienting alone implies no practical advantage.
Time-anonymous-token analysis instead merges timestamps assessed as irrelevant
to future timed behavior, with minor information loss explicitly disclosed
@bellettini2011time. Partial-observation estimators address the dual question
of which Petri-net states remain possible. Event-based state estimators predate
the later exact formulations @giua1997estimators. Fixed-structure linear
constraints can characterize exactly the current markings consistent with an
observed label word @giua2003marking @corona2003observers, while a related
algorithm returns every minimum-total-token _initial_ marking consistent with
that word @li2013minimum. Contact-free silent transitions admit an exact
fixed-structure linear characterization @giua2005state, and representative-
marking graphs recover a complete consistency set from a smaller basis plus
linear systems @ma2017representative. A reduced online observer goes further
representationally: it enumerates only minimal explanations and basis markings,
whose unobservable reach is exactly the complete current-marking estimate
@jiroveanu2008monitoring. Contact-free silent transitions, minimal
explanations, token-number prediction, and time-label constraints extend the
minimum-initial-state line under different assumptions @ruan2019unobservable
@yue2024minimal @yue2025prediction @li2026minimumstate. Observed state-class
graphs and hierarchical bases address timed or silent current-state estimation
@li2024timedstate @ghazel2009observer @ma2021hierarchical
@aguirre2008observability. The original modified state-class-graph estimator
for silent timed transitions is retained with a correction caveat rather than
an unqualified completeness claim @basile2013timedmarking. A later linear
formulation returns the complete timed marking set without the full state-class
graph @ma2020timedmarking, and a region observer treats timed automata with no event observation
@gao2020noevent. A probabilistic variant weights the consistent marking set
@cabasino2015probabilistic. A different observation model starts
from measured places even when no transition firing is directly observed
@arichi2026estimation. Finally, observation-equivalent Petri-net generators can
replace marking outputs by adaptive labels while preserving exactly the
consistent firing-sequence and marking sets @tong2016observation. These results
make inverse-observation sets, compact exact representations, and observer
compilation established concepts. Sparse symbolic loop execution instead
observes sibling states' branch-edge patterns up to a loop-impact barrier and
postpones repeated patterns @busse2024ssle. The former is a state quotient and
the latter a coverage-oriented search heuristic. Neither is an exact partition
of caller inputs by requested internal events, but both preclude a broad claim
that observation-guided omission or symbolic quotienting is new.

Context-guided concolic search similarly prefers candidate branches reached
under new dominator-filtered path contexts and widens the context depth only
incrementally @seo2014context. A dissertation extension learns and merges
preconditions from prior executions that fail to reach one requested target,
then prunes the target-relative search @seo2015context. These mechanisms make
requested-goal and observation-relative pruning established ideas. They change
search order or exclude target-failing paths; they do not enumerate the exact
image and inverse fibers of a total finite observer.

Earlier target guidance assigns state-dependent fitness to paths approaching a
requested coverage goal, while abstraction-guided concurrent testing ranks
thread and data choices through a backward slice from the selected assertion
@xie2009fitness @rungta2009abstraction. Both reinforce the same boundary:
targeted observations can organize sparse exploration without defining a
complete observer quotient.

Learned pruning makes the guarantee boundary sharper. Homi retains only states
predicted to improve coverage or expose bugs, and NumScout removes functions
predicted irrelevant to a requested numerical-defect class
@cha2020homi @chen2025numscout. Both are intentionally approximate. They
establish requested-observation control over state retention, not an exact
equivalence relation or exhaustive enumeration contract.

Coverage can also reduce the concrete seeds supplied to symbolic execution.
Coverage-based cause reduction retains a subset with the same statement
coverage and then prioritizes that subset before exploration
@zhang2014reduction. This is observation-preserving preprocessing, not a
semantic quotient of symbolic executions.

Property-guided work supplies a stronger boundary than coverage heuristics.
Regular-property-guided DSE combines an event-FSM history with a static
over-approximation of future events to prioritize branches likely to reach one
accepted trace @zhang2015regular. SRV's ideal rules additionally slice branches
that cannot contribute a counterexample or whose accepted continuations are
equivalent to an already explored event sequence when Preset/Postset satisfy
the stated soundness conditions. The evaluated implementation is explicitly
unsound because its Postset is context-insensitive @yu2018symbolic.
Derivative-guided symbolic execution represents LTLf trace
specifications as symbolic finite automata, uses residual specifications to
prune precondition traces, and proves soundness and falsification completeness
relative to its naive semantics @yuan2025derivative. Thus requested-event and
specification-relative omission can carry conditional or relative preservation
theorems. These methods seek property witnesses, not every observation and its
exact inverse input fiber.
At a component boundary, dynamic interface reduction discovers externally
visible behavior online and avoids global exploration of internal behavior
that cannot propagate through the interface @guo2011interface. This is a
strong finite-observer analogue, but it preserves model-checking behavior
rather than enumerating the observer's inverse input sets.

Assertion- and coverage-directed methods sharpen that conclusion. Summaries of
prior assertion-safe executions can soundly prune later multithreaded
executions while preserving reachable error locations @guo2015assertion.
Earlier abstract subsumption already backtracks when a symbolic heap state is
contained in a previously explored abstract state, obtaining finite but
under-approximate exploration for recursive heaps and arrays
@anand2006subsumption.
Modular glass-box checking instead safely checks large sets of similar states
together and substitutes component abstractions during bounded exhaustive
input and schedule exploration @roberson2010glassbox. Its grouped object is a
model-checker state set, not a requested-event caller-input fiber.
Postconditioned symbolic execution gives an exact path-level counterpart:
weakest-precondition summaries prune a new suffix already covered by prior
bounded behavior @yi2018postconditioned.
Observation-specific redundant-state detection instead soundly prunes a state
when no continuation can reach a new declared code location
@bugrara2013redundant. Both preserve search objectives rather than enumerate
the complete image and input fibers of a multivalued observer.
Neighborhood graph abstraction uses the dual over-approximate setting: an
abstract shape is discarded when another denotes a superset of its concrete
graphs and covers its abstract behavior @zambon2012subsumption.
The publisher abstract for dependency-derived compatible branch sets states
sound omission of paths that add no branch coverage under a bounded exploration
objective @yi2024compatible. An index abstract also reports multipoint DSE path
equivalence, but primary full text remains unavailable @lu2017multipoint. The
stronger results establish property-relative semantic omission without
establishing exhaustive observer fibers.

Finite path-family decomposition also appears in LLM-powered symbolic
execution: coverage-set partitions and property slices can summarize infinitely
many loop paths with finitely many derived subprograms @li2025llm. The practical
verification oracle there is explicitly approximate, so this establishes a
structural partition and termination boundary rather than an exact semantic
enumerator.

== Projection, Boolean atoms, and decision structures

AllSMT enumerates assignments to selected predicates and theory terms
@phan2015allsmtr. Later algorithms enumerate disjoint partial models and
projected SAT/SMT models without ordinary blocking clauses
@spallitta2024disjoint @spallitta2025projected. Instrumenting every selection
site with an `unobserved`-or-outcome coordinate reduces the present result set
directly to complete projected assignments. A short projected cube may omit a
coordinate and cover several complete observations, so it has a different
output contract; that distinction does not invalidate the reduction.

Finite observers also induce exact input partitions without a program-path
presentation. Input-equivalence-class construction enumerates satisfiable
behavioral patterns over possibly infinite input domains and minimizes them to
a coarsest finite partition @krafczyk2017effective. Exhaustive
property-oriented testing enumerates all satisfiable atoms of a fixed
guard/output/property alphabet @huang2024exhaustive. After totalization, a
selection observation is simply another finite observer. Its nonempty fibers
are therefore not a new kind of semantic quotient. What the graph proof adds
is that one fiber has an exact positive guard containing only observed-site
outcomes; generic Boolean-atom enumeration normally states both positive and
negative coordinates.

Decision trees give an even simpler special case. One input encounters only
the tests on its root-to-leaf path, whose outcomes form a sparse map; the path
conjunction is a disjoint guard and the leaf is a result @quinlan1986trees.
For finitely encoded inputs, reduced ordered BDDs and ADDs compile a totalized
finite-range observer and share its preimages, with canonicity only for fixed
variable order and terminal equality @bryant1986bdd @bahar1997add. Flattening
one terminal preimage to one formula may destroy that sharing. Thus sparse path
shape, exact disjointness, and compilation are established; the remaining
specificity is requested-root graph reachability, contextual site identity,
and a symbolic residual per observation fiber.

Neural-specific compilation makes this boundary concrete. Exact OBDDs, SDDs,
and deterministic decomposable circuits have been learned or constructed for
binarized networks @shih2019bnn @shi2020tractable @tang2023abdd
@bertossi2023shap. The last route substitutes internal threshold definitions,
compiles the output through an SDD, and enables repeated exact SHAP queries;
its SDD step can be exponential in primal-graph treewidth. BDD4BNN composes block diagrams
while existentially eliminating hidden activation vectors and produces one
exact reduced BDD per requested output class over a declared binary input
region @bdd4bnn2023. Its diagrams support exact counting, robustness, and
prime-implicant explanations, although compilation and whole-network diagram
operations can be exponential. Newer Boolean transformations retain exactness
for binary networks but use bounded approximation for real-valued networks
@tang2026boolean. These results rule out a claim that exact neural observers
must retain every internal decision. They compile an extensional class
function on a finite Boolean domain, whereas the present observer deliberately
retains reached internal site identities and attaches typed symbolic residuals.
Exact logic synthesis of binarized neural inference supplies a related circuit
representation without enumerating the output partition @chi2018bnnsynthesis.
Earlier Boolean-algebra extraction composes per-neuron Boolean functions and
can remove redundant hidden nodes without changing a binary or bipolar
network's function @yang2004booleanrules. Direct truth-table evaluation and
Boolean minimization likewise extract an exact rule set for a small
Boolean-feature neural classifier, while the same method becomes
sampling-based approximation at larger feature counts @mereani2019rule.
Exact consistency-cube minimization separately establishes complete minimal
prime-implicant enumeration @dusa2019consistency. These results compile an
extensional Boolean function; they do not preserve a sparse map of reached
hidden selections.

== Needed search, partial inputs, and dataflow demand

Functional-logic implementations attach stable identifiers to shared choices
and populate a fingerprint only as demanded computation reaches them.
Pull-tabbing, set functions, and the Fair Scheme use such maps to organize
complete or fair value search @antoy2011pull @brassel2007tighter
@brassel2011thesis @jost2023fairscheme. Their choices arise from
nondeterministic evaluation and their identities can be dynamic and
computation-local. The present graph is deterministic for each input and uses
static contextual identities so that summaries can be instantiated at distinct
occurrences. Nevertheless, demand-populated partial decision maps and shared
choice consistency are clear prior art.

Demand-guided exhaustive testing supplies a second close boundary. Korat
backtracks only over object fields read by an executable predicate
@boyapati2002korat. Lazy SmallCheck refines the tagged constructor hole forced
by a pure Boolean property and skips all bounded refinements once the result is
known @runciman2008smallcheck. Solver-backed lazy initialization extends the
idea to partial heaps @geldenhuys2013bounded @rosner2015bliss
@copia2022lissa @copia2023precise. These methods already avoid a Cartesian
product by following an observer. They may represent one semantic class with
several partial inputs, however, and do not generally return one exact
inverse-fiber guard with a symbolic residual.

Higher-order concolic testing provides a different canonicalization result. It
evolves canonical function inputs from constraints observed during execution
and proves sound evaluation and bug-finding completeness modulo concretization
and SMT incompleteness @you2021higherorder. It searches a canonical input
language for one counterexample rather than producing every exact first-order
input fiber, but blocks a broad claim that canonical symbolic input search is
new. An earlier verifier likewise gives sound proofs and counterexample-
complete search for a terminating pure higher-order fragment by controlling
dynamic dispatch and progressively unfolding functions @voirol2015counterexample.
Nguyễn and Van Horn instead progressively decompose unknown functions,
retain first-order path constraints, reconstruct concrete functional inputs,
and prove relative counterexample completeness modulo base reasoning
@nguyen2015counterexamples. Their expanded contract system adds recursive data,
first-class contracts, flow-sensitive refinement, and verification
@nguyen2017contracts.
Contracts had already served as sound symbolic higher-order values
@tobinhochstadt2012contracts. A later game-semantics formulation captures
arbitrary external functional behavior soundly and completely, with finite
exploration obtained by explicit recursion and callback-depth bounds
@lin2020game.
Earlier still, quantified refinement types establish sound relative
completeness for higher-order functional safety, with a later system extending
the result to universal and existential nondeterministic branching properties
@unno2013relative @unno2018relative. The theoretical systems rely on relative
first-order reasoning, while their automated inference procedures retain
documented incompleteness. They prove or refute a property rather than enumerate
the complete finite image of this paper's observer.

Classical demand-driven dataflow is the direct fixed-input semantic precedent.
Pingali and Arvind propagate requested output positions backward through a
stream graph and prove correctness and parsimony compositionally
@pingali1985efficient @pingali1986efficient. Avron and Sasson characterize when
a least legal output-complete valuation exists uniformly through stability
@avron1994stability. The strict finite acyclic dependency policy in
@sec-formal-model has a simpler reachability least valuation. The
change is one of quantification: prior dataflow work computes a least demanded
computation for fixed inputs, whereas this synthesis varies inputs, projects
each least computation to selection events, and enumerates the inverse fibers.
Neither reverse demand nor least computation is claimed as new.

Selective functors provide a separate compositional precedent. Their free
syntax and interpretations describe static computations with dynamically
selected effects @mokhov2019selective. They motivate the component boundary
but do not themselves enumerate exact caller-input fibers. Likewise,
compositional symbolic execution already reuses path summaries
@godefroid2007compositional @anand2008demand. The flattening law in this paper
therefore records semantic compatibility; it does not claim the first reusable
summary calculus.

== Geometric cells, parametric programs, and output quotients

When every selection is an affine sign test and every site is observed,
observations become total sign vectors. Hyperplane-arrangement algorithms
already enumerate the full-dimensional cells exactly once with
output-sensitive bounds @avis1996reverse @sleumer1998output
@ferrez2005fixedrank @rada2018new. Exact ReLU methods likewise enumerate dense
activation patterns, stars, polyhedra, or complete cell complexes and often
attach affine output maps @serra2018bounding @tran2019star
@vincent2021reachable @wang2022regions. These results establish exact
guard-plus-affine-residual enumeration and exponential worst cases. Their zero
or boundary coordinates and their dense activation vectors are not the same
as structural non-observation, but the all-sites-observed specialization is a
direct reduction.

That dense-cell baseline does not exhaust exact neural observers. Layer-wise
conversions already represented ReLU classifiers as multivariate decision
trees @nguyen2020ecdt @aytekin2022trees. Affinitree composes piecewise-linear
neural operators into a tree with affine tests and terminals, removes
LP-infeasible paths, and can merge semantics-preserving subtrees
@affinitree2024. Chang et al. go further for ReLU controllers: their exact
state-dependent tree omits infeasible activation tests and performs output
comparisons only while actions remain competitive; their pointwise-equivalence
theorem makes the leaves an exact policy representation @chang2026compact.
Logemann and Veith similarly compress policy trees and analyze polyhedral exact
output regions, but the published exactness argument and boundary convention
are less formal @logemann2023nn2eqcdt @logemann2024exact. Consequently,
feasibility-pruned and output-relative neural decision trees are established.
Their object is the extensional action or affine-map partition of a fixed
neural/PWL architecture, not an observation of arbitrary contextual selection
events in a typed shared graph.

Compositional hybrid-mode construction topologically substitutes upstream
affine maps into downstream guards, prunes infeasible products, and emits an
exact piecewise-affine guard/map representation @geyer2010mode. Exact
piecewise-affine minimization, clipping, and separation can then coalesce
regions that implement the same behavior @geyer2008optimal
@kvasnica2012clipping @kvasnica2013separation. A recent compositional neural
controller construction independently applies this PWA substitution pattern
layer by layer @soto2025pwa. Our observer intentionally takes
the opposite side of that quotient: equal-valued alternatives remain distinct
when their selection outcomes were observed. Guard substitution and residual
composition are nevertheless inherited techniques.

Multiparametric programming provides the strongest direct complexity
comparators. Reverse search enumerates full-dimensional pLP regions with
reconstructible affine optimizers @jones2006parametric. Sufficient-matrix pLCP
enumeration supplies explicit output-linear LP-oracle bounds covering pLP and
convex pQP @columbano2009sufficient. Minimum-norm selection can produce a
unique continuous, algorithm-independent pQP partition
@spjotvold2007unique, while degeneracy-safe pQP traversal finds every
full-dimensional neighbor across a facet @patrinos2010graphical. Polyhedral
projection and pLP solution are polynomially interreducible
@jones2008projection. Exact output-sensitive region enumeration, unique
selected optimizers, and projection are therefore all prior results.

Finally, requested-result quotienting is itself established. Different
explicit-MPC active-set regions can share the requested first control action
while later actions differ @konig2020common @mitze2021common. Polyhedral reward
regions can likewise induce the same optimal policy @shin2024multitask. A
requested output is an extensional quotient. A selection observation is
intensional: it retains equal-valued events actually encountered while omitting
sites outside the requested enabled closure. This distinction defines the
paper's object, but requested relativity alone does not establish priority.

== Result of the comparison

No broad constituent is new in isolation: not sparse choice maps, exact
partitions, projected enumeration, guarded residuals, demand-guided omission,
graph sharing, compositional substitution, geometric region traversal, or
requested-output quotienting. The synthesis packages a narrower object for a
finite typed shared graph and proves the agreement of its structural,
concolic, and projected presentations. The literature map found no single
audited work with exactly that package, but bounded search cannot turn this
packaging gap into a priority claim. Its value is a precise specification and
a set of reduction boundaries against which a future implementation can be
measured.
