# Exhaustive Enumeration of Selection Observations in Pure Dataflow Graphs: A Survey and Unified Framework

A problem-centered survey with a formal synthesis: enumerate every
distinct selection observation of a finite pure dataflow graph —
exact guards, residual values, one witness input per fiber — and
compare the literatures that can solve, compile, or specialize the
task (guarded symbolic execution, projected model enumeration,
decision structures, demand-guided search, region traversal,
compositional summaries). 920 works cataloged, 118 deep-read,
distilled into a unified terminology and framework. An updatable
systematic map: the baseline closed 2026-08-04 under bounded mapping
closure; updated and reconciled 2026-08-09; updates are staged on
demand.

**Read:** [manuscript (HTML)](manuscript.html) ·
[manuscript (PDF)](manuscript.pdf)

**Survey record:**
[method, catalog, evidence notes, syntheses](https://github.com/qobilidop/sys0/tree/main/surveys/dataflow-selection-enumeration/record)
— searched through 2026-08-09.

**Topic context:** [[survey-methodology]]

## Reading list

The works that anchor the comparison, curated from the deep-read set and
organized by the survey's six routes, with the foundations that fix the
formal object and the adjacent comparators that bound it. Entries link
the original paper (DOI where one exists) and our notes on it (library
pages where ingested, our evidence notes in the record otherwise).

### Problem and foundations

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Efficient Demand-Driven Evaluation. Part 1](https://doi.org/10.1145/3318.3480) | Local, structure-directed reverse demand for stream dataflow graphs, proved correct and parsimonious compositionally | TOPLAS · 1985 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/pingali1985efficient.md) |
| [Stability, Sequentiality and Demand Driven Evaluation in Dataflow](https://doi.org/10.1007/BF03259389) | Defines the least demanded computation for fixed inputs and requested output positions — the fixed-input core of enabled closure, under stability assumptions | Formal Aspects of Computing · 1994 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/avron1994stability.md) |
| [A Complexity Theory for Hard Enumeration Problems](https://doi.org/10.1016/j.dam.2019.02.025) | Fixes what delay, incremental, and output-polynomial mean — the standard that reclassifies "one solver call per solution" as an oracle-call count | Discrete Appl Math · 2019 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/creignou2019enumeration.md) |
| [Story of Your Lazy Function's Life: A Bidirectional Demand Semantics](https://doi.org/10.1145/3674626) | Mechanized backward propagation of an output request to a minimal sufficient partial input — demand as definedness, not an internal selection trace | ICFP · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/xia2024demand.md) |

### Guarded symbolic execution

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [All-Values Symbolic Execution](https://doi.org/10.1109/iwast.2012.6228982) | Reindexes exploration by the distinct symbolic values reaching a statement rather than by path; author-run experiments report large savings, but equal-valued alternatives lose their selection identity | AST · 2012 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/denaro2012allvalues.md) |
| [MultiSE: Multi-Path Symbolic Execution Using Value Summaries](https://doi.org/10.1145/2786805.2786830) | Value summaries already represent many executions as disjoint, collectively exhaustive guard/expression pairs | ESEC/FSE · 2015 | [[sen2015-multise]] |
| [A Formal Foundation for Symbolic Evaluation with Merging](https://doi.org/10.1145/3498709) | Mechanized evaluator whose guarded choices exactly represent the reachable concrete outcomes | POPL · 2022 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/porncharoenwase2022merging.md) |
| [Grisette: Symbolic Compilation as a Functional Programming Library](https://doi.org/10.1145/3571209) | Normalized union merging supplies the representation half of a guarded-residual enumerator, without defining enabled-edge activity or fiber leaves | POPL · 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/lu2023grisette.md) |
| [Compositional Symbolic Execution Semantics](https://doi.org/10.1016/j.tcs.2025.115263) | Exact mechanized denotation of symbolic execution as substitution/path-condition pairs with generic composition equations | Theor Comput Sci · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/voogd2025compositional.md) |

### Projected model enumeration

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [All-Solution Satisfiability Modulo Theories](https://doi.org/10.1109/ares.2015.14) | AllSMT over designated Boolean coordinates with sampled theory values — the solver-level reduction any enumeration claim is measured against | ARES · 2015 | [[phan2015-all-solution-satisfiability-modulo-theories]] |
| [Disjoint Partial Enumeration without Blocking Clauses](https://doi.org/10.1609/aaai.v38i8.28652) | Mutually exclusive partial models via chronological backtracking and implicant shrinking; unassigned variables are logical don't-cares, not structurally unobserved sites | AAAI · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/spallitta2024disjoint.md) |
| [Leveraging Decision-DNNF Compilation for Enumerating Disjoint Partial Models](https://doi.org/10.24963/kr.2024/48) | Disjoint covering partial models with polynomial post-compilation delay; a faithful reduction still needs an explicit activity variable | KR · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/lagniez2024decisiondnnf.md) |
| [Disjoint Projected Enumeration for SAT and SMT without Blocking Clauses](https://doi.org/10.1016/j.artint.2025.104346) | The strongest direct solver baseline: projected AllSAT/AllSMT that subsumes the target task after polynomial activity/outcome instrumentation | Artif Intell · 2025 | [[spallitta2024-disjoint-projected-enumeration-for-sat-and-smt-without-blocking-clauses]] |

### Compiled decision structures

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Graph-Based Algorithms for Boolean Function Manipulation](https://doi.org/10.1109/tc.1986.1676819) | Reduced ordered BDDs: the canonical baseline for compiling an observation function by root-to-terminal traversal and extensional reduction | IEEE Trans Comput · 1986 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/bryant1986bdd.md) |
| [Algebraic Decision Diagrams and Their Applications](https://doi.org/10.1023/a:1008699807402) | Terminals beyond Booleans — exact for selection fibers only when the terminal carrier is the complete observation rather than the program output | Formal Methods Syst Des · 1997 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/bahar1997add.md) |
| [Effective Infinite-State Model Checking by Input Equivalence Class Partitioning](https://doi.org/10.1007/978-3-319-67549-7_3) | Builds the coarsest input-equivalence-class partition of an infinite domain by enumerating satisfiable transition-condition combinations | ICTSS · 2017 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/krafczyk2017effective.md) |
| [Affinitree: Formal Analysis and Explanation of Deep Neural Networks](https://doi.org/10.1007/978-3-031-72044-4_8) | Compiles piecewise-linear networks into exact affine guard/residual decision structures, LP-pruning infeasible and entailed tests with a preservation proof | TAP · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/affinitree2024.md) |
| [Exhaustive Property Oriented Model-Based Testing with Symbolic Finite State Machines](https://doi.org/10.1016/j.scico.2023.103005) | Exact finite equivalence partition of infinite input/output domains via SMT-enumerated atoms over a declared observation alphabet | Sci Comput Program · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/huang2024exhaustive.md) |

### Demand-guided evaluation and search

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [SmallCheck and Lazy SmallCheck: Automatic Exhaustive Testing for Small Values](https://doi.org/10.1145/1411286.1411292) | Refines only the input a Boolean observation demands and prunes all completions once the answer is known — refutation, not fiber enumeration | Haskell · 2008 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/runciman2008smallcheck.md) |
| [On the Correctness of Pull-Tabbing](https://doi.org/10.1017/s1471068411000263) | Shared choice identifiers in term-graph rewriting already yield sound, evaluation-order-independent exhaustive enumeration of consistent results | Theory Pract Log Program · 2011 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/antoy2011pull.md) |
| [Implementing Functional Logic Programs by Translation into Purely Functional Programs](https://d-nb.info/1020245336/34) | Choice-ID translation with a proved value-set equality; its finite partial map from choice identifiers to outcomes is the closest precedent for a sparse selection record | PhD thesis, Kiel · 2011 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/brassel2011thesis.md) |
| [Implementing a Functional Logic Programming Language via the Fair Scheme](https://doi.org/10.15760/etd.3564) | The Fair Scheme's fullest formalization: sound, complete, optimal narrowing over demand-populated fingerprints | PhD dissertation, Portland State · 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/jost2023fairscheme.md) |

### Geometric and parametric enumeration

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Reverse Search for Enumeration](https://doi.org/10.1016/0166-218X%2895%2900026-N) | General memory-efficient output-polynomial enumeration, already instantiated for exact duplicate-free arrangement cells | Discrete Appl Math · 1996 | [[avis1996-reverse-search-for-enumeration]] |
| [Reverse Search for Parametric Linear Programming](https://doi.org/10.1109/cdc.2006.377799) | Duplicate-free, output-sensitive traversal of every full-dimensional critical region, each basis giving a polyhedral guard plus an affine optimizer | CDC · 2006 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/jones2006parametric.md) |
| [Optimal Complexity Reduction of Polyhedral Piecewise Affine Systems](https://doi.org/10.1016/j.automatica.2007.11.027) | Merges cells carrying equal behavior into a smaller exact representation — the precise counterpoint to an observer that keeps distinct outcomes with equal residuals | Automatica · 2008 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/geyer2008optimal.md) |
| [An Output-Sensitive Algorithm for Multi-Parametric LCPs with Sufficient Matrices](https://doi.org/10.1090/crmp/048/04) | Generic traversal covering parametric LP and convex parametric QP, with explicit per-output LP-oracle work — the strongest closed output-sensitive bound in that lineage | Polyhedral Computation · 2009 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/columbano2009sufficient.md) |
| [Reachable Polyhedral Marching](https://doi.org/10.1109/icra48506.2021.9561956) | Enumerates every feasible ReLU activation pattern with its exact input polyhedron and affine output map by adjacency-based work-list traversal | ICRA · 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/vincent2021reachable.md) |
| [A New Algorithm for Enumeration of Cells of Hyperplane Arrangements](https://doi.org/10.1137/15m1027930) | Proof-bearing incremental sign-prefix enumeration — exact, duplicate-free, output-polynomial, but always assigning a side to every hyperplane | SIAM J Discrete Math · 2018 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/rada2018new.md) |

### Compositional guarded summaries

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Compositional Dynamic Test Generation](https://doi.org/10.1145/1190215.1190226) | SMART's reusable per-function pre/postcondition summaries — avoiding interprocedural path products is established prior art | POPL · 2007 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/godefroid2007compositional.md) |
| [Demand-Driven Compositional Symbolic Execution](https://doi.org/10.1007/978-3-540-78800-3_28) | Exact partial summaries expanded toward one target location — demand-driven composition without enumerating all observations | TACAS · 2008 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/anand2008demand.md) |
| [Efficient Mode Enumeration of Compositional Hybrid Systems](https://doi.org/10.1080/00207170903159285) | Substitutes upstream affine residuals into downstream guards with infeasibility pruning — guarded residual composition in the affine case, with no requested-root demand | Int J Control · 2010 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/geyer2010mode.md) |
| [Selective Applicative Functors](https://doi.org/10.1145/3341694) | Laws, a free construction, and reusable interpreters for a static computation graph whose effects are selected dynamically | ICFP · 2019 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/mokhov2019selective.md) |

### Adjacent comparators

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Marking Estimation of Petri Nets Based on Partial Observation](https://doi.org/10.1109/acc.2003.1238961) | Exact inverse-consistency set for an observed label word via a fixed-structure linear system — hidden states, not caller-input fibers with residuals | ACC · 2003 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/giua2003marking.md) |
| [Goal-Driven Unfolding of Petri Nets](https://doi.org/10.4230/lipics.concur.2017.18) | Skips transitions outside every minimal goal-reaching configuration while preserving all minimal configurations | CONCUR · 2017 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/chatain2017goaldriven.md) |
| [Optimal Dynamic Partial Order Reduction with Observers](https://doi.org/10.1007/978-3-319-89963-3_14) | Explores exactly one representative per observation-equivalence class of schedules — observer-relative omission over interleavings, not inputs | TACAS · 2018 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/aronis2018observers.md) |
