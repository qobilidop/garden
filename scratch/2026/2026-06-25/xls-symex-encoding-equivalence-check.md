# Checking Two Symbolic Encodings of `f` for Equivalence

*2026-06-25. Follow-up to [xls-symex-diff-testing-vs-fuzzing.md](xls-symex-diff-testing-vs-fuzzing.md).*

**Setup:** a hand-written symbolic executor encodes `f(a_sym, b_concrete)` (partial evaluation — `a` symbolic, `b` a concrete value). XLS encodes `f(a_sym, b_sym)` (fully symbolic). **Question:** can we formally check the two `f`s are equivalent?

**Short answer:** yes — your executor is a *partial evaluation (specialization)* of the fully-symbolic one, so the check is *specialization equivalence* via an SMT miter. The only real question is how to quantify over `b`.

## Core framing

Both executors are formula emitters. XLS gives `F_xls(a, b)` over both vars. Yours gives `F_hand(a; β)` over `a`, parameterized by concrete `β`. Equivalence claim:

```
∀β ∈ dom(b). ∀a.   F_xls(a, b:=β)  ≡  F_hand(a; β)
```

"XLS specialized at `β`" must equal "your executor at `β`." Each instance is a **miter**: assert `F_xls(a,β) ≠ F_hand(a;β)`, solve.

- **UNSAT ⇒ equivalent at β**
- **SAT ⇒ counterexample input `a`**

Quantifier-free bit-vector logic (QF_BV, or QF_ABV with arrays) — decidable, no quantifier alternation. Same machinery as XLS LEC, with your executor as the other side. The substitution `b:=β` is trivial in Z3 (assert `b == β` on XLS's formula, then miter), so XLS's `z3_ir_translator` output is reused unchanged as the reference.

## The crux: quantifying over `b`

Determines whether you get a *proof* or just *testing*:

1. **`b` domain small (few bits).** Enumerate every `β`, one miter each. Complete proof. Trivial if `dom(b)` is small (e.g. ≤ 2²⁰).

2. **`b` domain large, executor re-runnable with symbolic `b`.** Lift to `F_hand(a, b)` and do a *single* miter:
   ```
   ∃a,b. F_xls(a,b) ≠ F_hand(a,b)   →  expect UNSAT
   ```
   Strongest and cheapest — **but** only works if your executor *can* run with `b` symbolic. Which raises the real question: **why was `b` concretized?**

3. **`b` domain large, concretization load-bearing.** If `b` is concretized because the encoding is otherwise intractable or undefined — dynamic array index, shift amount, loop trip-count, control-path selector — there may be **no single symbolic-`b` formula** your executor represents; `F_hand` is genuinely a per-`β` family. No complete proof without enumerating `β`; limited to **bounded checking** (sampled β, or β a concolic run visits) or proofs over structured subdomains. **Figure out which regime you're in first** — it caps what "formally check" can mean.

## Mechanics / things that bite

- **Common logic.** Both formulas must land in the same theory. XLS emits Z3/SMT-LIB2 bit-vectors via `z3_ir_translator`; get yours into the same form (emit SMT-LIB, or build both via the Z3 API). The proof is only as sound as that translation's faithfulness — itself a trust assumption.
- **Correspondence.** Pin the variable mapping: same bit-widths, same signedness/endianness for `a`, and the **output** correspondence (equivalence is on outputs given equal inputs). XLS is exact about `bits[N]` widths; mismatches yield false SAT/UNSAT.
- **Scaling.** Multipliers/dividers bit-blast badly. Arithmetic-heavy `f` can choke even per-`β` miters.

## Caveat worth saying out loud

This checks the two encodings **agree with each other — not that either is correct.** Shared bug in both encoders → every miter returns UNSAT, learning nothing about correctness. Equivalence ≠ correctness vs the true spec. If XLS is the source of truth, "equivalent to XLS" is what you want — but only as strong as trust that XLS's encoding is faithful.

## Open question to resolve next

Does XLS's translator expose the formula in a form you can directly `b == β`-constrain and miter (a callable `Z3IrTranslator` boundary), versus only the packaged `lec_main` IR-vs-netlist flow? Decides whether options 1/2 are a few hundred lines or a fork.
