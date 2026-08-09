# abramsky1990generalizedkahn — Generalized Kahn principle

- **Status:** screened; abstract asynchronous-network semantics boundary
- **Primary source:** https://doi.org/10.1007/BFB0040252
- **Open author copy:** https://arxiv.org/abs/1112.0427
- **Version read:** complete author manuscript
- **Bibliography key:** `abramsky1990generalizedkahn`

## Evidence locations

- Abstract and Section 2: the model covers asynchronous networks over arbitrary
  event structures rather than only stream histories.
- Section 3, Theorems 3.9 and 3.16: incrementality and causal expressiveness are
  sufficient for the two inclusions of the generalized Kahn principle.
- Section 3, Theorem 3.17: the partially ordered and linear trace models satisfy
  the generalized principle for nondeterministic functional networks.

## Relationship and evidence limit

This strengthens the fixed-point semantics boundary to nondeterministic
networks and event-structure models. It characterizes whole-network behavior;
it does not construct requested-site observations, caller-input inverse fibers,
or typed residual functions.
