# Toward a portable packet-processing compiler stack: research + assessment

Status: deep-research synthesis, 2026-07-18. 23 sources fetched, 114 claims extracted, 25 adversarially verified (22 confirmed, 3 refuted). Companion to [oppx-design.md](oppx-design.md).

## The core structural finding

The LLVM analogy fails for a precise, verifiable reason: **LLVM-style portability requires graceful degradation, and PISA-class hardware has none.**

- LLVM works because every CPU target is Turing-complete: any program compiles anywhere, just slower. ONNX works because CPU fallback always exists.
- Compilation to PISA pipelines is all-or-nothing: fit and run at line rate, or fail to compile (Chipmunk/Gallium, verified 3-0). Rule-based compilers (Domino, Barefoot's toolchain) reject programs whose semantically equivalent rewrites would compile.
- P4 programs are not portable even between chips of the *same vendor*: Lyra (SIGCOMM 2020, Alibaba first-party) documents an 18-MAU INT program compiling on Tofino-032Q (24 MAUs) and failing on Tofino-064Q (12 MAUs).
- Every academic cross-target success works by **decomposition, never uniform abstraction**: Lyra synthesizes per-chip code from a "one-big-pipeline" program; Gallium partitions into switch program + x86 residual; Chipmunk regenerates backends by program synthesis.

Consequence: "portable compilability" is the wrong goal for switch ASICs. What *can* be portable is **semantics** — a program's meaning, checked by admission against target capabilities. This is exactly the OPPX positioning (semantic reference substrate, capability descriptions + ahead-of-time admission), and the research validates it as the defensible slot.

## Market state (verified)

- **Tofino is fully dead.** PCN 827577-00 (2024-08-07): entire line EOL, all seven SKUs, last ship 2025-02-28. Tofino 3 canceled Jan 2023. Intel open-sourced the Tofino p4c backend only *after* discontinuing the product (Jan 2025) — open-sourcing as end-of-life gesture, not ecosystem investment.
- **p4c is the closest living LLVM analog**: shared frontend/midend + 7 in-tree backends (BMv2, DPDK SWX, kernel eBPF, uBPF, Tofino…). But each backend targets a distinct architecture model, so the shared artifact is the *language*, not portable *programs*. The eBPF backend covers only a narrow subset (no >32-bit arithmetic, no ternary).
- **P4's definition itself is fragmented**: four diverging representations (spec, formalizations, implementations, tests) — P4-SpecTec (KAIST, ECOOP 2025) filed 9+13 issues from mechanizing it. The conformance/semantics wound is real and open.
- **eBPF is the one IR that actually worked as a HW-offload target**: Netronome attached unmodified eBPF via TC/XDP, in-driver JIT (`nfp_bpf_jit.c`, still in mainline). But the IR had to be co-evolved with the hardware (32-bit sub-registers, JMP32, verifier hooks), only a subset offloaded, and Netronome exited the market. **The design worked; the business did not.**
- **Vendors resist portability rationally**: NPL vs P4 split; DOCA layering proprietary libs over DPDK; PNA convergence judged unlikely by the P4 community itself because NIC vendors value differentiation. Operators (Alibaba) deliberately run multi-vendor ASICs for leverage — portability pressure is on the buy side only.
- **P4HIR/P4MLIR** is the community-endorsed incremental path; "defining a single dialect is relatively straightforward" vs full p4c-MLIR integration "far beyond any personal effort." (Caveat the workflow itself flagged: the source talk is my own 2024 P4 Workshop deck — self-citation, though p4lang/p4mlir-incubator's existence is independent uptake evidence.)

## The skeptical case, answered honestly

**Is an LLVM-for-packet-processors a bad idea?** As a universal write-once-compile-anywhere stack: **yes, probably.**

1. No graceful degradation → no universal compiler, by construction.
2. The switch-side M×N problem shrank on its own: M (open programmable ASIC vendors) collapsed post-Tofino. Two-ish vendors per segment don't need an interchange layer; per-target programming is genuinely fine there.
3. Backend economics are the documented killer: optimizing backends demand effort "not available for these new, niche, and evolving substrates" (Gallium), and the one commercial proof (Netronome) died commercially despite technical success.
4. History rhymes: OpenCL lost to CUDA at committee speed; OpenFlow died of optionality; ONNX survives only where fallback exists.

**Where the portability problem is real**: DPU/SmartNIC proliferation (many vendors, many SDKs, buy-side pain) and software datapaths (eBPF/XDP, DPDK, VPP — huge install base, graceful degradation, no vendor gatekeeper). And *semantic* portability — knowing two dataplanes implement the same behavior — is valuable even where compilability isn't portable at all.

## Implications for OPPX

The research strengthens the current design's bets and sharpens three:

1. **Semantics-first is the right slot.** The universal-compiler slot is structurally closed; the normative-semantics/conformance slot is open and demonstrably wounded (P4-SpecTec, BMv2-as-de-facto-spec, p4c backend divergence).
2. **Capability descriptions + admission are not a nice-to-have** — they are the *only* honest answer to all-or-nothing targets. Ship the mechanism early enough to be credible.
3. **Decomposition is the portability mechanism that works.** Lyra/Gallium/Chipmunk all decompose. OPPX's block signatures + interface packages should be framed as the substrate for *partitioning* (this part of the graph admits to the switch, the residual goes to the host) — a stronger story than "one graph, many targets."

## Concrete actions (small-project scale, roughly ordered)

1. **Ship v0 as planned** (spec + reference interpreter + Python builder), positioned as executable golden semantics — never as a compiler stack.
2. **Make differential testing the killer app**: P4-subset → OPPX; run v1model programs and diff (packet, metadata, effects, state) across BMv2 / p4c-dpdk / p4c-ebpf. This serves an existing pain (p4c's own backends diverge, and nothing checks them against each other) using the only corpus that exists.
3. **Interoperate with p4mlir-incubator, don't compete** — OPPX as the semantics/conformance layer P4MLIR lacks; a P4HIR↔OPPX bridge is a natural artifact and community entry point.
4. **Engage the P4-SpecTec effort** — nearest-neighbor project attacking the same wound (divergent representations) from the mechanized-spec side; OPPX attacks it from the executable-IR side.
5. **Track BPF ISA standardization at IETF** — eBPF bytecode is the only packet-processing IR with real multi-party governance momentum; define the OPPX↔eBPF relationship (frontend? backend? both?) before someone else defines the space.
6. **Defer all HW backends.** Design capability/admission when a HW-shaped consumer exists; until then it's speculation the market can't validate (open questions: current NPL/DOCA/Pensando programmability status — unverified in this pass).
7. **Long-shot to watch, not build**: Chipmunk-style synthesis as backend-generation to escape the per-target engineering trap (one research group, no production adoption).

## Verdict

Worthwhile **with modest expectations**: yes as semantics/conformance infrastructure with real near-term utility (differential testing) and option value (if a portable layer ever emerges, it needs exactly this substrate); no as an attempt to become the LLVM of networking — that goal is contradicted by the hardware's compilation model, the post-Tofino market, and every commercial precedent. The honest framing: build the thing that's useful even if the standard never happens.

## Addendum: the PANDA → kParser → XDP2 lineage (added same day)

A long-running open-source lineage — PANDA (2021), the CPL/CPR parser IR and kParser (2022–2023), and XDP2 (2025) — is the domain's most direct attempt at exactly this question, and functions as a live case study. The published essays around it (the "SmackDown" series and companions, late 2024–2025, all post-Tofino) are the most detailed practitioner statement of the portable-datapath position on record.

### Positions in the published essays (late 2024–2025)

- **The "SmackDown" trilogy (Apr 2025)** stages P4 vs eBPF/XDP vs DPDK for "ubiquitous programming model for the high performance datapath." Verdict: **a draw** — eBPF wins popularity/ecosystem, P4 wins features/performance-on-hardware, DPDK wins programming model. On P4's core mistake: "they boiled the ocean — a completely new language, new compilers, and new programming practices"; P4-to-CPU compilers found to have no traction; "P4 will always be a niche market."
- **The prescription** = ONNX-shaped topology with no DSL: "write once, run anywhere, **run well**"; multilingual frontends (C, Python, Rust, even P4) → rich IRs → portfolio of software and hardware backends; "minimize the distance from current solutions" (CUDA-model: data structures + functional APIs in commodity languages, smart compiler maps to targets); optimizing per-target backend compilers do the heavy lifting.
- **"The Fundamental Theorem of Offloads" (Dec 2024)**: an offload is *proper* (semantically identical to the software it offloads) **iff both executables derive from the same source code**. Corollaries: portability requires a common source/IR; DSLs are "not necessary and not sufficient"; validate offload equivalence by hashing the common IR and comparing hashes at runtime; resource-limit behavior must live in the common source. Approximate offloads are, on this view, *why offloads never became ubiquitous*.
- **The "CPU-in-the-datapath" / DSA essays** bet against match-action pipeline hardware entirely — domain-specific bare-metal RISC-V cores (no OS, no cache coherence, hardware thread schedulers, custom parser/checksum instructions, accelerator engines, horizontal+vertical parallelism), projecting ASIC-rival performance with full programmability. ~380-instruction-per-packet budget at 1 Gpps drives everything to accelerators; CPU as "orchestra conductor."

### The lineage's track record (public record)

- **PANDA** (open-source C-macro parse-graph framework, multi-target): repo last commit **Dec 2021**; no downstream adoption found.
- **CPL/CPR** ("Common Parser Language" declarative JSON parser IR, netdev 0x16, 2022 — frontends PANDA-C/Python/P4, backends eBPF/DPDK/kParser/hardware, IR-hash offload verification): the schema announced for upstreaming does not appear to have been published.
- **kParser** (kernel embodiment): standalone RFC (Oct 2022) drew no on-list replies. Resurfaced inside P4TC (Jan 2023); dropped by the next revision after consistent maintainer feedback to generate parsers as eBPF in userspace instead. One BPF maintainer's objection is notable for *supporting* a generic IR while rejecting its placement: "the layer of abstraction is wrong here. What if tomorrow P4 is not the 'lingua franca' anymore? Then all of it is still baked into uapi instead of having a generic/versatile intermediate layer." P4TC itself stalled on maintainer NACKs by mid-2024 (LWN "P4TC hits a brick wall"). The 0x16 slides' own benchmarks showed the interpreted kParser slower than the existing flow dissector.
- **XDP2** (Sept 2025, github.com/xdp2-dev/xdp2, BSD-2): the successor — parse-graph + table IRs, C-macro API, cppfront-based optimizing compiler, backends XDP/eBPF/userspace/DPDK, AI/ML infrastructure as the wedge. Active but young as of mid-2026 (rc3 stage); early mailing-list reception was politely skeptical.

### Lessons for OPPX

1. **Independent convergence on the diagnosis.** The lineage arrived at the same topology (language-neutral multi-frontend → IR → multi-backend), the same P4 post-mortem (DSL = ocean-boiling; P4 demoted to one frontend/backend among many), and the same core requirement (machine-checkable SW/HW equivalence) — from deep inside the kernel-networking world. Strong convergent validation of the *problem framing*.
2. **Hash-equivalence is weaker than reference semantics.** IR-hash proves *provenance* (both images came from the same source) but assumes compilers are correct. Bit-exact reference semantics + differential testing proves *behavior* — it catches the backends themselves diverging. The Fundamental Theorem is citable motivation; a conformance suite is the strictly stronger instrument. "Offload complete" ≈ OPPX capability/admission.
3. **Unpublished IRs die.** CPL was described in talks and mailing-list diagrams but no spec shipped, and no adoption followed. XDP2's IRs are again internal compiler artifacts — no normative spec, reference interpreter, or conformance suite. The normative-semantics slot this lineage keeps gesturing at remains **open** — it is exactly OPPX's slot, and the history is evidence both that the slot matters and that occupying it requires shipping a spec, not slides.
4. **The kernel's verdict shapes the design space**: anything new must *compile to eBPF in userspace*, not sit beside it in the kernel. A portable IR should be a userspace toolchain artifact with eBPF as a first-class backend — which is OPPX's plan already; the maintainer quote above is an on-the-record demand for a "generic/versatile intermediate layer" *outside* uapi.
5. **Single-vendor IRs face reception headwinds.** An IR proposed alongside one company's product tends to be evaluated as that product's on-ramp rather than as a commons — a structural dynamic, seen repeatedly (NPL, DOCA, this lineage). A spec-first, vendor-unattached project avoids it.
6. **The domain-specific-CPU bet, if right, reopens LLVM-style portability.** All-or-nothing compilation is a property of PISA-class pipelines. If DPU-era targets become seas of domain-specific CPUs (Turing-complete, gracefully degrading), portable *compilability* returns — the skeptical case weakens for exactly the target class where M×N pressure is real. If not (high-end switch physics keep favoring pipelines), semantics-first positioning is unaffected. Either way OPPX doesn't need to bet.
7. **Concrete opening**: XDP2 has the N-backends-one-source problem *today* and no conformance machinery. Differential-testing XDP2's backends (or offering OPPX as a semantic reference layer) is a natural engagement point — xdp2@lists.linux.dev.

Reading caveats: the essay series doubles as the requirements narrative for an associated product line, so weigh its prescriptions accordingly; the CPU-in-the-datapath performance claims are projections, not shipped silicon; and the scope is host/NIC/DPU-centric — it never engages switch-ASIC constraints (PHV/stage budgets), so it complements rather than contradicts the earlier finding that portability pressure lives on the DPU/software side.

### Key sources (addendum)

- "SmackDown" trilogy, "If You Only Knew the Power of the Compiler!", "Design insights for programmable, high performance datapaths" (Medium, Wayback copies; Jan–Apr 2025)
- "The Fundamental Theorem of Offloads" (Dec 2024); "CPU-in-the-datapath"; "Domain Specific Accelerators: The Good, the Bad, and the Ugly" (Apr 2025); horizontal/vertical parallelism + threading-model series (Nov 2024)
- netdev 0x16 "High Performance Programmable Parsers" (CPL IR, 2022); netdev 0x15 flow-dissector/PANDA talk (2021); netdev 0x18 DSA-offload talks (2024)
- kParser RFC: lore.kernel.org/netdev/20221026075054.119069-2-pratyush@sipanda.io/T/; P4TC threads + LWN 953597, 963387, 977310
- github.com/panda-net/panda (dormant); github.com/xdp2-dev/xdp2 (active)

## Refuted / gaps

- Three hXDP-derived claims (eBPF-on-FPGA portability) refuted 0-3 — assert nothing about FPGA-NIC eBPF execution from this pass.
- Unverified coverage: current health of Broadcom NPL, NVIDIA Spectrum/DOCA programmability, Pensando pipelines, μP4, Taurus.

## Key sources

- Intel PCN 827577-00 (Tofino EOL): intel.com/content/www/us/en/content-details/827577/
- p4c architecture: github.com/p4lang/p4c
- Lyra: ennanzhai.github.io/pub/lyra-sigcomm20.pdf
- Gallium: homes.cs.washington.edu/~arvind/papers/gallium.pdf
- Chipmunk: people.cs.rutgers.edu/~sn624/552-F19/papers/chipmunk.pdf + SIGCOMM 2020 (10.1145/3387514.3405852)
- Netronome eBPF offload: netdevconf.info//1.2/papers/eBPF_HW_OFFLOAD.pdf; FOSDEM 2018 XDP-offload slides
- P4-SpecTec: 2025.ecoop.org (PLSS 2025)
- P4HIR/P4MLIR: p4lang/p4mlir-incubator; archived 2024 P4 Workshop deck (web.archive.org/web/20250115022048/…)
- Systems Approach post-Tofino retrospectives: systemsapproach.substack.com
