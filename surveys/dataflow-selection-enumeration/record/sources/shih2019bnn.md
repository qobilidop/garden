# shih2019bnn — Verifying Binarized Neural Networks by Angluin-Style Learning

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-030-24258-9_25
- **Version read:** SAT 2019 author PDF, pp. 354--370
- **Bibliography key:** `shih2019bnn`

## Why it matters

Shih, Darwiche, and Choi learn an OBDD that is exactly equivalent to a
binarized neural network on a chosen input region. The compiled OBDD supports
model counting and prime implicants whose omitted bits are explicit
don't-cares.

## Program and semantic model

The BNN has binary inputs and a binary output. Both the BNN and a hypothesis
OBDD are encoded into CNF. A region constraint can describe a Hamming ball or
the whole Boolean input space.

## Results, algorithm, and guarantees

Algorithm 1 adapts Angluin-style automaton/OBDD learning. Membership queries
evaluate the BNN. An equivalence query asks SAT for an input in the region on
which the BNN and hypothesis disagree. An unsatisfiable equivalence query
certifies that the returned OBDD computes exactly the same function throughout
the region. Expanding the region can reuse the prior OBDD as a hypothesis.

The underlying learner requires `n` equivalence queries and
`6n^2 + n log m` membership queries, where `n` is the final OBDD node count and
`m` its variable count. The CNF encoding and SAT-oracle costs are additional;
there is no polynomial bound in the BNN encoding because the output OBDD may be
exponential.

## Relationship to our hypothesis

The OBDD is an exact final-output fiber representation and its prime implicants
are sparse partial input assignments. It does not expose internal site events,
structural absence, symbolic residual values, or contextual DAG identities.

## Evidence locations

- Section 2, pp. 356--358: BNN and OBDD semantics.
- Section 3, pp. 358--360: BNN/OBDD CNF encodings and disagreement query.
- Section 4, pp. 360--362: OBDD-learning query count.
- Algorithms 1--2, pp. 362--364: exact regional compilation and Hamming region.
- Section 6, pp. 364--368: model-counting and prime-implicant experiments.

## Questions and possible weaknesses

- Correctness is relative to a complete SAT equivalence oracle and the stated
  finite input-region constraint.

