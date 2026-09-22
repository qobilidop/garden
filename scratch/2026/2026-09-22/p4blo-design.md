---
author: Claude Fable 5.1
---

# p4blo: P4's semantic core as an IR

P4's semantic core as an IR, architecture-free, with an independent
Lean semantics validated against a runnable reference.

That sentence is the project. p4blo is a personal, educational
prototype whose purpose is to make the sentence concrete enough to
argue about, so that a serious version can later be proposed to the
P4 community as an RFC rather than built alone. It supersedes the
P4NAH demo design (`scratch/2026/2026-09-19/p4nah-design.md`) and the
p4lean design before it; P4NAH survives as the name of one rule
inside p4blo. Pakeles is a sibling, not a part: it is a parser IR
designed from first principles, where p4blo's parser fragment is P4's
own parser semantics, faithfully.

## Who it is for

The primary reader is the P4 language community: spec, compiler and
architecture people. "Educational" describes the artifacts, each
small enough to read in a sitting, not a separate audience. P4 users
who want to learn what a program means by reading an interpreter, and
formal-methods people who want a Lean foothold for P4, are served for
free.

The proposal p4blo makes is one paragraph and has no ask: P4 should
have a specified, architecture-free semantic core with a serialized
form; the P4 language is one frontend of that core among several;
architectures and externs are specified outside it as contracts. An
RFC to standardize the IR this way comes after the project, not
inside it, and must read as the serialized form of the elaborated
core that P4-SpecTec already defines, with the architecture taken
out, never as a third IR beside SpecTec and p4mlir.

## The four claims

Each has one experiment and one way to fail. The project makes these
and no others.

1. **The core is small and post-elaboration.** The proto schema and
   its contract fit in a few pages. No generics, no `int`, no
   implicit casts, no tuples; every width resolved; names as ids.
   Fails if a corpus program needs an escape hatch.
2. **The core is semantically complete for real programs.** Four
   programs, authored in the Python eDSL, printed to P4 text and run
   through BMv2 under a v1model shim, match the reference interpreter
   packet for packet. Fails on any divergence not traceable to a
   documented closed behavior.
3. **A block is a function; an architecture is ordinary code.** Two
   architectures, a filter and a switch, each around fifty lines of
   Python with no P4 in them; every corpus program runs under both
   unchanged. Fails if the line counts say otherwise or a block needs
   a hook one architecture lacks.
4. **The semantics is mechanized and agrees with the reference.** A
   Lean interpreter over the IR, differential random testing against
   the Python interpreter with zero unexplained divergences, and one
   theorem. Fails if a divergence cannot be attributed to a bug in
   one side.

Not claimed: performance, running existing P4 source, P4Runtime,
hardware, or a replacement for any tool. The browser playground
below is a deliverable, not a claim: it proves nothing the native
tests do not.

## What is normative

- **Syntax:** the protobuf schema, plus a validator for what a schema
  cannot express (widths agree, ids resolve, parse graph rules).
  The text format is the readable representation and the golden
  format; binary and JSON are transports.
- **Meaning:** the Lean interpreter. Everything else, the Python
  interpreter, the printer, the eDSL, the prose, is tested against
  it. Until Lean exists the Python interpreter is provisional and the
  prose contract stands in.
