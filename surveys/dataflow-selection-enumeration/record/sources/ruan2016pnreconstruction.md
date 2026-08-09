# ruan2016pnreconstruction — Petri-net reconstruction from observations

- **Status:** screened; observation-to-model inference boundary
- **Primary source:** https://doi.org/10.1109/COASE.2016.7743519
- **Version read:** publisher abstract and proceedings metadata
- **Bibliography key:** `ruan2016pnreconstruction`

## Evidence locations

- Abstract: the input is a finite asynchronous collection of observed token-
  change sequences with implicit initial-marking and place-count information.
- Abstract: the reconstruction algorithm is polynomial in the number of net
  transitions.
- Abstract: it finds structures minimizing transitions and incident-matrix
  connections and incrementally checks future observations against the model.

## Relationship and evidence limit

This infers an unknown Petri-net structure from observations. It does not start
from a known pure program, enumerate its requested observations, or return exact
symbolic input guards and residual computations.
