---
citekey: fisler2002bisimulation
work:
  title: "Bisimulation Minimization and Symbolic Model Checking"
  author: "Kathi Fisler, Moshe Y. Vardi"
  venue: "Formal Methods in System Design"
  date: 2002
  doi: 10.1023/a:1016091902809
read: full-text
source: "Journal full text via https://doi.org/10.1023/A:1016091902809"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Blocks any presumption that an exact observer quotient is automatically an algorithmic win: BDD bisimulation minimization can cost more than checking the target invariant directly"
---

# Bisimulation Minimization and Symbolic Model Checking

## Evidence

### Evidence locations

- Construction: compute a BDD bisimulation quotient relative to selected
  atomic propositions before invariant checking.
- Analysis and experiments: minimization can cost more than checking the
  invariant directly and often does not improve the downstream BDD problem.

## Bearing on RQs

This blocks any presumption that an exact observer quotient is automatically
an algorithmic win.

## Evidence limits

- Its quotient is a transition-system preprocessing step.
