# latendresse2003conditional — Conditional-value preprocessing

- **Status:** deep-read; exact conditional-value predecessor
- **Primary source:** https://doi.org/10.1109/CSMR.2003.1192425
- **Version read:** SRI-hosted primary full text, pp. 170--179
- **Bibliography key:** `latendresse2003conditional`

## Evidence locations

- Representation and algorithm: nested conditional values bind macro names to
  alternatives guarded by compilation conditions, so symbolic preprocessing
  avoids enumerating every feasible directive path.
- Output contract: the algorithm computes exact conditions under which source
  lines are retained and exact conditional macro values at program points.

## Relationship and evidence limit

This is an early exact instance of computing guarded values without path
enumeration. The observer is preprocessing presence and macro value, not a
requested runtime selection-site map, and the work does not enumerate caller-
input fibers with residuals.
