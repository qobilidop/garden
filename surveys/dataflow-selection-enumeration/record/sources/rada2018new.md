---
citekey: rada2018new
work:
  title: "A New Algorithm for Enumeration of Cells of Hyperplane Arrangements and a Comparison with Avis–Fukuda's Reverse Search"
  author: "Miroslav Rada, Michal Černý"
  venue: "SIAM Journal on Discrete Mathematics"
  date: 2018
  doi: 10.1137/15m1027930
read: full-text
source: "Authors' 2016 preprint at https://nb.vse.cz/~cernym/preprinty/p1.pdf (DOI https://doi.org/10.1137/15m1027930)"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Gives a proof-bearing incremental sign-prefix algorithm for exact, duplicate-free, output-polynomial hyperplane-arrangement cell enumeration later specialized by Balestriero and LeCun to neural activation hyperplanes, though it always assigns a side to every hyperplane with no input-relative structural observation"
---

# A New Algorithm for Enumeration of Cells of Hyperplane Arrangements

## Evidence

### Why it matters

Rada and Černý provide a proof-bearing incremental cell-enumeration algorithm
that Balestriero and LeCun later specialize to neural activation hyperplanes.
Avis and Fukuda's reverse search and Sleumer's fixed-dimensional improvement
already establish earlier output-sensitive arrangement-cell enumeration.
Ferrez, Fukuda, and Liebling's 2005 central-arrangement algorithm also already
has the \(O(m\,LP(m,d)\,|C_m|)\) LP-relative bound later associated with
modified reverse search. Rada and Černý supply the especially direct
incremental sign-prefix formulation rather than the first bound of that form.
IncEnu preserves exact, duplicate-free, output-polynomial
enumeration of full-dimensional hyperplane cells. Those properties cannot be
claimed as new for our more general solver recurrence.

### Model and cell representation

An arrangement \(A_m\) contains \(m\) affine hyperplanes in
\(\mathbb R^d\). A cell is represented by a total sign vector selecting one
open halfspace of every hyperplane. A prefix sign vector \(s_i\) represents a
cell of the first \(i\) hyperplanes. A linear program tests whether a proposed
successor has a strict interior witness; the notation
\(lp(\mu,d)\) explicitly accounts for solving an LP with \(\mu+O(1)\)
constraints, \(d+O(1)\) variables, and coefficient bit sizes bounded by the
input (Section 2).

### Incremental Enumeration

Algorithm 1 processes one hyperplane at a time. Given a prefix cell and its
witness, it obtains the side of the new hyperplane containing that witness
without an LP and recursively visits that successor. It separately LP-tests
the opposite successor and visits it only when a witness exists. When all
hyperplanes have been processed, it streams the sign vector.

The literal pseudocode uses non-strict halfspaces when choosing the first side.
The surrounding text and Theorem 3.2 require a safe perturbation when the
witness lies on the newly inserted hyperplane. Dussault, Gilbert, and
Plaquevent-Jourdain later point out that simply assigning one side when the
relevant dot product is zero is incomplete at the pseudocode level: both strict
successors may exist. Their corrected central-arrangement implementation makes
the two perturbations explicit. The theorem here should therefore be cited
together with its perturbation premise, not as correctness of an unqualified
literal implementation.

This is the precise, corrected form of the later ternary-prefix algorithm:
retain the witness-implied actual sign and test only the opposite side. The
paper also gives an equivalent flattened variant for comparison with
Avis--Fukuda reverse search.

### Guarantees

Theorem 3.1 proves that the output stream is complete and contains no
duplicates. Uniqueness follows because every full-dimensional cell has one
sign vector. Completeness follows inductively: every cell after inserting
hyperplane \(i+1\) has a prefix predecessor that was visited after insertion
\(i\), and both successors of every visited predecessor are considered.

Theorem 3.2 gives

\[
  O(|C_m|\,m\,lp(m,d))
\]

time and \(O(lp(m,d))\) space. Corollary 3.3 classifies Algorithm 1 as compact
and output-polynomial. The stream need not be retained in memory.

The result is stronger and more carefully parameterized than a bare
"linear in regions and dimension" claim. The number of cells is itself
superpolynomial when dimension varies, so output polynomiality is the relevant
enumeration guarantee.

### Evidence locations

- Introduction, preprint pp. 1--2: full-dimensional cells, compactness, and
  output-polynomiality.
- Section 2 and equation (2.1), pp. 2--3: sign cells, witnesses, and LP model.
- Section 3.1 and Algorithm 1, pp. 3--4: incremental recurrence.
- Theorem 3.1, p. 5: completeness and no duplicates.
- Theorem 3.2 and Corollary 3.3, pp. 5--6: time, space, and OutputP result.
- Dussault et al. 2025, Section 5.2.1(B): zero-witness pseudocode caveat and
  explicit two-sided perturbation.

## Bearing on RQs

For one real affine layer restricted to strict signs away from all hyperplane
boundaries, the reduction is direct: each local outcome predicate is a
hyperplane sign, all sites are observed, and observation fibers are
full-dimensional arrangement cells. Boundary-inclusive or correlated
non-strict tests can instead yield half-open or lower-dimensional fibers, so
the arrangement theorem does not transfer to those cases without additional
assumptions. More generally, the recurrence supplies a standard
enumeration skeleton whenever accumulated exact guards can be incrementally
extended and feasibility-tested.

It does not define input-relative structural observation, sparse maps whose
domains vary by selected case edges, residual graph values, contextual site
identity, or finite typed graph composition. Hyperplane cells always assign a
side to every hyperplane. Thus it subsumes the generic incremental feasibility
search and its basic output bound, but not the graph-specific observer or its
enabled-closure correspondence.

## Evidence limits

Do not claim, on the strength of this work:

- first recursive feasibility-pruned enumeration;
- first exact or duplicate-free sign-region enumeration;
- first OutputP cell enumeration; or
- a novel \(O(KR)\)-style oracle-query bound in the all-sites-observed affine
  case.
