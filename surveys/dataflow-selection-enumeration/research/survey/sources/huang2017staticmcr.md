# huang2017staticmcr — Static-dependency maximal causality reduction

- **Status:** screened; dependency-guided causal schedule reduction
- **Primary source:** https://doi.org/10.4230/LIPIcs.ECOOP.2017.16
- **Version read:** official Dagstuhl abstract, contribution summary, and metadata
- **Bibliography key:** `huang2017staticmcr`

## Evidence locations

- Abstract and contribution summary: static dependency information removes
  constraints over reads on which a later event is not control-dependent.
- Abstract: the method explicitly addresses redundancy introduced by the
  static analysis while reducing MCR constraint construction and solving cost.

## Relationship and evidence limit

This is property- and dependency-sensitive optimization inside a causal
schedule quotient. It neither defines a caller-input observer nor attaches a
typed residual to each equivalence class.
