---
citekey: li2009minimum
work:
  title: "Minimum Initial Marking Estimation in Labeled Petri Nets"
  author: "Lingxi Li, Christoforos N. Hadjicostis"
  venue: "ACC 2009"
  date: 2009
  doi: 10.1109/acc.2009.5160266
read: full-text
source: "ACC 2009 proceedings paper via https://skoge.folk.ntnu.no/prost/proceedings/acc09/data/papers/0732.pdf (DOI record https://doi.org/10.1109/ACC.2009.5160266)"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-05
synthesis: "Gives the detailed definitions and complete recursive algorithm for the minimum-total-token initial markings consistent with an observed label word — an optimization-restricted inverse image of an event observer, evidence that partial event records can induce exact hidden-state sets, though not one that transfers residual program values"
---

# Minimum initial marking estimation

## Evidence

### Why it matters

This primary precursor gives the detailed definitions and algorithm used in the
survey's claim that a partial event word can induce a complete set of
optimization-restricted hidden initial markings.

### Main result and scope

Definitions 2--4 distinguish all consistent initial markings,
componentwise-minimal consistent markings, and minimum-total-token initial
markings. The recursive algorithm computes the complete set of minimum initial
markings consistent with the observed label word. Its stated complexity is
polynomial in the word length when the Petri-net dimensions are treated as
parameters.

This is not an unconstrained inverse-fiber enumerator: it intersects event-word
consistency with a minimum-token objective. Its outputs are Petri-net markings,
not caller inputs paired with residual program values.

### Evidence locations

- Definitions 2--4, paper pp. 5001--5002: consistent, minimal, and minimum
  initial-marking sets.
- Algorithm discussion, paper pp. 5002--5004: recursive complete construction.
- Complexity discussion, paper p. 5004: polynomial dependence on observation
  length under fixed net dimensions.
- Conclusion, paper p. 5005: scope and later extensions.

### Version relationship

The 2013 IEEE TAC article is the expanded same-title continuation. This note
pins the detailed claims to the full primary text actually read rather than
importing journal-only statements from metadata.

## Bearing on RQs

What is directly established by the work: the paper defines and completely
constructs the minimum-total-token initial markings consistent with an
observed label word under its fixed-net scope.

Our interpretation or inference: this is an optimization-restricted inverse
image of an event observer and is therefore evidence that partial event
records can induce exact hidden-state sets. The analogy does not transfer
residual program values.

Could it subsume our proposed contribution: no. It supports an adjacent
observer principle but has a different state model, quotient, and output
contract.

## Evidence limits

- The result is an optimization-restricted inverse image (event-word
  consistency intersected with a minimum-token objective), not an
  unconstrained inverse-fiber enumerator.
- Its outputs are Petri-net markings, not caller inputs paired with residual
  program values.
