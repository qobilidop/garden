# Evidence ledger

This file owns the bindings between literature, survey claims, and manuscript
use. Each `Exxx` record contains one checkable finding from the literature,
links downward to source-note anchors, upward to supported `Cxx` claims, and
across to manuscript sections that cite on its strength. It does not replace
the full reading notes in `sources/`, the survey propositions in `claims.md`,
or the interpretation in `syntheses/`. Scope and caveat remain attached to the
finding, and the validator enforces the bindings.

## Record schema

- **Finding** — one checkable statement of what the cited literature shows.
- **Works** — comma-separated citekeys for the works supporting the finding.
- **Anchors** — semicolon-separated source-note locations, written as
  `sources/<citekey>.md#<heading>`.
- **Supports** — comma-separated `Cxx` claim identifiers; omitted when the
  finding supports no registered claim.
- **Manuscript** — comma-separated section labels where the finding is used;
  omitted when it is not cited in the manuscript.
- **Scope** — the part of each work on which the finding relies.
- **Caveat** — the limits on what may be inferred from the finding.
- **Certainty** — `high`, `moderate`, or `low`, based on source-note read depth
  and evidence limits using a GRADE-inspired scale; reassessed whenever the
  finding or its evidence changes.

### E001

- **Finding:** The study design follows systematic-mapping, separate snowballing, and auditable secondary-study reporting guidance.
- **Works:** petersen2015mapping,wohlin2014snowballing,kitchenham2023segress
- **Anchors:** sources/petersen2015mapping.md#evidence-locations;sources/wohlin2014snowballing.md#evidence-locations;sources/kitchenham2023segress.md#evidence-locations
- **Manuscript:** sec-method
- **Scope:** methodology
- **Caveat:** These sources guide reporting; they do not certify literature completeness.
- **Certainty:** low

### E002

- **Finding:** Exact symbolic execution already represents behavior with path or merge guards and residual symbolic states or values.
- **Works:** voogd2025compositional,sen2015multise,porncharoenwase2022merging,lu2023grisette
- **Anchors:** sources/voogd2025compositional.md#evidence-locations;sources/sen2015multise.md#evidence-locations;sources/porncharoenwase2022merging.md#evidence-locations;sources/lu2023grisette.md#evidence-locations
- **Supports:** C02,C03
- **Manuscript:** sec-introduction,sec-routes
- **Scope:** definitions and correctness theorems
- **Caveat:** The exact equivalence conditions and merge contracts differ across languages; correspondence with selection fibers is our synthesis.
- **Certainty:** low

### E003

- **Finding:** All-values and dependence-guided symbolic execution reduce exploration relative to selected values or dependences.
- **Works:** denaro2012allvalues,wang2017dependence
- **Anchors:** sources/denaro2012allvalues.md#evidence-locations;sources/wang2017dependence.md#evidence-locations
- **Supports:** C15
- **Manuscript:** sec-routes
- **Scope:** algorithms, guarantees, and experiments
- **Caveat:** Their CFG and dependence observers are not the selection-observation fiber.
- **Certainty:** moderate

### E004

- **Finding:** AllSMT and disjoint projected enumeration already enumerate selected finite coordinates and projected partial models.
- **Works:** phan2015allsmtr,spallitta2024disjoint,spallitta2025projected
- **Anchors:** sources/phan2015allsmtr.md#evidence-locations;sources/spallitta2024disjoint.md#evidence-locations;sources/spallitta2025projected.md#evidence-locations
- **Supports:** C01,C02,C03,C15
- **Manuscript:** sec-introduction,sec-routes,sec-algorithms
- **Scope:** algorithm and coverage/nonrepetition results
- **Caveat:** Phan enumerates important Boolean coordinates; relevant theory-variable values are sampled annotations. A short projected cube can cover several complete observation tuples; equality with local exact fibers requires activity instrumentation and totalized output coordinates.
- **Certainty:** high

### E005

- **Finding:** Finite observer predicates induce exactly enumerable input-equivalence classes or satisfiable Boolean atoms.
- **Works:** krafczyk2017effective,huang2024exhaustive
- **Anchors:** sources/krafczyk2017effective.md#evidence-locations;sources/huang2024exhaustive.md#evidence-locations
- **Supports:** C05,C15
- **Manuscript:** sec-routes
- **Scope:** definitions, enumeration algorithms, and exactness results
- **Caveat:** The graph-specific positive guard is a specialized representation of these generic fibers.
- **Certainty:** high

### E006

- **Finding:** BDDs and ADDs compile exact finite-range functions with order-qualified canonicity and exponential worst cases.
- **Works:** bryant1986bdd,bahar1997add
- **Anchors:** sources/bryant1986bdd.md#evidence-locations;sources/bahar1997add.md#evidence-locations
- **Supports:** C07,C15
- **Manuscript:** sec-introduction,sec-routes
- **Scope:** representation definitions and complexity
- **Caveat:** A symbolic residual per observation terminal requires an additional construction.
- **Certainty:** high

