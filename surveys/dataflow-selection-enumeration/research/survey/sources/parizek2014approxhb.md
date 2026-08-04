# parizek2014approxhb — May-happen-before relevance

- **Status:** screened; sound approximate schedule relevance
- **Primary source:** https://doi.org/10.1145/2632362.2632365
- **Version read:** author-hosted full paper
- **Bibliography key:** `parizek2014approxhb`

## Evidence locations

- Analysis: static field-access information is combined with the current
  dynamic state in a sound may-happen-before approximation.
- Reduction: Java PathFinder uses that relation to avoid scheduling choices at
  statements that cannot be interleaved as globally relevant actions.

## Relationship and evidence limit

The method dynamically specializes relevance but remains an overapproximate
schedule analysis. It preserves complete interleaving coverage rather than
enumerating exact input fibers under a requested graph observer.
