# Closest-work audit

Status: open

This document will compare only the works that could plausibly subsume the
proposed contribution. Inclusion here is intentionally more selective than the
survey catalog.

## Comparison dimensions

| Work | Program model | Enumerated object | Partiality and inactivity | Exact partition | Residual value | Main guarantee | Complexity | Potential subsumption |
|---|---|---|---|---|---|---|---|---|
| Voogd et al. 2023 | Imperative programs with branching and loops | Feasible terminating traces and semantic pieces | Complete branch traces; divergence leaves a subpartition | Yes, for terminating inputs | Symbolic substitution / piece behavior | Concrete correspondence and trace-piece bijection | Not the focus | Subsumes generic partition, guard, residual, soundness, and completeness claims. |
| Sen et al. 2015 (MultiSE) | Imperative low-level language with computed jumps | Guarded symbolic expressions in value summaries | Merges path guards, optionally coalescing equal values | Guards for each variable are disjoint and exhaustive | Yes | Concrete soundness; logical equivalence to DSE absent approximations | Empirical sharing and speedup | Very close: already provides disjoint exhaustive guarded residual values. |
| Spallitta et al. 2024/2025 | SAT and SMT formulas with projected variables | Disjoint partial satisfying assignments / implicants | Unassigned variables are don't-cares; 2025 work adds projection and SMT | Yes, over satisfying assignments | No program residual | Complete nonrepeating enumeration | Output may be exponentially smaller than total models; solver algorithms studied | A selector-observation encoding may reduce our configurations and witnesses to projected AllSMT. |
| Feng et al. 2004 | Combinational circuits represented by OBDDs | Control-space cases paired with datapath functions | Selected muxes split control space; unsplit muxes remain merged | Tuple-list controls are mutually exclusive and cover the functional space | Yes, per-control data function | Construction agrees with ordinary symbolic simulation | Heuristics trade tuple count against OBDD size; empirical | Extremely close representation, but partitions are heuristic and do not preserve every demanded mux outcome. |
| Narayan et al. 1996 | Boolean functions | Window functions paired with per-window ROBDDs | Windows may overlap; orthogonal form is disjoint | Cover required; orthogonal variant is a partition | Yes, restricted Boolean function | Canonicity for fixed windows/orders and efficient operations | Exponential compactness separations | Subsumes broad input-space partition and compactness claims, not selection-induced windows. |
| Mauborgne and Rival 2005 | Transition systems and abstract traces | Trace partitions indexed by control/value history tokens | Partitions can be created and later merged | Concrete partitions; abstract values may overapproximate | Abstract state per token | Sound trace-discriminating abstraction and refinement ordering | Each retained branch can multiply cost | Occupies “trace partitioning”; distinguishes choices only while useful, but seeks abstraction rather than exact witnessed fibers. |
| Antoy 2011 | Rooted term graphs for functional-logic programs | Consistent resolutions of shared nondeterministic choices | Evaluation delays needed choices; equal identifiers must resolve alike | Represented set contains every consistent resolution | Result term graph / constructor value | Pull-tab and non-choice steps preserve represented results, independent of strategy | Avoids eager context cloning; no output-sensitive bound | Subsumes generic term-graph choice completeness, sharing, and evaluation-order invariance, but not deterministic input guards or structural observation fibers. |
| Phan 2015 and Spallitta et al. 2025 | SMT formulas with designated important/relevant variables | Total or disjoint partial projected assignments, plus selected theory-variable values | Nonimportant variables are existentially projected; partial relevant assignments denote don't-cares | Yes, over the projected solution space | Values for designated non-Boolean variables, not program residuals | Complete projected model enumeration; 2025 algorithm avoids blocking clauses | Output can be exponentially smaller than total models; empirical solver results | Strongest direct reduction: encode every site outcome, including inactivity, as a projected theory predicate and enumerate observations. |
| Michelutti et al. 2024 | SMT formulas over a fixed atom set | Theory-aware OBDD or SDD | Theory-inconsistent assignments are excluded by learned theory lemmas | Decision-diagram semantics cover all theory-consistent assignments | Diagram terminals / Boolean abstraction | Theory canonicity when the Boolean DD is canonical and the atom/canonicity conditions are fixed | Up-front AllSMT is identified as a bottleneck | Defeats any broad “canonical modulo theories” claim; our object can at most be unique relative to a fixed graph and observation policy. |
| Mokhov et al. 2019 | Pure descriptions of effectful computations | Statically visible effects with dynamically selected execution | `select` may skip a statically present computation; `Over` and `Under` provide static approximations | Not an input-space enumerator | Effectful result interpreted in any selective functor | Algebraic laws, free selective construction, and interpretation by natural transformation | Static analyses and industrial case studies; no trace enumeration bound | Strongly subsumes generic compositionality and reusable interpretation for conditional static graphs. Exact per-input selection logging is an instance, not a new abstraction by itself. |

| Kanade et al. 2009 | Simulink/Stateflow dataflow and hybrid-state models | Length-bounded sequences of discrete modes and conditional-block choices | Concrete run selects conditions; state regions are underapproximated | No; computes an underapproximation of a sampled equivalence class | Per-step symbolic transformer | Every state in the returned convex hull follows the sampled discrete trace | Bounded vertex representation uses polynomially many LPs of bounded dimension | Very close trace equivalence retaining conditional outcomes, but global rather than sparse/output-demanded and not an exact exhaustive cover. |
| Ryan and Sturton 2023 (Sylvia) | RTL Verilog split into sequential blocks | CFG path fragments and feasible full-path combinations | Cone-of-influence removes whole irrelevant blocks; active branch paths remain total within explored blocks | Feasible combinations are solver-checked | Partial symbolic stores | Realizable combinations are replayable | Fragment exploration is \(O(cbN2^b)\), but full combination still makes \(O(2^{bN})\) solver queries | Occupies modular path composition and witnesses, but still cross-products fragments and does not quotient by sparse output-observed sites. |
| Palmer et al. 2020 | Higher-order call-by-value functional language | Reverse lookup proofs, constraints, and contextual call paths to a target clause | Goal-directed lookup skips definitions irrelevant to one target | No exhaustive partition | Contextual symbolic variables and input model | Sound and complete test generation relative to concrete reverse lookup | General search recursively enumerable, not decidable | Strong context-identity and demand precedent; its target reachability problem differs from exact finite output-observation fibers. |

## Required adversarial conclusion

Before theory drafting begins, this document must state the strongest known
encoding of our proposed problem into each closest framework and identify which
claimed result, if any, is not inherited from prior work.

## Preliminary adversarial conclusion

The following broad claim is already known and must not be presented as novel:

> Symbolically evaluate a finite program and represent its behavior by disjoint,
> exhaustive guards paired with residual symbolic values.

The open question is whether the *observation policy* is new and useful: for a
fixed pure term graph, observe exactly the outcomes of result-demanded choice
sites, including active equal-valued choices, while leaving choices in inactive
cones absent. A projected-AllSMT encoding with one explicit inactive value per
site is an immediate potential reduction. Pull-tabbing separately supplies
term-graph sharing, consistent choices, completeness, and evaluation-order
invariance. Unless a structure-directed algorithm, representation theorem, or
complexity result establishes something not inherited from those encodings,
the original-paper route is not justified.
