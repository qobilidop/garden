= Survey scope and evidence method <sec-method>

The evidence study is a systematic map rather than a statistical systematic
literature review. It follows established guidance on systematic mapping
@petersen2015mapping, separate backward and forward snowballing
@wohlin2014snowballing, and auditable reporting of secondary studies
@kitchenham2023segress. Its purpose is to locate and compare solution
mechanisms for the problem defined by @sec-formal-model, not to survey
every use of symbolic execution, dataflow, or enumeration.

== Comparison questions and inclusion levels

The four research questions in the introduction determine the extraction
schema. For each work, the map records:

- its program or mathematical model and observer;
- the enumerated object and the information it omits or merges;
- its discovery algorithm and output representation;
- its coverage, uniqueness, guard, residual, and witness guarantees;
- its complexity statement and charged input/output representation; and
- its assumptions about purity, totality, effects, cycles, time, dimension,
  and solver completeness.

Works in the main comparison have one of three relationships to the target
problem. A _direct presentation_ enumerates the same observer after explicit
notation or reachability instrumentation. A _restricted specialization_ solves the
same contract under stronger assumptions, such as all sites being observed and
all classifiers being affine. An _adjacent comparator_ preserves or omits
information for a different observer and is included only when it clarifies a
semantic or complexity boundary. This classification keeps partial-order
reduction, Petri-net observation, hardware protocol semantics, and directed
testing from being presented as alternative implementations of an input-fiber
enumerator.

== Discovery, screening, and technical evidence

Discovery deliberately used a broader vocabulary than the final paper. It
covered symbolic execution and guarded values; projected and partial model
enumeration; decision structures; functional-logic and demand-guided search;
dataflow and hardware semantics; geometric, neural, and parametric regions;
and observer-relative state or search reduction. Exact database queries,
result depths, dates, source-dependent metadata, and frozen screened snapshots
are retained in the repository. Printed primary bibliographies control
backward snowballing when citation indexes are incomplete or incorrect.

Screening assigns one current catalog disposition. At the archived snapshot,
the 897 discovered works comprise 202 `deep-read`, 160 `screened`, 420
`candidate`, and 115 `excluded` records. Here `candidate` is a retained
discovery disposition, not an unresolved promise to read every record. The
main technical comparisons rely on deep reads of primary works with pinpoint
definition, algorithm, theorem, complexity, assumption, or example anchors.
Primary-abstract or metadata-only records may establish search scope or a
qualified chronology statement, but they do not support theorem or algorithm
claims.

The focused manuscript cites 56 cataloged works: 53 deep-read technical
sources and three screened methodological guides. No candidate-status work is
cited. This is narrower than the discovery catalog by design.

The audited record contains 318 database queries and 245 separately recorded
backward or forward citation chases. Excluding repeated adjudication passes,
the log contains 35,720 screened record occurrences; this is neither a
unique-paper count nor an estimate of a literature population. A claim-level
evidence matrix links every manuscript citation at its stable section label and
every active synthesis claim to source-note anchors, while stating the scope
and caveat of each comparison.

== Bounded baseline and living updates

The baseline was frozen only after every surfaced record received a catalog
disposition, every critical source was deep-read and chased in both directions,
and two predeclared replacement rounds added neither a conceptual solution
family nor a plausible close competitor. This is _bounded mapping closure_
relative to the recorded sources, rankings, query depths, and date—not a claim
that no additional work exists.

The repository treats the snapshot as an updateable baseline. Registered
Crossref and arXiv searches recur every 90 days, critical-source forward
neighborhoods are refreshed at least annually, and a new mechanism or plausible
direct competitor triggers an immediate reopening. A coverage date advances
only after catalog dispositions, source notes, thematic syntheses, evidence
rows, and affected manuscript claims have been reconciled. The current search
record was last reconciled on 4 August 2026.

The accompanying repository contains the protocol, query registry, catalog,
audited search log, frozen screening snapshots, primary-source notes, thematic
syntheses, evidence matrix, claim ledger, and manuscript checks. Downloaded
papers, transient API responses, and search-engine exports are deliberately
excluded. The current manuscript and repository are linked from
#link("https://qobilidop.github.io/dataflow-selection-enumeration/")[the paper website].

== Validity threats and AI assistance

The breadth-first discovery campaign may miss work whose terminology does not
intersect the registered queries or citation neighborhoods. Database rankings
are opaque, metadata services omit or merge records, and exact counts describe
captured occurrences rather than a population. The framework itself can bias
classification: a theorem proved for a different observer must not be silently
transferred after adding instrumentation or changing the output quotient.

Initial extraction and the repeated duplicate-screening passes were conducted
with substantial assistance from OpenAI Codex (GPT-5.6 Sol) under the author's
direction. The passes reused the same project framing and are repeated
AI-assisted checks, not independent human reviewers; no inter-rater agreement
statistic was computed. Bili Dong is the sole author of record, directed the
project, and accepts responsibility for the manuscript. AI output is not
treated as evidence: literature claims are tied to primary sources, and the
mathematical statements remain subject to human verification.
