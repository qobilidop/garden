# yang2020facelattices — Reachability Analysis for Feed-Forward Neural Networks Using Face Lattices

- **Status:** deep-read
- **Primary source:** https://arxiv.org/abs/2003.01226
- **Bibliography key:** `yang2020facelattices`

## Result and relationship

Definition 3 stores an original-input subpolytope together with an affine map
and offset (PDF p. 7). Algorithm 1 computes exact reachable sets (p. 9); the
paper bounds a layer's maximum output-set count by (2^m) and maps unsafe
output regions back to input regions (p. 11).

This is another exact guard-plus-affine-residual lineage member. It retains
dense ReLU regime structure and has no output-sensitive theorem or
requested-root-relative missing-site semantics.
