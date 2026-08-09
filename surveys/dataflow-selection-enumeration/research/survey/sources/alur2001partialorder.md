# alur2001partialorder — Partial-Order Reduction in Symbolic State Space

- **Status:** deep-read; exact interleaving-reduction comparator
- **Primary source:** https://doi.org/10.1023/A:1008767206905
- **Version read:** journal treatment, pp. 97--116
- **Bibliography key:** `alur2001partialorder`

## Why it matters

The method combines BDD-based symbolic state representation with partial-order
reduction. For asynchronous systems, interleavings of independent events that
are equivalent for local-property verification need not all be explored. This
is an exact observer-relative omission of execution choices, though its object
is concurrent scheduling rather than caller-input fibers.

## Evidence locations

- Abstract and Section 1: equivalence of independent-event interleavings for
  local properties and the symbolic/partial-order combination.
- Sections 2--4: transition-system assumptions, ample-set style reduction, and
  BDD-based symbolic reachability construction.
- Correctness development: preservation conditions for the reduced symbolic
  exploration.
- Evaluation: asynchronous design examples and BDD/state reductions.

## Relationship and evidence limit

The preserved observer is a local temporal property over concurrent state
transitions. It neither records requested internal selection identities nor
partitions a pure function's caller inputs, but it defeats broad novelty for
exact choice omission under an observer-preserving equivalence.