### E007

- **Finding:** Functional-logic search uses stable shared choice identities and demand-populated fingerprints in complete or fair search schemes.
- **Works:** antoy2011pull,brassel2007tighter,brassel2011thesis,jost2023fairscheme
- **Anchors:** sources/antoy2011pull.md#evidence-locations;sources/brassel2007tighter.md#evidence-locations;sources/brassel2011thesis.md#evidence-locations;sources/jost2023fairscheme.md#evidence-locations
- **Supports:** C01,C06,C15
- **Manuscript:** sec-routes
- **Scope:** choice representations and adequacy/value-preservation theorems
- **Caveat:** Identities and nondeterministic result semantics differ from static contextual graph sites.
- **Certainty:** moderate

### E008

- **Finding:** Lazy SmallCheck refines only the partial input fragment demanded by an executable Boolean observer while preserving bounded exhaustive testing.
- **Works:** runciman2008smallcheck
- **Anchors:** sources/runciman2008smallcheck.md#evidence-locations
- **Supports:** C01,C06,C15
- **Manuscript:** sec-introduction,sec-routes
- **Scope:** algorithm and exhaustiveness argument
- **Caveat:** It does not emit one canonical exact guard/residual record per selection-observation fiber.
- **Certainty:** high

### E009

- **Finding:** Classical stream-dataflow work computes reverse demands or least legal requested-output computations for fixed inputs under explicit conditions.
- **Works:** pingali1985efficient,avron1994stability
- **Anchors:** sources/pingali1985efficient.md#evidence-locations;sources/avron1994stability.md#evidence-locations
- **Supports:** C08,C15
- **Manuscript:** sec-routes
- **Scope:** transform correctness, parsimony, and stability characterization
- **Caveat:** Equality with the survey's strict finite enabled closure requires a specialization proof.
- **Certainty:** high

### E010

- **Finding:** Selective functors and compositional symbolic execution establish reusable compositional structures and path summaries.
- **Works:** mokhov2019selective,godefroid2007compositional,anand2008demand
- **Anchors:** sources/mokhov2019selective.md#evidence-locations;sources/godefroid2007compositional.md#evidence-locations;sources/anand2008demand.md#evidence-locations
- **Supports:** C15
- **Manuscript:** sec-routes
- **Scope:** universal interpreter and summary algorithms
- **Caveat:** They do not state the exact requested-root observation-fiber correspondence.
- **Certainty:** moderate

### E011

- **Finding:** Symbolic partial-order reduction explores representative interleavings of independent concurrent events while preserving local-property verification.
- **Works:** alur2001partialorder
- **Anchors:** sources/alur2001partialorder.md#evidence-locations
- **Supports:** C11,C15
- **Manuscript:** sec-synthesis
- **Scope:** algorithm and preservation argument
- **Caveat:** The observer is a concurrent local property, not a requested-root input fiber.
- **Certainty:** high

### E012

- **Finding:** Full-dimensional hyperplane cells have complete duplicate-free output-sensitive enumeration algorithms with the stated arithmetic or LP-relative bounds.
- **Works:** avis1996reverse,sleumer1998output,ferrez2005fixedrank,rada2018new
- **Anchors:** sources/avis1996reverse.md#evidence-locations;sources/sleumer1998output.md#evidence-locations;sources/ferrez2005fixedrank.md#evidence-locations;sources/rada2018new.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-introduction,sec-routes,sec-complexity
- **Scope:** algorithms, spanning arguments, and complexity theorems
- **Caveat:** Bounds do not transfer to non-strict boundary fibers or arbitrary caller predicates.
- **Certainty:** high

### E013

- **Finding:** Zonotope traversal supplies a rational-bit-model output-polynomial result, structured symmetry improves selected instances, and newer circuit-guided work does not replace the generic enumeration-class bound.
- **Works:** deza2022linear,deza2026whitewhale,dussault2025bdifferential
- **Anchors:** sources/deza2022linear.md#complexity-and-qualifications;sources/deza2026whitewhale.md#guarantee-and-complexity-boundary;sources/dussault2025bdifferential.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-complexity
- **Scope:** complexity theorem and algorithm comparison
- **Caveat:** The Deza-Pournin algorithm retains output-sized state; the successor improvements are structure-dependent.
- **Certainty:** moderate

### E014

