# Claims and qualification ledger

This file records the survey's current synthesis claims and the negative
constraints inherited from the original-paper audit. No item is novel merely
because it is listed. Each active claim must have explicit scope, anchored
evidence, and a stated relationship to the closest established result.

## Retired original-paper hypotheses

These rejected or reduced hypotheses remain as guardrails against reintroducing
claims that the survey has already shown to be known.

## H01 — Inputs induce unique selection observations

- **Status:** known / not a contribution
- **Provisional statement:** For a fixed finite rooted graph of deterministic,
  total, pure operators with finite choice operators, each concrete input
  induces a unique partial mapping whose domain is exactly the selection sites
  observed for the requested roots and whose values are the selected outcomes.
- **Potentially known as:** path, partial path, trace, choice assignment,
  configuration, projected model, cube, or guarded case.
- **Closest existing result:** The exact statement is the fiber partition of a
  deterministic observation function. Voogd et al. already prove a
  trace-to-piece correspondence for symbolic execution; projected AllSMT
  enumerates selected observations after activation/outcome instrumentation.
- **Assessment:** Useful as a definition and supporting lemma, but elementary
  once the observation function is total. It must not be sold as novelty.

## H02 — Exact symbolic enumeration of configurations

- **Status:** computationally reduced to prior work
- **Provisional statement:** A demand-driven symbolic evaluator can enumerate
  every feasible input-induced configuration with an exact guard and a residual
  symbolic output while omitting sites confined to unobserved alternatives.
- **Closest existing result:** Phan's AllSMT enumerates important predicates;
  Spallitta et al. enumerate disjoint projected partial SAT/SMT models; MultiSE
  supplies guarded residual symbolic values. Braßel and Huch's branching
  information, the Braßel--Fischer translation, and Braßel's dissertation
  already supply stable choice IDs and demand-extended partial decision maps
  for lazy functional-logic search. Lazy SmallCheck already refines the one
  partial-input hole demanded by a Boolean observer. Krafczyk and Peleska
  enumerate exact and then coarsest input-equivalence partitions, while Huang
  et al. enumerate all satisfiable atoms of a finite observer alphabet. A
  decision tree already represents each input by its encountered test/outcome
  path with a disjoint leaf guard and result, and, for finitely encoded inputs,
  ADD compilation represents the complete observation function. Neural-specific
  instances are also direct prior work: Chang et al., Logemann--Veith, and
  Affinitree omit infeasible or forced activation tests while retaining exact
  output semantics; BDD4BNN compiles hidden BNN activations away into exact
  requested-region class diagrams; and Bertossi--Leon compile a BNN output
  through SDD into a deterministic decomposable circuit for exact SHAP queries. A symbolic
  residual per observation still requires partial evaluation or a richer
  residual-labeled decision structure.
- **Reduction:** Introduce one finite-domain variable per contextual selection
  occurrence with values `unobserved` or an outcome. Constrain it by a
  backward-reachability encoding and ordinary graph equations, then project onto
  those variables. The construction is linear in the supplied exact value,
  classifier, outcome, and direct case-membership encoding, which need not be
  polynomial in a more succinct source representation.
- **Assessment:** An original algorithm must demonstrate a compositional or
  structural property not inherited from this explicitly charged
  instrumentation.

## H03 — Selection observation avoids irrelevant Cartesian products

- **Status:** supporting result; novelty rejected
- **Provisional statement:** Relative to total assignments over all syntactic
  selection sites, exact observation enumeration can be exponentially smaller;
  when all choices are demanded, exponential output remains unavoidable.
- **Closest existing result:** Partial-model enumeration, decision diagrams,
  guarded value summaries, and mux-guided functional-space partitioning all
  exploit omitted or shared decisions to avoid total Cartesian products.
- **Assessment:** A graph-specific exponential separation can illustrate the
  observation policy, but the broad compactness phenomenon is established.

## H04 — Selection observation is a compositional intensional semantics

- **Status:** expressible by established machinery; rejected as original
- **Provisional statement:** For a fixed finite typed pure term graph and an
  explicit selection-observing interface, the map containing exactly the
  observed selection-site outcomes is the least compositional refinement
  of ordinary value semantics that preserves those structural events.
- **Required results:** define the observer language; prove adequacy or full
  abstraction relative to it; state the refinement order; prove the universal
  property and congruence under graph substitution.
- **Key risks:** Event/configuration structures may already supply the semantic
  object. Merely declaring hidden events observable makes the theorem
  tautological. Ordinary XLS value contexts cannot distinguish equal-valued
  alternatives.
