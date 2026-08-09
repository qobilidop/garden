---
citekey: berzins2023polyhedral
work:
  title: "Polyhedral Complex Extraction from ReLU Networks Using Edge Subdivision"
  author: "Arturs Berzins"
  venue: "ICML 2023"
  date: 2023
source: "ICML 2023 paper, https://proceedings.mlr.press/v202/berzins23a.html"
read: full-text
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Extracts the exact bounded ReLU polyhedral complex via one-skeleton edge subdivision rather than redundant per-region processing — the closest contemporaneous GPU/parallel competitor to Balestriero, and a stronger geometric output than a selection-enumeration observer needs."
---

# Polyhedral Complex Extraction from ReLU Networks Using Edge Subdivision

## Evidence

### Why it matters

Berzins extracts the exact bounded ReLU polyhedral complex by subdividing its
one-skeleton rather than redundantly processing each region. It is the closest
contemporaneous GPU/parallel competitor to Balestriero and a stronger
geometric output than our observer needs.

### Object and algorithm

The method represents every cell by a ternary sign vector and maintains the
vertices and edges of the complex. For every neuron, it:

1. evaluates the network at all current vertices;
2. appends the new preactivation signs;
3. finds edges with opposite endpoint signs;
4. interpolates the new zero vertex and splits each crossing edge; and
5. connects new vertices that share the same splitting two-face.

Section 4.1 reconstructs higher-dimensional cells and the intersection poset
by perturbing zero signs. The implementation restricts the input to a bounded
polyhedral domain, adding domain signs and perturbing boundary zeros only
toward the interior.

### Guarantee and complexity audit

The argument assumes a generic arrangement: no existing vertex lies on the
new folded hyperplane. Under that assumption the edge-subdivision construction
is mathematically exact, but the paper gives no numbered end-to-end
correctness theorem. Its experimental zero-residual check is explicitly only
a necessary, not sufficient, validation.

Section 4.2.3 claims \(O(|V|)\) time and memory. Appendix A obtains that
claim by treating network evaluation as linear in vertex count, assuming
linear edge-to-vertex relationships, and using hash-based pairing of splitting
faces. The actual GPU implementation sorts keys and is
\(O(|V|\log |V|)\). Network width, evaluation cost, and the potentially
exponential output size remain relevant.

The method assumes a fully connected ReLU network, genericity, and a bounded
polyhedral domain. Nongeneric and unbounded cases are left for future work.

### Evidence locations

- Sections 3.3--3.5, paper pp. 3--4: sign vectors and complex model.
- Sections 4.1--4.2, pp. 5--6: perturbation and edge-subdivision algorithm.
- Section 4.2.3 and Appendix A, pp. 6 and 11: complexity claim and assumptions.
- Section 5.1.1, p. 7: limited validation check.
- Section 6, p. 9: bounded/generic scope and future work.

## Bearing on RQs

The full cell complex contains dense signs for all ReLU units and includes
lower-dimensional boundary faces. It does not request a subset of result
roots, omit structurally unreachable nested sites, or emit finite-typed
residual graph values. Its June/July 2023 appearance is best treated as
contemporaneous and likely independent of the June 2023 ICASSP paper, not as a
secure priority predecessor to it.

It nevertheless prevents claims that exact cell-complex extraction,
sign-vector face reconstruction, or GPU-parallel exact region processing is
new.

## Evidence limits

Read at full-text (ICML) level; the source note recorded no dedicated
evidence-limits section beyond the assumptions and complexity caveats already
stated in the Evidence section above (genericity, boundedness, and the
\(O(|V|)\) versus \(O(|V|\log|V|)\) discrepancy between the claimed and
implemented bound).
