---
citekey: godefroid2005dart
work:
  title: "DART: Directed Automated Random Testing"
  author: "Patrice Godefroid, Nils Klarlund, Koushik Sen"
  venue: "PLDI 2005"
  date: 2005
  doi: 10.1145/1064978.1065036
read: abstract-only
source: "Publisher abstract and bibliographic metadata, https://doi.org/10.1145/1064978.1065036"
retrieved: 2026-08-09
notes-by: Codex (publication-review revision)
notes-date: 2026-08-09
synthesis: "Foundational primary anchor for concrete executions whose dynamic symbolic analysis generates new inputs to direct exploration toward alternative paths; it does not group paths into complete observation fibers."
---

# DART: Directed Automated Random Testing

## Evidence

### Evidence locations

- Publisher abstract: DART observes a program under concrete random tests and
  automatically generates new inputs to direct execution along alternative
  paths.

## Bearing on RQs

DART establishes the concrete-plus-symbolic, solver-directed test-generation
pattern used by later concolic systems. The survey's local generator inherits
that pattern but must additionally prove that one observed model generalizes
to the entire exact selection-observation fiber.

## Evidence limits

Screened from the publisher abstract and metadata only. The note supports the
algorithmic lineage, not an end-to-end correctness or complexity transfer.