- **Finding:** Exact neural methods enumerate dense activation cells, exact input stars or polyhedra, and affine maps.
- **Works:** serra2018bounding,vincent2021reachable
- **Anchors:** sources/serra2018bounding.md#evidence-locations;sources/vincent2021reachable.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-routes
- **Scope:** encodings, traversal, and exactness
- **Caveat:** Most results concern bounded dense networks and require boundary qualifications.
- **Certainty:** moderate

### E015

- **Finding:** Neural tree extraction constructs EC-DTs with reported exact empirical fidelity and contradiction pruning; affine decision structures prove function preservation and can remove infeasible or entailed tests.
- **Works:** nguyen2020ecdt,affinitree2024
- **Anchors:** sources/nguyen2020ecdt.md#evidence-locations;sources/affinitree2024.md#evidence-locations
- **Supports:** C01,C04,C07,C09,C15
- **Manuscript:** sec-routes
- **Scope:** construction and empirical evaluation for EC-DT; equivalence theorem and LP simplification for Affinitree
- **Caveat:** Both preserve an extensional network function rather than the contextual selection-event observer; Affinitree's theorem-level guarantee is not attributed to EC-DT.
- **Certainty:** moderate

### E016

- **Finding:** Hybrid-mode and piecewise-affine methods already compose guards with affine residuals and exactly merge or factor equal-behavior regions.
- **Works:** geyer2010mode,geyer2008optimal
- **Anchors:** sources/geyer2010mode.md#evidence-locations;sources/geyer2008optimal.md#evidence-locations
- **Supports:** C01,C04,C09,C15
- **Manuscript:** sec-routes,sec-complexity,sec-framework
- **Scope:** composition, exactness, and complexity results
- **Caveat:** These methods preserve extensional affine behavior rather than contextual graph events.
- **Certainty:** high

### E017

- **Finding:** Reverse search enumerates every full-dimensional pLP critical-region basis with reconstructible affine optimizer and the displayed LP-relative bound.
- **Works:** jones2006parametric
- **Anchors:** sources/jones2006parametric.md#evidence-locations
- **Supports:** C04,C10,C15
- **Manuscript:** sec-introduction,sec-routes,sec-complexity
- **Scope:** algorithm and complexity theorem
- **Caveat:** The theorem is basis and full-dimensional-region relative and omits a coefficient-bit bound.
- **Certainty:** high

### E018

- **Finding:** The sufficient-matrix pLCP traversal extends the positive-semidefinite precursor, covers pLP and convex pQP, and gives explicit general-position and lexicographically perturbed LP-oracle bounds per reported basis.
- **Works:** jones2006lcp,columbano2009sufficient
- **Anchors:** sources/jones2006lcp.md#evidence-locations;sources/columbano2009sufficient.md#evidence-locations
- **Supports:** C04,C10,C15
- **Manuscript:** sec-routes,sec-complexity
- **Scope:** full-dimensional pLCP basis enumeration under the papers' matrix and perturbation assumptions
- **Caveat:** Perturbed bases can outnumber unperturbed regions; the analysis retains an output-sized visited set and proves neither a coefficient-bit nor a DelayP bound.
- **Certainty:** high

### E019

- **Finding:** OutputP, IncP, and DelayP charge input, output, prefix, and delay costs under standard hard-enumeration definitions.
- **Works:** creignou2019enumeration
- **Anchors:** sources/creignou2019enumeration.md#evidence-locations
- **Supports:** C03,C10,C15
- **Manuscript:** sec-complexity
- **Scope:** enumeration-complexity definitions
- **Caveat:** A solver or compilation oracle is not free unless its representation and cost are part of the stated input model.
- **Certainty:** high

### E020

- **Finding:** Partial-order and observer-based state reductions omit redundant interleavings or states while preserving reachable-state coverage or a declared future-event observer.
- **Works:** holzmann1992coverage,aronis2018observers
- **Anchors:** sources/holzmann1992coverage.md#evidence-locations;sources/aronis2018observers.md#evidence-locations
- **Supports:** C01,C11,C15
- **Manuscript:** sec-synthesis
- **Scope:** primary algorithms and preservation results
- **Caveat:** The omitted dimension is concurrent schedule or state-space behavior, not requested-root-relative caller-input fibers.
- **Certainty:** high

### E021

- **Finding:** Observation-specific redundant-state detection can prune a state when no continuation reaches a new declared code observation.
- **Works:** bugrara2013redundant
- **Anchors:** sources/bugrara2013redundant.md#evidence-locations
- **Supports:** C01,C11,C15
- **Manuscript:** sec-synthesis
- **Scope:** primary algorithm and stated soundness scope
- **Caveat:** The preserved objective is code observation during bounded exploration, not an exact caller-input fiber partition.
- **Certainty:** high

### E022

