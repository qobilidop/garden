# adobbati2024parametricreveals — Count-sensitive reveals on bounded equal-conflict nets

- **Status:** deep-read through the open preliminary version and author
  dissertation; count-sensitive observer and reduced-prefix boundary
- **Primary source:** https://doi.org/10.1007/978-3-662-68191-6_3
- **Primary institutional record:** https://boa.unimib.it/handle/10281/463658
- **Open preliminary version:** https://ceur-ws.org/Vol-3170/paper4.pdf
- **Author dissertation containing the expanded construction:**
  https://tesidottorato.depositolegale.it/bitstream/20.500.14242/74636/4/phd_unimib_764300.pdf
- **Open implementation:** https://github.com/MC3-lab/mscTree
- **Version evidence:** 2024 LNCS version of record, volume 14150,
  pp. 54--83. Its body is repository-restricted; the publisher abstract and
  reference list were checked against the complete 2022 PNSE preliminary and
  the first author's dissertation, Chapter 3. The final abstract states that
  its algorithm uses a smaller structure than preliminary reference [3].
- **Bibliography key:** `adobbati2024parametricreveals`

## Why it matters

The paper strengthens the retained transition-information-flow comparator in
two independent ways. It extends the net model from 1-safe free-choice nets to
bounded equal-conflict weighted P/T systems, and its observations retain
transition-occurrence counts rather than only the set of labels seen in a
maximal run. It therefore changes both the model boundary and the observer's
semantic object.

## Model and observer

The open formal development assumes a bounded, 1-live P/T system with a
T-restricted underlying net; the algorithmic results additionally require the
equal-conflict property. If two transitions share a pre-place in an
equal-conflict net, they have the same preset and input weights. Boundedness
makes the reachable-marking set finite, while absence of asymmetric confusion
lets maximal-step paths represent the relevant maximal configurations.

A configuration footprint is a multiset of transition labels: finite
multiplicities count occurrences and an infinite run may assign infinite
multiplicity. Extended-repeated reveals asks whether every maximal
configuration meeting each threshold `n_i` for transitions `t_i` contains some
transition from `Y`. Collective reveals instead thresholds the total number of
occurrences across a set `X`. These relations are defined only when some
maximal configuration satisfies the antecedent. Ordinary reveals,
extended-reveals, and repeated-reveals are special cases.

## Algorithms and guarantees

The preliminary paper's Definition 7 constructs the finite full prefix of the
maximal-step computation tree by cutting a path at its first repeated marking
(pp. 71--72). Algorithm 1 decides collective reveals by extending only prefix
paths that can still acquire needed `X` occurrences; Theorem 1 proves
correctness and Theorem 2 termination (pp. 73--76). Extended-repeated reveals
tracks one threshold per transition; the preliminary paper gives that
adaptation as a sketch (p. 76).

The final work adds the smaller query-relative construction documented in the
dissertation, Section 3.3.6, pp. 62--68. Algorithms 4--5 build `RMG_Y`: remove
maximal-step arcs containing a transition in `Y`, then recursively prune
nonoriginal dead ends so the remaining graph represents exactly the maximal
`Y`-free runs. Algorithm 6 operates on the full prefix of the `RMG_Y` tree and
searches for a path reaching the requested `X` count. The reduction assumes
the relation is already known to be defined; otherwise the unreduced algorithm
is needed to distinguish a true implication from an impossible antecedent.

## Complexity and evidence limits

The preliminary paper leaves complexity analysis and unbounded equal-conflict
nets as future work (p. 79). The dissertation proves ordinary reveals and
excludes PSPACE-complete for 1-safe nets (Chapter 3, Theorems 1--2,
pp. 37--38), but leaves the exact complexity of the other parametric relations
and general P/T systems open (p. 35). A full-prefix path has at most the number
of maximal-step-reachable markings plus one repeated marking, but branching can
be the product of the concurrently enabled conflict-group sizes (pp. 42--43).
The implementation experiments are preliminary and unoptimized (pp. 68--71),
so the smaller query-relative structure gives no general polynomial guarantee.

## Predecessor reconciliation and target boundary

`adobbati2022informationflowprefix` supplies the earlier 1-safe free-choice
full prefix, exact reveals/excludes procedures, and exhaustive set-valued
maximal-run footprints. The 2022 PNSE paper introduces the bounded
equal-conflict and count-sensitive generalization; the 2024 chapter is its
final expanded version and adds the reduced `RMG_Y` construction.

The domain remains whole-net maximal behavior, not symbolic caller inputs to a
requested pure-program result. The algorithms decide one selected implication
between transition-count predicates; they do not enumerate every observer
outcome, form exact inverse caller-input fibers, produce guards or witnesses,
or attach typed residual values.

## Evidence locations

- Final institutional record and publisher abstract: metadata,
  direct-predecessor statement, and smaller-structure claim.
- PNSE preliminary, Section 2 and opening of Section 3, pp. 62--65:
  assumptions and multiset footprints.
- PNSE preliminary, Definitions 4--5, pp. 67--68: extended-repeated and
  collective reveals.
- PNSE preliminary, Sections 4.1--4.2, pp. 69--72: maximal-step
  correspondence and finite full prefix.
- PNSE preliminary, Algorithm 1 and Theorems 1--2, pp. 73--76: procedure,
  correctness, and termination.
- PNSE preliminary, conclusion, p. 79: complexity and unbounded-net limits.
- Author dissertation, Section 3.3.6 and Algorithms 4--6, pp. 62--68:
  reduced `RMG_Y` construction and query-relative algorithm.
- Author dissertation, Section 3.3.7, pp. 68--71: implementation evidence.
