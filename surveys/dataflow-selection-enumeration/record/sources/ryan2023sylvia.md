---
citekey: ryan2023sylvia
work:
  title: "Sylvia: Countering the Path Explosion Problem in the Symbolic Execution of Hardware Designs"
  author: "Kaki Ryan, Cynthia Sturton"
  venue: "FMCAD 2023"
  date: 2023
  doi: 10.34727/2023/isbn.978-3-85448-060-0_19
read: full-text
source: "Version of record, https://doi.org/10.34727/2023/isbn.978-3-85448-060-0_19"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Sylvia composes independently explored RTL path fragments, uses SMT to filter their cross-product, and returns replayable witnesses — the closest recent symbolic-execution system for RTL, though its 'linear-in-N' exploration claim is not an end-to-end solver-work bound since the fragment cross-product remains exponential."
---

# Sylvia: Countering the Path Explosion Problem in the Symbolic Execution of Hardware Designs

## Evidence

### Why it matters

Sylvia is the closest recent symbolic-execution system for RTL. It composes
independently explored path fragments, uses SMT to filter their cross-product,
returns replayable witnesses, and presents a complexity argument that must be
read carefully.

### Program and semantic model

The symbolic engine executes synthesizable Verilog RTL. A path is a sequence of
source-line states with a symbolic store and path condition. Statically bounded
loops are unrolled. Sequential always blocks are explored independently;
combinational logic and assertions receive separate treatment.

### Main definitions

Piecewise composition produces one path-fragment tree per sequential block.
Full paths are combinations of one fragment from every block. SMT decides which
combinations are feasible and returns a concrete input replay for a realizable
assertion violation.

### Results and guarantees

The paper states that realizable composed paths correspond to replayable
full-design paths. Experiments over five designs and 84 properties report large
runtime and path-exploration reductions.

### Algorithm

Explore each independent block once, form fragment combinations, conjoin their
path conditions and partial stores, and query SMT. Optimizations handle repeated
submodules, cone of influence, query caching, and multiple cycles.

### Complexity

Under the paper's assumptions—\(N\) sequential blocks, at most \(b\) binary
branches per block, and \(c\) lines per basic block—the distinction is:

\[
\begin{array}{ll}
\text{traditional explored lines} & O(cbN2^{bN}),\\
\text{traditional SMT queries} & O(bN2^{bN}),\\
\text{piecewise explored lines} & O(cbN2^b),\\
\text{piecewise SMT queries} & O(bN2^b+2^{bN})=O(2^{bN}).
\end{array}
\]

Thus the abstract's linear-in-\(N\) exploration claim is not an end-to-end
solver-work bound. The method still submits the fragment cross-product.

### Terminology

Established terms include *piecewise composition*, *path fragment*, *symbolic
store*, *path condition*, *replayable counterexample*, and *cone of influence*.

### Motivating example

Two independent sequential blocks each have one branch. Ordinary execution
builds four full paths; piecewise execution explores two two-leaf fragment
trees, then checks the four pairings. Correlated guards make some pairings
infeasible.

### Evidence locations

- Sections II.B–II.C, pp. 111–112: symbolic execution state and paths.
- Sections III.B–III.C, pp. 113–114: fragment construction, SMT composition,
  and replay.
- Section III.D, pp. 114–115: four complexity counts.
- Section IV, pp. 115–117: implementation and optimizations.
- Section VI, pp. 117–119: experimental evidence.

## Bearing on RQs

What is directly established by the work: modular RTL path exploration,
solver-checked fragment composition, and concrete replay are feasible and
useful.

Our interpretation or inference: let \(P\) be feasible full CFG paths and \(K\)
be output-observation fibers. Normally \(K\le P\), strictly when paths differ
only in unobserved choices. Sylvia reduces fragment construction but still
considers up to \(2^{bN}\) pairings, whereas projected observation enumeration
returns exactly \(K\) models at the API boundary.

Could it subsume our proposed contribution: it subsumes broad claims about
compositional hardware paths and witnesses. It does not define
output-demanded graph-site observations, exact fiber guards, or residual
outputs. Translating a shared mux DAG to lazy CFG branches is itself a
semantic choice.

## Evidence limits

- The paper calls its exploration reduction a path-explosion result, but the
  combination phase remains exponential and should be separated in comparison.
- Cone-of-influence pruning is at block granularity and does not by itself
  define the recursive sparse observation.
