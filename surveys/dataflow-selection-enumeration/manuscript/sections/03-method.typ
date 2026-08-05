= Systematic mapping method <sec-method>

The evidence study is a systematic _map_, not a statistical systematic
literature review. Its purpose is to classify semantic objects, algorithms,
omission mechanisms, guarantees, and assumptions across research communities.
The protocol follows established guidance on systematic mapping
@petersen2015mapping, separate backward and forward snowballing
@wohlin2014snowballing, and auditable reporting of secondary studies
@kitchenham2023segress.

== Research questions and scope

The map asks what program models are used for path-free symbolic evaluation;
what objects are enumerated; which approaches retain partial rather than total
decisions; what soundness, completeness, disjointness, or minimality guarantees
are proved; how residuals, witnesses, and sharing are represented; what
complexity results exist; and which assumptions are made about purity,
totality, cycles, time, and solver completeness.

The search vocabulary spans twenty-seven clusters. They cover symbolic
execution and hardware simulation; synchronous and dataflow testing; projected
model and cube enumeration; trace partitioning, decision structures,
residualization, slicing, and demand; functional-logic and bounded-testing
search; finite-observer partitions; hyperplane, neural, continuous
piecewise-linear (CPWL), hybrid, and
parametric regions; stream-dataflow demand; observer-, property-, and
context-guided state or schedule reduction; higher-order concolic inputs; and
behavioral state quotients. The protocol lists the complete vocabulary and its
chronological extensions.

The protocol began with a smaller vocabulary. Newly exposed clusters were
added only through recorded reopenings; prior no-add rounds were then retired
rather than counted as closure. This matters because demand-driven
functional-logic search, Lazy SmallCheck, ordinary decision trees, and exact
region enumeration each materially narrowed the original thesis.

== Selection and extraction

A work is included when it makes a technical contribution to at least one
research question and exposes enough detail to compare semantics, guarantees,
or algorithmic behavior. Applications of an unchanged executor, conventional
control-flow-graph (CFG) def-use testing, machine-learning graph staging,
superseded secondary
versions, unobtainable technical claims, and out-of-scope computational models
receive stable exclusion codes.

Every audited database query records its exact text, source, date, hit count,
screened count, and frozen source-dependent metadata snapshot; abstracts are
retained when the source exposes them. The bounded closest-work snowballing
seed set is exactly the catalog entries marked `priority=critical`, and every
such seed receives separate backward and forward citation chases. The broader
comparison table also contains comparison-only boundary works and does not make
them additional closure seeds. Because citation indexes can
omit references, merge versions, or attach incorrect identifiers, the printed
primary bibliography controls backward closure. Technical extraction is based
on the primary paper and records definition, algorithm, theorem, complexity,
assumption, and example anchors. Search indexes are discovery instruments, not
the source for mathematical claims.

The extraction taxonomy has six dimensions:

- the program or mathematical model;
- the represented or enumerated object;
- the mechanism that omits, merges, abstracts, or quotients information;
- the concrete representation and enumeration algorithm;
- the proved or claimed guarantees; and
- the semantic and computational assumptions.

At the archived snapshot, the catalog contains 897 entries and marks 201 as
deep-read. The audited log contains 318 database queries and 245 separately
recorded backward or forward citation chases. Excluding repeated independent
adjudication passes, these rows contain 35,720 screened record occurrences;
this is not a unique-paper or population count. Eighty-three evidence rows link
manuscript claims to anchored primary-source notes.

== Saturation rule

The bounded map closes only after every candidate surfaced by the recorded
exploratory and audited searches is reconciled by a catalog disposition or an
explicit `not-recorded` log note, every critical source is deep-read and
snowballed in both directions, two consecutive
predeclared replacement rounds add neither a conceptual cluster nor a plausible
close competitor, and independent passes audit the final record sets and
borderline exclusions.
A result that introduces a new omission mechanism or enumerates observations
while avoiding decisions irrelevant to a request reopens the map. Closure is
therefore relative to the recorded databases and date; it is not a proof that
world literature contains no additional relevant work.

The repository accompanying this paper contains the protocol, catalog,
query-level search log, frozen screening snapshots, source notes, evidence
matrix, claim ledger, and closure audit. Downloaded papers and transient search
responses are deliberately excluded. The current rendered manuscript is
available at
#link("https://qobilidop.github.io/dataflow-selection-enumeration/")[the paper website];
the search record was last reconciled on 4 August 2026.

== Validity threats

The initial extraction has one primary agent. Three separate agent passes
duplicate-screened every logical record in the final closure rounds, but all
worked from the same project framing; they are not independent human review
teams, and no inter-rater agreement statistic was computed. Database coverage
and metadata are visibly incomplete; exact counts describe captured record
occurrences, not a population of papers. Vocabulary drift is acute because the
same phenomenon is called a path, fingerprint, configuration, cube, activation
pattern, mode, or critical region in different communities. Finally, the
formal framework is an interpretive bridge: this paper distinguishes a theorem
stated in prior work from a theorem obtained only after changing the observer
or adding graph instrumentation.

== AI assistance and author responsibility

OpenAI Codex (GPT-5.6 Sol) provided substantial assistance throughout this
project, including literature-search planning, organization of the evidence
record, cross-paper synthesis, development of the formal presentation,
drafting and editing of manuscript text, and repository tooling. Bili Dong
directed the project, is the sole author of record, and accepts responsibility
for the manuscript. This draft remains under continuing human review. AI
output is not treated as evidence: literature claims are intended to rest on
the cited primary sources and accompanying evidence record, and mathematical
claims must be checked against the stated definitions and proofs.
