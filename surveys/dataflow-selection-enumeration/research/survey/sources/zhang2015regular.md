# zhang2015regular — Regular Property Guided Dynamic Symbolic Execution

- **Status:** deep-read; event-property-guided search comparator
- **Primary source:** https://doi.org/10.1109/ICSE.2015.80
- **Version read:** author-hosted ICSE 2015 PDF, pp. 643--653
- **Bibliography key:** `zhang2015regular`

## Why it matters

The requested property is a finite-state machine over program events. The
method combines the event history of the current execution with a static
over-approximation of future events to rank off-path branches by their chance
of reaching an accepted event sequence. This is an explicit requested-event
observer controlling symbolic exploration.

## Evidence locations

- Sections I--II: define regular-property event traces and accepted paths.
- Section III.A: statically computes future event reachability.
- Section III.B: combines history and future FSM states in the branch
  evaluation function.
- Section IV: evaluates 13 Java programs and reports time to the first accepted
  path, not exhaustive observer enumeration.

## Relationship and evidence limit

The method prioritizes a target path and may still explore irrelevant paths; it
does not emit every event sequence or its exact input fiber. Its event-FSM
observer nevertheless rules out broad novelty for requested-event-guided path
selection.
