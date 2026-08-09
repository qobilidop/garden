---
citekey: alur2001partialorder
work:
  title: "Partial-Order Reduction in Symbolic State-Space Exploration"
  author: "Rajeev Alur, Robert K. Brayton, Thomas A. Henzinger, Shaz Qadeer, Sriram K. Rajamani"
  venue: "Formal Methods in System Design"
  date: 2001
  doi: 10.1023/a:1008767206905
read: full-text
source: "Journal article via https://doi.org/10.1023/A:1008767206905, pp. 97–116"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Combines BDD-based symbolic model checking with partial-order reduction to skip verification-irrelevant interleavings — an exact observer-relative choice-omission precedent, though for concurrent scheduling rather than caller-input fibers"
---

# Partial-Order Reduction in Symbolic State-Space Exploration

## Evidence

### Why it matters

The method combines BDD-based symbolic state representation with partial-order
reduction. For asynchronous systems, interleavings of independent events that
are equivalent for local-property verification need not all be explored. This
is an exact observer-relative omission of execution choices, though its object
is concurrent scheduling rather than caller-input fibers.

### Evidence locations

- Abstract and Section 1: equivalence of independent-event interleavings for
  local properties and the symbolic/partial-order combination.
- Sections 2--4: transition-system assumptions, ample-set style reduction, and
  BDD-based symbolic reachability construction.
- Correctness development: preservation conditions for the reduced symbolic
  exploration.
- Evaluation: asynchronous design examples and BDD/state reductions.

## Bearing on RQs

The preserved observer is a local temporal property over concurrent state
transitions. It neither records requested internal selection identities nor
partitions a pure function's caller inputs, but it defeats broad novelty for
exact choice omission under an observer-preserving equivalence.

## Evidence limits

Read at full-text level (journal treatment, pp. 97–116); the note records no
evidence-quality caveats beyond the scope boundary above.
