# robinson2020dissecting — Dissecting Deep Neural Networks

- **Template version:** 2
- **Status:** deep-read
- **Primary source:** https://arxiv.org/abs/1910.03879
- **Version read:** arXiv version 2
- **Last reviewed:** 2026-08-05
- **Bibliography key:** `robinson2020dissecting`

## Result and limitation

The paper states an exact conversion of fully connected ReLU networks to
piecewise-affine form (PDF p. 4). Algorithm 1 constructs hyperplane regions and
stores working tuples ((R_i,P_i)); Algorithm 2 returns the complete list of
regions and affine transformations (pp. 7--8).

This is an explicit guard-plus-residual output before RPM. The paper gives no
numbered end-to-end correctness theorem or asymptotic enumeration bound, and
its demonstrated scope is fully connected ReLU networks.

## Relationship to our hypothesis

### What is directly established by the work?

The paper presents an exact fully connected ReLU-to-PWA conversion whose
algorithm returns regions with affine transformations.

### What is our interpretation or inference?

Those regions instantiate guard-plus-affine-residual output for a dense network
but do not establish contextual structural non-observation.

### Could it subsume our proposed contribution?

It is an affine restricted comparator, without the general graph observer or a
separate output-sensitive theorem.

## Evidence locations

- Exact-conversion statement, PDF p. 4.
- Algorithms 1--2, PDF pp. 7--8: construction and returned region/affine-map
  list.

## Update impact

- **Syntheses affected:** geometric and neural-region comparison
- **Claims affected:** S04, S15
- **Manuscript action:** retained only the qualified exact-neural-region claim
