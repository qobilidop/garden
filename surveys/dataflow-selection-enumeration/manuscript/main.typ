#import "style.typ": paper

#show: paper

#set document(
  title: "Exhaustive Enumeration of Selection Observations in Pure Dataflow Graphs",
  author: "Bili Dong",
  keywords: (
    "symbolic execution",
    "dataflow graphs",
    "projected model enumeration",
    "demand semantics",
    "term graphs",
  ),
)

#align(center)[
  #text(size: 21pt, weight: "bold")[
    Exhaustive Enumeration of Selection Observations\
    in Pure Dataflow Graphs
  ]
  #v(0.75em)
  #text(size: 11.5pt)[Bili Dong]
  #v(0.35em)
  #text(size: 9.5pt, style: "italic")[Survey and formal synthesis --- working preprint]
]

#v(0.8em)

#block(
  width: 88%,
  inset: (x: 1em, y: 0.65em),
  fill: rgb("f7f9fb"),
  radius: 2pt,
)[
  #align(center)[*Abstract*]
  #v(0.25em)
  Symbolic execution is often described as constructing a formula or symbolic
  value. A different task is to enumerate, exhaustively and without
  duplication, the distinct decision observations induced by a requested
  result. For a pure shared dataflow graph, an input may expose one selection
  site while leaving sites in unselected case cones structurally unobserved.
  Each observable case should carry an exact input guard, a residual symbolic
  value, and a witness. This paper maps the many established forms of that
  problem across symbolic execution, projected model enumeration,
  functional-logic search, demand-driven testing and dataflow, decision
  diagrams, hyperplane and neural-region enumeration, and piecewise-affine
  systems. The map shows that the broad algorithmic proposal is not a new
  enumeration paradigm: finite observer partitions, projected AllSMT,
  decision structures, guarded residuals, and demand-guided search each cover
  substantial parts of it. We then give a common formal model that keeps the
  remaining distinctions explicit. A _selection observation_ is the partial
  map of contextual site outcomes reached from requested roots through strict
  operands and selected case edges. We prove that positive predicates for
  only those observed sites define its exact inverse-image fiber, relate local
  concolic generation to a global reachability-and-projection encoding, prove
  exact composition under graph substitution and sharing, and separate a
  linear oracle-call count from genuine output-polynomial complexity. The
  result is a reproducible survey and a conservative formal synthesis, not a
  claim of priority for symbolic enumeration itself.
]

#include "sections/01-introduction.typ"
#include "sections/02-motivating-example.typ"
#include "sections/03-method.typ"
#include "sections/04-formal-model.typ"

= Algorithms and correctness <sec-algorithms>

_To be completed after the formal-model review._

= Complexity and established special cases <sec-complexity>

_To be completed after the formal-model review._

= Related-work synthesis <sec-related>

_To be completed after mapping closure._

= Discussion and limitations <sec-discussion>

_To be completed after mapping closure._

= Conclusion <sec-conclusion>

_To be completed after review and revision._

#bibliography("../references.bib", style: "ieee")
