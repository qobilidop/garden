# jones2006lcp — full-dimensional parametric LCP enumeration

- **Status:** deep-read; direct sufficient-matrix precursor
- **Primary source:** https://doi.org/10.1109/CDC.2006.377797
- **Version read:** open conference paper
- **Bibliography key:** `jones2006lcp`

## Contribution

Jones and Morari formulate multiparametric linear complementarity problems for
positive-semidefinite matrices, covering pLP and convex pQP instances, and
enumerate all full-dimensional solution regions. A lexicographic perturbation
assigns a unique complementary basis to degenerate interiors, and adjacency
exploration reaches every full-dimensional basis region. The result is the
direct precursor generalized and analyzed by Columbano, Fukuda, and Jones.

## Guarantees and boundary

The full-dimensional regions have disjoint interiors and their closures cover
the parameter domain under the paper's assumptions. The enumeration is
complete for the perturbed basis representation, while boundary-only solution
sets are not separate outputs. The paper calls the procedure output-sensitive
but does not provide the later closed per-output formulas.

The basis and its inequalities determine a dense optimization critical region.
There is no requested-result demand, structurally absent selection coordinate,
typed shared graph, contextual event identity, or residual for a general pure
dataflow computation.

## Evidence locations

- Abstract and Section I: pLCP class and inclusion of pLP/pQP.
- Section II and Theorem 2: polyhedral solution regions, coverage, and interior
  separation.
- Section III and Algorithm 1: adjacency enumeration and completeness.
- Final discussion: output-sensitive framing and scope limitations.