- **Finding:** A finite goal-driven unfolding of a finite safe Petri net can omit transitions outside every minimal configuration to a requested marking while preserving all minimal goal-reaching configurations.
- **Works:** chatain2017goaldriven
- **Anchors:** sources/chatain2017goaldriven.md#evidence-locations
- **Supports:** C01,C14,C15
- **Manuscript:** sec-synthesis
- **Scope:** primary open paper, reduction property, algorithm, and theorems
- **Caveat:** The output is a partial-order configuration prefix for marking reachability, not a partition of symbolic caller inputs or a residual-valued observer image.
- **Certainty:** high

### E023

- **Finding:** A generalized unfolding framework lets a user state which information a prefix must preserve and how cutoffs are recognized, weakens adequate orders to well-founded relations, and separates extension-selection order from cutoff correctness.
- **Works:** bonet2014recent
- **Anchors:** sources/bonet2014recent.md#evidence-locations
- **Supports:** C01,C14,C15
- **Manuscript:** sec-synthesis
- **Scope:** primary article and theorem-level framework analysis
- **Caveat:** The user declaration ranges over unfolding preservation and cutoffs; it does not derive requested selection-site observations, input fibers, or typed residuals.
- **Certainty:** high

### E024

- **Finding:** Decision-DNNF compilation supports sound, complete, disjoint partial-model enumeration with polynomial delay after compilation.
- **Works:** lagniez2024decisiondnnf
- **Anchors:** sources/lagniez2024decisiondnnf.md#evidence-locations
- **Supports:** C01,C07,C15
- **Manuscript:** sec-routes
- **Scope:** official primary paper, definitions, propositions, and complexity analysis
- **Caveat:** This is not designated-variable projection. Compilation may be exponential, and a partial cube can cover several observations unless totalized activity/outcome coordinates are required in every output.
- **Certainty:** high

### E025

- **Finding:** Bidirectional demand semantics computes least sufficient partial inputs and cost for a requested output approximation in a pure typed calculus.
- **Works:** xia2024demand
- **Anchors:** sources/xia2024demand.md#evidence-locations
- **Supports:** C08,C15
- **Manuscript:** sec-routes
- **Scope:** primary preprint, formal definitions, mechanized lemmas, and theorems
- **Caveat:** The demand result concerns one known total input and partial-value definedness; it does not enumerate internal selection observations or exact caller-input fibers.
- **Certainty:** high

### E026

- **Finding:** Explicit-control methods can merge regions with different later decisions when they share a requested first action.
- **Works:** konig2020common,mitze2021common
- **Anchors:** sources/konig2020common.md#exact-result;sources/mitze2021common.md#contribution
- **Supports:** C09,C15
- **Manuscript:** sec-synthesis,sec-boundaries
- **Scope:** exact first-action grouping and certified reuse
- **Caveat:** These are extensional output quotients, not sparse contextual selection-event observers; the cross-domain distinction is our synthesis.
- **Certainty:** low

### E027

- **Finding:** A labeled-Petri-net observer can characterize exactly the current markings consistent with one observed transition-label word using a fixed-structure linear representation.
- **Works:** giua2003marking
- **Anchors:** sources/giua2003marking.md#evidence-locations
- **Supports:** C12,C15
- **Manuscript:** sec-synthesis
- **Scope:** exact compatible current-marking sets for the paper's labeled Petri-net model
- **Caveat:** The hidden objects are Petri-net markings, not caller inputs paired with typed residual program values.
- **Certainty:** high

### E028

- **Finding:** Exact BDD-based bisimulation minimization can cost more than direct symbolic invariant checking and often does not improve the downstream checking problem.
- **Works:** fisler2002bisimulation
- **Anchors:** sources/fisler2002bisimulation.md#evidence-locations
- **Supports:** C13,C15
- **Manuscript:** sec-synthesis,sec-boundaries
- **Scope:** exact quotient construction, analysis, and experiments
- **Caveat:** This rejects an automatic performance inference; it does not predict the workload of selection-fiber enumeration.
- **Certainty:** moderate

### E029

- **Finding:** Exact star propagation through a ReLU network retains input predicates and affine images while splitting on feasible activation cases.
- **Works:** tran2019star
- **Anchors:** sources/tran2019star.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-routes
- **Scope:** exact reachability for the paper's bounded ReLU-network model
- **Caveat:** A reachable output star is an extensional image object, not the graph's contextual selection observer.
- **Certainty:** high

### E030

- **Finding:** Property-directed generation refines the metavariable on which a first-order property is blocked and may return a partial constructor term denoting many satisfying completions.
- **Works:** lindblad2007property
- **Anchors:** sources/lindblad2007property.md#evidence-locations
- **Supports:** C06,C15
- **Manuscript:** sec-synthesis
- **Scope:** the paper's first-order constructor language and property-directed search
- **Caveat:** The paper states but does not prove the needed soundness and completeness conditions, and it does not aggregate one exact selection-observation fiber or residual.
- **Certainty:** moderate

