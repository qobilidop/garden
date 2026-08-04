# fisler2002bisimulation — Bisimulation minimization and symbolic checking

- **Status:** deep-read; exact quotient and negative-result comparator
- **Primary source:** https://doi.org/10.1023/A:1016091902809
- **Version read:** journal full text
- **Bibliography key:** `fisler2002bisimulation`

## Evidence locations

- Construction: compute a BDD bisimulation quotient relative to selected
  atomic propositions before invariant checking.
- Analysis and experiments: minimization can cost more than checking the
  invariant directly and often does not improve the downstream BDD problem.

## Relationship and evidence limit

This blocks any presumption that an exact observer quotient is automatically
an algorithmic win. Its quotient is a transition-system preprocessing step.
