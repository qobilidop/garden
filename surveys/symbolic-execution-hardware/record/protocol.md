# Survey protocol

This file records only choices specific to this survey. The current
`run-survey` skill is canonical for shared search, screening, snowballing,
logging, evidence, update, and bounded-closure procedure. Local commands and
file ownership are in `README.md`; current state is in `status.md`; event
history is in `log.tsv`; current interpretation is in `syntheses/`.

## Objective and study type

Build an updatable systematic map and critical survey of path-conditioned
symbolic execution of digital hardware designs. The survey traces the
literature without a domain-specific historical cutoff, centers
register-transfer-level (RTL) designs, and admits other hardware description
languages (HDLs), high-level synthesis (HLS) models, and cross-level
executable models only when a digital hardware design is the object of the
symbolic-execution claim.

The survey treats classical symbolic execution, concolic or dynamic symbolic
execution, and selective or hybrid methods with a load-bearing symbolic-
execution phase as distinct regimes inside the core. Symbolic simulation,
symbolic trajectory evaluation (STE), bounded model checking, and other
solver-backed hardware methods are outside the map denominator. A few may be
cited as historical context or boundary comparators, but contextual citation
does not confer inclusion. The map makes no formal risk-of-bias appraisal and
no claim to cover formal hardware verification generally.

The user approved the title, scope, RTL center, absence of a domain-specific
historical cutoff, and autonomous execution through manuscript, commit, and
push on 2026-08-10.
That approval is the protocol gate; later material method changes are logged in
`status.md` before they are applied.

## Research questions

- **RQ1:** Definition and regimes — Which works actually perform classical,
  concolic/dynamic, or selective/hybrid symbolic execution of a digital
  hardware design, and how do those regimes differ operationally?
- **RQ2:** Executed artifact — Which design representations are executed — RTL,
  other HDLs, HLS or behavioral models, SystemC/TLM, netlists, or coupled
  cross-level models — and how are hardware concurrency and clocked state
  represented?
- **RQ3:** Paths and scaling — What constitutes a path through concurrent,
  clocked hardware; how are path-conditioned alternatives enumerated,
  reconstructed, composed, merged, or selected; and which mechanisms control
  their growth?
- **RQ4:** Verification contract — Which goals are served, what witnesses or
  proofs are produced, and what bounds, approximations, environmental models,
  or harness assumptions qualify the result?
- **RQ5:** Evidence — How are systems evaluated with respect to design scale,
  temporal depth, coverage, solver work, defects, reproducibility, and
  comparison baselines?

## Scope and discovery choices

- **Window:** no domain-specific historical cutoff; APIs are queried from
  1900, before the digital-hardware literature relevant to this survey, and
  standing searches close at 2026-08-11 and critical-work citation chases at
  2026-08-12. Works first surfaced after those respective dates belong to a
  future update.
- **Language:** English-language title and abstract metadata; a non-English
  work can remain `parked` if its scope cannot be established reliably.
- **Sources:** OpenAlex, Crossref, Semantic Scholar, and arXiv, supplemented by
  backward and forward citation chasing and primary bibliographies. Exact
  standing searches, source-native syntax, limits, and reconciliation dates
  live only in `queries.tsv`.
- **Depth:** standing searches are relevance-ranked and capped as declared in
  `queries.tsv`. The catalog is bounded by those sources, queries, depths, and
  the closing date.
- **Terminology expansion:** discovery searches use *symbolic execution*,
  *dynamic symbolic execution*, *concolic*, and hardware-specific combinations
  of path exploration, path constraints, and directed test generation.
  Symbolic simulation, STE, BMC, and adjacent terms may be used only in
  boundary-sensitive searches that can expose mislabeled or comparative core
  work. Inclusion is decided from the operational mechanism, never from a
  title token or use of an SMT solver alone.
- **HDL/HLS interpretation:** Verilog, SystemVerilog, VHDL, Chisel, Bluespec,
  SystemC, HLS source or IR, and generated executable models are admissible.
  A language or synthesis paper enters only when the represented or generated
  hardware passes the same five-part operational test as RTL.
