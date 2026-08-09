# vin1990efficient — Efficient Data-Driven Evaluation: Theory and Implementation

- **Status:** deep-read
- **Primary source:** https://www.osti.gov/servlets/purl/7091112
- **Version read:** accepted/preprint full text; article metadata checked by DOI
- **Bibliography key:** `vin1990efficient`

## Why it matters

This operational successor constructs a backwards graph of critical nodes and
propagates termination notices to suppress computations that cannot contribute
to the requested result, particularly around switches and merges.

## Relationship

The algorithm analyzes and prunes one runtime execution. It does not
symbolically range over the input domain, enumerate distinct selection
observations, or derive exact input fibers. It nevertheless rules out a broad
claim that backwards demand or branch suppression in dataflow is new.
