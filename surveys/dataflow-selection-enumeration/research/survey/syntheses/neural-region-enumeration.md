# Exact activation-region and hyperplane-cell enumeration

## Established frontier

Exact enumeration of feasible geometric regime assignments is established
well beyond a monolithic SMT encoding:

- Avis and Fukuda's reverse search enumerates every full-dimensional affine
  arrangement cell exactly once with output-polynomial time and polynomial
  space; Sleumer improves its fixed-dimensional arithmetic bound to
  \(O(m|C|)\); Ferrez, Fukuda, and Liebling give the pre-Rada central-
  arrangement ray-shooting bound \(O(KQ\,LP(Q,D))\) with \(O(QD)\) working
  space; and Rada and Černý later give a direct incremental sign-prefix
  formulation. Deza and Pournin add a rational-bit-model zonotope traversal
  with output-sized retention but do not improve Ferrez's LP-relative bound;
  Dussault et al. specialize the central case, make the zero-witness
  perturbation explicit, and add circuit-guided variants.
- Serra et al. enumerate or count exactly the feasible dense ReLU activation
  patterns with a boundary-aware mixed-integer formulation.
- Xiang computes exact reachable polyhedral unions; Tran's star sets retain
  exact input predicates and affine images and reconstruct complete unsafe
  input sets; Robinson explicitly emits region/affine-map pairs; and Bak gives
  complete geometric ReLU-path enumeration.
- Yang retains original-input subpolytopes and affine maps; Vincent and
  Schwager then enumerate every feasible pattern with its exact H-polyhedral
  guard and residual affine map by adjacency marching.
- SyReNN, DISCO, Xu's local-polytope traversal, and SplineCam broaden exact
  partition construction, architectural scope, or proof support before or
  contemporaneously with the 2023 algorithms.
- Wang distinguishes dense activation cells from maximal extensional affine
  regions and merges connected cells with equal affine maps.
- Masden extracts the richer full ReLU cell complex and face poset, including
  lower-dimensional cells.
- Berzins gives a GPU-oriented exact bounded-complex algorithm based on edge
  subdivision.
- Balestriero and LeCun adapt incremental hyperplane enumeration layerwise but
  omit the formal and complexity support available in the earlier arrangement
  literature.
- Drammis et al. give the subsequent bounded-domain correctness argument and
  parameterized parallel work analysis.
- Joyce handles skip-connected linear regions, while AffineLens gives the
  strongest later high-dimensional architectural breadth in this audit,
  subject to full-dimensional and degeneracy assumptions.

Consequently the paper must not claim first exact feasible-choice enumeration,
first recursive feasibility pruning, first output-sensitive region
enumeration, first parallel exact enumeration, first enumeration of a guard
with an affine residual, or first exact treatment of convolution, pooling,
skip-connected, maxout, or other heterogeneous CPWL structure.

## Exact sparse neural trees and decision diagrams

The dense-cell reduction is only one neural observer. Chang et al. construct a
pointwise-equivalent decision tree for ReLU--argmax controllers while omitting a
ReLU test whose one side is LP-infeasible and adding output comparisons only
while competing winners remain. Logemann--Veith use related path-feasibility and
forced-rule pruning, then represent leaves as exact polyhedral policy-output
regions. Affinitree symbolically executes PWL networks into exact affine-test/
affine-terminal structures and prunes LP-infeasible subtrees.

Binary-neural knowledge compilation chooses an even coarser observer. Shih et
al. learn an exact regional OBDD; Shi et al. compile exact neuron and network
functions to OBDDs/SDDs; and BDD4BNN constructs exact per-class BDDs for a
requested input region while existentially eliminating intermediate activation
vectors. Reduced diagrams and prime implicants can skip irrelevant input tests.
These works establish exact neural-specific dynamic omission and extensional
requested-output quotients. They do not preserve internal event provenance.

## Three incompatible meanings of a zero coordinate

The lineage is especially useful for terminology because ternary maps encode
three different phenomena:

| Framework | Meaning of coordinate `0` |
|---|---|
| Balestriero--LeCun | the actual `+/-` sign is entailed by earlier geometric constraints and compressed away |
| Masden/Berzins | the cell lies on the unit's bent hyperplane; zero is an actual boundary sign |
| Selection observation | the coordinate is absent, not zero, because the site lies outside the requested result's enabled closure |

