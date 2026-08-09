---
citekey: columbano2009sufficient
work:
  title: "An Output-Sensitive Algorithm for Multi-Parametric LCPs with Sufficient Matrices"
  author: "Sebastiano Columbano, Komei Fukuda, Colin N. Jones"
  venue: "Polyhedral Computation"
  date: 2009
  doi: 10.1090/crmp/048/04
read: full-text
source: "Open author manuscript (arXiv:0807.2318) corresponding to the published chapter, https://doi.org/10.1090/crmp/048/04"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Gives a generic graph traversal for multi-parametric LCPs with sufficient matrices — covering parametric LP and convex parametric QP — enumerating full-dimensional critical domains with explicit per-output LP-oracle work; the strongest closed output-sensitive bound in the direct pLP/pQP lineage, superseding claims that the Jones reverse-search formula was the last explicit bound before degeneracy-safe pQP traversal."
---

# An Output-Sensitive Algorithm for Multi-Parametric LCPs with Sufficient Matrices

## Evidence

### Why it matters

Columbano, Fukuda, and Jones give a generic graph traversal for
multi-parametric linear complementarity problems with sufficient matrices, a
class that includes parametric linear programs and convex parametric quadratic
programs. The algorithm enumerates full-dimensional critical domains and gives
explicit LP-oracle work per reported perturbed basis. This is the strongest
closed output-sensitive bound located in the direct pLP/pQP lineage and
supersedes any statement that the Jones reverse-search formula was the last
explicit bound before degeneracy-safe pQP traversal.

### Object and traversal

The paper represents a solution by a complementary basis of the pLCP. In
general position, adjacent full-dimensional critical domains differ by pivots
found through boundary LPs. For degenerate inputs, lexicographic perturbation
constructs a graph of perturbed bases and a postprocessing map recovers an
unperturbed cover. The traversal stores discovered feasible bases to avoid
repetition; unlike reverse search, its auxiliary state grows with the explored
output.

Sufficient matrices cover positive-semidefinite pLCPs obtained from pLP and
convex pQP formulations. The output remains a dense optimization partition:
it does not model requested roots, structurally unobserved graph sites,
context-qualified occurrence identity, or equal-valued internal events.

### Complexity

Let the pLCP have dimension (n) and parameter dimension (d). Theorem 6.1
charges each general-position output by

\[
  n T_{LP}(n,d+1)
  + \frac{n^2-n}{2}T_{LP}(2n,d+1).
\]

Theorem 6.2 charges each output of the lexicographically perturbed algorithm by

\[
  (n^2+n)T_{LP}(n,d+1)
  + \frac{n^3-n}{2}T_{LP}(2n,d+1).
\]

Multiplying by the corresponding number of emitted bases gives the total
bound. The degenerate count is the number of perturbed basis outputs, which can
exceed the number of unperturbed critical domains. The analysis treats LP as
an oracle, gives no coefficient-bit or DelayP theorem, retains an output-sized
visited set, and omits lower-dimensional-only regions.

### Evidence locations

- Sections 2–4: sufficient-matrix pLCP model, critical domains, adjacency, and
  general-position traversal.
- Section 5: lexicographic perturbation and recovery of the unperturbed cover.
- Theorems 6.1 and 6.2: the two explicit per-output LP-oracle formulas.
- Conclusion: input-polynomial and output-linear framing, with the caveat that
  the perturbed output can be larger than the unperturbed representation.

## Bearing on RQs

Exact, degeneracy-safe, output-sensitive full-dimensional pLP/pQP region
enumeration is established prior art. The dataflow synthesis can compare its
different observer and representation, but cannot claim priority for generic
output-sensitive enumeration or a first degeneracy-safe bound.

## Evidence limits

Read at full-text (author manuscript) level; the source note recorded no
dedicated evidence-limits section beyond the complexity caveats already stated
in the Evidence section above (LP treated as an oracle, no coefficient-bit or
DelayP theorem, output-sized visited-state overhead, and lower-dimensional
regions omitted).
