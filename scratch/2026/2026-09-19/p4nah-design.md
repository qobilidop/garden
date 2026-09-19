---
author: Claude Fable 5.1
---

# P4NAH demo: a block is a function

Take the architecture out of P4 and a block becomes a function you
can call from anywhere, with its externs as imports; the architecture
becomes a hundred lines of ordinary code, and you lose nothing.

That sentence is the whole project. `p4nah-demo` exists to find out
whether it is true, and is designed so that it can turn out false.
P4NAH expands to **P4, No Architecture Hardcoded**. This note is the
design of the demo repository; the two-day exploration that led here,
with its research and prior-art evidence, is the sibling note
`p4nah-exploration.md` in this directory.

## The four claims

Each claim has one experiment and one way to fail. The demo makes
these four and no others.

1. **A block is a function.** The same compiled block runs under two
   hosts, a Rust program natively and a JavaScript program in a
   browser, and produces byte-identical output on the same packet and
   the same table entries. The block must be one that *decides*
   something, drops or forwards, because any checksum is trivially a
   function. Fails if either host needs a hook the other does not.
2. **Externs are imports.** The same block runs with its externs
   bound three ways, a Rust implementation, a JavaScript callback, and
   a test mock, without recompiling the block. Extern state, a
   register, is visible to the host between packets. An unbound or
   mistyped extern is a load error naming the instance. Fails if any
   extern has to live inside the block to work.
3. **An architecture is small ordinary code.** Two architectures, a
   filter and a switch, each under a hundred lines of Rust with no P4
   in them, and each again in JavaScript. Swap the program without
   touching the architecture; swap the architecture without touching
   the program. Fails if the line count says otherwise.
4. **Nothing is lost.** The switch architecture, running the demo
   programs, matches BMv2 packet for packet on the same inputs. This
   is what stops the first three claims from holding only for a toy.
   Fails on any divergence not traceable to a documented choice.

Not claimed: performance, compatibility with existing P4 programs, a
formal semantics, portability to hardware, or a replacement for any
existing tool. Formal semantics is a different project (P4Lean),
which will attach to the IR this demo defines.

## The design

**The fixed point.** Something must be hardcoded; here it is a block
calling convention and nothing above it:

```p4
parser  Parser<H, M>(packet_in pkt, out H hdr, inout M meta);
control Control<H, M>(inout H hdr, inout M meta);
control Deparser<H>(packet_out pkt, in H hdr);
```

plus one rule: a block performs no effects. A control writes fields
of `M`; whoever called it acts on them afterwards. Dropping,
forwarding, flooding are decisions written as data and executed by
the architecture. This is PSA's own deferred-execution model made the
language's only rule, and it is what makes a block a function.

**Blocks as functions, precisely.**

```
parse   : Packet × M → (H × M × bytes consumed) | ParseError
control : H × M × TableEntries → H × M
deparse : H → Packet
```

Tables are inputs, installed by the host, never state inside the
block. A parser rejection is a value; what happens next is the
architecture's decision, like a drop.

**The IR.** A protobuf schema, `p4nah.proto`, is the one seam of the
project: the frontend produces it, the interpreter consumes it, the
golden files are its text format. It carries types (`bit<N>`, structs,
headers), the three block kinds (parser states and transitions;
actions, tables and a structured `apply` body; emit sequences), extern
declarations, and the program's `M` struct. It carries no
architecture: no port width, no intrinsic metadata, no extern
implementation. Its meaning for the demo is fixed by a prose contract,
`IR.md`, that states the purity rule and every behavior P4 leaves
open and the demo closes: reading a field of an invalid header yields
zero, extraction past the end rejects, arithmetic wraps, a shift by
the width or more yields zero, a table miss runs the default action,
longest prefix wins. That file is what P4Lean will mechanize later,
so it is written as a specification, not as notes.

**Values.** Inside the interpreter a `bit<N>` is a width plus a
`u128` payload with masking; wider values are out of the demo. Byte
order exists only at `extract` and `emit`, in network order, as P4
specifies. Structs are field vectors indexed by ids interned from the
IR; headers are a validity bit plus fields; packets are byte
vectors. Widths are not in Rust types: the IR decides them at load
time, and the checker enforces them once.

