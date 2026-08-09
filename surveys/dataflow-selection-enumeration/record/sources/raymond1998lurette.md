# raymond1998lurette — Automatic Testing of Reactive Systems

- **Status:** deep-read
- **Primary source:** https://www-verimag.imag.fr/PEOPLE/Nicolas.Halbwachs/rtss98.html
- **Version read:** author-hosted RTSS 1998 manuscript
- **Bibliography key:** `raymond1998lurette`

## Why it matters

Lurette is a foundational constraint-based testing system for Lustre observers.
Its relevance predicate constrains a temporal test trajectory; it is not a
selector observation or exhaustive input partition.

## Program and semantic model

A deterministic black-box reactive program is synchronously composed with a
known observer. The joint temporal state contains program and observer states.
At each instant, the observer produces a Boolean relevance result and a next
observer state (Section 2.1.1, manuscript pp. 4–5).

A finite input sequence is relevant when the observer remains true at every
instant. Relevance combines environmental realism and user interest and is
limited to temporal safety. Because the program is a black box, the current
generation constraint may not depend instantaneously on its unknown output,
although observer state update may use that output (Section 2.2, p. 7).

## Algorithm and guarantees

For one observer state, the relevance predicate becomes a Boolean formula over
Boolean inputs and atoms for linear numerical constraints. A satisfying BDD
path selects Boolean choices; its numerical conjunction defines a convex
polyhedron from which a point is sampled. Empty polyhedra reject that BDD
branch (Section 2.4, pp. 9–10).

Each committed step satisfies the relevance observer under correct solving.
An independent oracle can stop on a safety violation and return the current
sequence (Sections 3.1–3.2). No asymptotic, exhaustive-coverage, or disjointness
result is proved; sampling remains randomized.

## Motivating example

A heater/regulator observer changes the admissible next-temperature polyhedron
according to delayed heater state (Sections 2.1.3 and 2.3).

## Relationship to our hypothesis

Lurette samples one temporal trajectory. Its Boolean relevance is a prefix
acceptance judgment, BDD paths are representation artifacts, and neither
equal-valued branch choices nor inactive nested selections are recorded. It
does not produce covering guards, residuals, or one witness per observation.

## Evidence locations

- Sections 2.1–2.4, manuscript pp. 4–10: relevance and generation.
- Sections 3.1–3.2, pp. 11–12: oracle interaction.
- Section 5, p. 14: limitations and future coverage work.
