# masden2022algorithmic — Algorithmic Determination of the Combinatorial Structure of ReLU Regions

- **Status:** deep-read; critical richer-region predecessor
- **Primary source:** https://doi.org/10.1137/24M1646996
- **Version read:** 2025 publication metadata, abstract, and 42-entry bibliography;
  arXiv v1 for the full theorem and algorithm text
- **Bibliography key:** `masden2022algorithmic`

## Why it matters

Masden computes a strictly richer object than a list of full-dimensional
activation patterns: the cells in every dimension of a ReLU network's
canonical polyhedral complex and their complete face poset. This establishes
that ternary sign sequences and exact lower-dimensional structure are already
developed in the neural-region literature.

## Object and sign semantics

Definition 13 assigns every cell a sign sequence in
\(\{-1,0,1\}^N\), using the signs of all node maps. Theorem 14 proves that
this map is well-defined and injective. Under genericity and
supertransversality, Lemma 16 identifies the number of zeros with the cell's
codimension. Here `0` has a third meaning distinct from both Balestriero and
our observer: the cell geometrically lies *on* the corresponding bent
hyperplane.

Theorem 15 shows that the set of dense binary activation patterns of
full-dimensional regions does not determine cell adjacency or decision-boundary
topology. The richer ternary complex is needed for that purpose.

## Algorithm and guarantee

The layerwise algorithm begins with first-layer hyperplane intersections. For
each earlier cell and each later layer, it solves systems combining \(k\) new
bent hyperplanes with \(n_0-k\) earlier face hyperplanes and retains exactly
the sign-compatible intersections. Lemma 23 characterizes all new vertices
and supplies the layerwise completeness test. The sign-labeled vertices then
determine the full face poset through the paper's cubical-duality results.

The main results require fully connected feedforward ReLU networks,
genericity, supertransversality, and at least \(n_0\) first-layer neurons for
the strongest duality statement. Numerical correctness also assumes solve
error is small relative to cell size.

The publication describes expected polynomial behavior in the number of
intermediate neurons for random initialization, while dependence on input
dimension is exponential. This is not a worst-case polynomial bound for an
arbitrary trained network.

## Relationship to selection observations

The paper defeats novelty claims for ternary structural regime labels, exact
cell-complex extraction, and face-poset reconstruction. Every neural node
contributes a sign coordinate, including boundary zeros. It does not define
requested-root-relative structural absence over an arbitrary typed graph.

A varying sparse domain is not by itself a separator because decision-tree
paths already have that shape. The remaining distinction must include the
graph-derived observer, contextual site identity, exact fibers, typed
residuals, and shared composition.

Our observation is intentionally coarser than Masden's cell complex along
geometric boundaries but can be finer than extensional output functions by
retaining equal-valued selected outcomes. The objects answer different
questions and neither should be called simply "the canonical partition"
without a fixed equivalence relation.

## Evidence locations

- Definitions 10--13 and Lemma 12, paper pp. 3--4 and appendix: genericity,
  supertransversality, and sign sequences.
- Theorems 14--15 and Lemma 16, pp. 3--4 and appendix: injectivity,
  insufficiency of binary patterns, and codimension.
- Theorem 20 and Lemma 21, pp. 4--5: cubical dual and face reconstruction.
- Lemmas 22--23 and Section 4.1, pp. 6 and appendix: layerwise enumeration.
- Section 4.3, p. 7: numerical and complexity qualifications.
