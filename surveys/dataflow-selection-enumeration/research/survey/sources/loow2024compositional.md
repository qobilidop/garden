# loow2024compositional — Compositional Symbolic Execution for Correctness and Incorrectness Reasoning

- **Status:** deep-read
- **Primary source:** https://drops.dagstuhl.de/storage/00lipics/lipics-vol313-ecoop2024/LIPIcs.ECOOP.2024.25/LIPIcs.ECOOP.2024.25.pdf
- **Version read:** official ECOOP 2024 version
- **Bibliography key:** `loow2024compositional`

## Why it matters

The paper gives a modern exact engine for creating and consuming reusable
function specifications. It shows how heavily occupied the term
“compositional symbolic execution” already is, while its heap-local framing is
largely orthogonal to observation-sensitive pure graphs.

## Program and semantic model

A partial symbolic state consists of a symbolic store, finite partial symbolic
heap, and path condition (Section 4.1, 25:11). The full engine adds a multiset
of symbolic predicates (Section 5.1, 25:13). Reusable separation-logic or
incorrectness-separation-logic specifications contain a precondition and
successful and error postconditions.

At a call, `consume` removes the precondition resources and returns a frame and
logical substitution; `produce` adds the chosen postcondition to that frame.
Figure 4 states seven well-formedness, coverage, semantic-decomposition, and
completeness properties for these operations (25:14).

## Results and guarantees

- Theorem 1: the core engine is over- and under-approximation sound, hence exact.
- Theorem 3: the compositional engine retains both guarantees under valid
  specifications and the stated exactness restriction on predicates.
- Theorem 6: the consume/produce implementations satisfy the seven interface
  properties.
- Theorem 8: synthesized under-approximate specifications are valid.

Assumptions include the demonstrator language, a finite linear heap, valid
specifications, suitable consume/produce operations, and strictly exact
predicates for under-approximate folding.

## Complexity

There is no asymptotic theorem. The evaluation reports 5,693 synthesized
specifications for 364 Collections-C functions in 66.92 seconds; one
specification is produced per constructed path (Section 9, 25:24).

## Relationship to our hypothesis

Active selections could be exported as ghost postcondition resources, but
ordinary specifications intentionally hide internal paths. A boundary-demand
mask controls which ghost observations cross a pure function boundary; this is
not heap framing. The work establishes reusable symbolic specifications, not
enumeration of sparse structural observations.

## Evidence locations

- Sections 4.1 and 5.1, 25:11–25:14: states and specification interface.
- Theorems 1, 3, and 6, 25:11–25:20: exactness and interface results.
- Theorem 8 and Section 9, 25:23–25:24: synthesis and evaluation.

