# Session 01 — Z3Wire extract + replace API redesigns

Repo: https://github.com/qobilidop/z3wire (work in `~/i/z3wire`).

Two back-to-back API redesign PRs landed on `main` this session:
- **PR #30** (`bc03a5a` is the next commit; #30 merged as `dd93230`): Unify extract API around `(width, low-offset)`.
- **PR #31** merged as `bc03a5a`: Replace API redesign (loosen field, add runtime-offset overload).

Branch `main` is now at `bc03a5a`. All remote feature branches deleted (extract-api-redesign, worktree-packet-view-example, replace-api-redesign). Renovate branches preserved.

## Workflow used (both redesigns)

1. `superpowers:brainstorming` → spec to `.agent_scratch/YYYY-MM-DD-<topic>-design.md` (project gitignores `.agent_scratch/`, so specs NOT committed; copied into worktree's `.agent_scratch/` for subagent reference).
2. `superpowers:writing-plans` → plan to `.agent_scratch/YYYY-MM-DD-<topic>-plan.md`.
3. `superpowers:using-git-worktrees` → `EnterWorktree(name=...)` creates `.claude/worktrees/<name>` on branch `worktree-<name>`. Push to remote with explicit refspec dropping the `worktree-` prefix: `git push origin worktree-X:X`.
4. `superpowers:subagent-driven-development` → per task: implementer subagent, spec compliance reviewer, code quality reviewer (loop until ✓ for each). Use general-purpose subagents; inline content of the task into prompts (don't make subagents read the plan file).
5. `superpowers:finishing-a-development-branch` → user pre-selected option 2 (PR) both times.
6. After merge: `ExitWorktree(action="remove", discard_changes=true)`, then `git fetch --prune`, `git pull --ff-only`, manually delete remote branch if GitHub didn't auto-delete (`git push origin --delete <branch>`).

## Key project facts (z3wire)

- Build: Bazel primary (`./dev.sh bazel test //...`), runs in devcontainer. CMake secondary.
- Style: Google C++ Style; free functions in `snake_case` (matches Z3). Default no comments unless WHY non-obvious. Markdown: plain hyphens (not em dashes), sentence case for non-title headings.
- Engineering: TDD, YAGNI, DAMP over DRY, local reasoning. One commit per logical change, subject < 72 chars.
- `Z3W_CHECK(cond) << "msg"` from `z3wire/check.h` — aborts via `std::abort()` on failure. Message prefix: `"Z3Wire check failed: "`. Use `EXPECT_DEATH(..., "Z3Wire check failed")` for death tests.
- Compile-fail tests: custom `cc_compile_fail_test` rule in `tests/compile_fail/defs.bzl`. **Now correctly shell-escapes `expected_message` apostrophes** (fixed in PR #31's last commit).
- Project memory rules (`~/.claude/projects/-Users-qobilidop-i-z3wire/memory/`):
  - Trivial fixups should amend, not new commit.
  - Auto-commit and auto-push without asking.
  - Skip worktree + PR for trivial docs/config edits; commit direct to main.
  - PR test plans must be verified locally with `[x]` for passing items.

## Extract redesign (PR #30) — what landed

API surface:
```cpp
extract<W, Lo>(v)            // static, both compile-time
extract<W>(v, size_t lo)     // runtime concrete offset (NEW)
// symbolic-offset overload REMOVED; compose: extract<W, 0>(shr(v, idx))
```

Return type: always `SymUInt<W>` (strips signedness — slice is a new value, no inherited type).

OOB:
- Static: `static_assert(W > 0 && Lo + W <= W_src)` → templ param renamed to `SrcW` (matches existing convention; reviewer caught `W_src` style nit).
- Runtime: `Z3W_CHECK(lo <= SrcW - W)` (phrased to avoid `SIZE_MAX` overflow; reviewer caught this overflow risk).

Precondition fix (commit `bf8e05e`): `shr(SymBitVec<W,S>, SymUInt<K>)` for `K > W` used to truncate the amount via `unsafe_cast<SymUInt<W>>(amount)`, silently wrapping large symbolic amounts. Fixed by widening source to `max(W, K)` (zext unsigned / sext signed), shift, truncate back. Required for the composition pattern to actually saturate to zero on large offsets.

Migration impact: 7 commits including format/include-cleaner cleanup at the end. `packet_view.cc` no longer has the `<31+B, 0+B>` doubled `BaseOffset` foot-gun.

## Replace redesign (PR #31) — what landed

API surface:
```cpp
replace<LO>(src, field)               // static
replace(src, field, size_t lo)        // runtime concrete (NEW)
replace(src, field, SymUInt<WL> lo)   // symbolic — KEPT (composition too verbose)
```

Field type loosened from `SymUInt<WF>` → `SymBitVec<WF, SF>` in all forms (forward-compatible — `SymUInt<WF>` IS `SymBitVec<WF, false>`).

Return type: preserves source signedness (replace is a *modification*, not a *projection* like extract).

Two intentional asymmetries with extract (documented in `docs/usage/operations.md`):
1. Symbolic-offset kept (composition is 8 lines with 3 subtle traps: shl widens, mask `(1ULL << WF) - 1` is UB at WF==64, signedness juggling).
2. Return preserves signedness.

Bonus fix bundled in (commit `ca03d78`): `cc_compile_fail_test` shell-escape (apostrophe in `"doesn't fit"` static_assert message was breaking the generated shell script). One-line fix in `defs.bzl`: `expected_message.replace("'", "'\\''")`.

4 commits total. First-ever compile-fail tests for `replace` added.

## Useful prior-art tables (cite in future similar work)

Extract: SMT-LIB/Z3 (`((_ extract i j) bv)` inclusive), SystemVerilog (`vec[lo +: W]`), Chisel (inclusive), CIRCT comb.extract (low+width), ac_int slc<W>(lo) (low+width), Rust bitvec (half-open), SystemC sc_bv (inclusive).
- Dynamic-offset forms converge on `(lo, width)` parameterization.
- No surveyed library has symbolic-offset extract — none operates on symbolic values.

Replace: NO library has a *functional, immutable* bit-replace.
- Mutating slice-LHS: SystemVerilog, sc_bv, Rust bitvec.
- Mutating method: ac_int set_slc.
- Z3 + CIRCT comb: no replace, synthesize via concat/extract.

## Subagent-driven lessons (reinforced)

- Implementer NEEDS_CONTEXT when plan misses files — happened twice (Task 2 of extract: missed barrel_shifter/multiplier/usage/operations.cc; Task 4 of extract: missed examples/usage/operations.cc's `demo_symbolic_extraction`; Task 2 of replace: missed `examples/symbolic_execution/exact_match_table.cc` raw-z3 workaround). Always grep for ALL callers before writing the plan's substitution table.
- Review fixups: amend the recent commit (per project policy on trivial fixups). Don't dispatch a fresh reviewer for the amend if the fix is exactly what was asked.
- LSP clang noise (no Bazel include paths) is constant during edits to header-dependent files. Ignore; trust `bazel build`.

## Open follow-ups / observations

- One subject line still over the 72-char limit on main: `bf8e05e` is 75 chars ("sym_bit_vec: fix shr to widen source when shift amount width exceeds source"). Not fixed — would have required rebasing the extract PR and breaking commit SHA links. Could be addressed if a future squash-merge gets adopted.
- Renovate has open branches (bazel-8.x, bazel-9.x, rules_cc-0.x, ubuntu-26.x). Not touched.
- The unintended file deletion mystery from after the extract PR merge: `z3wire/sym_bit_vec.h` showed up as `D` in the main checkout's working tree after `ExitWorktree`. Restored via `git restore`. Cause unclear — possibly an LSP/hook race. Worth watching for again.

## Commands cheat sheet

- Build: `./dev.sh bazel build //...`
- Test: `./dev.sh bazel test //...`
- Lint: `./dev.sh ./tools/lint.sh`
- Format: `./dev.sh ./tools/format.sh` (or `--check` for CI mode)
- Docs build: `./dev.sh ./tools/docs.sh`
- Single test filter: `./dev.sh bazel test //z3wire:sym_bit_vec_test --test_filter='SymBitVecTest.X*' --test_output=errors`
- Compile-fail test: `./dev.sh bazel test //tests/compile_fail:NAME --test_output=errors`
