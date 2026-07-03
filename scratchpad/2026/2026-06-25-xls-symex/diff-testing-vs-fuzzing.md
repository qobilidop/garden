# Diff Testing with XLS as Source of Truth — Symbolic/Concolic vs Fuzzing

*2026-06-25. Follow-up to [symex-evaluation.md](symex-evaluation.md), narrowing the use case to differential testing.*

**Goal under evaluation:** use the XLS model as source of truth, and diff-test it against a hand-written simulator efficiently. How much value does a symbolic/concolic test generator add over fuzzing for *this* goal?

## The reframe: target is divergence, not XLS-model coverage

In the prior report the goal was covering the XLS model's own branches. For diff testing the target is `XLS(x) ≠ Sim(x)`. These are not the same set:

- A symbolic/concolic executor on the **XLS model only** covers the *XLS model's* paths but is **blind to the simulator's structure.** A divergence can sit on an input that's trivial in the XLS model yet hits a buggy corner in the sim. XLS-model coverage is a weak proxy for divergence coverage.
- Since XLS is the *source of truth*, bugs are by assumption **in the simulator**. SE-on-XLS steers by the structure of the artifact declared correct — the wrong artifact. To target sim bugs structurally you'd symbolically execute the *sim* (KLEE on the C++), not the model.

The test-generator from the prior report therefore carries over poorly.

## Fuzzing is unusually strong for this specific goal

Two normal fuzzing weaknesses vanish in differential testing:

1. **The oracle is free and perfect.** Fuzzing's hardest problem — "is this output a bug?" — disappears. Any mismatch is a bug. This is why differential fuzzing dominates in practice (compilers via Csmith, crypto, serializers).
2. **Both sides are fast.** XLS JITs IR to native; the sim is presumably fast. Millions of diff-pairs/sec. Throughput finds the bulk of divergences.

So **coverage-guided differential fuzzing** is the baseline, and it's hard to beat on ROI.

## Where concolic still earns its keep — narrowly

Concolic beats fuzzing in one regime: **divergences behind tight equality guards.** If the two disagree only when `x == 0xDEADBEEF` (or a specific overflow/rounding/signed-edge corner), random mutation finds it with ~2⁻³² probability; concolic flips that constraint and lands it immediately. For arithmetic hardware — multiplier corners, divide-by-edge, signed/unsigned boundaries — divergences often *are* these narrow guarded cases. Concolic's real role here:

- **Crack the hard guards** fuzzing plateaus on, and
- **Seed the fuzzer** (Driller / whitebox-fuzzing hybrid: concolic gets past the guard, cheap mutation explores around it).

Genuine but **bounded, second-phase** value — reach for it only when pure differential fuzzing stops finding things.

## The symbolic tool you actually want is a miter, not a generator

If you model **both** sides symbolically, the high-value technique is not test generation — it's **bounded equivalence checking**: encode `XLS(x) ≠ Sim(x)` as one SMT formula and solve. This gives what fuzzing *categorically cannot*:

- a **proof of equivalence** over the entire bounded input domain (fuzzing can never prove absence of divergence), and
- a **minimal counterexample** when they differ.

This is exactly what **XLS LEC does** — except LEC mites XLS IR against a *netlist*. Diff-testing against a hand-written sim is "LEC against a different reference model." If the sim is SMT-encodable (or translatable), you're **extending LEC's miter to a new right-hand side**, reusing the IR→Z3 translator unchanged. The most XLS-native play.

Catch: requires a formal model of the sim, and inherits SMT scaling limits — multiplication blows up, sequential depth multiplies the burden. If the sim is big, pointer-heavy, or float-laden (often *why* it's hand-written), the miter is impractical and you fall back to fuzzing.

## Verdict — ranked for this goal

1. **Differential fuzzing (JIT'd XLS vs sim)** — highest ROI. Free perfect oracle + fast executors. **Start here.** The thing to beat.
2. **Bounded equivalence miter (LEC-style, sim as reference)** — highest *capability*, if the sim is SMT-modelable. Only approach that can *prove* equivalence or give minimal counterexamples. This — not the coverage-directed generator — is the symbolic technique worth building toward.
3. **Concolic test-generator on the XLS model** — **lowest marginal value of the three for this goal.** The free oracle removes the weakness it patches, and XLS-model coverage ≠ divergence coverage. Niche shrinks to *seeding the fuzzer* and *cracking tight arithmetic guards* — a phase-2 booster on (1), not a primary strategy.

**Bottom line:** vs the single-design coverage goal in the prior report, the concolic generator's value **drops** for diff testing. The symbolic weapon worth building here is the **miter**, not the generator — and only if the sim is cheap enough to formalize. Otherwise differential fuzzing is the efficient answer, with concolic seeding held in reserve for plateaus.

## Open question to resolve next

Can XLS's `z3_ir_translator` / LEC plumbing accept an *arbitrary external reference model* (the sim) as the miter's other side, or is it hard-wired to IR-vs-IR / IR-vs-netlist? Determines whether option 2 is "extend LEC" or "build from scratch."
