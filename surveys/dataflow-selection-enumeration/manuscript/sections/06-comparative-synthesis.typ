= Comparative synthesis <sec-synthesis>

The six routes overlap in mechanism and representation, so listing them does
not yet show whether they solve the same problem. This section compares their
observers and record guarantees, identifies the closest established results
that bound the survey's claims, and answers the four research questions.

== Observer agreement

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

== Guarantees and representations

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

== Complexity and applicability

The general problem has exponentially many observations, NP-hard
single-outcome feasibility, and \#P-hard counting special cases. One
successful model query per observation plus a final exhaustion query is only an
oracle-call accounting. It gives no OutputP, incremental-polynomial,
polynomial-delay, or wall-clock theorem. Geometric and parametric restrictions
have genuine output-sensitive algorithms; compiled methods may amortize
enumeration after potentially expensive preprocessing; local methods may avoid
unobserved cones but repeat solver and residual work. These are tradeoffs, not
a universal ranking.

== Closest established results

Six specific results, rather than a general sense of related work, bound what
the framework can claim. Each is the nearest established counterpart to one
component of the record contract, and each defeats a broad novelty claim a
reader might otherwise infer.

Requested-output projection is already known to merge distinct internal
histories. König and Mönnigmann prove that explicit-MPC regions whose
later-horizon actions differ can share the requested first action, Mitze et al.
extend that common-action reuse to nonlinear MPC, Kvasnica and coauthors give
clipping- and separator-based factorizations that erase region descriptions
while preserving the controller pointwise, and Shin and Yang identify, at
abstract level (the one abstract-only read cited in this survey), reward
regions inducing the same optimal policy @konig2020common @mitze2021common
@kvasnica2012clipping @kvasnica2013separation @shin2024multitask. Being relative
to a requested output is therefore not a contribution; retaining the sparse
internal selection events reached while computing it is.

Exact inverse consistency under a partial event observer is likewise
established. Petri-net estimators characterize exactly the markings consistent
with an observed transition-label word by a linear system whose structure is
independent of word length, make the nondeterministic-label case explicit,
compute the complete set of minimum-token initial markings, and admit timing and
unobservable events @giua2003marking @corona2003observers @li2009minimum
@ghazel2009observer. Their hidden objects are markings or timed states, not
caller inputs carrying typed residual values.

Multiplicity-sensitive event observation is established for unfoldings.
Reveals and excludes relations quantify over maximal runs, with a repeated
variant restricted to runs containing a fixed number of occurrences of the
observed transition, and a parametric algorithm decides them for bounded
equal-conflict nets @bernardinello2016revealsexcludes
@adobbati2024parametricreveals.

Pairing a recorded choice history with a symbolic residual is established for
concurrency: SymPaths proves a schedule-recording symbolic semantics sound and
complete against concrete executions before pruning equivalent paths
@deboer2020sympaths. Its observer is a thread schedule, not a requested-root
caller-input fiber.

Demand-driven refinement over structured inputs has an imperative continuation
beyond the functional line above. Korat prunes by the fields an executable
predicate actually reads @boyapati2002korat, Lindblad refines only the
metavariable blocking a Boolean property and returns a partial constructor term
denoting all satisfying completions @lindblad2007property, and bounded lazy
initialization, BLISS, LISSA, and PLI successively add relational field bounds,
SAT and bounded-exhaustive feasibility oracles, and joint heap/path-condition
feasibility, each with a preservation result for the states ordinary lazy
initialization would explore @geldenhuys2013bounded @rosner2015bliss
@copia2022lissa @copia2023precise. These search partial states; they do not
aggregate them into exact observation fibers with residuals.

Finally, an exact quotient is not automatically cheaper than the analysis it was
meant to accelerate. Fisler and Vardi show analytically and experimentally that
BDD bisimulation minimization can cost more than checking the invariant directly
and often does not improve the downstream problem @fisler2002bisimulation. No
performance claim follows from the observer-fiber construction alone.

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

== Answers to the research questions

*RQ1.* The common object is a finite observer on caller inputs. Its nonempty
inverse images are fibers, and an exact record attaches a guard, residual, and
witness to each fiber. This distinguishes semantic partitioning from the
algorithm and data structure used to expose it.

*RQ2.* The included approaches organize into six recurring, overlapping routes.
Local guarded evaluation and global projected enumeration are equivalent
general presentations; decision structures compile the observer; demand-guided
methods supply sparse discovery mechanisms; dense-sign geometric methods solve
a restricted affine specialization; and guarded summaries provide composition.

*RQ3.* General exactness follows only after all four record obligations are
proved. General output-sensitive complexity does not follow from sparse demand
or one model per fiber. Stronger bounds belong to restricted geometric,
parametric, or compiled inputs and must charge their representations.

*RQ4.* Approaches induce the same fibers when their observer kernels agree
after explicit instrumentation. Their labeled images and record schemas then
correspond only after an explicit image bijection. Coordinate projection,
equal-behavior merging, path refinement, and property-guided search otherwise
produce coarser, finer, or incomparable partitions. This observer test is the
framework's primary rule for transferring results across terminology.
