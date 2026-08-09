# Evidence ledger

One record per evidence item: a single checkable finding from the
literature, bound downward to source-note anchors, upward to the
`Cxx` claims it supports, and across to the manuscript sections that
cite on its strength. Scope and caveat ride the record. The
validator enforces the bindings. Keys are comma-separated, anchors
semicolon-separated.

Fields: **Finding** (what the literature shows), **Works** (citekeys),
**Anchors** (`sources/<citekey>.md#<heading>`), **Supports** (`Cxx`,
omitted when none), **Manuscript** (section labels, omitted when
none), **Scope**, **Caveat**, and optional **Certainty**
(`high`/`moderate`/`low`, GRADE-inspired; graded on next evidence
touch).


### E001

- **Finding:** The study design follows systematic-mapping, separate snowballing, and auditable secondary-study reporting guidance.
- **Works:** petersen2015mapping,wohlin2014snowballing,kitchenham2023segress
- **Anchors:** sources/petersen2015mapping.md#evidence-locations;sources/wohlin2014snowballing.md#evidence-locations;sources/kitchenham2023segress.md#evidence-locations
- **Manuscript:** sec-method
- **Scope:** methodology
- **Caveat:** These sources guide reporting; they do not certify literature completeness.

### E002

- **Finding:** Exact symbolic execution already represents behavior with path or merge guards and residual symbolic states or values.
- **Works:** voogd2025compositional,sen2015multise,porncharoenwase2022merging,lu2023grisette
- **Anchors:** sources/voogd2025compositional.md#evidence-locations;sources/sen2015multise.md#evidence-locations;sources/porncharoenwase2022merging.md#evidence-locations;sources/lu2023grisette.md#evidence-locations
- **Supports:** C02,C03
- **Manuscript:** sec-introduction,sec-related
- **Scope:** definitions and correctness theorems
- **Caveat:** The exact equivalence conditions and merge contracts differ across languages; correspondence with selection fibers is our synthesis.

### E003

- **Finding:** All-values and dependence-guided symbolic execution reduce exploration relative to selected values or dependences.
- **Works:** denaro2012allvalues,wang2017dependence
- **Anchors:** sources/denaro2012allvalues.md#evidence-locations;sources/wang2017dependence.md#evidence-locations
- **Supports:** C15
- **Manuscript:** sec-related
- **Scope:** algorithms, guarantees, and experiments
- **Caveat:** Their CFG and dependence observers are not the selection-observation fiber.

### E004

- **Finding:** AllSMT and disjoint projected enumeration already enumerate selected finite coordinates and projected partial models.
- **Works:** phan2015allsmtr,spallitta2024disjoint,spallitta2025projected
- **Anchors:** sources/phan2015allsmtr.md#evidence-locations;sources/spallitta2024disjoint.md#evidence-locations;sources/spallitta2025projected.md#evidence-locations
- **Supports:** C01,C02,C03,C15
- **Manuscript:** sec-introduction,sec-related
- **Scope:** algorithm and coverage/nonrepetition results
- **Caveat:** Phan enumerates important Boolean coordinates; relevant theory-variable values are sampled annotations. A short projected cube can cover several complete observation tuples; equality with local exact fibers requires activity instrumentation and totalized output coordinates.

### E005

- **Finding:** Finite observer predicates induce exactly enumerable input-equivalence classes or satisfiable Boolean atoms.
- **Works:** krafczyk2017effective,huang2024exhaustive
- **Anchors:** sources/krafczyk2017effective.md#evidence-locations;sources/huang2024exhaustive.md#evidence-locations
- **Supports:** C05,C15
- **Manuscript:** sec-related
- **Scope:** definitions, enumeration algorithms, and exactness results
- **Caveat:** The graph-specific positive guard is a specialized representation of these generic fibers.

### E006

- **Finding:** BDDs and ADDs compile exact finite-range functions with order-qualified canonicity and exponential worst cases.
- **Works:** bryant1986bdd,bahar1997add
- **Anchors:** sources/bryant1986bdd.md#evidence-locations;sources/bahar1997add.md#evidence-locations
- **Supports:** C07,C15
- **Manuscript:** sec-introduction,sec-related
- **Scope:** representation definitions and complexity
- **Caveat:** A symbolic residual per observation terminal requires an additional construction.

