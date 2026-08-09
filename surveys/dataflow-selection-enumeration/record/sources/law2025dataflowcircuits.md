# law2025dataflowcircuits — Mechanized semantics for dataflow circuits

- **Status:** screened; mechanized dataflow program-model boundary
- **Primary source:** https://doi.org/10.1145/3720432
- **Open author copy:** https://hal.science/hal-04851772v1
- **Version read:** primary author-deposited abstract and published metadata
- **Bibliography key:** `law2025dataflowcircuits`

## Evidence locations

- Abstract: the Coq formalization gives an operational semantics for stateless
  or stateful, possibly nondeterministic components connected asynchronously by
  unbounded FIFO channels.
- Abstract determinacy result: sufficient conditions ensure that all schedules
  lead to a unique observable channel-history behavior.
- Abstract representation result: a component graph and an inductive structured
  term calculus are proved semantically equivalent.

## Relationship and evidence limit

This is a close mechanized semantics for a pure dataflow-circuit program model.
Its observation is the whole circuit's channel history, and its main results
concern operational behavior, determinacy, and representation equivalence. It
does not enumerate a requested sparse selection observation, its exact
caller-input inverse fiber, and a general symbolic residual.
