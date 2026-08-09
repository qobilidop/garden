# mumtaz2011partial — P-PET: Partial Pseudo-Exhaustive Test for High Defect Coverage

- **Status:** deep-read; critical representative of support-local exhaustive
  circuit testing
- **Primary source:** https://doi.org/10.1109/TEST.2011.6139130
- **Version read:** author-hosted accepted manuscript
- **Open copy:**
  https://www.iti.uni-stuttgart.de/fileadmin/rami/files/publications/2011/ITC_MumtazIW2011.pdf
- **Bibliography key:** `mumtaz2011partial`

## Why it matters

Pseudo-exhaustive testing is a direct combinational-DAG predecessor for
exhaustiveness relative to a local observation support. Instead of applying all
global input vectors, it requires every assignment on the structural input cone
of every circuit output. Global test vectors can exercise several cones at
once, so unrelated inputs do not force a Cartesian product for every local
test obligation.

This is an important antecedent for the paper's motivating efficiency claim.
It does **not**, however, enumerate sparse selection observations. It emits
full input patterns, treats an output cone as containing all structural
predecessors—including both arms of a mux—and pursues fault coverage rather
than exact semantic input fibers or residual functions.

## Circuit and test-set model

Let a combinational circuit $C$ have primary inputs $I$ and outputs $O$.
For output $o$, its cone is the minimal subcircuit containing every structural
predecessor of $o$; $k_o\subseteq I$ is the set of primary inputs connected
to that output. The cone size is $|k_o|$ (Section I, paper p. 1).

A pseudo-exhaustive test set $T\subseteq\{0,1\}^{I}$ includes an exhaustive
test for every cone. Equivalently, in projection notation,

\[
  \pi_{k_o}(T)=\{0,1\}^{k_o}
  \qquad\text{for every }o\in O.
\]

The paper states the successive-cone cost as

\[
  \sum_{o\in O}2^{|k_o|}
\]

and, when cones can be exercised concurrently, bounds the test length between
$2^w$ and $|O|2^w$, where $w=\max_o|k_o|$ (Section I, equations (1)--(2),
paper p. 1).

The paper's **partial** variant is intentionally weaker: for a chosen
`MAXsize`, only cones of size at most that threshold are guaranteed exhaustive
coverage. Larger cones receive the generated patterns but are not guaranteed
to see every local assignment (Section I, paper pp. 1--2). Thus *partial* in
P-PET means partial circuit coverage, not partial input records.

## Enumeration and synthesis algorithm

The implementation uses programmable linear-feedback shift registers. A
primitive feedback polynomial $p$ of degree $r$ tests a cone $k$ when its
$2^r-1$ nonzero states project to all nonzero assignments of $k$; the all-zero
pattern is applied separately. The synthesis objective is to find a small set
$P$ of bounded-degree polynomials such that

\[
  \forall k\in K_c.\ \exists p\in P.\ p\prec k,
\]

where $K_c$ contains the cones within the cutoff (Section III, equation (3),
paper pp. 2--3).

The cited Barzilai theorem replaces explicit generation of all projected
patterns by a linear-independence test on polynomial remainder classes
$(X^{i_1}\bmod p),\ldots,(X^{i_s}\bmod p)$ over $GF(2)$ (Section V,
paper p. 3). The paper then solves a set-cover formulation heuristically. If
$k_a\subseteq k_b$, exhaustive coverage of $k_b$ implies coverage of
$k_a$, so subset cones are removed before greedy polynomial construction
(Section VI-A, paper p. 4). Algorithm 6 repeatedly chooses a polynomial that
covers the most remaining maximal cones and then the most smaller cones
(Section VI-B, paper pp. 4--5).

## Guarantees and complexity boundary

For every cone retained in $K_c$, the construction checks that some selected
polynomial projects to every cone assignment. This is an exact coverage
contract for those cones; the paper does not claim exact coverage for cones
above `MAXsize`.

