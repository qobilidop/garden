---
citekey: feng2004dynamic
work:
  title: "Improved Symbolic Simulation by Dynamic Functional Space Partitioning"
  author: "Tao Feng, Li-C. Wang, Kwang-Ting Cheng, Andy C.-C. Lin"
  venue: "DATE 2004"
  date: 2004
  doi: 10.1109/DATE.2004.1268825
read: full-text
source: "Official DATE 2004 proceedings PDF, https://doi.org/10.1109/DATE.2004.1268825"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Performs symbolic simulation over control-space partitions selected at muxes, pairing each control case with a datapath function — a representation remarkably close to guarded residual values for pure dataflow graphs."
---

# Improved Symbolic Simulation by Dynamic Functional Space Partitioning

## Evidence

### Why it matters

The paper performs symbolic simulation over control-space partitions selected
at muxes and pairs each control case with a datapath function. Its representation
is remarkably close to guarded residual values for pure dataflow graphs.

### Program and semantic model

The input is a combinational gate-level circuit symbolically simulated using
OBDDs. Muxes or reconstructed control points separate control and datapath
domains.

### Main definitions

A *2-tuple* `(C,D)` means a node has data value `D` when control condition `C`
holds. A 2-tuple list mutually exclusively partitions the functional space. The
union of controls is required to be the whole functional space. A mux
construction rule moves its select value into the control component and keeps
the selected datapath result in the data component.

### Results and guarantees

Theorem 1 gives a merge rule converting a mutually exclusive tuple list to one
tuple. The OR-gate construction is shown equivalent to ordinary symbolic
simulation. Consistency checking requires both lists' controls to cover the
whole functional space and their data expressions to agree on every
intersecting control region. The mux-rule proof is omitted for space.

### Algorithm

The simulator propagates tuple lists through gates. It may leave a mux merged or
split it into control cases. Static and dynamic heuristics choose only muxes
whose split is expected to control OBDD explosion; dynamic traceback revisits a
small fan-in window after detecting growth.

### Complexity

The paper explicitly treats the number of subspaces versus per-subspace OBDD
size as a time/space tradeoff. Splitting every mux can make tuple lists grow
dramatically; selected splitting enables circuits that monolithic simulation
cannot handle. Results are empirical rather than a general output-sensitive
bound.

### Terminology

*Functional space partitioning*, *case split*, *control domain*, *datapath
domain*, *partition point*, and *2-tuple list* are established hardware terms.

### Motivating example

A 2:1 mux with symbolic selector `c` maps `(1,a)` and `(1,b)` to the two cases
`(c,a)` and `(not c,b)`. Floating-point normalization then motivates selective
partitioning where OBDD size spikes.

### Evidence locations

- Section 3, Definitions 1–3: tuple lists, coverage, and mutual exclusion.
- Section 3, Theorem 1 and Construction Rules 1–2: merge and mux propagation.
- Section 3.2: coverage and consistency checking.
- Section 4: selective mux partitioning and growth tradeoff.

## Bearing on RQs

What is directly established by the work: mux-induced mutually exclusive
control regions with residual data expressions that cover the whole functional
space and agree with merged simulation.

Our interpretation or inference: this nearly matches our guard/residual
representation. The difference is that its selected partition points are
heuristic and optimized for OBDD size, while our observation would record
every and only output-demanded choice outcome.

Could it subsume our proposed contribution: it subsumes claims of first
mux-aware input partitioning or first guarded symbolic circuit result. We need
exact observation semantics, completeness for all demanded sites, and a
structural complexity result beyond its heuristics.

## Evidence limits

- Does recursively splitting every output-relevant mux produce exactly our
  configurations, modulo equal-value coalescing?
- Its mux rule appears to form control products at ordinary gates; demand
  sensitivity may avoid products arising solely inside inactive mux arms.
