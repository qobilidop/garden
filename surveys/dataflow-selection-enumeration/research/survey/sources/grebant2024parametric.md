# grebant2024parametric — Procedure-argument-dependent WCET formulas

- **Status:** screened; close input-sensitive symbolic-summary boundary
- **Primary source:** https://doi.org/10.1016/J.SYSARC.2024.103086
- **Open author copy:** https://hal.science/hal-04433439v2
- **Version read:** published abstract and author-copy method overview
- **Bibliography key:** `grebant2024parametric`

## Evidence locations

- Abstract: static analysis of binary code produces a formula for a procedure's
  WCET as a function of its arguments; the formula captures argument-dependent
  branch and loop control flow.
- Sections 5--6: the analysis identifies arguments, infers input conditions,
  and extends symbolic WCET expressions with conditional nodes.
- Section 7: the procedure summary supports modular call-site instantiation for
  pure functions.

## Relationship and evidence limit

The construction is a close input-sensitive conditional summary and explicitly
relates procedure arguments to control flow. Its result is a timing formula for
modular or runtime instantiation. It does not enumerate every sparse internal
selection observation and inverse input fiber, nor does it pair each such fiber
with the program's general symbolic residual value.
