# Executable formal specifications of hardware — survey framing (draft)

*2026-06-20; consolidated 2026-07-03 from an earlier project directory into a
single parked draft. A snapshot of framing, scoping, and initial findings for
a possible future survey — no active work. If it resumes, it starts as a
proper project.*

A survey, for personal learning — and shared as a blog post in case it's
useful to others. Not aimed at academic publication.

## What this covers

Languages and systems for writing an **executable formal specification** of
hardware — a single-source-of-truth, machine-checkable definition of *intended
behavior* from which tooling (simulators, symbolic executors, proof artifacts)
is mechanically derived. Sail is the north star; the goal is the broad
landscape around it, not Sail alone.

Three claims define the scope. A system is in scope only if it is all three:

1. **Formal** — rigorous semantics, not prose.
2. **Executable** — runnable operational semantics, not just
   axiomatic/declarative properties.
3. **Spec altitude** — specifies intended behavior, abstracting
   microarchitecture. *Not* hardware design or implementation (excludes HLS
   and formally-specified synthesizable HDLs used as the build language).

Explicitly in scope to pull the field past its ISA-centric default: arbitrary
hardware / ASICs, not only run-to-completion CPUs.

## Two things the survey is really about

1. A single source of truth formal spec of hardware architecture.
2. Tooling mechanically derived from it (simulator, symbolic executor, proof
   definitions) — the Sail multi-backend value proposition.

## Structure

Hybrid — orient by lineage, then pay off by comparison. Neutral landscape
framing, not thesis-driven.

- **Part I — Lineage tour.** One short subsection per community, to orient.
- **Part II — Comparison.** Organized by **model of computation** (the spine),
  scoring each system on the load-bearing dimensions.
- **Part III — Synthesis.** What's mature, what's missing — the beyond-ISA gap.

### Comparison dimensions

Load-bearing (the columns every system gets scored on):

1. **Model of computation / time** — run-to-completion sequential ·
   synchronous-clocked · asynchronous/event-driven · dataflow/streaming. *The
   spine* — the axis that separates Sail's world from arbitrary ASICs.
2. **Nondeterminism & underspecification** — how the spec stays executable
   while permitting a *range* of legal behaviors (controlled nondeterminism,
   undefined/unspecified values, relaxed concurrency).
3. **Derived artifacts / backends** — concrete simulator · symbolic executor ·
   SMT · theorem-prover definitions · test/oracle generation · docs.

Secondary (descriptive):

4. **Semantic foundation** — operational vs. denotational vs. relational;
   mechanized in a prover vs. standalone semantics.
5. **Domain & authority** — ISA-only vs. programmable vs. general; academic
   prototype vs. normative industrial reference.

## Open tension

Keeping a spec executable without collapsing legitimate nondeterminism
(relaxed memory, unspecified bits) into one arbitrary choice. Sail uses
controlled nondeterminism; how this generalizes beyond ISAs is where the
interesting research likely lives.

## Candidate systems

A tight pass: 2–3 canonical systems per lineage, with canonical refs. (The
comparison-dimension cells were never filled — reading had not started.)

### ADLs

Scope caveat: ADLs are the closest direct lineage to "Sail, generalized," but
most were built to *generate tooling* (simulators, compilers, assemblers), not
to be *formal*. Many strain claim #1. The survey question for this bucket:
which ADLs, if any, have semantics rigorous enough to count as formal — or did
formality only arrive later with Sail?

- **nML** — Fauth, Van Praet, Freericks, "Describing Instruction Set
  Processors Using nML" (EDTC 1995). Basis of CHESS / Target / Synopsys ASIP
  Designer.
- **LISA** — Hoffmann, Meyr, Leupers et al. (RWTH Aachen), LISA methodology
  for ASIPs (~2001); commercialized as Synopsys Processor Designer.
- **ArchC** — Rigo, Araujo et al. (UNICAMP), "ArchC: A SystemC-Based
  Architecture Description Language" (SBAC-PAD 2004). Open-source,
  SystemC-based.

### Synchronous languages

Scope note: the strongest fit for *non-processor*, formally-defined hardware
specs — declarative, rigorous semantics, not ISA-bound. The bucket that most
tests "beyond run-to-completion CPUs."

- **Lustre** — Caspi, Pilaud, Halbwachs, Plaice, "LUSTRE: a declarative
  language for programming synchronous systems" (POPL 1987). Industrialized
  as SCADE (DO-178C certified).
- **Esterel** — Berry & Gonthier, "The Esterel synchronous programming
  language: design, semantics, implementation" (Science of Computer
  Programming 1992).
- **Signal** — Le Guernic, Gautier, Le Borgne, Le Maire, "Programming
  real-time applications with SIGNAL" (Proc. IEEE 1991). Polychronous
  (multi-clock).

### Rigorous architecture / ISA semantics

Scope note: the north-star bucket. Cleanly all three claims, but ISA-centric
by construction — the reference point against which "does it generalize?" is
measured.

- **Sail** — Armstrong, Bauereiss, Campbell, … Sewell, "ISA Semantics for
  ARMv8-A, RISC-V, and CHERI-MIPS" (POPL 2019). REMS project, Cambridge.
- **ARM ASL** — Reid, "Trustworthy Specifications of ARM v8-A and v8-M System
  Level Architecture" (FMCAD 2016). ARM's internal Architecture Specification
  Language; basis of the machine-readable ARM spec.
- **L3** — Fox, "Directions in ISA Specification" (ITP 2012). The direct
  predecessor to Sail — instructive for *why* Sail's design choices were made.

### Mechanized hardware semantics (spec boundary)

