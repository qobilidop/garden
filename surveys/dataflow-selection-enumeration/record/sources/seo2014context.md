# seo2014context — How We Get There

- **Status:** deep-read; context-guided concolic-search comparator
- **Primary source:** https://doi.org/10.1145/2635868.2635872
- **Version read:** author-hosted FSE 2014 PDF, pp. 413--424
- **Bibliography key:** `seo2014context`

## Why it matters

Context-guided search (CGS) records how an execution reached a candidate branch
and favors branches whose preceding context has not yet been tried. Dominator
analysis removes branches judged irrelevant to that context, and the algorithm
widens the considered context incrementally. It is direct precedent for using a
sparse observation of prior decisions to prioritize symbolic exploration.

## Evidence locations

- Abstract and Section 1: motivate branch-context novelty as a search policy.
- Section 3: defines branch context, removes dominator-irrelevant branches, and
  incrementally increases context depth.
- Section 4: implements CGS for CREST and CarFast.
- Sections 5--6: compare coverage and iteration counts on six C and six Java
  subjects.

## Relationship and evidence limit

CGS changes exploration order under a testing budget; it does not merge states
under a proved equivalence, enumerate a complete observer image, or emit exact
input fibers and residual values. Context is imperative path history rather
than requested-root structural reachability in a pure DAG.
