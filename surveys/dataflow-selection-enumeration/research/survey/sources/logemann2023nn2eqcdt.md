# logemann2023nn2eqcdt — NN2EQCDT

- **Status:** deep-read
- **Primary source:** https://www.thinkmind.org/articles/cognitive_2023_4_10_40107.pdf
- **Version read:** COGNITIVE 2023 proceedings paper, pp. 94--100
- **Bibliography key:** `logemann2023nn2eqcdt`

## Why it matters

NN2EQCDT constructively transforms a feed-forward ReLU policy into a decision
tree while pruning infeasible paths and forced tests. It is the algorithmic
base of Logemann and Veith's later exact-output-region analysis.

## Program and semantic model

The method symbolically propagates effective weight and bias matrices through
a feed-forward ReLU network. Tree paths contain affine ReLU tests; leaves carry
the remaining affine expressions or action output. SMT/LP feasibility checks
discard contradictory path extensions.

## Results, algorithm, and guarantees

The construction expands the layer-local ReLU tests, checks each candidate
path dynamically, and removes rules that have a constant result over all
inputs satisfying the path. Invariants can be added as domain constraints.
The paper describes the transformation as equivalent and lossless, but gives
no numbered global pointwise-equivalence theorem. Validation is by construction
argument and sampled agreement in the implementation and examples.

## Complexity

The unpruned toy network would yield 262,143 nodes; satisfiability and
unnecessary-rule pruning reduce the reported tree to 83 nodes in 9.75 seconds,
described as 99.97 percent compression. These are empirical figures, not a
general polynomial bound. Worst-case branching remains exponential.

## Relationship to our hypothesis

The path is already a demand-populated partial test record, and each leaf can
be converted to a guard/residual pair. It defeats novelty for infeasibility
pruning and forced-test elimination in exact neural-policy trees. The paper
does not establish arbitrary typed graph semantics, requested-root closure, or
contextual identity under DAG sharing.

## Evidence locations

- Section II, pp. 95--96: effective-matrix ReLU/tree correspondence.
- Section III and Figure 1, pp. 96--98: recursive conversion, satisfiability
  pruning, and unnecessary-rule removal.
- Section IV, pp. 98--99: implementation and compression experiment.
- Section V, pp. 99--100: Mountain Car policy visualization and limitations.

## Questions and possible weaknesses

- The word *equivalent* is stronger than the formal proof presented in this
  short paper; the manuscript should distinguish the constructive claim from
  Chang et al.'s later explicit pointwise theorem.

