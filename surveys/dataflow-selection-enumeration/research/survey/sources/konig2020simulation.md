# konig2020simulation — empirical capped same-action enumeration

- **Status:** deep-read; empirical companion to the exact first-action
  projection baseline
- **Primary source:** https://arxiv.org/abs/2009.08332
- **Version read:** arXiv v1, submitted 17 September 2020
- **Bibliography key:** `konig2020simulation`

## Why it matters

König and Mönnigmann compare regional predictive-control techniques and
implement the same-first-action construction of `konig2020common`. The method
enumerates active-set polytopes whose full-horizon solutions differ but whose
selected active subset determines the same requested feedback law. It is a
direct empirical use of output-relative decision-history quotienting and
therefore meets the survey's close-competitor trigger.

## Algorithmic status

The implementation explicitly caps the number of polytopes and calls the
result heuristic. It reports feedback-law reuse and computation-time changes
over sampled systems, with strong dependence on the system and cap. The paper
adds comparative and hardware evidence, not a new semantic theorem.

In particular, it does not prove that its same-subset groups are the maximal
kernel classes of the first-action function, enumerate every group, eliminate
duplicates, or satisfy an output-sensitive, delay, space, or bit-complexity
bound. Its conclusions favor other regional techniques in the reported
comparison.

## Evidence locations

- PDF p. 4: construction, polytope cap, and heuristic qualification.
- PDF p. 8: mean reuse and timing results under the experimental sample.
- PDF p. 12: comparative conclusion.
- PDF pp. 14--15: citation of the companion exact-result paper.

## Relationship to selection observations

The method deliberately forgets optimization histories that share one
requested output action. It neither observes an input-dependent set of graph
sites nor retains equal-valued internal selection events, so it changes no
claim about the graph-relative observer.
