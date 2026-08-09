# xu2023invariants — Inductive invariants for dataflow circuits

- **Status:** screened; scalable proof-enabling companion
- **Primary source:** https://doi.org/10.1109/ICCAD57390.2023.10323796
- **Open author copy:** https://dynamo.ethz.ch/wp-content/uploads/sites/22/2024/04/Xu_ICCAD23_AutomaticInductiveInvariantGeneration.pdf
- **Bibliography key:** `xu2023invariants`

## Evidence locations

- Motivation and property model: dataflow-circuit verification must establish
  invariants over elastic handshakes and control state that generic model
  checking does not scale to infer unaided.
- Method: HLS structure guides automatic inductive-invariant generation for
  properties used in circuit verification and optimization.
- Evaluation: the generated invariants make previously difficult proofs
  tractable on the reported benchmarks.

## Relationship and evidence limit

This companion strengthens the proof mechanism behind property-specific
dataflow-circuit simplification. It supplies invariants for selected safety
claims, not a duplicate-free enumeration of observation fibers or symbolic
residual values.
