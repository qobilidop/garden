# Dealing with overflow systematically in XLS

2026-07-08.

In DSLX, `+` and `*` are same-width, wrapping ops — no implicit widening.
E.g. with `byte_offset: u10`, `byte_offset * u10:8` silently wraps once
`byte_offset >= 128`.

**Discipline: compute the mathematically exact result width first, widen
before the arithmetic, narrow explicitly only at the end.**

Running example: `absolute_bit_offset = byte_offset * 8 + bit_offset` with
`byte_offset: u10`, `bit_offset: u3`. Max value `1023 * 8 + 7 = 8191 = 2^13 - 1`,
so the exact result type is `u13`:

```rust
let absolute_bit_offset: u13 =
    widening_cast<u13>(byte_offset) * u13:8 + widening_cast<u13>(bit_offset);
```

## Toolkit, in order of preference

1. **Make overflow impossible by construction.** Multiplying by `2^3` and
   adding an exactly-3-bit value is bit concatenation:

   ```rust
   let absolute_bit_offset: u13 = byte_offset ++ bit_offset;
   ```

   Idiomatic answer for the running example — no arithmetic, synthesizes to
   pure wiring.

2. **`widening_cast<T>(x)`** to widen before arithmetic. Unlike `as`, it is
   checked at type-check time to be value-preserving (refuses to narrow).

3. **Widening ops from `std`** when the exact width isn't a nice concat:
   `std::umul(x, y) -> uN[N+M]` can't overflow by definition (also
   `std::smul`). Sum of `k` terms of width `N`: widen to `N + clog2(k)` first.

4. **`checked_cast<T>(x)`** when narrowing back down — asserts at runtime
   (interpreter/JIT tests) if the value doesn't fit, instead of silently
   truncating like `as`.

5. **Prove it.** Back the width reasoning with a quickcheck against a
   comfortably-wide reference:

   ```rust
   #[quickcheck]
   fn no_overflow(byte_offset: u10, bit_offset: u3) -> bool {
       abs_bit_offset(byte_offset, bit_offset) as u32 ==
           (byte_offset as u32) * u32:8 + (bit_offset as u32)
   }
   ```

   With `prove_quickcheck` (SMT-backed) this is a proof over all inputs, not
   sampling.

## Habit

Don't carry values at their storage width through arithmetic: widen at the
boundary where the computation starts, do all math at the exact result width,
narrow once at the end with `checked_cast`. Don't over-widen "to be safe"
either — extra bits are extra hardware; the exact width is both the safety
argument and the area-optimal choice.
