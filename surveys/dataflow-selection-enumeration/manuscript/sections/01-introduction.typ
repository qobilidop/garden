= Introduction <sec-introduction>

Consider a finite, typed, acyclic, deterministic pure dataflow graph containing
nested conditionals, multiplexers, priority selectors, or other finite choice
operators. Its primitives are total on their typed domains. A caller supplies
an input from a declared domain and requests one or more graph results. The
problem of this survey is:

#align(center)[
  _Enumerate every distinct selection observation induced by the requested
  results, exactly once, together with its exact input guard, residual value,
  and a witness._
]

A _selection observation_ records the contextual outcome of each selection
site reached from the requested roots through declared operand dependencies and
selected case edges. It is sparse because a site in an unselected case cone is absent,
not merely assigned an unconstrained value. Its inverse image in the caller
domain is an _observation fiber_. An exact enumerator returns one record

$
  ("observation", "guard", "residual", "witness")
$

per nonempty fiber. The guard denotes precisely that fiber; the residual
computes the requested values throughout it; and the witness demonstrates
feasibility.

This task is easy to misidentify. A monolithic symbolic value describes output
semantics but does not enumerate structural observations. A path records a
control-flow history rather than the enabled portion of an arbitrary shared
graph. A projected model fixes selected logical coordinates but needs explicit
reachability instrumentation to represent structural absence. A partial cube may
cover several complete observations. A geometric region can give an exact
guard and affine residual while quotienting equal behavior or assuming that
every site is observed. These objects can look alike while answering different
questions.

The survey therefore separates three choices that are often conflated:

- the _observer_, which determines when two inputs belong to the same record;
- the _enumeration mechanism_, which discovers all nonempty fibers; and
- the _representation_, which stores guards, residuals, witnesses, and shared
  structure.

This separation makes established approaches directly comparable. Projected
AllSMT enumerates selected finite coordinates @phan2015allsmtr and can emit
disjoint partial covers @spallitta2024disjoint @spallitta2025projected.
Multi-path symbolic execution supplies guarded residual values
@sen2015multise. Functional-logic search maintains demand-populated maps with
stable choice identities @brassel2007tighter @brassel2011thesis, and Lazy
SmallCheck refines only the input fragments demanded by a Boolean observer
@runciman2008smallcheck. Decision trees and diagrams compile finite observer
functions @bryant1986bdd @bahar1997add. Hyperplane and parametric methods give
stronger output-sensitive enumeration results for affine special cases
@avis1996reverse @jones2006parametric. None of these names alone specifies the
selection-observation problem; the comparison depends on the observer and
contract attached to the method.

The paper answers four questions:

- *RQ1:* What common terminology precisely defines selection-observation
  enumeration and distinguishes it from neighboring tasks?
- *RQ2:* Which established approach traditions or routes can enumerate, compile, or
  specialize the required fibers, and what instrumentation do they require?
- *RQ3:* Which correctness, representation, and complexity guarantees does
  each route provide under its stated assumptions?
- *RQ4:* Where do the approaches coincide, where do they compute a refinement
  or quotient of the target observer, and where do they address only an
  adjacent reduction problem?

The contribution is consequently a problem-centered survey and unified
framework:

- A finite selective-term-graph model defines requested-root enabled closure,
  contextual site identity, sparse observations, exact fibers, and the output
  record contract.
- An observer-refinement order distinguishes structural non-observation,
  existential projection, logical don't-care, and equal-behavior quotienting
  without treating them as interchangeable forms of sparsity.
- Six recurring research traditions and implementation routes are compared
  under one set of semantic, algorithmic, representational, and complexity
  dimensions. They overlap rather than forming a flat taxonomy.
- Formal correspondences show that observed-outcome guards and global
  reachability-and-outcome projection describe the same partition, while guarded
  summaries agree with flattened graph substitution under explicit sharing and
  interface conditions.

The framework is a synthesis, not a priority claim for its ingredients. Its
purpose is to state one problem precisely enough that results from different
communities can be transferred only when their observers and assumptions
actually agree.

The problem setup appears in @sec-example. The unified framework is defined in
@sec-formal-model, the bounded evidence method is reported in @sec-method, and
the known solution routes are compared in @sec-related. The principal
correspondences and complexity boundaries follow in @sec-algorithms and
@sec-complexity. Remaining semantic, evidence, and implementation limits are
stated in @sec-discussion.
