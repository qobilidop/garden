---
citekey: nguyen2020ecdt
work:
  title: "Towards Interpretable ANNs: An Exact Transformation to Multi-Class Multivariate Decision Trees"
  author: "Duy T. Nguyen, Kathryn E. Kasmarik, Hussein A. Abbass"
  date: 2020
  arxiv: 2003.04675
read: full-text
source: "arXiv v4 (17 November 2021) at https://arxiv.org/abs/2003.04675"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "EC-DT gives an early layer-wise exact transformation of ReLU classifiers into multivariate decision trees by recursive affine-test substitution and contradiction elimination — a direct predecessor to later neural-policy tree conversions, without a numbered global equivalence theorem"
---

# Towards Interpretable ANNs

## Evidence

### Why it matters

Nguyen, Kasmarik, and Abbass introduce Exact-Convertible Decision Trees
(EC-DTs), an early layer-wise exact transformation of ReLU classifiers into
multivariate decision trees. It is a direct predecessor to later neural-policy
tree conversions.

### Program and semantic model

An EC-DT replaces each hidden ReLU layer by multivariate affine tests and
recursively substitutes earlier layer conditions into later ones. Contradictory
rule conjunctions are removed. Leaves encode the final network decision. The
separate Extended C-Net combines learned C5 rules with back-projection and is
approximate rather than exact.

### Results, algorithm, and guarantees

The layer-wise construction is intended to preserve all feasible activation
decisions and the final classification boundary. Experiments report 100 percent
fidelity for EC-DT on the evaluated networks, while Extended C-Net trades
fidelity for compactness. The paper provides detailed derivations and
algorithms but no numbered global equivalence theorem over every real input.

### Complexity

EC-DT enumerates combinations of layer activation rules and grows
exponentially; the paper characterizes it as practical only for small networks.
Contradiction elimination reduces actual size but has no output-sensitive or
polynomial-delay bound.

### Evidence locations

- Sections 3--4, pp. 8--19: multivariate rule representation and EC-DT
  construction.
- Algorithms 1--4, pp. 12--22: layer conversion, contradiction checks, and
  Extended C-Net.
- Section 6, pp. 27--46: fidelity and model-size experiments.
- Sections 7--8, pp. 46--50: scaling and exact-versus-approximate limitations.

## Bearing on RQs

EC-DT predates later exact dense neural decision trees and already prunes
contradictory rule combinations. It lacks requested-root structural absence,
arbitrary typed primitives, contextual shared-DAG identity, and an explicit
guard-plus-symbolic-residual output contract.

## Evidence limits

- Exactness is supported constructively and empirically, not by a standalone
  theorem with a complete boundary convention.
