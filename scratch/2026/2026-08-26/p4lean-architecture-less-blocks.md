---
author: Claude Fable 5
---

# p4lean: architecture-less P4 blocks with semantics in Lean

Bili's design idea, developed in conversation after the
[[pakeles-formal-semantics-stack]] note settled the Lean 4 route: a
P4-inspired packet-processor language embedded in Lean — P4-familiar
surface, intentionally minimal, formal semantics, exports to P4 — whose
central thesis is that P4's architecture requirement is the flaw to fix.
"p4lean" is a working name, unswept (no registry/GitHub/trademark check
yet); the candidate backronym: **Proving Protocol-independent Packet
Parsers** — still P4, every shifted word honest.

The proposal splits into two separably-adoptable, separately-named
layers: **p4neer** (working name, unswept) is the P4-facing profile
alone — generic blocks, effects-as-metadata, device models outside
P4 — adoptable by people who never touch Lean; p4lean is *a*, not
*the*, semantics layer above it. p4neer earns its name three ways:
*pioneer* (French *pionnier*, from *pion*, foot soldier) originally
meant the military engineer who goes ahead of the army to prepare the
ground before any fortification exists — the engineer who arrives
before the architecture; the `-eer` agent suffix (engineer,
mountaineer) gives "one who works P4 directly" — P4 engineering
without the architect; the leet reading (4 = A) gives *paneer* —
cheese served in blocks: P4, served as blocks; the backronym reads
N-E-E-R as **No Execution Environment Required** — an architecture
*is* an execution environment, and a block's meaning and compilation
require none (execution gets one later, supplied by a device model —
the eBPF shape: programs defined environment-free, environment
supplied at load time), with the four-pillar creed variant "No
architecture, Effects as data, Externs as FFI, Runtime elsewhere";
and *ne'er* is a real English contraction — P4, ne'er an
architecture. Five readings, all pointing at the same thesis.
Accepted tax, in the [[pakelesir-design]] ledger style:
spelling-by-ear is poor (hearers type "paneer" or "pioneer"). The
boring benchmark it must keep beating: `p4blocks`.

Method note: claims below are primary-source-cited from single-agent
research passes plus two direct fetches (µP4 repo, PSA spec), not
panel-verified.

## Feasibility (verified 2026-08-26)

The embedding mechanism is fully precedented by
[lean-mlir](https://github.com/opencompl/lean-mlir) (ITP 2024, active
through July 2026, no-`sorry` CI): bracket-quotation concrete syntax
(`[dialect| …]`) parsed by a custom syntax category, elaborated into a
typed deep-embedded AST with denotational semantics and soundness
proofs. A `[p4| …]` embedding follows it nearly verbatim; the
metaprogramming book's IMP chapter covers the imperative-syntax
mechanics; elaborators position domain errors on the DSL's own syntax
spans, so the eDSL inherits Lean's whole LSP — the thing an external
DSL never gets (p4analyzer, a decade into P4, self-describes as "not
even at Alpha quality"). `bv_decide` (in core since 2024, verified
bitblasting, kernel-checked certificates) covers concrete-width
bitvector goals push-button.

No P4 formalization in Lean exists (GitHub + arXiv sweep; Petr4 is
Coq/OCaml, HOL4P4 is HOL4, P4K is K) — unoccupied territory, moderate
confidence.

Known risks: (1) symbolic bit-widths are outside `bv_decide`'s reach
and width-generalization is open research even for the lean-mlir team
(`Blase/WidthGeneralize`) — mitigated by restricting the language to
concrete widths, which the IR export forces anyway; (2) P4's mix of
C-like structs + state-machine sublanguage has no direct syntax
precedent — needs a spike, not analogy; (3) polished error UX at scale
is original engineering; (4) a `bisim_decide` equivalence tactic is
Leapfrog rebuilt in Lean — research-sized, not weekend-sized.

## Scope

Not parser-alone: parser + match-action, i.e. a packet processor.
P4-expressive but intentionally minimal; P4 programmers should find it
familiar, but every wart refused (architecture zoo, exotic externs,
preprocessor) is a familiarity cost knowingly spent on being better.
The formal story survives match-action because P4 controls are
loop-free by construction — straight-line bitvector actions, bounded
per-packet execution — so per-program reasoning stays solver-friendly.
Two-tier formal offering: decidable equivalence at the parser layer
(the [[pakelesir-design]] crown jewel; the parser fragment elaborates
to the Pakeles IR), solver-backed reasoning above it. Tables are
parameters: a pipeline denotes `TableEntries → Packet → Result`.
Multi-file modularity is free — programs are ordinary Lean
definitions, so Lean's module system and lake replace P4's `#include`,
and the protocol library becomes an importable package carrying golden
vectors and proofs per definition.

## The architecture-less thesis

