# xu2024spuriousdynamism — Balancing away spurious circuit dynamism

- **Status:** screened; successor dataflow-circuit optimization
- **Primary source:** https://doi.org/10.1145/3626202.3637570
- **Open author copy:** https://www.research-collection.ethz.ch/bitstreams/5ae51bd7-243d-417c-a131-839cbc64257c/download
- **Version read:** complete author copy
- **Bibliography key:** `xu2024spuriousdynamism`

## Evidence locations

- Sections 1--2: transient stalls and unsynchronized arrivals can make regular
  exchanges appear dynamically irregular and block handshake simplification.
- Method: linear programming selects latency and occupancy balancing that
  makes transfers more predictable and exposes removable protocol logic.
- Evaluation: alternative balancing choices provide explicit performance and
  area tradeoffs across degrees of retained dynamism.

## Relationship and evidence limit

This changes the optimization mechanism from proving generic behaviors absent
to transforming latency and occupancy so spurious behavior disappears. The
result is a simplified circuit, not an exhaustive observer image or inverse
input-fiber representation.
