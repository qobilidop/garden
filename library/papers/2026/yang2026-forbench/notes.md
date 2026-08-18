---
citekey: yang2026-forbench
work:
  title: "Forbench: Symbolic Simulation Helps Make Your Testbench More Formal"
  author: Ziyi Yang, Wenbin Che, Ziyue Zheng, Guangyu Hu, Hongce Zhang (5 authors; HKUST-GZ / HKUST)
  venue: ICCAD '26 (IEEE/ACM Int. Conf. on Computer-Aided Design), San Jose, Nov 2026 — forthcoming
  date: 2026-08-02 (arXiv v1); ICCAD '26 camera-ready
  doi: 10.1145/3831252.3834108   # assigned in the paper's ACM reference block; not yet registered at Crossref (proceedings publish Nov 2026)
  arxiv: 2608.01045v1
sources:
  pdf: https://arxiv.org/pdf/2608.01045v1  # → shadow
retrieved: 2026-08-08
notes-by: "Claude Fable 5; Codex GPT-5.6 Sol"
notes-date: 2026-08-09
synthesis: "Fork on testbench conditions, not design branches: a symbolic-simulation runtime with simulation ergonomics — real engineering value, though the 'third path' framing oversells its distance from prior symbolic simulation."
---

# Forbench: Symbolic Simulation Helps Make Your Testbench More Formal

