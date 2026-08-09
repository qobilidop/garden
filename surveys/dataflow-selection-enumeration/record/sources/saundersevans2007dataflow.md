# saundersevans2007dataflow — Event Structure Spans for Nondeterministic Dataflow

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1016/j.entcs.2006.10.055
- **Version read:** author-uploaded ENTCS manuscript
- **Bibliography key:** `saundersevans2007dataflow`

## Why it matters

Event-structure spans are the strongest conceptual precedent for retaining
intensional computation histories after extensional input/output behavior has
merged. They also give a distinct formal meaning to demand.

## Semantic object and demand

An event structure contains event occurrences, finite causal histories, and
hereditary conflict. A configuration is a downward-closed conflict-free set of
events (Definition 2.1, manuscript p. 2).

A span has an input event structure, computation event structure, and output
event structure. The output map preserves causal history. A demand morphism
maps each computation event to a finite input configuration, is monotone along
causality, and turns incompatible demands into conflict. Demand over a
configuration is the union of its event demands (Definition 2.4, pp. 3–4).

Sequential composition pairs a downstream event with an upstream configuration
whose output meets its demand, retaining the mediating causal history.

## Results and assumptions

Secure configurations support feedback. Theorem 4.6 makes them a stable
family; Definition 4.7 and Theorem 4.10 construct a traced span (pp. 5–9).
Theorem 5.3 characterizes deterministic spans as stable continuous functions,
composition preserves determinism, and Theorem 5.8 recovers Kahn least-fixed-
point semantics under trace (pp. 10–13).

The denotational development gives no enumeration algorithm or asymptotic
bound. Event structures and configurations may be infinite.

## Motivating example

Two nondeterministic processes have the same extensional input/output relation,
but feedback distinguishes them because their causal histories differ
(Section 1, journal pp. 109–110).

## Relationship to our hypothesis

A configuration is a consistent causal history, not a partition of concrete
program inputs. Conflict represents nondeterministic alternatives; demand is
finite causal input needed to enable an event. Selection observations discard
ordering and general causality, use deterministic guarded inputs, and expose a
fixed graph-relative set of site outcomes. Event spans provide neither input
fiber guards nor residual/witness enumeration.

## Evidence locations

- Definitions 2.1 and 2.4, manuscript pp. 2–4: configurations and spans.
- Definitions 4.1 and 4.7 and Theorems 4.6 and 4.10, pp. 5–9: trace.
- Theorems 5.3 and 5.8, pp. 10–13: determinism and Kahn semantics.
