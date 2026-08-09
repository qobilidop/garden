# capra2005colored — Colored Petri Nets State-Space Reduction via Symbolic Execution

- **Status:** primary-abstract screened; state-space quotient comparator
- **Primary source:** https://doi.org/10.1109/SYNASC.2005.26
- **Version inspected:** publisher and University of Milan repository metadata
- **Bibliography key:** `capra2005colored`

## Why it matters

Capra constructs a quotient reachability graph for an extended well-formed
colored-Petri-net syntax. Numerical encodings of color domains and linear
constraints permit symbolic state aggregation beyond static global symmetry.
This adds symmetry- and constraint-based reachability quotients to the map's
list of superficially similar symbolic partitions.

## Evidence locations

- Primary abstract: well-formed-net SRGs capture encoded symmetries and retain
  the information of ordinary reachability graphs.
- Primary abstract: the new quotient maps color domains to numerical domains
  and uses linear constraints as symbolic execution for asymmetric systems.
- Repository record: SYNASC 2005, pp. 231--238, DOI and asymmetric distributed
  algorithm comparison.

## Relationship and evidence limit

The object is a quotient of reachable Petri-net markings, not a partition of
caller inputs by requested internal events, and it carries neither typed
symbolic residuals nor requested-root demand. Only abstract- and metadata-level
claims are used here because the complete primary text was not openly
retrievable during the audit; no theorem-level inference is made.
