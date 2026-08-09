# you2021higherorder — Sound and complete higher-order concolic testing

- **Status:** deep-read; canonical-input search comparator
- **Primary source:** https://doi.org/10.1007/978-3-030-72019-3_23
- **Version read:** author-hosted ESOP 2021 PDF, pp. 635--663
- **Bibliography key:** `you2021higherorder`

## Evidence locations

- Sections 2--4: canonical higher-order inputs evolve from observations made
  during concolic execution, including across concretized calls.
- Metatheory: concolic evaluation is sound relative to concrete evaluation.
- Completeness result: modulo concretization and SMT incompleteness, the search
  finds an error-triggering input whenever one exists.

## Relationship and evidence limit

Canonical input forms avoid an unstructured enumeration of higher-order values
while preserving bug-finding completeness under explicit qualifications. The
algorithm searches for a counterexample, not a duplicate-free partition of
all first-order caller inputs by an internal-event observer.
