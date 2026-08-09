# sears2018observationpolicies — Observers from dynamic observation policies

- **Status:** screened; policy-relative observer construction
- **Primary source:** https://doi.org/10.1007/S10626-018-0272-2
- **Version read:** publisher abstract and theorem metadata
- **Bibliography key:** `sears2018observationpolicies`

## Evidence locations

- Observation model: whether an event is observed may depend on transitions or
  states rather than a fixed observable alphabet.
- Construction: the method builds a deterministic generator for the language
  of event sequences visible under the supplied observation policy.
- Exactness boundary: the paper states conditions for exact observer
  construction and a PSPACE-complete general check.

## Relationship and evidence limit

This is an explicit sparse, policy-relative observation object. It consumes a
discrete-event system and observation policy and returns an observed-event
generator; it does not partition symbolic caller inputs or pair fibers with
program residuals.
