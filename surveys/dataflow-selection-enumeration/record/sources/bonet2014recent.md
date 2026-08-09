# bonet2014recent — User-parametric complete unfolding prefixes

- **Status:** deep-read; configuration-equivalence and cut-off boundary
- **Primary source:** https://doi.org/10.1016/j.tcs.2014.07.003
- **Institutional record:**
  https://openresearch-repository.anu.edu.au/items/be36ce28-f87f-4338-8279-6d663b7b7228
- **Version read:** publisher HTML version of record, *Theoretical Computer
  Science* 551 (2014), pp. 84--101; the ANU repository records the author PDF
  but currently restricts the bitstream
- **Bibliography key:** `bonet2014recent`

## Why it matters

The paper makes preservation itself a parameter of an unfolding prefix. A user
states which configurations count as equivalent, while an implementer states a
decidable cutting relation; a proof-only well-founded relation connects the
two. This is strong precedent for an observer-relative finite summary and for
separating semantic preservation from exploration order.

## Program and semantic model

The model is a finite place/transition Petri net with an initial multiset
marking; every transition is assumed to have a nonempty preset (Section 2.1).
The framework is not globally restricted to safe or bounded nets. Boundedness
matters through finitariness: marking equivalence has finite index exactly when
the net has finitely many reachable markings, whereas an unbounded net may
produce an infinite run and prefix.

## Main definitions

- Section 4, Definition 2 parameterizes completeness by an equivalence `≈` on
  configurations of the full unfolding. Every class must have a cut-off-free
  representative in the prefix, and every one-event extension of a represented
  cut-off-free configuration must also occur. Marking equivalence recovers the
  usual reachable-marking guarantee.
- Section 4, Definition 3 defines a cutting context `Theta = (≈, cut)`. The
  decidable relation says that one configuration may cut off an event.
  Correctness requires a proof-only well-founded relation satisfying `CC:PE`:
  every suffix of the cut event's local configuration has an equivalent,
  smaller suffix from its cutter.
- A cutting context is finitary only when the equivalence has finite index and
  `CC:CHAIN` holds: every infinite causal chain with equivalent local
  configurations contains a later event whose causal past contains a cutter.

## Results and theorem boundaries

- Section 5, Theorem 6 proves completeness for any cutting context and any fair
  result of the generalized algorithm: every minimal configuration in each
  equivalence class is present without cut-off events, hence the prefix is
  complete in the precise sense of Definition 2.
- Section 5, Theorem 7 proves finiteness only for a **finitary** cutting
  context. Finite index alone is insufficient; `CC:CHAIN` is also required.
  For a nonterminating run, fairness requires that every possible extension
  that appears is eventually selected.
- Arbitrary event selection is compatible with completeness and, under
  finitariness, termination, but generally loses canonicity and a one-event-
  per-marking size bound. Section 7, Theorem 9 restores canonicity only under
  an additional selection invariant that prevents selecting an event before
  possible cutters are available.

## Target distinction

Section 8 uses a set of target configurations for reachability, coverability,
safety, planning, or diagnosis. The target set must be closed under the chosen
equivalence. Changing only selection order to prefer low heuristic values
retains Theorems 6--7. Dead-end pruning needs sound extension-closed dead ends
that are also closed under the equivalence; Theorem 10 proves the transformed
relation remains a cutting context. Lemma 11 and Section 8.2 add stronger
assumptions for optimal on-the-fly search.

These targets are existential goal configurations in a Petri-net unfolding.
On-the-fly search may stop at the first target, and the prefix preserves
representatives modulo a user-chosen configuration equivalence. The paper does
not enumerate every value of a requested internal observer, compute exact
inverse caller-input fibers, or attach a typed residual value to each class.

## Evidence locations

- Section 2.1: finite-net and nonempty-preset assumptions; boundedness and
  reachable-marking finiteness.
- Section 3, Figure 2: generalized prefix algorithm, decidable cut-off test,
  and selection/cut-off separation.
- Section 4, Definitions 2--3: completeness, cutting contexts, `CC:PE`, finite
  index, and `CC:CHAIN`.
- Section 5, Lemmas 4--5 and Theorems 6--7: fairness, completeness, and
  finiteness.
- Section 7, Theorem 9: conditional canonicity and lack of a general size
  bound.
- Section 8, Theorem 10, Lemma 11, and Section 8.2: target closure, heuristic
  guidance, safe dead-end pruning, and optimality assumptions.
