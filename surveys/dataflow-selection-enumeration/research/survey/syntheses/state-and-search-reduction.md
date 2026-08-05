# State quotients and observation-guided exploration

## Exact state-space quotients

Chiola et al.'s symbolic reachability graph represents equivalence classes of
well-formed colored-Petri-net markings under encoded color symmetries. It is
constructed directly rather than by first materializing ordinary reachability,
can be substantially smaller, and preserves the represented reachability
analysis. Haddad et al. extend the construction to partial symmetries. Capra
uses numerical color-domain mappings and linear constraints for models beyond
static global symmetry. These latter two statements are limited to the primary
high-level evidence recorded in their source notes.

Iavich et al.'s S3E is a closer software analogue: it groups symbolic execution
states into declared group orbits, explores canonical representatives in a
quotient transition system, and states orbit-preservation, quotient-soundness,
canonicalization, and constraint-reuse results. Its implementation evidence is
only a toy model, and production-firmware evaluation is left for future work.

Alur et al. reduce a different state-space multiplicity. Their BDD-based
symbolic exploration retains representative orders of independent concurrent
events under partial-order conditions that preserve local-property
verification. This is observer-preserving omission of execution choices, but
the omitted choices are schedules rather than input-selected dataflow sites.
The lineage is broader than this seed: coverage-preserving reductions retain
the full reachable-state set; Boolean/SAT and BDD techniques preserve rule-
system, local-property, or LTL observers; MPOR claims soundness and no redundant
interleavings under quasi-monotonicity; and SymPaths proves reduced symbolic
execution correct and complete relative to concrete multithreaded executions.
Concolic DPOR instantiates the same schedule omission during test generation.
Approximate POR instead makes epsilon/delta loss explicit. Chatain and Fabre's
symbolic unfoldings likewise avoid enumerating every concurrent-action
interleaving and additionally commute with component product. A separate
modular-prefix construction exchanges interface-relative component summaries
to avoid constructing the global Petri net. Complete-prefix algorithms also
operate directly on contextual nets with read arcs and multiple event
histories, on safe timed nets with symbolic token ages, and on high-level
symbolic nets, including an extended class with infinitely many reachable
markings. A later construction carries time, stopwatch, and parameter
constraints symbolically, but proves finite-prefix completeness only for the
ordinary safe Time-Petri-net subclass. For 1-safe free-choice nets, a different
full prefix folds maximal-step paths at repeated markings and supports exact
reveals, excludes, and maximal-run transition-set footprints, with exponential
worst-case footprint computation. These are reductions or finite
representations of whole-net runs and reachability, not caller-input
observation fibers with typed residuals.
Bilgram et al. further quotient behaviorally equivalent colors and remove
impossible place colors while preserving a bisimilar unfolded net.

Other constructions omit different state dimensions. Basis markings abstract
an acyclic implicit-transition subnet while completely characterizing the
reachable marking set according to the primary abstract. Fully symbolic
saturation- or signature-based partition refinement computes maximum
bisimulation for transition systems; the BDD lineage begins at least with
Bouali and de Simone and extends through rank-based, toolbox, and parallel
implementations. Fisler and Vardi's negative result matters: constructing the
quotient can cost more than checking an invariant directly. Time-anonymous values merge timestamps
assessed as unable to affect future timed behavior, but their source discloses
minor information loss. Under partial state observation, exact marking
estimators retain the hidden markings still consistent with the visible label
word. A related recursive algorithm instead returns the complete subset of
consistent initial markings with minimum total token count. Timed class-graph
and hierarchical-basis observers add timing or unobservable transitions; the
latter claim is primary-abstract limited.

This is an exact quotient of reachable states, not an input partition. It has
no requested root, contextual internal-event map, or typed input residual.
Together these lineages block broad claims that symmetry-guided aggregation,
direct construction of a reduced symbolic graph, or observer-preserving choice
omission is new.

## Observation-guided search

Seo and Kim's context-guided concolic search observes a dominator-filtered
suffix of preceding branch decisions and prioritizes branches reached in new
contexts. Seo's dissertation further reports precondition-guided search, which
builds and merges conditions learned from executions that fail to reach one
requested branch. Busse et al.'s SSLE observes sibling loop states' edge
patterns up to an impact barrier and postpones repeats. Ahmed and Mishra's
QUEBS caps repeated RTL branch selections and resets other caps when a
qualifying coverage event occurs.

Fitness-guided DSE measures progress toward a requested coverage target.
Abstraction-guided concurrent testing ranks thread and data choices through a
backward slice from an assertion, refining when guidance stalls. Multipoint
DSE also reports target-equivalent path elimination, but its primary full text
was unavailable and no general semantic quotient is imported.

Homi and NumScout move from prioritization to learned omission: one retains a
small state subset predicted to improve coverage or bug discovery, and the
other prunes functions predicted irrelevant to a requested defect family. Both
are deliberately approximate, so they strengthen the negative taxonomy but
not the exact-quotient lineage.

These are deliberately search policies. They may delay or prune candidates
without making the observed patterns semantic equivalence classes, requiring
unbounded exhaustive coverage, or emitting an exact guard/residual pair per
class. Their relevance is negative and taxonomic: observation novelty,
requested goals, qualifying events, and sparse path context are established
search controls, so the synthesis must rely on its exact finite-observer fiber
contract rather than those broad motifs.

## Property-relative reduction

Regular-property-guided DSE uses the event-FSM history and a static
over-approximation of future events to prioritize paths likely to reach one
accepted event sequence. SRV's ideal property-oriented slicing can omit
branches that cannot contribute a counterexample or whose accepted event
continuations are equivalent to an already explored sequence when Preset and
Postset meet its soundness conditions. The evaluated implementation is
explicitly unsound because Postset is context-insensitive. Derivative-guided
symbolic execution represents a
trace specification by a symbolic finite automaton and uses the residual
specification to prune unproductive precondition traces, with soundness and
falsification completeness relative to its naive semantics.

Assertion-guided multithreaded execution records summaries explaining why
prior executions cannot reach an error and soundly prunes executions they
subsume. Abstract symbolic subsumption predates it: revisiting a symbolic heap
state contained in a previous abstract state causes backtracking, obtaining
finite under-approximate exploration for recursive structures. The publisher
abstract for compatible-branch coverage states that
dependency analysis omits paths unable to add branch coverage under its bounded
exploration contract. These are close negative results: the omission is
relative to a declared observer, but the objective is one property's
preservation rather than enumeration of the observer's full image and fibers.

Coverage-based cause reduction acts one phase earlier. It removes concrete
seed inputs while retaining statement coverage before symbolic exploration,
then prioritizes the reduced suite. That is observation-preserving input
preprocessing rather than an execution quotient.

This lineage is stronger than heuristic guidance because its omission is
relative to an explicit property observer and can carry preservation results.
It seeks an accepted witness, however, rather than
enumerating every observation with its disjoint exact input fiber and typed
residual.

Li, Meng, and Duck supply one more structural boundary. Coverage-set
partitions and property slices finitely summarize possibly infinite loop-path
families. The practical verification oracle is explicitly approximate, so the
result establishes a finite path-family decomposition rather than an exact
semantic enumerator.
