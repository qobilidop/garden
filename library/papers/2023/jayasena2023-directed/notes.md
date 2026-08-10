---
citekey: jayasena2023-directed
work:
  title: "Directed Test Generation for Hardware Validation: A Survey"
  author: Aruna Jayasena, Prabhat Mishra
  venue: "ACM Computing Surveys 56(5), 1–36"
  date: 2023-12-19 # first public appearance; Crossref records formal online publication on 2024-01-12
  doi: 10.1145/3638046
sources:
  pdf: https://www.cise.ufl.edu/research/cad/Publications/csur23.pdf # author-hosted ACM-formatted manuscript; publisher PDF was OA but bot-gated during capture
  html: https://dl.acm.org/doi/10.1145/3638046
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-10
synthesis: "Directed hardware testing is best understood as a target-and-contract layer spanning formal, concolic, statistical, learning, constrained-random, and ATPG mechanisms; this survey maps that breadth well, but its search method and family-level tradeoff ratings are not reproducible measurements."
---

# Directed Test Generation for Hardware Validation: A Survey

A hardware-validation survey that organizes automated directed testing along
three coupled dimensions: how a test is generated, how it crosses design
abstraction levels, and which validation contract it serves. Jayasena and
Mishra position formal methods, concolic testing, statistical techniques,
machine learning, constrained-random generation, and ATPG as six mechanism
families, then follow their tests through specification, TLM, RTL, gate-level,
and silicon settings. The resulting map is unusually broad and clearly
illustrated. It is a useful orientation and bibliography, but not a
reproducible systematic review: its methodology describes the taxonomy and
paper structure without reporting searches, selection criteria, screening, or
study-quality assessment.

## Directedness is a relation to a target

The paper's most durable conceptual move is to define the space around the
scenario a test is intended to activate rather than around one implementation
technology. Random simulation cheaply covers common behaviors; a directed
method spends analysis or generation effort on a remaining branch, state,
property, fault, trigger, side-channel condition, or physical effect. What
counts as a good test therefore depends on both the target and the observer.

That framing prevents “directed test generation” from becoming a synonym for
symbolic execution. A model checker can turn a negated property's
counterexample into a test. A concolic engine can invert path constraints. A
statistical or learned heuristic can raise the probability of a rare trigger.
Constrained-random generation can bias a legal input distribution, while ATPG
can repurpose a fault model to activate a security-relevant net. The methods
produce similar-looking test vectors but license different claims: bounded
reachability, path feasibility, higher empirical coverage, or merely an
improved activation probability.

The authors evaluate the families through coverage, scalability, and overall
effort. Their discussion correctly insists that test-generation cost alone is
misleading: random generation is nearly free but can require enormous
simulation budgets, whereas an expensive directed test may eliminate many
runs. Hardware coverage is also not reducible to software-style line coverage,
because concurrent machines can exercise every line without covering the
interactions that matter.

## Concolic execution occupies a middle, not the whole map

The concolic section gives a compact lineage from coverage-directed symbolic
techniques through STAR, HYBRO, symbolic-state caching, trace-based constraint
generation, and target-directed search. Its common loop is concrete
simulation, path recording, alternate-path selection, constraint solving, and
rerun. The recurring scaling lever is not “use an SMT solver” but choose which
path or target deserves a query and reuse what earlier runs learned.

Several distinctions matter for [[symbolic-execution]]. STAR symbolically
replays an RTL path observed in simulation; HYBRO prioritizes uncovered
branches; later systems cache symbolic states, slice dependencies, avoid
repeated branches, rank distance to one target, or cluster multiple targets.
The survey thus places hardware concolic execution beside formal
counterexample generation and probabilistic test search rather than treating
all solver-backed validation as one technique.

The comparison is descriptive rather than controlled. Reported coverage and
speedups come from different underlying papers, artifacts, benchmarks,
targets, and baselines. Tables that label one framework's coverage “low,”
“medium,” or “high” help navigation, but they cannot establish a performance
ordering without a common experimental contract.

