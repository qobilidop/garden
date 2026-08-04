= Related-work synthesis <sec-related>

The closest literature is not one lineage with changing terminology. It is a
set of constructions that preserve different observers while producing
superficially similar partial assignments, guards, or residuals. This section
organizes those constructions by the information they retain and states the
reduction or boundary in each case.

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

Delayed-choice execution is an especially instructive neighbor. A bounded
nondeterministic value remains in a shared suspension until a non-copy use
forces a concrete alternative, preserving reachable visible states while
avoiding unused choices @gligoric2008delayed. Concrete forcing still separates
values that induce the same selector outcome and can enumerate values where
our residual remains symbolic. Structural observation, concrete forcing, and
logical relevance are consequently three different omission rules.

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
idea to partial heaps. These methods already avoid a Cartesian product by
following an observer. They may represent one semantic class with several
partial inputs, however, and do not generally return one exact inverse-fiber
guard with a symbolic residual.

Classical demand-driven dataflow is the direct fixed-input semantic precedent.
Pingali and Arvind propagate requested output positions backward through a
stream graph and prove correctness and parsimony compositionally
@pingali1985efficient @pingali1986efficient. Avron and Sasson characterize when
a least legal output-complete valuation exists uniformly through stability
@avron1994stability. The strict finite acyclic dependency policy in
Section @sec-formal-model has a simpler reachability least valuation. The
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

Compositional hybrid-mode construction topologically substitutes upstream
affine maps into downstream guards, prunes infeasible products, and emits an
exact piecewise-affine guard/map representation @geyer2010mode. Exact
piecewise-affine minimization, clipping, and separation can then coalesce
regions that implement the same behavior @geyer2008optimal
@kvasnica2012clipping @kvasnica2013separation. Our observer intentionally takes
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