### E032

- **Finding:** SymPaths records scheduler choices alongside symbolic execution and proves soundness and completeness relative to concrete executions.
- **Works:** deboer2020sympaths
- **Anchors:** sources/deboer2020sympaths.md#evidence-locations
- **Supports:** C11,C15
- **Manuscript:** sec-synthesis
- **Scope:** primary semantics and correctness theorems
- **Caveat:** The choice record observes concurrent schedules rather than requested-root graph selections.
- **Certainty:** high

### E033

- **Finding:** Repeated reveals/excludes and bounded equal-conflict parametric algorithms make multiplicity-sensitive event observation and query-relative reduction explicit.
- **Works:** bernardinello2016revealsexcludes,adobbati2024parametricreveals
- **Anchors:** sources/bernardinello2016revealsexcludes.md#evidence-locations;sources/adobbati2024parametricreveals.md#evidence-locations
- **Supports:** C14,C15
- **Scope:** primary definitions, algorithms, and bounded-net guarantees
- **Caveat:** These are run/event observers over Petri nets, not caller-input fibers with residual functions.
- **Certainty:** high

### E034

- **Finding:** Maximal affine regions of a ReLU network merge connected activation cells that implement the same affine map, so region counts under the two definitions differ.
- **Works:** wang2022regions
- **Anchors:** sources/wang2022regions.md#why-it-matters
- **Supports:** C04,C15
- **Scope:** the quotient distinction between activation cells and equal-map regions
- **Caveat:** Abstract-only read; the claim is anchored at abstract level and supports no theorem or algorithm statement.
- **Certainty:** low

### E035

- **Finding:** Prime-implicant enumeration from Decision-DNNF circuits has characterized output-sensitive complexity, establishing don't-care-style implicant minimization as its own literature.
- **Works:** decolnet2022prime
- **Anchors:** sources/decolnet2022prime.md#complexity-definitions-and-results
- **Supports:** C01
- **Scope:** the logical don't-care leg of the omission-mechanism taxonomy
- **Caveat:** Anchors the leg's existence and complexity framing, not any correspondence with the selection observer; that correspondence is the survey's taxonomy.
- **Certainty:** high

### E036

- **Finding:** Lexicographic perturbation for multiparametric LP selects a unique continuous piecewise-affine optimizer and nonoverlapping basis regions under the paper's assumptions.
- **Works:** jones2007lexicographic
- **Anchors:** sources/jones2007lexicographic.md#evidence-locations
- **Supports:** C04,C10,C15
- **Manuscript:** sec-complexity
- **Scope:** the paper's multiparametric linear-programming model
- **Caveat:** The result concerns optimizer/basis representations, not contextual graph-event fibers.
- **Certainty:** high

### E037

- **Finding:** A minimum-norm secondary optimization yields a unique continuous selection from the original pQP solution set with an algorithm-independent polyhedral representation under stated assumptions.
- **Works:** spjotvold2007unique
- **Anchors:** sources/spjotvold2007unique.md#evidence-locations
- **Supports:** C04,C10,C15
- **Manuscript:** sec-complexity
- **Scope:** the paper's convex multiparametric quadratic programs
- **Caveat:** This is a selected optimizer quotient, not a selection-event observer.
- **Certainty:** high

### E038

- **Finding:** A graphical-derivative adjacency method discovers every full-dimensional convex-pQP neighbor across a facet without nondegeneracy or a facet-to-facet assumption.
- **Works:** patrinos2010graphical
- **Anchors:** sources/patrinos2010graphical.md#qualifications-and-complexity
- **Supports:** C04,C10,C15
- **Manuscript:** sec-complexity
- **Scope:** full-dimensional critical regions of the stated convex pQP class
- **Caveat:** The paper gives no polynomial total, delay, workspace, or coefficient-bit bound and omits lower-dimensional-only regions.
- **Certainty:** high

### E039

- **Finding:** Rank-deficient strictly convex mpQP can be handled by enumerating optimal active-set combinations with the paper's NNLS-based per-combination analysis.
- **Works:** bemporad2015multiparametric
- **Anchors:** sources/bemporad2015multiparametric.md#evidence-locations
- **Supports:** C04,C10,C15
- **Manuscript:** sec-complexity
- **Scope:** the paper's strictly convex mpQP assumptions
- **Caveat:** At most exponentially many active-set combinations are considered; this is not a new enumeration-class bound.
- **Certainty:** high

### E040