P4-16 blocks have no semantics outside a vendor architecture; the spec
says so, and every formalization had to fight it — HOL4P4's headline
contribution *included inventing* an architectural semantics, and
Petr4 parameterizes everything over architectures and externs. The
formalizers already discovered block-autonomous semantics is the only
way to make P4 mean anything; p4lean makes that the language design:

- **Blocks are the semantic unit.** Parser: `bytes → headers`.
  Control: `(headers, meta, tables) → (headers, meta)`. Deparser:
  `headers → bytes`. Composition is typed function composition.
- **Effects are data.** Control blocks never perform effects; they
  write metadata fields (drop, egress port, multicast group,
  resubmit/recirculate), and an interpreter outside the block applies
  them. Verified precedent: this is PSA's own deferred-execution
  model — control blocks write `psa_ingress_output_metadata_t`
  (`egress_port`, `multicast_group`, `clone_spec`, `resubmit_spec`)
  and the target-dependent PRE/BQE act on the fields after the block
  completes ([PSA spec](https://p4lang.github.io/p4-spec/docs/PSA.html)).
  p4lean formalizes what PSA specifies in prose: effect precedence
  becomes a small total function with theorems; reentry
  (resubmit/recirculate) requires a declared fuel bound to keep
  semantics total.
- **Externs are FFI**: typed signatures with three tiers — concrete
  Lean model (checksum), uninterpreted function (hash), stateful
  signature (registers, gated). Anything nondeterministic or
  target-dependent (timestamps, RNG) is an FFI call, never intrinsic
  metadata.
- **Free theorem the architecture world can't state**: parser/deparser
  round-trip (`deparse ∘ parse = id` on valid packets, modulo
  normalization) — statable only when both blocks are autonomous
  functions.

Prior art, verified by direct fetch:
[µP4](https://github.com/cornell-netlab/MicroP4) (SIGCOMM, "Composing
Dataplane Programs with µP4") made the same diagnosis — portable,
modular, composable dataplane — but kept a logical architecture (µPA),
had no formal semantics, is dormant, and its own limitation list
(packet-replication gaps, no stateful processing, varlen issues) maps
onto exactly what this design addresses. Lesson: composability alone
did not sustain adoption; the semantics and theorems must carry it.

## Block signatures (minimal, fully generic)

```p4
parser  P4Parser<H, M>(packet_in pkt, out H hdr, inout M meta);
control P4Control<H, M>(inout H hdr, inout M meta);
control P4Deparser<H>(packet_out pkt, in H hdr);
```

Rulings: the parser sees only bytes plus `M` (varlen bookkeeping) —
no port/intrinsic input, preserving parser = pure automaton over
bytes and its decidable equivalence; `M` is zero-initialized on fresh
packets and preserved across reentry (one rule replacing PSA's
resubmit/recirculate type-parameter zoo); the deparser takes `in H`
only — emission is a fold over header validity, keeping `H → bytes`
pure for the round-trip theorem; facts-vs-effects direction discipline
lives in the device model's typing (Lean), not in nominal P4 structs —
no profile-fixed metadata types anywhere, so parsers and deparsers are
universally portable and only the pairing of control + device model
binds an effect vocabulary. Inert single-block wrapper packages exist
solely because p4c requires a `main` to compile a unit; they claim no
semantics.

## The inversion: device models leave P4 entirely

P4 architectures are frameworks — they call your code. p4lean blocks
are libraries — a device model calls them. Device logic (switch, NIC:
queues, ports, replication, the effect interpreter) is not written in
P4 at all; it is host-language code importing compiled blocks as FFI.
Consequences:

- The compiled-block artifact is the serialized IR (Pakeles IR for
  parsers, a match-action sibling above it), carrying its types — the
  IR is the ABI. The Lean reference device model imports blocks by
  denotation (FFI = function application; a switch model is roughly a
  page of Lean); a production device model loads the same IR through
  the toolchain; per-packet cost is avoided by compile-time codegen.
- Precedents: eBPF (kernel = host device model, programs = compiled
  blocks, verdict/redirect fields = effects-as-metadata, at planetary
  scale); EverParse (verified parser blocks imported as C functions
  into Windows kernel logic); and BMv2 itself, whose simple_switch is
  already a C++ device model invoking compiled-P4 blocks around its
  own queueing — v1model exists to make that reality pretend to be a
  P4-level contract.
- Accepted costs: "a P4 program" stops existing (blocks + a device
  model; device models are few and shared, like kernels); cross-block
  type consistency moves to the ABI/loading semantics (free in Lean,
  specified for dynamic loading); the control-plane surface (which
  tables live on a device) becomes a host-side registry.

## Evolution path (all out-of-tree; nothing needs upstream changes)

1. **Contract + semantics + harness.** The generic block declarations
   as a `.p4` include; Lean semantics for blocks and the reference
   effect interpreter; a source-to-source harness wrapping blocks into
   v1model/PSA slots so everything runs on stock BMv2 today;
   differential testing Lean-vs-BMv2 from the start (the semantics
   must agree with P4-reality once export exists — the harness is the
   sync oracle).
2. **Backend + device models.** A p4c backend compiling P4-authored
   blocks to the IR (p4c's pluggable-backend design is precedented by
   p4c-dpdk/ubpf and third-party P4LLVM/p4c-mlir), plus the Lean
   reference device model and a production runner. Out-of-tree p4c
   backends bear rebase cost against upstream churn — priced in.
3. **By pull only**: further backends, additional device models,
   community engagement.

Upstream contributions happen as byproducts (p4c fixes discovered
while building), not as strategy; the design deliberately requires no
one's permission.

## Project shape (p4neer repo)

One repo. The first-class artifacts are the two contracts; the
executables are evidence they work:

1. **The profile contract** — the `.p4` include (block declarations +
   inert wrapper packages) and its prose spec. The repo's front page.
2. **The block IR schema** — the compiled-block format (protobuf),
   public and documented. The load-bearing seam of the inversion: an
   internal format would make this BMv2-with-different-JSON; a public
   schema is where other backends and device models meet. Shared with
   the Pakeles IR family (parser part), zero Lean dependency.
3. **The simulator** — Rust device model + block engine consuming IR.
   v0 brutally small: one switch model, pcap in/out, tables from a
   plain config file (P4Runtime deferred).
4. **The p4c backend** — P4-authored blocks → IR. Most expensive,
   highest-churn component (p4c internals, upstream rebases).
5. **Conformance corpus + BMv2 harness** — with formal semantics
   deliberately outside p4neer, the source-to-source harness (blocks
   wrapped into v1model on stock BMv2, diffed against the simulator)
   is the repo's self-contained correctness oracle, and its golden
   vectors are the public test corpus for any other implementation.

Sequencing exploits IR-as-ABI decoupling: contract + IR schema →
simulator against hand-authored IR fixtures (no p4c needed) → backend
(acceptance test already waiting) → harness closes the differential
loop. Front-loads the cheap novel parts; defers the churny one.

**Execution packaging**, three layers: the *contract* stays the IR
(device models load IR and choose interpret/JIT/AOT — the eBPF model:
bytecode crosses the boundary, not machine code); the *embedding
surface* is the engine as a library behind a small C ABI (every
language binds it; zero-copy buffers; hosts link the reference
engine, not arbitrary native plugins); the *distribution target* is
Wasm, compiled from IR by the toolchain. Blocks are ideal Wasm
citizens by construction — pure, syscall-free, float-free (fully
deterministic), with externs-as-FFI mapping 1:1 onto Wasm imports
supplied by the host — and Wasm is the one target with a formal
semantics, keeping the trust chain articulable. Known cost:
linear-memory copies; irrelevant for software device models,
disqualifying only for line-rate paths, which consume IR by AOT
compilation anyway. Precedent to verify: Envoy proxy-wasm
(dataplane plugins in Wasm at scale), Extism, component-model/WIT
maturity.

**Browser playground** as a named milestone, two routes: (1) early —
compile the *engine* to Wasm (mature Rust→Wasm path) and interpret IR
client-side; edit surface is the textual IR, so no frontend toolchain
in the browser; available as soon as the simulator exists. (2) later —
blocks themselves compiled to Wasm modules. Because execution is
bit-identical to CI, the conformance corpus doubles as interactive
documentation (every golden vector a run-it-yourself example), and
Compiler-Explorer-style share URLs (IR + packet) become the bug-report
and teaching medium. Kaitai's ide.kaitai.io is the precedent for how
much a browser IDE mattered to the one binary-format DSL that reached
tooling maturity. Pure static assets — no server. Out of scope:
in-browser eDSL (Pyodide, later at most) and in-browser Lean (proofs
stay a CI/desktop story; the playground demonstrates behavior, not
theorems).

## Open items

- Name sweeps for p4lean and p4neer (registries, GitHub, trademark
  adjacency to p4.org and Perforce's P4) before anything
  public-facing.
- Prior art still unexamined: NetKAT lineage, Lucid, Π4
  (dependently-typed P4), P4Cub, Lyra — each needs a stated delta.
  µP4's paper deserves a full read beyond its README.
- Syntax spike: 2–3 operators through the `[p4| …]` elaborator; also
  the Sail counter-spike from [[pakeles-formal-semantics-stack]].
- Decidable-fragment check: parser feature list (lookahead, bounded
  header stacks) vs Leapfrog/Octopus restrictions.
- Verify: p4c's out-of-tree extension mechanism (and submodule-vs-
  installed-lib build strategy), psa_switch completeness, `error`-type
  portability across p4c targets, and the fixed `PortId_t` width
  against Tofino/DPDK mappings.
- Verify the Wasm-plugin precedents from memory: Envoy proxy-wasm,
  Extism, component-model/WIT maturity for typing block signatures at
  the boundary.
