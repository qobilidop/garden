# bertossi2023shap — Efficient Computation of SHAP Explanation Scores for Neural Network Classifiers via Knowledge Compilation

- **Status:** deep-read; exact BNN knowledge-compilation comparator
- **Primary source:** https://doi.org/10.1007/978-3-031-43619-2_4
- **Version read:** arXiv:2303.06516v3, 23 July 2023
- **Bibliography key:** `bertossi2023shap`

## Why it matters

Bertossi and Leon compile the final Boolean function of a binarized neural
network into a deterministic decomposable Boolean circuit suitable for exact
SHAP-score computation. The construction is another direct predecessor for
extensional neural-output compilation: internal neuron values are substituted
away, the final circuit is equivalent to the classifier, and repeated queries
operate on a shared compiled representation.

## Program and semantic model

The model is a fully binarized feed-forward classifier. Inputs and hidden
outputs lie in `{−1,1}`, the single output is Boolean, and each neuron is a
linear threshold gate with binary weights and a real bias. The observer is only
the final binary class function over the complete finite input cube. Internal
activation identities and a typed symbolic output residual are not retained.

## Results, algorithm, and guarantees

Section 3 constructs an auxiliary-variable-free propositional definition of
each threshold gate by counting how many input signs agree with their weights.
Definitions are substituted layer by layer into the final output and converted
to CNF. The CNF is compiled into an SDD; interpreting SDD decision nodes as
disjunctions and elements as conjunctions gives a deterministic decomposable
NNF circuit. A final smoothing transformation yields the circuit class used by
the exact SHAP algorithm.

Every step is semantics preserving, so the final circuit computes the same
Boolean label as the BNN. The experiment checks this directly: black-box BNN,
black-box compiled circuit, and open-box compiled-circuit computations return
the same SHAP scores. The paper presents the construction and equivalence
argument rather than a separately numbered whole-network theorem.

## Complexity

The gate-formula and CNF construction can expand combinatorially. Compiling CNF
to SDD is the dominant step and is exponential in the primal graph's treewidth;
the authors present this as a fixed-parameter qualification, not a polynomial
whole-network guarantee. Converting SDD to d-DNNF is linear in SDD size, and
the final smoothing algorithm is quadratic in circuit edges. In the reported
13-feature, one-hidden-layer experiment, initial CNF construction took about
1.3 hours, while later SDD/circuit use made repeated exact SHAP computation
substantially faster.

## Relationship to our hypothesis

The work defeats any claim that exact neural output compilation is limited to
OBDDs or that auxiliary hidden activations must survive in the representation.
It also reinforces the importance of charging compilation time and compiled
circuit size. It does not preserve the requested-root partial map of contextual
internal selection events, support arbitrary typed pure IR, or attach a typed
symbolic residual per event fiber.

## Evidence locations

- Section 2 and Equation (3): binary threshold-network and Boolean-circuit
  semantics.
- Section 3.1, Equations (4)--(9): exact threshold formulas, internal
  substitution, and auxiliary-variable-free CNF construction.
- Section 3.2: SDD compilation and the treewidth-dependent exponential bound.
- Section 3.3 and its algorithm: deterministic decomposable circuit conversion
  and quadratic smoothing.
- Section 4 and Figure 4: faithful BNN/circuit outputs, exact SHAP equality, and
  compilation/query timing.

## Questions and limitations

- Exactness is for a finite binary input/output classifier, not real-valued
  networks.
- The final circuit intentionally erases internal activation provenance.
- The construction has no OutputP, DelayP, or polynomial total-size theorem.
