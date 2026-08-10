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

The nearest results are output-directed and dataflow-specific, not only broad
neighboring literatures. PESO is the closest formal predecessor: it enumerates
relevant-slice conditions for requested output criteria, associates symbolic
outputs and tests, and proves exploration completeness under explicit finite
model and solver assumptions @qi2013output. SPD is the closest shared
path-family/residual predecessor @santelices2010dependencies. Feng et al.'s
mux functional-space cells are the closest restricted pure-dataflow
guard/residual representation @feng2004dynamic, and Kanade et al. are the
closest graphical-dataflow trace-equivalence predecessor, although their
symbolic region underapproximates one sampled trace class
@kanade2009simulink. Sylvia supplies a modern modular RTL comparison with
replayable witnesses, but its feasible fragment combination retains an
exponential stated worst case @ryan2023sylvia.

Functional-logic fingerprints are the closest lineage for the sparse map
shape: set functions record executed nondeterministic steps, pull-tabbing
introduces stable choice-ID/outcome propagation through runtime copies, and
memoized pull-tabbing exposes the later task-local partial map
@antoy2009setfunctions
@alqaddoumi2010pulltab @hanus2021memoized. The observer is nondeterministic
evaluation history rather than a deterministic caller-input fiber. SPLat adds
a close configuration-testing precedent: first reads populate a decision
stack, SAT prunes feature-model-infeasible partial assignments, and concrete
configurations witness claimed distinct test traces @kim2013splat.

#figure(
  block(breakable: true)[
    #text(size: 7.2pt)[
      #table(
        columns: (0.9fr, 1.35fr, 1.25fr, 1.45fr, 1.25fr),
        align: left,
        inset: 3pt,
        stroke: (x: none, y: 0.4pt + luma(200)),
        table.header(
          [*Work or route*], [*Native observer/output*], [*Coverage guarantee*],
          [*Guard · residual · witness*], [*Kernel/contract relation*],
        ),
        [PESO], [Relevant-slice conditions at requested outputs],
          [Conditionally complete exploration of finite RSCs],
          [RSC/path condition · symbolic output · solver test],
          [Kernel equality open; may refine or fragment a target fiber],
        [SPD], [Dependence-relevant path-family graph for queried uses],
          [Exact mode described as pathwise-equivalent; no numbered end-to-end theorem],
          [Path-family condition · shared guarded values · no exposed witness record],
          [Kernel equality open; dependence families may be finer],
        [Feng et al.], [Mux control/data functional-space cells],
          [Mutually exclusive functional-space partition intended],
          [Boolean control · data expression · no witness],
          [Restricted-close; merge choices can make its kernel coarser],
        [Kanade et al.], [Bounded discrete trace including conditional outcomes],
          [Sampled class is underapproximated],
          [Sufficient predicate · transformer · sample],
          [Different trace observer; sampled region is not a full kernel class],
        [Fingerprints / MPT], [Task-local choice-ID/outcome map],
          [Search guarantees are source-strategy-specific],
          [No input guard · result value, not residual · task],
          [Different input domain and observer; no kernel order established],
        [SPLat], [Reachable test trace under configuration inputs],
          [One execution per distinct trace is claimed; no formal exactness theorem],
          [Partial configuration cylinder · none · execution],
          [Trace kernel may be finer or incomparable to selection events],
        [Wang et al.], [Colored solution-tree equivalence class],
          [Every class exactly once; delay $O(n s)$],
          [No input guard · class tree · no witness],
          [Different solution domain; incomparable without a reduction],
        [Projected AllSMT], [Instrumented totalized observation tuple],
          [Complete tuples enumerate the exact image],
          [Existential fiber · no residual · model],
          [Same kernel after faithful activity/outcome instrumentation],
        [BDD/ADD compilation], [Finite encoded observer function],
          [Exact for the compiled function; BDD canonicity needs fixed order],
          [Terminal preimage · optional terminal residual · optional model],
          [Same kernel iff terminal labels injectively relabel the totalized observer],
        [Hyperplane traversal], [Strict sign cell],
          [Complete, duplicate-free, output-sensitive under source cost models],
          [Polyhedral cell · separate/charged · method-specific],
          [Same kernel on the boundary-free all-sites-observed affine restriction],
        [Parametric traversal], [Optimizer basis or critical region],
          [Full-dimensional basis/region coverage under stated assumptions],
          [Closed polyhedron · affine optimizer · method-specific],
          [Usually different; boundary overlap prevents a disjoint all-input kernel],
        [Guarded component summaries], [Namespaced component observations under demanded ports],
          [Exact under full-domain locality and contextual identity assumptions],
          [Conjoined guard · substituted residual · witness recovered by solving the composed guard],
          [Same kernel as flattening under the composition theorem],
      )
    ]
  ],
  caption: [Guarantees of the closest representatives. “Open” means that this
  survey does not prove equality with the target observer or one-record
  contract.],
  kind: table,
) <tab-guarantees>

Wang et al. are important because they defeat a broader novelty claim: their
dynamic program enumerates every locally colored equivalence class of solution
trees in an acyclic decomposable AND/OR graph exactly once with delay
$O(n s)$ @wang2021equivalence. Exact quotient enumeration is therefore not new
as a general objective. Their class-tree output and decomposability assumptions
do not supply a reduction from arbitrary selection fibers, caller-input guards,
residuals, or witnesses.

Three exact correspondences remain open: whether instrumented PESO plus RSC
quotienting yields exactly one selection fiber; whether SPD's dependence
families denote the enabled-closure observer rather than a refinement; and
whether Feng's actual split/merge algorithm, augmented with immutable
contextual event labels, preserves every target observation. The survey does
not use their absence of an explicit theorem as evidence that no reduction
exists.

The strongest adjacent boundaries remain useful but should not be mistaken for
the closest algorithms. Requested-output quotients can merge distinct internal
histories, as in common-first-action controller regions
@konig2020common @mitze2021common and exact neural-policy decision trees
@chang2026compact. Giua et al. give exact inverse consistency for Petri-net
markings under an observed label word @giua2003marking. SymPaths records
scheduler choices and proves its symbolic semantics sound and complete against
concrete executions @deboer2020sympaths. Lindblad's property-blocked constructor
search is a close demand-refinement shape, but its stated soundness and
completeness conditions are explicitly unproved @lindblad2007property; Korat
and the BLISS--LISSA--PLI heap line establish stronger bounded access-guided and
feasibility-preservation results for different artifacts @boyapati2002korat
@rosner2015bliss @copia2022lissa @copia2023precise. Finally, Fisler and Vardi
show that exact BDD bisimulation minimization can cost more than direct symbolic
checking @fisler2002bisimulation. No performance claim follows from the
observer-fiber construction alone.

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
parametric, or compiled inputs and must charge their representations. The
route-by-route obligations and assumptions are summarized in
@tab-guarantees.

*RQ4.* Approaches induce the same fibers when their observer kernels agree
after explicit instrumentation. Their labeled images and record schemas then
correspond only after an explicit image bijection. Coordinate projection,
equal-behavior merging, path refinement, and property-guided search otherwise
produce coarser, finer, or incomparable partitions. This observer test is the
framework's primary rule for transferring results across terminology;
@tab-guarantees records the known equality, open, and incomparable cases.