### E007

- **Finding:** Functional-logic search uses stable shared choice identities and demand-populated fingerprints in complete or fair search schemes.
- **Works:** antoy2011pull,brassel2007tighter,brassel2011thesis,jost2023fairscheme
- **Anchors:** sources/antoy2011pull.md#evidence-locations;sources/brassel2007tighter.md#evidence-locations;sources/brassel2011thesis.md#evidence-locations;sources/jost2023fairscheme.md#evidence-locations
- **Supports:** C01,C06,C15
- **Manuscript:** sec-introduction,sec-related
- **Scope:** choice representations and adequacy/value-preservation theorems
- **Caveat:** Identities and nondeterministic result semantics differ from static contextual graph sites.

### E008

- **Finding:** Lazy SmallCheck refines only the partial input fragment demanded by an executable Boolean observer while preserving bounded exhaustive testing.
- **Works:** runciman2008smallcheck
- **Anchors:** sources/runciman2008smallcheck.md#evidence-locations
- **Supports:** C01,C06,C15
- **Manuscript:** sec-introduction,sec-related
- **Scope:** algorithm and exhaustiveness argument
- **Caveat:** It does not emit one canonical exact guard/residual record per selection-observation fiber.

### E009

- **Finding:** Classical stream-dataflow work computes reverse demands or least legal requested-output computations for fixed inputs under explicit conditions.
- **Works:** pingali1985efficient,avron1994stability
- **Anchors:** sources/pingali1985efficient.md#evidence-locations;sources/avron1994stability.md#evidence-locations
- **Supports:** C08,C15
- **Manuscript:** sec-related
- **Scope:** transform correctness, parsimony, and stability characterization
- **Caveat:** Equality with the survey's strict finite enabled closure requires a specialization proof.

### E010

- **Finding:** Selective functors and compositional symbolic execution establish reusable compositional structures and path summaries.
- **Works:** mokhov2019selective,godefroid2007compositional,anand2008demand
- **Anchors:** sources/mokhov2019selective.md#evidence-locations;sources/godefroid2007compositional.md#evidence-locations;sources/anand2008demand.md#evidence-locations
- **Supports:** C15
- **Manuscript:** sec-related
- **Scope:** universal interpreter and summary algorithms
- **Caveat:** They do not state the exact requested-root observation-fiber correspondence.

### E011

- **Finding:** Symbolic partial-order reduction explores representative interleavings of independent concurrent events while preserving local-property verification.
- **Works:** alur2001partialorder
- **Anchors:** sources/alur2001partialorder.md#evidence-locations
- **Supports:** C11,C15
- **Manuscript:** sec-related
- **Scope:** algorithm and preservation argument
- **Caveat:** The observer is a concurrent local property, not a requested-root input fiber.

### E012

- **Finding:** Full-dimensional hyperplane cells have complete duplicate-free output-sensitive enumeration algorithms with the stated arithmetic or LP-relative bounds.
- **Works:** avis1996reverse,sleumer1998output,ferrez2005fixedrank,rada2018new
- **Anchors:** sources/avis1996reverse.md#evidence-locations;sources/sleumer1998output.md#evidence-locations;sources/ferrez2005fixedrank.md#evidence-locations;sources/rada2018new.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-introduction,sec-related,sec-complexity
- **Scope:** algorithms, spanning arguments, and complexity theorems
- **Caveat:** Bounds do not transfer to non-strict boundary fibers or arbitrary caller predicates.

### E013

- **Finding:** Zonotope traversal supplies a rational-bit-model output-polynomial result, structured symmetry improves selected instances, and newer circuit-guided work does not replace the generic enumeration-class bound.
- **Works:** deza2022linear,deza2026whitewhale,dussault2025bdifferential
- **Anchors:** sources/deza2022linear.md#complexity-and-qualifications;sources/deza2026whitewhale.md#guarantee-and-complexity-boundary;sources/dussault2025bdifferential.md#evidence-locations
- **Supports:** C04,C15
- **Manuscript:** sec-complexity
- **Scope:** complexity theorem and algorithm comparison
- **Caveat:** The Deza-Pournin algorithm retains output-sized state; the successor improvements are structure-dependent.

