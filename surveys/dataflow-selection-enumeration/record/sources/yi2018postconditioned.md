---
citekey: yi2018postconditioned
work:
  title: "Eliminating Path Redundancy via Postconditioned Symbolic Execution"
  author: "Qiuping Yi, Zijiang Yang, Shengjian Guo, Chao Wang, Jian Liu, Chen Zhao"
  venue: "IEEE Transactions on Software Engineering"
  date: 2018
  doi: 10.1109/tse.2017.2659751
read: full-text
source: "Author-hosted accepted journal full text via https://doi.org/10.1109/tse.2017.2659751"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Postconditioned symbolic execution prunes redundant path suffixes already covered by prior weakest-precondition summaries — exact semantic omission whose unit remains a CFG path, not an observation value with a complete caller-input fiber and typed graph residual"
---

# Postconditioned path subsumption

## Evidence

### Evidence locations

- Construction: weakest-precondition summaries of explored suffixes are
  propagated backward and used to detect when a new path condition is already
  covered by prior behavior.
- Preservation result: the subsumed suffix can be pruned while retaining the
  bounded exhaustive-path objective under the paper's assumptions.

## Bearing on RQs

This is exact semantic omission of redundant path suffixes.

## Evidence limits

Its unit remains a CFG path and postcondition summary, not an observation
value with its complete caller-input fiber and typed graph residual.
