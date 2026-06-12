# Literature scan: novelty check and related-work foundation

Date: 2026-06-12. Method: deep-research workflow — 5 search angles, 20 primary sources, 99 extracted claims, 25 adversarially verified (3-vote panels) — plus a second-pass verification (same day) that re-ran the claims whose original verifier panels stalled on fetch failures (the giant P4-16 spec HTML, paywalled IEEE/ACM pages). The second pass used downloaded copies and open-access mirrors (USENIX, author preprints, GitHub raw); all previously-unverified claims are now resolved. Everything in the "Confirmed" sections is backed by verbatim quotes from primary sources.

## Bottom line

No prior work was found that (a) makes architectureless P4 blocks separately compilable artifacts, (b) compiles P4 to WebAssembly, or (c) defines a language-neutral, schema-specified per-packet dataplane interface between P4 program components. All five research questions now have confirmed coverage. One sentence worth keeping for the paper: proxy-wasm is the WASM-modules-in-dataplane analogue but with an ABI interface; Envoy ext_proc is the protobuf-schema-interface analogue but out-of-process over gRPC; both are L4/L7 — no prior system combines schema-defined interfaces with sandboxed modules at packet granularity.

## Confirmed findings (3-0 unanimous, primary sources)

### P4Muse (IEEE Access, July 2025) — nearest recent modularity work
Achieves modularity entirely inside a single p4c compilation: custom IR passes merge modules into one P4 program. Modules are never separately compiled artifacts; there is no runtime or dataplane interface between them ("P4Muse introduces no runtime overhead" because modules dissolve). Full-text searches for WASM, protobuf, separate compilation, artifact, ABI: zero hits. Cite as the nearest recent work to distinguish against.
Sources: https://ieeexplore.ieee.org/document/11080440/ , https://publications.polymtl.ca/66568/1/2025_Rahmati_P4Muse_Enabling_Modular_P4_Programming.pdf

### P4 Weaver (SOSR 2021) — source-level weaving, architectures fixed
Aspect-oriented source-to-source weaving of vendor base code + customer extensions into a single P4 file. Explicitly treats architectures and externs as fixed vendor-supplied elements ("P4 Weaver does not allow users to add new match kind or extern declarations. These declarations depend on the architecture."). Not prior art for separately compiled artifacts or architectures-as-software. Note: its remote-compilation IDE keeps vendor code hidden — a weak form of separate ownership worth acknowledging.
Source: https://conferences.sigcomm.org/sosr/2021/papers/s22.pdf

### P4 Weaver's "linker infeasible" argument — the gift quote
P4 Weaver explicitly argued a linker model with separately compiled P4 modules is infeasible: "the notion of a linker and a run-time stack for P4 is not feasible." But its own reasoning grounds this entirely in hardware targets ("can not be mapped onto ASICs where the logic connections... are hard-wired"), conceding that linking works on general-purpose ISAs. This is the strongest direct support in the literature for P4moda's framing: separate compilation becomes viable once the target is software. Cite it, hedging that their conclusion was target-specific ("ASICs or FPGAs"), not fundamental to P4.
Source: https://conferences.sigcomm.org/sosr/2021/papers/s22.pdf (Section 2)

### Wasm-bpf (arXiv 2408.04856, Aug 2024) — closest WASM work, still not dataplane-in-WASM
Packages eBPF programs as distributable WASM modules (WASI + container toolchains) — precedent for "dataplane-adjacent program as a separately distributable WASM artifact." But the packet logic still executes in the Linux kernel; the WASM module carries only user-space control logic and the loader. NOT prior art for executing dataplane block logic inside a WASM runtime. No work compiling P4 to WASM was found. Adjacent thread: bpftime runs eBPF in a userspace VM (non-WASM).
Sources: https://arxiv.org/abs/2408.04856 , https://github.com/eunomia-bpf/wasm-bpf

