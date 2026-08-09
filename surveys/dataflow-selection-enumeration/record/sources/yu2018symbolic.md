# yu2018symbolic — Symbolic Verification of Regular Properties

- **Status:** deep-read; property-oriented path-slicing comparator
- **Primary source:** https://doi.org/10.1145/3180155.3180227
- **Version read:** author-hosted ICSE 2018 PDF, pp. 871--881
- **Bibliography key:** `yu2018symbolic`

## Why it matters

SRV strengthens regular-property-guided DSE with property-oriented path
slicing. Its ideal rules remove branches that cannot contribute a
counterexample event and branches whose possible counterexample traces are
equivalent to an already explored event sequence, provided the Preset/Postset
analyses meet the stated soundness conditions.

## Evidence locations

- Section 2: defines relevant paths and event-sequence equivalence relative to
  the regular-property monitor.
- Section 3.1, Theorems 3.1--3.2: give sufficient soundness conditions for the
  Preset/Postset facts used by the ideal slicer.
- Section 3.2, Algorithm 2: slices a branch when no counterexample event can
  depend on it or every possible accepted continuation is event-equivalent to
  one already explored.
- Sections 4--5: implementation and evaluation on 15 Java programs.
- Practical qualification: the evaluated SRV is explicitly unsound because
  its Postset approximation is context-insensitive.

## Relationship and evidence limit

SRV seeks a regular-property counterexample; it does not partition caller
inputs into exact inverse fibers or return a typed residual per observation.
Only the ideal slicing rules receive the conditional preservation reading; the
practical implementation must not be presented as sound.
