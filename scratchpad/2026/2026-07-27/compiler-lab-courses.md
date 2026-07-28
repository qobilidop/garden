# Hands-on compiler courses: comparison, sequence, 3-week sprint

Question: best open-source compiler course + lab, preferring RISC-V targets, Rust, SSA coverage. Baselines: [Crafting Interpreters](https://craftinginterpreters.com/), [PKU MiniC](https://pku-minic.github.io/online-doc/#/).

## Candidates

| Course / lab | You write | Target | SSA | Notes |
|---|---|---|---|---|
| [KAIST CS420 + KECC](https://github.com/kaist-cp/cs420) | Rust (skeleton given) | RISC-V | core focus | C compiler; irgen → SSA opts (mem2reg, GVN) → regalloc → asmgen; csmith-fuzzed grading |
| [Cornell CS 6120 self-guided](https://www.cs.cornell.edu/courses/cs6120/2025sp/self-guided/) | any (bril-rs exists) | Bril IR, no real ISA | deepest coverage | dataflow, dominators, SSA, LICM, JIT, GC; open-ended tasks |
| [PKU MiniC](https://pku-minic.github.io/online-doc/#/) | Rust or C++ | RISC-V | Koopa IR is SSA-form | full front-to-back from scratch, staged lv1–lv9 |
| [Tsinghua MiniDecaf](https://decaf-lang.github.io/minidecaf-tutorial/) | Rust among others | RISC-V | weak | same lineage as MiniC; superseded by it — skip |
| [sunshaoce/rvcc](https://github.com/sunshaoce/rvcc) | C, read-along | RISC-V | no | chibicc → RV64, 316 commit-lessons; evening read, foil for why IRs exist |
| Crafting Interpreters | Java/C | bytecode VM | no | frontend + VM craft; zero on the three criteria; Part III only, if at all |

Verdict: KECC is the only full match on all three criteria and covers exactly what MiniC treats lightly (SSA optimization, regalloc). CS 6120 is the best SSA education but targets a toy IR — theory companion, not the lab.

## Sequence (full ladder, ~4–5 months part-time)

1. clox (optional warm-up) → 2. PKU MiniC, breadth pass → 3. CS 6120 lessons 1–8 with tasks → 4. KECC, the main event → 5. CS 6120 lessons 9+ as dessert. Cut from the ends, never the middle; 6120 lands hardest *after* building something naive in MiniC.

## 3-week sprint shape (chosen 2026-07-27, assumes ~full-time)

- Week 1 — MiniC through lv8 (functions), skip lv9 (arrays: big time sink, low conceptual payoff). Surplus goes to cleaner Koopa emission, not lv9.
- Week 2 — 6120 lessons 1–8 with tasks done honestly. Budget by task, not lecture: lessons 1–3 compress to ~1.5 days; dataflow (4) and SSA (6) are a day or two each.
- Week 3 — days 1–3 clear task backlog + watch lessons 9+ (tasks skipped); days 4–5 close the loop: implement mem2reg or trivial GVN on own Koopa IR from week 1.
- Success bar: SSA construction (dominance frontiers, φ-insertion, renaming) implemented by hand at least once. Everything else negotiable.
- Part-time fallback: halve scope (MiniC lv6, 6120 lessons 2–6), don't stretch the calendar.

## CS 6120 lab logistics

No lab repo. Task specs = "Tasks" section at the bottom of each lesson page (e.g. [lesson 6, SSA](https://www.cs.cornell.edu/courses/cs6120/2025sp/lesson/6/)). Infrastructure = [sampsyo/bril](https://github.com/sampsyo/bril): `benchmarks/` as test suite, `brili` interpreter for output-equivalence checks, `is_ssa.py`, turnt (snapshot tests), brench (benchmark runner + instruction counts), docs at [capra.cs.cornell.edu/bril](https://capra.cs.cornell.edu/bril/). Own code in own repo; bril-rs gives typed (de)serialization of Bril JSON. Workflow per task: pass → benchmarks → brili → brench. Script that loop during lesson 2's warm-up.