**Externs.** The IR declares an extern type by its methods, with
parameter directions and widths, and declares instances with resolved
type parameters and constructor arguments. The interpreter resolves
every instance at load time against a registry the host filled: a
factory per extern type, an optional override per instance. Signature
mismatch and missing binding are load errors. State belongs to the
implementation object, so the host reads a register between packets.
Packet-fate operations are never externs; they are metadata. Reads of
the environment, timestamps and random numbers, are out of the demo.
The standard extern crate ships `csum16`, a CRC-32 hash, a register
and a counter, all deterministic, because the corpus pins their
outputs.

**The metadata contract.** An architecture declares the fields it
needs in `M`: name, width, and whether it *provides* the field before
the block runs or *consumes* it after. At load the program's `M` is
checked structurally against that declaration and nothing else about
`M` is anyone's business. The filter needs one consumed field,
`drop`. The switch provides `ingress_port` and consumes `drop`,
`egress_port` and `flood`. A program written for the switch runs
under the filter unchanged.

**Architectures.** Ordinary code with one shape: given an ingress
port and a packet, return the list of egress ports and packets. The
filter runs parser then control and returns the packet or nothing.
The switch runs parser, control and deparser over four ports and
implements drop, unicast and flood. Each is written twice, in Rust
inside the crate and in JavaScript inside the page, and the two must
agree on the corpus. Neither contains P4.

**Hosts.** Native: a CLI that loads a program and an architecture,
installs entries, and runs a pcap through, writing a pcap. Browser: a
wasm module built from the same crate, exposing load, install, bind
extern and the three block functions, with the architecture and the
externs written in JavaScript in the page and the trace shown per
packet. Wasm is the only foreign binding surface in the demo; a C ABI
is deliberately absent.

**The oracle.** BMv2's `simple_switch` running the same programs
wrapped in a v1model shim that maps `M`'s contract fields onto
`standard_metadata`. The corpus of vectors, program plus entries plus
input pcap plus expected output pcap, is generated once from the
oracle and replayed by every cell of the matrix. It is the only check
on the interpreter that is not the interpreter.

**The programs.** Two, chosen to decide packet fate in different
ways: an ACL over Ethernet, IPv4 and TCP or UDP with a prefix table
that drops or passes; and IPv4 forwarding in the shape of the p4lang
tutorial, with an LPM table, a TTL decrement, MAC rewrite and the
checksum extern. Both run under both architectures: the ACL under
the switch floods what it does not drop; forwarding under the filter
has its port decision ignored.

**The subset.** Exactly what the two programs need: `bit<N>`,
`bool`, headers, structs, parser states with `extract` and `select`,
actions with parameters, tables with `exact` and `lpm` keys and a
default action, `if`, `apply`, `emit`, declared externs. No header
stacks, no `varbit`, no generics beyond the three block signatures,
no `package` or `main` in programs. Everything else is a spanned
"unsupported" error from the frontend, so the grammar stays P4's and
the subset is what the frontend accepts.

