# P4moda design

Status: draft for review. Distilled from the 2026-06-12 brainstorming session.

## Vision

Today a P4 program is monolithic: it contains the user's P4 logic but also implicitly assumes an architecture (v1model, PSA, PNA) supplied by a vendor and hardcoded into compilers. P4moda inverts this. Pure P4 logic lives in standalone, individually compilable **P4 blocks** (parser, control, deparser). Architecture logic — the thing that wires blocks together, implements the traffic manager, and supplies externs — becomes ordinary software, written in any language, against an open interface specification.

A more precise framing discovered during design: fully "architectureless" P4 is impossible, because blocks must agree on some signature convention, and that convention is itself a minimal architecture. P4moda is therefore a **meta-architecture**: the smallest fixed point (block kinds, parameter roles, an opaque architecture-metadata slot) on top of which real architectures become ordinary, swappable software.

## Goals

In priority order:

1. **Composable software dataplanes** — build and run dataplanes by wiring independently compiled blocks together on CPUs.
2. **Architecture experimentation** — make it cheap to define new architectures explicitly out of blocks, instead of being stuck with v1model/PSA/PNA.
3. **Testing and verification** — compile and test each block in isolation against a well-defined interface.

Explicitly deferred: cross-vendor hardware portability (ASIC/FPGA/NIC targets). The design should not preclude it, but nothing is optimized for it now.

## Core decisions

### 1. Protobuf as schema, not wire format

Protobuf is the interface definition language, nothing more. The `.proto` schemas are the authoritative, **normative** spec of what data crosses a block boundary. How the data physically moves is a **binding** (non-normative): proto serialization over IPC for testing and tracing, generated in-memory structs and function calls for fast paths. This keeps the spec honest without forcing serialization cost on every packet, and it means the future ABI/FFI story is just another binding of the same schema rather than a second spec.

### 2. Block artifact: WASM first, native later

Compiling a block produces a WebAssembly module plus a descriptor (see below).

- **WASM reference binding (now):** any host language with a WASM runtime loads and calls blocks. Sandboxed by construction, one artifact runs anywhere, and WASM's module boundary serves as ABI v0 — deferring hand-rolled ABI design. Likely compiler path: p4c midend → C → clang → WASM.
- **Native shared-library binding (later):** `.so` with a C ABI generated from the same schemas, designed with lessons from the WASM round. This is the documented fast path; it is not part of v1.
- **Rejected:** a portable IR + interpreter. Its prototyping speed is tempting, but the IR would become a second normative spec to maintain (the BMv2 JSON cautionary tale), and it is the weakest option for language-agnosticism.

### 3. Boundary data model

Stress-testing the interfaces by writing v1model's glue logic revealed that boundary data splits three ways:

| Data | Typing | Who defines it |
|---|---|---|
| Packet bytes | opaque `bytes` | p4moda spec |
| Program state (headers H, user metadata M) | canonical envelope; opaque to architecture, introspectable via descriptor | p4moda spec (encoding) + block compiler (descriptor) |
| Architecture metadata (e.g. v1model's `standard_metadata_t`) | typed proto message | each architecture author |

Key findings from the v1model exercise:

- The architecture glue never inspects headers; it only shuttles program state between blocks and reads/writes architecture metadata (the traffic manager needs `egress_spec`, `mcast_grp`, drop decisions — nothing else).
- Program state still needs a canonical encoding, because separately compiled blocks (parser and ingress) must agree on how H is laid out when it crosses the boundary. The envelope is that encoding; descriptors let composition-time checks verify the parser's H matches the ingress's H.
- Per-program generated proto schemas were rejected: v1model's logic is generic over H (literally its P4 package signature), so generated types would force regenerating the glue per program while buying nothing the glue ever uses.
- Raw-bytes-only boundaries were rejected: reading `egress_spec` out of an opaque buffer puts the metadata layout contract in out-of-band documentation — exactly the implicit-architecture problem P4moda exists to kill.

### 4. Architecture metadata: P4 is the source of truth

The metadata struct is authored once, in P4 (the file blocks must include anyway):

```p4
// v1model_meta.p4 — the one authored artifact
struct standard_metadata_t {
    bit<9>  ingress_port;
    bit<9>  egress_spec;
    bit<9>  egress_port;
    bit<16> mcast_grp;
    // ...
}
```

A p4moda tool generates the proto from it, annotating exact widths with custom field options (`uint32 ingress_port = 1 [(p4moda.bitwidth) = 9];`). Generation in this direction is forced by a real asymmetry: P4 can natively say `bit<9>`; protobuf cannot. Precedent: P4Info is generated from P4 source the same way.

Guard against version skew (block compiled against metadata v1.0 composed with glue using v1.1): the compiler embeds a digest of the metadata struct layout in each block's descriptor; the generated proto carries the same digest; composition-time checking compares them. Generation prevents drift at authoring time; the digest catches it at composition time.

### 5. Parameter roles via spec-owned block signatures

How does the compiler know a parameter is architecture metadata rather than user metadata? Not by name heuristics (what p4c effectively does today) and not by annotations alone. P4moda ships a core include — analogous to `core.p4` — defining generic block signatures:

```p4
// p4moda.p4 — owned by the spec
parser  P4modaParser<H, M, A>(packet_in pkt, out H hdr,
                              inout M meta, inout A arch_meta);
control P4modaControl<H, M, A>(inout H hdr, inout M meta,
                               inout A arch_meta);
control P4modaDeparser<H>(packet_out pkt, in H hdr);
```

Parameter roles are fixed positionally by these spec-owned type declarations — the type system tells the compiler, no inference needed. Whatever type a block binds to `A` is its architecture metadata, and that type's defining file feeds the proto generation above. Architectures with multiple metadata structs (PSA's separate input/output metadata) wrap them in a single struct bound to `A`.

