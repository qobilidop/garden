# chatterjee2019valuecentric — Value-centric DPOR

- **Status:** deep-read; exact value-observation schedule quotient
- **Primary source:** https://doi.org/10.1145/3360550
- **Version read:** open-access PACMPL full text and arXiv 1909.00989
- **Bibliography key:** `chatterjee2019valuecentric`

## Evidence locations

- Equivalence: value-happens-before groups maximal traces according to observed
  values and is always at least as coarse as happens-before, sometimes
  exponentially coarser.
- Algorithm and bound: for a bounded number of threads, VCDPOR explores the
  partition in polynomial time per equivalence class.

## Relationship and evidence limit

Same-valued writes are intentionally indistinguishable, making this a direct
observer-relative quotient. It enumerates concurrent schedules rather than
caller-input fibers and carries no symbolic residual per class.
