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

The search vocabulary spans sixteen clusters: formal and multi-path symbolic
execution; hardware symbolic simulation; synchronous and dataflow testing;
AllSAT, AllSMT, partial models, and cubes; trace partitioning; decision
diagrams, residualization, slicing, and demand; functional-logic search and
choice fingerprints; demand-driven bounded testing and lazy initialization;
pseudo-exhaustive circuit testing; finite-observer input partitions; decision
trees and finite-range diagrams; exact hyperplane, neural, and CPWL region
enumeration; classical stream-dataflow demand; and compositional hybrid-mode,
piecewise-affine, and parametric-program partitions.

The protocol began with a smaller vocabulary. Newly exposed clusters were
added only through recorded reopenings; prior no-add rounds were then retired
rather than counted as closure. This matters because demand-driven
functional-logic search, Lazy SmallCheck, ordinary decision trees, and exact
region enumeration each materially narrowed the original thesis.

== Selection and extraction

A work is included when it makes a technical contribution to at least one
research question and exposes enough detail to compare semantics, guarantees,
or algorithmic behavior. Applications of an unchanged executor, conventional
CFG def-use testing, machine-learning graph staging, superseded secondary
versions, unobtainable technical claims, and out-of-scope computational models
receive stable exclusion codes.

Every audited database query records its exact text, source, date, hit count,
screened count, and frozen title-level snapshot. Every closest work receives
separate backward and forward citation chases. Because citation indexes can
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

== Saturation rule

The bounded map closes only after every exploratory work is reconciled, every
critical source is deep-read and snowballed in both directions, two consecutive
predeclared replacement rounds add neither a conceptual cluster nor a plausible
close competitor, and an independent reviewer audits borderline exclusions.
A result that introduces a new omission mechanism or enumerates observations
while avoiding decisions irrelevant to a request reopens the map. Closure is
therefore relative to the recorded databases and date; it is not a proof that
world literature contains no additional relevant work.

The repository accompanying this paper contains the protocol, catalog,
query-level search log, frozen screening snapshots, source notes, evidence
matrix, claim ledger, and closure audit. Downloaded papers and transient search
responses are deliberately excluded.

== Validity threats

The initial extraction has one primary screener. Independent adversarial
audits sample exclusions and challenge closest-work claims, but this is weaker
than duplicate screening with inter-rater agreement. Database coverage and
metadata are visibly incomplete; exact counts describe the captured result
sets, not a population of all papers. Vocabulary drift is acute because the
same phenomenon is called a path, fingerprint, configuration, cube, activation
pattern, mode, or critical region in different communities. Finally, the
formal framework is an interpretive bridge: this paper must distinguish a
theorem stated in prior work from a theorem obtained only after changing the
observer or adding graph instrumentation.
