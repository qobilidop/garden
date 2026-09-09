---
author: Claude Fable 5.1
---

# Eprouvette: semantics in, verified symbolic executor out

Bili's design idea, developed in conversation over one session. The
starting question was whether to invent a specification language that
compiles to SMT-LIB. The answer that survived is narrower and better:
a Lean 4 library in which you write a target language's semantics as
an interpreter, and a symbolic executor and test generator for that
language falls out — with the executor's answers checked, and for one
fragment, Lean theorems. The use case it replaces is the hand-written
symbolic executor over a solver API (the
[p4pktgen](http://theory.stanford.edu/~barrett/pubs/NKF+18.pdf) shape:
a test generator in Python over z3py that reimplements path
enumeration and pruning by hand). "Eprouvette" is a temporary name,
swept but unreserved (see the naming section).

Independent project: not a module of any sibling project in this
scratch layer, though the Lean-model-plus-differential-testing pattern
it reuses was settled for one of them in
[[pakeles-formal-semantics-stack]] and is inherited here unchanged.

Method note: claims are primary-source-cited from single-agent web
passes plus direct fetches (Cedar SymCC sources, the Leanette
artifact, the Iorek paper); "unverified" marks the gaps. Not
panel-verified.

## What was rejected on the way, and why

**A spec language compiling to SMT-LIB.** Lean already is that
language: a `Prop` over `BitVec`, `Int`, structures and inductives,
discharged by `bv_decide` (verified bitblasting in core),
[lean-smt](https://github.com/ufmg-smite/lean-smt) (cvc5 with proof
reconstruction; UF and linear arithmetic, bitvectors experimental),
`grind`, and lean-auto. An eDSL whose pitch is "nicer than raw
SMT-LIB" competes with its own host.

**Compiling to solver-API code in C++, Python, Rust.** SMT-LIB text is
already the cross-language ABI: every binding parses it, and `push`,
`pop`, `get-value` are SMT-LIB commands. Generating API code per target
buys nothing for a fixed formula. Where a host program must build
formulas from runtime data, the thing to ship is an *encoder* in that
language, hand-written and differentially tested against the Lean one
— exactly Cedar's split between its Lean symbolic compiler and the
Rust `cedar-policy-symcc` crate. Lean-to-Rust/Python extraction is not
a shipped path (the mature pipelines run Rust *into* Lean via Charon
and Aeneas; λ□ extraction is research-grade).

**Rosette as an eDSL in a mainstream language.** The structural
obstacle is intercepting `if` on a symbolic boolean. Racket lifts it by
macro; Haskell gets an explicit `mrgIf` by typeclass
([Grisette](https://dl.acm.org/doi/10.1145/3571209), POPL 2023, the
only typed-library Rosette); mainstream hosts have neither, leaving
re-execution ([CrossHair](https://crosshair.readthedocs.io/en/latest/how_does_it_work.html)
overloads `__bool__` and reruns), bytecode rewriting (Java
PathFinder), or an explicit `cond` API (the JAX `lax.cond` trade,
which users accept). When Amazon needed solver-aided test generation
from Java, [Iorek](https://dl.acm.org/doi/10.1145/3133915) (OOPSLA
2017) bridged JUnit through a solver-aided IR to a Rosette engine
rather than re-hosting. A mainstream-language *production evaluator*
remains a later, by-pull deliverable of this project, in the
Leanette/Rosette 4 pattern; it is not the project.

## Prior art, and what has never been assembled

"Rosette in Lean" has been tried in the sense that matters:
[Leanette](https://dl.acm.org/doi/10.1145/3498709) (Porncharoenwase,
Nelson, Wang, Torlak, POPL 2022) is a Lean reference evaluator for
Rosette's core language, proven correct against the concrete
semantics; Rosette 4 (Racket) was validated against it by solver-aided
differential testing
([artifact](https://github.com/uw-unsat/leanette-popl22-artifact)).
The Rosette authors built the Lean model and kept the user-facing
evaluator in Racket. Nobody has made the Lean side the thing users
write in, and nobody has published a reason not to.

The remaining pieces each exist in a different system:

- **Typed merging as a library** — Grisette (Haskell): explicit
  branching, union types, an ordered-guards normal form that cut
  constraint size five-fold against Rosette.
- **Write-once interpreter, two instances, soundness by logical
  relation** — [Katamaran](https://dl.acm.org/doi/10.1145/3547628)
  (Keuchel, Huyghebaert, Lukyanov, Devriese, ICFP 2022, Coq): the
  interpreter is written over a specification monad, instantiated
  concretely and symbolically, and the symbolic executor's soundness
  reduces to the shallow one's by a Kripke logical relation.
- **Verified term-to-SMT-LIB pipeline in Lean** — Cedar's
  [SymCC](https://github.com/cedar-policy/cedar-spec/tree/main/cedar-lean/Cedar/SymCC):
  `Term`/`TermType`, a hash-consed A-normal-form `Encoder`, a `Solver`
  that spawns cvc5 with `IO.Process.spawn` and speaks SMT-LIB text over
  stdin/stdout behind an `IO.FS.Stream`, a `Decoder` for cvc5's model
  output. The proofs cover the compiler to `Term`; the encoder is
  explicitly trusted.
- **Symbolic simulation as tactic-driven proof, no SMT-LIB** —
  [LNSym](https://github.com/leanprover/LNSym) (Arm machine code in
  Lean).

For the *use case* — semantics in, executor out — the competitors are
not Rosette but the semantics-first frameworks: the
[K framework](https://fsl.cs.illinois.edu/publications/chen-rosu-2019-setss.pdf)
(its founding claim; symbolic backend from any K definition),
[Isla](https://www.cl.cam.ac.uk/~pes20/isla/isla-cav2021-extended.pdf)
(CAV 2021: a symbolic engine derived from Sail ISA specifications, used
for Morello test generation), and HOL4P4's
[proof-producing symbolic execution for P4](https://link.springer.com/chapter/10.1007/978-3-031-86695-1_5)
(VSTTE 2024). Against that field the honest differentiators are:
generic over target languages (Isla and HOL4P4 are single-language); a
library in a mainstream prover (K is its own meta-language, no proof
export); dependent-width bitvectors; and verify answers that are
theorems rather than trust.

## Design

**Term layer.** Cedar-shaped, module for module: term datatype,
hash-consed ANF printer to SMT-LIB, cvc5 as a child process, model
decoder. SMT-LIB text is the only ABI. No SMT-LIB library exists on
Reservoir to reuse (smtlean is Lean 3); expect one to two thousand
lines, with the decoder as the part that costs debugging time (Cedar
assumes cvc5's single-line model format). The encoder is trusted at
first, as in Cedar.

**Symbolic monad.** Path condition plus store, a `branch` primitive,
ordered-guard merging in the Grisette style, and a `sym do` macro
layer so that inside the eDSL, branching reads as ordinary `if`. Lean's
macro system is the strongest outside Racket and `do` is itself a
macro layer, so this is the one design question the spike must answer.

**One interpreter, two instances.** The user's interpreter is written
over a value-algebra typeclass. The concrete instance is the normative
semantics; the symbolic instance is the executor. Soundness is one
lemma per operation, closed Katamaran-style.

**Two executor modes.** Merged (a DAG that joins state at every
control-flow join, Rosette's
[SVM](https://dl.acm.org/doi/10.1145/2594291.2594340) finding) for
verify queries; enumerated for test generation, where paths are
recovered as solver models over the merge guards with blocking clauses
rather than by walking a path tree.

**Closed loop.** A generated test's expected output comes from running
the *concrete* interpreter on the model's input, never from the model.
If that run leaves the claimed path, the encoder or the merge is wrong
— so every emitted test also audits the trusted encoder.

**Two checkers.** `bv_decide` inside Lean, with its LRAT-checked
certificate, for the pure bitvector fragment; SMT-LIB for anything that
needs models.

**Fragment.** First-order and finite: `BitVec n`, records, bounded
stacks, bounded loops under fuel. Coverage criteria, pruning,
deduplication and shrinking are framework features, because that is
where hand-rollers spend their time. Outside a declared finite fragment
"reads like a normal language" is a promise nobody has kept; inside
one it holds.

**Why Lean for the N-bit type.** On the strict test — width in the
type, `concat : BitVec n → BitVec m → BitVec (n+m)` checked without
ceremony — Lean has it in core (friction only at non-definitional
width equalities, a `BitVec.cast` justified by `omega`); Haskell gets it
with `KnownNat` plus the natnormalise plugin; C++ templates have always
had it; Rust cannot on stable (`generic_const_exprs` is unstable and,
per the
[2026 project goals](https://rust-lang.github.io/rust-project-goals/2026/const-generics.html),
without a stabilization path); Python, Racket and TypeScript check
widths at runtime or not at all. Lean is also the only host where a
runtime-known width is the same type, which matters for variable-length
extraction; SMT-LIB itself has only concrete widths, so symbolic-length
extraction is bounded and case-split in the encoder on every host.

## Naming

*Eprouvette* — French *éprouvette*, an English dictionary word without
the accent, pronounced ay-proo-VET. Five readings, one thesis:

- the `-ette` diminutive places it in the Rosette, Grisette, Leanette
  family, the solver-aided community's own naming line (Leanette is
  taken by the POPL 2022 artifact);
- literally "little tester": from *éprouver*, from Latin *probare*,
  the one root behind both *prove* and *probe* — verified test
  generation spelled out;
- a laboratory test tube, the instrument experiments are generated in;
- historically the
  [gunpowder tester](https://en.wikipedia.org/wiki/Eprouvette): a
  fixed mortar that fires a standard shot and measures the range — a
  tool that fires generated inputs at an implementation and measures
  what comes back;
- *épreuve*: test, ordeal, and a printer's proof.

Sweep (2026-09-08): two zero-star GitHub repositories by name, no
GitHub user or organization, free on crates.io, PyPI and npm, no
software product or company found by web search. Not swept: domains,
trademarks. Accepted tax: ten letters and poor spelling-by-ear
(hearers type "eprouvet" or "aprouvette"). Runner-up: *provetta*,
Italian test tube from the same root via *provare*, eight letters and
easier to spell, but the GitHub user is taken and the `-etta` echoes
the family without joining it (Italian *provetto*, "skilled", is a
homograph from *provectus*, not the same root). Rejected: *proverka*
(a common Russian word, a thousand repositories), *abtast* (one letter
from the AB Tasty product), *dokime* (PyPI taken, a starred project),
and the boring descriptive benchmark *semtest*, taken on every
registry — which is also the evidence that the descriptive lane is
crowded. The earlier working name SMarTy was dropped: *Smarty* is a PHP
template engine with the domain and the GitHub organization since
2000.

## Plan

1. One-week spike: term layer, monad, `sym do`, run against the
   examples of the Rosette guide's essentials chapter. Read the
   Leanette artifact for reusable code and its license.
2. Demonstrator: port two or three of Rosette's sample solver-aided
   DSLs and a slice of the Rosette 4 / Grisette benchmark set, plus one
   apples-to-apples baseline against an open hand-written symbolic
   executor in lines of code, paths found and time — p4pktgen's parser
   subset is the cleanest candidate.
3. Proof of the symbolic evaluator against the concrete semantics for
   the core.
4. `bv_decide` as the checked backend, so verify returns a theorem.
5. Name lock and public repository.

Open: whether to prove the encoder rather than trust it (giving
`Term` an SMT-LIB semantics in Lean and relating the printer to it —
unattempted anywhere, and a second project); how far the `sym do`
macro can go before loops stop reading like loops; and where the
spec-first audience — the Cedar and ISA-vendor pattern, where the
semantics is already the normative artifact and a free test generator
is the reason to write it formally — actually is beyond those two
cases. People who hand-write symbolic executors in Python will not move
to Lean for ergonomics alone; the pitch is to projects for which the
spec is the product and the generated vectors are how it earns its
keep against an implementation.
