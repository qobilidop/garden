# thomson2015lazy — Lazy happens-before equivalence

- **Status:** screened; mutex-insensitive schedule-state relation
- **Primary source:** https://doi.org/10.1145/2688500.2688533
- **Version read:** official ACM abstract and author-hosted full preprint
- **Bibliography key:** `thomson2015lazy`

## Evidence locations

- Abstract and construction: lazy happens-before omits mutex-induced edges to
  define a more precise state-equivalence relation than ordinary
  happens-before for systematic concurrency testing.
- Evaluation: the paper reports the potential for additional schedule
  reduction on 79 Java benchmarks.

## Relationship and evidence limit

This is another exact observation choice about which events matter to a
quotient, but its coordinate is a concurrent schedule and reached state. The
short paper does not define caller-input fibers or attach dataflow residuals.
