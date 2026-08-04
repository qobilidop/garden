# palmer2020demand — Higher-Order Demand-Driven Symbolic Evaluation

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1145/3408984
- **Version read:** PACMPL full paper
- **Bibliography key:** palmer2020demand

## Why it matters

DDSE provides a formal, context-sensitive demand-driven symbolic evaluator for
higher-order functional programs. Its relative call stacks and contextual
variables are strong antecedents for dynamic occurrence naming.

## Program and semantic model

The language is a closed, alpha-renamed ANF call-by-value functional language.
Every clause has a unique defining variable; conditional arms begin with
explicit branch-label clauses. Concrete reverse lookup starts at a target clause
and walks backward to the definitions required to explain a value.

## Main definitions

Definitions 3.2–3.3 define deterministic concrete lookup using a lookup stack
and dynamic call-context stack. Definitions 4.1–4.3 introduce relative stacks,
stack-qualified symbolic variables, a global satisfiable constraint, and a path
map for possible call sites.

## Results and guarantees

The symbolic lookup relation is deterministic for fixed constraint and path
map. The proof development relates relative stacks to concrete stacks,
eliminates the path oracle, and establishes correspondence between symbolic and
concrete lookup. Theorem 4.13 proves test generation sound and complete
relative to concrete demand lookup.

## Algorithm

A breadth-first promise/worklist search explores reverse proof obligations and
call-site choices, accumulating symbolic constraints. A satisfying model gives
an input reaching the chosen target clause.

## Complexity

Finding the necessary constraint and path map is recursively enumerable but
not decidable in the higher-order language. The paper notes that naive recursive
lookup can be exponential and uses caching in the implementation.

## Terminology

Here *demand-driven* means reverse lookup from a target program clause, not
result observation of a finite dataflow graph. Other established terms include
*contextual variable*, *relative stack*, *path map*, *lookup stack*, and
*symbolic backwards execution*.

## Motivating example

Lookup begins from a target result, skips unrelated earlier definitions, enters
and exits function calls using context stacks, and accumulates just the
constraints needed to derive the demanded value and reach the program start.

## Relationship to our hypothesis

### What is directly established by the work?

Demand-guided symbolic evaluation can be formalized for functional programs,
with contextual call identities, models, and a soundness/completeness proof.

### What is our interpretation or inference?

Branch labels and contextual proof paths could be instrumented to record active
branch outcomes. The native query is nevertheless reachability of one target,
not exhaustive equivalence classes under an output observer.

### Could it subsume our proposed contribution?

It subsumes broad claims about functional demand-driven symbolic evaluation and
context sensitivity. Finite total term graphs permit a decidable exact
partition that the general higher-order setting does not.

## Evidence locations

- Definitions 3.1–3.3 and Lemma 3.4, pp. 102:8–11: program and concrete lookup.
- Definitions 4.1–4.5, pp. 102:14–17: symbolic context machinery.
- Lemmas 4.6–4.12 and Theorem 4.13, pp. 102:17–19: model extraction and
  correctness.
- Appendix Theorem C.41, p. 102:53: forward reachability equivalence.

## Questions and possible weaknesses

- Its use of “demand” should not be imported without qualification.
- Effects, divergence, and call-by-value reachability make skipped computation
  semantically different from an inactive cone in a total pure graph.
