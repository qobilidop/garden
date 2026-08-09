# saarikivi2012dpor — DPOR for concolic testing

- **Status:** deep-read; concolic concurrency comparator
- **Primary source:** https://doi.org/10.1109/ACSD.2012.18
- **Version read:** primary conference full text
- **Bibliography key:** `saarikivi2012dpor`

## Evidence locations

- Algorithm: combine concolic path constraints with DPOR and exploit read
  commutativity and dynamic independence to avoid redundant schedules.
- Evaluation: reports schedule and test reductions for concurrent programs.

## Relationship and evidence limit

This omits schedule choices while retaining the relevant concurrent behavior;
it does not quotient caller inputs by internal dataflow selections.
