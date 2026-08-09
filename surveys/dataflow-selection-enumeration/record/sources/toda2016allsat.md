# toda2016allsat — Implementing Efficient All Solutions SAT Solvers

- **Status:** deep-read
- **Primary source:** https://arxiv.org/pdf/1510.00523
- **Version read:** author manuscript corresponding to ACM JEA 2016
- **Bibliography key:** `toda2016allsat`

## Why it matters

The paper establishes model-and-block as a standard outer enumeration skeleton
and compares it to nonblocking traversal, partial-assignment simplification,
and on-the-fly OBDD construction.

## Enumerated and compiled objects

The broad AllSAT contract is a family of partial satisfying assignments whose
disjunction is equivalent to the CNF. Implementations differ materially:

- basic blocking emits total assignments;
- blocking plus heuristic simplification emits partial assignments;
- chronological nonblocking traversal emits total assignments; and
- formula–BDD caching builds one OBDD representing all assignments.

These are different output representations, not interchangeable measurements
of one explicit enumeration (Sections 3–5).

## Algorithms and complexity

Algorithm 2 repeatedly obtains and blocks one total model (pp. 9–11).
Simplification can compress exponentially many total models but exact minimum
simplification is expensive, so the implementation uses heuristics (pp.
12–13). Algorithms 3–6 give nonblocking traversal; Algorithm 7 constructs an
OBDD with caching (pp. 14–27).

OBDD size can approach an explicit solution list in the worst case. Variable
ordering and its preprocessing cost materially affect results. The paper gives
implementation and empirical comparisons, not OutputP, IncP, or
polynomial-delay theorems.

## Relationship to our hypothesis

Full-fiber blocking changes a concrete-model blocker into an exact
observation-fiber blocker, but retains the standard model-and-block skeleton.
The formula–BDD solver is a stronger shared-representation baseline. Empirical
comparisons must align output representation and include preprocessing,
serialization, time, and memory.

## Evidence locations

- Algorithm 2, manuscript pp. 9–11: blocking enumeration.
- Pages 12–20: partial simplification and nonblocking algorithms.
- Algorithm 7 and discussion, pp. 20–28: BDD caching and evaluation accounting.