- **Finding:** Multiparametric linear-program solution and halfspace polyhedral projection have polynomial input and output conversions in both directions.
- **Works:** jones2008projection
- **Anchors:** sources/jones2008projection.md#evidence-locations
- **Supports:** C10,C15
- **Manuscript:** sec-complexity
- **Scope:** the representations and reductions stated in the paper
- **Caveat:** The interreduction does not identify either object with the selection observer.
- **Certainty:** high

### E041

- **Finding:** PESO enumerates reordered relevant-slice conditions for requested slicing criteria, associates them with symbolic outputs and solver-generated tests, and is conditionally complete for the finite RSC set under a sound and complete solver.
- **Works:** qi2013output
- **Anchors:** sources/qi2013output.md#evidence-locations
- **Supports:** C02,C03,C15
- **Manuscript:** sec-introduction,sec-routes,sec-synthesis
- **Scope:** the paper's finite symbolic program model and RSC exploration assumptions
- **Caveat:** Equal RSCs fix symbolic outputs, but the paper does not prove that RSCs are the coarsest output quotient or that one RSC equals one instrumented selection fiber.
- **Certainty:** high

### E042

- **Finding:** SPD builds a shared graph of dependence-relevant path families and guarded symbolic values for queried uses while avoiding products of irrelevant control subpaths.
- **Works:** santelices2010dependencies
- **Anchors:** sources/santelices2010dependencies.md#evidence-locations
- **Supports:** C02,C03,C15
- **Manuscript:** sec-introduction,sec-routes,sec-synthesis
- **Scope:** the paper's symbolic program-dependence construction and exact mode
- **Caveat:** The paper describes equality with pathwise symbolic execution but gives no numbered end-to-end soundness/completeness theorem; exact correspondence to selection fibers is open.
- **Certainty:** moderate

### E043

- **Finding:** Dynamic functional-space partitioning represents mux behavior by mutually exclusive Boolean control cells paired with selected data expressions and recursively omits unselected case partitions.
- **Works:** feng2004dynamic
- **Anchors:** sources/feng2004dynamic.md#evidence-locations
- **Supports:** C02,C04,C15
- **Manuscript:** sec-introduction,sec-synthesis
- **Scope:** symbolic simulation of the paper's hardware/dataflow model
- **Caveat:** Heuristic split points and merging can erase source-event provenance; the paper does not prove the target's one-record-per-contextual-observation contract.
- **Certainty:** moderate

### E044

- **Finding:** Symbolic Simulink/Stateflow analysis records conditional-block outcomes in bounded discrete traces and carries symbolic predicates and residual transformers.
- **Works:** kanade2009simulink
- **Anchors:** sources/kanade2009simulink.md#evidence-locations
- **Supports:** C02,C15
- **Manuscript:** sec-synthesis
- **Scope:** the paper's bounded trace and block-value-region construction
- **Caveat:** The computed region is an underapproximation of one sampled trace class, not an exhaustive disjoint exact partition.
- **Certainty:** high

### E045

- **Finding:** Sylvia independently explores RTL block path fragments, combines them with SMT feasibility checks, and returns replayable witness inputs.
- **Works:** ryan2023sylvia
- **Anchors:** sources/ryan2023sylvia.md#evidence-locations
- **Supports:** C03,C15
- **Manuscript:** sec-synthesis
- **Scope:** the paper's modular RTL symbolic-execution algorithm
- **Caveat:** The full fragment combination remains exponential in the stated worst case and the output is not one exact selection-fiber guard/residual record.
- **Certainty:** moderate

### E046

- **Finding:** Set-function evaluation records the nondeterministic steps actually executed as a fingerprint, representable by choice-node/rule pairs; it does not yet establish the later stable choice-ID partial-map form.
- **Works:** antoy2009setfunctions
- **Anchors:** sources/antoy2009setfunctions.md#evidence-locations
- **Supports:** C06,C07,C15
- **Manuscript:** sec-introduction,sec-routes,sec-synthesis
- **Scope:** the paper's functional-logic computation-space semantics
- **Caveat:** Complete strategies enumerate values, but the paper does not prove stable identity across runtime copies, one canonical fingerprint class, a caller-input guard, or a symbolic residual per graph observation.
- **Certainty:** high

### E047

- **Finding:** Pull-tabbing propagates immutable choice identifiers so duplicated runtime occurrences of one nondeterministic choice make a consistent decision.
- **Works:** alqaddoumi2010pulltab
- **Anchors:** sources/alqaddoumi2010pulltab.md#evidence-locations
- **Supports:** C06,C07,C15
- **Manuscript:** sec-introduction,sec-routes,sec-synthesis
- **Scope:** call-time choice under the paper's pull-tab transformation
- **Caveat:** The paper gives neither a numbered soundness/completeness theorem nor deterministic caller-input fibers and residuals.
- **Certainty:** moderate

### E048

