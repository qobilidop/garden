# lin2020game — Symbolic execution game semantics

- **Status:** deep-read; bounded complete open-program semantics
- **Primary source:** https://doi.org/10.4230/LIPIcs.FSCD.2020.27
- **Version read:** open-access Dagstuhl primary full text
- **Bibliography key:** `lin2020game`

## Evidence locations

- Semantics: operational game semantics represents arbitrary external
  higher-order client behavior during symbolic execution.
- Main result: the symbolic semantics is sound and complete; the implemented
  exploration becomes finite by bounding recursion and callback depth.

## Relationship and evidence limit

This is a strong bounded-completeness result for higher-order open programs.
It enumerates interaction behavior under explicit depth bounds, not exact
first-order input fibers for a requested internal dataflow observer.