Scope caveat: these are *design* languages with rigorous semantics, so they
strain claim #3 (spec altitude). Included because the boundary is exactly the
interesting part: guarded-atomic-action / rule-based semantics are high-level
and oracle-like, and Kami/Kôika are explicitly about *specification and
modular verification*. The survey question: where does "spec" end and "design"
begin here?

- **Bluespec** — Nikhil, "Bluespec System Verilog: efficient, correct RTL from
  high level specifications" (MEMOCODE 2004); Hoe & Arvind, guarded atomic
  actions / term-rewriting-system semantics.
- **Kami** — Choi, Vijayaraghavan, Sherman, Chlipala, Arvind, "Kami: a
  platform for high-level parametric hardware specification and its modular
  verification" (ICFP 2017). Coq.
- **Kôika** — Bourgeat, Pit-Claudel, Chlipala, Arvind, "The essence of
  Bluespec: a core language for rule-based hardware design" (PLDI 2020). Coq;
  deterministic one-rule-at-a-time semantics with verified compilation.

## Prior surveys & related work

Gap-check run 2026-06-20 (web search). Bottom line: **no unifying
cross-lineage survey under this framing was found** — the gap holds. The
closest existing umbrella ("An Overview of Formal Hardware Specification
Languages") is ~2002, verification-framed, and predates executable ISA specs
entirely. Per-lineage surveys exist but stop at lineage boundaries. Items
found in that search are marked `[found 2026-06-20]`.

Naming-collision warning: "A Survey of Architecture Description Languages"
(Medvidovic & Taylor, IEEE, 1997/2000), AADL (SAE standard), and ISO/IEC/IEEE
42010 are all about **software/systems architecture** — a *different field*
that happens to share the "ADL" acronym. Not the processor/hardware ADLs (nML,
LISA) this survey means. Cite the Mishra & Dutt lineage, not the Medvidovic
lineage.

### ADLs — thoroughly surveyed

- Mishra & Dutt, *Processor Description Languages* (Morgan Kaufmann, 2008).
  Book-length survey.
- Mishra & Dutt, "Architecture Description Languages for Programmable Embedded
  Systems" (IEE Proceedings — Computers and Digital Techniques, 2005).
- Tomiyama, Halambi, Grun, Dutt, Nicolau, "Architecture Description Languages
  for Systems-on-Chip Design" (APCHDL, 1999).
- Qin & Malik, "Architecture Description Languages for Retargetable
  Compilation" — chapter in *The Compiler Design Handbook* (2002).

### Synchronous languages — well-mapped

- Benveniste, Caspi, Edwards, Halbwachs, Le Guernic & de Simone, **"The
  Synchronous Languages 12 Years Later"** (Proceedings of the IEEE, 2003). The
  canonical survey.
- Halbwachs, *Synchronous Programming of Reactive Systems* (Kluwer, 1993).
  Book.

### Formal hardware specification languages — the closest existing umbrella

- **"An Overview of Formal Hardware Specification Languages"**
  `[found 2026-06-20]` — a taxonomy of formal HW spec languages aimed at
  standard-compliance verification. Circa 2002, verification-framed, predates
  Sail / executable ISA specs entirely. The closest thing to this project's
  umbrella that exists — but stale and on a different axis (verification, not
  the spec→derived-tooling story). Worth reading as "the last time someone
  tried the umbrella, and what's changed since."
- Chen, **"A Short Historical Survey of Functional Hardware Languages"** (ISRN
  Electronics, 2012) `[found 2026-06-20]` — functional HW languages (Lava,
  ReWire, Clash lineage). Adjacent: clean-semantics functional descriptions;
  some sit near the spec boundary.

### Formal hardware verification — adjacent, not the topic

These survey the *consumer* of specs (proving designs correct), not executable
specification itself. Useful for framing the boundary.

- Kern & Greenstreet, "Formal Verification in Hardware Design: A Survey" (ACM
  TODAES, 1999).
- Gupta, "Formal Hardware Verification Methods: A Survey" (Formal Methods in
  System Design, 1992).
- Garavel, ter Beek & van de Pol, "The 2020 Expert Survey on Formal Methods"
  `[found 2026-06-20]` — broad formal-methods landscape; context, not specific
  to HW spec.

### Executable formal ISA specification — no dedicated survey found

Confirmed by the 2026-06-20 search: no standalone survey. Knowledge lives in
related-work sections of primary papers, and the field is *active* (these are
primary works, not surveys, but anchor the related work):

- Armstrong et al. (Sail), POPL 2019 — related-work section.
- Reid, ASL papers (FMCAD 2016 and follow-ups); ASL formal-semantics tutorial
  at POPL 2024 `[found 2026-06-20]`.
- Dasgupta et al., "A Complete Formal Semantics of x86-64 User-Level ISA"
  (PLDI 2019) `[found 2026-06-20]`.
- "A Complete Formal Semantics of eBPF ISA for Solana" (PACMPL 2025,
  Isabelle/HOL) `[found 2026-06-20]`.
- "Accurate and Extensible Symbolic Execution of Binary Code based on Formal
  ISA Semantics" (arXiv 2404.04132, 2024) `[found 2026-06-20]` — directly the
  spec→symbolic-executor derived-artifact story.
- "The Simulation Semantics of Synthesisable Verilog" (arXiv 2502.19348, 2025)
  `[found 2026-06-20]`.

### The cross-lineage synthesis — confirmed gap

No survey draws the boundary this project draws: ADLs + synchronous +
ISA-semantics + mechanized-HDL, compared across the model-of-computation
spine. The per-silo surveys exist; the cross-silo comparison is the gap. (As
confirmed as a negative can be at this search depth — absence of evidence, not
proof.)
