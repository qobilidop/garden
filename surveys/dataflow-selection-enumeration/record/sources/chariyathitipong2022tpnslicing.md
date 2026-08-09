# chariyathitipong2022tpnslicing — MTL-directed Time Petri-net slicing

- **Status:** screened; property-directed omission boundary
- **Primary source:** https://doi.org/10.1109/ACCESS.2022.3170094
- **Version read:** open IEEE Access article
- **Bibliography key:** `chariyathitipong2022tpnslicing`

## Evidence locations

- Abstract: the slice is computed from an initial marking and a target Metric
  Temporal Logic property, removing transitions irrelevant to that property.
- Algorithm 2: the dependency graph and the set of transitions that may fire
  drive the retained subnet.
- Evaluation: the sliced and original nets are checked for equivalent results
  on the selected property while the slice reduces verification cost.

## Relationship and evidence limit

This is an explicit observer-relative omission method over a timed concurrent
model. Its preservation statement is for execution paths needed to decide one
MTL property. It does not enumerate every observer value, inverse caller-input
fiber, or symbolic program residual.
