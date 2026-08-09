# tang2026boolean — Toward Global Interpretability of Neural Networks via Boolean Transformation

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1016/j.neunet.2026.109419
- **Version read:** publisher HTML, available online 21 July 2026
- **Bibliography key:** `tang2026boolean`

## Why it matters

This work extends neuron-wise ABDD conversion to residual and attention
structures and multiclass outputs, and proposes a more aggressive
equivalent-interval merge that produces smaller diagrams empirically.

## Results and boundary

Binary residual and attention networks are transformed componentwise into
equivalent ABDDs, Boolean circuits, and SDDs. The authors also study real-valued
sigmoid networks through parameterized binarization. That extension has a
bounded approximation error; it is not a literal exact compilation of an
arbitrary real-valued network despite broad equivalence language in the
abstract and introduction.

No full-network OutputP or delay theorem is stated. The main new evidence is
constructive equivalence for the binary architectural components and empirical
diagram reduction.

## Relationship to our hypothesis

The exact binary scope broadens the compiled-observer lineage to skips and
attention. The real-valued scope is only approximate. Neither preserves a
sparse requested internal-event observer with contextual shared-DAG identity.

## Evidence locations

- Sections 3--4: component definitions, ABDD construction, and residual/
  attention Boolean transformations.
- Circuit and SDD construction subsection: exact binary symbolic composition.
- Real-valued-network subsection and experiments: sigmoid conversion and
  bounded approximation error.
- Conclusion: claimed architectural scope and future scaling limits.

## Questions and possible weaknesses

- The manuscript must not repeat the broad *general neural network equivalent*
  wording without separating exact binary conversion from approximate
  real-valued conversion.

