# ahmed2017quebs — Qualifying Event Based Search

- **Status:** deep-read; event-triggered bounded-search comparator
- **Primary source:** https://doi.org/10.1109/ICCD.2017.36
- **Version read:** author-hosted ICCD 2017 PDF, pp. 185--192
- **Bibliography key:** `ahmed2017quebs`

## Evidence locations

- Section III: bounded DFS is exhaustive only within the unrolling bound.
- Section IV and Algorithm 1: QUEBS caps how often each branch may be selected
  and resets the other caps when a qualifying event occurs.
- Section IV: the evaluated qualifying event is coverage of a previously
  unexplored branch.
- Sections V--VI: RTL validation experiments and coverage results.

## Relationship and evidence limit

QUEBS is explicit event-relative postponement for RTL concolic testing. Limits
trade exhaustive bounded search for coverage efficiency and can later relax;
the method does not identify exact semantic equivalence classes or enumerate
input fibers.
