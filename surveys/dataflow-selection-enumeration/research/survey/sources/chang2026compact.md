# chang2026compact — Equivalent and Compact Representations of Neural Network Controllers With Decision Trees

- **Status:** deep-read; critical exact policy-tree predecessor
- **Primary source:** https://doi.org/10.1109/TAC.2026.3676368
- **Version read:** arXiv:2304.06049v3, expanded IEEE TAC manuscript
- **Conference precursor:** https://doi.org/10.1109/CDC49753.2023.10383761
- **Bibliography key:** `chang2026compact`

## Why it matters

This is the closest neural-policy comparator. It constructs an exactly
equivalent soft decision tree for a feed-forward ReLU controller with a
deterministically tie-broken argmax output. Unlike a dense activation-pattern
tree, it tests a hidden activation only when both sides remain feasible in the
current node domain, and introduces output comparisons only when multiple
actions can still win.

## Program and semantic model

The source model is a layered feed-forward ReLU network over real inputs with a
finite discrete output selected by argmax. Each tree node carries a domain
defined by its ancestor tests. Internal nodes use sigmoid-wrapped affine
functions solely to express a soft-decision-tree split at threshold one half;
leaves return a one-hot action. The same deterministic argmax tie rule is used
by the network and tree.

## Results, algorithm, and guarantees

Algorithm 1 recursively computes the affine form of each neuron relative to the
current domain. Rule A splits on a ReLU only if the intersections with both its
positive and nonpositive sides are nonempty. When no hidden split remains,
Rule B splits on an output-score difference only if competing winners remain.
Otherwise Rule C emits the unique winning action. Feasibility is reduced to
linear programming.

Lemma 1 establishes that the split rules are well-defined, Lemma 2 relates the
leaf-local affine scores to the original network, and Theorem 1 proves global
pointwise equality of the network and resulting tree for every real input.
The theorem is stronger than sampled fidelity.

## Complexity

Theorem 4 bounds tree size by a product of hyperplane-arrangement region bounds,
with an additional output-comparison factor. Lemma 3 calls the result polynomial
in the uniform hidden width only when input dimension, network depth, and output
width are treated as fixed. It is not a polynomial bound in the full encoded
network size and is not an OutputP or delay theorem.

## Relationship to our hypothesis

### What is directly established by the work?

- Exact output-action fibers for a discrete ReLU policy can be represented by
  an adaptively pruned oblique decision tree.
- Infeasible activation tests and forced output comparisons can be omitted.
- The resulting tree preserves the controller pointwise over the full input
  domain, subject to the shared tie convention.

### What is our interpretation or inference?

Its reached tree path is a sparse record of tests needed to determine the
action. This defeats any broad claim that exact observer-relative omission or
exact policy-region decision trees are new.

### Could it subsume our proposed contribution?

It directly subsumes the discrete-output ReLU-policy specialization. The
remaining scope is the formal correspondence for arbitrary finite typed pure
DAGs, requested internal roots, contextual shared-graph sites, and symbolic
residuals that intentionally preserve equal-valued observed events rather than
quotienting solely by the final action.

## Evidence locations

- Definitions 1--3 and equations (1)--(5), pp. 2--4: network, tree, node
  domains, and leaf semantics.
- Table I and Algorithm 1, pp. 4--6: feasibility-pruned ReLU and output splits.
- Lemmas 1--2 and Theorem 1, pp. 5--6: well-definedness and pointwise
  equivalence.
- Definition 4, Theorem 3, Theorem 4, and Lemma 3, pp. 6--7: arrangement and
  size analysis.
- Sections V--VI, pp. 7--11: verification formulations and experiments.

## Questions and possible weaknesses

- The polynomial-width statement fixes input dimension and depth; presenting it
  without those parameters would overstate the theorem.
- Boundary ownership depends on the specified nonpositive/positive split and
  deterministic argmax tie rule.