The work states that finding a minimum-length pseudo-exhaustive test set is
NP-complete and that its polynomial selection is a set-cover problem. The
presented construction is heuristic: it does not prove a globally minimum test
set or an output-sensitive enumeration class (Sections II-B and III,
paper pp. 2--3). Its cost metric is number of applied patterns and hardware
overhead, not number or serialized size of semantic observation records.

Experiments on industrial full-scan circuits measure the fraction of cones and
gates covered at a chosen cutoff, required polynomials/patterns, stuck-at
coverage, $N$-detectability, and non-target bridging-fault coverage
(Section VII, paper pp. 5--8).

## Historical lineage

McCluskey's 1984 verification-testing paper introduced exhaustive testing of
individual output cones. Udell and McCluskey's 1989 paper formalized segments
and segmentations, treated multiple-output segments, and defined a segment
test set guaranteeing detection of detectable faults within segments. The
1989 full text was not openly obtainable during this survey; those details are
limited to its publisher abstract and exact bibliography rather than presented
as a deep read.

Srinivasan, Gupta, and Breuer later derived generic and circuit-specific bounds
on minimum pseudo-exhaustive test length. Their 1998 abstract states, in
particular, that circuits with at most five outputs and maximum cone size $k$
can always be tested with $2^k$ patterns. These are bounds for local truth-table
coverage, not for selection-observation enumeration.

## Relationship to selection observations

### Shared insight

Both frameworks parameterize exhaustiveness by an observer smaller than the
whole input vector. Pseudo-exhaustive testing makes local support hyperedges
$k_o$ explicit and reuses full test vectors across their local Cartesian
products. It therefore defeats any claim that exhaustive testing relative to
local dataflow cones is new.

### Exact separator

Consider

```text
return select(b, f(x), g(y))
```

For its single output, the structural cone contains $b$, the inputs of $f$,
and the inputs of $g$. Pseudo-exhaustive testing requires every joint
assignment on that set. The selection observer instead has an observation for
each outcome of `b`; when one case is selected, the other case cone is outside
the enabled closure and its inputs remain unconstrained. Its result is an exact
guard and a residual selected-case value, not a full truth table for the union
of both case supports.

This distinction is structural rather than merely algorithmic:

- pseudo-exhaustive relevance is a static output support cone;
- selection observation is input- and requested-root-relative enabled
  reachability through only selected case edges;
- PET outputs a covering set of concrete global tests;
- our synthesis outputs graph-intensional site/outcome maps, exact inverse
  images, residual values, and witnesses; and
- logical or LFSR don't-cares do not encode that a selection site was
  unobserved.

Encoding an observation coordinate as a circuit output lets PET supply tests
covering all assignments to its structural support. It still does not enumerate
the image of the observation map, prove exact fibers, or preserve site identity.
Consequently PET is a strong local-exhaustiveness predecessor but not a direct
reduction of the proposed semantic object.

## Evidence locations

- Section I and equations (1)--(2), paper pp. 1--2: cone definition, PET
  contract, test-length bounds, and P-PET cutoff.
- Sections II-B and III, paper pp. 2--3: pattern-generator lineage, minimum-set
  hardness statement, and polynomial-cover objective.
- Section V, paper p. 3: linear-independence criterion for exhaustive cone
  projection.
- Section VI and Algorithm 6, paper pp. 4--5: subset-cone elimination and
  set-cover heuristic.
- Section VII, paper pp. 5--8: empirical metrics and scope.
- Section VIII, paper p. 8: stated P-PET guarantee and limitations.

## Questions and limitations

- The paper's word *partial* is easily misread as a partial-assignment result;
  it is instead a cutoff that gives no exhaustive guarantee for large cones.
- Structural connection can retain functionally irrelevant inputs and all mux
  arms; the paper does not compute semantic supports or dynamic enabled
  closures.
- Test vectors may be shared across cones, but they remain complete global
  vectors rather than emitted cylinders.
- The minimum-test-set hardness statement is cited rather than reproved, and
  the proposed heuristic has no approximation ratio.
- The original 1984 and 1989 papers remain necessary historical citations;
  manuscript claims about their precise formal definitions must stay within
  the accessible abstracts unless their full texts are obtained.
