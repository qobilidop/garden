# xu2023dynamism — Eliminating unnecessary dataflow-circuit dynamism

- **Status:** screened; property-proved circuit simplification
- **Primary source:** https://doi.org/10.1145/3543622.3573196
- **Open author copy:** https://dynamo.ethz.ch/wp-content/uploads/sites/22/2023/03/Xu_FPGA23_EliminatingExcessiveDynamism.pdf
- **Bibliography key:** `xu2023dynamism`

## Evidence locations

- Problem statement and method: generic dynamically scheduled dataflow
  components permit handshake behaviors that a particular HLS-generated
  circuit may never exercise.
- Verification stage: model checking proves the absence of selected protocol
  behaviors before an optimization removes the corresponding generality.
- Evaluation: the resulting simplifications preserve circuit behavior for the
  verified property and reduce hardware cost on the studied circuits.

## Relationship and evidence limit

The method uses formal absence proofs to omit unnecessary dynamic behavior in
a close dataflow-circuit model. It decides particular circuit properties and
rewrites hardware; it does not enumerate a sparse internal observer's complete
image or exact caller-input fibers with residuals.