- **Closed behaviors:** everything P4 leaves open and p4blo closes is
  listed in one file with its choice: reading a field of an invalid
  header, extraction past the packet end, arithmetic overflow, shifts
  by the width or more, table miss, LPM and ternary tie-breaking,
  header-stack index out of range, and the parser loop bound (a
  parser may loop over a stack; a state that consumes no bits may not
  be revisited, or a fuel rule, decided in the note's open items).

## The design

**Post-elaboration.** The IR is P4 after the frontend has done its
work: monomorphic blocks, resolved widths, explicit casts, desugared
control flow, interned names. That is the gain of being free of
frontend sugar, and it is what keeps the Lean semantics free of type
inference. Every frontend, Python now, others later, owes the IR the
same elaboration.

**Blocks.** The one hardcoded thing is a block calling convention and
the rule that a block performs no effects (the P4NAH rule):

```
parse   : Packet × M → (H × M × bytes consumed) | ParseError
control : H × M × TableEntries → H × M
deparse : H → Packet
```

A control writes fields of `M`; whoever called it acts on them
afterwards. Drop, forward, flood, clone and recirculate are decisions
written as data, executed by the architecture. Tables are inputs
installed by the host. A block may call another block; that is P4's
own composition and it is in.

**Metadata contract.** An architecture declares the `M` fields it
needs, each with a width and whether the architecture provides it
before the block runs or consumes it after. At load the program's `M`
is checked structurally against the declaration and nothing else
about `M` concerns anyone.

**Externs.** Register, counter, meter, hash and checksum are not core
P4; they are v1model, PSA and PNA externs. So at the IR level an
extern is exactly a declared type with method signatures, an instance
with constructor arguments, and call sites. The reference interpreter
binds each instance to a registered Python callable at load, checks
arity, directions and widths, and refuses to load on any mismatch.
Every extern a corpus program uses ships twice, a Python
implementation and a Lean model, pinned to each other by vectors;
that pair is corpus material, not spec material. A Python package of
such bindings is a convenience, not part of the IR.

**Architectures.** Python functions of one shape: given an ingress
port and a packet, return egress ports and packets. The filter runs
parser then control. The switch runs all three blocks over a few
ports and implements drop, unicast and flood. Neither contains P4.

**Python eDSL.** A builder that constructs IR: plain constructors for
declarations, operator overloading for expressions, explicit
constructs for control flow in the manner of JAX's `lax.cond`. No
decorator that reads Python source, because the IR is the product and
the eDSL should teach it by use, not hide it.

**Printer.** IR to P4-16 text. Cheap, and it pays twice: it feeds the
BMv2 oracle and it is a frontend in reverse.

**Pure Python, always.** The Python package carries no native
dependency, ever: the protobuf runtime is the pure-Python wheel,
packets are `bytes` and `int`, and pcap I/O lives in a separate
optional package. This is what makes the playground free, and the
first compiled dependency would silently kill it.

**Playground.** The published wheel loaded into the browser through
Pyodide, presented as a marimo notebook exported to static HTML plus
wasm with its offline bundle, hosted under the repository. The user
edits eDSL code and sees packets and traces below it; the corpus
vectors replay in the page and show the oracle's verdict. It runs the
eDSL, validator, interpreter, printer and both architectures; it
cannot run BMv2 or Lean, and the page says so in one line. Costs
accepted: a few megabytes and seconds on first load.

**Oracle.** BMv2's `simple_switch` running the printed programs
wrapped in a v1model shim that maps the metadata contract onto
`standard_metadata`. Vectors, program plus entries plus input pcap
plus expected output, are generated once from the oracle and replayed
by every implementation. P4-SpecTec's interpreter is a candidate
second oracle.

**Lean and DRT.** A Lean interpreter over the IR, decoding the
protobuf JSON mapping with Lean's own JSON support (Cedar's Lean
protobuf library is the upgrade if speed matters). Differential
random testing: corpus programs times random packets and table
entries, both interpreters run, outputs compared, every divergence
attributed. A pipe to a Lean binary is enough; no FFI. Random program
generation is later, if ever. One theorem, extract-then-emit
roundtrip being the current pick.

**Coverage table.** Every construct of P4's core appears with one of
three statuses: in; elaborated away, with the elaboration named; or
excluded, with a reason. The checklist is P4-SpecTec's elaborated IL,
walked construct by construct, because it is exactly P4 core after
sugar. The subset is a checklist, not a horizon: the schema is
designed for the full core and never bakes an exclusion into its
shape.

## Scope

Three exclusion categories; only the third makes p4blo a subset.

- **Out by thesis:** anything architecture-dependent: intrinsic
  metadata, packet fate as externs, action selectors and profiles,
  direct counters and meters, clone and recirculate as operations.
- **Out by elaboration:** generics, `int`, implicit casts, tuples,
  `switch` on action runs, and other sugar the frontend removes.
- **Out by scope, each threatening no claim:** varbit, header unions,
  value sets, `exit`, `return`, extern function objects.

**In:** `bit<N>`, `bool`, enums and errors, headers, structs, header
stacks with push, pop and index arithmetic; parser states with
extract, lookahead, advance, verify, select with masks and ranges;
sub-parser and sub-control instantiation; actions with data; tables
with exact, lpm and ternary keys, priorities, default actions, const
entries; `if`, assignment, slices, concatenation, explicit casts,
wrapping arithmetic; emit; declared externs.

**Corpus,** chosen to hit the hard semantics: the p4lang tutorial
forwarder (lpm, TTL, checksum); an ACL (ternary with priorities,
parser errors); an MPLS or VLAN program (header stacks); a stateful
program (register).

**Not built:** a p4c backend, performance, P4Runtime, a P4 text
parser, any playground frontend code beyond the notebook. The p4c
backend is named in the README as the first thing the community
version would build, with 4ward's route as precedent.

## Order

Each step ends with something that can fail.

1. Schema, validator, closed-behaviors file, the forwarder hand-written
   in text format, the Python interpreter running one packet.
2. Extern registry with signature checks; the stateful program.
3. The Python eDSL; the four programs authored in it; the two
   architectures; the metadata contract check.
