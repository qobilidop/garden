# jiroveanu2008monitoring — Reduced Petri-net observer

- **Status:** deep-read; exact observation-relative state representation
- **Primary source:** https://doi.org/10.1007/s10626-007-0036-x
- **Version read:** author-hosted journal full text, pp. 323--354
- **Bibliography key:** `jiroveanu2008monitoring`

## Evidence locations

- Reduced observer construction: backward search enumerates minimal
  explanations of the received transition-label observation and retains their
  basis markings instead of every current marking.
- Representation result: the unobservable reach of those basis markings is
  exactly the complete current-marking estimate produced by the classical
  observer.
- Complexity discussion: computation depends on the largest all-unobservable
  connected subnet rather than the entire plant size under the stated model.

## Relationship and evidence limit

This is an exact, observer-relative omission of hidden firing detail and a
compact representation of the entire consistency set. The object is a dynamic
Petri-net state estimate from a known or bounded initial marking, not a
duplicate-free partition of all caller inputs with symbolic program residuals.
