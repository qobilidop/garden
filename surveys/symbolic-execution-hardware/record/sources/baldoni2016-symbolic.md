---
citekey: baldoni2016-symbolic
work:
  title: "A Survey of Symbolic Execution Techniques"
  author: "Roberto Baldoni, Emilio Coppa, Daniele Cono D'Elia, Camil Demetrescu, Irene Finocchi"
  venue: "ACM Computing Surveys 51(3)"
  date: 2018
  doi: 10.1145/3182657
  arxiv: 1610.00502v3
read: full-text
source: "Author preprint, https://arxiv.org/pdf/1610.00502v3"
canonical-note: library/papers/2016/baldoni2016-symbolic/notes.md
retrieved: 2026-08-09
notes-by: Codex GPT-5.6 Sol (survey adversarial revision)
notes-date: 2026-08-12
synthesis: "The software canon supplies the baseline state/path model and shows why search, memory, environment, merging, and solving must be reported as coupled choices; it is orientation evidence, not evidence about hardware semantics or this map's population."
---

# A Survey of Symbolic Execution Techniques

## Evidence

- Sections 2–3 define the classical execution state around a current
  statement, symbolic store, and path constraints, then distinguish classical,
  concolic/dynamic, selective, online, offline, forward, and backward execution.
- Sections 4–6 treat memory, environment, and path-space control as modeling
  choices. Forking, merging, summaries, subsumption, slicing, and
  concretization relocate precision and cost rather than removing them.
- The path-explosion and constraint-solving discussions explain why a smaller
  explicit state frontier may produce larger formulas or harder solver work.
  This supports the survey's four-ledger accounting lens as synthesis, not as a
  conservation theorem reported by Baldoni et al.

## Bearing on RQs

- **RQ1:** supplies the general symbolic-execution vocabulary against which the
  hardware-specific classical, concolic, and selective-hybrid regimes are
  defined.
- **RQ3:** supports separating explicit paths from formula size, summaries,
  concretization, and solver strategy when discussing path explosion.
- **RQ4:** shows that environment models, under-approximation, bounds, and
  concretization qualify what an execution result establishes.
- **Boundary:** it is a secondary software survey and therefore E7. Its
  definitions orient the operational test but do not count as a hardware-design
  symbolic-execution contribution.

## Evidence limits

The paper surveys software symbolic execution through a 2017 literature
horizon. It does not establish HDL concurrency, clock, reset, translation, or
hardware-harness claims, and it provides no denominator or effectiveness
estimate for the hardware literature mapped here.
