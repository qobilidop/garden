# Symbolic Executor for XLS IR — Evaluation Report

*Deep research synthesis, 2026-06-25. 15 sources, 25 claims adversarially verified (20 confirmed, 5 killed).*

## TL;DR

Worth building **only as a coverage-directed test generator**, and even then the incremental value over XLS's existing tooling is **narrow**. Don't build a fresh symbolic-execution engine — **reuse the IR→Z3 translator** and put the effort into the one thing it doesn't do: *steering toward coverage targets* (specific muxes/branches/states), not solving. The combinational subset is genuinely well-scoped and a legitimate v1, but the hardest-to-reach states only show up once Proc state exists.

## 1. The gap is smaller than the premise assumes

A claim assumed true going in got **refuted 0–3**: that XLS's Z3 path is "only for LEC, not test generation." It isn't. The solver facility answers "is there a counterexample to `and.1234` always being zero?" and **yields a counterexample — which *is* a concrete input vector.** DSLX QuickCheck + `prove_quickcheck_main` already turn property failures into input vectors over all inputs.

The real differentiator is **not** "can you generate test inputs from XLS IR" (you can, today). It's **coverage-directed** generation: systematically reaching *arbitrary* branches/states for coverage closure, vs. generating a witness for *one* property violation. Thinner slice than "build a symbolic executor" suggests. *(confidence: high)*

## 2. The combinational subset is real and tractable

XLS IR's three abstractions map onto the scope boundary:

- **Functions** (stateless, single-output) ≈ combinational *(note: Functions can also be pipelined, so combinational ⊂ Functions)*
- **Procs** (recurrent state + channels) ≈ stateful / concurrent
- **Blocks** ≈ RTL-level

The combinational op set — bit ops/reductions, `add/sub/smul/umul/sdiv/...`, comparisons, `bit_slice/concat/decode/encode/one_hot`, `sel/one_hot_sel/priority_sel`, `array/array_index/array_update/tuple` — maps onto SMT **bit-vector + array theories**. This mapping is **not speculative — the shipping IR→Z3 translator already realizes it.** Minor friction: `smulp/umulp` (partial-product) and `dynamic_bit_slice`. *(confidence: high)*

## 3. The conceptual shift: hardware has no program counter

The deepest point. KLEE-style SE assumes a sequential CFG where one branch is live at a time. In hardware **every node executes; branches are muxes, and many are active simultaneously each cycle.** This is why the RTL literature (RFUZZ, DirectFuzz) defines coverage as **mux-toggle**: each 2:1 mux select must evaluate both true and false. For XLS IR (pure dataflow, no PC), the coverage target must be defined over **`sel`/`one_hot_sel`/`priority_sel` toggles and node activation** — not linear paths. *(confidence: high)*

Corollary: mux-toggle coverage **provably misses combinational logic that doesn't drive a select signal** (2024 fuzzing survey + DIFUZZRTL). An actual argument *for* path-sensitive SE on the combinational subset having standalone value. *(confidence: medium, 2–1)*

## 4. Challenges, in order of how much they'll hurt

