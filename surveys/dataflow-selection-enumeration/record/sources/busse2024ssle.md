# busse2024ssle — Sparse Symbolic Loop Execution

- **Status:** deep-read; observational loop-state postponement comparator
- **Primary source:** https://doi.org/10.1145/3678722.3685535
- **Version read:** FUZZING 2024 registered-report PDF, pp. 61--69
- **Bibliography key:** `busse2024ssle`

## Why it matters

Sparse symbolic loop execution (SSLE) explicitly observes branch-edge patterns
among sibling states spawned by one loop. It immediately explores states with a
new pattern and postpones states whose pattern has already been seen up to a
precomputed loop-impact barrier. It therefore meets the map's broad trigger for
delaying choices judged irrelevant to the current observation, even though its
goal and guarantees differ sharply from exact fiber enumeration.

## Program and semantic model

The setting is execution-generated-tree dynamic symbolic execution of
imperative programs with heavily branching loops. SSLE statically computes a
barrier beyond which loop-modified data can influence control flow, then groups
sibling loop states by their observed taken-edge pattern before that barrier.
The output objective is line or branch coverage and bug finding, not a finite
semantic quotient of all caller inputs.

## Algorithm and guarantees

SparKLE integrates SSLE with KLEE. A state whose edge pattern is unique for its
loop sibling group remains favored; a repeated pattern is postponed and may be
revisited later. The technique is a search heuristic rather than a proof that
two states are semantically equivalent. The registered report does not claim
complete, nonredundant, or exact inverse-fiber enumeration, and postponed states
cannot be treated as permanently eliminated observations.

The preliminary eight-benchmark evaluation reports up to 55 percent additional
line coverage in one-hour runs and, in some cases, postponement of up to 99.997
percent of states without observed coverage loss. The report prospectively
plans a larger evaluation; these figures are empirical, not semantic theorems.

## Relationship to our hypothesis

SSLE defeats any broad suggestion that observation-pattern-guided state
selection is new. Its observer is a heuristic edge-pattern abstraction scoped
to loop siblings, while this paper specifies a complete input-to-selection map,
exact guards, residuals, and a decisive exhaustion condition for finite pure
DAGs.

## Evidence locations

- Abstract and Section 1: loop-state edge-pattern observer and motivation.
- Sections 2--3: loop-impact barrier, sibling grouping, and state postponement.
- Section 4: SparKLE implementation in KLEE.
- Sections 5--6: preliminary eight-benchmark coverage and postponed-state
  results, plus the registered evaluation plan.

## Questions and limitations

- The source is a registered report with preliminary evaluation.
- States are postponed by a heuristic pattern, not merged under proved semantic
  equivalence.
- Loops and unbounded executions are outside the finite-DAG model of this paper.
