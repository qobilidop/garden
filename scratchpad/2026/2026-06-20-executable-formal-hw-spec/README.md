# Executable formal specifications of hardware

A survey, for personal learning — and shared as a blog post in case it's useful to others. Not aimed at academic publication.

Started 2026-06-20.

## What this covers

Languages and systems for writing an **executable formal specification** of hardware — a single-source-of-truth, machine-checkable definition of *intended behavior* from which tooling (simulators, symbolic executors, proof artifacts) is mechanically derived. Sail is the north star; the goal is the broad landscape around it, not Sail alone.

Three claims define the scope. A system is in scope only if it is all three:

1. **Formal** — rigorous semantics, not prose.
2. **Executable** — runnable operational semantics, not just axiomatic/declarative properties.
3. **Spec altitude** — specifies intended behavior, abstracting microarchitecture. *Not* hardware design or implementation (excludes HLS and formally-specified synthesizable HDLs used as the build language).

Explicitly in scope to pull the field past its ISA-centric default: arbitrary hardware / ASICs, not only run-to-completion CPUs.

## Two things the survey is really about

1. A single source of truth formal spec of hardware architecture.
2. Tooling mechanically derived from it (simulator, symbolic executor, proof definitions) — the Sail multi-backend value proposition.

## Structure

Hybrid — orient by lineage, then pay off by comparison. Neutral landscape framing, not thesis-driven.

- **Part I — Lineage tour.** One short subsection per community, to orient.
- **Part II — Comparison.** Organized by **model of computation** (the spine), scoring each system on the load-bearing dimensions.
- **Part III — Synthesis.** What's mature, what's missing — the beyond-ISA gap.

### Comparison dimensions

Load-bearing (the columns every system gets scored on):

1. **Model of computation / time** — run-to-completion sequential · synchronous-clocked · asynchronous/event-driven · dataflow/streaming. *The spine* — the axis that separates Sail's world from arbitrary ASICs.
2. **Nondeterminism & underspecification** — how the spec stays executable while permitting a *range* of legal behaviors (controlled nondeterminism, undefined/unspecified values, relaxed concurrency).
3. **Derived artifacts / backends** — concrete simulator · symbolic executor · SMT · theorem-prover definitions · test/oracle generation · docs.

Secondary (descriptive):

4. **Semantic foundation** — operational vs. denotational vs. relational; mechanized in a prover vs. standalone semantics.
5. **Domain & authority** — ISA-only vs. programmable vs. general; academic prototype vs. normative industrial reference.

## Lineages to cover

- Architecture description languages (ADLs): nML, LISA, EXPRESSION, ArchC, …
- Synchronous languages: Lustre, Esterel, Signal / SCADE, …
- Rigorous architecture / ISA semantics: Sail (REMS), ARM ASL, …
- Mechanized hardware semantics at the spec boundary: Kami, Kôika, Bluespec, …

## Open tension to track

Keeping a spec executable without collapsing legitimate nondeterminism (relaxed memory, unspecified bits) into one arbitrary choice. Sail uses controlled nondeterminism; how this generalizes beyond ISAs is where the interesting research likely lives.

## Status

- [x] Scope, framing, structure, dimensions locked.
- [~] Source inventory — tight candidate list drafted (12 systems, see `source-inventory.md`); pending your prune.
- [ ] Reading — fill the load-bearing cells per system.
- [ ] Draft Parts I–III.
- [x] Prior-survey gap-check (2026-06-20) — no unifying survey under this framing; see `prior-surveys.md`.
- [ ] Gap-check pass on the *system* inventory (find blind-spot systems, not to substitute reading).

## Output

When it converges, publish as a dated note (blog post), or graduate to its own repo if it outgrows this folder.
