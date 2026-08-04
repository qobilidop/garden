# scheurer2016lattice — A General Lattice Model for Merging Symbolic Execution Branches

- **Status:** deep-read; high-relevance supporting work
- **Primary source:** https://doi.org/10.1007/978-3-319-47846-3_5
- **Version read:** authors' ICFEM paper, https://www.key-project.org/wp-content/uploads/2016/12/SHB-General_Lattice_Model-2016.pdf
- **Bibliography key:** `scheurer2016lattice`

## Why it matters

The paper gives a general semantic framework for exact and abstract state
merging. It prevents us from claiming branch merging with guarded conditional
values as new, but it does not enumerate output observations or their fibers.

## Program and semantic model (RQ1, RQ7)

The formal setting is deterministic sequential Java in Java Dynamic Logic,
with partial-correctness proofs in KeY. A symbolic state is `(U,C,phi)`: an
update, remaining program (or program counter), and path-condition set.
Concrete states are paired with constraints, and concretization gives the
states represented by a symbolic state.

Only states at the same program counter are merged. The formal subset is
simplified and primitive-valued; KeY supports references, exceptions, and other
Java features. Loops require invariants or bounds. A chosen merge lattice must
satisfy the framework's semantic and signature-extension conditions.

## Mathematical object and merge algorithms (RQ2–RQ3)

The weakening order `s1 . s2` is concretization inclusion. At each program
counter, this order induces a join-semilattice. `SEL4` requires the lattice
order to imply weakening; `SEL5` permits only conservative signature extension
when merge procedures introduce Skolem symbols and constraints.

The generic merge pattern combines `joinVal` with generated constraints. Two
instantiations are developed:

- exact if-then-else merging, which retains conditional symbolic terms; and
- abstract/predicate merging, which joins values in an abstract-domain lattice
  and may forget distinctions.

## Guarantees (RQ4)

Proposition 1 establishes the semilattice properties for exact ITE merge, and
Proposition 2 for the abstract-domain construction. Theorem 1 proves merge
soundness: validity of the merged state implies validity of both input states.
Abstract merging is intentionally an overapproximation; the theorem does not
give completeness, an exact input partition, disjointness, or minimality.

## Residuals, witnesses, and sharing (RQ5)

Exact ITE terms are guarded residual values and may share subsequent execution.
The method does not enumerate observation records or attach one concrete witness
to each case. Branch identity survives only insofar as it remains in the merged
symbolic state.

## Complexity and performance (RQ6)

No worst-case asymptotic bound is given. The paper warns that ITE merging can
defer rather than eliminate exponential growth and may increase term and solver
cost. In KeY experiments, proof reductions reached roughly 80% for some
methods; `mergeAt` and `gallopLeft` reduced proof effort by about 77% and 71%.
Some exact-merge examples regressed, including `dist` and `ensuresCapacity`.
Predicate abstraction also requires expert predicate selection.

## Motivating example (RQ8)

In `dist`, a branch swaps two positive integers. Exact merging represents the
post-branch values by conditional terms; predicate abstraction retains only
chosen facts such as positivity. The example cleanly separates exact structural
merging from lossy semantic abstraction.

## Relationship to our hypothesis

### What is directly established by the work?

A general lattice account of sound symbolic-state merging, with exact ITE and
abstract-domain instances.

### What is our interpretation or inference?

A selection-observation record could be carried as part of an exact symbolic
state, while ordinary merging could erase provenance not included in that
state. The framework describes safe merging but does not choose our
observation, enumerate its fibers, or exploit dataflow demand.

### Could it subsume our proposed contribution?

It subsumes a general claim about sound branch merging. It does not subsume a
specific structural observation quotient, complete enumerator, exact guards,
or compositional observation summaries.

## Evidence locations

- Sections 2.1–2.3, Definitions 1–4: JavaDL symbolic and concrete states,
  concretization, and weakening.
- Section 3, Definitions 5–8 and Lemma 1: induced lattices and selection
  constraints.
- Section 4, Definitions 9–13, Propositions 1–2, and Theorem 1: exact and
  abstract merge instances and soundness.
- Section 5: KeY evaluation and performance tradeoffs.

