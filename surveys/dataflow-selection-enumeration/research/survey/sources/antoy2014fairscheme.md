# antoy2014fairscheme — Compiling a Functional Logic Language: The Fair Scheme

- **Status:** deep-read; critical close predecessor
- **Primary source:** https://doi.org/10.1007/978-3-319-14125-1_12
- **Extended version read:**
  https://web.cecs.pdx.edu/~antoy/homepage/publications/lopstr13/long.pdf
- **Bibliography key:** `antoy2014fairscheme`

## Why it matters

This is the closest operational predecessor found after the initial
functional-logic audit. It combines all of the following in one finite acyclic
term-graph setting:

- demand-directed reduction of only *needed* subexpressions;
- a fair queue intended to expose all nondeterministic result values;
- stable choice identifiers preserved through pull-tab copies; and
- finite sparse fingerprints of choice identifiers and chosen alternatives.

Those ingredients rule out novelty claims for sparse demand-populated
identifier-to-outcome records or fair exhaustive search over such records by
themselves. The distinction that remains is semantic: Fair Scheme fingerprints
record dynamically created program nondeterminism on paths to result values;
selection observations record deterministic, input-selected graph sites and
induce exact input fibers.

## Model and algorithm

The source is a limited-overlapping inductively sequential (LOIS)
constructor-based graph-rewrite system. Expressions are finite, acyclic,
single-root graphs with sharing. Nondeterminism is represented by binary choice
nodes. The compiler produces three deterministic mutually recursive target
procedures:

- `S` finds and executes one rewrite or pull-tab step;
- `N` normalizes a finite amount of an expression; and
- `D` manages a queue of live expressions, splitting a choice-rooted expression
  into its alternatives, yielding constructor values, discarding failures, and
  rotating unfinished work.

The paper's `needed` relation is result-directed. A node is needed for an
expression when every derivation to constructor-rooted form must derive that
node to constructor-rooted form; maximal operation-rooted subexpressions are
the roots of need. This is established semantic terminology, but it differs
from our graph-local enabled closure: constructor normalization and rewrite
redex discovery determine Fair Scheme demand.

## Choice identity and fingerprints

A fresh choice identifier decorates each dynamically created choice. A pull-tab
copy preserves its source identifier, so all copies denote one call-time choice.
The paper defines a fingerprint as a finite set

`{(c1,a1),...,(cj,aj)}` with each `ci` a choice identifier and
`ai` in `{1,2}`.

The fingerprint of a root-to-node path accumulates the alternative traversed at
each choice. It is inconsistent if it contains both alternatives for one
identifier. Each expression in the dispatch queue is associated with a
fingerprint, and inconsistent queue elements are discarded.

This is extensionally a finite partial map from choice identifiers to binary
outcomes. It is sparse because it contains only choices traversed on the path to
the queued expression. It is not exposed as a canonical result object, and the
paper does not prove that each consistent fingerprint is generated once or that
equal result values have equal fingerprints.

## Formal results and their exact scope

**Theorem 1 (Optimality).** One invocation of `S` terminates with a
replacement at a node needed for its operation-rooted argument; rewriting that
node to failure implies failure of the argument. “Optimal” therefore means
that every executed step is needed, not minimum total work, minimum delay, or
an output-sensitive enumeration bound.

**Theorem 2 (Correctness).** For every state `tk` of the simulated
pull-tabbing computation:

1. every source value remains reachable from `tk` by some consistent source
   computation; and
2. every value consistently reachable from `tk` is a source value.

This is soundness plus an existential value-preservation property. It does not
state that the single dispatch run eventually emits each value, much less that
it emits every fingerprint exactly once.

Section 5 explicitly labels **Strong Completeness** a conjecture. Its argument
reduces nondeterministic choices to subscripted orthogonal graph rewriting and
assumes that a needed-redex normalizing theorem for terms transfers to the
corresponding graph class. Thus the extended 2013 paper does not prove the
eventual-production claim that its informal discussion motivates.

The paper depends on Antoy's 2011 pull-tabbing theorem for preservation of
constructor values under consistent computation. Choice identifiers are
ignored in the intermediate simulation lemmas and reintroduced by filtering
inconsistent fingerprints.

## Complexity and implementation evidence

No asymptotic total-time, delay, queue-size, fingerprint-size, or
output-sensitive bound is proved. The implementation section gives qualitative
optimizations: reduce repeatedly at a known needed node for a bounded number of
steps and cache whether a constructor subtree is already a value. A fixed step
bound is used to preserve fairness.

The fair queue can contain several expressions sharing graph nodes. Distinct
queue elements may therefore perform the same or disjoint needed step, which
the paper notes creates parallelism. This is operational sharing, not a
compositional summary theorem.

## Relationship to selection observations

### Directly established

- finite sparse choice-ID/outcome fingerprints;
- dynamic identity stable through copied choices;
- demand-directed evaluation of needed graph subexpressions;
- value preservation for consistent pull-tabbing states; and
- needed-step optimality for the simple finite acyclic LOIS scheme.

### Not established

- static context-qualified identities for deterministic selection sites;
- symbolic input variables or feasible input regions;
- exact positive guard cylinders for a fingerprint;
- pairwise-disjoint input fibers or full-fiber blocking;
- duplicate-free enumeration of projected fingerprints;
- a literal-minimal fingerprint or guard; or
- compositional reuse across graph substitution.

The closest defensible correspondence is that a selection observation is a
projection of a demanded fingerprint in a guarded-choice *meta-encoding*. That
correspondence still requires a proof covering strictness, multi-way selectors,
assumptions, projection, and renaming of dynamic choice identities.

## Evidence locations

- Sections 2–3, pp. 2–13 of the extended version: LOIS graphs, need, failure,
  pull-tabbing, and target procedures.
- Section 4, pp. 13–18: call-tree simulation, Theorems 1–2, fingerprints, and
  inconsistent-path filtering.
- Section 5, pp. 18–21: the strong-completeness gap and conjecture.
- Sections 6–8, pp. 21–23: implementation, fairness, related work, and the
  bounded meaning of optimality.

## Questions and weaknesses

- Eventual production is claimed informally but left conjectural in this paper.
- Fingerprints are path annotations used for consistency, not enumerated
  quotient objects.
- Dynamic choice IDs are computation-local and only defined modulo fresh-name
  renaming.
- Full constructor normalization does not automatically match the strictness
  policy of an arbitrary dataflow graph.
- No nonredundancy or enumeration-complexity theorem is supplied.
