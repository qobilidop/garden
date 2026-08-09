# arras2016dkpn — Composite dataflow/Kahn execution

- **Status:** screened; heterogeneous execution-model boundary
- **Primary source:** https://doi.org/10.1109/PDP.2016.34
- **Open author copy:** https://www.labri.fr/perso/ejeannot/publications/euromicro16.pdf
- **Version read:** complete author copy
- **Bibliography key:** `arras2016dkpn`

## Evidence locations

- Abstract and Section III: DKPN separates dataflow controllers from Kahn
  filters and supplies composition semantics for the two spaces.
- Section III-A: a firing is externally atomic while its computation phase
  executes continuously under KPN semantics.
- Section III-C: hierarchical refinement and clustering preserve the external
  interface and controller, yielding the same external firing semantics.

## Relationship and evidence limit

DKPN is a concrete mixed-model execution boundary with dynamic parameters and
hierarchy. Its object is a schedulable streaming implementation, not an exact
partition of caller inputs by requested internal observations.
