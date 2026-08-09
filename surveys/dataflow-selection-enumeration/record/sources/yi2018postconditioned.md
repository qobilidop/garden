# yi2018postconditioned — Postconditioned path subsumption

- **Status:** deep-read; exact path-redundancy reduction
- **Primary source:** https://doi.org/10.1109/TSE.2017.2659751
- **Version read:** author-hosted accepted journal full text
- **Bibliography key:** `yi2018postconditioned`

## Evidence locations

- Construction: weakest-precondition summaries of explored suffixes are
  propagated backward and used to detect when a new path condition is already
  covered by prior behavior.
- Preservation result: the subsumed suffix can be pruned while retaining the
  bounded exhaustive-path objective under the paper's assumptions.

## Relationship and evidence limit

This is exact semantic omission of redundant path suffixes. Its unit remains a
CFG path and postcondition summary, not an observation value with its complete
caller-input fiber and typed graph residual.