### PNA — P4.org's approach remains architecture-centric
PNA is an official, still-unfinalized Architecture WG spec (latest release v0.7, Dec 2022; no v1.0 through 2026 — verified current as of June 2026). It is itself a fixed architecture package (`package PNA_NIC<MH, MM>(...)`, three blocks: main parser/control/deparser); inter-block interfaces live entirely inside the P4 type system via generic type parameters and intrinsic metadata structs. Repo-wide grep: zero occurrences of protobuf, WASM, or separately compiled artifacts.
Sources: https://github.com/p4lang/pna , https://p4.org/specs/

### TDI — control plane only; cite to preempt confusion
IPDK's Table Driven Interface is a runtime target-abstraction layer for control-plane table programming (entryAdd/Del/Mod/Get, tdi.json analogous to p4info). No mention anywhere of per-packet interfaces, dataplane ABIs, or composing separately compiled blocks. Does not occupy P4moda's design space.
Sources: https://ipdk.io/documentation/Recipes/InfrastructureNetworking/ , https://github.com/p4lang/tdi

### P4TC — single closest prior work on the compilation axis
Compiles P4 to eBPF for the Linux datapath, and notably generates the parser and main control block as separate eBPF programs. However: target is eBPF (kernel-verifier model), not WASM; inter-stage communication is an ad-hoc {data, metadata} tuple with no standardized or schema-defined interface; match-action table state lives kernel-side via kfuncs (hybrid). Development stalled mid-2024 (LWN: "P4TC hits a brick wall"). Closest prior work for the compilation story; leaves the schema-defined block-interface axis unaddressed. Related: p4c's older eBPF/PSA-eBPF backend predates P4TC and strengthens the P4-to-sandboxed-bytecode lineage.
Sources: https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md , https://dl.acm.org/doi/abs/10.1145/3630047.3630193 , https://lwn.net/Articles/977310/

## Confirmed findings — second-pass verification

### P4-16 spec (v1.2.5, Oct 2024) — the authoritative baseline
All three baseline claims confirmed against the downloaded spec text:

- **Architecture definition:** Section 2: "Architecture: A set of P4-programmable components and the data plane interfaces between them." Section 4: "In general, P4 programs are not expected to be portable across different architectures... However, P4 programs written for a given architecture should be portable across all targets that faithfully implement the corresponding model." The architecture-coupling problem P4moda targets is inherent to the standardized language model.
- **Typed P4 interfaces, no neutral schema:** Section 4.2 specifies block interfaces as P4 type declarations with directed parameters ("the architecture includes a type declaration that specifies the interfaces between the block and the other components"). Grep counts: "protobuf" = 0, "WebAssembly"/"WASM" = 0 in spec prose. The concept of a typed per-block dataplane interface already exists in the spec — cite it as the baseline P4moda generalizes (this is exactly the `p4moda.p4` signatures decision).
- **No separate compilation:** the only cross-file composition mechanism is the C preprocessor (Section 6.2); "separate compilation", "linker", "object file" = 0 occurrences; all instantiation is compile-time. The spec's compilation output is "a data plane configuration... and an API for managing state" — no binary block artifact concept exists.

Source: https://p4.org/wp-content/uploads/sites/53/2024/10/P4-16-spec-v1.2.5.html

### P4.org WG charters and IPDK — portability via fixed architectures, confirmed
- **Architecture WG charter:** "The main goal of the P4 Architecture working group is to provide a specification for the Portable Switch Architecture (PSA)... a common platform that vendors can agree to support as a target." Portability = fixed portable architectures + portable externs, not architecture-independence. **Hedge for the paper:** the charter also promises "a blue-print for defining new architectures -- the language specification to define P4-programmable blocks and control flows, and the interfaces between them" and says PSA should "allow for composing functionality developed by different parties" — a careful reviewer could cite this, so don't overstate "P4.org never discusses composition"; the blueprint is per-architecture and vendor-defined, with no artifact or schema story.
- **API WG:** P4Runtime is "a control plane protocol for controlling the data plane elements of a device or program defined by a P4 program." Full WG enumeration (Language Design, API, Architecture, Education): none covers per-packet dataplane interfaces between components.
- **IPDK:** its Infrastructure Networking recipe explicitly envisions "The dataplane may consist of multiple P4 programs working in conjunction" — community precedent for multi-program dataplanes — while its docs define only control-plane interfaces (P4Runtime, TDI, OpenConfig, SAI); the only compilation artifacts mentioned are p4info control-plane schemas. Useful motivation cite: the multi-program vision exists with no inter-program dataplane interface to support it.

