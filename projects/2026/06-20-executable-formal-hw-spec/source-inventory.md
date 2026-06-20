# Source inventory

The reading list and the rows of the Part II comparison table. One entry per system. Fill the load-bearing cells (model of computation · nondeterminism · derived artifacts) *as you read* — the stubs are the reading checklist.

Tight pass: 2–3 canonical systems per lineage. Widen later on request.

Status legend: `candidate` (not yet confirmed in scope) · `reading` · `done`.

<!--
Entry template:

### {System}  — status: candidate
- Canonical refs:
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:
-->

## ADLs

**Scope caveat:** ADLs are the closest direct lineage to "Sail, generalized," but most were built to *generate tooling* (simulators, compilers, assemblers), not to be *formal*. Many strain claim #1 (rigorous semantics). The survey question for this bucket: which ADLs, if any, have semantics rigorous enough to count as formal — or did formality only arrive later with Sail?

### nML — status: candidate
- Canonical refs: Fauth, Van Praet, Freericks, "Describing Instruction Set Processors Using nML" (EDTC 1995). Basis of CHESS / Target / Synopsys ASIP Designer.
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

### LISA — status: candidate
- Canonical refs: Hoffmann, Meyr, Leupers et al. (RWTH Aachen), LISA methodology for ASIPs (~2001); commercialized as Synopsys Processor Designer.
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

### ArchC — status: candidate
- Canonical refs: Rigo, Araujo et al. (UNICAMP), "ArchC: A SystemC-Based Architecture Description Language" (SBAC-PAD 2004). Open-source, SystemC-based.
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

## Synchronous languages

**Scope note:** the strongest fit for *non-processor*, formally-defined hardware specs — declarative, rigorous semantics, not ISA-bound. The bucket that most tests "beyond run-to-completion CPUs."

### Lustre — status: candidate
- Canonical refs: Caspi, Pilaud, Halbwachs, Plaice, "LUSTRE: a declarative language for programming synchronous systems" (POPL 1987). Industrialized as SCADE (DO-178C certified).
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

### Esterel — status: candidate
- Canonical refs: Berry & Gonthier, "The Esterel synchronous programming language: design, semantics, implementation" (Science of Computer Programming 1992).
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

### Signal — status: candidate
- Canonical refs: Le Guernic, Gautier, Le Borgne, Le Maire, "Programming real-time applications with SIGNAL" (Proc. IEEE 1991). Polychronous (multi-clock).
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

## Rigorous architecture / ISA semantics

**Scope note:** the north-star bucket. Cleanly all three claims, but ISA-centric by construction — the reference point against which "does it generalize?" is measured.

### Sail — status: candidate
- Canonical refs: Armstrong, Bauereiss, Campbell, ... Sewell, "ISA Semantics for ARMv8-A, RISC-V, and CHERI-MIPS" (POPL 2019). REMS project, Cambridge.
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

### ARM ASL — status: candidate
- Canonical refs: Reid, "Trustworthy Specifications of ARM v8-A and v8-M System Level Architecture" (FMCAD 2016). ARM's internal Architecture Specification Language; basis of the machine-readable ARM spec.
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

### L3 — status: candidate
- Canonical refs: Fox, "Directions in ISA Specification" (ITP 2012); "Trustworthy and accurate ISA specifications" lineage. The direct predecessor to Sail — instructive for *why* Sail's design choices were made.
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

## Mechanized hardware semantics (spec boundary)

**Scope caveat:** these are *design* languages with rigorous semantics, so they strain claim #3 (spec altitude, not implementation). Included because the boundary is exactly the interesting part: guarded-atomic-action / rule-based semantics are high-level and oracle-like, and Kami/Kôika are explicitly about *specification and modular verification*. The survey question: where does "spec" end and "design" begin here?

### Bluespec — status: candidate
- Canonical refs: Nikhil, "Bluespec System Verilog: efficient, correct RTL from high level specifications" (MEMOCODE 2004); Hoe & Arvind, guarded atomic actions / term-rewriting-system semantics.
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

### Kami — status: candidate
- Canonical refs: Choi, Vijayaraghavan, Sherman, Chlipala, Arvind, "Kami: a platform for high-level parametric hardware specification and its modular verification" (ICFP 2017). Coq.
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:

### Kôika — status: candidate
- Canonical refs: Bourgeat, Pit-Claudel, Chlipala, Arvind, "The essence of Bluespec: a core language for rule-based hardware design" (PLDI 2020). Coq; deterministic one-rule-at-a-time semantics with verified compilation.
- Model of computation:
- Nondeterminism / underspecification:
- Derived artifacts / backends:
- Semantic foundation:
- Domain & authority:
- Notes / verdict:
