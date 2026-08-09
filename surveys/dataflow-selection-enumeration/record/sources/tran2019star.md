---
citekey: tran2019star
work:
  title: "Star-Based Reachability Analysis of Deep Neural Networks"
  author: "Hoang-Dung Tran, Diago Manzanas Lopez, Patrick Musau, Xiaodong Yang, Luan Viet Nguyen, Weiming Xiang, Taylor T. Johnson"
  venue: "CAV 2019"
  date: 2019
  doi: 10.1007/978-3-030-30942-8_39
read: full-text
source: "CAV 2019 LNCS proceedings PDF via https://doi.org/10.1007/978-3-030-30942-8_39"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-05
synthesis: "Exact star reachability retains an affine image plus predicates over original basis variables, with an LP-feasibility worst case and complete unsafe-input reconstruction — an earlier guard-plus-affine-residual construction than RPM, restricted to dense ReLU semantics"
---

# Star-Based Reachability Analysis of Deep Neural Networks

## Evidence

### Why it matters

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

### Evidence locations

- Algorithm 3.1, PDF p. 6 / LNCS p. 675: exact reachable-star construction.
- Theorems 1--2, PDF p. 7 / LNCS p. 676: worst-case LP count and complete
  unsafe-input reconstruction.

## Bearing on RQs

The exact star construction retains an affine image and predicates over the
original basis variables, with the stated LP-feasibility worst case and unsafe
input reconstruction.

A star can serve as an exact guard-plus-affine-residual representation for a
dense ReLU region, but its observer is not automatically the contextual
selection observer.

It subsumes an affine restricted case, not structurally unobserved nested sites
or the four-field general record contract.

## Evidence limits

Read at full-text level from the CAV 2019 LNCS proceedings PDF; the note
records no limitations beyond the scope distinction already given in Bearing
on RQs above.
