---
citekey: phan2015-all-smt
work:
  title: "All-Solution Satisfiability Modulo Theories: Applications, Algorithms and Benchmarks"
  author: Quoc-Sang Phan, Pasquale Malacaria
  venue: "2015 10th International Conference on Availability, Reliability and Security, pp. 100–109"
  date: "2015-08"
  doi: 10.1109/ARES.2015.14
sources:
  pdf:  # first-author-hosted IEEE proceedings PDF; title, authors, pages, and DOI match the record
    url: https://qsphan.github.io/papers/ares15.pdf
    archived: https://web.archive.org/web/20250507075750/http://qsphan.github.io/papers/ares15.pdf
retrieved: 2026-08-09
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-09
synthesis: "All-SMT makes the observation coordinates explicit: it enumerates every feasible valuation of designated Boolean variables, while relevant theory values are sampled annotations rather than independently enumerated outputs."
---

# All-Solution Satisfiability Modulo Theories: Applications, Algorithms and Benchmarks

A solver-method paper that defines an operational [[model-enumeration]]
interface, gives two algorithms over an incremental SMT API, implements the
`aZ3` prototype, and demonstrates applications in program analysis. Its most
durable contribution is not the benchmark result but the separation between
*important* Boolean variables, whose feasible valuations are exhaustively
enumerated, and *relevant* theory variables, whose values are attached from
one representative model. The algorithms are easy to reconstruct and the
experiments cross-check result counts, but the paper supplies neither a formal
correctness theorem nor a standard output-complexity result.

## The variable sets define the observable result

For an SMT formula `phi`, the paper defines `All-SMT(phi, VI, VR)`. `VI` is a
set of important Boolean variables. Two theory models count as the same output
when they agree on `VI`; the solver must emit every extendable valuation of
those variables. `VR` may contain non-Boolean values, but they are evaluated in
the representative model returned for a `VI` valuation. They do not add
enumeration coordinates.

That distinction is the conceptual core. All-SMT does not enumerate “all
models” in the literal model-theoretic sense, which could be infinite. It
enumerates the finite projected image selected by `VI`, with `VR` as witness
data. A client must therefore instrument its desired observer into Boolean
coordinates. In [[symbolic-execution]], branch predicates can serve as those
coordinates; output bits can instead define an extensional value observer.
The solver enumerates the chosen observation, not an intrinsic notion of
program behavior.

## Blocking and depth-first enumeration trade memory for control

The blocking-clause algorithm repeatedly asks for a model, projects it to
`VI`, emits the projected valuation plus `VR`, and asserts one clause negating
that complete `VI` assignment. When the formula becomes unsatisfiable, every
feasible valuation has been emitted. The method is simple enough to act as a
reference implementation, but its formula grows by one clause per result.

The alternative performs a depth-first traversal of the important variables
using an incremental, backtrackable solver. It pushes a chosen literal, checks
satisfiability, descends until every important variable is assigned, emits a
model, and then backtracks to the next branch. This avoids retaining an
output-sized blocking-clause set and reuses solver state, at the cost of
driving a systematic search outside the solver's native branching policy.

Both procedures remain exponential when the projected image is exponential.
The phrase “one call to All-SMT” in the program-analysis applications describes
the client API boundary: the All-SMT implementation itself makes repeated
incremental checks. It is not evidence that the underlying satisfiability work
has collapsed to one decision query.

## Applications validate the interface, not one universal advantage

The paper instruments bounded-model-checking or symbolic execution formulas
for four uses: multiple counterexamples, automated test generation, software
reliability analysis, and quantitative information flow. In each case, `VI`
selects the finite distinction of interest—paths, guards, or output bits—and a
model supplies a concrete witness.

The evaluation compares MathSAT with `aZ3` using both blocking clauses and the
depth-first method on linear-integer and bit-vector/array benchmarks. Counts
from the two `aZ3` variants agree with the expected results, while the tested
MathSAT version returns incorrect counts for several bit-vector cases. The
blocking implementation becomes impractical on the two displayed 65,536-model
benchmarks; depth-first search completes them. These results support the
prototype and expose a then-current MathSAT limitation. They do not establish
that depth-first traversal dominates modern projected enumeration across
theories or output representations.

## Assessment

- **Durable:** making the projection set part of the solver contract;
  distinguishing exhaustively enumerated Boolean coordinates from sampled
  theory values; and presenting blocking and systematic traversal as two
  implementation strategies.
- **Era-bound:** `aZ3` on the 2015 Z3 API, the evaluated MathSAT behavior, the
  QF_LIA and QF_AUFBV benchmark set, and absolute timings. A modern solver
  comparison cannot inherit those outcomes.
- **Weaknesses:** the paper argues completeness operationally rather than with
  a formal proof, gives no OutputP or delay analysis, and sometimes describes
  the client as making one solver call without charging the internal sequence
  of satisfiability checks. `VR` values are examples from one model, not
  residual functions valid over an entire projected fiber.
- **Against the library:** [[spallitta2024-disjoint-enumeration]]
  keeps projection and SMT reasoning but replaces accumulated blockers with
  chronological search and emits disjoint partial models. The later method
  changes both the search architecture and the output object, so shorter
  output does not mean it enumerates the same record stream.

All-SMT is best remembered as an observer interface: declare the Boolean
distinctions that matter, enumerate every feasible valuation, and treat all
other model content as existential support or witness data.
