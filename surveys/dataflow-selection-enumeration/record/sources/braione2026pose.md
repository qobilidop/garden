---
citekey: braione2026pose
work:
  title: "Path-Optimal Symbolic Execution of Heap-Manipulating Programs"
  author: "Pietro Braione, Giovanni Denaro, Luca Guglielmo"
  venue: "SANER 2026"
  date: 2026
  doi: 10.1109/saner67736.2026.00112
read: full-text
source: "arXiv v2 / SANER 2026 author version via https://doi.org/10.1109/SANER67736.2026.00112"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "POSE is a direct recent instance of synthesizing merged conditional heap-alias/distinctness values before splitting alternatives, with path-optimality formalized and empirically supported but semantic equivalence to GSE not yet proved"
---

# Path-optimal heap symbolic execution

## Evidence

### Evidence locations

- Introduction and Section III: POSE embeds all current heap-alias and
  distinctness alternatives in `ite` expressions and forks only at actual
  program decisions, rather than at lazy-initialization choices.
- Section IV: on 692 supported Java methods, the implementation reports one
  symbolic trace per observed program path and reductions of several orders of
  magnitude relative to classic lazy initialization.
- Threats to validity: the authors explicitly leave a formal soundness and
  completeness proof relative to GSE for future work; the exact-path counts
  were manually cross-checked only for a sample.

## Bearing on RQs

POSE is a direct recent instance of synthesizing merged conditional values
before splitting alternatives. Its path-optimality claim is formalized and
empirically supported.

## Evidence limits

- Semantic equivalence to GSE is not yet proved.
- It does not enumerate exact observation fibers or typed residuals.
