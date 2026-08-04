# tran2019star — Star-Based Reachability Analysis of Deep Neural Networks

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-030-30942-8_39
- **Bibliography key:** `tran2019star`

## Why it matters

Exact star reachability is an earlier guard-plus-affine-residual construction
than RPM. A star retains an affine image together with predicates over its
original basis variables.

Algorithm 3.1 returns exact reachable stars (PDF p. 6; LNCS p. 675). Theorem 1
relates the worst case to (2^N) LP feasibility problems, and Theorem 2
reconstructs the complete unsafe input set by retaining the original center,
basis, and strengthened predicates (PDF p. 7; LNCS p. 676).

The construction covers dense ReLU semantics and can encode an exact input
guard plus affine image. It does not define input-dependent structural absence
of selector sites or a requested-root-relative observation.
