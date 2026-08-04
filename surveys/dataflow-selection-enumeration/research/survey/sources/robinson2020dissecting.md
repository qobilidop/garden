# robinson2020dissecting — Dissecting Deep Neural Networks

- **Status:** deep-read
- **Primary source:** https://arxiv.org/abs/1910.03879
- **Version read:** arXiv version 2
- **Bibliography key:** `robinson2020dissecting`

## Result and limitation

The paper states an exact conversion of fully connected ReLU networks to
piecewise-affine form (PDF p. 4). Algorithm 1 constructs hyperplane regions and
stores working tuples ((R_i,P_i)); Algorithm 2 returns the complete list of
regions and affine transformations (pp. 7--8).

This is an explicit guard-plus-residual output before RPM. The paper gives no
numbered end-to-end correctness theorem or asymptotic enumeration bound, and
its demonstrated scope is fully connected ReLU networks.
