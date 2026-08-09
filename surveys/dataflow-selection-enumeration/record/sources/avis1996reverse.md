# avis1996reverse — Reverse Search for Enumeration

- **Status:** deep-read; critical output-sensitive predecessor
- **Primary source:** https://doi.org/10.1016/0166-218X(95)00026-N
- **Open copy:** https://cgm.cs.mcgill.ca/~avis/doc/avis/AF96a.pdf
- **Version read:** Discrete Applied Mathematics 65 (1996), author PDF
- **Bibliography key:** `avis1996reverse`

## Why it matters

Avis and Fukuda establish reverse search as a general memory-efficient
enumeration method and instantiate it for full-dimensional cells of affine
hyperplane arrangements. The cell result predates Rada and Černý's incremental
formulation and already provides exact-once, output-polynomial enumeration in
polynomial working space. We therefore cannot claim that completeness,
nonduplication, OutputP enumeration, or easy parallel traversal begins with the
later sign-prefix algorithm.

## Model and enumerated object

Section 3.2 takes \(m\) distinct affine hyperplanes in \(\mathbb R^n\). A cell
is a nonempty total sign vector in \(\{-,+\}^m\), equivalently the intersection
of one strict open halfspace from every hyperplane. Every nonempty such set is
open and hence full-dimensional. The method permits parallel, redundant, and
otherwise degenerate arrangements; it does not require simplicity, bounded
cells, or general position.

This model excludes hyperplane boundaries from the output. It therefore
matches an all-sites-observed selection observer only when outcomes are strict
signs and the caller domain excludes boundary points. Non-strict branch
semantics can instead produce half-open or lower-dimensional fibers.

## Reverse-search construction and guarantee

Property 2.1 shows that a finite local-search trace with a unique terminal
object induces a directed spanning tree or forest whose arcs can be traversed
in reverse without storing the visited set. For arrangement cells, the authors
reorient hyperplanes so a chosen root is the all-positive cell. Lemma 3.1
proves that every non-root cell has an adjacent cell with one fewer separator
from the root; Corollary 3.2 bounds the resulting trace height by \(m\).
Reverse traversal of this parent relation therefore visits every cell exactly
once.

The paper does not label this conclusion as a standalone numbered
"complete-and-duplicate-free theorem." It follows from Property 2.1, Lemma
3.1, the unique reoriented root, and the traversal. Theorem 3.3 is the
complexity theorem.

## Complexity

Let \(l(m,n)\) be the arithmetic cost of the required LP with \(n\) variables
and roughly \(m\) inequalities. Theorem 3.3 gives

\[
  O\!\left(mn\,l(m,n)\,|C|\right)
\]

time and \(O(mn)\) working space for all cells \(C\). With fixed \(n\) and a
linear-time fixed-dimensional LP routine, this becomes
\(O(m^2|C|)\). This is an output-polynomial arithmetic/LP-operation result, not
an independently stated coefficient-bit-complexity bound.

## Relationship to later work and our hypothesis

Sleumer retains the reverse-search framework and improves the
fixed-dimensional cell bound by a factor of \(m\). Rada and Černý later insert
hyperplanes incrementally, keep the witness-implied sign without an LP, and
test only the opposite successor. That is a useful structural reformulation
and may change LP sizes and counts, but it is not the origin of exact,
duplicate-free, output-sensitive arrangement-cell enumeration.

The result subsumes our all-sites-observed strict-affine special case and its
broad enumeration guarantee. It has no requested-root-relative structural
absence, context-qualified graph occurrence, typed residual expression, or
dataflow composition interface.

## Evidence locations

- Printed p. 24, Property 2.1: spanning-forest and unique-sink reverse-search
  invariant.
- Printed p. 29, Section 3.2 opening: affine model, strict sign vectors, open
  cells, and adjacency.
- Printed p. 29, Lemma 3.1 and Corollary 3.2: progress toward the root and
  height at most \(m\).
- Printed pp. 30--31, LP (3.1): adjacency oracle.
- Printed p. 31, Theorem 3.3: time and space bounds.
- Printed p. 31: the authors' qualified historical-priority statement begins
  "We believe" and must not be restated as an independently proved fact.

## Questions and limitations

- The cell output omits every lower-dimensional arrangement face.
- The complexity analysis is expressed through LP/arithmetic cost.
- The general reverse-search framework can repeat work along different
  root-to-output traversals but deliberately avoids a visited set.