- **Resolution:** Translate strict nodes applicatively and selections through a
  free selective computation. Interpret it in a reader of input combined with
  the idempotent writer monoid of finite site/outcome event sets; prove
  functional consistency before decoding the set to a partial map. Mokhov et
  al. already supply the
  free syntax and universal interpreter. The coarsest-partition statement is a
  kernel factorization relative to an explicit observer.

## H05 — Contextual summaries compose exactly under sharing and calls

- **Status:** supporting synthesis; rejected as original
- **Provisional statement:** A summary computed once for a subgraph can be
  instantiated at contextual call occurrences and composed with a caller to
  yield exactly the same observation guards and residual values as whole-graph
  evaluation, without flattening the graph.
- **Required results:** formal occurrence naming, graph substitution, shared
  demand, invocation, and finite iteration; equality with flattened semantics;
  a complexity or reuse advantage over activation-variable projected AllSMT.
- **Key risk:** Naive tree neededness does not lift to shared term graphs, and a
  summary that exposes all internal outcomes may simply be ordinary relational
  encoding.
- **Resolution:** Output-demand-parametric summaries do compose exactly by
  propagating the caller's boundary-demand mask and unioning namespaced event
  maps. This is selective/relational composition. Geyer et al. 2010 already
  instantiate the guard conjunction and residual-substitution core for
  topologically composed affine hybrid components, including infeasibility
  pruning. The graph-specific theorem is equality with flattening under
  requested-root demand and contextual site identity; it has no general
  compactness or output-delay advantage over flat activation instrumentation.

## H06 — Full-observation blocking takes one satisfiable query per result

- **Status:** derived baseline; not currently novel
- **Provisional statement:** Repeatedly obtain one input model, replay it to
  compute its full selection observation `tau`, derive the exact fiber formula
  `Gamma_tau`, and block that formula. For `K` feasible observations, the
  procedure makes `K` satisfiable solver queries and one final unsatisfiable
  query.
- **Assessment:** Exact fibers imply no duplicates and coverage. Under a
  unit-cost model-producing oracle, the invocation count is linear in `K`; this
  is not an OutputP, IncP, polynomial-delay, or wall-clock bound. The
  construction is extensionally equivalent to naive projected AllSMT over
  complete activation/outcome tuples. Formula size, serialized output,
  incremental solving cost, and compiled enumeration remain separate.

## Current survey synthesis claims

### S01 — Taxonomy of omission mechanisms

- **Status:** survey synthesis
- **Statement:** Structural non-observation, existential projection, logical
  don't-care, and equal-behavior coalescing omit different information and can
  induce different observers. Abstract merging, symmetry quotienting, and
  property-guided pruning are adjacent instances of the same observer-relative
  principle rather than direct implementations of the target enumerator.
- **Evidence required:** a focused extraction and claim-evidence matrix covering
  the primary sources used for each main solution family and adjacent boundary.

### S02 — Three equivalent presentations of selection observation

- **Status:** survey synthesis; formal derivation recorded
- **Statement:** For finite total selective term graphs, the same graph-relative
  observation is characterized by enabled-edge reachability, generated locally
  by concolic exact-fiber specialization, and encoded globally by total
  unobserved-or-outcome activation coordinates.
- **Presentation rule:** Attribute the component constructions to their
  established literatures; present only the cross-literature equivalence as our
  organizing derivation.

### S03 — Fiber generation equals projected enumeration

- **Status:** survey synthesis; formal derivation recorded
- **Statement:** A concolically generated local guard is the exact input fiber
  of one observation, and it is equivalent to fixing the projected activation
  variables in the global encoding.
- **Consequence:** Model-and-full-fiber-block and naive projected AllSMT both
  require \(K\) satisfying models plus a final unsatisfiable query. Solver time
  and representation size remain separate.

### S04 — Dense activation regions are an all-sites-observed special case

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
  formulation; Deza and Pournin add a rational-bit-model zonotope traversal
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
  forced activation tests while preserving the output. Exact BNN-to-BDD/SDD or
  d-DNNF compilation can eliminate hidden activations entirely. Novelty
  can rest only on the requested-root-relative typed shared-graph observer and
  a nontrivial event-preserving construction/composition result, not exact
  regime enumeration, guard-plus-residual output, dynamic sparsity, or an
  extensional requested-class quotient.

### S05 — Selection observations are an observer-equivalence partition

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

### S06 — Demand-guided refinement is established independently

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

### S07 — Decision paths and compiled observation functions subsume the output shape

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** A deterministic root-to-leaf path is an input-relative partial
  map from encountered tests to outcomes, its branch conjunction is a disjoint
  leaf guard, and its leaf carries a result. Totalizing graph-site
  non-observation turns the proposed observer into an ordinary finite-range
  function. For finitely encoded inputs it is compilable as an MTBDD or ADD.
