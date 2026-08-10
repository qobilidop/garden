= Survey scope and evidence basis <sec-method>

The evidence study is a systematic map rather than a statistical systematic
literature review. It is organized following the framing of systematic
mapping @petersen2015mapping, separate backward and forward snowballing
@wohlin2014snowballing, and auditable reporting of secondary studies
@kitchenham2023segress; no completed reporting checklist is claimed. It
supports the comparison of solution mechanisms for the problem in
@sec-framework, not a census of every use of symbolic execution, dataflow,
or enumeration.

== Comparison and inclusion

The four research questions in the introduction determine the extraction
schema. For each work, the map compares its model and observer, enumerated
object, discovery algorithm, output representation, guarantees, complexity
charge, and semantic or solver assumptions.

Works in the main comparison have one of three relationships to the target
problem. A _direct presentation_ enumerates the same observer after explicit
notation or reachability instrumentation. A _restricted specialization_ solves the
same contract under stronger assumptions, such as all sites being observed and
all classifiers being affine. An _adjacent comparator_ preserves or omits
information for a different observer and is included only when it clarifies a
semantic or complexity boundary. The classification prevents a neighboring
reduction problem from being presented as an alternative implementation of an
input-fiber enumerator.

== Discovery, screening, and technical evidence

Discovery deliberately used a broader vocabulary than the final paper. It
covered symbolic execution and guarded values; projected and partial model
enumeration; decision structures; functional-logic and demand-guided search;
dataflow and hardware semantics; geometric, neural, and parametric regions;
and observer-relative state or search reduction. Exact queries, result depths,
dates, and citation chases are retained in the audited log. Transient result
sets are discarded after reconciliation, so the log row is the audit unit;
primary bibliographies supplement incomplete citation indexes.

Through 9 August 2026, 340 database queries and 245 backward or forward
citation chases yielded 36,828 screened record occurrences. Repeated hits and
rows rejected before cataloging remain in that occurrence count; it is neither
a unique-paper count nor an estimate of a literature population. After
deduplication and audit, the current catalog contains 920 works: 118
`deep-read`, 243 `screened`, 424 retained `candidate`, and 135 `excluded`
records. Candidate status records discovery rather than a promise to read the
work. The manuscript cites 76 deep-read technical sources and four screened
works; no candidate-status work supports a manuscript claim.

Technical claims rely on primary works with pinpoint definition, algorithm,
theorem, complexity, assumption, or example anchors. Abstract- or
metadata-level records support only search scope or qualified chronology. The
evidence ledger binds manuscript claims to those source anchors and carries
their scope and caveats.

== Bounded baseline and on-demand updates

The baseline was frozen only after every discovered record received a catalog
disposition, every critical source was deep-read and chased in both directions,
and two predeclared replacement rounds added neither a conceptual solution
family nor a plausible close competitor. This is _bounded mapping closure_
relative to the recorded sources, rankings, query depths, and date—not a claim
that no additional work exists.

Updates run on demand when a new mechanism or plausible direct competitor
appears. The current record was last reconciled on 9 August 2026, when 22
registered queries were rerun at caps of the top 100 relevance- or
recency-ranked results. The resulting no-new-competitor finding is limited to
those ranked slices. The protocol, queries, catalog, log, source notes,
syntheses, and evidence and claim ledgers are linked from
#link("https://qobilidop.github.io/sys0/surveys/dataflow-selection-enumeration/")[the survey's landing page].

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
