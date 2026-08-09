---
citekey: krafczyk2017effective
work:
  title: "Effective Infinite-State Model Checking by Input Equivalence Class Partitioning"
  author: "Niklas Krafczyk, Jan Peleska"
  venue: "ICTSS 2017"
  date: 2017
  doi: 10.1007/978-3-319-67549-7_3
read: full-text
source: "Author-deposited ICTSS 2017 paper via https://doi.org/10.1007/978-3-319-67549-7_3, pp. 38–53 (open copy: https://inria.hal.science/hal-01678956)"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Constructs the coarsest input-equivalence-class partition of an infinite input domain by enumerating satisfiable transition-condition combinations and merging behaviorally indistinguishable classes — the closest generic predecessor for exact input-fiber enumeration of a finite observer"
---

# Effective Infinite-State Model Checking by Input Equivalence Class Partitioning

## Evidence

### Why it matters

Krafczyk and Peleska construct an exact finite partition of a possibly infinite
input domain according to what transition behavior every finite state/output
class observes. They enumerate satisfiable combinations of transition
conditions, disjointify them, take satisfiable products across state classes,
and finally merge behaviorally indistinguishable classes to obtain the
coarsest input-equivalence-class partition (IECP).

This is the closest generic predecessor yet found for “enumerate exact input
fibers of a finite observer.” It defeats broad novelty claims about exact
equivalence-class enumeration, finite abstraction of an infinite input domain,
solver-pruned enumeration of predicate combinations, disjoint exhaustive
guards, or post-enumeration coarsening.

### System and equivalence relation

The model is a livelock-free input/output state-transition system (IOSTS).
Inputs may have infinite domains; internal state variables and outputs have
finite domains. Quiescent states are first quotiented into a finite `MO`
partition according to identical internal-state and output valuations.

For a state class $A_i$ and input $c$, the semantic observation is the set of
`MO` classes reachable after the finite transient response. Nondeterminism
therefore yields a set of destinations. An IECP is valid when all inputs in one
class induce the same destination-class set from every source state class.

If $g_{i,j}$ denotes the condition under which state class $A_j$ is reachable
from $A_i$, then the per-source observation is the truth pattern of the finite
family $G_i=\{g_{i,j}\}_j$, equivalently its set of true conditions.

### Enumeration algorithm

**Algorithm 1** recursively enumerates every satisfiable subset $p\subseteq
G_i$. Unsatisfiable prefixes prune their supersets. Because one satisfiable
set can be contained in another under nondeterminism, it augments $p$ with
negations of conditions belonging to satisfiable supersets and keeps the
result only if satisfiable. The resulting positive/negative formulas are
pairwise disjoint classes for state $A_i$.

**Algorithm 2** forms the global partition. It recursively chooses one local
class from every state class, conjoins their formulas, and emits exactly the
satisfiable intersections. Processing the smallest local partitions first lets
an unsatisfiable prefix prune the largest product suffix. The paper emphasizes
that every satisfiable product must be found or the input cover would be
incomplete.

The resulting formulas are mutually disjoint and cover the input domain under
the system assumptions. A finite transducer uses the classes as input symbols.
Transducer minimization can then merge symbols whose transitions have the same
target and output from every minimized state; the union of their input regions
is the coarsest IECP.

### Complexity boundary

Algorithm 1 searches subsets of each $G_i$, so it has an immediate
$2^{|G_i|}$ worst-case candidate space. Algorithm 2 searches a product of
local class counts, $\prod_i |M_i|$. SMT-unsatisfiable prefixes can prune both
spaces but do not change these worst-case exponential bounds. The paper gives
the exact size of a product subtree skipped by one failed prefix and reports
large empirical speedups over explicit input discretization; it does not claim
OutputP, IncP, or polynomial delay.

Transducer construction/minimization adds cost in the finite number of state
and input classes. Formula serialization and union after merging are not
analyzed as enumeration output size.

### Reduction from selection observations

Instrument a pure graph as a one-step transition system whose finite visible
output is the totalized selection-observation vector

\[
  \overline\Omega_{G,R}(x)
  \in\prod_{q\in Q}(\{\bot_q\}\cup\Omega_q).
\]

With one stable source class and one observable destination/output code per
realizable vector, the coarsest IECP is extensionally exactly

\[
  X/{\sim_\Omega},
  \qquad
  x\sim_\Omega y\iff
  \overline\Omega_{G,R}(x)=\overline\Omega_{G,R}(y).
\]

### Evidence locations

- Section 2.1, paper pp. 40--42: IOSTS and finite `MO` state classes.
- Section 2.2, pp. 42--47: IECP definition, Algorithms 1--2, disjointification,
  exhaustive satisfiable-product enumeration, and product pruning.
- Section 2.3, pp. 47--49: transducer construction, minimization, and coarsest
  IECP.
- Section 3, pp. 49--52: experiments against explicit-discretization model
  checking.

## Bearing on RQs

This is a genuine semantic reduction of the partition object. It does not yet
give a competitive construction from the original graph: supplying one
transition condition per observation code may presuppose the image we want to
enumerate. Alternatively, exposing every site-activity/outcome predicate as a
fixed condition family yields Boolean atoms that may refine the fibers and
must be projected/merged. The graph-specific algorithm can therefore still
contribute an intensional, incremental construction, but not a new kind of
equivalence partition.

The IOSTS result also does not emit a symbolic residual of the graph's ordinary
output. That can be appended to the visible output, but equality of symbolic
functions is stronger than equality of finite concrete outputs and falls
outside the paper's finite-output model.

Safe claim:

> Selection-observation fibers are a stateless, graph-intensional instance of
> exact input equivalence class partitioning. Our possible contribution is a
> structure-directed enumeration and residualization theorem that avoids
> predeclaring all observer classes, not the existence of the partition.

## Evidence limits

- Finite internal-state and output domains and livelock freedom are essential.
- Transition conditions $g_{i,j}$ are assumed obtainable from the model.
- The enumerated behavior is global across every state class, not relative to
  requested pure-graph roots.
- The classes record extensional transition behavior, not intensional site
  identities or structural non-observation.
- Coarsest merging is by finite transducer behavior, not by equality of
  symbolic residual functions.
