# Exact activation-region and hyperplane-cell enumeration

## Established frontier

Exact enumeration of feasible geometric regime assignments is established
well beyond a monolithic SMT encoding:

- Rada and Černý incrementally enumerate every full-dimensional cell of an
  affine hyperplane arrangement, prove completeness and nonduplication, and
  give an OutputP time/space analysis.
- Serra et al. enumerate or count exactly the feasible dense ReLU activation
  patterns with a boundary-aware mixed-integer formulation.
- Vincent and Schwager enumerate every feasible pattern together with its
  exact H-polyhedral guard and residual affine output map by adjacency
  marching.
- Masden extracts the richer full ReLU cell complex and face poset, including
  lower-dimensional cells.
- Berzins gives a GPU-oriented exact bounded-complex algorithm based on edge
  subdivision.
- Balestriero and LeCun adapt incremental hyperplane enumeration layerwise but
  omit the formal and complexity support available in the earlier arrangement
  literature.
- Drammis et al. give the subsequent bounded-domain correctness argument and
  parameterized parallel work analysis.

Consequently the paper must not claim first exact feasible-choice enumeration,
first recursive feasibility pruning, first output-sensitive region
enumeration, first parallel exact enumeration, or first enumeration of a guard
with an affine residual.

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

## Surviving separator

The general pure-graph problem permits nested selectors whose unselected case
subgraphs are outside the requested result's enabled closure. It therefore
emits a partial map whose *domain itself varies with the input*. Equal-valued
selected outcomes remain distinct, while a site under an unselected outer
case is absent rather than assigned a wildcard.

The closest neural algorithms instead:

- assign or geometrically classify every activation unit;
- operate on continuous real CPA layers;
- enumerate full-dimensional polyhedra or a complete boundary complex; and
- have no requested-root-relative site observer.

The defensible contribution, if the remaining audit survives, is therefore a
formal correspondence among enabled-edge reachability, sparse graph-relative
observations, exact fibers, residuals, and compositional shared-graph
evaluation—not a new general region-enumeration skeleton.

## Complexity consequence

For affine sign sites, any theory-level recurrence should reduce to the
standard incremental arrangement bound

\[
  O(RK\,lp(K,D))
\]

up to representation costs. A generic \(K+1\) model-query accounting per
emitted observation is therefore not independently novel. Complexity claims
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

