---
citekey: lagniez2024decisiondnnf
work:
  title: "Leveraging Decision-DNNF Compilation for Enumerating Disjoint Partial Models"
  author: "Jean-Marie Lagniez, Emmanuel Lonca"
  venue: "KR 2024"
  date: 2024
  doi: 10.24963/kr.2024/48
read: full-text
source: "Official KR 2024 paper at https://proceedings.kr.org/2024/48/kr2024-0048-lagniez-et-al.pdf"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Decision-DNNF compilation enumerates disjoint, covering partial models with polynomial post-compilation delay, but its omitted variables are semantic don't-cares rather than structurally unobserved sites, so a faithful reduction needs an explicit activity variable"
---

# Leveraging Decision-DNNF Compilation for Enumerating Disjoint Partial Models

## Evidence

### Why it matters

The paper gives disjoint, covering partial-model enumeration with polynomial
post-compilation delay. It is a crucial comparator because its omitted
variables are semantic don't-cares, not structurally unobserved sites.

### Semantic and compiled objects

A partial model is a literal cube every total extension of which satisfies the
formula. The algorithm emits one nonunique pairwise-disjoint family whose
extensions cover all total models; it does not enumerate every partial model or
guarantee prime implicants (Section 2, p. 510).

A d-DNNF is a shared circuit with decomposable conjunctions and deterministic
disjunctions. Decision-DNNF restricts disjunctions to decision nodes and
converts linearly to d-DNNF. Smoothing makes every disjunct mention the same
variables (pp. 510–511).

### Algorithm and guarantees

A model graph retains both children of a conjunction and one child of a
disjunction (Definition 1). Proposition 1 shows each such graph is a tree and
Corollary 1 constructs it in linear time. Proposition 2 gives a bijection with
models for smooth d-DNNF. Propositions 3–4 establish linear-delay traversal and
sound, complete, disjoint enumeration for smooth circuits (pp. 512–515).

On nonsmooth d-DNNF, absent variables in a selected disjunct are omitted,
yielding disjoint partial models whose total extensions cover all models.

### Complexity

Smoothing costs `O(|Var| |Σ|)`. After compilation, enumeration has
`O(|Σ|)` delay and `O(|Σ| |Mod(Σ)|)` total time. Decision-DNNF compilation may
itself be exponential in the source CNF, so these are not end-to-end
polynomial-time bounds (pp. 511 and 514–516).

### Motivating example

For `(a or b) and (not a or not b) and (c or d)`, six complete models admit a
four-cube disjoint partial cover, with cubes able to omit the remaining free
choice between `c` and `d` (Example 1 and Figure 1, pp. 510 and 512–513).

### Evidence locations

- Section 2, pp. 510–511: partial models and circuit classes.
- Definition 1 and Propositions 1–4, pp. 512–515: algorithm and guarantees.
- Pages 515–516: nonsmooth partial enumeration and compilation qualification.

## Bearing on RQs

Omitting a literal means both values preserve satisfiability. It does not mean
a selector was structurally inactive. A faithful reduction needs an activity
variable plus outcome variables, or a finite inactive-or-outcome code. Fixing
one observation and enumerating partial input models can produce several cubes
for one observation fiber. The cover is syntax-dependent and supplies no
program residual value, although any completion is a witness.

## Evidence limits

Read at full-text level from the official KR 2024 proceedings PDF. Decision-
DNNF compilation may itself be exponential in the source CNF, so the stated
polynomial post-compilation delay is not an end-to-end polynomial-time
guarantee.