- **Finding:** Memoized pull-tabbing demand-populates a task-local fingerprint mapping stable choice identifiers to outcomes and reuses it to avoid repeated traversal.
- **Works:** hanus2021memoized
- **Anchors:** sources/hanus2021memoized.md#evidence-locations
- **Supports:** C06,C07,C15
- **Manuscript:** sec-introduction,sec-routes,sec-synthesis
- **Scope:** the paper's memoized functional-logic evaluation scheme
- **Caveat:** Correctness and operational completeness are attributed to earlier pull-tabbing results; MPT itself does not define or prove exact input guards, residuals, or selection-fiber coverage.
- **Certainty:** moderate

### E049

- **Finding:** SPLat discovers configuration variables on first read, checks partial assignments against a feature model, and backtracks over the access stack to execute one configuration per claimed distinct reachable test trace.
- **Works:** kim2013splat
- **Anchors:** sources/kim2013splat.md#evidence-locations
- **Supports:** C06,C15
- **Manuscript:** sec-routes,sec-synthesis
- **Scope:** bounded finite configuration variables, a test, and the paper's reset/execution assumptions
- **Caveat:** The paper gives no formal soundness/completeness/nonrepetition theorem and emits neither an exact symbolic fiber guard nor a residual function.
- **Certainty:** moderate

### E050

- **Finding:** Wang et al.'s `Next` algorithm enumerates every locally colored equivalence class of solution trees in an acyclic decomposable AND/OR graph exactly once with delay \(O(ns)\).
- **Works:** wang2021equivalence
- **Anchors:** sources/wang2021equivalence.md#evidence-locations
- **Supports:** C05,C15
- **Manuscript:** sec-introduction,sec-synthesis,sec-complexity
- **Scope:** the supplied decomposable acyclic graph, local coloring equivalence, graph size \(n\), and solution size \(s\)
- **Caveat:** The output is a colored class tree, not a caller-input guard, residual, or witness; no general reduction from arbitrary observer fibers is proved.
- **Certainty:** high

### E051

- **Finding:** Chang et al. construct an exact decision-tree representation of a neural-network controller's extensional policy and compact it while preserving policy equivalence.
- **Works:** chang2026compact
- **Anchors:** sources/chang2026compact.md#evidence-locations
- **Supports:** C07,C09,C15
- **Manuscript:** sec-synthesis,sec-boundaries
- **Scope:** the paper's neural-controller and decision-tree representation assumptions
- **Caveat:** Policy equivalence can merge internal activation or selection events and does not provide the survey's residual-valued event observer.
- **Certainty:** high

### E052

- **Finding:** Explicit conversion of a ReLU network to a piecewise-affine representation emits polyhedral input regions paired with affine maps.
- **Works:** robinson2020dissecting
- **Anchors:** sources/robinson2020dissecting.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-routes
- **Scope:** the paper's ReLU-network conversion procedure
- **Caveat:** The representation is extensional and need not retain contextual activation-event identities.
- **Certainty:** moderate

### E053

- **Finding:** Exact neural-network analysis can construct the full polyhedral complex induced by a piecewise-linear network, including lower-dimensional faces.
- **Works:** masden2022algorithmic
- **Anchors:** sources/masden2022algorithmic.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-routes
- **Scope:** the paper's genericity and piecewise-linear network assumptions
- **Caveat:** A face complex is a geometric representation, not a requested-root contextual event observer.
- **Certainty:** moderate

### E054

- **Finding:** A polyhedral-complex method recovers activation regions and their face relations for piecewise-affine neural networks.
- **Works:** berzins2023polyhedral
- **Anchors:** sources/berzins2023polyhedral.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-routes
- **Scope:** the paper's network and polyhedral-complex assumptions
- **Caveat:** Its output quotient and boundary conventions differ from sparse selection observations.
- **Certainty:** moderate

### E055

- **Finding:** Parallel layerwise activation-region enumeration has work and storage governed by intermediate region counts and the paper's bounded-domain assumptions.
- **Works:** drammis2024parallel
- **Anchors:** sources/drammis2024parallel.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-routes
- **Scope:** the paper's parallel exact neural-region algorithm
- **Caveat:** The analysis concerns dense activation regions, not residual-valued sparse observations.
- **Certainty:** moderate

### E056

- **Finding:** Korat observes fields read by an executable representation invariant and exhaustively generates finitized nonisomorphic satisfying object structures.
- **Works:** boyapati2002korat
- **Anchors:** sources/boyapati2002korat.md#evidence-locations
- **Supports:** C06,C15
- **Manuscript:** sec-synthesis
- **Scope:** finitized object structures and the paper's canonical construction procedure
- **Caveat:** It emits concrete structures, not one symbolic guard/residual record per observer fiber.
- **Certainty:** high

### E057

