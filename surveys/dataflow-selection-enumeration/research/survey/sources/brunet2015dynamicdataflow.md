# brunet2015dynamicdataflow — Execution-trace graphs for dynamic dataflow

- **Status:** screened; expanded dissertation treatment
- **Primary source:** https://doi.org/10.5075/EPFL-THESIS-6663
- **Version read:** EPFL dissertation record and dissertation, Chapter 5
- **Bibliography key:** `brunet2015dynamicdataflow`

## Evidence locations

- Chapter 5: an execution trace graph is a directed acyclic graph whose nodes
  are action firings and whose edges encode dependencies among firings.
- Section 5.2.2: dependency kinds include token, port, internal-variable,
  finite-state-machine, and guard dependencies; guard enabling and disabling
  make input-dependent actor behavior explicit.
- Section 5.6: the graph supports post-mortem analysis and mapping of a dynamic
  program's feasible design space rather than exhaustive symbolic execution.

## Relationship and evidence limit

The dissertation is the fuller treatment of the 2013 guard-dependency paper.
It gives a precise concrete-run graph object and exposes selection causality,
but does not construct a complete partition of caller inputs or one typed
residual function for each observation fiber.
