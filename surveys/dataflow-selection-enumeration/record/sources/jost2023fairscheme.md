---
citekey: jost2023fairscheme
work:
  title: "Implementing a Functional Logic Programming Language via the Fair Scheme"
  author: "Andrew Michael Jost"
  venue: "PhD dissertation, Portland State University"
  date: 2023
  doi: 10.15760/etd.3564
read: full-text
source: "Portland State University dissertation via https://doi.org/10.15760/etd.3564 (repository record: https://pdxscholar.library.pdx.edu/open_access_etds/6419/), 254 pages"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "The Fair Scheme's latest full formalization: sound, complete, optimal narrowing via sparse demand-populated fingerprints — establishing fingerprints and fair scheduling as prior art the survey's duplicate-free enumeration and guarded meta-encoding claims must be proven against"
---

# Implementing a Functional Logic Programming Language via the Fair Scheme

## Evidence

### Why it matters

The dissertation is the latest full formalization and implementation account of
the Fair Scheme. Its abstract calls the simple scheme sound, complete, and
optimal, and its implementation supports narrowing, constraints, equational
constraints, and set functions. It therefore must delimit rather than merely
decorate our functional-logic comparison.

The close overlap remains representational and operational. A runtime
configuration contains a graph expression, a fingerprint, constraint and
binding stores, and scan state. The fingerprint is a sparse record of demanded
choice decisions; the fair queue attempts to enumerate all values. What is
missing is deterministic-input partitioning and duplicate-free enumeration of
the fingerprint projection itself.

### Simple Fair Scheme

Chapter 3 formalizes finite acyclic LOIS graph-rewrite systems. The dispatcher
maintains a queue of live computations and rotates after each finite step. A
choice-rooted task forks, a value is yielded, a failure or inconsistent task is
discarded, and every live task is eventually scheduled.

Definition 3.4.1 makes demand semantic: a node is needed when every derivation
of the surrounding expression to constructor-rooted form must derive the node
to constructor-rooted form. This does not identify a minimum support of the
eventual value, and it is not the same relation as deterministic enabled
reachability from requested roots.

### Formal theorems

**Theorem 3.4.7** imports Antoy's pull-tabbing correctness theorem: consistent
rewriting before and after a choice-free pull-tabbing derivation has the same
constructor values modulo node renaming.

**Theorem 3.4.10 (Correctness of the Fair Scheme)** repeats the two-sided
per-state value-preservation statement of the 2013 paper. From every state of
the simulated computation, every source value remains consistently reachable,
and every consistently reachable value is a source value. It does not explicitly
quantify over an emitted fingerprint sequence or prove exactly-once output.

**Theorem 3.4.12 (Optimality)** proves that `S(e)` performs one replacement at
a needed node and that a needed rewrite to failure establishes failure. The
text immediately clarifies that taking only needed steps need not give the
shortest derivation. “Optimal” is therefore a local semantic necessity result.

Chapter 7 demonstrates examples where Sprite's queue finds values hidden by
diverging alternatives in KiCS2 and PAKCS. This is strong operational evidence
for fairness. The dissertation calls the scheme complete, but the displayed
correctness theorem remains the per-state existential result rather than a
separate formal liveness or duplicate-free enumeration theorem.

### Extensions and proof boundary

Chapter 4 adds lazy free-variable instantiation (`FS-x`), equational constraints
(`FS-beta`), and set functions (`FS-S`). It explicitly states that extending the
Chapter 3 proofs to a richer formalism would be a significant undertaking
beyond the dissertation's scope; each extension receives an informal argument.
Consequently, the formal theorems cover the simple ground LOIS scheme, not the
entire full-featured Sprite implementation.

Generator expressions assign fresh choice IDs to constructor alternatives. A
generator plus a fingerprint determines whether a free variable has a binding.
Constraint stores additionally correlate identifiers. This is close to symbolic
input generation, but the generated choices range over program values and may
be infinite; they do not yield formulas describing exact concrete-input fibers.

### Concrete fingerprint representation

Chapter 5 describes a runtime configuration containing an expression,
fingerprint, constraint store, binding store, and scan state. A fingerprint is
initially empty. Forking `a ?i b` extends child configurations with `i -> left`
and `i -> right`; a contradictory child is not created.

Sprite represents fingerprints as segmented copy-on-write trees. Leaves pack
choice outcomes into bits; branches are reference-counted and shared. Forking
copies a root pointer, while insertion copies only shared nodes along a path.
The dissertation provides this engineering rationale but no asymptotic bound
for total configurations, fingerprint growth, delay, or emitted values.

### Evidence locations

- Chapter 2.3.1, pp. 57–61: equivalent representations of nondeterminism.
- Chapter 3.2.2, pp. 96–100: choice identifiers and consistent computation.
- Chapter 3.3, pp. 101–105: dispatch queue and target procedures.
- Chapter 3.4, pp. 105–118: need, value preservation, and optimality theorems.
- Chapter 4 introduction, pp. 121–122: explicit informal-proof boundary for
  the extensions.
- Chapter 4.1, pp. 133–139: generator choices and fingerprint-based bindings.
- Chapter 5.2, pp. 187–191: configurations and concrete fingerprint structure.
- Chapter 7.1, pp. 216–218: operational completeness examples and resource
  qualifications.

## Bearing on RQs

### Subsumed claims

- sparse demand-populated choice-ID/outcome maps;
- fair scheduling of shared graph-rewrite tasks;
- consistency across duplicated choices;
- constructor-value preservation for the simple scheme; and
- local needed-step optimality.

### Remaining distinctions

- deterministic selection sites rather than program nondeterminism;
- one unique observation per concrete input;
- exact positive-cylinder formulas for observation fibers;
- conflict-frontier and disjoint-partition properties;
- duplicate-free projected observation enumeration;
- stable context-qualified occurrence names across calls and inputs; and
- a formal correspondence respecting graph strictness and multi-way outcomes.

The dissertation therefore materially narrows our theory claim. It does not
collapse the input-fiber theorem, but any manuscript must treat fingerprints as
established prior art and prove the guarded meta-encoding rather than suggesting
that sparse observations are new.

## Evidence limits

- The theorem called correctness is not an exactly-once enumeration theorem.
- The full Curry extensions are not covered by the Chapter 3 formal proofs.
- Equal values may result from several fingerprints.
- Dynamic identifier allocation is not stable occurrence naming across inputs.
- The claimed practical completeness is necessarily resource-relative and has
  no delay or space bound.
