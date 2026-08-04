# xu2022traversing — Traversing the Local Polytopes of ReLU Neural Networks

- **Status:** deep-read
- **Primary source:** https://openreview.net/pdf?id=EQjwT2-Vaba
- **Bibliography key:** `xu2022traversing`

## Result and complexity

Equations 2--6 define activation codes, exact H-polytope guards, and affine
local models (PDF p. 2). Algorithm 1 and Theorem 4.1 cover every nonempty
one-hidden-layer polytope; Algorithm 3 and Theorem 4.2 cover every nonempty
level-(L) polytope intersecting a closed bounded convex region (pp. 4--5).
The paper states exponential time and space and uses an LP per pattern (p. 4).

This is a theorem-backed exact adjacency enumerator, but its proof scope is
fully connected ReLU networks and every activation remains a coordinate.
