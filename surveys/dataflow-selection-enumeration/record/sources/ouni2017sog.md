# ouni2017sog — Symbolic observation graph

- **Status:** screened; close observer-sensitive state-space boundary
- **Primary source:** https://doi.org/10.29007/7B44
- **Version read:** primary abstract, construction description, and proceedings metadata
- **Bibliography key:** `ouni2017sog`

## Evidence locations

- Abstract and paper description: system transitions are divided into observed
  and unobserved classes. Graph nodes are sets of states connected through
  unobserved transitions and encoded symbolically with BDDs; graph edges retain
  observed transitions explicitly.
- Proceedings metadata: SCSS 2017, EPiC Series in Computing 45, pp. 107--119.

## Relationship and evidence limit

This is a close structural use of an explicit observer to compact a state
graph. Its aggregates are system-state sets used for model checking, not
inverse sets of caller inputs. The construction does not attach a general
program residual to each observation or claim complete sparse input-fiber
enumeration.