Sources: https://raw.githubusercontent.com/p4lang/p4-spec/main/p4-16/psa/charter/P4_Arch_Charter.adoc , https://raw.githubusercontent.com/p4lang/p4runtime/main/README.md , https://ipdk.io/documentation/Recipes/InfrastructureNetworking/ , https://archive.p4.org/working-groups/

### NetBricks (OSDI 2016) — closest software-dataplane composition analogue
Both claims confirmed from the USENIX PDF:

- Builds NFs by composing a small set of packet-processing operators ("we take inspiration from modern data analytics frameworks (e.g., Spark and Dryad) and build a small set of customizable network processing elements"); an NF is "a directed graph with these abstractions as nodes."
- Replaces hardware/VM isolation with language-level safety: "we embrace type checking and safe runtimes to provide isolation in software... the same memory isolation as containers and VMs, without incurring the same performance penalties." Rust static checking + safe runtime; unique types statically verified. Note: its term ZCSI = "Zero-Copy **Software** Isolation" (not "zero-cost" — mis-expanded in the first-pass claim).
- Relevance: the closest prior art for safe software isolation of composed dataplane stages — cite when motivating WASM sandboxing. Distinction: single language/runtime (Rust, one process), no separately compiled artifacts, no language-neutral schema, not P4.

Source: https://www.usenix.org/system/files/conference/osdi16/osdi16-panda.pdf

### Polycube (IEEE TNSM 2021) — wire-model composition, confirmed
- Enables "arbitrary and complex network function chains" of in-kernel eBPF "Cubes," each with in-kernel dataplane + user-space control plane; composability is an explicit design goal (G2).
- The inter-cube interface is deliberately wire-like: chaining "mimics the well-known model in use in the physical world that deploys functions (e.g., bridges, routers) connected by wires"; cubes connect via virtual ports, packets hand off via eBPF tail calls plus untyped per-CPU-map metadata. "protobuf" = 0 occurrences; YANG appears only for the control-plane REST API.
- Relevance: confirms the pattern that software-dataplane composition frameworks use untyped wire/port models — supports the novelty of a schema-defined per-packet boundary.

Source: https://sebymiano.github.io/publication/2021-polycube/2021-polycube.pdf (author preprint)

