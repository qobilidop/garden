# yuan2025derivative — Derivative-Guided Symbolic Execution

- **Status:** deep-read; specification-guided falsification comparator
- **Primary source:** https://doi.org/10.1145/3704886
- **Version read:** author-hosted POPL 2025 PDF, 31 pages
- **Bibliography key:** `yuan2025derivative`

## Why it matters

Trace specifications for ADTs and opaque effectful libraries are translated to
symbolic finite automata. Symbolic derivatives expose the residual
specification after an event prefix, guide construction of feasible
precondition traces, and prune unproductive symbolic paths. The work therefore
provides a formal, event-observer-guided omission mechanism.

## Evidence locations

- Sections 1--2: LTLf trace specifications, latent SFA structure, and
  precondition-trace construction.
- Section 5: derivative semantics and pruning.
- Theorems 5.16 and 5.20: soundness of derivative-guided falsification.
- Theorem 5.19: completeness relative to the naive falsification semantics.
- Sections 6--8: implementation, evaluation, and scope qualifications.

## Relationship and evidence limit

The theorem is about finding falsifying event traces for effectful ADTs. It
does not enumerate a total finite observer image, prove disjoint input fibers,
or attach one ordinary symbolic residual to each fiber. Its proven
specification-relative pruning is nevertheless closer and stronger than an
ordinary coverage heuristic.
