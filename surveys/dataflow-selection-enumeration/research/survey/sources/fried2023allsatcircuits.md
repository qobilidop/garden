# fried2023allsatcircuits — AllSAT for Combinational Circuits

- **Status:** deep-read; high-relevance supporting work
- **Primary source:** https://doi.org/10.4230/LIPIcs.SAT.2023.9
- **Version read:** official open-access SAT 2023 proceedings PDF
- **Bibliography key:** `fried2023allsatcircuits`

## Why it matters

This paper shows that preserving a circuit's native ternary semantics can
produce much shorter AllSAT cubes than first translating the circuit to a
Boolean CNF. It is a direct hardware bridge among graph structure, logical
don't-care, disjoint or overlapping covers, and exhaustive enumeration. Its
output nevertheless remains a DNF over circuit inputs, not a record of
internal selector outcomes.

## Program and output model

The input is a finite single-output combinational Boolean circuit represented
as an and-inverter graph. An AllSAT-CT result is a DNF `Q` over the circuit
inputs whose Boolean models are exactly the inputs making the circuit output
true. A partial ternary assignment maps an input or gate to `0`, `1`, or `X`;
`X` means either Boolean value can extend the assignment while the observed
output remains true.

Two reported cubes may be required to be pairwise disjoint, or may overlap.
The disjoint and non-disjoint problems have the same Boolean coverage contract
but different blocking obligations (Sections 2--3, Article 9:4--9:7).

## Algorithms and guarantees

Algorithm 1 is the generic iterative-blocking scheme: obtain one total model,
generalize it to a cube, add that cube to `Q`, generate a blocking clause, and
terminate after unsatisfiability. Exact coverage follows from emitting only
implicants and blocking every previously covered Boolean model. If each
generalized cube also satisfies all prior blockers, the resulting DNF is
pairwise disjoint (Section 3, Article 9:6--9:7).

The three circuit-native variants are:

- **TALE:** greedily replaces input values by `X` and uses ternary circuit
  simulation to retain only changes that leave the output `1` (Algorithm 2,
  Section 4.1, Article 9:8). Its output need not be disjoint.
- **MARS:** uses a dual-rail encoding of `0`, `1`, and `X`; incomplete anytime
  MaxSAT calls seek more `X` values; separate blocking formulas produce
  disjoint or non-disjoint covers (Sections 4.2.1--4.2.3, Article 9:9--9:12).
- **DUTY:** applies TALE after MARS generalization and therefore may obtain a
  shorter but non-disjoint cube (Section 4.3, Article 9:12).

The paper presents correctness through the generic coverage invariant,
ternary simulation, and the two blocking constructions. It has no numbered
theorem or proposition and no OutputP, IncP, polynomial-delay, or total-runtime
bound. MaxSAT is deliberately used as an anytime heuristic rather than a
guarantee of minimum cubes.

## Complexity and empirical scope

Explicit AllSAT output can be exponential, and disjointness can require far
more cubes than an overlapping cover. The paper's contribution is empirical
scalability rather than an enumeration-complexity classification. Experiments
compare HALL with CNF blocking, nonblocking, and BDD solvers on industrial
static-timing, EPFL, and random circuits. MARS is strongest in the disjoint
setting; TALE is strongest in the non-disjoint setting (Section 5, Article
9:12--9:16).

## Motivating example

The small circuit in Figure 1 has a region where assigning only `c=0` is
sufficient to force the output. Generalizing through a Tseitin CNF can retain
three input literals because fresh label variables obscure the circuit's
ternary don't-care. TALE's native simulation obtains the one-literal cube.
This cleanly motivates the distinction between a semantic circuit cube and an
encoding-dependent partial assignment (Section 4, Article 9:7--9:8).

## Relationship to our hypothesis

### What is directly established by the work?

Native circuit structure and ternary simulation can yield substantially
shorter exact AllSAT covers than Boolean generalization after CNF conversion.
Circuit AllSAT can emit either disjoint or overlapping partial input cubes, and
the desired choice changes blocking.

### What is our interpretation or inference?

The paper's `X` is logical input don't-care: both Boolean extensions remain in
the satisfying input set. It is not the structural inactivity of an internal
selection site whose containing case was not enabled. Its circuit gates are
used to generalize input assignments, not exposed as an intensional trace.

This is nevertheless a required baseline for any implementation comparison:
activation/outcome instrumentation followed by CNF conversion may fragment a
semantic region, while a graph-native evaluator may preserve it. Encoding
quality and observation semantics must be evaluated separately.

### Could it subsume our proposed contribution?

It subsumes broad claims of first using graph structure for short exhaustive
circuit enumeration, first contrasting native graph enumeration with CNF, or
first supporting both disjoint and non-disjoint circuit covers. It does not
define enabled selector sites, retain observed equal-valued alternatives, emit
residual data values, or partition inputs by a graph-intensional observation.
The later partial-model and entailment literature provides stronger general
semantics, so this is high-value deep-read support rather than a new critical
frontier.

## Evidence locations

- Section 2, Article 9:4--9:5: Boolean and ternary circuit semantics.
- Section 3 and Algorithm 1, Article 9:5--9:7: exact DNF contract, blocking,
  and disjointness condition.
- Figure 1 and Section 4 introduction, Article 9:7--9:8: native-circuit
  generalization example.
- Section 4.1 and Algorithm 2, Article 9:8: TALE.
- Sections 4.2--4.3, Article 9:8--9:12: dual rail, MaxSAT approximation,
  disjoint/non-disjoint blockers, MARS, and DUTY.
- Section 5, Article 9:12--9:16: evaluation.

## Questions and possible weaknesses

- The coverage argument is distributed across the generic algorithm and
  blocking constructions rather than isolated as a formal theorem.
- MaxSAT generalization is approximate, and neither minimum cube count nor
  minimum cube size is guaranteed.
- The API returns a DNF cover; enumeration cost cannot be compared with a BDD
  or DAG result without aligning output representations and serialization.
