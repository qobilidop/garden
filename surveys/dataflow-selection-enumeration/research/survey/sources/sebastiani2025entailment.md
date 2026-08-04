# sebastiani2025entailment — Entailment vs. Verification for Partial-Assignment Satisfiability and Enumeration

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-031-99984-0_37
- **Version read:** official open-access CADE 30 proceedings PDF
- **Bibliography key:** `sebastiani2025entailment`

## Why it matters

This paper makes the semantic ambiguity behind short partial models explicit.
It distinguishes inexpensive residual evaluation from logical coverage of all
total extensions, proves that the two differ under projection even when the
matrix is CNF, and argues that enumeration should use entailment. The result is
directly relevant to how observation cubes and exact fibers are specified.

## Main definitions

Definition 1 says that a partial truth assignment `mu` *verifies* `phi` when
three-valued evaluation returns true, equivalently when the residual `phi|mu`
simplifies syntactically to true. Definition 2 says that `mu` *entails* `phi`
when every total extension of `mu` satisfies `phi`, equivalently when `phi|mu`
is valid (Section 3.1, p. 723).

For an existentially quantified formula `exists B. psi(A,B)`, Definition 3
says that `mu` verifies it when one total assignment `delta` to `B` makes
`mu union delta` verify `psi`. Definition 4 says that `mu` entails it when,
for every total extension `eta` over `A`, there exists a possibly
extension-dependent `delta` over `B` satisfying `psi`. The quantifier order is
therefore `for all eta, exists delta`, not one shared witness for the whole
cube (Section 3.2, pp. 724–725).

## Theorems and semantic guarantees

Theorem 1 proves that verification and entailment coincide for tautology-free
CNF formulas. For generic formulas, verification implies entailment but not
conversely. Properties 5 and 6 sharpen the tradeoff: verification is
polynomial-time to check but is not invariant under formula equivalence;
entailment is equivalence-invariant but co-NP-complete to check (pp. 723–724).

Theorems 2 and 3 characterize verification and entailment of
`exists B. psi` through its Shannon expansion. Theorem 4 proves that
verification is strictly stronger than entailment in this setting, even when
`psi` is a tautology-free CNF formula (pp. 724–725).

Theorem 5 applies the same separation to Tseitin and Plaisted–Greenbaum
CNF-izations. Projecting away their fresh variables preserves logical
equivalence and hence entailment, but not verification. The paper explicitly
notes that `CNF_PG(NNF(phi))` improves verification-based enumeration without
closing this entailment gap (p. 726).

Theorem 6 proves a uniqueness characterization. Any partial-satisfaction
relation that implies entailment, agrees with ordinary satisfaction on total
assignments, preserves conjunction elimination, and is invariant under formula
equivalence must equal entailment. Adding a finite collection of syntactic
simplifications to verification cannot in general recover these properties
(pp. 726–727).

## Complexity and algorithmic consequences

Verification is polynomial in the formula representation; entailment requires
validity of the residual and is co-NP-complete. The paper nevertheless observes
that an entailed partial assignment may stop a verification-based search tree
up to exponentially earlier: extending `mu` to a verifying `mu'` may expose up
to `2^(|mu'|-|mu|)` branches (Section 4.1, p. 728).

This is not an enumeration-complexity classification and supplies no OutputP,
IncP, or polynomial-delay result. It is primarily a semantic analysis. The
implementation discussion surveys OBDD/SDD reduction, dualized search using a
SAT solver on `CNF(not phi) and mu`, and entailment-based HALL generalization.
The paper reports prior empirical improvement but says earlier dual-search
implementations did not compete with the state of the art (Section 4.3,
p. 731).

## Motivating examples

Examples 1–2 use the equivalent formulas
`(A1 and A2) or (A1 and not A2)` and `A1`. The cube `{A1}` entails both, but
verifies only the syntactically reduced formula `A1`, demonstrating that
verification is not invariant under equivalence (pp. 723–724).

Examples 3–5 show that a cube may entail but fail to verify an existentially
quantified CNF, a Tseitin or Plaisted–Greenbaum encoding, and even the
`NNF + CNF_PG` encoding (pp. 725–726).

Examples 7–9 use a circuit whose four total models are all covered by
`{A1, not A3}`. Tableaux, non-CNF DPLL, ordinary d-DNNF traversal, and
verification-based HALL generalization return four total assignments, whereas
OBDD/SDD reduction or entailment-based generalization can return the single
cube (pp. 729–731).

## Relationship to our hypothesis

### What is directly established by the work?

Partial-assignment coverage should be defined by entailment if it is intended
to be invariant under equivalent formula presentations. Existential projection
creates a verification/entailment gap even for a CNF matrix, and standard or
NNF-aware CNF conversion does not remove that semantic gap.

### What is our interpretation or inference?

If an activation/outcome encoding emits short partial cubes, calling a cube one
semantic observation region requires an entailment claim, not merely that one
label completion makes the encoding reduce to true. Exact observation guards
already have the stronger form: they define precisely all inputs mapped to one
fixed graph-relative observation.

Our complete observation record is not itself a partial satisfying assignment.
It is the image of a deterministic graph observer, with structural inactivity
defined by enabled-edge reachability. When represented as a totalized tuple,
every inactive-or-outcome coordinate is explicit, so the paper's ambiguity
arises only if that tuple is further compressed into a cube.

### Could it subsume our proposed contribution?

It subsumes any proposed novelty claim that logical entailment is a new or
better semantics for short enumeration cubes. It does not define which graph
sites are output-demanded, distinguish active equal-valued alternatives,
construct residual program values, prove exact graph composition, or enumerate
one record per graph-intensional observation fiber.

It strengthens the boundary with projected AllSMT: a solver-generated partial
model may be a compact cover of several selection observations, while our
enumeration fixes the full observation and computes its exact fiber. Any paper
claim must state which object is being partitioned and whether omitted
coordinates mean logical don't-care or structural inactivity.

## Evidence locations

- Section 3.1, pp. 723–724: Definitions 1–2, Theorem 1, Properties 5–6, and
  Examples 1–2.
- Section 3.2, pp. 724–725: Definitions 3–4, Theorems 2–4, and Example 3.
- Section 3.3, p. 726: Theorem 5 and Examples 4–5 on CNF-ization.
- Section 3.4, pp. 726–727: Theorem 6's characterization of entailment.
- Section 4.1, pp. 727–729: complexity tradeoff and projected enumeration.
- Sections 4.2–4.3, pp. 729–731: d-DNNF/OBDD/SDD behavior, dual search, HALL,
  and Examples 7–9.

## Questions and possible weaknesses

- The work analyzes propositional formulas and Boolean abstractions. Theory
  consistency in AllSMT adds another obligation not formalized by its central
  definitions.
- Entailment may reduce output size while making each reduction check harder;
  the paper gives no general output-sensitive runtime theorem.
- Exact-fiber enumeration can avoid asking a solver for shortest cubes, but it
  may pay separately to construct or simplify the full fiber guard.