These must not be conflated. Logical redundancy, geometric boundary, and
structural non-observation are distinct semantic relations.

## Exact special-case reduction

Translate each ReLU into a binary selection between two affine regimes and
request the network output. In a dense feedforward layer chain, every
activation result is an ordinary operand dependency, hence every site lies in
the enabled closure. On full-dimensional cell interiors, the selection
observation is exactly the dense activation vector. Its inverse image is the
activation cell, and its residual is the cell-local affine map.

Thus exact activation-region enumeration is not merely analogous; it is the
all-sites-observed real-CPA special case of the observer proposed here.

## Activation cells are not extensional affine regions

Most exact neural algorithms enumerate feasible activation patterns or the
polyhedral cells induced by them. Adjacent cells with different activation
patterns may nevertheless realize the same affine function in degenerate
networks. Wang explicitly separates `shape` from affine `value` and merges
connected same-value cells into maximal linear regions.

Our selection observer deliberately retains observed equal-valued outcomes.
It therefore corresponds to the finer activation-cell partition in the dense
ReLU reduction, not automatically to maximal extensional affine regions. Any
use of *linear region* must state which equivalence is intended.

## Surviving graph-semantic separator

The general pure-graph problem permits nested selectors whose unselected case
subgraphs are outside the requested result's enabled closure. It emits a
partial map whose domain varies with the input. But dynamic sparsity alone is
not a separator: an ordinary decision-tree execution already evaluates only
the tests on its selected root-to-leaf path, whose conjunction is a guard and
whose leaf is a result; BDDs add shared residual subgraphs.

The remaining distinction is the whole graph-semantic package: arbitrary typed
shared dataflow rather than a tree or dense CPA layer chain; requested-root
relative enabled closure; context-qualified selector identities; preservation
of observed equal-valued alternatives; exact inverse fibers; and typed
residuals. A site under an unselected outer case is absent rather than assigned
a wildcard, but that fact is generically representable after totalization.

The dense geometric algorithms instead:

- assign or geometrically classify every activation unit;
- operate on continuous real CPA layers;
- enumerate full-dimensional polyhedra or a complete boundary complex; and
- have no requested-root-relative site observer.

The defensible contribution, if the remaining audit survives, is therefore a
formal correspondence among enabled-edge reachability, graph-relative
observations, exact fibers, residuals, and compositional shared-graph
evaluation, plus a nontrivial construction or representation result—not a new
general region-enumeration skeleton or merely a sparse dynamic path.

## Complexity consequence

For strict affine sign sites on the full real domain, any theory-level
recurrence should reduce to the established arrangement bounds. Avis--Fukuda
give

\[
  O(KQD\,l(Q,D)),
\]

Sleumer gives \(O(KQ)\) arithmetic time for fixed \(D\). Ferrez--Fukuda--
Liebling give \(O(KQ\,LP(Q,D))\) time and \(O(QD)\) working space for central
arrangements, and Rada--Černý's later incremental formulation gives

\[
  O(KQ\,lp(Q,D))
\]

where \(Q\) is the number of hyperplanes, \(K\) the number of cells, and
\(D\) the input dimension, up to representation costs and the open-cell
assumptions stated in the primary results. Dussault et al.'s newer algorithms
provide substantial empirical improvements for central arrangements, but no
replacement end-to-end asymptotic bound. Deza--Pournin's
\(O(Kp(Q,D,B_Z))\) rational-bit-model result, where \(B_Z\) is total generator
encoding length, retains output-sized state and leaves
the polynomial unspecified; its symmetry-aware successor likewise gives no
better generic theorem. A generic \(K+1\) model-query accounting per emitted
observation is therefore not independently novel. Complexity claims
must instead expose:

- graph evaluation and enabled-closure size;
- number and serialized size of sparse observations;
- exact-primitive formula construction;
- solver feasibility cost and incremental reuse;
- residual construction; and
- contextual composition costs under graph sharing.

## Terminology consequence

Use *activation pattern*, *activation region*, *hyperplane cell*, and
*polyhedral complex* for the established neural objects. Do not rename them
selection observations. Reserve *selection observation* for the locally
defined partial map over graph sites and say explicitly that activation
patterns instantiate it only in the all-sites-observed special case.
