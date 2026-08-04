# Current positioning and route gate

## Negative result from the survey

The original broad thesis is not viable as a novelty claim. The literature
already supplies:

- exact semantic partitions for symbolic execution;
- disjoint guarded residual values;
- term-graph choice completeness with sharing;
- projected enumeration of selected theory observations;
- sparse disjoint partial models and deterministic decision diagrams; and
- hardware-oriented functional-space partitioning guided by mux structure;
- demand-driven omission of unused nondeterministic search space;
- sparse fingerprints mapping stable choice identities to outcomes;
- shared suspensions that postpone bounded nondeterministic values until
  non-copy use, with exact visible-state preservation and exponential path
  reduction when choices remain unforced;
- fair work-queue exploration combining needed graph reduction with sparse
  choice fingerprints and value-set preservation;
- value-set-adequate lazy choice-tree translations whose concrete searches
  demand-extend finite choice-ID maps;
- a compositional free abstraction for static computations with dynamically
  selected effects;
- exact and demand-driven reusable function summaries; and
- normalized ordered-guard representations for merged symbolic values;
- pseudo-exhaustive circuit tests that cover every assignment to each local
  output cone while reusing complete global test vectors across cones;
- complete duplicate-free OutputP enumeration of full-dimensional affine
  hyperplane cells; and
- exact dense ReLU activation-pattern enumeration, including methods that emit
  an exact polyhedral guard and affine residual, reconstruct the full cell
  complex, or parallelize layerwise enumeration;
- Lindblad's and Lazy SmallCheck's refinement of exactly the partial-input
  unknown demanded by a Boolean property, with partial constructor terms that
  denote bounded completion sets and pruning once the answer is known;
- bounded lazy heap initialization with solver-aided preservation theorems for
  every feasible partial state; and
- exact input-equivalence-class enumeration over infinite domains, including
  satisfiable Boolean-atom construction and minimization to coarsest finite
  observer partitions;
- ordinary decision trees whose input-relative root-to-leaf paths already pair
  encountered tests with a disjoint guard and leaf result, plus reduced
  BDD/ADD sharing and canonicalization for fixed orders; and
- least demanded computations for fixed stream-dataflow inputs and output
  demands, including compositional reverse-demand transformations and a
  stability characterization.

These ingredients combine through a straightforward observation/outcome
instrumentation of a finite pure graph.

## Exact packaging gap

Among the current deep-read set, no single work packages a compositional,
graph-intensional semantics of deterministic selection observations that
simultaneously:

- retains equal-valued outcomes of observed selection sites;
- omits unobserved selection sites;
- respects DAG sharing and contextual occurrences;
- returns exact input guards and residual values; and
- supports reusable subgraph summaries equal to whole-graph evaluation.

The absence of an exact packaging match is not evidence of novelty. Plain
compositionality is already supplied by selective functors, and exact
enumeration is supplied by projected AllSMT after activation instrumentation.
The packaging gap is useful as a running example for a survey taxonomy, not as
an original-paper claim.

Two distinctions remain worth formalizing. Delayed-choice execution branches
on every concrete value at a non-copy use, whereas a selection observation
groups values by the selected outcome and retains ordinary symbolic residuals.
Fair-Scheme fingerprints use dynamic computation-local choice identities,
whereas reusable graph summaries require static context-qualified occurrence
identities. Neither distinction by itself establishes an original enumeration
paradigm; both delimit the correspondence theorem the synthesis must prove.

Pseudo-exhaustive testing adds a third boundary. It establishes static
support-local exhaustiveness, including cone-containment reduction and
test-length analysis, but its output cone contains both arms of a mux and its
artifact is a concrete covering test set. Selection observations instead use
input-relative selected-edge reachability and return exact fibers with
residuals. The survey must claim neither that local exhaustive circuit testing
is new nor that PET already enumerates the same semantic object.

