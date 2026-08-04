# sotoudeh2021syrenn — SyReNN: A Tool for Analyzing Deep Neural Networks

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-030-72013-1_15
- **Bibliography key:** `sotoudeh2021syrenn`

## Result and scope

Definition 4 specifies an exact finite convex-polytope partition on which the
network is linear (PDF p. 4; LNCS p. 284). Algorithms 1--2 perform exact
extension and splitting (pp. 8--9). The scalable precise algorithm is limited
to one- and two-dimensional input unions, while the supported layer vocabulary
includes fully connected, convolutional, ReLU, and concatenation layers; the
paper also identifies MaxPool, LeakyReLU, and HardTanh as piecewise-linear
layers (pp. 4--5, 10).

The work defeats novelty based on exact low-dimensional heterogeneous neural
partitioning. Its artifact is primarily the partition; affine residuals are
recoverable rather than necessarily emitted as explicit matrices.
