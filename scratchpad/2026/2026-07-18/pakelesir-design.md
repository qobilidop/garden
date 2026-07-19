# PakelesIR design

Status: v0 note from the 2026-07-18 session (named WEIRT for a few hours, renamed same day). Successor-in-spirit to [oppx-design.md](oppx-design.md) (OPPX deferred as too ambitious); the research grounding is [portable-pp-compiler-stack-research.md](portable-pp-compiler-stack-research.md). Own project, okay to fail, learn from it.

## Vision

PakelesIR (from German *Paketleser*, "packet reader") is a serializable IR for describing wire-format parsers, plus the toolchain that makes one description yield many artifacts that provably agree: datapath parsers, Wireshark dissectors, validators, golden test vectors.

The bet: parsing is the tractable subset of packet processing. A parser is a pure total function `bytes → (typed headers, validity, offsets, accept/reject)` — no state, no effects, no memory model. Parsers sit inside a decidable class (finite automata + bounded arithmetic), so **parser equivalence is provable** (Leapfrog, PLDI 2022) — categorically stronger than the differential testing that is the best possible for full packet processing. And the parser is the most-programmable stage across the whole market: even fixed-function switches and NICs expose it (Intel DDP profiles, NVIDIA flex parser, Pensando).

## The graveyard, and the answer to it

Parser IRs specifically have died repeatedly: NetPDL (2000s), CPL (never published), kParser (NACKed out of the kernel), PANDA. Diagnosis: parsing is easy enough that every project writes its own in a week — per-project pain sits below the adoption threshold for a shared layer. Consequence: PakelesIR must ship artifacts people want unilaterally, adoption or not — a protocol library with golden vectors, a working dissector generator, a conformance oracle — never a spec asking for buy-in. The parsing-being-easy problem is also the opportunity: parsers face untrusted bytes, and the graveyard-era consumers (2005 software stacks) have been replaced by ones with real M×N pain (programmable NIC parsers × protocol churn: SRv6, Geneve options, PSP, Ultra Ethernet).

## Positioning

- **Kaitai Struct** owns "any binary format, many languages." PakelesIR's edge is everything Kaitai lacks: the parse automaton, line-rate/HW targets, equivalence checking, dual error modes. "Any wire format" is an architectural property of PakelesIR's format layer, not its marketing.
- **EverParse** owns "one spec → one formally verified implementation" (shipping in Hyper-V). PakelesIR is "one spec → many implementations that provably agree, plus inspection tooling." Sibling, not competitor: 3D's dependent constraints are the format layer's expressiveness floor, and a PakelesIR→3D bridge is a candidate verified backend. Its gaps (no automaton, reject-only, C-only, no cross-implementation story) are PakelesIR's requirements list.
- **P4** is the dominant technical influence (its parser sublanguage: states, select, header stacks, verify) and the first frontend — never the identity. The kernel's kParser verdict is on record: the eBPF world wants the P4-*independent* intermediate layer.
- **Spicy/Zeek** own stateful, application-layer parsing. Out of scope here.

## Scope

In: header-region parsing of a single packet or message — bytes in, typed extraction out, stop where payload begins. Serialization as the format layer's inverse (near-free; doubles the consumer set: generators, fuzzers, test vectors).

Out: reassembly, cross-packet state, application-layer parsing, match-action, anything after the payload cursor.

Two layers:

- **Format layer** — field layouts, dependent lengths, TLV, header stacks, endianness. Domain-generic *by construction*: it must express non-packet wire formats (NVMe/virtio/DMA descriptors — where the EverParse double-fetch threat model applies, since those buffers are device/guest-shared). If it can't express a virtio descriptor, that's a design bug.
- **Automaton layer** — the parse graph. Networking-specific, P4-shaped.

## IR design

