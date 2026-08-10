= Comparative synthesis <sec-synthesis>

The six routes overlap in mechanism and representation, so listing them does
not yet show whether they solve the same problem. This section compares their
observers and record guarantees, identifies the closest established results
that bound the survey's claims, and answers the four research questions.

== Observer, contract, and representation

The observer-kernel test gives the shortest comparison. Projected enumeration
and candidate-local symbolic evaluation are direct general presentations after
the instrumentation proved in @sec-algorithms. Decision structures are direct
when they compile the totalized observer; dense-sign geometry is direct only on
its all-sites-observed affine restriction; and demand-guided, parametric, or
compositional methods require the correspondence conditions stated in
@sec-routes and @sec-composition.

This is more precise than asking whether a method emits a “partial assignment.”
Structural absence is an observer value; existential projection hides formula
coordinates; a logical don't-care represents either value; and equal-residual
coalescing takes a quotient. Similar syntax can therefore denote different
fibers.

The record contract adds four independent obligations: duplicate-free
coverage, guard/fiber equivalence, residual correctness, and a witness. Output
representation remains orthogonal: a flat record stream, tree, decision DAG,
or polyhedral complex may encode the same observer while charging very
different construction and serialization costs. The two tables below separate
published native guarantees from the framework correspondence needed to obtain
the target contract.

== Complexity takeaway

The general problem can have exponentially many observations and contains hard
feasibility and counting special cases. Its $K+1$ model-query accounting is not
an output-sensitive theorem; stronger guarantees belong to restricted or
precompiled inputs and must charge residuals, witnesses, and representation
size as @sec-complexity specifies.

== Closest established results

The nearest results are output-directed and dataflow-specific, while the
strongest novelty boundary comes from exact equivalence-class enumeration on a
different representation. @tab-closest-guarantees consolidates those published
native objects and guarantees.

#figure(
  block(breakable: true)[
    #text(size: 8.1pt)[
      #table(
        columns: (24%, 22%, 25%, 29%),
        align: left,
        inset: 3.5pt,
        stroke: (x: none, y: 0.4pt + luma(200)),
        table.header(
          [*Work and native object*], [*Coverage guarantee*],
          [*Guard · residual · witness*], [*Relation to target*],
        ),
        [PESO: relevant-slice conditions at requested outputs @qi2013output],
          [Conditionally complete exploration of finite RSCs],
          [RSC/path condition · symbolic output · solver test],
          [Kernel equality open; may refine or fragment a target fiber],
        [SPD: queried-use path-family graph @santelices2010dependencies],
          [Exact mode described as pathwise-equivalent; no numbered end-to-end theorem],
          [Path-family condition · shared guarded values · no exposed witness record],
          [Kernel equality open; dependence families may be finer],
        [Feng et al.: mux functional-space cells @feng2004dynamic],
          [Mutually exclusive functional-space partition intended],
          [Boolean control · data expression · no witness],
          [Restricted-close; merge choices can make its kernel coarser],
        [Kanade et al.: bounded discrete trace @kanade2009simulink],
          [Sampled class is underapproximated],
          [Sufficient predicate · transformer · sample],
          [Different trace observer; sampled region is not a full kernel class],
        [Sylvia: RTL path-fragment combination @ryan2023sylvia],
          [Feasible combinations are SMT-filtered; stated worst case is exponential],
          [Fragment constraints · no fiber-wide residual · replayable model],
          [Adjacent modular construction; no selection-fiber theorem],
        [Fingerprints / MPT: executed-choice map @antoy2009setfunctions
          @alqaddoumi2010pulltab @hanus2021memoized],
          [Search guarantees are source-strategy-specific],
          [No input guard · result value, not residual · task],
          [Different input domain and observer; no kernel order established],
        [SPLat: reachable configuration test trace @kim2013splat],
          [One execution per distinct trace is claimed; no formal exactness theorem],
          [Partial configuration cylinder · none · execution],
          [Trace kernel may be finer or incomparable to selection events],
        [Wang et al.: colored solution-tree class @wang2021equivalence],
          [Every class exactly once; delay $O(n s)$],
          [No input guard · class tree · no witness],
          [Different solution domain; incomparable without a reduction],
      )
    ]
  ],
  caption: [Closest and novelty-bounding published comparisons. “Open” means
  that this survey does not prove equality with the target observer or
  one-record contract.],
  kind: table,
) <tab-closest-guarantees>

The general routes require a separate table because several rows are framework
reductions or restricted correspondences rather than native end-to-end
algorithms for the target.

#figure(
  block(breakable: true)[
    #text(size: 8.1pt)[
      #table(
        columns: (24%, 22%, 25%, 29%),
        align: left,
        inset: 3.5pt,
        stroke: (x: none, y: 0.4pt + luma(200)),
        table.header(
          [*Route and native object*], [*Coverage guarantee*],
          [*Guard · residual · witness*], [*Framework correspondence*],
        ),
        [Projected AllSMT: instrumented observation tuple @phan2015allsmtr],
          [Complete tuples enumerate the exact image],
          [Existential fiber · no residual · model],
          [Same kernel after faithful activity/outcome instrumentation],
        [BDD/ADD compilation: finite observer function @bryant1986bdd @bahar1997add],
          [Exact for the compiled function; BDD canonicity needs fixed order],
          [Terminal preimage · optional terminal residual · optional model],
          [Same kernel iff labels injectively relabel the totalized observer],
        [Hyperplane traversal: strict sign cell @avis1996reverse @rada2018new],
          [Complete, duplicate-free, output-sensitive under source cost models],
          [Polyhedral cell · separate/charged · method-specific],
          [Same kernel on the boundary-free all-sites-observed affine restriction],
        [Parametric traversal: optimizer basis or region @jones2006parametric
          @columbano2009sufficient],
          [Full-dimensional basis/region coverage under stated assumptions],
          [Closed polyhedron · affine optimizer · method-specific],
          [Usually different; boundary overlap prevents a disjoint all-input kernel],
        [Guarded component summaries: namespaced observations under demanded
          ports @geyer2010mode],
          [Exact under full-domain locality and contextual identity assumptions],
          [Conjoined guard · substituted residual · witness from composed guard],
          [Same kernel as flattening under the composition theorem],
      )
    ]
  ],
  caption: [Route-level guarantees after the instrumentation or restrictions
  required by the unified framework.],
  kind: table,
) <tab-route-guarantees>

The tables make two novelty boundaries explicit. Output-directed guarded
exploration and sparse executed-choice maps are established, and Wang et al.
already prove exact polynomial-delay quotient enumeration for a restricted
decomposable representation. Their class-tree output does not, however, supply
arbitrary caller-input guards, residuals, or witnesses.

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
@tab-closest-guarantees and @tab-route-guarantees.

*RQ4.* Approaches induce the same fibers when their observer kernels agree
after explicit instrumentation. Their labeled images and record schemas then
correspond only after an explicit image bijection. Coordinate projection,
equal-behavior merging, path refinement, and property-guided search otherwise
produce coarser, finer, or incomparable partitions. This observer test is the
framework's primary rule for transferring results across terminology; the two
guarantee tables record the known equality, open, and incomparable cases.
