---
citekey: wang2021equivalence
work:
  title: "A General Framework for Enumerating Equivalence Classes of Solutions"
  author: "Yishu Wang, Arnaud Mary, Marie-France Sagot, Blerina Sinaimeri"
  venue: "ESA 2021"
  date: 2021
  doi: 10.4230/LIPIcs.ESA.2021.80
read: full-text
source: "Official LIPIcs proceedings PDF, https://doi.org/10.4230/LIPIcs.ESA.2021.80"
retrieved: 2026-08-09
notes-by: Codex GPT-5.6 Sol (publication-review revision)
notes-date: 2026-08-09
synthesis: "A general polynomial-delay framework for enumerating locally colored equivalence classes directly from acyclic decomposable AND/OR solution graphs; it establishes quotient enumeration as a first-class objective but does not emit caller-input guards, residuals, or witnesses."
---

# A General Framework for Enumerating Equivalence Classes of Solutions

## Evidence

### Why it matters

The paper treats direct enumeration of equivalence classes, rather than
enumerating every solution and grouping afterward, as the computational
objective. This is the closest general enumeration-theory precedent for the
survey's observer-fiber framing. Its positive result is materially restricted:
the solution space must be an acyclic decomposable AND/OR graph and the
equivalence must be induced by local colors on its OR-plus nodes.

### Model and equivalence

Definitions 1--2 use an acyclic decomposable AND/OR graph. One solution is a
subtree containing one start node, one chosen child at every OR node, and all
children at every AND node. Decomposability requires the reachable subgraphs
below distinct children of an AND node to be disjoint.

Definitions 3--4 assign colors to OR-plus nodes, require the children of one
AND node to have distinct colors, contract the AND nodes in a solution tree,
and identify solutions whose contracted colored trees are equal. The paper
therefore enumerates the quotient image itself; it also writes the inverse
class as $pi^(-1)(T)$, but does not construct a formula denoting that inverse
set.

### Algorithm and guarantee

Algorithm 1 orders colored class trees and constructs the next admissible tree
recursively. Compatibility sets prevent the Cartesian product of child classes
from producing combinations that do not arise from one AND choice.

Proposition 6 states that `Next` returns the first class, its successor, or the
end marker as appropriate. Theorem 7 enumerates every equivalence class exactly
once with delay $O(n s)$, where $n$ is graph size and $s$ the maximum solution
size. The guarantee charges an explicitly supplied acyclic decomposable
AND/OR representation, not construction of that representation from an
arbitrary program or solver formula.

### Dynamic-programming specialization

Section 3 obtains the AND/OR graph from a tree-sequential dynamic program and
applies the coloring quotient to optimal tree colorings and dynamic programs
over tree decompositions. The equivalence is local to DP states or bags. The
paper does not address graph-selection events, requested roots, symbolic
caller domains, or SMT encodings.

### Evidence locations

- Abstract and Section 1, pp. 80:1--80:2: direct quotient enumeration objective
  and scope.
- Definitions 1--4, pp. 80:3--80:4: solution graph, solution trees, coloring,
  and equivalence classes.
- Algorithm 1, Definition 5, Proposition 6, and Theorem 7, pp. 80:6--80:8:
  successor construction, admissibility, exactness, and polynomial delay.
- Section 3, pp. 80:8--80:12: dynamic-programming reduction and applications.
- Section 4, p. 80:12: decomposability boundary and open problems.

## Bearing on RQs

What is directly established by the work: a quotient can be the enumerated
object rather than a postprocessing step, and locally colored class trees of an
acyclic decomposable AND/OR solution graph have an exact polynomial-delay
enumerator.

Our interpretation or inference: a selection observer also defines a quotient,
but its equivalence is over caller inputs and its required record includes an
exact inverse-image guard, residual, and witness. No reduction from a general
selective term graph and caller predicate to the paper's decomposable colored
solution graph is supplied.

Could it subsume our proposed contribution: it subsumes any broad claim that
direct equivalence-class enumeration is a new objective. It supplies a stronger
delay theorem on its restricted representation, but not the graph-specific
observer, local exact guard, residualization, or SMT baseline.

## Evidence limits

- The equivalence is induced by local colors in a decomposable solution graph;
  arbitrary observer kernels are outside the theorem.
- The output is a colored class tree, not a guard or compact description of all
  original inputs in that class.
- Polynomial delay is relative to the supplied AND/OR graph and maximum output
  size; no translation-size theorem connects it to this survey's source graph.
