---
citekey: geldenhuys2013bounded
work:
  title: "Bounded Lazy Initialization"
  author: "Jaco Geldenhuys, Nazareno Aguirre, Marcelo F. Frias, Willem Visser"
  venue: "NFM 2013"
  date: 2013
  doi: 10.1007/978-3-642-38088-4_16
read: full-text
source: "NFM 2013 author manuscript via https://doi.org/10.1007/978-3-642-38088-4_16, pp. 229--243"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Bounded lazy initialization explores a heap only as program field accesses demand it, filtering null/existing/fresh alternatives via precomputed relational field bounds and canonical labels — a demand-driven heap predecessor whose observer is an imperative execution path, not a site-indexed selection map"
---

# Bounded Lazy Initialization

## Evidence

### Why it matters

Bounded lazy initialization (BLI) explores a heap only as program field
accesses demand it. When an uninitialized reference field is read, it considers
`null`, an existing object, or a fresh object, but filters those alternatives
using precomputed relational field bounds and canonical labels. It therefore
precedes our work on access-relative omission, bounded completion, feasibility
pruning, and reuse of one partial state for many concrete heaps.

Its observer is nevertheless an imperative execution path over heap accesses,
not a site-indexed map of selected dataflow edges. It preserves the symbolic
heap and path condition needed for program analysis; it does not enumerate the
equivalence classes induced by a requested-root selection observer.

### Model and algorithm

The input is a Java heap of reference objects within a finite node scope. A
partially initialized heap contains concrete allocated nodes and reference
fields that remain symbolic until first access. Traditional lazy
initialization branches over all type-correct aliases, `null`, and a new node.

BLI obtains tight relational bounds from TACO for each field. A tuple in a
field bound denotes a source/target combination occurring in some valid
bounded structure. During first access to field $o.f$, the algorithm uses the
field label to retain only:

- `null` if the relevant bound permits it;
- existing allocated nodes whose canonical labels intersect the permitted
  target label; and
- a fresh canonical node when the bound permits a not-yet-allocated target.

Canonical breadth-first allocation prevents multiple isomorphic construction
orders from representing the same concrete structure. A second algorithm
incorporates this symmetry breaking into lazy initialization.

### Guarantee and boundary

The paper argues that pruning is sound because an omitted alternative does not
occur in any valid structure represented by the correct bounds. The later
BLISS paper supplies explicit soundness-and-completeness theorems for BLI and
its refinements relative to ordinary lazy initialization.

BLI can still generate a partial heap that has no valid total completion:
individual field labels are locally consistent with the bounds even when
their conjunction is globally inconsistent. This exact limitation motivates
RBLI and BLISS.

The algorithm is finite only under the user-selected heap scope. Its search
space remains combinatorial in the number of objects and reference fields; the
paper gives empirical counts and runtimes rather than output-sensitive or
polynomial-delay bounds.

### Evidence locations

- Sections 1--2, paper pp. 229--233: lazy initialization, TACO bounds, and
  redundant/isomorphic heaps.
- Section 3, pp. 233--239: field labels, two BLI algorithms, and pruning
  rationale.
- Section 4, pp. 239--240: implementation data structures.
- Section 5, pp. 240--242: empirical comparison and scaling limits.

## Bearing on RQs

Both algorithms avoid eagerly constructing data that the consumer has not
accessed. The correspondence stops there:

- BLI demand is a dynamic field read in an imperative program; our observed
  domain is enabled reachability from requested pure-graph roots.
- A BLI branch assigns one heap edge; a graph observation records the outcome
  of a selector whose chosen edge controls further reachability.
- An uninitialized BLI field denotes a set of heap completions; an absent
  observation coordinate says a particular graph site was not reached.
- BLI explores program paths and retains path conditions; it does not group
  all paths or inputs by equality of an observation map.
- Its relational bounds encode a separate representation invariant, whereas
  our guards are the exact inverse images of graph observations.

Encoding finite heaps and field reads into a pure selector graph would make a
bounded BLI exploration an implementation strategy for a specialized graph,
but BLI neither defines nor emits the resulting observation partition.

## Evidence limits

Read at full-text level from the NFM 2013 author manuscript; the note records
no limitations beyond the scope distinctions already given in Bearing on RQs
above.
