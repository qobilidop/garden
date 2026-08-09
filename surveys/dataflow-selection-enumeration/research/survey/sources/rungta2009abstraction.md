# rungta2009abstraction — Abstraction-guided concurrent testing

- **Status:** deep-read; target-abstraction search comparator
- **Primary source:** https://doi.org/10.1007/978-3-642-02652-2_16
- **Version read:** primary paper, pp. 174--191
- **Bibliography key:** `rungta2009abstraction`

## Evidence locations

- Method: backward slicing from a selected assertion builds an abstraction that
  ranks thread and data nondeterminism toward the target.
- Refinement loop: expands the abstraction when guidance no longer progresses.
- Evaluation: reports error-finding improvements on concurrent programs.

## Relationship and evidence limit

The abstraction is a target-directed exploration heuristic, not an equivalence
quotient or complete enumeration of the target observer's input preimages.
