# xia2024demand — Story of Your Lazy Function's Life

- **Status:** deep-read
- **Primary source:** https://arxiv.org/abs/2406.14787
- **Version read:** primary preprint corresponding to ICFP 2024
- **Bibliography key:** `xia2024demand`

## Why it matters

This is the closest semantic precedent for propagating an output request
backward to minimal sufficient input information. Its demand is partial-value
definedness and cost for one lazy computation, not an internal selection trace
or exhaustive input partition.

## Semantic object

For a typed term, forward semantics maps total input values to a total output.
The backward demand semantics takes the total input plus an approximation of
the actual output and returns a tick cost and a least sufficient approximation
of the inputs (Section 3.1 and Figure 8, Article 237:7–11).

Approximations are partial values in which thunked subvalues may be bottom and
are ordered by definedness. The semantics uses full forward values to decide
control and then propagates requested output structure backward.

## Results and assumptions

- Lemmas 3.4–3.6 prove totality on valid demands, monotonicity, and join
  homomorphism for returned input information.
- Theorems 3.7–3.9 prove functional correctness plus achievable and minimal
  cost/input information relative to the clairvoyant semantics.

The results are mechanized in Rocq. The calculus is pure, total, typed, and
first-order, with explicit memoized thunks and structural recursion. General
recursion requires fuel.

## Complexity and examples

The translation may be quadratic because forward and backward copies appear in
`let` and `foldr`. Tick cost is semantic rather than construction runtime; the
paper gives no automatic demand-function simplification bound. Case studies
derive `O(kn)` lazy sorting prefixes and amortized queue results.

## Relationship to our hypothesis

The result is a minimal approximation for one already known total input. It
does not record internal site identities/outcomes, preserve equal-valued
control alternatives, or enumerate exact guarded input regions. Join
deliberately merges shared information and work, whereas a selection
observation can retain intensional branch distinctions.

## Evidence locations

- Section 2.1, Article 237:3–6: bidirectional motivation.
- Section 3.1 and Figure 8, 237:7–11: semantics.
- Lemmas 3.4–3.6 and Theorems 3.7–3.9, 237:11–13: metatheory.
- Sections 3.1 and 3.5, 237:14: representation and scope limitations.
