---
citekey: chatain2017goaldriven
work:
  title: "Goal-Driven Unfolding of Petri Nets"
  author: "Thomas Chatain, Loïc Paulevé"
  venue: "CONCUR 2017"
  date: 2017
  doi: 10.4230/lipics.concur.2017.18
read: full-text
source: "Published CONCUR 2017 LIPIcs article via https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.CONCUR.2017.18, volume 85, article 18, pp. 18:1–18:16"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Goal-driven Petri-net unfolding skips transitions outside every minimal goal-reaching configuration while preserving the complete set of minimal configurations — a direct instance of observer-relative omission for partial-order configurations, not caller-input partitioning"
---

# Goal-Driven Unfolding of Petri Nets

## Evidence

### Evidence locations

- Section 2, Definitions 1--5 (pp. 18:4--18:5), works with safe Petri nets,
  occurrence-net configurations, unfoldings, and adequate-order finite
  prefixes. The finite-prefix argument uses the finite number of markings of a
  finite safe net.
- Definition 6 and the following remark (p. 18:6) define a goal as an exact
  marking or a partially specified set of places that must be marked together.
  A firing sequence is minimal when no permutation of it is a cycling firing
  sequence; for a partial goal, no earlier marking may already satisfy the
  goal. Definition 7 and Lemma 8 lift this to configurations and show goal
  reachability iff some minimal configuration reaches it.
- Definition 9 and Property 1 (pp. 18:6--18:7) abstract the external
  `useless-trs` reduction: it may remove only transitions absent from every
  minimal firing sequence to the goal, and therefore preserves goal
  reachability. Lemma 10 justifies repeated reduction after intermediate
  markings.
- Section 4.1 and Theorem 11 (pp. 18:7--18:8) attach inherited useless-
  transition sets to unfolding events, discard an event when its transition is
  useless after a causal predecessor, and prove that the resulting goal-driven
  unfolding preserves **all** minimal configurations from the initial marking
  to the goal.
- Algorithm 1 (pp. 18:9--18:11) computes putative goal-driven prefixes under
  an adequate order, propagates transitions across cut-off alternatives, and
  repeatedly relaxes the map of ignored transitions. This correction is
  necessary because equal-marking cut-offs can have different permitted
  futures after goal-oriented reduction.
- Lemma 12 and Theorem 13 (pp. 18:11--18:12) prove termination and completeness
  of the finite goal-driven prefix for minimal goal-reaching extensions. With
  a total adequate order, the construction has at most one non-cut-off event
  per reachable marking.
- The complexity statement on p. 18:11 excludes the external reduction calls
  and warns that the alternative-configuration set can be exponential. The
  automata-network reduction in Section 5.1 is polynomial in the number of
  automata and transitions but exponential in the number of states of an
  individual automaton; this is not a general output-sensitive bound.
- The related-work discussion (p. 18:3) distinguishes Bonet et al.'s directed
  unfolding: heuristic ordering can stop or prune dead ends, but otherwise
  retains configurations, including transient-cycle and nonminimal ones. The
  goal-driven construction can instead retain only all minimal configurations
  relevant to the goal.

## Bearing on RQs

This directly instantiates observer-relative omission: for a requested goal
marking, it skips transitions outside every minimal goal-reaching
configuration while preserving the complete set of minimal configurations. It
is a distinct successor to directed unfolding rather than merely another event
ordering heuristic.

The enumerated objects are partial-order Petri-net configurations leading to a
marking. The method does not partition caller inputs by sparse internal-site
outcomes, construct exact inverse fibers or guards, or attach a typed symbolic
residual to each observation.

## Evidence limits

Read at full-text level (published CONCUR 2017 LIPIcs article, pp. 18:1–18:16);
the note records no evidence-quality caveats beyond the scope boundary above.
