# Claims and qualification ledger

This file records the survey's current synthesis claims. Every
current claim is a settled survey synthesis — its **Status:** line
reads `survey synthesis`, with a qualifier after the semicolon
recording how novelty resolved (broad novelty defeated, formal
derivation recorded, implementation claim rejected). A new claim
enters as `hypothesis` and moves to `supported`, `known-result`, or
`rejected` under the novelty discipline. No item is novel merely
because it is listed. Each active claim must have explicit scope, anchored
evidence, and a stated relationship to the closest established result.

## Current survey synthesis claims

The `Cxx` identifiers below are stable synthesis-claim IDs. The
**Supports:** field of `evidence.md` connects primary-source
evidence to them; evidence rows have their own `Exxx` identifiers so that a
source's claim cannot be mistaken for this survey's synthesis.

### C01 — Taxonomy of omission mechanisms

- **Status:** survey synthesis
- **Statement:** Structural non-observation, existential projection, logical
  don't-care, and equal-behavior coalescing omit different information and can
  induce different observers. Abstract merging, symmetry quotienting, and
  property-guided pruning are adjacent instances of the same observer-relative
  principle rather than direct implementations of the target enumerator.
- **Scope:** Cross-literature classification of omission mechanisms; a descriptive taxonomy with no algorithmic content of its own.
- **Prior frontier:** Each omission mechanism is separately established in its own literature (projected enumeration, don’t-care minimization, equal-behavior factorization, decision-path sparsity); the four-way distinction and the adjacency classification are this survey’s organization.
- **Evidence:** the evidence ledger connects the four omission mechanisms
  and adjacent observer-relative reductions to their primary-source rows. The
  taxonomy itself is a cross-literature synthesis, not a theorem attributed to
  any one source.

### C02 — Equivalent presentations of selection observation

- **Status:** survey synthesis; formal derivation recorded
- **Statement:** For finite total selective term graphs, enabled-edge
  reachability determines which site outcomes enter the observation. The sparse
  outcome map, its totalized unobserved/outcome vector, concolic exact-fiber
  specialization, and global reachability-and-outcome projection induce the
  same observer fibers. Reachability alone is strictly coarser when distinct
  outcomes expose the same operand nodes.
