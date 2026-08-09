# bak2020geometric — Improved Geometric Path Enumeration for Verifying ReLU Neural Networks

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-030-53288-8_4
- **Bibliography key:** `bak2020geometric`

## Result and relationship

Algorithms 1--2 split an input star neuron by neuron and enumerate neural paths
(PDF pp. 4--5; LNCS pp. 69--70). The paper states that the method is sound and
complete and enumerates every network path for the input set (PDF p. 6; LNCS
p. 71), relying on the earlier star-reachability result. Stars carry affine
generators and predicates (PDF p. 7).

This is complete exact dense sign-path enumeration with an affine residual
encoding, but not a sparse demand-relative graph observation.