### 6. Externs are the import half of a block's interface

A block's full interface is symmetric:

```
block = { exports: run(envelope) -> envelope,
          imports: [extern functions it calls] }
```

This is literally WASM's module model, so "externs become FFI" is the day-one implementation, not a future feature. In the later native binding, the same imports become a vtable of function pointers — the same spec.

- **Declaration:** externs are declared (not defined) in P4 interface files, the same pattern as architecture metadata. Extern sets are standalone, reusable interface packages (a core set mirroring PSA's register/counter/meter/hash; vendor sets possible later). A block depends on extern packages, not on an architecture.
- **Compilation:** generic externs (`register<bit<32>>(1024) flow_state;`) are monomorphized per instance; the descriptor records each instance with resolved signatures and constructor arguments. Extern call signatures go through the same P4-to-proto generation as metadata.
- **Composition:** loading a block resolves imports like a linker resolves symbols. Unresolved import = composition-time error. Host implementations are plain objects in the architecture's language; the p4moda host library auto-generates marshalling (small values as WASM integers, wide values and out-params via linear memory) from the descriptor.
- **State lives host-side:** register contents and counter values belong to the architecture process, so the control plane and tests can read or inject extern state without reaching inside blocks.
- **Two kinds in practice** (from the v1model exercise): pure state/compute externs (register, counter, meter, hash, checksum, random) are self-contained reusable library classes; architecture-coupled externs (`clone3`, `resubmit`, `recirculate`, `digest`) are closures over the glue's per-packet context — `clone3()` appends a request that the traffic-manager loop consumes after the block returns.
- **Performance escape hatch (later):** the spec can allow an extern implementation to be supplied as a linkable module rather than a host function, so hot externs (hash) inline into the block. Same import model; not v1.

### 7. Tables are not externs

Match-action tables stay inside the block — the compiler implements lookup. What crosses the boundary is their population interface (entry insertion), which the descriptor exposes P4Info-style. Separate plane, existing precedent, no new design needed.

## Artifacts and spec components

A compiled block ships as:

- `block.wasm` — the executable module (exports `run`, declares extern imports).
- `block.descriptor` — machine-readable: program-state layout (for envelope compatibility checks), architecture-metadata digest, extern imports with resolved signatures, table population interface.

The normative p4moda spec consists of:

1. The envelope schema (packet bytes + program state encoding + `arch_meta` slot).
2. The descriptor format.
3. The P4-to-proto generation rules (including the bitwidth field options).
4. `p4moda.p4` (block signatures) and the core extern interface package.

Bindings (WASM calling convention, future C ABI, proto-over-IPC test transport) are non-normative companions.

## Validation example: v1model as ordinary software

The proof-of-concept milestone: reimplement v1model as ~100 lines of Python glue composing six blocks (parser, verify-checksum, ingress, egress, compute-checksum, deparser), with the traffic manager (drop/unicast/multicast, then clone/recirculate) as plain readable Python and externs as plain Python objects. Behavior that is buried in BMv2's C++ internals today becomes software you can read, modify, and unit-test. Python-grade throughput is acceptable: this binding targets testing and experimentation, by design.

## Prior art

- **µP4 (SIGCOMM 2020)** — closest relative: architecture-independent P4 modules composed by a linker. Source-level only; modules are not independently compilable artifacts with a wire-level interface. P4moda goes further on exactly that axis.
- **P4-16 spec** — already separates language from architecture (blocks are typed; an architecture is a package signature plus intrinsic metadata). P4moda finishes what P4-16 started: making blocks mean something outside a vendor package.
- **Lyra / Flightplan / Gallium** — split one program across heterogeneous devices; Flightplan's runtime handoff protocol is an ad-hoc version of the block interface.
- **P4 DPDK SWX pipeline, p4-tc** — software targets consuming "just the logic"; proof that architectureless execution is practical.
- **PISCES, NIKSS (PSA-eBPF)** — P4 onto existing software dataplanes; their architecture-mismatch pain is motivation material.
- **P4Runtime / TDI** — protobuf-specified interfaces for the control plane; P4moda fills the analogous gap for the dataplane.
- **Click modular router** — spiritual ancestor: composable elements with typed ports; lessons on granularity and scheduling apply.

## Open questions and future work

- Clone/recirculate/resubmit semantics in the envelope: requests are extern-mediated (decided), but the spec language for "packet re-enters the pipeline" needs precise wording.
- Program-state envelope encoding details: exact canonical layout, varbit handling, header stacks.
- Control-plane story: how the descriptor's table interface relates to P4Runtime proper (reuse vs. profile vs. subset).
- Native C ABI binding (after WASM lessons).
- Hardware targets and cross-vendor portability (explicitly out of scope for now).
- Compiler implementation strategy: how much of p4c is reusable as a library vs. a fork vs. a new midend consumer.

## Suggested roadmap

1. **Spec sketch** — envelope + descriptor + `p4moda.p4` + core externs, written as proto files and prose.
2. **Hello parser** — compile one parser block to WASM by hand (or via a minimal p4c-to-C path); load it from Python; round-trip a packet.
3. **v1model demo** — six blocks + Python glue + in-memory externs; run a reference P4 program (e.g. basic L3 forwarding) and compare behavior against BMv2.
4. **Second architecture** — something deliberately non-v1model (e.g. a two-stage middlebox pipeline) reusing the same parser block, to prove the experimentation story.
5. **Spec v0.1** — revise everything the prototype falsified; publish.