- **Scope:** Finite, total selective term graphs under the survey's deterministic pure-dataflow model.
- **Prior frontier:** The component constructions are individually established (guarded/multipath symbolic execution, projected AllSMT, demand semantics, decision-path records); the recorded derivation is the cross-literature equivalence on this model
  (E002, low certainty: the fiber correspondence is the survey's synthesis).
- **Presentation rule:** Attribute the component constructions to their
  established literatures; present only the cross-literature equivalence as our
  organizing derivation.

### C03 — Fiber generation equals projected enumeration

- **Status:** survey synthesis; formal derivation recorded
- **Statement:** A concolically generated local guard is the exact input fiber
  of one observation, and it is equivalent to fixing the projected totalized
  outcome coordinates in the global reachability encoding.
- **Scope:** Single observations of the same model; equivalence of the concolic local guard and the projected global encoding, with cost and representation kept separate.
- **Prior frontier:** Phan’s AllSMT model-and-block enumeration and Spallitta’s disjoint projected enumeration establish the enumeration side; the identification of the concolic local guard with the exact fiber of the projected encoding is the recorded derivation.
- **Qualification:** Phan's complete projected tuples index individual finite
  observations after instrumentation. Spallitta's shorter disjoint projected
  cubes are covers and can denote several complete tuples; they are not one
  target fiber per output unless the representation is constrained accordingly.
- **Consequence:** Model-and-full-fiber-block and naive projected AllSMT both
  require \(K\) satisfying models plus a final unsatisfiable query. Solver time
  and representation size remain separate.

### C04 — Dense activation regions are an all-sites-observed special case

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Translating each ReLU regime to a binary selection and
  requesting a dense network's output makes every activation site observed.
  On full-dimensional interiors, feasible activation patterns and their
  polyhedral regions are exactly the resulting observation image and fibers.
- **Scope:** All-sites-observed affine specializations — hyperplane-arrangement cells, dense ReLU activation regions on full-dimensional interiors, and parametric partitions.
- **Prior frontier:** Avis and Fukuda prove output-polynomial reverse-search
  enumeration of every arrangement cell under an arithmetic/LP-operation cost
  model (not a coefficient-bit bound), Sleumer improves the fixed-dimension
  arithmetic bound, Ferrez et al. give a pre-Rada ray-shooting central-arrangement
  algorithm with \(O(K m\,LP(m,D))\) time (writing \(m\) for the hyperplane count) and input-polynomial working space,
  and Rada and Černý give a later complete duplicate-free incremental
  formulation; Deza and Pournin give a self-contained rational-bit analysis of
  zonotope traversal
  with output-sized retention but no stronger generic bound, while their White
  Whale successor exploits structured symmetry; Serra et al. enumerate
  feasible ReLU patterns;
  Geyer et al. compose affine event cells into exact PWA guard/residual pairs;
  Jones and Maciejowski give duplicate-free output-sensitive pLP critical-region
  enumeration with a reconstructible affine optimizer; Jones and Morari, then
  Columbano, Fukuda, and Jones, extend full-dimensional enumeration to pLCPs
  including pLP and convex pQP and give explicit perturbation-safe per-output
  LP-oracle bounds; Spjøtvold, Tøndel, and Johansen give a unique continuous
  minimum-norm pQP selection and algorithm-independent polyhedral
  representation; Geyer et al. 2008
  minimize behavior-equivalent PWA guards under explicit representation and
  solver qualifications;
  Tran's stars and Robinson's explicit PWA conversion emit exact guards with
  affine images before RPM's adjacency walk; Masden and Berzins recover richer
  cell complexes; Wang merges activation cells into maximal equal-affine
  regions; and Drammis et al. analyze parallel layerwise enumeration.
- **Consequence:** A variable sparse domain is also anticipated by ordinary
  decision-tree paths, and exact neural trees/TADS can prune infeasible or
  forced activation tests while preserving the output. Any remaining
  contribution must therefore be stated narrowly in terms of the
  requested-root-relative typed shared-graph observer or a proved
  event-preserving construction/composition result; exact regime enumeration,
  guard-plus-residual output, dynamic sparsity, and extensional
  requested-class quotients are prior art.

### C05 — Selection observations are an observer-equivalence partition

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Totalizing each site with an `unobserved` sentinel makes the
  selection observation a finite-valued function. Its nonempty fibers are the
  exact kernel equivalence classes of that observer.
- **Scope:** Totalized finite-valued observers over the survey model; the partition statement, not any construction.
- **Prior frontier:** The partition statement itself is elementary (the kernel
  of a totalized finite-valued function); what is established elsewhere is its
  exact generic enumeration — IOSTS input-equivalence-class partitioning over
  infinite input domains, SFSM property testing over satisfiable Boolean
  atoms, projected AllSMT over a chosen finite observer vector, and Wang et
  al.'s polynomial-delay enumeration of locally colored equivalence classes
  from acyclic decomposable AND/OR solution graphs.
- **Consequence:** The remaining graph-specific result is the compact local
  form of each fiber and its residual, plus any demonstrable construction
  advantage. The quotient and generic exact enumeration are established.

### C06 — Demand-guided refinement is established independently

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Lindblad represents satisfying sets by partial constructor
  terms and refines a property-blocking metavariable, but explicitly leaves the
  stated soundness and completeness conditions unproved. Lazy SmallCheck
  refines exactly the tagged hole forced by a pure Boolean property and skips
  all total refinements when the answer is known. Korat supplies access-guided
  exhaustive generation for finitized object inputs, while SPLat
  demand-populates configuration decisions and explores feasible partial
  assignments intended to represent distinct reachable test traces.
- **Scope:** Property-directed demand-driven generation over finitized or constructor-shaped inputs.
- **Prior frontier:** BLI, BLISS, LISSA, and PLI provide the imperative heap
  continuation, culminating in exact preservation of bounded jointly feasible
  heap/path symbolic states. The functional-logic lineage separately
  establishes executed-step fingerprints, stable choice-ID propagation, and
  demand-populated task maps.
- **Consequence:** A contribution cannot be “demand sensitivity” alone. It
  would need one exact record per graph observation, exact union guards,
  residual symbolic values, and an analysis beyond the prior partial-state
  search results.

### C07 — Decision paths and compiled observation functions subsume the output shape

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** A deterministic root-to-leaf path is an input-relative partial
  map from encountered tests to outcomes, its branch conjunction is a disjoint
  leaf guard, and its leaf carries a result. Totalizing graph-site
  non-observation turns the target observer into an ordinary finite-range
  function. For finitely encoded inputs it is compilable as an MTBDD or ADD.
- **Scope:** Finitely encoded inputs and compiled representations of totalized observers.
- **Prior frontier:** Bryant proves canonicity of reduced ordered Boolean
  function graphs for a fixed order; Bahar et al. extend the terminal carrier
  to finite algebraic values. Both retain exponential worst cases. Antoy and
  Hanus's fingerprint lineage independently establishes sparse,
  demand-populated partial maps from stable runtime choice identities to
  outcomes, but for nondeterministic evaluation rather than caller-input
  guards.
- **Consequence:** Sparse encountered-test maps, disjoint guards, and shared
  observer compilation are established. Symbolic residual generation is a
  separate obligation. A contribution requires a
  graph-specific construction, composition, or representation theorem beyond
  generic decision structures.

### C08 — Fixed-input least demanded computation is established

- **Status:** survey synthesis; terminology and semantic novelty defeated
- **Statement:** For fixed stream inputs and output-position demands, classical
  dataflow semantics defines or implements a least sufficient computation
  under sequentiality/stability assumptions.
- **Scope:** Fixed stream inputs and output-position demands under the cited sequentiality/stability assumptions.
- **Prior frontier:** Pingali and Arvind give a compositional reverse-demand
  transformation; Avron and Sasson characterize uniform existence of least
  legal demanded valuations by stability; Xia et al. give the mechanized
  bidirectional demand semantics that is the closest modern result (E025).
- **Consequence:** Conditional on a translation proving that the source
  language's semantic least demand matches our declared all-operands policy,
  the remaining quantification is over symbolic inputs: enumerate the range of
  the least computation's selection projection and the exact inverse image of
  each observation. “Demand-sensitive evaluation” is not itself a
  contribution.

### C09 — Requested-output projection does not define the selection observer

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Projecting a rich internal decision history to a requested
  output can merge cases whose unrequested continuation differs. That quotient
  is extensional and distinct from recording the sparse internal selections
  reached while computing the request.
- **Scope:** The relation between requested-output projections and the intensional sparse observation map.
- **Prior frontier:** König and Mönnigmann prove that explicit-MPC regions with
  different later-horizon actions can share the same requested first action.
  Mitze et al. extend common-first-action reuse to nonlinear MPC (E026).
  Kvasnica and coauthors give exact clipping- and separator-based factorizations
  that erase region descriptions while preserving the pointwise controller
  output (E061, low certainty: the cross-domain correspondence is the survey's
  synthesis).
  Chang et al. give a modern exact decision-tree representation of a neural
  controller's extensional policy, reinforcing the distinction between policy
  preservation and event preservation.
- **Consequence:** “Requested-root-relative” alone is not a contribution. The
  survey's object must be an intensional, input-dependent sparse map of
  contextual selection-site outcomes that retains observed equal-valued
  events; it is not the kernel of the requested output function.

### C10 — Parametric-program canonicality and complexity are established

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Full-dimensional pLP/pQP/pLCP partitions already have exact
  degeneracy-safe traversals, explicit output-sensitive LP-oracle bounds, and
  unique optimizer selections under stated assumptions.
- **Scope:** Full-dimensional pLP/pQP/pLCP partitions under each work’s stated matrix-class assumptions (Patrinos and Sarimveis work without nondegeneracy).
- **Prior frontier:** Jones and Morari give the positive-semidefinite pLCP
  precursor; Columbano, Fukuda, and Jones give explicit general-position and
  lexicographically perturbed sufficient-matrix bounds; Spjøtvold, Tøndel, and
  Johansen give a unique continuous minimum-norm selection; Patrinos and
  Sarimveis discover every full-dimensional convex-pQP facet neighbor without
  nondegeneracy; and Jones, Kerrigan, and Maciejowski polynomially interreduce
  pLP solution and polyhedral projection.
- **Consequence:** The survey must claim neither the first canonical partition
  nor the first degeneracy-safe output-sensitive region enumeration. The
  surviving formal package concerns a different object: requested-root enabled
  closure, contextual site identity, preservation of equal-valued observed
  events, typed residuals, and exact observed-outcome fibers over a shared
  pure dataflow graph. Parametric optimizer-basis regions use a different
  observer unless an explicit correspondence is established; closed critical
  regions can overlap on boundaries and full-dimensional traversal can omit
  lower-dimensional-only regions, so a disjoint all-input transfer also needs
  boundary ownership or a restricted caller domain.

### C11 — Exact choice-record reduction is established for concurrent schedules

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Symbolic partial-order methods already retain representative
  schedule-bearing symbolic paths while omitting interleavings that are
  equivalent for a declared reachability or temporal-property observer.
- **Scope:** Concurrent-schedule observers for declared reachability or temporal properties.
- **Prior frontier:** Holzmann, Godefroid, and Pirottin preserve full state
  coverage; Alur et al. preserve local-property verification under a symbolic
  partial-order reduction; SymPaths proves correctness and completeness of a
  schedule-recorded symbolic semantics relative to concrete executions.
- **Consequence:** A partial map of observed choices paired with a symbolic
  residual is not unique to dataflow selection. The surviving distinction is
  the requested-root input-fiber observer over contextual sites, not schedule
  equivalence.

### C12 — Partial event records already induce exact hidden-state sets

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Petri-net observers can characterize exactly the current
  markings consistent with an observed transition-label word.
- **Scope:** Petri-net state estimation under partial event-label observation.
- **Prior frontier:** Giua, Júlvez, and Seatzu give a fixed-structure linear
  representation of the compatible current-marking set. This one strong anchor
  is sufficient for the adjacent inverse-observation boundary; the manuscript
  does not need a mini-survey of its nondeterministic-label, initial-marking,
  and timed extensions.
- **Consequence:** Exact inverse consistency under a partial event observer is
  established. This manuscript's narrower object partitions initial caller
  inputs of a pure function and attaches a typed residual value.

### C13 — Exact quotienting carries no automatic performance advantage

- **Status:** survey synthesis; implementation claim rejected
- **Statement:** A smaller exact semantic quotient can cost more to construct
  than a direct analysis of the unreduced symbolic representation.
- **Scope:** BDD-based bisimulation quotients for symbolic invariant checking, the setting of the single supporting study.
- **Prior frontier:** Fisler and Vardi show theoretically and empirically that
  bisimulation minimization often fails to improve symbolic invariant checking.
- **Consequence:** The formal observer-fiber construction cannot imply a
  practical speedup. Any implementation claim requires measurements against
  projected encodings, decision diagrams, and specialized quotients.

### C14 — Request-relative complete prefixes and count-sensitive observers are established

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Petri-net unfolding can parameterize the semantic information
  preserved by a prefix, retain every minimal configuration reaching one
  requested marking while omitting transitions outside all such
  configurations, and decide multiplicity-sensitive reveals relations over
  bounded equal-conflict maximal runs.
- **Scope:** Petri-net unfolding prefixes and reveals relations over bounded equal-conflict maximal runs.
- **Prior frontier:** Bonet et al. separate user-declared configuration
  equivalence, cutting contexts, and event selection; Chatain and Paulevé prove
  completeness of finite goal-driven prefixes; Bernardinello et al. define
  repeated reveals and excludes; Adobbati et al. supply the bounded
  equal-conflict parametric algorithm and query-relative reduction.
- **Consequence:** Neither request-relative omission nor a finite sparse
  internal-event observer can support a novelty claim by itself. The remaining
  distinction is the exact caller-input inverse-fiber and typed-residual
  packaging for contextual selection sites in a pure shared graph.

### C15 — Observer, mechanism, and representation are separate comparison axes

- **Status:** survey synthesis; organizing terminology
- **Statement:** A solver or traversal discovers nonempty fibers of a declared
  observer, while a flat guard list, tree, decision diagram, compiled circuit,
  or polyhedral complex represents those fibers. Equality of input kernels
  after explicit instrumentation gives the same fibers; matching labeled
  records additionally requires an explicit bijection between feasible images.
  Similar output syntax establishes neither condition.
- **Scope:** The survey's comparison methodology across every surveyed route; terminology, not a priority claim.
- **Prior frontier:** The separation echoes established observer-relative equivalence and knowledge-compilation representation distinctions; its use as a three-way relationship classification for this problem is the survey’s organizing apparatus.
- **Consequence:** The main survey classifies prior work as a direct
  presentation, restricted specialization, adjacent comparator, or open
  correspondence before transferring correctness or complexity results. This is the paper's
  organizing terminology, not a priority claim for observer kernels,
  enumeration algorithms, or the individual representations.
