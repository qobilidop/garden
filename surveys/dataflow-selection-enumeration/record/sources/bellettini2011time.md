# bellettini2011time — Time-anonymous reachability

- **Status:** primary-screened; irrelevant-state-component comparator
- **Primary source:** https://doi.org/10.1109/SYNASC.2011.16
- **Version inspected:** primary SYNASC 2011 paper, pp. 110--117
- **Bibliography key:** `bellettini2011time`

## Evidence locations

- Method section: recognizes timestamps assessed as unable to influence future
  evolution and replaces them with a time-anonymous value.
- Reachability construction: merges/factorizes states and obtains finite
  time-coverage graphs in the evaluated examples.
- Discussion: discloses minor information loss from the abstraction.

## Relationship and evidence limit

This is a useful irrelevant-state-component comparator, but the disclosed
information loss means it is not imported as an exact quotient theorem. It
removes timestamp detail rather than an unreached structural selection site and
does not enumerate caller-input fibers.
