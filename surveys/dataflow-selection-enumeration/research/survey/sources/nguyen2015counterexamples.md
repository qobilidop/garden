# nguyen2015counterexamples — Relatively complete higher-order counterexamples

- **Status:** deep-read; higher-order symbolic-input comparator
- **Primary source:** https://doi.org/10.1145/2737924.2737971
- **Version read:** primary PLDI full text and arXiv 1411.3967
- **Bibliography key:** `nguyen2015counterexamples`

## Evidence locations

- Symbolic semantics: unknown higher-order functions are progressively
  decomposed into lower-order unknowns while first-order path conditions are
  retained for solver reasoning.
- Metatheory: evaluation is sound and counterexample generation is relatively
  complete modulo the base solver; successful symbolic results reconstruct
  concrete higher-order inputs.

## Relationship and evidence limit

This establishes relatively complete canonical symbolic search for functional
inputs. It seeks a counterexample rather than enumerating every first-order
observation fiber without duplication.
