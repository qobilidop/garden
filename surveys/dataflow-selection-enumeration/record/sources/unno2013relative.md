---
citekey: unno2013relative
work:
  title: "Automating Relatively Complete Verification of Higher-Order Functional Programs"
  author: "Hiroshi Unno, Tachio Terauchi, Naoki Kobayashi"
  venue: "POPL 2013"
  date: 2013
  doi: 10.1145/2429069.2429081
read: full-text
source: "Author-hosted POPL 2013 full text plus appendices, https://doi.org/10.1145/2429069.2429081"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "A universally quantified refinement type system is sound and relatively complete for safety of a higher-order functional language relative to first-order reasoning — predating counterexample-complete and canonical-input works and blocking a broad priority claim for relatively complete automated higher-order safety verification, though it proves or refutes one safety property rather than enumerating every exact first-order observation fiber."
---

# Automating Relatively Complete Verification of Higher-Order Functional Programs

## Evidence

### Evidence locations

- Sections 3.1--3.2, Theorems 3.6--3.7: a universally quantified refinement
  type system is sound and relatively complete for safety of the stated
  higher-order functional language, relative to first-order reasoning and the
  permitted pure instantiation expressions.
- Section 4 and Section 5: automated constraint generation and parameter
  inference realize a sound prototype, but practical restrictions on formula
  shape, instantiations, integer reasoning, and CEGAR make the implementation
  incomplete; two reported safe benchmarks remain unverified.

## Bearing on RQs

This predates the counterexample-complete and canonical-input works already in
the map and blocks a broad priority claim for relatively complete automated
higher-order safety verification.

## Evidence limits

It proves or refutes one safety property; it does not enumerate every exact
first-order observation fiber.
