#import "../../../style.typ": centered-block

= Introduction <sec-introduction>

Consider a finite, typed, acyclic, deterministic pure dataflow graph containing
nested conditionals, multiplexers, priority selectors, or other finite choice
operators. Its primitives are total on their typed domains. A caller supplies
an input from a declared domain and requests one or more graph results. The
problem of this survey is:

#centered-block[
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

The paper introduces _selection observation_, _selective term graph_,
_enabled closure_, _observed-outcome guard_, _observation record_, and
_full-fiber blocking_ as local names or local refinements for this synthesis;
they are not claimed as established terms of art, and the complete four-field
contract is not presented as an already established named task. The paper is
therefore also a theory/position synthesis of a proposed semantic contract,
not evidence that this exact observer already has a demonstrated consumer.
_Observer_, _kernel_,
_fiber_, _guard_, _residual_, _projection_, and _symbolic execution_ retain
their established meanings. The six groups below are overlapping solution
routes, not a field-wide taxonomy.

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

This separation makes six overlapping routes comparable: guarded symbolic
execution, projected enumeration, compiled decision structures, demand-guided
search, geometric or parametric specialization, and compositional summaries.
Each route has strong precedents, but its name alone does not determine the
observer or supply the complete record contract. @sec-routes introduces the
representative literature only where each route is analyzed.

The paper answers four questions:

- *RQ1:* What consistent terminology precisely defines selection-observation
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

@sec-example develops the problem through one graph. @sec-framework then
defines its core semantics independently of any solver, and @sec-method states
the survey's evidence boundary. @sec-routes presents the six solution routes,
@sec-algorithms gives two general enumeration presentations, and
@sec-composition states the compositional extension. @sec-complexity separates
general costs from stronger specialized frontiers; @sec-synthesis then compares
observers, guarantees, and closest established results. @sec-boundaries states
the remaining boundaries and open problems, and @sec-conclusion closes with the
main conclusions.
