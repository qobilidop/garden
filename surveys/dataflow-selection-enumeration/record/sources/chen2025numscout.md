# chen2025numscout — LLM-pruning symbolic execution

- **Status:** deep-read; approximate target-guided boundary
- **Primary source:** https://doi.org/10.1109/TSE.2025.3555622
- **Version read:** primary arXiv/full version and journal metadata
- **Bibliography key:** `chen2025numscout`

## Evidence locations

- Architecture: an LLM classifier removes functions judged irrelevant to
  requested numerical defects before focused symbolic execution.
- Limitations and evaluation: pruning is predictive and may discard relevant
  code; effectiveness is empirical.

## Relationship and evidence limit

The requested defect controls omission, but the method is explicitly
approximate and does not partition all inputs by a finite observer.
