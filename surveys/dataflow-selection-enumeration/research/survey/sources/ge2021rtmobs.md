# ge2021rtmobs — Compositional observer semantics for timed properties

- **Status:** screened; close explicit-observer boundary
- **Primary source:** https://doi.org/10.1016/J.SCICO.2021.102624
- **Version read:** primary publisher abstract and Sections 3--4
- **Bibliography key:** `ge2021rtmobs`

## Evidence locations

- Abstract: RT-MOBS checks real-time requirements on Time Petri Nets by using
  marking observers and derives the observer and target property compositionally
  from the structure of a property-specification pattern.
- Sections 3.1--3.3: an observer is a Time Petri Net composed with the system;
  sub-observers for scope, occurrence or order, and time constraints are joined
  through declared interfaces.
- Section 4: the construction supplies observer semantics and modal
  mu-calculus formulas for the supported real-time property patterns.

## Relationship and evidence limit

This work uses an explicit, compositional observer in a Petri-net setting, but
the observer is a property-monitor model for verification. It does not emit an
observation image and exact inverse caller-input fibers, and it does not attach
the observed program's general residual value to each fiber.
