# aytekin2022trees — Neural Networks are Decision Trees

- **Status:** deep-read
- **Primary source:** https://arxiv.org/abs/2210.05189
- **Version read:** arXiv v3, 25 October 2022
- **Bibliography key:** `aytekin2022trees`

## Why it matters

Aytekin gives a broad constructive neural-network-to-tree representation based
on effective input-space filters selected by earlier activation categories. It
predates the policy-specific exact tree constructions and makes the dense
activation-decision lineage explicit.

## Program and semantic model

For piecewise-linear activations, the activation category vector turns each
layer into a choice among affine filters of the original input. Algorithm 2
unrolls these choices into a tree whose depth is the total hidden width. The
paper then sketches extensions to convolution, skips, normalization, recurrence,
and arbitrary activations; continuous activations require infinitely many
categories for literal exactness.

## Results, algorithm, and guarantees

Equations (3)--(5) derive effective matrices conditioned on prior activation
categories, and Algorithms 1--2 give the constructive conversion. The paper
claims equivalence for broad architectures but states no numbered theorem or
inductive proof with boundary and recurrence assumptions. Infeasible or
redundant paths are noted as removable and are manually simplified in examples,
not pruned by a proved complete algorithm.

## Complexity

For total hidden width `d`, the displayed dense binary tree has depth `d` and
up to `2^d` leaves for two-piece activations. The representation may trade
fewer per-input computations for exponential storage. A continuously valued
activation induces infinite branching unless discretized, which would no
longer be exact.

## Relationship to our hypothesis

This establishes the dense decision-history encoding for neural networks. It
does not provide exact feasible input fibers, solver-pruned sparse paths,
requested-root-relative structural omission, or typed residuals.

## Evidence locations

- Section 2.1, equations (1)--(5): activation-conditioned effective filters.
- Algorithms 1--2, pp. 3--4: dense tree construction.
- Sections 2.2--2.4, pp. 4--6: convolution, recurrence, and arbitrary
  activations.
- Section 3, pp. 6--7: examples and hand simplification.
- Section 4, p. 7: storage/computation tradeoff.

## Questions and possible weaknesses

- The blanket *any activation* wording needs the paper's infinite-width caveat.
- There is no formal feasibility-pruning or global partition theorem.

