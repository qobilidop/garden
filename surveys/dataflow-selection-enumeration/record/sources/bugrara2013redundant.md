---
citekey: bugrara2013redundant
work:
  title: "Redundant State Detection for Dynamic Symbolic Execution"
  author: "Suhabe Bugrara, Dawson Engler"
  venue: "USENIX ATC 2013"
  date: 2013
source: "Open-access USENIX ATC full text at https://www.usenix.org/conference/atc13/technical-sessions/presentation/bugrara"
read: full-text
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "A sound, requested-observation-relative state-pruning reduction for dynamic symbolic execution that targets new code locations rather than enumerating every observation value with its exact inverse input guard"
---

# Redundant State Detection for Dynamic Symbolic Execution

## Evidence

### Evidence locations

- Algorithm and soundness: a state is pruned when analysis proves that no
  continuation can reach a code observation not already covered; dynamic
  symbolic execution otherwise proceeds normally.

## Bearing on RQs

This is a close requested-observation reduction with a sound omission rule.

## Evidence limits

- It seeks new code locations rather than enumerating every observation value
  and its exact inverse input guard.