- **Prior frontier:** Bryant proves canonicity of reduced ordered Boolean
  function graphs for a fixed order; Bahar et al. extend the terminal carrier
  to finite algebraic values. Both retain exponential worst cases.
- **Consequence:** Sparse encountered-test maps, disjoint guards, and shared
  observer compilation are established. Symbolic residual generation is a
  separate obligation. A contribution requires a
  graph-specific construction, composition, or representation theorem beyond
  generic decision structures.

### S08 — Fixed-input least demanded computation is established

- **Status:** survey synthesis; terminology and semantic novelty defeated
- **Statement:** For fixed stream inputs and output-position demands, classical
  dataflow semantics defines or implements a least sufficient computation
  under sequentiality/stability assumptions.
- **Prior frontier:** Pingali and Arvind give a compositional reverse-demand
  transformation; Avron and Sasson characterize uniform existence of least
  legal demanded valuations by stability; Part 2 and Vin et al. develop global
  and operational demand propagation.
- **Consequence:** Conditional on a translation proving that the source
  language's semantic least demand matches our declared strict edge policy,
  the remaining quantification is over symbolic inputs: enumerate the range of
  the least computation's selection projection and the exact inverse image of
  each observation. “Demand-sensitive evaluation” is not itself a
  contribution.

### S09 — Requested-output projection does not define the selection observer

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

### S10 — Parametric-program canonicality and complexity are established

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
  events, typed residuals, and exact positive inverse fibers over a shared
  pure dataflow graph.

### S11 — Exact choice-record reduction is established for concurrent schedules

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Symbolic partial-order methods already retain representative
  schedule-bearing symbolic paths while omitting interleavings that are
  equivalent for a declared reachability or temporal-property observer.
- **Prior frontier:** Holzmann, Godefroid, and Pirottin preserve full state
  coverage; later SAT/SMT and BDD methods give property-preservation or
  optimality results; SymPaths proves correctness and completeness of a
  schedule-recorded symbolic semantics relative to concrete executions.
- **Consequence:** A partial map of observed choices paired with a symbolic
  residual is not unique to dataflow selection. The surviving distinction is
  the requested-root input-fiber observer over contextual sites, not schedule
  equivalence.

### S12 — Partial event records already induce exact hidden-state sets

- **Status:** survey synthesis; broad novelty defeated
- **Statement:** Petri-net observers can characterize exactly the current
  markings consistent with an observed transition-label word, compute the set
  of minimum-token initial markings consistent with that word, and incorporate
  time or unobservable-transition reductions.
- **Prior frontier:** Giua, Júlvez, and Seatzu give a fixed-structure linear
  representation of the compatible current-marking set; Corona et al. make the
  nondeterministic-label case explicit; Li and Hadjicostis compute a complete
  optimization-restricted initial-marking set; Ghazel, Toguyéni, and Yim use a
  timed class-graph observer; hierarchical basis graphs extend marking
  estimation under unobservable transitions at the primary-abstract level.
- **Consequence:** Exact inverse consistency under a partial event observer is
  established. This manuscript's narrower object partitions initial caller
  inputs of a pure function and attaches a typed residual value.

### S13 — Exact quotienting carries no automatic performance advantage

- **Status:** survey synthesis; implementation claim rejected
- **Statement:** A smaller exact semantic quotient can cost more to construct
  than a direct analysis of the unreduced symbolic representation.
- **Prior frontier:** Fisler and Vardi show theoretically and empirically that
  bisimulation minimization often fails to improve symbolic invariant checking;
  later work improves symbolic refinement and quotient construction without
  removing the workload dependence.
- **Consequence:** The formal observer-fiber construction cannot imply a
  practical speedup. Any implementation claim requires measurements against
  projected encodings, decision diagrams, and specialized quotients.

### S14 — Request-relative complete prefixes and count-sensitive observers are established

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

### S15 — Observer, mechanism, and representation are separate comparison axes

- **Status:** organizing survey synthesis
- **Statement:** A solver or traversal discovers nonempty fibers of a declared
  observer, while a flat guard list, tree, decision diagram, compiled circuit,
  or polyhedral complex represents those fibers. Observer equivalence requires
  equality of input kernels after explicit instrumentation; similar output
  syntax does not establish that equality.
- **Consequence:** The main survey classifies prior work as a direct
  presentation, strict specialization, or adjacent comparator before
  transferring correctness or complexity results. This is the paper's
  organizing terminology, not a priority claim for observer kernels,
  enumeration algorithms, or the individual representations.
