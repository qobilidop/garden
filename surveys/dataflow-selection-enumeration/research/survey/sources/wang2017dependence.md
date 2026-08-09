# wang2017dependence — Dependence Guided Symbolic Execution

- **Status:** deep-read; critical predecessor
- **Primary source:** https://doi.org/10.1109/TSE.2016.2584063
- **Version read:** authors' TSE manuscript, https://se-lab.cs.wmich.edu/static/pdf/DGSE.pdf
- **Bibliography key:** `wang2017dependence`

## Why it matters

Dependence-guided symbolic execution (DGSE) directly develops the thesis that
paths can be pruned when all symbolic values at their statement instances have
already been covered collectively by other paths. It then gives a practical
dependence approximation, a formal fault-detection theorem, and an independent
choices example reducing `2^N` paths to `N+1`. It is mandatory prior art for
both value-directed enumeration and redundant-product avoidance.

## Program and semantic model (RQ1, RQ7)

The paper uses an imperative program CFG `(N,E)` and conventional dynamic
symbolic execution with generated test inputs. Branch outcomes are treated as
nodes. A symbolic value at a statement instance is the symbolic expression
relating that instance to symbolic inputs.

The soundness proof assumes that potential faults are represented as
conditional `abort` statements, the solver returns sound decisions rather than
`UNKNOWN`, and path-specific dependences are determined precisely. The Java
prototype combines Symbolic PathFinder with Indus and an interprocedural static
dependence analysis. Conservative alias/dependence overapproximation can retain
redundant paths but is intended not to lose distinctive ones; resource bounds
and unsupported solver theories can still lose paths.

## Exact value criterion and dependence approximation (RQ2–RQ3)

The ideal criterion is statement-local and collective. A new path is redundant
when every symbolic value at every statement instance on it has appeared at
the corresponding instance on some previously explored path; no single prior
path need subsume the whole new path.

Direct expression storage, equivalence checking, and predicting unseen
redundancy are considered impractical. DGSE replaces exact symbolic-value
equivalence with *relevant path slices*. The slice for node `n` contains the
trace nodes transitively connected to `n` by dynamic control, data, potential,
or interactive dependence. Its branch nodes form the *relevant path
condition*. A path is redundant (Definition 6) when all its node-specific
relevant slices are collectively contained in those of explored paths.

Irrelevant preceding branch constraints are omitted. This is not an
output-only quotient: every statement instance may serve as an observer, so
faults unrelated to the final output can remain covered.

## Dependences and algorithm

Definitions 1–3 adapt branch-sensitive control, data, and potential dependence.
Definition 4 adds *interactive dependence*: two earlier nodes interact when
they can occur on one path and a later node depends simultaneously on both.
This recursive relation is needed because ordinary dependences do not preserve
the prefix-like exploration property; omitting it can miss a division-by-zero
example.

`DGSymbolicExec` (Algorithm 2) maintains solver tasks `(pcon,psi)`. After an
execution, `DGPathExec`:

1. replaces each full path prefix by the relevant path condition for the
   opposite branch; and
2. after the initiating constraint, negates only branches transitively
   dependent on that initiating branch.

Algorithm 3 computes interactive dependence by a pair-reaching-definition
analysis followed by a worklist closure.

## Guarantees (RQ4)

- Lemma 5.1 proves that adjacent nodes in a relevant path slice have a
  transitive-dependence relation.
- Lemma 5.2 proves that every relevant path slice lying on a feasible path
  explored by conventional symbolic execution is covered by some feasible path
  explored by DGSE.
- Theorem 5.3 concludes that every conditional-abort fault detectable by
  traditional symbolic execution is detectable by DGSE.

The theorem is reachability/fault completeness, not equality between the exact
symbolic-value quotient and DGSE's approximation. It does not enumerate
canonical cases or prove guard disjointness, uniqueness, or minimality.

## Residuals, witnesses, and sharing (RQ5)

Solver-generated test inputs are witnesses. DGSE deliberately does not store
symbolic values, residual expressions, or a shared result graph; relevant
slices stand in for expression equality. Its collective-coverage relation can
use different paths for different statement values.

## Complexity and performance (RQ6)

Algorithm 3 has stated `O(n^3)` complexity in CFG nodes; the preceding
pair-reaching-definition analysis is polynomial. Path exploration remains
exponential in tightly dependent programs. For `N` independent conditionals,
traditional symbolic execution explores `2^N` paths while DGSE explores
`N+1`: one all-true path and one path flipping each independent branch.

Across terminating experiments, DGSE explored 6.96%–96.57% of Symbolic
PathFinder's total paths and achieved 1.02x–49.56x speedups. For Schedule with
six inputs it explored 8,191 rather than 117,649 paths; for Replace with eleven
inputs, 10,279 rather than 136,766 total paths. Simpler relevant path
conditions and fewer expensive unsatisfiable queries sometimes made the time
speedup larger than the path-count reduction.

## Motivating examples (RQ8)

Figure 1's two independent absolute-value computations show collective value
coverage: the mixed path contributes no new statement value even though no
single earlier path matches it. Figure 4 generalizes this to the `2^N` versus
`N+1` family. Figure 2 contrasts DGSE with PESO: an output-only criterion can
miss an earlier crash, whereas all-statement value coverage retains it.

## Relationship to PESO, SPD, and our hypothesis

### What is directly established by the work?

Collective coverage of statement-level symbolic values as a path-redundancy
criterion; a dependence-based exploration that preserves conditional-abort
fault detection under stated assumptions; sparse relevant path conditions; and
an explicit independent-product reduction.

### What is our interpretation or inference?

The ideal value criterion is broader than our result observation because it
treats every statement as a potential fault site, but it is coarser about
provenance because equal symbolic values are interchangeable. A selection
observation instead retains an observed site's outcome even when both arms have
equal residual values, and omits sites structurally inactive for the requested
result.

PESO partitions executions by one requested output's relevant slice and proves
that an RSC fixes that output. DGSE seeks all-statement fault coverage and uses
collective slice coverage. SPD statically computes query-specific path families
and guarded residual values; DGSE dynamically explores witnesses and stores no
residual graph.

### Could it subsume our proposed contribution?

It subsumes broad claims that symbolic-value coverage and dependence-guided
partial conditions can avoid independent path products. It does not directly
produce exact selection-observation fibers, residual values, compositional
summaries, or one canonical record per observation. Those narrower differences
must be formalized; “value-directed symbolic execution” is not a viable novelty
claim.

## Evidence locations

- Sections 1 and 3, Figures 1–2: exact symbolic-value intuition, collective
  coverage, fault-oriented motivation, and PESO comparison.
- Section 4, Definitions 1–3: branch-sensitive control, data, and potential
  dependence.
- Sections 5.1–5.2, Definitions 4–7 and Algorithms 2–3: interactive
  dependence, relevant slices/conditions, redundancy, exploration, and
  dependence computation.
- Section 5.3, Lemmas 5.1–5.2 and Theorem 5.3: fault-detection soundness.
- Section 5.1, Figure 4: `2^N` versus `N+1` independent choices.
- Section 6, Tables 5–7: path counts, speedups, solver calls, and costs.
- Sections 7 and 9: conservative analysis, solver limitations, program
  coupling, and future work.

## Questions and possible weaknesses

- How does the exact statement-value criterion behave when expression equality
  is semantic rather than syntactic?
- Can one characterize the gap between exact value coverage and relevant-slice
  equality, rather than only asserting conservative approximation?
- Does selection-outcome provenance yield a strict refinement of DGSE value
  coverage on pure selection DAGs?
