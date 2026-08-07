# OPPX design

Status: v0 draft distilled from the 2026-07-18 brainstorming session. A starting point — expect further iterations before any implementation.

## Vision

OPPX is an ONNX-inspired portable IR for programmable packet processing: a computational-graph representation whose purpose is to specify the semantics of single-packet processing precisely and portably. P4 tried to unify packet processing at the language level and ended up architecture-fragmented; OPPX bets that unification is realistic one level down, at a portable IR with multiple language frontends.

Primary role: a **semantic reference substrate** — executable golden semantics, differential testing of real dataplanes, a common representation for tools. Eventual ambition: a **de facto interchange standard**. The sequencing is load-bearing: the standard, if it ever happens, emerges from indispensable tooling (the LLVM IR path), not from publication (the OpenFlow path).

## Theory of adoption (and its known challenges)

- The ONNX M×N economics mostly don't exist here: P4 is nearly the only frontend with a corpus, and HW vendors have demonstrated (by starving P4 portability, keeping NPL closed) that they resist portable representations. A standard bet on vendor goodwill inherits P4's incentive problem unchanged.
- The realistic wedge is **user-side pull**: DPU/SmartNIC proliferation recreates M×N pressure on the buy side (operators hate per-SDK rewrites), and eBPF's growth supplies a real software target. Imagine the adoption story as a hyperscaler using OPPX for differential testing across dataplanes they already run — not a vendor announcing native support.
- OpenFlow is the domain's own cautionary tale: optional features made "supports OpenFlow" meaningless. Since packet processing has no line-rate fallback target (ONNX's CPU-fallback escape hatch), subset support must be first-class and machine-checkable: target capability descriptions + ahead-of-time admission, functions with reference decompositions so "supports op X" has one meaning. OPPX must be better than ONNX here, not equal.
- Bit-exactness removes ONNX's other escape hatch (numerical tolerance). The resolution is the memory-model move: a precise core with explicitly specified nondeterminism points. This is the project's research core.
- The "portable PP representation" slot is contested by p4c/P4-MLIR. Positioning: OPPX is language-neutral and semantics-first where P4-MLIR is P4's compiler internals; the long game may well standardize through p4.org once proven, and that's fine.

## Scope

In scope: the processing of a single packet — parse, transform, match-action, deparse — including its reads and writes of named persistent state.

Out of scope:

- Queueing, scheduling, traffic management, cross-packet ordering.
- Control-plane protocols. Entry *semantics* (match kinds, priority, defaults) are in; entry *programming* (P4Runtime/TDI/bpf syscalls) is out. Precedent on both sides: ONNX says nothing about how weights are trained or updated (its one attempt, the training IR, withered); P4 defines table semantics while P4Runtime is a separate spec.
- Architectures. In P4 terms, OPPX focuses on the architecture-less logic fully expressible in the IR. An architecture (v1model, PSA, PNA, or anything else) is not IR structure: it is an **interface package** — block signatures + extern declarations + metadata conventions + capability constraints — plus glue software outside the IR. Block composition (wiring) is the architecture's business.

## Semantic model

An OPPX graph denotes a pure transition function:

    (state, packet, nondet-inputs) → (state', packet'?, metadata, effects)

Single-packet scope = one step of a transition system. Cross-packet interleaving of steps, control-plane writes, and aging are *other* transitions on the same state, defined outside the IR.

- **Values**: bit-precise (`bit<N>`), structured headers with validity, an explicit payload object. Control flow via subgraph ops (ONNX-style If; bounded Loop for parsing).
- **State**: graphs declare named state objects; ops read/write them by reference. The spec-level state is mechanically derived: `state` = product of all declared objects. Semantics are defined by functionalization into the threaded form (the ISA-spec/Sail style); the in-graph read/write ops are notation for it. Per-object access order within a packet is structural (ordering tokens), never implicit — the TF ref-variables lesson.
- **Write authority** is a derived per-object property: objects the graph writes (registers) vs. objects only external transitions write (parameters — table/map entries, the ONNX-initializer analog). One notion of state, not two. The externally-written objects and their types yield an auto-derived control-plane-facing schema (the P4Info analog).
- **Effects**: write-only interactions are reified as an ordered stream of effect records in the output — counter updates, digests, clone/mirror/recirculate requests. The system outside interprets them. Packet replication therefore never happens inside the graph: 1 in, ≤1 out, plus effects.
- **Nondeterministic inputs**: timestamp, random — declared inputs, not hidden state (the JAX PRNG move).
- **Nondeterminism points** (cross-packet state consistency, concurrent pipelines) are explicitly specified, memory-model style. Baseline: per-packet-atomic state access; an `@atomic`-like scoping construct reserved for stronger guarantees.

Consequences that fall out for free: purity is machine-checkable (no state, no nondet ⇒ pure — usable in admission predicates); composed blocks have additive state (disjoint union; shared state between blocks deliberately inexpressible in v0); the differential-testing observation interface is derived (output packet, metadata, effects, state record per step).

## What is not an extern

P4's extern zoo mostly dissolves:

- **Checksum/hash/CRC**: pure computations — **named functions with reference decompositions** (ONNX's function mechanism). Named so a target with a CRC engine can recognize and map the unit.
- **Counter**: write-only from the dataplane (which is why HW implements it off-pipeline) — an effect record, not state the graph reads.
- **Meter**: *not* deferrable outside (the color feeds back into this packet's logic) — but decomposes into register state + timestamp input + a pure `meter_update` function.
- Residue: truly black-box architecture externs remain as the escape hatch (signature-only, in architecture domains), now rarely needed. Black-box externs are where ONNX portability goes to die (custom ops), so the design minimizes them structurally.

## State: one primitive

`oppx.core` v0 ships exactly one state type: the indexed array (register). Sufficiency argument: P4 already ran this experiment — register is its sole dataplane-mutable primitive, and the stateful-dataplane literature (sketches, Bloom filters, cuckoo tables) is built on arrays + pure logic.

Known extension pressure, deferred by design: **dynamic maps with dataplane insertion** (eBPF map_update, HW learn-on-miss). The threading model covers them unchanged, but they are a new state *type* whose in-graph failure semantics (fail-on-full, eviction order) must be pinned — observable behavior, since programs branch on insert errors. Deferred until an eBPF-class frontend exists to demand them. Note the P4-class answer already works: learning = digest effect → external transition inserting the entry, which is how real switches do it.

## IR structure

- **Domains + opsets**, ONNX-style, from day one: `oppx.core` (ops, one state type, effects, subgraphs), the standard function library, architecture/vendor domains later. Versioned operator sets; strict serialization compatibility.
- **Block signatures**: a graph can declare it implements a named, versioned interface (e.g. a parser role: packet + metadata in, parsed headers + metadata out) — making conformance to a pipeline-stage role checkable. ONNX has no analog (its models are free-form); OPPX needs one because stage composability matters here. Architecture domains own their signatures. `oppx.rmt`, when it exists, specializes *constraints* (capability descriptions like PHV capacity), not types.
- **Interfaces are semantic types; representations are bindings.** A parse result is "typed headers + validity + payload cursor"; PHV vs. zero-copy offsets are two physical encodings chosen per target, invisible to semantics. (The p4moda "schema, not wire format" principle, one level down.) Where a representation difference is observable — PHV capacity — it surfaces in capability/admission, not in types.
- **Functions with reference decompositions** double as the fusion mechanism: targets implement the named op natively or take the decomposition.
- **Target capability descriptions + admission**: mechanism reserved in the format from day one; detailed design deferred until a HW-shaped consumer exists.

## Normative artifacts

1. Prose spec (scope, semantic model, core ops, function library, block-signature and domain mechanisms).
2. Stable serialization (protobuf, ONNX-grade compatibility rules; format `ir_version` separate from opsets).
3. **Reference interpreter, day one.** The anti-ONNX-Runtime move: ONNX deferred its reference evaluator ~5 years and ONNX Runtime became the de facto spec — the same failure as BMv2 becoming v1model's spec. Bit-exact packet processing cannot survive that ambiguity.
4. Conformance test suite generated from the reference semantics.

Non-normative: Python graph-builder API, frontends, future MLIR dialects, future formal (Sail/K) semantics, all bindings.

## Roadmap

1. **v0 — spec sketch + builder API + reference interpreter.** Hand-authored example graphs (a parser, an L3 forwarder) via a Python builder (the onnx.helper analog). Shakes out the IR design cheaply before any compiler pressure.
2. **v1 — P4-subset frontend + differential testing.** P4 → OPPX for a subset; run v1model reference programs against BMv2 and compare (packet, metadata, effects, state). v1model expressed as an interface package — the proof the architecture story works. Strongest available evidence of semantic accuracy.
3. **Later, in rough order of pull**: software backend (eBPF/DPDK-class), capability profiles / `oppx.rmt` when a HW-shaped consumer exists, MLIR dialect as a compiler implementation, formal semantics (Sail/K) as the normative spec's mechanization, dynamic-map state type with an eBPF-class frontend.

## Prior art and lessons

- **ONNX**: domains/opsets, initializers-as-inputs, functions-with-decompositions, generated conformance tests — copy. Late reference interpreter, custom-op portability leak, optional-support-by-scoreboard — fix. No fallback-free subset story, no block interfaces — exceed.
- **TF variables**: ref-variables' underspecified read/write ordering was bad enough to force resource variables with program-order semantics. Ordering must be structural.
- **eBPF maps**: domain-adjacent state precedent; adoption success, specification cautionary tale (loose cross-CPU semantics).
- **OpenFlow**: fragmentation via optionality; the reason capability descriptions are first-class here.
- **P4-MLIR / p4c / BMv2 JSON**: nearest living neighbors; position precisely (compiler internals and de facto formats vs. a normative, language-neutral, semantics-first spec). A fresh literature scan (p4moda-style) is owed before publishing anything.
- **p4moda (own prior work)**: rejected "portable IR" when P4 stayed the normative language (a second spec to maintain); OPPX inverts — the IR is the one normative spec, languages are frontends. Its findings recur here: architecture glue never inspects program logic; effects-as-appended-requests; schema-vs-binding; interface signatures owned by the spec.
- **nanuk (own prior work)**: independent project; natural future producer/consumer of OPPX, and its Sail experience feeds the formal-semantics stage.

## Open questions for next iterations

- Parsing representation in a graph IR: bounded Loop + cursor vs. an explicit parse-state-machine construct; varbit and header stacks.
- The concrete core op inventory and the function library's initial contents.
- Effect-stream ordering guarantees and effect record schemas.
- Block-signature mechanism details (how roles, versions, and metadata conventions are declared and checked).
- The nondeterminism-point catalog: what the baseline consistency model must specify for concurrent pipelines.
- Name check: "OPPX" availability and collisions (the nanuk-style sweep) before anything public.