### E014

- **Finding:** Exact neural methods enumerate dense activation cells, exact input stars or polyhedra, and affine maps; activation cells and maximal equal-map regions are distinct quotients.
- **Works:** serra2018bounding,vincent2021reachable,wang2022regions
- **Anchors:** sources/serra2018bounding.md#evidence-locations;sources/vincent2021reachable.md#evidence-locations;sources/wang2022regions.md#why-it-matters
- **Supports:** C04,C15
- **Manuscript:** sec-related,sec-complexity
- **Scope:** encodings, traversal, exactness, and quotient distinction
- **Caveat:** Most results concern bounded dense networks and require boundary qualifications.

### E015

- **Finding:** Neural tree extraction constructs EC-DTs with reported exact empirical fidelity and contradiction pruning; affine decision structures prove function preservation and can remove infeasible or entailed tests.
- **Works:** nguyen2020ecdt,affinitree2024
- **Anchors:** sources/nguyen2020ecdt.md#evidence-locations;sources/affinitree2024.md#evidence-locations
- **Supports:** C01,C04,C07,C09,C15
- **Manuscript:** sec-related
- **Scope:** construction and empirical evaluation for EC-DT; equivalence theorem and LP simplification for Affinitree
- **Caveat:** Both preserve an extensional network function rather than the contextual selection-event observer; Affinitree's theorem-level guarantee is not attributed to EC-DT.

### E016

- **Finding:** Hybrid-mode and piecewise-affine methods already compose guards with affine residuals and exactly merge or factor equal-behavior regions.
- **Works:** geyer2010mode,geyer2008optimal
- **Anchors:** sources/geyer2010mode.md#evidence-locations;sources/geyer2008optimal.md#evidence-locations
- **Supports:** C01,C04,C09,C15
- **Manuscript:** sec-related,sec-complexity
- **Scope:** composition, exactness, and complexity results
- **Caveat:** These methods preserve extensional affine behavior rather than contextual graph events.

### E017

- **Finding:** Reverse search enumerates every full-dimensional pLP critical-region basis with reconstructible affine optimizer and the displayed LP-relative bound.
- **Works:** jones2006parametric
- **Anchors:** sources/jones2006parametric.md#evidence-locations
- **Supports:** C04,C10,C15
- **Manuscript:** sec-introduction,sec-related,sec-complexity
- **Scope:** algorithm and complexity theorem
- **Caveat:** The theorem is basis and full-dimensional-region relative and omits a coefficient-bit bound.

### E018

- **Finding:** Parametric programming provides a positive-semidefinite pLCP precursor, explicit sufficient-matrix output bounds, unique selected pQP representations, degeneracy-safe adjacency, rank-deficiency handling, and pLP/projection interreduction.
- **Works:** jones2006lcp,columbano2009sufficient,jones2007lexicographic,spjotvold2007unique,patrinos2010graphical,bemporad2015multiparametric,jones2008projection
- **Anchors:** sources/jones2006lcp.md#evidence-locations;sources/columbano2009sufficient.md#evidence-locations;sources/jones2007lexicographic.md#evidence-locations;sources/spjotvold2007unique.md#evidence-locations;sources/patrinos2010graphical.md#qualifications-and-complexity;sources/bemporad2015multiparametric.md#evidence-locations;sources/jones2008projection.md#evidence-locations
- **Supports:** C04,C10,C15
- **Manuscript:** sec-related,sec-complexity
- **Scope:** theorems and algorithm analyses
- **Caveat:** Each guarantee has distinct assumptions; perturbed bases can outnumber unperturbed regions and no general DelayP or bit bound is inferred.

### E019

- **Finding:** OutputP, IncP, and DelayP charge input, output, prefix, and delay costs under standard hard-enumeration definitions.
- **Works:** creignou2019enumeration
- **Anchors:** sources/creignou2019enumeration.md#evidence-locations
- **Supports:** C03,C10,C15
- **Manuscript:** sec-complexity
- **Scope:** enumeration-complexity definitions
- **Caveat:** A solver or compilation oracle is not free unless its representation and cost are part of the stated input model.

### E020

