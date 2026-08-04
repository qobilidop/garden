# shi2020tractable — On Tractable Representations of Binary Neural Networks

- **Status:** deep-read
- **Primary source:** https://doi.org/10.24963/kr.2020/91
- **Version read:** KR 2020 proceedings paper, pp. 882--892
- **Open copy:** https://arxiv.org/abs/2004.02082
- **Bibliography key:** `shi2020tractable`

## Why it matters

This work compiles the exact Boolean function of a binary neural network into
OBDDs and SDDs, making explanation, exact model counting, and robustness
queries tractable in the compiled representation.

## Program and semantic model

Inputs and step-activation outputs are Boolean. Each neuron is a linear
threshold classifier. Neuron OBDDs are combined as a Boolean circuit and then
knowledge-compiled to an SDD.

## Results, algorithm, and guarantees

Theorem 1 recalls an exponential worst-case OBDD construction for a linear
classifier. Theorem 2 gives a pseudo-polynomial `O(nW)`-node and `O(nW)`-time
OBDD for integer weights with total magnitude parameter `W`; fixed precision
extends the result to rational weights. Exact neuron diagrams compose into an
exact network circuit/SDD. Theorems 3--4 characterize hardness of robustness
queries on uncompiled representations; the SDD operations then support exact
queries in time polynomial in current diagram sizes, although repeated
conjunction can still grow exponentially.

## Relationship to our hypothesis

The paper establishes exact neural-specific knowledge compilation and sparse
prime-implicant explanations. It targets a dense Boolean final-output function,
not an input-dependent partial record of requested internal events.

## Evidence locations

- Section 2, pp. 883--885: Boolean neural and OBDD/SDD model.
- Theorems 1--2, pp. 884--885 and appendix: neuron compilation bounds.
- Section 4, pp. 885--886: exact SDD network compilation.
- Theorems 3--4 and Algorithm 1, pp. 886--888: exact robustness analysis.
- Section 6, pp. 888--891: exact binary-CNN SDD case study and explanations.

## Questions and possible weaknesses

- The pseudo-polynomial bound depends on numerical weight magnitude and does
  not imply polynomial bit complexity.