- **Finding:** Bounded lazy initialization refines symbolic heap fields on access while using relational bounds and canonical labels to reduce bounded structure generation.
- **Works:** geldenhuys2013bounded
- **Anchors:** sources/geldenhuys2013bounded.md#evidence-locations
- **Supports:** C06,C15
- **Scope:** the paper's bounded symbolic-heap model
- **Caveat:** Locally consistent partial heaps can lack a globally valid completion, and no observation quotient is emitted.
- **Certainty:** moderate

### E058

- **Finding:** BLISS uses SAT with a declarative invariant to retain exactly the bounded heaps admitted by lazy initialization's validity condition.
- **Works:** rosner2015bliss
- **Anchors:** sources/rosner2015bliss.md#evidence-locations
- **Supports:** C06,C15
- **Manuscript:** sec-synthesis
- **Scope:** bounded symbolic heaps under the paper's invariant encoding
- **Caveat:** Heap validity remains separate from path behavior and the output is not an exact observer-fiber partition.
- **Certainty:** high

### E059

- **Finding:** LISSA combines demand-driven heap refinement with bounded-exhaustive symbolic solving so that no valid heap path admitted by its executable invariant is pruned.
- **Works:** copia2022lissa
- **Anchors:** sources/copia2022lissa.md#evidence-locations
- **Supports:** C06,C15
- **Manuscript:** sec-synthesis
- **Scope:** the paper's bounded heap and executable-invariant model
- **Caveat:** Heap feasibility and primitive path feasibility are not jointly exact in this result, and paths are not grouped by observer fiber.
- **Certainty:** high

### E060

- **Finding:** Precise lazy initialization jointly solves heap structure and path conditions and preserves exactly the bounded feasible scoped symbolic states of its baseline.
- **Works:** copia2023precise
- **Anchors:** sources/copia2023precise.md#evidence-locations
- **Supports:** C06,C15
- **Manuscript:** sec-synthesis
- **Scope:** the paper's bounded scoped symbolic-state model and solver assumptions
- **Caveat:** Exact state preservation is not one-record-per-selection-observation aggregation and supplies no requested residual function.
- **Certainty:** high

### E061

- **Finding:** Controller clipping and separator constructions remove explicit region descriptions while preserving the pointwise controller function.
- **Works:** kvasnica2012clipping,kvasnica2013separation
- **Anchors:** sources/kvasnica2012clipping.md#contribution;sources/kvasnica2013separation.md#contribution
- **Supports:** C09,C15
- **Scope:** exact pointwise-equivalent controller factorizations
- **Caveat:** Function-preserving factorization is an extensional representation result, not a sparse contextual selection-event observer; the cross-domain distinction is the survey's synthesis.
- **Certainty:** low

### E062

- **Finding:** Classical symbolic execution runs programs on symbolic inputs, propagates formula-valued states, and treats conditional branches as a central testing problem.
- **Works:** king1976symbolic
- **Anchors:** sources/king1976symbolic.md#evidence-locations
- **Supports:** C02,C15
- **Manuscript:** sec-routes
- **Scope:** publisher abstract and bibliographic metadata
- **Caveat:** The abstract establishes the lineage, not exact observation-fiber grouping or an enumeration theorem.
- **Certainty:** low

### E063

- **Finding:** DART combines concrete executions with dynamic symbolic analysis that generates new inputs to direct exploration toward alternative program paths.
- **Works:** godefroid2005dart
- **Anchors:** sources/godefroid2005dart.md#evidence-locations
- **Supports:** C02,C03,C15
- **Manuscript:** sec-routes,sec-algorithms
- **Scope:** publisher abstract and bibliographic metadata
- **Caveat:** Model-guided path exploration does not itself aggregate complete selection-observation fibers.
- **Certainty:** low

### E064

- **Finding:** SEDGE uses concolic SMT reasoning over high-level Pig dataflow programs to generate input data intended to cover operator cases.
- **Works:** li2013sedge
- **Anchors:** sources/li2013sedge.md#evidence-locations
- **Supports:** C02,C15
- **Manuscript:** sec-routes
- **Scope:** accepted-paper abstract and introduction
- **Caveat:** Operator-case coverage by an accumulated example dataset is not duplicate-free exact fiber enumeration with residuals.
- **Certainty:** low

### E065

- **Finding:** Variational execution represents configuration-dependent alternatives under propositional contexts and shares redundant work across many configurations.
- **Works:** wong2018variational
- **Anchors:** sources/wong2018variational.md#evidence-locations
- **Supports:** C02,C07,C15
- **Manuscript:** sec-routes
- **Scope:** primary abstract and introduction
- **Caveat:** A shared multi-configuration execution is a representation predecessor, not one exact inverse-fiber record per selection observation.
- **Certainty:** low