- **Finding:** Partial-order and observer-based state reductions omit redundant interleavings or states while preserving reachable-state coverage or a declared future-event observer.
- **Works:** holzmann1992coverage,aronis2018observers
- **Anchors:** sources/holzmann1992coverage.md#evidence-locations;sources/aronis2018observers.md#evidence-locations
- **Supports:** C01,C11,C15
- **Manuscript:** sec-related
- **Scope:** primary algorithms and preservation results
- **Caveat:** The omitted dimension is concurrent schedule or state-space behavior, not requested-root-relative caller-input fibers.

### E021

- **Finding:** Observation-specific redundant-state detection can prune a state when no continuation reaches a new declared code observation.
- **Works:** bugrara2013redundant
- **Anchors:** sources/bugrara2013redundant.md#evidence-locations
- **Supports:** C01,C11,C15
- **Manuscript:** sec-related
- **Scope:** primary algorithm and stated soundness scope
- **Caveat:** The preserved objective is code observation during bounded exploration, not an exact caller-input fiber partition.

### E022

- **Finding:** A finite goal-driven unfolding of a finite safe Petri net can omit transitions outside every minimal configuration to a requested marking while preserving all minimal goal-reaching configurations.
- **Works:** chatain2017goaldriven
- **Anchors:** sources/chatain2017goaldriven.md#evidence-locations
- **Supports:** C01,C14,C15
- **Manuscript:** sec-related
- **Scope:** primary open paper, reduction property, algorithm, and theorems
- **Caveat:** The output is a partial-order configuration prefix for marking reachability, not a partition of symbolic caller inputs or a residual-valued observer image.

### E023

- **Finding:** A generalized unfolding framework lets a user state which information a prefix must preserve and how cutoffs are recognized, weakens adequate orders to well-founded relations, and separates extension-selection order from cutoff correctness.
- **Works:** bonet2014recent
- **Anchors:** sources/bonet2014recent.md#evidence-locations
- **Supports:** C01,C14,C15
- **Manuscript:** sec-related
- **Scope:** primary article and theorem-level framework analysis
- **Caveat:** The user declaration ranges over unfolding preservation and cutoffs; it does not derive requested selection-site observations, input fibers, or typed residuals.

### E024

- **Finding:** Decision-DNNF compilation supports sound, complete, disjoint partial-model enumeration with polynomial delay after compilation.
- **Works:** lagniez2024decisiondnnf
- **Anchors:** sources/lagniez2024decisiondnnf.md#evidence-locations
- **Supports:** C01,C07,C15
- **Manuscript:** sec-related
- **Scope:** official primary paper, definitions, propositions, and complexity analysis
- **Caveat:** This is not designated-variable projection. Compilation may be exponential, and a partial cube can cover several observations unless totalized activity/outcome coordinates are required in every output.

### E025

- **Finding:** Bidirectional demand semantics computes least sufficient partial inputs and cost for a requested output approximation in a pure typed calculus.
- **Works:** xia2024demand
- **Anchors:** sources/xia2024demand.md#evidence-locations
- **Supports:** C08,C15
- **Manuscript:** sec-related
- **Scope:** primary preprint, formal definitions, mechanized lemmas, and theorems
- **Caveat:** The demand result concerns one known total input and partial-value definedness; it does not enumerate internal selection observations or exact caller-input fibers.

### E026

- **Finding:** Explicit-control methods can merge regions with different later decisions when they share a requested first action, or remove region descriptions while preserving the pointwise controller function.
- **Works:** konig2020common,mitze2021common,kvasnica2012clipping,kvasnica2013separation
- **Anchors:** sources/konig2020common.md#exact-result;sources/mitze2021common.md#contribution;sources/kvasnica2012clipping.md#contribution;sources/kvasnica2013separation.md#contribution
- **Supports:** C09,C15
- **Scope:** exact first-action grouping, certified reuse, and pointwise-equivalent controller factorizations
- **Caveat:** These are extensional output quotients or factorizations, not sparse contextual selection-event observers; the cross-domain distinction is our synthesis.

### E027

