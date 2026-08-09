# tong2016observation — Observation-equivalent Petri-net generators

- **Status:** deep-read; exact observer-compilation comparator
- **Primary source:** https://doi.org/10.1109/TAC.2015.2496500
- **Version read:** author-hosted journal full text, pp. 2448--2462
- **Bibliography key:** `tong2016observation`

## Evidence locations

- Definitions 10--12: generators are observation equivalent when each firing
  sequence induces observations with the same consistent firing-sequence set;
  with a common net this also gives the same consistent-marking set.
- Conversion results: bounded labeled nets with arbitrary marking-output
  observations are compiled into equivalent adaptive-label generators, and
  conditions are given for equivalent ordinary labeled generators.

## Relationship and evidence limit

This is a direct formal precedent for changing an observation encoding while
preserving its exact inverse-consistency sets. It compares Petri-net sensor
structures, not enumeration algorithms, and attaches no dataflow residual.
