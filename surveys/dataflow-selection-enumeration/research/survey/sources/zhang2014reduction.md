# zhang2014reduction — Coverage-preserving seed reduction

- **Status:** deep-read; coverage-observer preprocessing comparator
- **Primary source:** https://doi.org/10.1145/2610384.2610392
- **Version read:** author-hosted ISSTA 2014 PDF, pp. 160--170
- **Bibliography key:** `zhang2014reduction`

## Evidence locations

- Section 2: defines a reduced test suite as a subset retaining the original
  suite's statement coverage.
- Workflow step 2: uses coverage-based cause reduction and delta debugging
  before seeded symbolic exploration.
- Prioritization: orders the surviving tests to maximize coverage rate.
- Evaluation: measures symbolic-execution improvement after preprocessing.

## Relationship and evidence limit

The deleted seed components preserve one requested coverage observation, but
the reduction occurs before symbolic exploration. It is neither a quotient of
symbolic executions nor an exact enumeration of program-observer input fibers.
