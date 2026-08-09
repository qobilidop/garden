# cha2020homi — Learned aggressive state pruning

- **Status:** deep-read; approximate coverage-guided boundary
- **Primary source:** https://doi.org/10.1145/3368089.3409755
- **Version read:** author-hosted ESEC/FSE 2020 full text
- **Bibliography key:** `cha2020homi`

## Evidence locations

- Sections 2--3: maintain only a small state subset predicted to improve code
  coverage or reach bugs and update the pruning policy online.
- Evaluation: compares the learned policy with KLEE on C programs.

## Relationship and evidence limit

Homi establishes learned observation-guided omission but deliberately loses
states. It supplies no exact quotient or completeness result.