Exact neural-region enumeration adds a fourth boundary. When every activation
unit is represented as a selection and the network output is requested, every
site is observed and a dense activation cell is exactly one observation fiber.
Classical arrangement algorithms precede Rada and Černý's feasibility-pruned
OutputP recurrence; Serra et al. exactly enumerate feasible ReLU patterns;
Tran's star sets and Robinson's explicit piecewise-affine conversion already
retain exact guards with affine images; RPM adds adjacency-oriented traversal;
and later work extracts richer face complexes, handles broader CPWL
architectures, or parallelizes layerwise enumeration. Wang further shows why
activation cells must be distinguished from maximal connected affine regions.

The surviving distinction cannot be merely a sparse map whose domain varies:
decision-tree paths already have that shape. It is the requested-root-relative
observer over arbitrary typed shared dataflow with context-qualified site
identity, exact inverse fibers, and residuals. A sign omitted because it is
logically entailed, or set to zero because a cell lies on a boundary, is still
not an unobserved selection site.

Demand-driven bounded testing adds a fifth boundary. Lindblad already emits
partial constructor terms whose uninstantiated metavariables denote every total
refinement after property-directed reduction becomes true. Lazy SmallCheck
turns this idea into a concrete bounded refuter that refines the one tagged hole
the property forces and skips every total refinement when the result is known.
Korat independently backtracks only over fields an executable predicate reads.
Lazy heap-initialization methods similarly instantiate
only accessed fields and use relational bounds, SAT, or bounded-exhaustive
completion to prune partial states; PLI proves preservation of precisely the
jointly feasible scoped heap/path states. The remaining distinction is not
demand-guided refinement. It is one canonical record per richer graph observer
fiber, including an exact guard and symbolic residual, rather than a possibly
fragmented partial-input cover or an imperative path state.

Input-equivalence-class partitioning adds a sixth, more fundamental boundary.
Krafczyk and Peleska enumerate satisfiable local transition-condition patterns,
take their exact products across finite state classes, and minimize the result
to a coarsest behavior-preserving partition of a possibly infinite input
domain. Huang, Krafczyk, and Peleska enumerate all satisfiable Boolean atoms of
a finite guard/output/property alphabet. Instrumenting a one-step pure graph
with its totalized observation makes our fibers an instance or projection of
these exact classes. The only surviving opportunity is a specialized
graph-intensional construction and compact local guard/residual theorem; the
equivalence partition itself is established.

Decision structures add a seventh generic boundary. A deterministic
root-to-leaf path is already a sparse map from the tests encountered for one
input to their outcomes; the path conjunction is a guard and the leaf is a
result or residual. Compiling the totalized selection observation into an ADD
makes terminals correspond to observations and terminal preimages to fibers.
Reduction may skip an input variable because the compiled observation is
extensionally independent of it, which is different from graph-structural
non-observation but becomes an ordinary function property after the
unobserved sentinel is instrumented. Thus sparse path shape, disjoint leaf
regions, and residual labels are not separators. Only a demonstrably better
graph-specific construction, local guard form, or composition result could
survive this baseline.

Classical demand-driven dataflow adds an eighth boundary. Pingali and Arvind
already propagate output demands backwards through a stream graph and prove
their correctness and parsimony properties compositionally. Avron and Sasson
define the least legal output-complete valuation and characterize its uniform
existence by stability. Our enabled closure is at most a finite acyclic
specialization of that fixed-input object. The remaining change is to range
over symbolic inputs, project each least computation to selected site/outcome
events, and enumerate the exact inverse-image fibers. That change in
quantification must be explicit; “demand-sensitive evaluation” alone is
established.

## Route decision

- The manuscript is a survey with a unifying formal synthesis.
- The formal framework connects established objects and makes their observer
  choices explicit; it must not present the fiber theorem or observation
  reduction as a new symbolic-execution method.
- The survey's central negative result now has three independent generic
  reductions—projected AllSMT, fixed-alphabet Boolean atoms, and IOSTS input
  equivalence classes—plus ordinary decision-tree/ADD compilation and direct
  demand predecessors in stream dataflow, Korat, Lindblad's generator, and
  Lazy SmallCheck.
- A future CAV tool paper remains possible only after direct baseline
  experiments show a validation or scalability frontier.
