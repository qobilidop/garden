# xiang2017reachable — Reachable Set Computation and Safety Verification for Neural Networks with ReLU Activations

- **Status:** deep-read
- **Primary source:** https://arxiv.org/abs/1712.08163
- **Bibliography key:** `xiang2017reachable`

## Result and relationship

Theorem 3 gives an exact layer reachable set as a union of polyhedra (PDF p.
10). Algorithms 2--3 propagate this construction through the whole network
and perform safety verification; both safe and unsafe answers are claimed
sound (pp. 13--14).

This establishes exact output-polyhedron reachability before later activation
region enumerators. It does not explicitly retain an input guard or activation
observation for every emitted output polyhedron, and it has no
requested-root-relative graph-site observer.
