---
citekey: affinitree2024
work:
  title: "Affinitree: A Compositional Framework for Formal Analysis and Explanation of Deep Neural Networks"
  author: "Maximilian Schlüter, Bernhard Steffen"
  venue: "TAP 2024"
  date: 2024
  doi: 10.1007/978-3-031-72044-4_8
read: full-text
source: "TAP 2024 paper, pp. 148–167, cross-checked against the expanded 2025 dissertation, via https://doi.org/10.1007/978-3-031-72044-4_8"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Symbolic execution of piecewise-linear neural networks into exact affine guard/residual decision structures, LP-pruned for infeasible paths — a formal comparator for feasibility-pruned neural decision trees and graph symbolic evaluation"
---

# Affinitree

## Evidence

### Why it matters

Affinitree symbolically executes piecewise-linear deep neural networks into
semantically equivalent typed affine decision structures. Its affine-predicate
nodes and affine terminals form an exact guard/residual tree. LP feasibility
checks remove impossible edges, nodes, and subtrees; equivalent subtrees may be
merged. It is therefore a direct formal comparator to feasibility-pruned neural
decision trees and graph symbolic evaluation.

### Program and semantic model

The source model is a feed-forward piecewise-linear neural network. Symbolic
execution composes affine layers directly and replaces each activation split by
an affine predicate over the original input. A typed affine decision structure
(TADS) carries affine predicates internally and an affine output map at each
terminal. The framework is compositional and supports equivalence, difference,
and classification-region queries on the resulting structures.

### Results, algorithm, and guarantees

The construction is semantics preserving for the stated PWL network model.
Path conjunctions are linear constraints, so LP feasibility exactly identifies
infeasible paths; the dissertation states this correspondence as Theorem 7.1.2.
The implementation reuses witnesses during depth-first traversal and prunes an
infeasible branch before constructing its descendants. Structural reductions
merge equal successor subtrees and simplify entailed tests.

The TAP evaluation covers 3,000 networks. One reported fairness example drops
from an estimated 883 million nodes in the full unoptimized tree to 808,713
nodes after pruning, but LP work remains the limiting cost. These measurements
demonstrate reduction, not a polynomial worst-case guarantee.

### Complexity

Worst-case activation products and TADS size remain exponential. Each retained
or rejected boundary may require an LP check; witness reuse reduces observed
calls but the paper gives no full-network OutputP, polynomial-delay, or
polynomial-bit bound.

### Evidence locations

- TAP paper, Sections 2--3: PWL networks, TADS, and symbolic construction.
- TAP paper, pruning and reduction sections: LP feasibility and structural
  simplification.
- TAP paper, evaluation section: 3,000-network corpus and scaling limits.
- Dissertation, Section 7.1 and Theorem 7.1.2: path/LP infeasibility
  correspondence.
- Dissertation, implementation chapter: witness-reusing DFS and pruning.

## Bearing on RQs

What is directly established by the work:

- Exact symbolic execution of PWL neural networks to affine guards and affine
  residual terminals.
- Sound and complete LP removal of infeasible activation paths in the model.
- Semantics-preserving structural reduction and compositional analysis.

Our interpretation or inference: the reached TADS path is a sparse decision
record because infeasible and entailed activation tests can disappear. This
defeats the claim that exact neural methods necessarily retain dense
activation vectors.

Could it subsume our proposed contribution: it subsumes the real PWL neural
specialization and much of the generic guard/residual narrative. It does not
define requested internal roots or a dynamic partial map of preserved
observation-event identities over arbitrary typed pure IR; its reductions are
extensional and may merge distinctions that the proposed intensional observer
deliberately retains.

## Evidence limits

- The exact result is restricted to the represented PWL neural operators and
  real affine predicates.
- The representation can still be enormous after pruning and has no general
  output-sensitive complexity theorem.