1. **Path/state explosion** — *the* dominant barrier. The explicit reason the RTL test-gen field pivoted from formal/SE to fuzzing (DirectFuzz DAC'21; arXiv 2304.05445 is literally titled *"Countering the Path Explosion Problem in the Symbolic Execution of Hardware Designs"*). *(high)*
2. **Multiplication** — XLS's own docs: "SAT scales exponentially... past a point of utility for complex operations, notably multiplication." Multiplier nodes are common; hard per-node solver cost. *(high)*
3. **Arrays** — handle via **concolic concretization**: resolve the index expression to a concrete value during concrete sim, treat each element as an independent variable. The UF/Mishra concolic work shows static-analysis SE *can't* handle dynamic array refs; concolic does. Informs `array_index/array_update` modeling directly. *(high)*

## 5. Build-vs-reuse → reuse, and go concolic

Two known architectures (SystemC CrosSym/SEFOS, by analogy): modify the sim kernel vs. modify the SE engine. The lesson — **reuse existing infrastructure** — points at building atop XLS's IR→Z3 translator for the encoding layer rather than re-deriving IR semantics.

The proven practical template is **concolic** (UF, VLSI Test'14): instrument → run on a simulator to get a concrete operation trace → convert trace to path constraints → **negate a constraint → solve to force an unexplored path.** This maps onto XLS almost too neatly: **XLS's JIT/interpreter is the concrete backend; the IR→Z3 translator is the constraint solver.** You'd be gluing two things XLS already ships. *(architecture: high; the empirical payoff — Zet x86, 99.54% coverage in 140 tests vs 97.26% in 40,000 random — is **one 2014 benchmark**, medium confidence.)*

## 6. Honest competition: fuzzing

RFUZZ and DirectFuzz explicitly position fuzzing as **cheaper to engineer, more portable, more scalable** than SE. DirectFuzz reaches target sites up to 17.5× (avg 2.23×) faster than RFUZZ using a hierarchy-distance metric. **Any XLS SE must justify itself against these** — and the honest answer is likely *complementary*: **SE generates high-value seeds for hard targets; a fuzzer mutates around them.** Caveat: no source benchmarks SE head-to-head against fuzzing on identical RTL, so relative-scalability claims are directional, not quantified.

## 7. State and procs: how far does it extend?

- **Single-process state is bounded.** Proc statefulness is *exactly two ops*: `state_read` and `next_value`. The extension is carrying per-tick state across activations — i.e. **bounded unrolling**. Realistic. *(2–1 on the bounding inference; the two-op fact is unanimous)*
- **Procs + channels is the genuinely hard case.** `send`/`receive`, tokens, infinite-depth FIFOs with flow control/back-pressure, and activation overlap (N+1 may start before N's state resolves) introduce **concurrency** — the real difficulty. Defer it. *(high)*

So: **combinational is useful on its own** (fuzzing seeds, coverage closure, the mux-blindness gap above), but the *highest-value* hard-to-reach states are behind Proc state. Don't oversell v1.

## Recommendation: the minimal-useful version

> **v1:** A *combinational, concolic, coverage-directed input generator* that reuses XLS's IR→Z3 translator for constraint solving and the JIT for concrete execution. Coverage target = `sel`/`one_hot_sel`/`priority_sel` toggle + node coverage. Arrays via concretization.
>
> **Benchmark against:** (a) plain XLS QuickCheck / `prove_quickcheck_main` with coverage-shaped properties, and (b) a fuzzing baseline (RFUZZ/DirectFuzz-style over the JIT'd IR). If you can't beat QuickCheck-with-coverage-properties, the project has no reason to exist — that's the make-or-break experiment.
>
> **v2:** Proc state via bounded unrolling. **v3 (deferred):** procs + channels.

## Open questions the research couldn't close

1. What's the empirical scaling ceiling of XLS's *existing* translator on real combinational designs before multipliers/arrays blow up?
2. **Does a dedicated SE engine actually beat instrumenting QuickCheck with coverage-shaped properties?** (The crux. Untested anywhere.)
3. Does the JIT give a cheap enough concrete backend to make concolic clearly better than KLEE-style fork-on-branch here?
4. How to encode back-pressure / activation-overlap symbolically without state explosion.

## Caveats

Strongest claims rest on first-party XLS docs + peer-reviewed papers (RFUZZ ICCAD'18, DirectFuzz DAC'21, UF concolic VLSI Test'14). The SE-efficiency number is a single 2014 benchmark. Several XLS-specific bridges are inferences, not source assertions. XLS is actively developed — op set and Proc state ops (`state_read`/`next_value`; older `state_next` naming appears in some sources) are current as of the docs but may shift.

## Sources

- XLS solvers / formal docs — <https://google.github.io/xls/solvers/>
- XLS IR semantics — <https://google.github.io/xls/ir_semantics/>
- XLS repo — <https://github.com/google/xls>
- RFUZZ (ICCAD'18) — <https://adept.eecs.berkeley.edu/papers/rfuzz/>
- DirectFuzz (DAC'21) — <https://www.semanticscholar.org/paper/DirectFuzz:-Automated-Test-Generation-for-RTL-using-Canakci-Delshadtehrani/1c0c23da82b9929ac54bd2efa939d6079750a793>
- UF/Mishra concolic RTL test gen (VLSI Test'14) — <https://www.cise.ufl.edu/research/cad/Publications/vlsi14test.pdf>
- Countering Path Explosion in SE of Hardware (arXiv 2304.05445) — <https://arxiv.org/abs/2304.05445>
- Hardware fuzzing survey (arXiv 2403.12812) — <https://arxiv.org/pdf/2403.12812>
- DIFUZZRTL — <https://lifeasageek.github.io/papers/jaewon-difuzzrtl.pdf>
- CrosSym/SEFOS SystemC SE (arXiv 2509.05504) — <https://arxiv.org/pdf/2509.05504>
