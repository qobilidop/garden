# anand2006subsumption — Abstract subsumption checking

- **Status:** deep-read; symbolic-state omission comparator
- **Primary source:** https://doi.org/10.1007/11691617_10
- **Version read:** author-hosted SPIN 2006 full text
- **Bibliography key:** `anand2006subsumption`

## Evidence locations

- State representation and subsumption sections: one abstract symbolic state
  denotes a set of concrete heaps; revisiting a subsumed state causes
  backtracking.
- Scope and guarantees: state matching can make exploration finite for
  recursive heap and array inputs, but the bounded abstraction is an
  under-approximation.

## Relationship and evidence limit

The omission is semantic state-set inclusion, not merely search order. It does
not enumerate every finite observer value or exact caller-input fiber.
