---
author: Claude Fable 5
---

# bpf-tv: evaluating a translation validator for LLVM IR → BPF

Question: is building an arm-tv-style translation validator for the LLVM BPF backend worth pursuing, and if so in what shape?

Method: 4 parallel research threads (2026-07-30) — arm-tv/riscv-tv deep dive (paper + repo history), LLVM BPF backend internals + miscompile record, semantics-substrate inventory, novelty/competition sweep — plus recall of prior BPF ISA research (2026-07-29) and nanuk satellite-track framing (2026-07-11). Primary sources cited inline.

## Verdict

Worth pursuing, in a specific shape: a BPF lifter inside the arm-tv codebase, validating the `.o` as a *template* with CO-RE-relocatable fields symbolic, staged so semantic TV is v0 and verifier-acceptability checking is a separate later tool. The honest expectation: modest bug yield, high infrastructure leverage, one genuinely novel design element (symbolic relocations), and a defensible unclaimed lane with moderate collision risk.

Framing (per 2026-07-30 clarification): tool-first, not paper-first — publication is a welcome side effect, community-workshop sharing is the baseline. This weakens the two paper-shaped risks (low bug yield, replication-isn't-paper-sized), converts collision risk into mere redundancy risk (a tool stays useful even if someone publishes first), and matches the riscv-tv precedent exactly: shipped as a Dev Mtg talk + working code, no paper. What it raises instead: the bar for usability and maintenance — the tool's value now depends on someone (starting with its author) actually running it.

## The recipe and what it costs

arm-tv ([OOPSLA 2025](https://dl.acm.org/doi/10.1145/3763147), [paper PDF](https://users.cs.utah.edu/~regehr/papers/arm-tv.pdf)) validates by lifting: backend lowers IR → asm; a lifter raises asm back to LLVM IR; the LLVM middle-end compacts the lifted IR; modified Alive2 checks refinement. 45 miscompiles found (39 fixed); most fixes landed in target-*independent* SelectionDAG/GlobalISel code. Dev repo: [regehr/alive2, branch `arm-tv`, dir `backend_tv/`](https://github.com/regehr/alive2/tree/arm-tv); frozen artifact on [Zenodo](https://zenodo.org/records/17013831).

- The target-independent hard parts — Alive2 "assembly mode" (physical pointers, `freeze poison` adversarial initial state), ABI axioms making per-function verification compose, SMT memory-encoding optimizations (~10× reduction, upstreamed to mainline Alive2) — took ~3 years and are done, open source (MIT).
- Measured effort floor for a new target: riscv-tv ([LLVM Dev Mtg 2025 slides](https://llvm.org/devmtg/2025-10/slides/student_talks/briles.pdf)) = one student + advisor, ~2 kloc lifter C++, ~5 months in the same codebase, with backend-code-owner advice (Craig Topper). RV64IMB done; found 1 new miscompile ([PR #155231](https://github.com/llvm/llvm-project/pull/155231)).
- Semantics-source fork quantified: hand-written AArch64 lifter = 8.1 kloc, empirically bug-prone, needed 7,500+ tests; spec-derived lifter (ARM MRA/ASL via ASLp) = ~2 kloc + 1 kloc OCaml, "almost completely correct by construction." BPF has no MRA analogue — a hand lifter at BPF scale (~120 opcodes, no FP/flags/vectors) is nearer 1–2 kloc, but the correctness burden lands on testing (bpf_conformance's 313-test corpus is the natural harness).
- Known Alive2 blockers: scalable vectors (irrelevant) and multiple address spaces (bites: BPF arena `addr_space_cast`, kernel 6.9+ — exclude in v0).

## The target: what the BPF backend actually is

- SelectionDAG is the production ISel path; a GlobalISel skeleton exists but is minimal. Custom passes split cleanly: semantics-relevant (BPFMIPeephole zext-elimination, BPFMISimplifyPatchable/CO-RE, BPFCheckAndAdjustIR incl. arena addrspacecast handling, atomics lowering, branch layout) vs metadata (BPFAbstractMemberAccess, BTFDebug) vs verifier-appeasement-only (BPFAdjustOpt, [D147968](https://reviews.llvm.org/D147968) TTI hooks — semantically no-ops by intent, cheap TV targets).
- Miscompile record: ~10–12 documented true wrong-code incidents; 5 issues carry the `miscompilation` label today, 3 open and recent — atomics returning the wrong value ([#210280](https://github.com/llvm/llvm-project/issues/210280)), branch-over-empty-block resolving to the wrong offset ([#208984](https://github.com/llvm/llvm-project/issues/208984)), wrong CO-RE bitfield access ([#77720](https://github.com/llvm/llvm-project/issues/77720)).
- The hot spot: BPFMIPeephole's 32-bit-subregister zero-extension elimination — ~5 wrong-code fixes in one ~1 kloc pass over 7 years (loop back-edges 2019, PR48578 2021, bpf_fastcall [#110618](https://github.com/llvm/llvm-project/pull/110618) 2024, subreg misfolding [#208244](https://github.com/llvm/llvm-project/pull/208244) 2026). Local, per-function, single semantic dimension (upper-32-bit state) — a near-ideal TV target.
- The backend's own culture concedes the risk: checking passes (BPFMIChecking, reloc-in-PHI check) deliberately fatal-error at semantic cliffs rather than trust the lowering.
- Scale is favorable: integer-only scalar code, 512 B stack, no dynamic allocation/varargs/exceptions, helpers as plain external calls, functions typically O(100)–O(10k) insns. Bounded loops fit Alive2's bounded-unrolling TV model better than general code does.

## The trust-gap motivation (why yield ≠ value)

Expected yield of generic miscompiles is low: arm-tv mined out the shared SelectionDAG code ("fuzz one, fuzz all" — riscv-tv found exactly one new bug). A bpf-tv finds BPF-specific lowering bugs, and the record shows those cluster in exactly the passes a lifter-based TV covers.

The motivating asymmetry: the kernel verifier checks *safety*, not *correctness* — a miscompiled program can be verifier-accepted and silently wrong ([#208984](https://github.com/llvm/llvm-project/issues/208984) is precisely this). Jitterbug verified below the bytecode (JITs); Agni verifies the verifier; BeePL/VEP/BCF bypass or augment the pipeline. Above the bytecode — the step everyone actually ships through — nothing checks correctness. That sentence is the paper's motivation section.

## The cut-point problem (the novel part)

The compiler's `.o` is not final code: libbpf rewrites imm/off fields at load time (CO-RE, [reference](https://nakryiko.com/posts/bpf-core-reference-guide/)), then the verifier patches again (ctx-access rewrites, map-pointer embedding). A validator must choose its cut-point explicitly:

1. **`.o` as template** — treat relocatable fields as symbolic constants constrained by `.BTF.ext` records. Stays within the compiler's contract; proves correctness for *all* kernels at once; fits SMT naturally. This is the design novelty over arm-tv (which handles concrete relocations only), and BPFMISimplifyPatchable/BPFAbstractMemberAccess become validated rather than trusted.
2. Post-libbpf — adds libbpf's relocation algorithm to the obligations; a separate tool if ever.
3. Post-verifier-patching — out of scope; that is verifier territory.

v0 exclusions consistent with arm-tv precedent: arena address spaces, inline asm (pervasive via `barrier_var`/`may_goto` macros — passthrough or reject; a real coverage cost worth measuring early), bpf2bpf multi-subprogram composition, helpers/kfuncs as uninterpreted calls with matched call sequences (K2's treatment; sound because the backend doesn't reorder calls), maps via K2-style encoding or havoc'd distinguished blocks.

## Verifier-acceptability: adjacent, not the same project

Verifier-rejection regressions outnumber miscompiles ~10:1 in the issue record and drive real behavior (Cilium pins `llvmorg-19.1.7`; kernel selftests keep a per-clang-version workaround ledger; `barrier_var` exists). But checking "output remains verifier-trackable" means modeling a version-dependent kernel abstract domain — not a fixed ISA. Different obligations, different TCB, different tool. Agni's machine-extracted verifier semantics is the natural substrate if that tool ever gets built. Keep it out of bpf-tv v0; it is the differentiating *second* result if the project grows into a paper.

## Landscape and timing

- Lane confirmed empty as of 2026-07-30: no tool, paper, thread, or grant occupies LLVM IR → BPF TV. BPF appears nowhere in arm-tv's paper, repo (`git grep -i bpf` empty), or stated future work (x86-64 named instead).
- Collision ranking: (1) the arm-tv group — methodology transfers directly, BPF is cheap for them; (2) ETH Sun/Su (SOSP 2025 best-paper verifier proof-delegation) — adjacent, could pivot; (3) Kops authors — already prove per-instruction emission equivalence in Lean 4. Mitigation and strategy coincide: build inside their codebase and engage early — the co-champion pattern (Craig Topper for riscv-tv; BPF analogues: Yonghong Song, Eduard Zingerman) converts the fastest potential scooper into a collaborator.
- Funding: eBPF Foundation RFP explicitly solicits formal verification of "verifiers and JITs"; no funded project covers the compiler stage; 2026 call planned. Only BPF-related NSF FMitF award is verifier-side.
- Sharing venues (tool-first): LPC eBPF track and LSFMM+BPF are the natural rooms — both have precedent for tooling talks (Agni got maintainer engagement at LSFMM 2025; ePass presented at LPC 2025); LLVM Dev Mtg is the riscv-tv precedent (talk + code, no paper); eBPF workshop @ SOSP if a writeup materializes (2026 deadline passed; 2027 exists). If a paper ever happens, the story = trust gap + symbolic-relocation validation + verifier-visible-property checking; venue precedents OOPSLA/CAV/OSDI.

## Substrate decision

Alive2/arm-tv fork, not xdsl-smt. xdsl-smt's published TV covers control-flow-free scalar code only — no loops, no memory at scale, no LLVM-dialect semantics on the source side ([PLDI 2025](https://users.cs.utah.edu/~regehr/papers/pldi25.pdf)). Its realistic role is validating a future BPF-dialect→BPF-dialect optimizer. Consequence: bpf-tv and the xDSL BPF-dialect idea are two different projects with different engines — the "BPF-the-ISA vs BPF-the-target" fork from the 2026-07-29 strategy discussion, now with the substrate assignment settled per side.

Reusable side-B assets: PREVAIL's concrete semantics (MIT, tracks RFC 9669 incl. atomics) as ground truth; K2's SMT map encoding (MIT) as pattern; bpf_conformance as differential harness for the lifter; uBPF/rbpf as executable oracles. None is a drop-in; the lifter is the work.

## Development model: out-of-tree is viable (fork not required)

Verified against the arm-tv tree (2026-07-30 clone):

- The extension seam is a class hierarchy, not a monolith: `mc2llvm` base (11 virtuals, target-agnostic MC plumbing) with `arm2llvm final : public mc2llvm` and `riscv2llvm final : public mc2llvm`. The only hard-coded coupling is a 2-line if/else dispatch in `backend_tv/lifter.cpp` plus target-init in the ~450-line driver `tools/backend-tv.cpp` ("Only aarch64 or riscv64 are supported").
- The build already produces static libraries (`backend_tv`, `llvm_util`, `ir`, `smt`, `tools`, `util`); the `backend-tv` executable is a thin client. Caveats: no install/export of those libs (only `alive`/`alive-jobserver` install; a shared `alive2` lib target exists but is commented out), no releases, no stable API — consumers include from the source dir and track a moving branch.
- Prior art, both models: **out-of-tree consumer** — Minotaur ([OOPSLA 2024](https://users.cs.utah.edu/~regehr/minotaur-oopsla24.pdf), [repo](https://github.com/minotaur-toolkit/minotaur)) builds against Alive2 via `ALIVE2_SOURCE_DIR`/`ALIVE2_BUILD_DIR` CMake vars; nuance: its extensions touched core semantics, so it still points at a patched fork ([alive2-intrinsics](https://github.com/minotaur-toolkit/alive2-intrinsics)). **In-tree new target** — riscv-tv itself (3 files + dispatch lines). **External-tool bridge accepted in-tree** — the ASLp `aslp/` subdirectory.
- bpf-tv is better positioned for pure out-of-tree than Minotaur was: a new lifter subclasses `mc2llvm` and needs no core Alive2 changes for v0 (assembly memory mode is already flag-gated in the driver). The BPF driver can be an own-repo file modeled on `backend-tv.cpp`, bypassing the hard-coded dispatch entirely.

Recommended model: own repo (`bpf-tv`), arm-tv branch pinned as a submodule, Minotaur-style CMake against its static libs, own driver + `bpf2llvm` subclass. Zero fork maintenance; the repo contains only BPF code. The working lifter then *is* the in-tree proposal ("may I add the two dispatch lines?") — a natural first-contact PR. Residual risks: tracking an active research branch without releases (pin + periodic rebase), and arena address-space support later would touch Alive2 core — at which point the Minotaur position (small patched fork) is the fallback, but that is deferred scope.

## Cons, stated plainly

- Low headline bug count is the likely outcome (matters less under tool-first framing, but shapes expectations for announcement impact).
- Demand is latent: no maintainer has asked for compiler-correctness tooling; community anxiety is verifier-side. Adoption (CI use) is unproven even for arm-tv — its safety-critical pushbutton goal is explicitly "not yet fully realized." Under tool-first framing this is the *primary* risk: a tool nobody runs is strictly worse than an unpublished paper.
- The substrate is one professor's active research branch of Alive2 — no releases, no stable API, longevity not guaranteed. Mitigated by the out-of-tree model (own repo + pinned submodule; see Development model), but the dependency risk doesn't vanish.
- Inline asm pervasiveness in real BPF programs may cap coverage of production code (Cilium et al.) more than it did for arm-tv's C benchmarks; measure early.
- Opportunity cost against Pakeles/nanuk: this is a formal-methods tooling project with a different audience than the wire-format/IR line; it feeds the BPF-credibility arc but not the parser-IR arc directly.

## Staging, if pursued

1. Reproduce riscv-tv locally in the arm-tv branch; understand `backend_tv/` structure (repo already cloned to scratchpad during research).
2. BPF lifter v0 in own repo per Development model (arm-tv as pinned submodule, own driver, `bpf2llvm : mc2llvm`): loop-free, integer-only, single-subprogram, concrete relocations, no arena/inline-asm; bpf_conformance corpus as lifter test suite; differential-test the lifter against uBPF/rbpf.
3. Run over kernel selftests + Cilium `.o`s; measure supported-function coverage and solver timeouts; fuzz with YARPgen/IRFuzzer per arm-tv's oracle recipe.
4. Symbolic CO-RE relocations — the novel increment.
5. Engage: LLVM Discourse + BPF backend maintainers at whatever point 2–3 produces a first result; propose a talk at LPC eBPF track or LSFMM+BPF; eBPF Foundation 2026 call as funding vehicle if wanted.
6. Verifier-acceptability checker: separate decision, revisit only after v0 lands.
