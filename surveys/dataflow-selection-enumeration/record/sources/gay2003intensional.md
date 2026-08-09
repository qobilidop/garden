# gay2003intensional — Intensional and extensional dataflow semantics

- **Status:** screened; close semantic-object boundary
- **Primary source:** https://doi.org/10.1007/S00165-003-0018-1
- **Version read:** primary publisher abstract and theorem summary
- **Bibliography key:** `gay2003intensional`

## Evidence locations

- Abstract: the synchronous Kahn semantics is extensional because it describes
  node functions; the categorical synchronous-process semantics is intensional
  because it describes stepwise output-token production from input tokens.
- Abstract equivalence result: under Wadge's cycle-sum condition, which ensures
  deadlock freedom, the two semantics are equivalent and extensional function
  composition is faithfully modeled by detailed intensional interactions.

## Relationship and evidence limit

This work makes the intensional/extensional boundary explicit within dataflow
program semantics. The intensional object records whole token-production
interactions. It does not define a requested-root-relative partial map of
selection-site outcomes or enumerate that map's exact caller-input fibers with
general residual values.
