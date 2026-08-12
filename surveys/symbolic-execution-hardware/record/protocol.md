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

## Research questions

- **RQ1:** Definition and regimes — Which works actually perform classical,
  concolic/dynamic, or selective/hybrid symbolic execution of a digital
  hardware design, and how do those regimes differ operationally?
- **RQ2:** Design target and operational representation — Which hardware
  representation is the paper's claim about—RTL, another HDL, HLS,
  SystemC/TLM, a netlist, or a coupled cross-level model—which program or IR
  does the executor actually step, and how are concurrency and clocked state
  bridged between them?
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
  1900, before the digital-hardware literature relevant to this survey.
  Current per-query reconciliation dates live in `queries.tsv`; the dated
  publication checkpoint and known gaps live in `status.md`.
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

## Selection boundaries

Include a peer-reviewed work, dissertation, substantial technical report, or
preprint only when its central method satisfies all parts of the following
operational test:

1. it steps, replays, or composes executions of a digital hardware design or a
   claimed-faithful executable representation of one;
2. at least one hardware input, state element, or environment value is
   represented symbolically;
3. it constructs path predicates tied to alternatives distinguished by the
   executed design representation—control-indexed and, for sequential designs,
   time-indexed—not merely by an external procedural testbench;
4. feasibility reasoning over those predicates controls the enumeration,
   selection, reconstruction, composition, merging, or generation of another
   execution; and
5. this symbolic-execution mechanism is load-bearing in the paper's method and
   evidence, producing a witness, test, coverage result, or qualified
   verification result.

When the executor operates on a translated, generated, lifted, HLS, or other
derived artifact, the paper must document a semantic relation to the digital
design adequate to the result it claims. Witness replay can validate one path
through that bridge but does not establish equivalence of all executions.

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
- **Design target** (the catalog column remains `artifact`):
  `rtl|hdl-other|hls|systemc-tlm|gate-netlist|mixed-level|generic`. This facet
  names the representation about which the paper claims, not necessarily the
  program interpreted by the executor. `rtl` includes Verilog, SystemVerilog,
  and generated RTL; `hdl-other` covers digital HDLs not more specifically
  classified; `generic` is used only when the method is hardware-specific but
  target-independent. Operational representations and semantic bridges are
  synthesized separately from deep-read evidence.
- **Primary execution regime:** `classical|concolic|selective-hybrid`. To keep
  this one-value facet reproducible, `selective-hybrid` is reserved for a
  non-symbolic search engine that maintains its own evolving frontier or corpus,
  can make exploration progress between symbolic invocations, and exchanges
  candidates with the symbolic executor. Concrete simulation or replay that
  merely supplies and checks the trace in a concolic loop does not meet that
  criterion. The remaining trace-following or reconstruction systems are
  `concolic`; the remaining direct symbolic-state systems are `classical`.
  `classical` includes
  explicit path fragments and state merging when symbolic execution remains
  the sole exploration regime; record those scaling mechanisms in the
  mechanism synthesis rather than making them peer regimes. An LLM repair loop
  that consumes concolic results is not by itself an independent search engine.
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
  every `deep-read` requires a local, survey-specific source note.
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
  as linked background through the optional `canonical-note` frontmatter
  field. This survey still keeps a local source note that answers its own RQs,
  boundary, taxonomy, and evidence-limit questions; general-note prose is not
  copied wholesale.
- The systematic map may publish a dated bounded snapshot without claiming
  bounded mapping closure. Closure, if reached, uses the stronger shared skill
  criteria and is stated relative to the exact sources, queries, depths, and
  date.
- Historical `notes-by` values from the initial campaign name `Codex` without
  a recoverable exact model. Preserve them as legacy provenance; material
  revisions append the revising model under the current shared contract.
- In migrated notes, `retrieved: "-"` means that acquisition time was not
  recorded; it must not be inferred from the later review date.

## Publication qualifications

Counts derive only from `catalog.tsv`. Technical claims derive from full-text
evidence notes with pinpoint anchors. Abstract-only records support scope,
terminology, and chronology only. Claims about exhaustiveness always name the
cycle bound, initial state, harness, solver theory, and approximation policy
when those conditions matter. Comparisons between path count and symbolic
expression size do not treat either as an end-to-end cost measure without
solver and construction evidence.
