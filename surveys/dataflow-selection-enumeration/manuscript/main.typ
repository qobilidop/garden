#import "style.typ": paper

#show: paper

#set document(
  title: "Exhaustive Enumeration of Selection Observations in Pure Dataflow Graphs: A Survey and Unified Framework",
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
    in Pure Dataflow Graphs\
    #text(size: 15pt)[A Survey and Unified Framework]
  ]
  #v(0.75em)
  #text(size: 11.5pt)[Bili Dong]
  #v(0.2em)
  #text(size: 9.5pt)[Independent researcher]
  #v(0.35em)
  #text(size: 9.5pt, style: "italic")[Problem · approaches · analysis · Draft · 5 August 2026]
  #v(0.2em)
  #text(size: 8.5pt)[
    #link("https://qobilidop.github.io/dataflow-selection-enumeration/")[Online manuscript]
  ]
]

#v(0.8em)

#pad(x: 6%)[
  #block(
    width: 100%,
    inset: (x: 1em, y: 0.65em),
    fill: rgb("f7f9fb"),
    radius: 2pt,
  )[
    #align(center)[*Abstract*]
    #v(0.25em)
    Different inputs can make a shared graph consult different selection nodes.
    We group allowed inputs when the requested outputs consult the same graph
    occurrences and obtain the same outcomes. For each group, the target is an
    exact input formula, a symbolic expression for the requested outputs, and
    one sample input. We call the grouping function the selection observer and
    each group an observation fiber. The base model is a finite, acyclic,
    deterministic pure graph with total primitives. This paper surveys the established approaches
    that can solve, compile, or specialize this task: guarded symbolic execution,
    projected model enumeration, decision structures, demand-guided search,
    geometric region traversal, and compositional summaries. Its main synthesis
    is a unified terminology and theoretical framework that separates the
    observer being enumerated from the discovery algorithm and output
    representation. Within that framework, enabled reachability determines
    which site outcomes are included; sparse event maps, observed-outcome
    guards, and totalized reachability-and-outcome coordinates then determine
    the same input partition. The comparison explains
    which approaches enumerate the same fibers directly, which require
    instrumentation or quotienting, which provide stronger guarantees on
    restricted instances, and which solve only adjacent reduction problems. The
    result is a problem-centered survey and semantic contract, not a claim of a
    new generic enumeration paradigm or practical speedup.
  ]
]

#include "sections/01-introduction.typ"
#include "sections/02-motivating-example.typ"
#include "sections/04-formal-model.typ"
#include "sections/03-method.typ"
#include "sections/07-related-work.typ"
#include "sections/05-algorithms.typ"
#include "sections/06-complexity.typ"
#include "sections/08-discussion.typ"
#include "sections/09-conclusion.typ"

#bibliography("../references.bib", style: "ieee")
