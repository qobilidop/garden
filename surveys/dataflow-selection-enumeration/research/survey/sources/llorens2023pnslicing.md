# llorens2023pnslicing — Maximal and minimal dynamic Petri-net slices

- **Status:** screened; exact contribution-directed slicing boundary
- **Primary source:** https://doi.org/10.3233/FI-222148
- **Open author copy:** https://riunet.upv.es/server/api/core/bitstreams/ffec5931-9260-43aa-a25b-0946d967bfa7/content
- **Version read:** full journal article
- **Bibliography key:** `llorens2023pnslicing`

## Evidence locations

- Problem and algorithms: the slicing criterion is a set of places, and the
  algorithms isolate places and transitions that may contribute tokens to it.
- Maximal result: the maximal slice includes every node that may contribute in
  any computation and can reproduce every computation contributing tokens to
  a requested place.
- Minimal result: the minimal slice retains the nodes needed for a shortest
  transition sequence that contributes tokens; maximality and minimality are
  formally proved and compared experimentally with prior algorithms.

## Relationship and evidence limit

This is stronger and more target-like than one property-preserving Time
Petri-net slice because it gives explicit maximal/minimal contribution
guarantees relative to requested places. It returns a subnet, not a complete
partition of caller inputs by observed outcomes, and has no typed residual per
fiber.
