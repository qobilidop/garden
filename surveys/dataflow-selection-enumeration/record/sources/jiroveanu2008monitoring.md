---
citekey: jiroveanu2008monitoring
work:
  title: "On-Line Monitoring of Large Petri Net Models Under Partial Observation"
  author: "George Jiroveanu, René K. Boel, Behzad Bordbar"
  venue: "Discrete Event Dynamic Systems"
  date: 2008
  doi: 10.1007/s10626-007-0036-x
read: full-text
source: "Author-hosted journal full text via https://doi.org/10.1007/s10626-007-0036-x, pp. 323--354"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "A reduced Petri-net observer represents the entire consistency set via basis markings from backward search over minimal explanations of the observed transition-label sequence — an exact observation-relative state estimate, not a duplicate-free partition of caller inputs with symbolic residuals"
---

# On-Line Monitoring of Large Petri Net Models Under Partial Observation

## Evidence

### Evidence locations

- Reduced observer construction: backward search enumerates minimal
  explanations of the received transition-label observation and retains their
  basis markings instead of every current marking.
- Representation result: the unobservable reach of those basis markings is
  exactly the complete current-marking estimate produced by the classical
  observer.
- Complexity discussion: computation depends on the largest all-unobservable
  connected subnet rather than the entire plant size under the stated model.

## Bearing on RQs

This is an exact, observer-relative omission of hidden firing detail and a
compact representation of the entire consistency set.

## Evidence limits

The object is a dynamic Petri-net state estimate from a known or bounded
initial marking, not a duplicate-free partition of all caller inputs with
symbolic program residuals.
