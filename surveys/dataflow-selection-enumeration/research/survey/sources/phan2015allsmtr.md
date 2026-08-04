# phan2015allsmtr — All-Solution Satisfiability Modulo Theories

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1109/ARES.2015.14
- **Version read:** IEEE proceedings PDF
- **Bibliography key:** `phan2015allsmtr`

## Why it matters

This work states the direct solver-level reduction against which any claim of
exhaustive selection-configuration enumeration must be compared: enumerate
models of an SMT formula with respect to chosen Boolean variables and return
values for chosen non-Boolean variables.

## Program and semantic model

The input is a theory formula `phi`, a set `VI` of important Boolean
variables, and a set `VR` of relevant, possibly non-Boolean variables. The
output consists of every Boolean valuation of `VI` extendable to a theory
model of `phi`, with model values for `VR`.

Program analysis is an application rather than the formal core. The paper
obtains formulas and important predicates from bounded model checking and
symbolic execution.

## Main definitions

The extended problem `All-SMT(phi, VI, VR)` computes all models of `phi` with
respect to `VI`; each model also includes a value assignment for `VR`.
Unimportant Boolean variables are not part of the enumerated observation.

## Results and guarantees

Algorithms 1 and 2 enumerate distinct assignments over `VI` by adding a
blocking clause after each model. Algorithm 3 performs a depth-first search
over the important variables. The experiments compare all three approaches
with MathSAT and independently compare the number of results.

The paper calls its implementation more precise than the evaluated MathSAT
version, but it does not establish a general complexity or optimal-delay
theorem.

## Algorithm

The basic method repeatedly obtains a model, records its values on `VI` and
`VR`, and blocks the Boolean valuation on `VI`. The depth-first variant uses
the solver stack to explore assignments to important variables without
retaining every blocking clause.

## Complexity

The number of observations is exponential in `|VI|` in the worst case. The
comparison is empirical; the paper emphasizes avoiding repeated solver setup
and reducing blocking-clause overhead.

## Terminology

Established terms include *All-SMT*, *important Boolean variables*,
*relevant variables*, *blocking clause*, and *model*.

## Motivating example

The paper encodes symbolic program paths by Boolean branch variables and asks
AllSMT to enumerate their feasible valuations in one analysis. This is a
direct predecessor to treating selection outcomes as important predicates.

## Relationship to our hypothesis

### What is directly established by the work?

An SMT solver can exhaustively enumerate selected Boolean observations and
return witnesses or values for selected theory variables.

### What is our interpretation or inference?

For each selection occurrence `q`, introduce predicates encoding whether the
site is inactive or which outcome it takes. If ordinary graph equations
constrain those predicates as total functions of the input, AllSMT enumerates
the exact selection observations, and a returned input valuation is a
witness.

### Could it subsume our proposed contribution?

It subsumes the broad enumeration-and-witness problem after instrumentation.
It does not itself define graph-relative activity, preserve residual graph
values, or exploit compositional graph summaries. Those differences matter
only if they support a nontrivial semantic theorem or algorithmic advantage.

## Evidence locations

- Abstract and Introduction, pp. 100–101: problem, applications, and claimed
  contributions.
- Section II.A, pp. 101–102: formal `All-SMT(phi, VI, VR)` definition.
- Algorithms 1–3, pp. 102–104: blocking and depth-first enumeration.
- Section IV, pp. 105–108: benchmark methodology and empirical comparison.

## Questions and possible weaknesses

- Boolean observations are total assignments over `VI`; structural inactivity
  therefore needs an explicit value or activation variable.
- The result-value mechanism returns concrete model values, not a residual
  symbolic function valid over a whole observation region.
