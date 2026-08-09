# boyapati2002korat — Korat

- **Status:** deep-read; critical predicate-demanded enumeration predecessor
- **Primary source:** https://doi.org/10.1145/566172.566191
- **Version read:** ISSTA 2002 paper, pp. 123--133
- **Open copy:**
  https://mir.cs.illinois.edu/marinov/publications/BoyapatiETAL02Korat.pdf
- **Bibliography key:** `boyapati2002korat`

## Why it matters

Korat exhaustively generates every bounded nonisomorphic input satisfying an
executable Java predicate. Its central optimization monitors exactly which
candidate fields the predicate reads. When the predicate returns without
reading the remaining fields, the answer is independent of their values, so
backtracking skips or bulk-processes the entire unread suffix.

This predates both Lazy SmallCheck and our project. It defeats broad claims of
first consumer-access-guided exhaustive generation, first use of partial
candidate information to prune a finite Cartesian product, or first
nonredundant bounded enumeration driven by an executable observer.

## Finitized input domain

A **finitization** gives a finite domain for every field of every allocated
object: a finite number of objects per class, finite primitive ranges, and the
permitted class domains (plus `null`) for reference fields. After allocation,
a candidate is a vector of field-domain indices. Thus the raw domain is the
Cartesian product of all field domains; for the paper's $n$-node binary-tree
example it has $(n+1)^{2n+1}$ candidates.

The executable predicate is usually `repOk`, a representation invariant, but
Korat wraps arbitrary multi-argument preconditions into the same interface.
The required search property is Boolean acceptance of a complete candidate.

## Access-guided search

Instrumentation records fields in order of first access during one predicate
execution. After the predicate returns, Korat backtracks on this dynamic field
ordering rather than on all vector positions:

- if the predicate returns `false`, every candidate with the same accessed
  field values also returns `false`, so all assignments to unread fields are
  skipped;
- if it returns `true`, every candidate with the same accessed values is valid,
  and Korat outputs the nonisomorphic members represented by the unread suffix;
  and
- the next candidate changes the last accessed field with a remaining domain
  value, resets later accessed fields as needed, and repeats.

This is a dynamic dependency trace. A naturally short-circuiting predicate can
reject a bad prefix after reading few fields; a predicate that reads everything
before returning yields little or no pruning.

## Completeness and symmetry

For deterministic predicates, field-access pruning does not remove any valid
candidate because values not read during the execution cannot influence its
Boolean answer. The search enumerates every bounded satisfying input while an
isomorphism optimization retains only the lexicographically least candidate in
each rooted object-graph isomorphism class.

The paper states a weaker three-part guarantee for nondeterministic predicates:
inputs on which the predicate always returns true are generated; inputs on
which it always returns false are not; inputs with varying answers may or may
not be generated. Our pure deterministic setting avoids that caveat.

Korat's isomorphism quotient is over renamings of allocated object identities,
not over equal predicate access traces or equal graph-selection observations.
Two nonisomorphic valid structures remain separate even if the predicate reads
the same fields and returns the same result.

## Complexity boundary

The worst case remains the full field-domain product when the predicate reads
every field. The paper gives exact raw-space formulas and empirical candidate,
state, time, and output counts, but no OutputP, IncP, DelayP, or general
predicate-query bound in terms of emitted valid structures. Canonicalization
avoids object-identity permutations; its benefit depends on the heap symmetry.

The empirical conclusion is that access-guided backtracking supplies the main
pruning and symmetry breaking mainly reduces the number of valid structures.
This is evidence, not a worst-case separation theorem.

## Relationship to selection-observation enumeration

Korat's observer is one Boolean predicate. Its dynamic read set is used to
accelerate exhaustive generation, but it is not part of the emitted semantic
result. Korat outputs concrete valid inputs; it does not output a partial record
standing for all unread-field completions.

One can nevertheless reduce a fixed observation-fiber query to Korat on a
finite structural domain: define

\[
  repOk_o(x)\equiv \Omega_{G,R}(x)=o.
\]

Korat will enumerate every bounded concrete input in that fiber, pruning
unread input components. This presupposes $o$ and repeats work across
observations; it does not enumerate the observer image, combine all fiber
members into one exact symbolic guard, or compute a symbolic residual.

The two omission mechanisms are also different:

- an unread Korat field is an input coordinate whose values cannot change the
  current Boolean answer;
- an unobserved selection site is an internal graph-event coordinate outside
  the requested enabled closure; and
- an input may influence an ordinary symbolic residual without inducing any
  selection observation at all.

Korat is therefore a direct predecessor for the search principle, not a direct
subsumption of the result type. The safe statement is:

> Predicate-access-guided bounded exhaustive generation is established by
> Korat. Our formal synthesis changes the quotient key and emitted artifact,
> not the general principle of refining or backtracking only on accessed data.

## Evidence locations

- Abstract and Section 1, paper pp. 123--124: complete nonisomorphic bounded
  generation and access-guided pruning.
- Sections 3.1--3.2, pp. 126--127: finitization, candidate vector, and raw
  product size.
- Section 3.3, pp. 127--128: dynamic field ordering, unread-field pruning,
  valid-candidate handling, and nondeterministic-predicate guarantee.
- Section 3.4, pp. 128--129: rooted object-graph isomorphism and canonical
  representative generation.
- Section 5, pp. 130--132: empirical candidate counts and pruning attribution.

## Assumptions and limitations

- Exhaustiveness is relative to a user-supplied finite finitization.
- The principal guarantee assumes deterministic predicate executions.
- Correctness relies on complete instrumentation of transitive field accesses.
- The output is concrete valid inputs, not a disjoint symbolic partition.
- No exact guard, symbolic residual, stable selection-site identity, or
  one-record-per-access-pattern contract is defined.

