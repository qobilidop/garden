# Output-directed symbolic execution and path quotients

## Why this cluster is the closest semantic precedent

Four works reject syntactic path enumeration in favor of an observer tied to
symbolic values or outputs:

| Work | Observer and represented object | Redundancy avoided | Stated guarantee |
|---|---|---|---|
| `santelices2010dependencies` | queried variables; path families and path-family conditions | products of control subpaths outside the transitive control/data dependence of a queried use | exact mode is described as producing the same result as pathwise symbolic execution; no numbered end-to-end theorem |
| `qi2013output` | a postdominating slicing criterion; relevant slices, reordered relevant-slice conditions, and symbolic outputs | paths whose differences do not affect the observed output | exploration completeness for the finite set of relevant-slice conditions under a sound and complete solver |
| `denaro2012allvalues` | each program statement; guarded symbolic values | repeated traversal paths yielding an already known symbolic expression | algorithmic and experimental claim; no formal soundness or completeness theorem |
| `wang2017dependence` | collective symbolic values of statement instances; relevant path slices | paths not adding a unique symbolic value under a dependence approximation | conditional-abort fault-detection preservation under precise dependence and a decisive sound solver |

This cluster already establishes *output-directed exploration*, *value-directed
symbolic execution*, sparse relevant branch conditions, guarded residual
expressions, witnesses, and avoidance of independent path products. None of
those ideas can be claimed as new.

## The observer controls the quotient

These approaches do not discover one representation-independent notion of a
path. They choose an observer and collapse executions that it cannot
distinguish:

- PESO observes the symbolic expression at one or more slicing criteria.
- AVaSE observes symbolic values at program statements.
- SPD observes the values used at specified statements and constructs the
  dependence-relevant path families needed for them.
- DGSE approximates the ideal equivalence induced by the collective symbolic
  values of statement instances.

Our proposed selection observation chooses a different, explicitly
intensional observer: a partial map from contextually identified selection
sites to their selected outcomes, restricted to the enabled closure of
requested roots. It retains an observed site's outcome even when two arms yield
the same extensional output. It omits a nested site when its containing case is
not selected.

This distinction is real, but not automatically novel. Instrumenting every
selection site with a ghost unobserved-or-outcome value turns the structural
observer into an ordinary symbolic output. Output-directed exploration or
projected enumeration can then recover its image. The survey contribution is
to expose this observer change and its information consequences, not to claim
that observer-induced quotienting itself is new.

## Exact differences that remain useful

1. **One-way slice equivalence.** PESO proves that equal relevant-slice
   conditions imply equal symbolic output, but does not show that its
   conditions are the coarsest or canonical output quotient. Different RSCs
   may still yield the same output.
2. **Equal-value provenance.** AVaSE deliberately coalesces equal symbolic
   expressions. A selection observation retains distinct observed-site outcomes
   even when their residual values are equal.
3. **Dependence approximation.** SPD and DGSE use dependence to avoid irrelevant
   combinations. Potential and interactive dependence can conservatively
   retain distinctions that an exact semantic quotient would remove.
4. **Region object.** The closest works primarily enumerate tests, slices,
   guarded values, or path families. Our synthesis assigns every complete
   observation an exact input fiber and separates that totalized observation
   tuple from any shorter entailing cube.
5. **Graph identity and sharing.** Imperative statement instances and CFG paths
   do not directly settle whether a shared dataflow selection has one identity,
   how contextual calls are named, or how a reusable subgraph summary exposes
   only caller-observed events.
6. **Composition.** The papers provide intra-program exploration and some
   shared path-family graphs, not an exact subgraph-summary theorem equating
   modular and whole-graph observation enumeration. Established selective and
   relational semantics still make such a theorem a synthesis rather than an
   obvious novelty claim.

## Terminology consequences

Use established terms when the corresponding object is meant:

- *symbolic value* and *guarded symbolic expression*;
- *relevant slice* and *relevant-slice condition*;
- *path family* and *path-family condition*;
- *dependence-guided symbolic execution*;
- *value summary* and *state merging*.

Do not rename these objects “selection observations.” Reserve that local term
for the graph-intensional sparse site/outcome map. Say that a site is
*observed for* \((x,R)\) exactly when it belongs to the enabled closure;
“active selection” is neither established nor unambiguous in this cluster.

## Best motivating contrast

Use a nested graph in which an outer selector chooses between two cases, one
of which contains an inner selector, and make the outer cases return the same
ordinary value for at least one input region. The example simultaneously
shows:

- why the unobserved inner site must be absent rather than logically
  don't-care;
- why equal ordinary outputs do not determine the selection observation;
- why total assignments over every syntactic selector create a spurious
  Cartesian product; and
- why output-directed prior work can reproduce the distinction only after the
  structural observer is explicitly instrumented.

## Safe positioning statement

The formal synthesis is a taxonomy of observer-induced quotients. Ordinary
paths, output-relevant slices, guarded values, projected tuples, short cubes,
and graph-relative selection observations preserve different information.
For finite pure graphs, enabled-closure semantics, ghost-output
instrumentation, and projected enumeration give equivalent presentations of
the last object. This cross-community equivalence is useful exposition; its
ingredients and broad algorithmic consequences are prior art.
