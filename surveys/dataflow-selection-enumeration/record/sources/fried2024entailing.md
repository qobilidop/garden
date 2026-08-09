---
citekey: fried2024entailing
work:
  title: "Entailing Generalization Boosts Enumeration"
  author: "Dror Fried, Alexander Nadel, Roberto Sebastiani, Yogev Shalmon"
  venue: "SAT 2024"
  date: 2024
  doi: 10.4230/lipics.sat.2024.13
read: full-text
source: "Open-access SAT 2024 proceedings PDF via https://doi.org/10.4230/LIPIcs.SAT.2024.13"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "The closest circuit-native account of the semantic gap between propagating a partial input through a graph and proving every completion forces the observed output: orders gate, satisfying, and entailing generalization, then uses entailment-producing unsatisfiable cores inside an exhaustive AllSAT blocking loop"
---

# Entailing Generalization Boosts Enumeration

## Evidence

### Why it matters

This paper gives the closest circuit-native account of the semantic gap
between propagating a partial input through a graph and proving that every
completion forces the observed output. It orders gate, satisfying, and
entailing generalization, then uses entailment-producing unsatisfiable cores
inside an exhaustive AllSAT blocking loop. It therefore rules out novelty
claims based merely on graph-native enumeration, semantic generalization, or
entailment-based omission.

### Program and output model

The input is a finite acyclic single-output combinational Boolean circuit
`Gamma = <I,G,o>`. An input assignment maps each variable to `0`, `1`, or the
don't-care value `X`; omitted variables conventionally have value `X`.
Ternary simulation extends the input assignment gate by gate (Definition 1,
Article 13:4).

For a partial input `tau`, *satisfaction* means that ternary propagation
computes output `1`. *Entailment* means that every Boolean replacement of its
`X` values computes output `1`. Thus satisfaction is a graph-local sufficient
test, whereas entailment is the semantic cube-coverage property (Section 3,
Article 13:4--13:5).

An AllSAT-CT result is a DNF `Q(I)`. Every cube in `Q` must entail the circuit,
and `Q` must be logically equivalent to the circuit's asserted output. The
paper intentionally studies overlapping covers: one total input may be
subsumed by multiple emitted cubes (Section 4, Article 13:6--13:7).

### Algorithms and guarantees

Definition 2 orders three ways to generalize a total model:

- a gate generalization leaves every internal gate two-valued under ternary
  simulation;
- a satisfying generalization only makes the propagated output two-valued and
  true;
- an entailing generalization merely requires all Boolean completions to make
  the output true.

Lemma 4 proves strictness by inclusions and separating examples:
`G(Gamma,sigma) subset S(Gamma,sigma) subset E(Gamma,sigma)`, with satisfying
and entailing generalizations that cannot be subsumed by any member of the
next stricter class (Article 13:5--13:6).

Algorithm 1 instantiates the standard enumerate-generalize-block loop:

1. obtain a total satisfying input from an incremental `plain` solver;
2. generalize it to an entailing cube;
3. add the cube to the output DNF; and
4. block that cube in `plain` until `UNSAT`.

`CORE` obtains an unsatisfiable core from a second solver containing the
negated circuit and minimizes it locally. `ROC` first performs ternary
generalization and then core generalization. `CARMA` combines the core method
with a dual-rail front end (Article 13:6--13:8). The paper cites the generic
blocking framework for correctness rather than proving a new end-to-end
theorem. Since only entailing cubes are emitted and every emitted cube is
blocked, the returned DNF covers exactly all satisfying total inputs. It is
explicitly not guaranteed to be disjoint, prime, minimum-cardinality, or
minimum-size.

### Complexity and empirical scope

The paper provides no OutputP, IncP, polynomial-delay, or total-runtime
classification. Unsatisfiable-core minimization is local; globally smallest
cores are described as too costly. The central claim is empirical.

The evaluation uses 97 one-output circuit instances across EPFL, fuzzed,
ISCAS85, and industrial static-timing families, with a one-hour timeout.
`ROC` solves 94 instances and obtains the best PAR-2 and normalized DNF-size
quality among the evaluated configurations. The experiments also show that
solver choice, forward versus backward ternary generalization, and core
minimization materially affect the result (Section 5, Article 13:8--13:12).

### Motivating example

Figure 2 has inputs `a,b`, internal gates for `a and b` and `a and not b`, and
an output that is their disjunction. The cube `{a=1}` entails the output:
either value of `b` activates one of the two terms. Ternary simulation leaves
both terms and the output at `X`, so the same cube does not satisfy the
circuit. This is a compact demonstration that native propagation can miss a
semantically valid short region (Article 13:2--13:3).

The example is useful for our paper, but it exposes logical input don't-care,
not structural inactivity. Both `b` completions remain relevant alternatives;
no internal selection site is omitted because its containing case is outside
an enabled closure.

### Evidence locations

- Figure 2 and Section 1, Article 13:2--13:3: entailing but non-satisfying
  circuit cube.
- Definition 1, Article 13:4: ternary circuit simulation.
- Definitions 2--3 and Lemma 4, Article 13:5--13:6: generalization hierarchy
  and strict separators.
- Section 4 and Algorithm 1, Article 13:6--13:8: exact DNF contract,
  enumerate-generalize-block loop, CORE, ROC, and the non-disjoint scope.
- Section 5, Article 13:8--13:12: benchmarks, metrics, ablations, and results.
- Section 6, Article 13:12: scope and proposed extensions.

## Bearing on RQs

What is directly established by the work: circuit-native ternary simulation,
CNF gate satisfaction, and semantic entailment induce genuinely different
generalization powers. Entailment can produce exponentially more compact
coverage than a propagation-based notion in the surrounding partial-assignment
literature, and it works directly in an exhaustive
enumerate-generalize-block architecture.

Our interpretation or inference: an exact observation fiber is stronger and
differently typed than an entailing input cube. A fiber fixes one
graph-intensional observation and is one cell of a pairwise-disjoint partition
of the caller domain. An entailing AllSAT cube only says that all of its
inputs force output `1`; two such cubes may overlap and may combine many
different internal selection observations.

The paper's `X` is also distinct from our inactive marker. `X` permits both
Boolean completions of a caller input or gate abstraction. Inactivity says
that a graph site does not belong to the enabled closure for that concrete
observation. Logical generalization can erase distinctions among observed sites;
observation enumeration deliberately retains them.

Could it subsume our proposed contribution: it subsumes claims of first
applying entailment-based partial assignments to circuit enumeration, first
exploiting the difference between graph propagation and semantic coverage, or
first combining native circuit generalization with iterative blocking.
Together with projected partial-model work, it makes a broad algorithmic
novelty claim untenable.

It does not define a selector-site observer, enabled closure, graph-relative
observation equivalence, exact disjoint fibers, guarded residual values, or
compositional summaries of such observations. Those remaining objects are a
cross-literature formal synthesis, not automatically an original algorithmic
contribution.

## Evidence limits

- Correctness is inherited from the cited generic blocking scheme rather than
  isolated as a theorem for Algorithm 1.
- Output quality is defined as fewer cubes, but no minimal-cover guarantee or
  representation-normalized comparison is given.
- The paper does not analyze output-sensitive complexity or solver-call delay.
- Overlapping covers cannot by themselves serve as a unique enumeration of
  equivalence classes.
