# tran2019star — Star-Based Reachability Analysis of Deep Neural Networks

- **Template version:** 2
- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-030-30942-8_39
- **Version read:** CAV 2019 LNCS proceedings PDF
- **Last reviewed:** 2026-08-05
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

## Relationship to our hypothesis

### What is directly established by the work?

The exact star construction retains an affine image and predicates over the
original basis variables, with the stated LP-feasibility worst case and unsafe
input reconstruction.

### What is our interpretation or inference?

A star can serve as an exact guard-plus-affine-residual representation for a
dense ReLU region, but its observer is not automatically the contextual
selection observer.

### Could it subsume our proposed contribution?

It subsumes an affine restricted case, not structurally unobserved nested sites
or the four-field general record contract.

## Evidence locations

- Algorithm 3.1, PDF p. 6 / LNCS p. 675: exact reachable-star construction.
- Theorems 1--2, PDF p. 7 / LNCS p. 676: worst-case LP count and complete
  unsafe-input reconstruction.

## Update impact

- **Syntheses affected:** geometric and neural-region comparison
- **Claims affected:** S04, S15
- **Manuscript action:** retained only the qualified exact-neural-region claim
