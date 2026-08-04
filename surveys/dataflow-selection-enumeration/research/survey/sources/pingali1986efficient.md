# pingali1986efficient — Efficient Demand-Driven Evaluation. Part 2

- **Status:** deep-read
- **Primary source:** https://hdl.handle.net/1721.1/149053
- **Version read:** MIT-LCS-TM-243 full report; article metadata checked by DOI
- **Bibliography key:** `pingali1986efficient`

## Why it matters

Part 2 replaces per-operator microscopic demand propagation with global graph
transformations for a restricted dataflow language. It is the critical direct
continuation of Part 1.

## Results

The report defines safe and strongly safe programs, proves termination of its
steady-state transformation, and proves that a safe program input-output
equivalent to its corresponding lazy program is strongly safe (Theorem 8).
Minimizing inserted safety gates is reduced to vertex cover and shown
NP-complete (report p. 48).

The report does not provide measurements sufficient to decide when reduced
demand-propagation overhead outweighs the extra computation introduced by the
global transformation (p. 51). It still evaluates one fixed-input demand and
does not enumerate observations or their symbolic input fibers.

## Evidence locations

- Theorem 8: safety and equivalence imply strong safety.
- Report p. 48: safety-gate minimization and vertex-cover NP-completeness.
- Report p. 51: performance-measurement limitation.
