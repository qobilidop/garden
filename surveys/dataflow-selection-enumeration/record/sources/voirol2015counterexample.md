# voirol2015counterexample — Counterexample-complete higher-order verification

- **Status:** deep-read; higher-order input-search predecessor
- **Primary source:** https://doi.org/10.1145/2774975.2774978
- **Version read:** author-hosted Scala 2015 full text, pp. 18--29
- **Bibliography key:** `voirol2015counterexample`

## Evidence locations

- Algorithm: controlled dynamic dispatch and progressive closure/function
  unfolding reduce verification to a sequence of quantifier-free SMT queries.
- Metatheory: proofs and reported counterexamples are sound, and the procedure
  is counterexample-complete for the stated terminating pure fragment.

## Relationship and evidence limit

The method canonicalizes and delays higher-order search choices, but seeks one
counterexample rather than every exact first-order observer fiber.
