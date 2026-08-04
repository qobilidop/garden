# guo2015assertion — Assertion-guided symbolic execution

- **Status:** deep-read; assertion-relative pruning comparator
- **Primary source:** https://doi.org/10.1145/2786805.2786841
- **Version read:** author-hosted ESEC/FSE 2015 PDF, pp. 854--865
- **Bibliography key:** `guo2015assertion`

## Evidence locations

- Sections 2--3: summarize why prior executions cannot reach an assertion
  failure and use subsumption to prune later executions.
- Correctness development: pruning preserves reachable error locations under
  the stated symbolic-execution assumptions.
- Sections 4--5: Cloud9 implementation and multithreaded C/C++ evaluation.

## Relationship and evidence limit

The preserved observer is reachability of a selected assertion failure. The
method soundly removes executions for that property, but neither enumerates all
observer values nor returns their exact caller-input fibers and residuals.