## Translation is part of the verification claim

Figure 4 makes test translation a first-class stage between generation and
validation. A test may be cheaper to generate against a SystemC/TLM or other
high-level specification, but applying it to RTL requires explicit timing,
interface, and refinement information. Conversely, abstracting a faulty RTL
design to accelerate generation risks carrying the wrong behavior upward.

The surveyed TLM-to-RTL approaches use refinement specifications,
transaction-to-phase mappings, or RTL-derived observability constraints to
bridge this gap. Reported acceleration can be substantial, but the semantic
bridge—not the high-level generator alone—determines whether the low-level
test still reaches the intended behavior. This is the same contract problem
that appears when symbolic execution runs a Verilator-produced software model:
the result depends on translation and harness fidelity as well as solver
correctness.

## One test object serves incompatible validation contracts

The use-case half of the paper ranges further than most surveys of symbolic
execution. Pre-silicon applications target branch, FSM, processor, memory, and
assertion coverage. Post-silicon tests must additionally expose effects at
observable signals, reduce error-detection latency, or localize a fault with
limited traces. Security tests activate rare Trojan triggers or maximize a
side-channel distinction. Non-functional tests seek timing, thermal, energy,
or peak-power scenarios.

This breadth is useful precisely because it defeats a single metric. A test
that increases RTL branch coverage may be useless after fabrication if its
effect never reaches a trace buffer. A Trojan-activation test can improve
trigger coverage without proving the absence of an implant. A bounded-model
counterexample can guarantee activation within its encoded model while saying
nothing about a cross-level translation. “Directed” identifies intent, not
the strength of the result.

## The final comparison is an expert heuristic

Figure 24 plots the six method families on 1–5 axes for coverage, scalability,
and generation effort and colors them by “guarantee.” It communicates the
authors' high-level synthesis effectively: formal methods trade scalability
and effort for stronger guarantees, while simulation-oriented families move
toward scale with weaker mathematical confidence. Yet the paper supplies no
coding rubric, extracted study-level data, uncertainty, or sensitivity
analysis for these coordinates. The plot should be read as expert orientation,
not as a meta-analysis or a measurement that can support fine-grained ranking.

The same limitation applies to the paper's industrial-adoption conclusion.
The authors plausibly identify tool variety, domain-specific requirements,
and the simplicity of established random and constrained-random workflows as
barriers, then call for usability and interoperability. They do not present
industrial interviews or adoption data that would separate those causes.

## Assessment

- **Durable:** separating generation mechanism, abstraction translation, and
  validation use case; treating total validation effort rather than generator
  runtime as the cost; and positioning concolic execution as one mechanism in
  a wider target-driven ecosystem.
- **Era-bound:** the individual tool coverage, speedup, and scalability
  reports; the 2023 boundary of the bibliography; and the relative placement
  of machine-learning, fuzzing, solver, and ATPG systems as implementations
  evolve.
- **Weaknesses:** the paper reports no reproducible literature-search or
  screening protocol, carries heterogeneous primary-study claims into broad
  comparison tables, and gives no derivation for Figure 24's numerical
  ratings. “Comprehensive” describes topical breadth, not demonstrated search
  completeness.
- **Against the library:** [[baldoni2016-symbolic]] supplies the software-side
  execution taxonomy; [[yang2026-forbench]] shows one modern hardware
  symbolic-simulation design in depth; and [[symbolic-execution-hardware]]
  narrows the question to operational symbolic execution of digital designs
  with an explicit systematic-map record. This paper is the adjacent field
  map that explains where symbolic and concolic systems sit among other ways
  to generate hardware tests.

The paper is most valuable as a map of contracts. It shows why asking only
“which test-generation technique is best?” is underspecified: the answer
depends on the artifact, target, observer, semantic bridge, and strength of
evidence the test is supposed to provide.
