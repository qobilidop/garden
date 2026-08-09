# Model enumeration

Model enumeration reports every distinct satisfying object selected by a
formula and an observation contract. The shelf, by role:
[[phan2015-all-solution-satisfiability-modulo-theories]] (classic projected
All-SMT interface), [[avis1996-reverse-search-for-enumeration]] (parent-map
enumeration with output-sensitive specializations), and
[[spallitta2024-disjoint-projected-enumeration-for-sat-and-smt-without-blocking-clauses]]
(disjoint projected partial models without accumulated blockers).

## The observation contract determines what “all” means

Enumeration is never simply “return every model.” Phan and Malacaria designate
important Boolean variables whose feasible valuations define the outputs;
other theory values are sampled from one extending model. Spallitta et al.
separate relevant variables from existentially hidden ones, then permit a
partial model to omit relevant literals that are logical don't-cares. The
first contract emits complete projected tuples. The second may emit a much
smaller disjoint cover in which one cube represents many tuples.

Avis and Fukuda make the same dependency visible without logic. Their objects
must first be chosen as vertices of a connected search graph. Hyperplane-cell
enumeration reports strict sign vectors for open full-dimensional cells; it
does not report boundary faces. In every case, completeness is relative to an
explicit object set. Projection, shrinking, and excluding boundaries can each
reduce output, but they do so by different semantics.

## Duplicate avoidance belongs to the traversal

The simplest All-SMT loop emits a projected assignment and asserts its
negation. Its history is an ever-growing blocker database. Phan and Malacaria
also give a depth-first alternative that systematically assigns the important
variables and reuses an incremental solver stack. Spallitta et al. combine
that chronological frontier with CDCL conflict learning: the frontier prevents
repetition, while conflict analysis escapes barren regions. Their shrinking
limit preserves disjointness and termination; deleting beyond it can cycle.

Reverse search reaches the same architectural goal through a different
invariant. A deterministic local-search parent gives every nonroot object one
predecessor, so traversing the induced tree backward needs neither blockers
nor a visited set. This can be stronger than solver traversal when adjacency
and parent tests are cheap. It is inapplicable when the objects have no useful
connected neighborhood or canonical route to a root.

No-duplication is therefore not a final filtering pass. It can be encoded as
learned blockers, a chronological search boundary, or a unique-parent forest.
Each choice determines memory use, revisitation behavior, and which partial
outputs can safely be emitted.

## Output sensitivity must charge the representation

Avis and Fukuda obtain a genuine output-polynomial arithmetic bound and
input-polynomial working space for full-dimensional arrangement cells because
their LP adjacency oracle and parent relation are explicitly charged. The two
solver papers give convincing implementations but no corresponding OutputP or
polynomial-delay theorem. One API invocation of an All-SMT procedure can hide
many incremental satisfiability checks, and removing blocking clauses does not
make theory reasoning constant-time.

Partial models complicate comparison further. A solver that emits ten cubes
and one that emits a thousand complete assignments may represent the same set
of total models but not the same output object. A compiled diagram could share
still more structure while charging expensive preprocessing. Time per printed
record is meaningful only after the observer and serialization format are
fixed.

## What the shelf needs next

The missing pieces are the primary foundations for compiled decision diagrams
and the modern complexity theory of hard enumeration. They would let the shelf
compare three forms of reuse—shared compiled subgraphs, solver state, and
parent-map traversal—under one input/output cost model rather than by raw
model counts or wall-clock results alone.