- **Finding:** Petri-net observers characterize current or minimum initial markings consistent with an observed label word and can incorporate nondeterministic labels, timing, or unobservable events.
- **Works:** giua2003marking,corona2003observers,li2009minimum,ghazel2009observer
- **Anchors:** sources/giua2003marking.md#evidence-locations;sources/corona2003observers.md#evidence-locations;sources/li2009minimum.md#evidence-locations;sources/ghazel2009observer.md#evidence-locations
- **Supports:** C12,C15
- **Scope:** exact compatible-marking sets, optimization-restricted initial sets, and timed state estimation
- **Caveat:** The hidden objects are Petri-net markings or timed states, not caller inputs paired with typed residual program values; the detailed minimum-marking claim is pinned to the full conference primary.

### E028

- **Finding:** Exact BDD-based bisimulation minimization can cost more than direct symbolic invariant checking and often does not improve the downstream checking problem.
- **Works:** fisler2002bisimulation
- **Anchors:** sources/fisler2002bisimulation.md#evidence-locations
- **Supports:** C13,C15
- **Scope:** exact quotient construction, analysis, and experiments
- **Caveat:** This rejects an automatic performance inference; it does not predict the workload of selection-fiber enumeration.

### E029

- **Finding:** Exact neural-region work also uses star sets, explicit PWA conversion, polyhedral complexes, and parallel layerwise enumeration, with different output quotients and guarantees.
- **Works:** tran2019star,robinson2020dissecting,masden2022algorithmic,berzins2023polyhedral,drammis2024parallel
- **Anchors:** sources/tran2019star.md#evidence-locations;sources/robinson2020dissecting.md#evidence-locations;sources/masden2022algorithmic.md#evidence-locations;sources/berzins2023polyhedral.md#evidence-locations;sources/drammis2024parallel.md#evidence-locations
- **Supports:** C04,C15
- **Scope:** primary algorithms, exactness statements, and representation boundaries
- **Caveat:** These objects need not preserve the graph's contextual selection observer.

### E030

- **Finding:** Property-blocked and access-guided generation, bounded lazy initialization, BLISS, LISSA, and PLI refine partial inputs or heaps under bounded exhaustive-search objectives.
- **Works:** lindblad2007property,boyapati2002korat,geldenhuys2013bounded,rosner2015bliss,copia2022lissa,copia2023precise
- **Anchors:** sources/lindblad2007property.md#evidence-locations;sources/boyapati2002korat.md#evidence-locations;sources/geldenhuys2013bounded.md#evidence-locations;sources/rosner2015bliss.md#evidence-locations;sources/copia2022lissa.md#evidence-locations;sources/copia2023precise.md#evidence-locations
- **Supports:** C06,C15
- **Scope:** primary algorithms and work-specific correctness scopes
- **Caveat:** Lindblad states but does not prove the needed soundness/completeness conditions; the other works have their own proved or explicitly scoped guarantees. Their observers and artifacts differ from exact selection-observation records.

### E031

- **Finding:** Reward-space regions can group rewards that induce the same optimal MDP policy and support policy-invariance analysis.
- **Works:** shin2024multitask
- **Anchors:** sources/shin2024multitask.md#relevance
- **Supports:** C09,C15
- **Scope:** primary abstract and conference-archive presentation text
- **Caveat:** This screened source supports only the high-level comparator claim, not an enumeration theorem, canonicality result, or complexity bound.

### E032

- **Finding:** SymPaths records scheduler choices alongside symbolic execution and proves soundness and completeness relative to concrete executions.
- **Works:** deboer2020sympaths
- **Anchors:** sources/deboer2020sympaths.md#evidence-locations
- **Supports:** C11,C15
- **Scope:** primary semantics and correctness theorems
- **Caveat:** The choice record observes concurrent schedules rather than requested-root graph selections.

### E033

- **Finding:** Repeated reveals/excludes and bounded equal-conflict parametric algorithms make multiplicity-sensitive event observation and query-relative reduction explicit.
- **Works:** bernardinello2016revealsexcludes,adobbati2024parametricreveals
- **Anchors:** sources/bernardinello2016revealsexcludes.md#evidence-locations;sources/adobbati2024parametricreveals.md#evidence-locations
- **Supports:** C14,C15
- **Scope:** primary definitions, algorithms, and bounded-net guarantees
- **Caveat:** These are run/event observers over Petri nets, not caller-input fibers with residual functions.
