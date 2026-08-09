---
citekey: moehle2025short
work:
  title: "On Enumerating Short Projected Models"
  author: "Sibylle Möhle, Roberto Sebastiani, Armin Biere"
  venue: "Discrete Applied Mathematics"
  date: 2025
  doi: 10.1016/j.dam.2024.10.021
read: full-text
source: "Author-hosted final-layout Discrete Applied Mathematics version at https://cca.informatik.uni-freiburg.de/papers/MoehleSebastianiBiere-DAM25.pdf"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "A direct baseline for disjoint projected model enumeration and model shrinking; its short cubes may cover several complete selection observations, so identifying a cube with one observation is valid only when it uniquely determines every omitted coordinate"
---

# On Enumerating Short Projected Models

## Evidence

### Why it matters

The work is a direct baseline for disjoint projected model enumeration and
model shrinking. Its short cubes may cover several complete selection
observations, so they are not automatically observation records.

### Enumerated object

For `F(X,Y)`, `X` is the relevant variable set and `Y` is existentially
projected. A partial model is a cube every total extension of which satisfies
the projected formula. The irredundant algorithm constructs a disjoint sum of
products equivalent to `exists Y. F`; the redundant variant may emit
overlapping cubes (pp. 413–419).

### Algorithm and guarantees

Polynomial-size Tseitin encodings represent `F` and its negation. One CDCL
solver finds a total model; a second solver checks the negated formula under
that model's input literals. Conflict analysis removes assumptions not needed
for the contradiction. The irredundant algorithm adds a blocker and its dual
encoding (pp. 420–423).

Proposition 1 proves dual blockers make cubes contradictory. Proposition 4
proves termination. Theorem 1 proves equivalence to the projection and
pairwise contradiction (pp. 422 and 431–432). Shrinking is explicitly not
guaranteed minimal (p. 437).

### Complexity

The paper proves no OutputP, IncP, or polynomial-delay result. Conflict
analysis and encoding may be small while discovering the next total model
still requires general SAT solving.

### Evidence locations

- Pages 413–419: AllSAT, projection, and partial models.
- Pages 420–423: dual shrinking and blockers.
- Proposition 4 and Theorem 1, pp. 431–432: termination and correctness.
- Page 437: non-minimality and limitations.

## Bearing on RQs

Complete assignments to explicit inactive-or-outcome variables correspond to
totalized selection observations. A short cube can omit one such coordinate
and thereby represent several observations. Identifying a short cube with one
observation is valid only when it uniquely determines every omitted coordinate.
Structural inactivity remains an explicit sentinel, not logical don't-care.

## Evidence limits

- No separate limits section in the source note; the paper proves no
  output-polynomial, incremental-polynomial, or polynomial-delay result (see
  ### Complexity above), and shrinking is explicitly not guaranteed minimal.