4. The printer, the v1model shim, BMv2 in a container, the vectors.
   Claims 1 to 3.
5. The Lean interpreter, the extern models, DRT, the theorem. Claim 4.
6. The coverage table, the README, the write-up.
7. The playground: the wheel on PyPI, the notebook exported, the
   corpus replaying in the browser. Last, because until the table is
   final the corpus is not. Done.

Done means: four claims green, coverage table published, README with
the sentence and the claim matrix, the corpus running in the browser,
one blog post. The date is Bili's
to set. The honest "useful on its own" story is modest: a readable
Python P4 interpreter with a clean IR, good for teaching and for
testing table logic in pytest, until a p4c bridge exists.

## Repository

```
p4blo/
  README.md          the sentence, the four claims, the coverage table
  proto/p4blo.proto  the IR
  SEMANTICS.md       closed behaviors; prose commentary on the Lean
  python/p4blo/      ir, validator, eDSL, interpreter, printer,
                     externs registry, architectures
  lean/              the interpreter, extern models, the theorem
  corpus/            four programs (eDSL source, IR goldens, P4 text)
  oracle/            v1model shim, BMv2 container, vector generation
  vectors/           the corpus vectors
  drt/               the differential loop
  playground/        the marimo notebook and its export
  tests/             one test per claim cell
```

## Neighbors

- [P4-SpecTec](https://github.com/kaist-plrg/p4-spectec): the P4
  spec's own executable mechanization, on the official track since
  2026. Its elaborated IL is the coverage checklist and its
  interpreter a candidate oracle. p4blo does not re-mechanize P4; it
  serializes the elaborated core and takes the architecture out.
- [Nano-P4](https://github.com/pacokwon/nano-p4-spec) (P4.org GSoC
  2026): an educational P4 dialect with typing rules, dynamic
  semantics and one hardcoded NanoSwitch architecture, in SpecTec.
  The same size of language with the opposite decision about the
  architecture; the foil for claim 3.
- [4ward](https://github.com/4ward-p4/4ward): a p4c backend into a
  protobuf behavioral IR into a Kotlin simulator, no semantics; the
  proof that a protobuf P4 IR is workable and the precedent for a
  p4c bridge.
- [p4mlir-incubator](https://github.com/p4lang/p4mlir-incubator): a
  compiler IR for a future p4c, not an interchange format.
- [HOL4P4](https://github.com/kth-step/HOL4P4): mechanized semantics
  with an executable derived inside the prover; no serialized IR.
- [cedar-spec](https://github.com/cedar-policy/cedar-spec): the
  method: Lean model as the spec, a production implementation,
  differential random testing, protobuf across the boundary.
- [µP4](https://github.com/cornell-netlab/MicroP4) (SIGCOMM 2020):
  composed programs inside the language; p4blo takes the architecture
  out of it. The framing to be visibly different from.
- [BMv2](https://github.com/p4lang/behavioral-model): the oracle.
- [Pyodide](https://pyodide.org/) and
  [marimo](https://docs.marimo.io/guides/wasm/): the playground
  substrate. Pyodide runs any pure-Python wheel and ships protobuf;
  marimo exports a notebook to static HTML plus wasm (verified
  2026-09-22).

## Naming

*p4blo*: `p4` plus `blo`, block cut short, read aloud as *Pablo*.
Pablo descends from Latin *Paulus*, "small", so the name says small
blocks in two languages. Name-shaped rather than claim-shaped, so the
tagline carries the claim. Sweep (2026-09-21): free on PyPI,
crates.io and npm; no repository of that name; the GitHub handle is
an unrelated empty account. Domains and trademarks unswept.

Considered and rejected: `p4sem` and `p4ir` name the method (and
p4ir is one letter from P4HIR); `p4blocks` is claim-shaped and
invites the µP4 reading; `p4nah` reads as dismissive of P4 the moment
it heads a community proposal; the small lane (`p4mini`, `p4tini`,
`p4nano`) is Nano-P4's, and `p4nano` collides with it outright;
`microp4` is µP4; `p4core` reads as core.p4; pa-words from other
languages (*pala*, *palikka*, *parva*, *pavé*, *parça*) each needed a
footnote that `blo` does not.

## Open

- Blocks as exactly three kinds, or typed functions with a kind tag.
- The parser loop bound: a no-consumption revisit rule versus fuel.
- The one theorem: extract-then-emit roundtrip is the pick; parser
  determinism is the alternative.
- Whether the v1model shim can express flood without BMv2 multicast
  groups; if not, flood is checked between the two architectures and
  the oracle covers drop and unicast.
- Whether P4-SpecTec's interpreter can be driven as a second oracle
  on the printed programs.
- Whether p4blo parsers could one day lower to Pakeles; a question,
  not a plan.
