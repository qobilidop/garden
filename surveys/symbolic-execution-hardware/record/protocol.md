# Survey protocol

This file records only choices specific to this survey. The current
`run-survey` skill is canonical for shared search, screening, snowballing,
logging, evidence, update, and bounded-closure procedure. Local commands and
file ownership are in `README.md`; current state is in `status.md`; event
history is in `log.tsv`; current interpretation is in `syntheses/`.

## Objective and study type

Build an updatable systematic map and critical survey of symbolic execution of
digital hardware designs. The survey traces the literature without a
domain-specific historical cutoff, centers register-transfer-level (RTL)
designs, and admits other
hardware description languages (HDLs), high-level synthesis (HLS) models, and
cross-level executable models when a digital hardware design is itself a
symbolic participant.

The survey treats *symbolic execution* as the core genre. Symbolic simulation
and symbolic trajectory evaluation (STE) enter selectively as intellectual
roots or direct comparators, not as comprehensive secondary corpora. The map
makes no formal risk-of-bias appraisal and no claim to cover formal hardware
verification generally.

The user approved the title, scope, RTL center, absence of a domain-specific
historical cutoff, and autonomous execution through manuscript, commit, and
push on 2026-08-10.
That approval is the protocol gate; later material method changes are logged in
`status.md` before they are applied.

## Research questions

- **RQ1:** Vocabulary and lineage — How have symbolic execution, concolic
  execution, symbolic simulation, and STE been distinguished and connected in
  work on digital hardware designs?
- **RQ2:** Executed artifact — Which design representations are executed — RTL,
  other HDLs, HLS or behavioral models, SystemC/TLM, netlists, or coupled
  cross-level models — and how are hardware concurrency and clocked state
  represented?
- **RQ3:** Alternatives and scaling — Where do alternative behaviors live —
  separate paths, path fragments, symbolic expressions, abstract states, or
  concrete/symbolic hybrids — and which mechanisms control their growth?
- **RQ4:** Verification contract — Which goals are served, what witnesses or
  proofs are produced, and what bounds, approximations, environmental models,
  or harness assumptions qualify the result?
- **RQ5:** Evidence — How are systems evaluated with respect to design scale,
  temporal depth, coverage, solver work, defects, reproducibility, and
  comparison baselines?

## Scope and discovery choices

- **Window:** no domain-specific historical cutoff; APIs are queried from
  1900, before the digital-hardware literature relevant to this survey, and
  searches close at 2026-08-10. Works first surfaced after that date belong to
  a future update.
- **Language:** English-language title and abstract metadata; a non-English
  work can remain `parked` if its scope cannot be established reliably.
- **Sources:** OpenAlex, Crossref, Semantic Scholar, and arXiv, supplemented by
  backward and forward citation chasing and primary bibliographies. Exact
  standing searches, source-native syntax, limits, and reconciliation dates
  live only in `queries.tsv`.
- **Depth:** standing searches are relevance-ranked and capped as declared in
  `queries.tsv`. The catalog is bounded by those sources, queries, depths, and
  the closing date.
- **Terminology expansion:** discovery searches include *symbolic execution*,
  *concolic*, *symbolic simulation*, and *symbolic trajectory evaluation*.
  Inclusion is decided by mechanism and relationship to the core, never by a
  title token alone.
- **HDL/HLS interpretation:** Verilog, SystemVerilog, VHDL, Chisel, Bluespec,
  SystemC, HLS source or IR, and generated executable models are admissible.
  A language or synthesis paper enters only when symbolic execution of the
  represented or generated hardware is a central contribution.
- **Defective bibliographies:** an empty, truncated, or implausibly incomplete
  citation-index bibliography is replaced by the primary version's printed or
  publisher-deposited references and marked `primary-complete` in `log.tsv`.

## Selection boundaries

Include a peer-reviewed work, dissertation, substantial technical report, or
preprint when its central method operationally executes a digital hardware
design over symbolic values, states, traces, or path conditions and produces
verification evidence such as a witness, test, coverage result, invariant, or
bounded proof result.

A work is **core** when it self-identifies as symbolic or concolic execution,
or when its operational mechanism explicitly distinguishes feasible
path-conditioned hardware behaviors in the same sense despite different
terminology. A **lineage** work is included selectively when it defines a
symbolic-simulation or STE mechanism directly inherited, repeatedly cited, or
used as a baseline by critical core works. A **comparator** is included only
when a close mechanism is needed to state a boundary or evaluate a central
claim. Citation alone does not confer inclusion.

