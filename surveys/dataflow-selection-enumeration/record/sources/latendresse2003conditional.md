---
citekey: latendresse2003conditional
work:
  title: "Fast Symbolic Evaluation of C/C++ Preprocessing Using Conditional Values"
  author: "Mario Latendresse"
  venue: "CSMR 2003"
  date: 2003
  doi: 10.1109/csmr.2003.1192425
read: full-text
source: "SRI-hosted primary full text (pp. 170-179) via https://doi.org/10.1109/CSMR.2003.1192425"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "An early exact instance of computing guarded macro values without enumerating every feasible directive path, though its observer is preprocessing presence rather than a requested runtime selection-site map"
---

# Fast Symbolic Evaluation of C/C++ Preprocessing Using Conditional Values

## Evidence

### Evidence locations

- Representation and algorithm: nested conditional values bind macro names to
  alternatives guarded by compilation conditions, so symbolic preprocessing
  avoids enumerating every feasible directive path.
- Output contract: the algorithm computes exact conditions under which source
  lines are retained and exact conditional macro values at program points.

## Bearing on RQs

This is an early exact instance of computing guarded values without path
enumeration.

## Evidence limits

- The observer is preprocessing presence and macro value, not a requested
  runtime selection-site map, and the work does not enumerate caller-input
  fibers with residuals.
