# bugrara2013redundant — Observation-specific redundant-state detection

- **Status:** deep-read; exact code-observation pruning
- **Primary source:** https://www.usenix.org/conference/atc13/technical-sessions/presentation/bugrara
- **Version read:** open-access USENIX ATC full text
- **Bibliography key:** `bugrara2013redundant`

## Evidence locations

- Algorithm and soundness: a state is pruned when analysis proves that no
  continuation can reach a code observation not already covered; dynamic
  symbolic execution otherwise proceeds normally.

## Relationship and evidence limit

This is a close requested-observation reduction with a sound omission rule.
It seeks new code locations rather than enumerating every observation value and
its exact inverse input guard.
