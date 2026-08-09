# hampapuram2005pathsimulation — Symbolic path simulation for dataflow

- **Status:** screened; path-feasibility service for dataflow analysis
- **Primary source:** https://doi.org/10.1145/1108768.1108808
- **Version read:** primary abstract and publication metadata
- **Bibliography key:** `hampapuram2005pathsimulation`

## Evidence locations

- Construction: a reusable symbolic path-simulation engine is wrapped for a
  client analysis and computes path-feasibility information.
- Application: global path simulation improves the precision of ESP's path-
  sensitive interprocedural dataflow analysis on C and C++ systems code.

## Relationship and evidence limit

This is a direct symbolic-dataflow integration precedent. It answers
feasibility queries for analysis paths rather than enumerating a disjoint
requested-event image and its caller-input fibers.
