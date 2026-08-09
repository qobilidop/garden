# Claims and qualification ledger

This file records the survey's current synthesis claims, each with
status `hypothesis`, `supported`, `needs-qualification`,
`known-result`, or `rejected`. No item is novel merely because it is
listed. Each active claim must have explicit scope, anchored
evidence, and a stated relationship to the closest established result.

## Current survey synthesis claims

The `Sxx` identifiers below are stable synthesis-claim IDs. The
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
- **Evidence:** the claim-evidence matrix connects the four omission mechanisms
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
- **Presentation rule:** Attribute the component constructions to their
  established literatures; present only the cross-literature equivalence as our
  organizing derivation.

### C03 — Fiber generation equals projected enumeration

- **Status:** survey synthesis; formal derivation recorded
- **Statement:** A concolically generated local guard is the exact input fiber
  of one observation, and it is equivalent to fixing the projected totalized
  outcome coordinates in the global reachability encoding.
- **Consequence:** Model-and-full-fiber-block and naive projected AllSMT both
  require \(K\) satisfying models plus a final unsatisfiable query. Solver time
  and representation size remain separate.

### C04 — Dense activation regions are an all-sites-observed special case

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Translating each ReLU regime to a binary selection and
  requesting a dense network's output makes every activation site observed.
  On full-dimensional interiors, feasible activation patterns and their
  polyhedral regions are exactly the resulting observation image and fibers.
- **Prior frontier:** Avis and Fukuda prove output-polynomial reverse-search
  enumeration of every arrangement cell, Sleumer improves the fixed-dimension
  arithmetic bound, Ferrez et al. give a pre-Rada ray-shooting central-arrangement
  algorithm with \(O(KQ\,LP(Q,D))\) time and input-polynomial working space,
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
  forced activation tests while preserving the output. Novelty
  can rest only on the requested-root-relative typed shared-graph observer and
  a nontrivial event-preserving construction/composition result, not exact
  regime enumeration, guard-plus-residual output, dynamic sparsity, or an
  extensional requested-class quotient.

### C05 — Selection observations are an observer-equivalence partition

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Totalizing each site with an `unobserved` sentinel makes the
  selection observation a finite-valued function. Its nonempty fibers are the
  exact kernel equivalence classes of that observer.
- **Prior frontier:** IOSTS input-equivalence-class partitioning enumerates and
  minimizes exact behavior-preserving classes over infinite input domains;
  SFSM property testing enumerates satisfiable Boolean atoms of a finite
  guard/output/property alphabet; projected AllSMT enumerates a chosen finite
  observer vector.
- **Consequence:** The remaining graph-specific result is the compact local
  form of each fiber and its residual, plus any demonstrable construction
  advantage. The quotient and generic exact enumeration are established.

### C06 — Demand-guided refinement is established independently

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Lindblad represents satisfying sets by partial constructor
  terms and refines a property-blocking metavariable; Lazy SmallCheck refines
  exactly the tagged hole forced by a pure Boolean property and skips all total
  refinements when the answer is known. Korat supplies access-guided exhaustive
  generation for finitized object inputs.
- **Prior frontier:** BLI, BLISS, LISSA, and PLI provide the imperative heap
  continuation, culminating in exact preservation of bounded jointly feasible
  heap/path symbolic states.
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
- **Prior frontier:** Bryant proves canonicity of reduced ordered Boolean
  function graphs for a fixed order; Bahar et al. extend the terminal carrier
  to finite algebraic values. Both retain exponential worst cases.
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
- **Prior frontier:** Pingali and Arvind give a compositional reverse-demand
  transformation; Avron and Sasson characterize uniform existence of least
  legal demanded valuations by stability.
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
- **Prior frontier:** König and Mönnigmann prove that explicit-MPC regions with
  different later-horizon actions can share the same requested first action.
  Mitze et al. extend common-first-action reuse to nonlinear MPC. Kvasnica and
  coauthors give exact clipping- and separator-based factorizations that erase
  region descriptions while preserving the pointwise controller output. Shin
  and Yang independently identify polyhedral reward sets that induce the same
  optimal MDP policy and study policy invariance and reward-space reduction.
- **Consequence:** “Requested-root-relative” alone is not a contribution. The
  survey's object must be an intensional, input-dependent sparse map of
  contextual selection-site outcomes that retains observed equal-valued
  events; it is not the kernel of the requested output function.

### C10 — Parametric-program canonicality and complexity are established

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Full-dimensional pLP/pQP/pLCP partitions already have exact
  degeneracy-safe traversals, explicit output-sensitive LP-oracle bounds, and
  unique optimizer selections under stated assumptions.
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
  observer unless an explicit correspondence is established.

### C11 — Exact choice-record reduction is established for concurrent schedules

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Symbolic partial-order methods already retain representative
  schedule-bearing symbolic paths while omitting interleavings that are
  equivalent for a declared reachability or temporal-property observer.
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
  markings consistent with an observed transition-label word, compute the set
  of minimum-token initial markings consistent with that word, and incorporate
  time and unobservable events.
- **Prior frontier:** Giua, Júlvez, and Seatzu give a fixed-structure linear
  representation of the compatible current-marking set; Corona et al. make the
  nondeterministic-label case explicit; Li and Hadjicostis compute a complete
  optimization-restricted initial-marking set; and Ghazel, Toguyéni, and Yim
  use a timed class-graph observer with unobservable events.
- **Consequence:** Exact inverse consistency under a partial event observer is
  established. This manuscript's narrower object partitions initial caller
  inputs of a pure function and attaches a typed residual value.

### C13 — Exact quotienting carries no automatic performance advantage

- **Status:** survey synthesis; implementation claim rejected
- **Statement:** A smaller exact semantic quotient can cost more to construct
  than a direct analysis of the unreduced symbolic representation.
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

- **Status:** organizing survey synthesis
- **Statement:** A solver or traversal discovers nonempty fibers of a declared
  observer, while a flat guard list, tree, decision diagram, compiled circuit,
  or polyhedral complex represents those fibers. Equality of input kernels
  after explicit instrumentation gives the same fibers; matching labeled
  records additionally requires an explicit bijection between feasible images.
  Similar output syntax establishes neither condition.
- **Consequence:** The main survey classifies prior work as a direct
  presentation, restricted specialization, or adjacent comparator before
  transferring correctness or complexity results. This is the paper's
  organizing terminology, not a priority claim for observer kernels,
  enumeration algorithms, or the individual representations.
