---
author: Claude Fable 5
---

# A formally specified protobuf IR: the Pakeles semantics stack

Question, in three rounds: (1) does any protobuf-serialized IR have a formal
semantics, and what methodologies exist for building one? (2) how to achieve
SpecTec/Sail-style mechanization for a new IR, and what precedents specify a
language in Lean 4 the way Cedar is specified? (3) how should the testing
architecture and frontend surface follow from those choices? Extends the
[[pakelesir-design]] note (2026-07-18), which fixed the decidable-class scope,
the serializable-IR-as-normative-artifact ruling, and the tshark oracle; this
note adds the formal-semantics layer and re-derives the frontend ranking.

Method: six web-research fan-outs (2026-08-25/26), each citing primary sources
(repos, specs, papers). Claims are primary-source-cited by single research
agents, **not** adversarially panel-verified — re-verify load-bearing claims
before citing them in anything durable. Fast-moving landscape: re-check at
writing time.

## The gap, confirmed twice

No protobuf-defined IR anywhere has a corroborated formal semantics. Checked
directly: Substrait (its own formalization attempt,
[discussion #31](https://github.com/substrait-io/substrait/discussions/31),
stalled at prose), Apache Beam Runner API (prose only), P4Runtime (spec
self-describes semantics as prose over protobuf syntax), ONNX (the SONNX
safety-profile WG is a certification-evidence effort, not a semantics; one
ResearchGate-only "full ONNX catalog in Lean 4" paper is unverifiable — no
arXiv, no identifiable authors, 403 on fetch — do not build on it).
Conversely, every formally specified portable format uses a custom encoding:
Wasm (custom binary), EVM (opcode stream), JVM classfiles, Sail-specified ISAs.

The combination is compatible, just unoccupied. The enabling principle, from
Wasm's architecture: **semantics attaches to abstract syntax; the wire
encoding is semantically inert.** Protobuf is a codec for the AST, never the
semantic object. A new IR that pairs protobuf interchange with mechanized
semantics fills a real niche — and doing it spec-first for a *new* IR has no
precedent at all (every existing Lean model below retrofits an existing
language).

## Methodology ladder (spec rigor, cheapest to heaviest)

- **ONNX's own pattern** — protobuf syntax + prose + Python reference impl +
  conformance tests. Proven for interop; SONNX's existence is ONNX's own
  admission it is not enough for certification-grade rigor.
- **TOSA** ([spec](https://www.mlplatform.org/tosa/)) — the most rigorous
  non-mechanized spec in production: versioned executable pseudocode per op,
  explicit `ERROR_IF`/`REQUIRE` preconditions, tiered conformance (bit-exact
  int, ULP-bounded float).
- **StableHLO** ([spec.md](https://github.com/openxla/stablehlo/blob/main/docs/spec.md))
  — constraint-notation spec + a reference interpreter kept in lockstep
  (91/96 ops), the strongest living "executable semantics as spec" pairing.
- **Wasm SpecTec** ([adopted 2025](https://webassembly.org/news/2025-03-27-spectec/))
  — one DSL source generates typeset rules + prose + Coq + interpreter +
  tests; the test suite is the sync oracle. The gold standard — but
  Wasm-locked (no non-Wasm use found; adopting it means forking).
- **Full mechanization** — see toolchain verdicts.

## Toolchain verdicts for a new IR

- **SpecTec**: generality claimed, unproven; single-language artifact. No.
- **Sail**: the language fits (dependent bitvector lengths, SMT-checked —
  right primitive for bit/byte extraction) and its backends (C/OCaml
  emulators, LaTeX, Coq/Isabelle/HOL4) are domain-agnostic, but every use is
  ISA-shaped and the Lean backend is explicitly experimental. Worth a 2–3
  operator spike before final commitment; if the IR reads more
  "decode pipeline" than "dataflow graph," Sail's fit improves.
- **K framework**: actively maintained, real multi-language track record
  (KEVM, KWasm), interpreter + symbolic executor + prover from one
  definition — but no prose generation and no working export to any proof
  assistant, which rules it out when the goal includes metatheory (parser
  equivalence). Load-bearing precedent anyway: Ethereum deprecated the
  Yellow Paper in favor of KEVM
  ([yellowpaper#397](https://github.com/ethereum/yellowpaper/issues/397)) —
  the mechanized executable spec outlived the hand-written math.
- **Ott**: rules → LaTeX + provers (Arm used it for ASL), but no interpreter
  and no tests; superseded for this purpose.
- **Prover-first in Lean 4 — chosen.** The Cedar pattern: evaluator defined
  in Lean (spec = reference interpreter by construction), production Rust
  differentially tested against it, releases gated on model + proofs + diff
  tests being current
  ([cedar-spec](https://github.com/cedar-policy/cedar-spec),
  [lean-lang.org case study](https://lean-lang.org/use-cases/cedar/)).

## Lean-4-as-language-spec landscape (2026-08)

Cedar remains the only verified instance of the full pattern. The nearest
cluster is EVM/Solidity: **SolidCore**
([paradigmxyz/solidity-lean](https://github.com/paradigmxyz/solidity-lean)) —
executable Solidity semantics, replay-tested against solc + Foundry, proofs
checked on every build, public divergence bounty; **EVMYulLean**
([NethermindEth](https://github.com/NethermindEth/EVMYulLean)) — 99.99% of
Cancun conformance tests, aspires to become the official executable source of
truth; **EquiVM** ([argotorg](https://github.com/argotorg/EquiVM)) —
kernel-checked refinement proofs for deployed contracts, LLM-generated
proofs; **risc0-lean4** — self-described research artifact. All retrofit;
none release-gates. Dissolved leads: Ethereum's "leanSpec" is Python (the
"Lean" is a minimalism roadmap); LambdaClass Concrete is aspirational;
sail-riscv's Lean output type-checks but is non-executable. The whole cluster
is blockchain/ZK — a networking application would be the pattern's first
transfer out of that domain.

## The stack (bottom-up)

1. **Wire**: protobuf schema, opset-style versioning. Codec only.
2. **Abstract syntax + types**: Lean 4 datatypes; protobuf mirrors the AST
   with a round-tripping decode/encode (diff-tested at minimum).
3. **Semantics**: executable Lean evaluator = the reference interpreter,
   built into a CLI via lake.
4. **Metatheory**: progress/preservation first; then decidable parser
   equivalence against the real semantics (the Leapfrog result restated for
   this IR — the crown jewel the decidable-class scope was chosen for).
   Proofs checked on every build, SolidCore-style.
5. **Production**: the Rust toolchain, never normative.
6. **Conformance oracle**: shared (IR, packet, expected) corpus + Cedar-style
   differential random testing; release gate in Cedar's wording. The corpus
   is the single spine every consumer — Lean, Rust, any frontend — is judged
   against.
7. **Prose spec**: hand-written TOSA-style per-operator document, explicitly
   non-normative, citing Lean definitions as authority.

## Testing architecture (four layers, build in order)

1. **Structure-aware differential fuzzing** — Cedar's recipe: `arbitrary`
   impls over the protobuf-derived Rust types (well-formed programs by
   construction), libFuzzer coverage feedback, Lean over FFI as the diff
   side; + swarm testing (randomly disable IR construct subsets per campaign
   — near-free, empirically high-yield) + shrinking on every divergence.
2. **Symbolic packet generation over the IR** — walk the parse graph over a
   symbolic packet, one Z3-solved concrete packet per feasible path:
   path-complete per-program coverage. Proven in-domain by p4pktgen (ICSE
   2018) and [P4Testgen](https://github.com/p4lang/p4c/tree/main/backends/p4tools/modules/testgen)
   (SIGCOMM 2023, shipped in p4c). The IR is the right symbolic target — it
   is small and it is what both sides consume. (Lean-side symbolic execution
   does not exist as tooling; lean-smt/lean-auto are proof backends.)
3. **Kani harnesses, narrowly scoped** — the s2n-quic precedent: a boundary
   bug libFuzzer missed in 16.7M executions, Kani found in 20s. Small bounded
   harnesses only (one field decode, one length computation); CBMC blows up
   on whole-parser loops.
4. **Bisimulation proofs where decidable** — Leapfrog (PLDI 2022) /
   [Octopus](https://link.springer.com/chapter/10.1007/978-3-032-32519-8_11)
   decide parser equivalence for bounded-lookahead automata without unbounded
   header stacks; for that fragment, proof replaces testing. Open scoping
   question: the IR's P4-checklist features (lookahead, header stacks with
   depth bounds) against Octopus's restrictions.

Program generation: seed with real protocols (the Kaitai formats gallery has
ready-made ethernet/ipv4/tcp/dns specs; Wireshark's corpus for exotic
shapes), synthesize beyond seeds type-directedly, and guide by
field-dependency-pattern coverage (MLIRod's finding: bugs live in uncommon
dependency patterns between ops, not op presence) measured across *both*
sides.

## Frontend ranking (revised)

The ONNX/StableHLO lesson: adoption came from low-friction *producers*, not
native authoring languages (ONNX Script arrived six years after ONNX won;
StableHLO is never hand-authored). Frontends are producers into the IR, and
they stack:

1. **Protobuf text format first** — the WAT/MLIR-style textual surface for
   free (built-in `TextFormat`; only a pretty-printing convention to
   document). Golden-file format for the differential loop, debugging
   surface, common compile target for every frontend. Consistent with the
   design note's "no textual DSL" ruling — this is the mechanical 1:1
   projection that ruling explicitly allows, not a second language.
2. **Python eDSL as the practitioner on-ramp** — declarative classes
   (Scapy/construct idiom) over builders code-generated from the protobuf
   schema (MLIR-ODS move: one schema, no frontend/IR drift);
   construction-time validation (JAX's model, not cvxpy's defer-to-solve);
   explicit `Switch`/`when` combinators for value-branching (Python cannot
   overload `and`/`or`/`if` — hard constraint). Tested by three-way
   differential execution (pure-Python interpreter vs Lean vs Rust, exact
   equality), Hypothesis at IR- and eDSL-level, round-trips, golden IR
   snapshots, torch.onnx-style `opset_version` targeting.
3. **Lean eDSL as the maintainer channel** — canonical protocol specs
   authored via Lean syntax extension, elaborated to the IR and checked
   against the semantics in the same file (zero drift; Verso proves Lean
   hosts non-proof DSLs). Not the public frontend: toolchain UX is wrong for
   network engineers.
4. **Import paths by pull** — Kaitai `.ksy` and P4 parser blocks (p4c
   frontend usable as a library; P4LLVM/p4c-mlir precedent), Rust eDSL as a
   later producer.

Rejected: a bespoke external DSL — P4, funded and a decade in, still has no
production-quality LSP (`p4analyzer`: "not even at Alpha quality"); a second
language surface maintained forever, buying nothing over text format +
Python. Kaitai as literal frontend — seekable-streams-only (won't-fix), no
formal semantics to anchor, GPLv3 compiler; its `switch-on` model and formats
gallery are the parts to steal. Design donors to read: Daedalus (Galois;
declarative DDL with real tooling incl. LSP, BSD-3) and EverParse/3D (the
correct-by-construction contrast to this test-and-prove architecture —
already positioned as sibling in the design note).

## Open items

- Sail spike (2–3 operators) before final commitment to Lean-only authoring.
- Decidable-fragment check: IR feature list vs Octopus/Leapfrog restrictions.
- SONNX primary documents (WG `/deliverables`, the HAL paper) were not
  reachable this pass; the Why3 attribution remains unconfirmed.
- Positioning claim to re-verify at writing time: "first protobuf-carried IR
  with mechanized semantics" and "Cedar's release gate has no second
  implementer" were true as of 2026-08-26; the EVM cluster moves fast.
