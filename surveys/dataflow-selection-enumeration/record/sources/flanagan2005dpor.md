# flanagan2005dpor — Dynamic partial-order reduction

- **Status:** deep-read; foundational schedule reduction
- **Primary source:** https://doi.org/10.1145/1040305.1040315
- **Version read:** primary POPL full text
- **Bibliography key:** `flanagan2005dpor`

## Evidence locations

- Algorithm and theorem: dependency information observed during execution
  constructs persistent backtracking choices so stateless model checking
  explores representative schedules while preserving reachable behaviors.

## Relationship and evidence limit

This is the foundational DPOR mechanism. It removes independent schedule
orders, not input assignments with identical requested dataflow observations.
