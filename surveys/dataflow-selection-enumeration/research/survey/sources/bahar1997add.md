# bahar1997add — Algebraic Decision Diagrams and Their Applications

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1023/A:1008699807402
- **Version read:** author-uploaded FMSD manuscript
- **Bibliography key:** `bahar1997add`

## Why it matters

An algebraic decision diagram is a canonical shared representation of a finite
function. It can represent active-selection fibers exactly, but only when the
terminal carrier is the complete selection observation rather than the
ordinary program output.

## Program and semantic model

An ADD represents one or more functions

\[
f_i:\{0,1\}^n\to S,
\]

where `S` is a finite algebraic carrier. Ordered binary variable nodes form a
DAG and terminals contain carrier values (Section 2.2, pp. 172–173).

## Representation and guarantees

ITE omits a variable node when its two recursive results coincide. A unique
table merges isomorphic residual functions and a computed table memoizes
recursive operations. Reduced ordered ADDs are canonical for exact finite or
integer carriers and a fixed variable order; floating-point equality weakens
the practical claim (Theorem 2.1 and Sections 2.3–2.5, pp. 174–178).

Sharing is extensional: distinct prefixes that reach the same residual
function lose their provenance.

## Complexity

Worst-case ADD size remains exponential in the number of Boolean variables.
The paper gives memoized recursive algorithms and compact empirical examples,
not a general polynomial representation theorem (Sections 2.2 and 2.4).

## Motivating example

The weighted directed-graph example represents an adjacency matrix with
repeated terminal weights and submatrices (Figure 1, pp. 172–173).

## Relationship to our hypothesis

If terminals contain only output values, reduction erases active equal-valued
selections. If the carrier contains the complete sparse observation, the ADD
represents the observation function and each terminal preimage is exactly a
fiber. A skipped ADD input variable then means that the complete observation
is independent of that input; it does not by itself denote an inactive
selection site. The paper does not provide residual-output or witness APIs, and
enumerating root-to-terminal cubes can still be exponential.

## Evidence locations

- Sections 2.2–2.4, pp. 172–175: representation, reduction, and canonicity.
- Sections 2.5.1–2.5.2, pp. 176–178: ITE and Apply.