Hardware/software and cross-level work is included only when a hardware model
participates symbolically. Symbolic execution of firmware or binaries running
on an otherwise concrete or emulated platform is not hardware symbolic
execution for this survey.

This survey declares these exclusion codes:

- `E1-software-or-firmware-only` — the symbolically executed object is software
  or firmware and no hardware design model participates symbolically;
- `E2-formal-hardware-without-execution` — BMC, model checking, theorem proving,
  equivalence checking, SAT/SMT solving, or information-flow analysis without
  a load-bearing operational symbolic-execution or selected-lineage mechanism;
- `E3-symbolic-simulation-outside-lineage` — symbolic simulation or STE that is
  neither a defining ancestor, direct comparator, nor mechanism reused by the
  core corpus;
- `E4-analog-physical-or-postsilicon` — analog/mixed-signal modeling, physical
  timing or manufacturing analysis, post-silicon testing, or fault simulation
  without a qualifying digital-design execution mechanism;
- `E5-hardware-accelerates-software` — hardware merely accelerates or hosts
  symbolic execution of software;
- `E6-out-of-scope-artifact` — quantum circuits, network/protocol models,
  dataflow programs, or another non-digital-hardware meaning of circuit,
  execution, or simulation;
- `E7-secondary-or-insubstantial` — secondary literature, tutorials, posters,
  extended abstracts, or other records without a primary technical
  contribution; selected secondary works may still support related-work
  orientation outside the map denominator;
- `E8-duplicate-or-superseded` — duplicate metadata record or superseded
  version retained for auditability; and
- `E9-retracted-or-withdrawn` — formally retracted or withdrawn.

Undecidable candidates take `parked` and are re-screened on update. A Verilated
RTL model executed by KLEE is in scope because the generated software remains
the operational representation of a hardware design; a firmware binary
executed by KLEE against concrete peripherals is E1. An HLS compiler verified
only by equivalence checking is E2; symbolic execution of its generated circuit
or source-to-hardware execution relation can enter.

## Taxonomy and coding

Every include carries one abstract-level primary value per facet. Full-text
note facets are authoritative for the individual work but do not silently
rewrite the abstract-level map.

- **Relation:** `core|lineage|comparator` as defined above.
- **Artifact:** `rtl|hdl-other|hls|systemc-tlm|gate-netlist|mixed-level|generic`.
  `rtl` includes Verilog, SystemVerilog, and generated RTL; `hdl-other` covers
  executable digital HDLs not more specifically classified; `generic` is used
  only when the method is hardware-specific but representation-independent.
- **Execution:** `path|concolic|fragment|symbolic-simulation|ste|hybrid`.
  `hybrid` takes precedence when concrete simulation, fuzzing, or another
  exploration engine is co-equal with symbolic execution; `fragment` denotes
  explicit compositional path fragments rather than ordinary path search.
- **Goal:** `functional|test-coverage|security|equivalence|method-general`.
  Use the evaluated or stated primary end goal, not every possible use.
- **Evidence:** `experiment|case-study|formal-only|none`. `experiment` requires
  multi-design or comparative quantitative evaluation; `case-study` is a
  bounded demonstration on one principal design family.
- **Priority:** `critical|high|medium|low`. `critical` is the bounded set of
  closest or load-bearing works that must be deep-read and chased in both
  directions.

## Survey-specific record choices

- The scrutiny scale is `candidate`, `screened`, `included`, `deep-read`,
  `excluded`, and `parked`. `included + deep-read` is the include-level map;
  only `deep-read` requires a full local or explicitly exempt external source
  note.
- The catalog retains a concise item-specific adjudication rationale. Screening
  decisions must be judgments from the record's title and abstract or primary
  text, never keyword classifiers.
- Existing canonical evidence notes in `library/` or another survey may serve
  as citation-closure exemptions named in the record README and validator;
  their evidence is not duplicated locally.
- The systematic map may publish a dated bounded snapshot without claiming
  bounded mapping closure. Closure, if reached, uses the stronger shared skill
  criteria and is stated relative to the exact sources, queries, depths, and
  date.

## Publication qualifications

Counts derive only from `catalog.tsv`. Technical claims derive from full-text
evidence notes with pinpoint anchors. Abstract-only records support scope,
terminology, and chronology only. Claims about exhaustiveness always name the
cycle bound, initial state, harness, solver theory, and approximation policy
when those conditions matter. Comparisons between path count and symbolic
expression size do not treat either as an end-to-end cost measure without
solver and construction evidence.
