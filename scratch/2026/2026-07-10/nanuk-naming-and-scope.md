# nanuk: naming and scope decisions

2026-07-10. Session with Claude on naming the educational packet-processor
project. **Outcome: the project is `nanuk`** (Inuktitut for polar bear;
personal meaning, hidden "nano-", polar bear mascot).

## The project

Educational, minimal, from chip to programming language:

- ISA-based packet engine in the spirit of Xsight Labs
  [xISA](https://xsightlabs.com/blog/unlocking-the-future-of-programmable-networking-introducing-the-xisa-by-xsight-labs/)
  (RISC-like, ~50 instructions/engine) — **not** PISA/match-action.
- General dataplane engine: usable in a switch or a NIC, not switch-specific.
- Formal spec in Sail; P4-inspired Python eDSL; MLIR compiler infra.

## Prior art surveyed

- Full-stack journeys: Nand2Tetris, xv6, fromthetransistor (the cautionary
  unfinished one), Crafting Interpreters, tinygrad.
- Minimal cores: PicoRV32, SERV, Sodor, Ibex, mini-rv32ima. They implement a
  *given* ISA — a big part of why they finish.
- Networking education: NetFPGA + P4→NetFPGA
  ([Ibanez et al.](https://www.cl.cam.ac.uk/~nz247/publications/ibanez2019p4netfpga.pdf),
  needs $$$ board, opaque IP), BMv2 (unreadable black box), Corundum, Snabb.
- Direct neighbors: [p4mlir-incubator](https://github.com/p4lang/p4mlir-incubator),
  [sail-riscv](https://github.com/riscv/sail-riscv) (the model to imitate:
  spec → generated emulator as golden model), Kaitai Struct (software binary
  parsing; nanuk differentiates on streaming/hardware semantics).

**The gap is real: there is no Nand2Tetris of packet processing.**

## Scope decisions

- **Parser-first.** The parser is a distinct engine with its own micro-ISA in
  real chips, so a standalone parser ISA is stage 1 of the same architecture,
  not a smaller different project. Parse graph = FSM → bridges automata theory
  to gates; canonical anchor is Gibb et al., "Design Principles for Packet
  Parsers" (ANCS 2013). Weak demo appeal mitigated by a ~50-line fixed
  forwarding stub so packets visibly move.
- **Staging:** 1) Sail parser-ISA spec → generated emulator (golden model,
  shippable alone); 2) Python eDSL → assembly directly; 3) MLIR dialect
  inserted later as a refactor (MLIR-first is the over-engineering trap);
  4) RTL core cosimulated against Sail; Tiny Tapeout capstone.
- **Parked:** multiple engines, traffic manager, real MAC/SerDes, line rate,
  standalone language. Keep the park list visible in the repo.
- **ISA design hedge:** derive from RV32E + a few packet ops
  (extract/deposit, lookup, checksum) rather than inventing from whole cloth
  — one open design problem at a time.
- **Monorepo:** `spec/ hw/ lang/ compiler/ guide/ examples/`; MLIR subdir gets
  an isolated build; ISA churn is cross-layer so commits must be atomic;
  one CI pipeline tests eDSL → compiler → Sail emulator → RTL cosim.
  (Chipyard's submodule meta-repo is the anti-pattern.)

## Naming journey

Candidates considered and why they fell:

- `punt` — punting is slow-path vocabulary; the joke contradicts a project
  whose thesis is building the fast path. Self-deprecating names only work
  when the joke is true (SERV's is).
- `tinypisa` — died when architecture pivoted from PISA to xISA-style.
- `tinyswitch` — switch-specific; scope is switch-or-NIC.
- `tinyplane` — strong runner-up (data plane + planing hull + paper plane +
  Sail wink); felt long, though 9 letters is peer-normal (tinygrad 8,
  nand2tetris 11).
- `TinyPP` — pronounced "tiny pee-pee"; the joke never retires.
- `packeteer` — secondhand: Packeteer Inc. (PacketShaper, Blue Coat 2008);
  PyPI taken.
- `matcha`, `dplane`, `snip`, `tipp`, `packlet` — assorted lesser fits.
- Every common short English word (plane, fin, wisp, skim, pkt, tern, rill,
  skiff, peel, foil) is squatted on PyPI; short ⇒ coinage.

`nanook` (preferred spelling) is blocked: PyPI squatted (dormant KORG tool),
GitHub user active. **`nanuk` is clean everywhere:** PyPI, npm, crates.io,
RubyGems, Homebrew, conda-forge, NuGet, Maven, Docker Hub all free as of
2026-07-10. GitHub username taken (active user since 2011, orgs share the
namespace) → repo is `qobilidop/nanuk`; org fallbacks `nanuk-project` /
`nanuklang` if ever needed.

## Launch checklist

- Real-world collisions: NANUK case brand, Czech "nanuk" = popsicle. No legal
  risk (different class), but search noise — always pair the name with the
  tagline ("nanuk — a tiny packet processor, from chip to language").
  The tagline is load-bearing; the name explains nothing (Ibex/Sodor pattern).
- Claim early: public repo with README commit (private reserves nothing);
  PyPI 0.0.1 stub once a skeleton module exists (real stub, not a squat);
  `nanuk.dev` if wanted.
- Licenses in commit one: Apache-2.0 for code/RTL (patent grant matters for
  hardware), CC-BY-4.0 for the guide.
- Biggest remaining risk is scope, not branding. Milestone 1 = the Sail
  parser-ISA spec.