**Category:** a hardware-verification tool/methodology paper (ICCAD '26).
**Context:** pre-silicon RTL functional verification sits on two poles —
simulation (operational, low-expertise, but each run explores one
concrete trace, so coverage is a fraction of the input space and corner
bugs escape) and formal property verification (FPV: exhaustive, but
demands a mindset shift to axiomatic SystemVerilog Assertions and scales
poorly on large designs). Forbench proposes a third path: keep the
simulation testbench — its procedural style, its driver/monitor
structure, its Python API — but drive it with *symbolic* inputs and
solver-backed state transitions, so a single run reasons over all input
valuations up to a bounded depth. The pitch: get FPV-grade bounded
coverage without leaving the operational execution model or writing
SVAs. The claimed wins are usability (a familiar interface, tunable
concrete-vs-symbolic per signal) and speed (beats prior symbolic
simulation and STE tools on datapath-heavy designs). Framework is
open-source (github.com/hkustgz-zhang-lab/Forbench).

## The problem it argues against: SVA is a semantic minefield

The motivating example (Fig. 1) is the strongest part of the paper's
framing. Verifying a variable-latency multiplier, the "natural" SVA
`(start, a0=a, b0=b) |-> ##[1:8] (valid && (result == a0*b0))` looks
right but is *wrong*: `##[1:8]` requires only that *some* cycle in the
1–8 window satisfies the conjunction, so a trace where `valid` rises a
cycle before `result` is correct still passes — premature `valid` is not
ruled out, and a downstream consumer reading `result` on `valid` gets
garbage. Swapping `&&` for `|->` doesn't fix it; the temporal
permissiveness is the issue. The paper piles on: enforcing
non-overlapping `start` needs repetition/overlap operators and the
`within`/`throughout`, `until`/`until_with`, three-repetition-types
distinctions; SVA composes poorly compared to simulation's functions and
tasks. The thesis: even for a trivial design, writing correct properties
is expert-only and error-prone, and that barrier — not raw solver power
— is what keeps formal methods out of practice.

## The mechanism: symbolic simulation, forked by the testbench not the DUT

Forbench models RTL as a transition system `TS = (Vs, Vi, I, T)` and
maintains a set of active symbolic states, each a tuple `(Ms, Φ, X)`:
`Ms` maps state variables to symbolic expressions, `Φ` is accumulated
constraints (assumptions + path conditions), `X` is the fresh variables
minted for unspecified inputs each cycle. Each cycle it checks
requested assertions, considers a fork, mints X-variables for
unconstrained inputs, and applies `T` to step (Algorithm 1). Two
testbench styles ride on top: **active-stepping** (single flow, explicit
`dut.step()`) and **coroutine-based** (multiple `@register_task`
coroutines with `wait_cond`/`wait_cycle`/`wait_task`, mimicking
Verilog's concurrent `always` blocks — the natural fit for overlapped
streaming I/O, shown in Fig. 3 as a near-structural match to a
conventional SV driver/monitor testbench).

The load-bearing design decision (§4.3, emphasized in the paper's own
bold): **forking is driven by conditions in the *testbench*, not
branches in the *design*.** When a `wait_cond(E)` is hit, an SMT solver
checks `Φ∧E` and `Φ∧¬E`; if only one is SAT the branch is pruned and its
condition folded into `Φ`, if both are SAT the coroutine forks (clone
state, add `E` to one and `¬E` to the other). Because a testbench has
far fewer conditions than a DUT has branches, this yields far fewer
forks than classical symbolic *execution* — the paper's core efficiency
claim, and its distinction from the KLEE-on-Verilated-RTL lineage. This
also separates it from symbolic *execution* generally: symbolic
simulation keeps all outcomes of a design branch in one expression (via
ITE) rather than forking on it, so it is inherently less prone to path
explosion; forking is reserved for genuine testbench-level decision
points.

Supporting machinery: unspecified values are kept *relational* (an
`out = a+b` with `b=1` is stored as `X+1`, not opaque unknown — following
WASIM [8]); expression bloat is fought with independence/constant
analysis, assumption-guided evaluation, ITE unreachable-case pruning,
and word-level sweeping (SMTSweep [27], same group). For the rare
genuine explosion, `sim.abstract(P)` merges forked coroutines under a
user-supplied predicate `P`, sound because `P` is SMT-checked to
over-approximate the merged states (§4.4). Backward simulation and
symbolic initial states (modular inductive verification, deep-state
reachability) are noted as further capabilities (§4.5).

## Evidence

Implemented in C++ on SMT-Switch + Bitwuzla; Verilog → BTOR2 via Yosys;
Python API via Boost.Python. Three experiments:

- **Simulation speed (Table 2).** Five designs (AES, rocket, piccolo,
  flute, ridecore; 10^4–10^5 gates), 100-cycle bound. Forbench beats
  WASIM everywhere (e.g. rocket 10.8s vs 187s; flute 125s vs 1048s) and
  VossII (STE) everywhere (VossII times out >3600s or N/A on all five).
  Concrete simulators (iverilog, Verilator) are of course faster —
  but they cover one trace, not the whole bounded input space.
- **Branch coverage (Table 3).** Against random, Pono, EBMC, STSearch,
  Hot-FV on ITC'99 + OR1200/Rocket modules. Forbench *matches the best
  achievable coverage on every benchmark* while usually being fastest,
  sometimes by large margins (or1200: 94.63% in 84s vs Pono's 145s /
  random's 11058s; rocketTile_small: 79.16% in 9438s). EBMC N/A on the
  large ones (crashed).
- **Bug finding (Table 4).** Ten injected bugs (E0–E9) in a micro-riscv
  RV32I core, reproducing Bruns et al. [18]'s [[symbolic-execution]] setup.
  Both find 10/10, but Forbench does it in 17.4s total vs 11,645s, and
  explores 23 branches total vs ~101M executed instructions / 13,072
  partial paths — the testbench-forking-beats-DUT-forking claim made
  concrete.

## Assessment

- **Durable:** The reframing is the contribution and it is genuinely
  useful — "fork on testbench conditions, not design branches" is a
  clean lever that plausibly explains the bug-finding speedups, and the
  SVA motivating example is a crisp, honest illustration of why
  property-writing (not solving) is the real adoption barrier. Meeting
  best-known coverage while cutting runtime on processor-scale designs
  is a solid, reproducible-looking result against named recent baselines
  on standard benchmarks (ITC'99, OR1200, Rocket).
- **Genuinely novel-in-packaging, not in kind:** SMT-based word-level
  symbolic simulation (WASIM), STE, relational unknowns, word-level
  sweeping all pre-exist — much of it from the same lab. Forbench's real
  novelty is the *fork-able Python coroutine* runtime (working around
  Python's inability to clone a running coroutine via introspection) and
  the cocotb-like interface over a symbolic engine. That is engineering
  value, but the paper's "third path" framing oversells the conceptual
  distance from prior symbolic simulation.
- **Weaknesses / caveats:** Coverage is *bounded* (100 cycles here) —
  "exhaustive" always means "up to the bound," and the paper is
  comfortable eliding that in prose ("full-coverage verification"). The
  usability claim ("Medium" expertise, more natural than SVA) is
  asserted from example code, never measured — no user study, no
  effort/LOC comparison, so the central pitch (lowering the barrier) is
  evidenced only by the authors' own testbenches. The `sim.abstract`
  soundness rests on a *human-supplied* predicate `P`, relocating rather
  than removing the expertise burden for the hard cases (and the authors
  note it wasn't needed for any experiment, so it is untested here).
  Baselines are apples-to-different-oranges by necessity (concrete vs
  symbolic vs STE vs BMC), which the tables handle honestly but which
  makes "faster" a claim that needs reading the footnotes.

The paper is a well-executed systems-and-tooling contribution whose
lasting idea is a usability/efficiency reframe — move symbolic branching
from the design to the testbench, and wrap it in the interface engineers
already use — rather than a new verification theory.
