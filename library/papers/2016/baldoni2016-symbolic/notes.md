---
citekey: baldoni2016-symbolic
work:
  title: "A Survey of Symbolic Execution Techniques"
  author: Roberto Baldoni, Emilio Coppa, Daniele Cono D'Elia, Camil Demetrescu, Irene Finocchi
  venue: "ACM Computing Surveys 51(3), pp. 1–39"
  date: "2018-05-23"
  doi: 10.1145/3182657
  arxiv: 1610.00502v3 (v1 first appeared 2016-10-03; v3 author preprint aligned with ACM publication)
sources:
  pdf:  # arXiv v3 author preprint; title and authors match the DOI record
    url: https://arxiv.org/pdf/1610.00502v3
    archived: https://web.archive.org/web/20240603230103/https://arxiv.org/pdf/1610.00502v3
retrieved: 2026-08-09
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-09
synthesis: "Symbolic execution is an architecture of tradeoffs across execution mode, memory and environment models, path-space control, and solver strategy; practical engines move complexity between paths, formulas, models, and concretizations rather than eliminating it."
---

# A Survey of Symbolic Execution Techniques

A field survey that organizes four decades of [[symbolic-execution]] around
the design of an engine rather than around a chronology of tools. Baldoni et
al. begin from the classical state `(stmt, σ, π)`—the next statement, a
symbolic store, and path constraints—then trace the choices required to make
that ideal run on real software. Their durable contribution is the resulting
architecture: execution mode and search, memory, environment, path-space
control, and constraint solving are coupled design decisions. The treatment
is technically clear and unusually broad, but it is a narrative survey with
a 2017 literature horizon, not a systematic comparison of effectiveness.

## Symbolic execution is a configurable architecture

Classical symbolic execution forks at a branch and accumulates a constraint
for each resulting path. A solver determines whether the path is feasible and
can produce a concrete input that reaches a target state. This clean model is
only one point in a larger design space. The survey distinguishes:

- classical symbolic execution from concolic or dynamic symbolic execution,
  which lets a concrete run drive symbolic tracking, and selective execution,
  which changes modes across component boundaries;
- online engines, which keep multiple states alive, from offline engines,
  which repeatedly negate constraints from completed runs, plus hybrids;
- forward exploration from backward reasoning toward a target; and
- path selectors aimed at coverage, a target location, likely bugs, or
  diversity, with no universally best strategy.

These choices determine the guarantee. A concrete seed, an unmodeled call, a
concretized value, or a bounded search can make an otherwise systematic
procedure under-approximate the program. Search heuristics decide which
evidence appears before resources expire; they do not change the size of the
underlying space.

## Memory and environment are modeling decisions

A symbolic address makes both *where* to read and *what* is stored there
conditional. The survey lays out a spectrum rather than a preferred answer:
an executor can fork for each feasible address, build if-then-else formulas
or theory-of-arrays terms, concretize an address, model only selected regions,
or initialize heap objects lazily. Forking exposes alternatives as states;
formulas expose them to the solver; concretization and partial models give up
behaviors for tractability.

The same structure recurs at the software boundary. System calls, libraries,
callbacks, devices, and the filesystem can be executed concretely, replaced
with symbolic models, or explored in a virtualized environment. Concrete
execution is cheap but commits to one outcome. A model is reusable but only as
faithful as its author. Whole-system execution sees more of the stack but adds
state and implementation cost. “Running the program” therefore already
contains a modeling decision about which program and environment count.

## Path explosion has no single cure

The path-space section is the survey's conceptual center. Its techniques act
at different layers:

- feasibility checks and search policies avoid spending time on impossible
  or low-priority paths;
- loop and function summaries replace repeated execution with relations;
- subsumption, interpolation, equivalence, and abstraction try to recognize
  states whose future behavior need not be explored separately;
- under-constrained and preconditioned execution deliberately narrow or
  loosen the starting context;
- state merging replaces separate states with conditional expressions; and
- slicing, taint analysis, fuzzing, and compiler transformations reduce or
  reshape the program presented to the executor.

Each intervention changes a cost rather than abolishing it. In particular,
state merging reduces the number of scheduled states while producing larger
conditional formulas. An early or indiscriminate merge can make solver work
worse than exploring paths separately, so placement and similarity heuristics
matter. The right question is not simply whether to merge, but where
alternatives should live and which component can represent them cheaply.

That framing locates [[sen2015-multise]] and [[yang2026-forbench]] on a common
spectrum. MultiSE continuously factors paths into per-variable guarded values;
Forbench leaves RTL design branches inside symbolic expressions and forks at
testbench decisions. One merges after control has split and the other avoids
materializing many splits, but both exchange path count for expression and
solver structure.

## The solver boundary shapes the engine

Constraint solving is not a final black-box step. A solver's theories and
performance constrain which values can remain symbolic and therefore shape
the executor in front of it. The survey groups mitigation into reducing and
rewriting constraints, splitting independent formulas, caching answers across
related queries or runs, deciding whether queries are eager or deferred, and
concretizing expressions that are too expensive or unsupported.

Reuse is especially important because neighboring paths share most of their
constraints. But syntactic similarity is not semantic simplicity: a compact
merged formula may be harder than several small path formulas, while an
apparently expensive query may become trivial after rewriting. Solver-aware
state design is consequently part of the analysis algorithm, not just an
implementation optimization.

## Assessment

- **Durable:** the decomposition into execution strategy, memory,
  environment, path explosion, and solving remains a useful map. The survey
  is strongest when it shows that precision and cost move between these
  components and when it treats merging as a placement tradeoff.
- **Era-bound:** the exact tool inventory, solver-capability table, 742-title
  Google Scholar count from August 2017, and Cyber Grand Challenge framing
  describe the field at publication. The forward-looking discussion of
  separation logic, inferred invariants, summaries, program analysis, and
  symbolic computation should be read as a 2018 agenda.
- **Weaknesses:** no reproducible search, selection, or quality-assessment
  protocol is reported. Applications are placed in a separate appendix, and
  the survey does not quantitatively compare the effectiveness, cost, or
  reproducibility of the techniques it catalogs. Broad “state of the art”
  judgments are expert synthesis rather than protocol-derived findings.
- **Terminology caution:** the paper says *soundness* prevents false
  negatives and *completeness* prevents false positives. That is opposite the
  convention many logic and static-analysis readers expect. Its guarantees
  are best interpreted through the stated false-negative and false-positive
  behavior rather than through those labels alone.
- **Against the library:** MultiSE and Forbench validate the survey's central
  architectural lesson in different domains. Their representations move
  alternatives between paths and formulas; neither removes dependence on the
  harness, theory support, approximation policy, and resource bound.

The survey is best used as a design map. Practical symbolic execution does
not solve path explosion once: it repeatedly chooses which distinctions to
preserve, summarize, merge, concretize, or postpone, and pays for each choice
in a different part of the engine.
