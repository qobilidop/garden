---
citekey: copia2022lissa
work:
  title: "LISSA: Lazy Initialization with Specialized Solver Aid"
  author: "Juan Manuel Copia, Pablo Ponzio, Nazareno Aguirre, Alessandra Gorla, Marcelo F. Frias"
  venue: "ASE 2022"
  date: 2022
  doi: 10.1145/3551349.3556965
read: full-text
source: "ASE 2022 paper via https://doi.org/10.1145/3551349.3556965"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "LISSA's SymSolve prunes partial-heap prefixes via an existential feasibility oracle — a close algorithmic analogue of demand-driven partial-state pruning — though it returns paths and test heaps rather than enumerating equivalence classes of inputs under an observation function"
---

# LISSA

## Evidence

### Why it matters

LISSA replaces the declarative heap specification required by BLISS with
`SymSolve`, a bounded-exhaustive solver that asks whether a partially symbolic
heap can be completed to a concrete heap accepted by its ordinary executable
`repOK`. The target program initializes fields only when they are accessed;
SymSolve explores completions only to decide whether the current partial heap
has at least one valid extension.

This is a close algorithmic analogue of maintaining a partial object,
expanding a demanded coordinate, and using an existential feasibility oracle
to prune it. It does not, however, enumerate equivalence classes of inputs
under an observation function.

### SymSolve and LISSA

Given a partial heap $H$, an executable invariant `repOK`, and finite object
scopes, SymSolve searches the concrete completions of $H$. Like Korat, it
observes which fields `repOK` reads, systematically assigns a feasible value,
and prunes candidate prefixes that already make `repOK` return false. It also
uses canonical allocation to avoid isomorphic heaps. It returns one valid
completion as a witness or exhausts the bounded completion space and reports
unsatisfiable.

LISSA invokes SymSolve on partial heaps produced by lazy initialization. An
unsatisfiable result prunes the corresponding program path. Memoization and a
variant that invokes the solver only after selected events reduce repeated
work.

The search is complete only for the user-provided finite scopes. The paper
states that SymSolve's pruning is sound and that LISSA never removes a valid
path. The implementation argument relies on Korat-style exhaustive completion
and symmetry breaking; unlike the 2023 successor, it does not present a
numbered theorem equating the explored symbolic states with LI under the joint
heap and primitive path constraints.

### Complexity boundary

SymSolve may enumerate exponentially many heap completions for every partial
heap. The paper explicitly notes the potentially exponential intermediate
structures and evaluates runtime, paths, and maximum reachable scope rather
than deriving an output-sensitive bound. Symmetry breaking avoids isomorphic
concrete heaps but does not quotient states by observed program behavior.

### Evidence locations

- Sections 1--2, paper pp. 1--4: LI, partial-heap satisfiability, and Korat.
- Section 3, pp. 4--7: SymSolve's demanded-field search, sound symmetry
  breaking, and LISSA integration.
- Section 4, pp. 7--10: empirical evaluation and exponential memory tradeoff.
- Section 5, pp. 10--11: separation of heap and primitive path conditions.

## Bearing on RQs

The closest common pattern is existential continuation:

\[
  \text{keep partial state }p
  \quad\Longleftrightarrow\quad
  \exists x\in\gamma(p).\;x\text{ is valid}.
\]

Our enumeration uses the same kind of question to reject impossible
site-outcome prefixes. It additionally needs to establish exactly which
observation the remaining inputs share and to combine every surviving fragment
with the same observation into one exact guard.

The `repOK` access trace is not the program-under-test selection observation.
It is an operational strategy for solving the heap invariant; two executions
that expose the same graph selectors can cause different `repOK` accesses,
and conversely. LISSA returns paths and test heaps, not a residual symbolic
function for each observer fiber.

## Evidence limits

LISSA keeps two feasibility components separate:

- SymSolve checks whether the symbolic heap satisfies `repOK`; and
- the symbolic executor checks the primitive path condition.

A heap completion can satisfy `repOK` while no assignment simultaneously
satisfies the program path condition. LISSA may therefore preserve infeasible
combined states and produce false positives. Precise Lazy Initialization was
introduced specifically to close this gap.
