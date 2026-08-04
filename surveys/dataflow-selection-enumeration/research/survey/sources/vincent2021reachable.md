# vincent2021reachable — Reachable Polyhedral Marching

- **Status:** deep-read; critical guard-plus-residual predecessor
- **Primary source:** https://doi.org/10.1109/ICRA48506.2021.9561956
- **Version read:** arXiv v2, 1 April 2021
- **Open copy:** https://arxiv.org/abs/2011.11609
- **Bibliography key:** `vincent2021reachable`

## Why it matters

Reachable Polyhedral Marching (RPM) enumerates every feasible ReLU activation
pattern together with its exact input polyhedron and affine output map. It is
the strongest adjacency-oriented pre-Balestriero analogue of an
`(observation, guard, residual)` enumerator, but it is not the earliest exact
guard-plus-affine method: Tran's stars, Robinson's explicit piecewise-affine
conversion, and other reachability constructions precede it.

## Mathematical object

For an activation pattern \(a\), equations (8)--(12) derive:

- the affine map \(C_a x+d_a\) realized by the whole network; and
- an H-representation of the convex input cell on which that pattern holds.

Redundant halfspaces are removed by linear programming. Remaining essential
constraints are facets and identify adjacent cells. The output is therefore
an explicit piecewise-affine representation, not merely a count.

## Algorithm

Algorithm 1 computes the activation pattern across a facet, including cases
where a zero affine constraint causes downstream or degenerate units to change
together. Algorithm 2 starts from one interior point, emits its cell-local
affine map and minimized H-representation, constructs each neighboring
pattern, and performs a work-list traversal while suppressing patterns already
visited or queued.

The paper argues completeness because the polyhedral input cells form a
connected adjacency complex and the traversal visits every neighbor of every
reached cell. The conference version states this argument in prose rather than
as a numbered theorem. A later extended version supplies a formal
neighbor-pattern theorem and appendix proof.

## Complexity and assumptions

There is no end-to-end asymptotic theorem. Each emitted region can require up
to one redundancy LP per hidden neuron plus neighbor construction and set
membership. Total work is necessarily output-sensitive in the number of
activation cells and can be exponential in network size. The implementation
stores activation patterns while allowing emitted cell geometry to be
processed incrementally.

The method assumes a feedforward ReLU network with a linear final layer,
continuous piecewise-affine semantics, a full-dimensional interior seed,
exact-enough LP comparisons, and adjacency through shared codimension-one
faces. It enumerates full-dimensional cells rather than lower-dimensional
boundary cells.

## Relationship to our observer

RPM already returns three artifacts that broad versions of our pitch would
claim: a structural regime identifier, an exact guard, and a residual affine
map. Those artifacts must be acknowledged as prior art.

Its regime identifier is a dense activation vector. Every hidden ReLU is
evaluated in every cell; no coordinate disappears because a selected graph
case lies outside the requested result. RPM also assumes continuous real ReLU
chains rather than arbitrary finite shared graphs, typed bitvectors and
aggregates, contextual sites, and heterogeneous selection operators.

Dynamic sparsity alone is also established by decision-tree paths. The
remaining separator is the requested-root-relative typed shared-graph observer
with contextual site identity and exact inverse fibers—not
guard-plus-residual enumeration or a varying path domain by itself.

## Evidence locations

- Definitions 1--3, paper pp. 2--3: PWA and polyhedral-complex model.
- Equations (8)--(12), pp. 3--4: cell-local affine map and H-representation.
- Algorithm 1, p. 4: neighboring activation pattern.
- Algorithm 2 and completeness argument, pp. 4--5: exhaustive adjacency walk.
- Sections V--VI: forward/backward reachability applications and evaluation.
