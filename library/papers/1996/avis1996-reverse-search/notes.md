---
citekey: avis1996-reverse-search
work:
  title: "Reverse search for enumeration"
  author: David Avis, Komei Fukuda
  venue: "Discrete Applied Mathematics 65(1–3), pp. 21–46"
  date: "1996-03"
  doi: 10.1016/0166-218X(95)00026-N
sources:
  pdf: https://cgm.cs.mcgill.ca/~avis/doc/avis/AF96a.pdf  # author-hosted journal PDF; title, authors, pagination, and DOI identity match the record
retrieved: 2026-08-09
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-09
synthesis: "Reverse search turns any finite deterministic local search into a parent forest and traverses that forest backward, enumerating without a visited set when parent and adjacency oracles are cheap."
---

# Reverse search for enumeration

A general algorithmic framework for exhaustive [[model-enumeration]] and a
collection of concrete instantiations. Avis and Fukuda observe that a finite,
deterministic local search points every candidate toward a terminal object.
Those directed edges form a spanning forest. Traversing the forest in reverse
enumerates every candidate without storing the visited set. The paper is
mathematically clear about the conditions and oracle costs; its strongest
relevance here is the complete, duplicate-free, output-sensitive enumeration
of full-dimensional hyperplane-arrangement cells.

## A local optimizer becomes an enumeration parent map

Let an undirected graph contain exactly the objects to enumerate. A finite
local-search function maps every nonterminal vertex to an adjacent vertex and
eventually reaches a terminal set. Property 2.1 states the elementary but
powerful consequence: the selected directed edges form a spanning forest with
one terminal sink in each component.

Reverse search starts at the sinks and finds every neighbor whose local-search
parent is the current vertex. Depth-first traversal needs no global visited
set because every nonroot object has exactly one parent. Backtracking simply
reapplies the parent function. With an adjacency oracle of bounded degree,
Theorem 2.2 charges adjacency and parent evaluation across vertices and edges;
Corollary 2.3 makes the output-linear shape visible when those local costs are
independent of the output count.

The framework is not a free enumeration theorem. One must still provide the
object graph, a terminating parent function, all roots, and efficient forward
and reverse traversal tests. A poor parent oracle or a disconnected or
implicitly expensive neighborhood can erase the attractive bound.

## Hyperplane cells supply the closest exact specialization

For `m` distinct affine hyperplanes in `R^n`, the paper represents each open
full-dimensional cell by its complete strict sign vector. It reorients the
hyperplanes so that a chosen root is all-positive. Lemma 3.1 ensures every
nonroot cell has an adjacent cell separated from the root by one fewer
hyperplane; choosing the lexicographically first such improvement gives a
unique parent, and Corollary 3.2 bounds the tree height by `m`.

Adjacency across one hyperplane is tested by a linear program. If `l(m,n)` is
the arithmetic cost of that LP, Theorem 3.3 gives
`O(m n l(m,n) |C|)` time for all cells `C` and `O(m n)` working space. The
result permits parallel, redundant, and otherwise degenerate arrangements; it
does not require general position. It excludes points on the hyperplanes,
however, so every reported object is an open full-dimensional cell.

This is a complete solution for a strict affine, all-sites-observed selection
problem: sign vectors are observations and cells are their input fibers. It is
not a solution for nested conditionals whose unchosen subgraphs are
structurally absent, non-strict branches that own boundary points, arbitrary
SMT theories, or records requiring a symbolic residual.

## The same structure supports many enumerators

The paper also develops reverse searches for polyhedral vertices,
triangulations, spanning trees, connected induced subgraphs, topological
orderings, and Euclidean spanning trees, then introduces partial reverse
search for constrained optimization. These applications demonstrate the
framework's portability, but they do not share one uniform per-output cost:
each depends on its own adjacency and parent tests.

Easy parallel decomposition follows structurally because subtrees below
different children are independent. Useful speedup still depends on tree
height and load balance. The paper is appropriately more cautious about that
performance question than later shorthand descriptions of “embarrassingly
parallel” traversal sometimes are.

## Assessment

- **Durable:** deriving a canonical parent forest from a terminating local
  search; enumerating without a visited set; explicitly charging parent and
  adjacency oracles; and separating output count from working space.
- **Era-bound:** the LP-operation cost notation, particular application
  implementations, and the authors' historical-priority belief. The latter is
  qualified in the paper and should not be restated as a proved priority fact.
- **Weaknesses:** the general framework guarantees little until an efficient
  reverse test and root set are supplied. The arrangement theorem is an
  arithmetic/LP-relative result, not a coefficient-bit analysis, and it omits
  all lower-dimensional faces.
- **Against the library:** [[phan2015-all-smt]]
  and [[spallitta2024-tabular]]
  organize enumeration through solver search rather than an explicit object
  adjacency graph. Reverse search obtains polynomial working space from a
  unique parent; the solver methods obtain duplicate avoidance from blockers
  or chronological traversal. All three make the no-duplication mechanism an
  architectural choice rather than an afterthought.

Reverse search remains the clean classic answer when feasible objects admit a
cheap connected neighborhood and a deterministic route to one root. Its
limitations are exactly as important as its elegance: many symbolic observer
fibers do not arrive with that geometry.
