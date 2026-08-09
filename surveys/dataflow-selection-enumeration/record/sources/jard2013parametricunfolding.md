# jard2013parametricunfolding — Parametric-stopwatch symbolic unfoldings

- **Status:** deep-read; parametric-stopwatch symbolic-unfolding boundary
- **Primary source:** https://doi.org/10.1007/s10703-013-0188-2
- **Open repository record:** https://hal.science/hal-00840368
- **Author-manuscript full text:**
  https://hal.science/hal-00840368v1/document
- **Version read:** expanded 2013 journal article, *Formal Methods in System
  Design* 43(3), pp. 493--519; Section 1 identifies the ATVA 2010 chapter as
  its preliminary version
- **Bibliography key:** `jard2013parametricunfolding`

## Evidence locations

- The abstract and Section 1 define symbolic unfoldings for safe parametric
  stopwatch Petri nets. Stopwatch activation can suspend and resume a
  transition's accumulated activity, while interval bounds may contain
  parameters whose valuations are retained symbolically as linear
  constraints.
- Section 4, Theorems 1--2 and Definition 21 (author manuscript p. 14),
  establish correctness and completeness of time branching processes for
  ordinary safe Time Petri Nets and define their symbolic unfolding as the
  union of all valid time branching processes.
- Section 5, Definition 23 and Proposition 1 (pp. 15--16), define
  future-equivalence using the cut marking and reduced token ages and prove
  that corresponding extensions preserve validity and future-equivalence.
- Definition 26 and Theorems 3--4 (pp. 18--19) construct the maximal
  cut-off-free prefix. Theorem 3 proves every finite valid time process has a
  future-equivalent representative in that prefix; Theorem 4 proves that the
  prefix contains finitely many events.
- Section 6, Definition 27 (pp. 19--20), extends the model with stopwatch
  activator arcs and parametric firing intervals. Theorems 5--6 (pp. 26--27)
  transfer the correctness and completeness correspondence to the richer
  model, and Definition 33 (p. 27) defines its symbolic unfolding.
- Section 1 and the conclusion (p. 29) state the important boundary: the
  finite-complete-prefix result applies only to the safe ordinary Time Petri
  Net subclass. Known undecidability prevents such a finite complete prefix in
  the presence of stopwatches or parameters. For ordinary Time Petri Nets, the
  construction is more compact than the earlier Chatain--Jard method, avoids
  transition duplication, and does not introduce read arcs when the source
  net has none.

## Relationship and evidence limit

This changes the represented model boundary beyond the retained safe
Time-Petri-net prefix: symbolic unfolding covers stopwatch suspension and
parametric timing while preserving all valid timed processes. It also supplies
a different, more local finite-prefix construction for the ordinary Time Petri
Net subclass.

The article does not prove a finite complete prefix for parametric stopwatch
nets. Its equivalence and cut-off objects concern markings, token ages, timed
processes, and parameter valuations—not exact caller-input fibers of requested
internal selection observations or typed residual functions.