**ONNX-style serializable IR as the one normative artifact. No textual DSL.** Expressions are trees of operator nodes in the IR — no syntax hidden inside strings (Kaitai's YAML smuggles a textual expression language into string fields; that compromise is rejected). The Python builder API is the v0 authoring surface; a YAML-ish human-readable view, if the protocol library ever wants one, is a mechanical 1:1 projection of the IR, not a second language.

Automaton-layer vocabulary — the P4-parser coverage checklist:

- State graph with guarded transitions; select on tuples of fields with masks, ranges, default arm.
- Cycles allowed with explicit depth bounds (MPLS-style self-loops).
- Variable-length extraction with computed sizes; lookahead (non-consuming); advance (computed skip).
- Header stacks with next-index extraction.
- verify-style predicated reject carrying error codes.
- Value sets as parameter inputs (select arms referencing externally programmed sets — the entries-as-inputs move).
- Sub-parser composition with named entry states.
- In-state computation as dataflow feeding named outputs, not statements.

**Ceiling as design principle**: express everything a P4 parser can and deliberately not much more — no general recursion, no unbounded loops. Staying inside the decidable class is what keeps equivalence checking (the crown jewel) and matches what hardware parsers implement. Bounded depth is the property that makes the bet work, not a limitation.

**Two evaluation modes** over one description: **reject** (datapath accept/reject) and **diagnose** (Wireshark-style best-effort parse of malformed input, error-annotated as far as bytes allow).

**Projections**: result shapes are declared — full field tree, flow key, steering decision — all projections of one parse. Validation is the empty projection.

**Annotations**: presentation metadata (display names, enum value labels, doc strings) rides as an annotation layer; never core semantics.

## Toolchain

1. Reference interpreter — normative, day one (the anti-ONNX-Runtime / anti-BMv2 lesson).
2. Wireshark Lua dissector generator.
3. Differential testing with `tshark -T json` as oracle — the world's de facto parsing reference, free golden corpus for thousands of protocols.
4. Later: eBPF backend (the kernel-sanctioned shape), equivalence checker (Leapfrog-style), DDP-class hardware backend when a consumer exists, PakelesIR→3D verified backend.

## Roadmap

1. **v0 — the Wireshark demo loop.** Ethernet→VLAN→IPv4→TCP/UDP described once via the Python builder → reference interpreter + generated Lua dissector, diffed against tshark on real pcaps. Forces format layer, automaton layer, diagnose mode, and annotations to all exist minimally. Python throughout (clarity and iteration speed while the IR churns; Rust port when something needs to be fast).
2. **v1 — protocol library + P4 frontend.** Grow the protocol library with golden vectors (the unilaterally useful artifact); P4-subset frontend and differential testing against BMv2.
3. **Later, by pull**: eBPF backend, equivalence checker, descriptor case study (virtio or NVMe), verified backend via 3D, hardware profile.

Optional pre-v0 spike: write the v0 stack in EverParse 3D to feel the expressiveness envelope's edges firsthand.

## Name

PakelesIR, locked 2026-07-18. "Pakeles" compresses German *Paketleser* ("packet reader"); the `-IR` suffix follows the MLIR/ClangIR/P4HIR convention and does the compiler-infrastructure signaling. Etymological bonus: *lesen* descends from PIE *leg-* "to gather, pick out" (Greek *légein*, Latin *legere*; German *Auslese*) — reading originally meant picking apart a stream, so a parser restores the word's first sense. Pronounced PAH-keh-les; the project is PakelesIR, installables are `pakeles`.

Sweep (2026-07-18): total void — PyPI, npm, crates.io, RubyGems, Homebrew, conda-forge, NuGet, Docker Hub all free; GitHub org *and* user free; zero repos containing the string. Known taxes, accepted: five spoken syllables, spelling-by-ear ambiguity, faint "packet-less" misreading. Names considered and dropped this session: weir (crates squatted 2026-06 by a third party), weirx (clean but interchange-family X overpromises), WEIRT (clunky in the mouth), P4rse (Perforce's 2025 P4 rebrand + p4.org trademark; verbally just "parse"), grein (GRIN/Gren compiler-name neighborhood), fyke/headgate/krino/razbor/kaiseki (runners-up, several fully clean). No name reservations made yet — revisit before anything goes public.

## Open questions

- Automaton encoding: explicit cyclic state graph vs structured bounded loops (both serializable; which analyzes and composes better?).
- Concrete op inventory for expressions and extraction; the format-layer type system's exact surface.
- Projection mechanism: how result shapes are declared and checked.
- Diagnose-mode semantics: how far to parse past an error, and what the error-annotated result looks like, precisely.
- Annotation schema; protocol-library file conventions.
- IR versioning (opset-style? format version vs op version).
- Whether v0's Lua generation shares machinery with future backends or stays deliberately naive.
