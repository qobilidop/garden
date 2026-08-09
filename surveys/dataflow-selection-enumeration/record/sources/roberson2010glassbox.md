# roberson2010glassbox — Modular glass-box model checking

- **Status:** screened; similarity-based state-set checking
- **Primary source:** https://doi.org/10.1145/1869459.1869461
- **Version read:** author-hosted OOPSLA full paper
- **Bibliography key:** `roberson2010glassbox`

## Evidence locations

- Construction: glass-box checking identifies state-space similarities and
  safely checks a large set of similar states together instead of visiting
  each represented state separately.
- Modular extension: Pipal replaces modules with abstractions and applies the
  grouped-state procedure to bounded exhaustive checking over inputs and
  schedules.

## Relationship and evidence limit

This is a direct semantic state-grouping precedent with a modular boundary.
Its classes are model-checker state sets under finite bounds, not exact fibers
of a requested internal event observer, and no typed graph residual is emitted.