- **Defective bibliographies:** an empty, truncated, or implausibly incomplete
  citation-index bibliography is replaced by the primary version's printed or
  publisher-deposited references and marked `primary-complete` in `log.tsv`.

## Selection boundaries

Include a peer-reviewed work, dissertation, substantial technical report, or
preprint only when its central method satisfies all parts of the following
operational test:

1. it steps, replays, or composes executions of a digital hardware design or a
   claimed-faithful executable representation of one;
2. at least one hardware input, state element, or environment value is
   represented symbolically;
3. it constructs path predicates tied to distinguishable control- and
   time-indexed executions of that design;
4. feasibility reasoning over those predicates controls the enumeration,
   selection, reconstruction, composition, merging, or generation of another
   execution; and
5. this symbolic-execution mechanism is load-bearing in the paper's method and
   evidence, producing a witness, test, coverage result, or qualified
   verification result.

Classical symbolic execution, concolic/dynamic symbolic execution, and
selective/hybrid symbolic execution pass the same five-part test but remain
separate taxonomy values. State merging and fragment composition remain
eligible when path-conditioned execution identities and feasibility
obligations remain explicit. Pure propagation of symbolic values through a
circuit, an abstract trajectory, or an unrolled transition formula does not
pass merely because it represents many executions or calls SAT/SMT. A paper's
self-description is evidence to inspect, not a classification rule.

Hardware/software and cross-level work is included only when the hardware
model itself passes the operational test. Symbolic execution of firmware or
binaries running on an otherwise concrete or emulated platform is not hardware
symbolic execution for this survey. Symbolic execution of HLS source or
generic C/C++ is included only when the analysis models hardware-specific
execution semantics or validates and uses an explicit relation to the
generated hardware design; intended synthesis alone is insufficient.

This survey declares these exclusion codes:

- `E1-software-or-firmware-only` — the symbolically executed object is software
  or firmware and no hardware design model participates symbolically;
- `E2-formal-hardware-without-execution` — BMC, model checking, theorem proving,
  equivalence checking, SAT/SMT solving, or information-flow analysis without
  a load-bearing operational symbolic-execution mechanism;
- `E3-symbolic-method-without-path-execution` — symbolic simulation, STE, or
  another symbolic hardware method that does not maintain path-conditioned
  executions satisfying the operational test;
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
RTL model executed by KLEE is in scope only when the generated program is used
as the operational representation of RTL and the paper addresses or validates
that bridge; a firmware binary executed by KLEE against concrete peripherals
is E1. An HLS compiler verified only by equivalence checking is E2; symbolic
execution of generic source intended for HLS but lacking hardware semantics or
a validated source-to-hardware relation is E6.

## Taxonomy and coding

Every include carries one abstract-level primary value per facet. Full-text
note facets are authoritative for the individual work but do not silently
rewrite the abstract-level map.

- **Relation:** every include is `core`; contextual lineage and comparator
  works are cited outside the map denominator rather than coded as includes.
- **Artifact:** `rtl|hdl-other|hls|systemc-tlm|gate-netlist|mixed-level|generic`.
  `rtl` includes Verilog, SystemVerilog, and generated RTL; `hdl-other` covers
  executable digital HDLs not more specifically classified; `generic` is used
  only when the method is hardware-specific but representation-independent.
- **Execution:** `classical|concolic|selective-hybrid`. `classical` includes
  explicit path fragments and state merging when symbolic execution remains
  the sole exploration regime; record those scaling mechanisms in the
  mechanism synthesis rather than making them peer regimes. `concolic`
  follows or reconstructs concrete executions while maintaining their
  symbolic path constraints. `selective-hybrid` applies symbolic or concolic
  execution only to selected regions/phases or makes it co-equal with fuzzing,
  concrete simulation, or another exploration engine.
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
- Positive inclusion requires primary full-text evidence for all five parts of
  the operational test. A primary abstract can support exclusion when it
  clearly establishes a failed part; otherwise the record remains `parked`
  until the primary text is available. This asymmetric evidence rule prevents
  a paper's use of the phrase “symbolic execution” from substituting for a
  mechanism audit.
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
