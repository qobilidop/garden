# bergenthum2009unfolding — Token-flow unfolding semantics

- **Status:** screened; complete redundancy-reduced unfolding boundary
- **Primary source:** https://doi.org/10.3233/FI-2009-134
- **Primary institutional record:** https://opus.bibliothek.uni-augsburg.de/opus4/frontdoor/index/index/docId/56117
- **Author-hosted conference precursor:** https://www.fernuni-hagen.de/sttp/docs/2008atpnunfolding.pdf
- **Version read:** full journal article; metadata cross-checked against the
  University of Augsburg record
- **Bibliography key:** `bergenthum2009unfolding`

## Evidence locations

- Section 1 identifies token individualization as the source of redundant
  isomorphic processes and runs in standard unfoldings; in the worst case it
  increases the event count exponentially at every unfolding depth. The paper
  introduces token-flow and reduced token-flow unfoldings for general marked
  place/transition nets.
- Section 3.1, Definitions 3.1--3.4 represents branching behavior as a prime
  event structure whose left-closed consistency sets carry token flows.
  Strongly identical conflicting events are omitted. Lemma 3.2 establishes a
  unique maximal token-flow unfolding up to isomorphism, and Theorem 3.1 shows
  that every process is represented by a left-closed consistency set.
- Theorem 3.2 confines duplicate isomorphic processes to strongly identical
  events that can occur concurrently. Corollary 3.1 therefore gives a
  one-to-one correspondence between consistency sets and process-isomorphism
  classes when the net has no auto-concurrency.
- Section 3.2 further omits weakly identical events. The resulting reduced
  unfolding retains an example token-flow distribution per consistency set and
  represents every underlying run rather than every process; without
  auto-concurrency, its consistency sets correspond one-to-one to
  run-isomorphism classes.
- Section 4, Definitions 4.2--4.4 adapts cutting contexts, completeness, and
  canonical prefixes to token-flow unfoldings. Corollary 4.3 equates finiteness
  of the token-flow and standard canonical prefixes, Theorem 4.1 proves the
  token-flow prefix complete with respect to its cut-off events, and Theorem
  4.2 proves that the proposed algorithm computes that prefix whenever it is
  finite. The bounded-net, local-configuration, and marking-equivalence setup
  supplies the stated finite-prefix case; the reduced construction inherits
  the analogous results.
- Sections 5--6 report substantially smaller prefixes and faster construction
  in many cases, but retain an important tradeoff: the consistency-set family
  can be exponential, and redistribution checks can make the reduced algorithm
  slower unless it omits many isomorphic runs. For safe nets, both new models
  coincide with the standard unfolding.

## Relationship and evidence limit

This extends the token-flow semantic framework with an explicitly complete,
redundancy-reduced representation of all Petri-net processes or runs and
constructive finite-prefix guarantees. It is closer to exhaustive sparse case
enumeration than a token-flow language alone, but its domain and quotient are
whole Petri-net executions. It neither partitions caller inputs by outcomes at
requested internal sites nor attaches an exact input-fiber guard and typed
residual function to each observation.