### Protobuf/IDL per-packet interfaces (RQ5) — clear negative at L2/L3, two L7 analogues
Seven targeted searches found no system where an IDL schema (protobuf, FlatBuffers, Cap'n Proto) defines the per-packet interface between dataplane modules. Nearest neighbors are all non-IDL: NSH/SFC service-chaining metadata (fixed TLV headers), DPDK Packet Framework and eBPF/XDP (C-struct ABIs). Protobuf appears in networking only at the control plane (P4Runtime, gNMI) or general RPC. Two L7 analogues verified for the related-work section:

- **Envoy ext_proc** — confirmed protobuf-schema-defined per-traffic-unit processing: a bidirectional gRPC stream of `ProcessingRequest`/`ProcessingResponse` messages per HTTP request/response part. Schema-defined interface, but out-of-process gRPC and L7 units.
- **proxy-wasm** — confirmed "specification of the low-level Application Binary Interface (ABI) and conventions to use between L4/L7 proxies and their extensions delivered as WebAssembly modules." Sandboxed WASM modules in a dataplane, but a host-function ABI (not a schema) over L4/L7 streams.
- The quotable gap: proxy-wasm has the WASM-module half, ext_proc has the schema-interface half; neither is per-packet, and no system combines them at L2/L3 packet granularity.

Sources: https://www.envoyproxy.io/docs/envoy/latest/api-v3/service/ext_proc/v3/external_processor.proto , https://github.com/proxy-wasm/spec

### P4Muse survey list — re-checked against the actual paper
All ten names appear (daPIPE [9], P4 Weaver [10], P4-Ansible [11], µP4 [12], Lyra [13], ClickP4 [18], P4Visor [27][29], PRIME [31][32], P4All [33], HyperVDP [25]), bucketed into modular programming / composition-virtualization / compiler design / incremental programming. Headline: "Previous solutions... indirectly introduced modularity and lacked essential features such as backward compatibility, simple syntax, or compatibility with important classes of use cases."

**Important scoping caveat found:** P4Muse does NOT claim "none produce separately compiled artifacts" (zero hits for that phrasing), and its survey includes **P4Bricks [26]**, described as "creating a single data plane configuration file by merging multiple compiled data plane files." P4Bricks was read in full — see the dedicated section below; P4Muse's characterization is accurate, and P4Bricks does not occupy P4moda's space.

Source: https://publications.polymtl.ca/66568/1/2025_Rahmati_P4Muse_Enabling_Modular_P4_Programming.pdf

### P4Bricks (INRIA tech report, 2017/2018) — read in full; the closest "post-compile composition" prior art
Full title: "P4Bricks: Enabling multiprocessing using Linker-based network data plane architecture" (Soni, Turletti, Dabbous; HAL hal-01632431v2, Feb 2018). **Never peer-review published** — zero DBLP records; the authors describe it as "the initial design of our system with an ongoing implementation"; material also appears in Soni's 2018 PhD thesis.

What it is: a static **Linker** takes compiler *output* (target configs, e.g. BMv2 JSON) of independently written P4 programs plus operator-specified composition operators (parallel/sequential), and merges everything into ONE pipeline — refactoring, vertically decomposing, and rescheduling match-action tables onto physical stages. A **Runtime** control-plane proxy then translates each program's table updates into the merged pipeline.

Why it does not occupy P4moda's space:
- **No inter-program interface exists.** Programs dissolve into a single merged pipeline; "sharing" is implicit structural equivalence of header formats. The only per-packet runtime mechanism is an added intrinsic metadata bitfield ("indicator") tagging which program each header instance is valid for — an isolation tag, not an interface.
- **No independently executable artifacts.** Inputs are mergeable representations; after linking, individual programs cease to exist as executable units.
- **Architecture stays fixed** — in fact P4Bricks defines its own bespoke architecture (e.g. a P4Bricks-specific `verify` extern signature) rather than making architectures replaceable.
- Zero hits for protobuf, WASM, schema, ABI.

Two useful citations fall out of it:
1. **It corroborates P4 Weaver's infeasibility argument rather than contradicting it:** P4Bricks attempted a post-compile linker against the abstract RMT stage model, left the hard part unfinished (the stage-allocation algorithm: "we omit the description of SelectionOperations function"), was only partially implemented on BMv2, and was never completed or published. An attempted-and-abandoned hardware-model linker is evidence *for* the claim that linking becomes tractable only on software targets.
2. **Its stated limitations are P4moda motivation material:** parser merging "fails... and stops linking" when parse states have side effects; deparser merging is semantically unsound in general ("it is not possible to identify the correct merged emit order of header instances"), restricting composition to programs with the same protocol stack and no encapsulation; and the conclusion concedes the language design itself is an obstacle ("we hope that our work provide a good motivation to rethink design of deparser"). These are the costs of composing by *merging* — P4moda's explicit runtime boundary avoids the entire class of problems (no parser/deparser merging happens at all; blocks keep their own).

Sources: https://inria.hal.science/hal-01632431v2 , https://inria.hal.science/hal-01632431/file/p4bricks-inria-tech.pdf

## Remaining hedges

1. **Search-based negatives are not proofs.** The RQ5 negative (no IDL-schema per-packet interfaces) rests on seven searches; phrase the paper claim as "to our knowledge."
2. **Architecture WG charter's "blueprint" language** — hedge against it when claiming P4.org doesn't address composition (see above).

(Resolved: the earlier P4Bricks hedge — the paper has now been read in full; see its dedicated section.)

## Time-sensitivity notes

- PNA unfinalized status verified June 2026; could change.
- P4TC stalled 2024; could resume.
- P4Muse appeared July 2025 — watch for late-2025/2026 modular-P4 follow-ups not yet indexed.
