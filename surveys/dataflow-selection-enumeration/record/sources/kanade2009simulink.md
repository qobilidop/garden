# kanade2009simulink — Generating and Analyzing Symbolic Traces

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-642-02658-4_33
- **Version read:** author manuscript
- **Bibliography key:** kanade2009simulink

## Why it matters

This is the closest trace-equivalence predecessor in a graphical dataflow
setting. Its discrete state explicitly contains choices of conditional blocks,
and it groups initial states by equal discrete traces.

## Program and semantic model

A Simulink/Stateflow state is \((q,s)\in Q\times\mathbb R^n\). The discrete
component \(q\) includes active Stateflow states and outcomes of conditional
blocks. With a fixed numerical solver and step size, one concrete step is a
deterministic function \(f\).

Instrumented simulation emits \((q',s',P,F)\) such that the seed satisfies
\(P\), \(F\) produces its successor, and every state satisfying \(P\) follows
the same discrete successor and transformer.

## Main definitions

Definition 1 declares two initial states equivalent up to \(k\) steps when
their concrete traces have the same discrete component at every step. The
definition remains meaningful without Stateflow because conditional-block
outcomes are part of \(q\).

## Results and guarantees

Compositional callbacks construct per-step symbolic transformers. The bounded
vertex representation (BVR) underapproximates a convex region while containing
the sampled seed. Algorithm 1 computes a BVR all of whose states follow the
sampled length-\(k\) discrete trace.

It does not compute the exact equivalence class: repeated
underapproximations and disjunctive guards leave equivalent states uncovered.

## Algorithm

Conditional callbacks use the concrete branch to add either the predicate or
its negation to the symbolic transformer. The backward trace analysis
repeatedly intersects with a step guard and takes a preimage under the residual
transformer. BVR fixes the number of vertices with chosen coefficient and
direction sets.

## Complexity

BVR construction and its operations solve a polynomial number of linear
programs whose dimensions are functions of the fixed representation
parameters. This controls representation complexity at the cost of
underapproximation.

## Terminology

Established terms include *symbolic trace*, *discrete component*, *trace
equivalence*, *symbolic transformer*, *preimage*, and *bounded vertex
representation*.

## Motivating example

Instrumented interconnected blocks emit path predicates and linear residual
expressions. States in the backward-computed convex region repeat the same
conditional choices and Stateflow modes as the sampled simulation.

## Relationship to our hypothesis

### What is directly established by the work?

Conditional choices are intensional trace components even when the numerical
state alone might not distinguish them. Symbolic predicates and residual
transformers characterize a sufficient region following one sampled trace.

### What is our interpretation or inference?

The global \(q\) component records all conditional-block choices participating
in each simulation step. It is not a recursively sparse map defined by a
selected output root.

### Could it subsume our proposed contribution?

It subsumes the general idea of grouping dataflow-model inputs by conditional
trace while carrying symbolic transformers. It does not give exact iff guards,
an exhaustive disjoint cover, or output-demanded inactivity.

## Evidence locations

- Sections 2.1–2.2, pp. 4–7: state model, symbolic transformers, and
  compositional instrumentation.
- Section 3, pp. 8–10: BVR guarantees and LP costs.
- Definition 1 and Algorithm 1, p. 11: discrete-trace equivalence and backward
  construction.
- Section 5, p. 13: underapproximation limitations.

## Questions and possible weaknesses

- How much of the sparse observation is reproduced if the output cone is sliced
  before instrumentation?
- The underapproximation is intentional, so its empirical coverage cannot be
  compared to exact enumeration counts.
