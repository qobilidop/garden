# soto2025pwa — A Compositional Algorithm for Computing a Switched System Representation of Neural Network Controllers

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1109/CDC57313.2025.11312749
- **Version read:** author-hosted 2025 CDC paper
- **Open copy:** https://miriamgar.github.io/papers/cdc25.pdf
- **Bibliography key:** `soto2025pwa`

## Why it matters

García Soto and Prabhakar give a recent neural-network-specific compositional
piecewise-affine construction. It independently confirms that exact regional
residual composition by preimage intersection and affine substitution is prior
art in the neural-controller setting.

## Program and semantic model

A PWA representation is a finite collection of polyhedral regions paired with
affine maps. `PWA(W,b)` computes this representation for one activated affine
layer. `Compose(f,g)` intersects each upstream region with the affine preimage
of each downstream region and substitutes the upstream affine map into the
downstream map. A binary composition-order tree determines layer grouping.

## Results, algorithm, and guarantees

Proposition 1 establishes the single-layer construction and Proposition 2 the
correctness of PWA composition. The recursive main algorithm evaluates the
composition-order tree bottom-up, yielding the network's exact input-output
PWA representation. The final example composes that controller with linear
dynamics into a switched affine system.

## Complexity

The paper does not give a general asymptotic bound. Experiments identify the
number of intermediate and final PWA regions, especially during composition,
as the practical runtime driver. Balanced composition orders permit parallel
work and may reduce tree height, but do not remove exponential region growth.

## Relationship to our hypothesis

The work directly subsumes exact affine guard/residual composition for dense
ReLU layers. It does not retain activation-event identity, omit graph sites by
requested-root enabled closure, or handle arbitrary typed pure DAG primitives.

## Evidence locations

- Section II: PWA and neural-network definitions.
- Section III, Proposition 1: exact single-layer PWA construction.
- Section IV, Proposition 2 and recursive algorithm: preimage-intersection
  composition and composition ordering.
- Section V: empirical region-count and runtime analysis.
- Appendix/example: switched-affine closed-loop construction.

## Questions and possible weaknesses

- The correctness propositions establish representation equality, not a
  general output-sensitive complexity theorem or minimal partition.

