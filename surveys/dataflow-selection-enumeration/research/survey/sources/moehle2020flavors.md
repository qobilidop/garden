# moehle2020flavors — Four Flavors of Entailment

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1007/978-3-030-51825-7_5
- **Version read:** SAT 2020, Springer LNCS 12178 proceedings text, pp. 62–71
- **Bibliography key:** `moehle2020flavors`

## Why it matters

This paper separates four increasingly powerful ways to recognize that a
partial assignment already covers projected models. Its strongest condition
is the exact `forall X exists Y` projected-entailment query. That quantifier
order is the semantic core of compressing several visible assignments into one
cube when each visible completion may require a different hidden witness.

## Formula and output model

The input is a Boolean formula `F(X,Y)`, where `X` contains relevant variables
and `Y` contains irrelevant variables. Enumeration should produce a DNF `M`
over `X` whose cubes cover the models of `exists Y. F`. The solver trail `I`
may assign both relevant and irrelevant variables, but only its restriction to
`X` is emitted (Sections 1–2, pp. 62–64).

Ordinary entailment asks whether every total extension of `I` satisfies `F`,
equivalently whether `not F and I` is unsatisfiable. Exact projected
entailment is stronger: after applying `I`, it asks
`forall X_remaining exists Y_remaining. F|I`. Different completions of the
relevant variables may therefore use different irrelevant witnesses.

For example, with `F = x1 and (x2 iff y)` and trail `I = {x1}`, ordinary
entailment fails because some joint `x2,y` extensions falsify `F`, but projected
entailment holds because each choice of `x2` has a matching `y` (Table 1,
pp. 65–66).

## The four entailment checks

The paper orders four checks by power and cost (Section 3, pp. 64–66):

1. **Syntactic evaluation:** `F|I` reduces directly to true.
2. **Incomplete semantic reasoning:** a polynomial or otherwise bounded
   procedure, such as unit propagation or limited decisions on the negation,
   may establish entailment but can answer unknown.
3. **Ordinary semantic entailment:** a SAT oracle establishes unsatisfiability
   of `not F and I`. This is a co-NP check.
4. **Exact projected entailment:** a QBF oracle establishes
   `forall X_remaining exists Y_remaining. F|I`. This lies at the second level
   of the polynomial hierarchy (`Pi_2^P`).

Table 1 gives formulas and trails separating the four levels, so none of these
tests can in general replace the next stronger test without losing possible
cube compression.

## Enumeration procedure and guarantees

Figure 1 embeds the selected entailment oracle in chronological CDCL. The
procedure propagates, analyzes conflicts, and otherwise either records the
current projected trail when the oracle succeeds or chooses a new decision.
Relevant variables are decided before irrelevant ones. After recording a
cube, it chronologically backtracks to and flips the highest relevant decision
needed to continue enumeration; it does not accumulate blocking clauses or run
a post-model cube-shrinking pass (pp. 63–67).

Figure 2 presents the corresponding transition calculus, extending the
authors' prior chronological-CDCL calculus with `EndTrue`, `EndFalse`,
`BackTrue`, `BackFalse`, `Unit`, `DecideX`, and `DecideY` rules. Section 5
argues that the procedure terminates, outputs only covered cubes, covers all
projected models, and avoids overlap by its chronological flip discipline
(pp. 67–70).

These arguments are given in prose and calculus invariants rather than as
numbered theorem/proof statements. The paper supplies no OutputP, IncP, or
polynomial-delay theorem. More powerful oracles may shorten outputs but make
each entailment check substantially harder.

## Implementation and empirical scope

The contribution is theoretical and algorithmic. It proposes combining dual
reasoning with chronological CDCL and contrasts the design with blocking and
shrinking enumerators, but reports no implementation evaluation. The authors
leave implementation and experiments as future work (Sections 5–6, pp.
69–71).

## Relationship to our hypothesis

### What is directly established by the work?

A partial cube over visible variables covers all its visible completions under
existential projection exactly when the residual satisfies a
`forall visible, exists hidden` QBF. A SAT-only entailment oracle is incomplete
for that purpose. Chronological CDCL can use any of four increasingly strong
checks to enumerate a nonoverlapping DNF without blocking clauses.

### What is our interpretation or inference?

This result directly covers the semantic question posed when a projected
AllSAT method tries to omit some explicit observation coordinates from its
output cube. If hidden program or encoding choices can depend on the omitted
observation values, exact compression requires the strongest projected query,
not one shared hidden witness.

Our proposed exact-fiber enumeration avoids that compression problem by first
fixing a complete graph-relative observation, including inactivity values, and
then deriving the inputs with exactly that observation. It can still use a QBF
or analogous quantified check to simplify a fiber, but shortest-cube discovery
is not part of the record's semantic identity.

### Could it subsume our proposed contribution?

It subsumes the claim that `forall X exists Y` projected entailment is a new
semantic basis for partial projected model cubes, and it supplies an important
blocking-free enumeration baseline. It does not define demanded graph sites,
structural inactivity, active equal-arm choices, exact guards for fixed
observations, residual program values, or modular composition.

## Evidence locations

- Sections 1–2, pp. 62–64: projected-model problem and chronological-CDCL
  setup.
- Section 3 and Table 1, pp. 64–66: four entailment flavors, separating
  examples, and SAT-versus-QBF checks.
- Figure 1, pp. 63–67: enumeration algorithm and relevant-first decisions.
- Figure 2 and Section 5, pp. 67–70: calculus and correctness discussion.
- Section 6, pp. 70–71: claimed novelty and future implementation work.

## Questions and possible weaknesses

- The strongest exact oracle is `Pi_2^P`; no bound shows when smaller output
  compensates for that per-check cost.
- Correctness is not packaged as numbered theorems, and the paper provides no
  empirical validation of the proposed solver.
- Cubes describe logical don't-care over a chosen Boolean projection; they do
  not distinguish graph-intensional events that happen to share values.
- The theory does not cover SMT consistency or residual symbolic program
  values.
