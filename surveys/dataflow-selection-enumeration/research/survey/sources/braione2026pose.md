# braione2026pose — Path-optimal heap symbolic execution

- **Status:** deep-read; up-front conditional-state comparator
- **Primary source:** https://doi.org/10.1109/SANER67736.2026.00112
- **Version read:** arXiv v2 / SANER author version, pp. 1--12
- **Bibliography key:** `braione2026pose`

## Evidence locations

- Introduction and Section III: POSE embeds all current heap-alias and
  distinctness alternatives in `ite` expressions and forks only at actual
  program decisions, rather than at lazy-initialization choices.
- Section IV: on 692 supported Java methods, the implementation reports one
  symbolic trace per observed program path and reductions of several orders of
  magnitude relative to classic lazy initialization.
- Threats to validity: the authors explicitly leave a formal soundness and
  completeness proof relative to GSE for future work; the exact-path counts
  were manually cross-checked only for a sample.

## Relationship and evidence limit

POSE is a direct recent instance of synthesizing merged conditional values
before splitting alternatives. Its path-optimality claim is formalized and
empirically supported, but semantic equivalence to GSE is not yet proved. It
does not enumerate exact observation fibers or typed residuals.
