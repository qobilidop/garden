---
citekey: chang2026compact
work:
  title: "Equivalent and Compact Representations of Neural Network Controllers With Decision Trees"
  author: "Kevin Chang, Nathan Dahlin, Rahul Jain, Pierluigi Nuzzo"
  venue: "IEEE TAC 71(8)"
  date: 2026
  doi: 10.1109/tac.2026.3676368
read: full-text
source: "arXiv:2304.06049v3 expanded manuscript (IEEE TAC version https://doi.org/10.1109/TAC.2026.3676368; CDC 2023 precursor https://doi.org/10.1109/CDC49753.2023.10383761)"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "The closest neural-policy comparator: constructs an exactly equivalent, adaptively pruned oblique decision tree for a discrete-output feed-forward ReLU controller, splitting only when both sides of a hidden activation or a pair of competing actions remain feasible, proven pointwise equal to the network by Theorem 1"
---

# Equivalent and Compact Representations of Neural Network Controllers With Decision Trees

## Evidence

### Why it matters

This is the closest neural-policy comparator. It constructs an exactly
equivalent soft decision tree for a feed-forward ReLU controller with a
deterministically tie-broken argmax output. Unlike a dense activation-pattern
tree, it tests a hidden activation only when both sides remain feasible in the
current node domain, and introduces output comparisons only when multiple
actions can still win.

### Program and semantic model

The source model is a layered feed-forward ReLU network over real inputs with a
finite discrete output selected by argmax. Each tree node carries a domain
defined by its ancestor tests. Internal nodes use sigmoid-wrapped affine
functions solely to express a soft-decision-tree split at threshold one half;
leaves return a one-hot action. The same deterministic argmax tie rule is used
by the network and tree.

### Results, algorithm, and guarantees

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

### Complexity

Theorem 4 bounds tree size by a product of hyperplane-arrangement region bounds,
with an additional output-comparison factor. Lemma 3 calls the result polynomial
in the uniform hidden width only when input dimension, network depth, and output
width are treated as fixed. It is not a polynomial bound in the full encoded
network size and is not an OutputP or delay theorem.

### Evidence locations

- Definitions 1--3 and equations (1)--(5), pp. 2--4: network, tree, node
  domains, and leaf semantics.
- Table I and Algorithm 1, pp. 4--6: feasibility-pruned ReLU and output splits.
- Lemmas 1--2 and Theorem 1, pp. 5--6: well-definedness and pointwise
  equivalence.
- Definition 4, Theorem 3, Theorem 4, and Lemma 3, pp. 6--7: arrangement and
  size analysis.
- Sections V--VI, pp. 7--11: verification formulations and experiments.

## Bearing on RQs

What is directly established by the work: exact output-action fibers for a
discrete ReLU policy can be represented by an adaptively pruned oblique
decision tree; infeasible activation tests and forced output comparisons can
be omitted; and the resulting tree preserves the controller pointwise over the
full input domain, subject to the shared tie convention.

Our interpretation or inference: its reached tree path is a sparse record of
tests needed to determine the action. This defeats any broad claim that exact
observer-relative omission or exact policy-region decision trees are new.

Could it subsume our proposed contribution: it directly subsumes the discrete-
output ReLU-policy specialization. The remaining scope is the formal
correspondence for arbitrary finite typed pure DAGs, requested internal roots,
contextual shared-graph sites, and symbolic residuals that intentionally
preserve equal-valued observed events rather than quotienting solely by the
final action.

## Evidence limits

- The polynomial-width statement fixes input dimension and depth; presenting it
  without those parameters would overstate the theorem.
- Boundary ownership depends on the specified nonpositive/positive split and
  deterministic argmax tie rule.
