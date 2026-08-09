# gligoric2008delayed — On Delayed Choice Execution for Falsification

- **Status:** deep-read; critical demand-sensitive predecessor
- **Primary source:**
  https://infoscience.epfl.ch/server/api/core/bitstreams/fa02f0c5-b893-40a3-9522-1c074a9df2ff/content
- **Version read:** EPFL IC LARA-REPORT-2008-08, 19 pages
- **Bibliography key:** `gligoric2008delayed`

## Why it matters

This paper states the closest prior version of the motivating principle “do not
enumerate choices that the requested computation never observes.” It transforms
bounded-exhaustive guarded-command execution so a nondeterministic value remains
suspended until a non-copy use forces it. If no such use occurs, one delayed
execution represents all concrete values of that suspension.

The work predates our project and therefore blocks novelty claims for
demand-sensitive omission of unused input choices or for the exponential
reduction obtained by that omission. A delayed state containing concrete cells
and suspensions implicitly denotes a cylinder over the unforced choices. The
paper does not, however, define or export a stable site-to-outcome observation,
nor does it prove that those cylinders form an exact or maximal input-fiber
partition.

## Program and execution model

The source is an imperative guarded-command control-flow graph with visible and
invisible variables. Statements include reads, writes, copies, `assume`, and
bounded nondeterministic `getInt(a,b)`. The eager computation tree branches at
each `getInt` and contains every reachable state.

The delayed transformation replaces a nondeterministic write with a fresh shared
cell containing `Susp(a,b)`. A `force(x)` operation nondeterministically replaces
the suspension with one concrete value. Reads into visible variables force first;
copies between invisible variables copy the cell reference and do not force.
Shared cells provide call-by-need consistency across copies.

The paper deliberately calls a decision *forced* when execution requires a
concrete value. This is established and precise for its operational semantics.
Our term *observed* is preferable for the graph paper because membership in an
enabled closure is not implemented by a particular forcing machine.

## Correctness theorem

Let `alpha(c,d)` project a program state onto its control state and visible
variables. Section 3.3 moves each `force` down the eager tree across independent
statements, removes it before overwriting assignments, propagates it through
copies, coalesces duplicate forces, and stops immediately before a visible read.
Forces that reach leaves are removed.

The unnumbered theorem on p. 14 states that the eager and delayed trees have
exactly the same set of reachable `alpha`-projected states. This is a two-sided
extensional preservation theorem for the selected visible observer.

This is not a one-to-one correspondence between paths. Several eager concrete
paths may collapse into one delayed path. A leaf's forced cells and remaining
suspensions implicitly describe a concrete cylinder, but the theorem does not
attach a stable coordinate map to the leaf, prove that such cylinders are exact
or maximal fibers of the visible result, or enumerate one representative per
fiber.

## Path reduction and complexity

Moving `force` downward never increases the number of root-to-leaf traces. If
`K` distinct suspended choices with `N` outcomes are removed at leaves, Section
3.4 states that the delayed tree has an `N^K` path reduction. The ordered-bit
example contrasts exponentially many eager paths with polynomially many
delayed paths.

This is a structural reduction, not an output-sensitive enumeration bound. The
paper supplies no worst-case delay, total-space, or solver-call analysis. Its
implementation in Java PathFinder reports large empirical improvements for
red-black-tree generation, sorting, and several falsification benchmarks.

## Exact overlap with our motivating example

The sorting example stores keys and payload values in parallel arrays. The sort
compares keys but only copies payloads. Copy propagation therefore leaves every
payload suspension unforced, and exhaustive execution time is independent of the
payload-value bound. This is a direct precedent for omitting alternatives whose
values flow only through observationally irrelevant data.

The authors further state that if execution never forces a concrete assignment,
exploration proves the same result for all values of that variable, even values
outside the user-specified range. That is a qualitative universal don't-care
claim, not a symbolic formula for the input region.

Delayed choice nevertheless overpartitions our semantic observations whenever a
non-copy use needs a concrete value. If `x` ranges over `0..99` and is used only
by the selector `x < 50`, delayed execution forces and explores 100 values,
whereas our observer has two outcome fibers. If the result is `x + 1` and the
graph has no selection site, delayed execution again forces all 100 values;
our observer has one empty selection observation and retains `x + 1` as a
symbolic residual. The distinction is therefore not merely that we record more
metadata: we quotient used inputs by selection outcomes while preserving
ordinary symbolic computation within a fiber.

## Relationship to selection observations

### Directly established

- nondeterministic values can remain suspended until first non-copy use;
- copying preserves one shared delayed decision;
- invisible never-forced choices need not branch;
- visible reachable-state sets are preserved exactly; and
- eliminating `K` independent `N`-way leaf choices can reduce paths by `N^K`.

### Not established

- stable identifiers for syntactic selection sites;
- an emitted stable partial map of forced sites to outcomes;
- deterministic guards whose outcomes are selected by concrete inputs;
- exact positive-cylinder formulas for one observation;
- pairwise-disjoint fibers or conflict-frontier structure;
- duplicate-free observation enumeration; or
- compositional graph summaries.

Our algorithm can be viewed as lifting this paper's operational omission
principle into an explicit graph-intensional observable with exact inverse
images, while coarsening concrete forced values to semantic selection outcomes.
That is a legitimate synthesis, but the omission principle itself is prior art.

## Terminology

Established terms include *delayed choice*, *force*, *suspension*, *visible
variable*, *invisible variable*, *copy propagation*, *computation tree*, and
*bounded-exhaustive testing*. “Demand” appears informally through when a value is
used; the formal event is `force`.

## Evidence locations

- Sections 1–2, pp. 2–9: guarded-command falsification, bounded-exhaustive
  testing, first-use choice, and motivating examples.
- Sections 3.1–3.2, pp. 9–12: eager and delayed semantics, shared suspension
  cells, and the source transformation.
- Section 3.3, pp. 12–14: projection theorem and removal of leaf choices.
- Section 3.4, p. 14: trace monotonicity and `N^K` reduction.
- Section 4, pp. 14–16: Java PathFinder evaluation.
- Sections 5–6, pp. 16–18: relationship to lazy initialization, lightweight
  symbolic execution, and the universal never-forced-value observation.

## Questions and weaknesses

- Correctness is stated for the set of visible states, not complete trace
  equivalence or a stable decision observer.
- The implementation explores concrete forced choices without path conditions
  or feasibility solving.
- The report credits Korat with an implicit delayed-choice mechanism and relates
  generalized symbolic execution and Kiasan to first-access or first-use lazy
  initialization; its own contribution is the generic guarded-command
  transformation and projected-state preservation proof.
- Imperative control state, heap mutation, and bounded test inputs differ from
  finite pure dataflow evaluation.
- A removed force collapses values but does not produce a guard describing the
  collapsed concrete-input class.