**The frontend.** tree-sitter, starting from Oxide's
[`tree-sitter-p4`](https://github.com/oxidecomputer/tree-sitter-p4)
(MPL-2.0, active 2026-09), forked if its coverage falls short of the
subset. The walk from concrete syntax tree to IR, with name resolution
and widths, is the actual frontend and is written in Rust. The
tree-sitter crate (0.27, 2026-08) builds for wasm32, so the parser
lives in the same module as the interpreter and the page highlights
with the same grammar. If the C runtime fights the wasm build, a
pure-Rust PEG parser is the fallback and that decision takes a day.

**`p4nah.p4`.** A one-file P4 include with the three generic block
types and an inert package, so the demo programs are checkable with
stock `p4test` and wrappable for the oracle. It is the only artifact
in the repository someone else could adopt today.

## Technology, with the reason for each

- **Rust** for the crate: Pakeles already exists in Rust with a
  protobuf IR and an interpreter of the same shape; wasm is one
  build flag; rustc is the strictest reviewer an AI-assisted
  prototype gets. Written loosely, cloning freely, indices over
  references, because a demo that fights the borrow checker has
  chosen the wrong idiom.
- **protobuf** for the IR: a schema with a text format is the seam
  between frontend, interpreter, corpus and, later, P4Lean.
- **wasm-bindgen** for the browser: the host demo that anyone can
  open.
- **tree-sitter** for parsing: an existing grammar, editor support
  from the same file, error recovery for a playground.
- **BMv2** as the oracle: the incumbent, and the only independent
  one.
- **No Lean, no C ABI, no p4c backend, no P4Runtime.** Each was
  considered and each belongs to a different project.

## Repository

```
p4nah-demo/
  README.md         the sentence, the four claims, the matrix
  p4nah.p4          the calling convention as a P4 include
  IR.md             the IR's prose contract
  proto/p4nah.proto the IR
  programs/         acl.p4, l3fwd.p4, and their IR text-format goldens
  crates/p4nah/     ir, frontend, values, interpreter, externs,
                    contract, architectures (one library crate)
  crates/p4nah-cli/ native host over pcap; corpus replay
  crates/p4nah-wasm/ the browser binding
  web/              the page: editor, JavaScript architectures and
                    externs, run, trace
  oracle/           v1model shim, BMv2 container, corpus generation
  vectors/          the corpus
  tests/            the matrix, one test per cell
```

The README's front page is a matrix, not a feature list: two programs
by two architectures by two hosts by three extern bindings, a link per
cell, the two architecture line counts underneath, and one command to
re-run any cell. A component belongs in the demo when it fills a cell.

## Build order

Each step ends with something that can fail.

1. `p4nah.proto`, `IR.md`, the ACL program hand-written in IR text
   format, the interpreter running one packet natively. Claim 1, one
   host.
2. Extern registry, the standard extern crate, a mock; forwarding
   with its checksum. Claim 2, one binding.
3. The two Rust architectures, the metadata contract check, the CLI
   over pcap. Claim 3, one language.
4. The oracle: v1model shim, BMv2 in a container, the corpus. Claim
   4, and from here every later step replays the corpus.
5. The frontend, so the programs are authored as P4 text and the
   hand-written IR goldens become generated ones.
6. The wasm binding, the page, the JavaScript architectures and
   externs. Claims 1 to 3 across hosts and bindings.
7. The matrix in the README, every cell green or explained.

## Neighbors

- [4ward](https://github.com/4ward-p4/4ward) (Kotlin, Apache-2.0,
  2025–26): p4c backend to a protobuf IR into a glass-box simulator
  with trace trees, v1model, PSA and PNA. Its roadmap admits v1model
  bleeds into its interpreter at extern dispatch, fork types and the
  clone, resubmit and recirculate flags, which are the three things
  this design moves out of blocks. The closest project in shape; the
  demo does not compete with it on simulator features.
- [Oxide's x4c, p4rs and SoftNPU](https://github.com/oxidecomputer/p4)
  (Rust, MPL-2.0): the only maintained Rust P4 execution stack, with
  one fixed architecture and a `Pipeline` trait. Source of the
  tree-sitter grammar.
- [BMv2](https://github.com/p4lang/behavioral-model) (1.15.6,
  2026-09): the oracle.
- [P4-SpecTec](https://github.com/kaist-plrg/p4-spectec): the P4
  spec's own executable mechanization, referenced from the P4-16
  spec since 2026-09-14; where P4Lean will look for the meaning of
  P4-defined behavior. Not part of this demo.

## Naming

*P4NAH*: **P4, No Architecture Hardcoded**, and "P4? nah". `p4` plus a
short suffix is the ecosystem's own convention. Sweep (2026-09-18):
no GitHub repositories, users or organizations for `p4nah` or
`p4nah-demo`; free on crates.io, PyPI and npm. Domains and trademarks
unswept.

## Open

- Coverage of Oxide's grammar against the subset; decided by running
  it on the two programs.
- The tree-sitter C runtime under wasm32 in practice.
- Whether the v1model shim can express `flood` without configuring
  BMv2 multicast groups; if not, flood is checked by the two hosts
  against each other and the oracle covers drop and unicast.
- Table semantics the oracle will pin: LPM tie-breaking and default
  action behavior must match BMv2 or be listed in `IR.md` as a
  documented divergence.
