# angerer2010schedule — Explicit happens-before schedule analysis

- **Status:** screened; static task-schedule abstraction
- **Primary source:** https://doi.org/10.1145/1869542.1869544
- **Version read:** primary abstract and metadata
- **Bibliography key:** `angerer2010schedule`

## Evidence locations

- Programming model: task scheduling constraints are explicit happens-before
  relations in the program.
- Analysis result: a static abstraction of the dynamic schedule determines
  whether two tasks execute sequentially, exclusively, or in parallel.

## Relationship and evidence limit

This is an intensional schedule observer over declared task constraints. It is
used for optimization and verification and does not enumerate symbolic caller-
input fibers or dataflow residuals.
