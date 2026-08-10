---
citekey: kim2013splat
work:
  title: "SPLat: Lightweight Dynamic Analysis for Reducing Combinatorics in Testing Configurable Systems"
  author: "Chang Hwan Peter Kim, Darko Marinov, Sarfraz Khurshid, Don Batory, Sabrina Souto, Paulo Barros, Marcelo d'Amorim"
  venue: "ESEC/FSE 2013"
  date: 2013
  doi: 10.1145/2491411.2491459
read: full-text
source: "Author-hosted ESEC/FSE paper, https://mir.cs.illinois.edu/~marinov/publications/KimETAL13SPLat.pdf"
retrieved: 2026-08-09
notes-by: Codex (publication-review revision)
notes-date: 2026-08-09
synthesis: "SPLat demand-populates a stack of accessed configuration variables, uses SAT to retain feasible partial assignments, and executes one configuration per distinct reachable test trace — a close demand-guided exploration precedent without exact symbolic fiber guards or residuals."
---

# SPLat: Lightweight Dynamic Analysis for Reducing Combinatorics in Testing Configurable Systems

## Evidence

### Why it matters

SPLat is a close precedent for exploration controlled by a sparse set of choices
actually consulted during execution. For one fixed test, it monitors reads of
configuration variables, backtracks only over variables reached on the current
trace, and treats unread variables as irrelevant to that execution. This is
nearer to demand-populated selection records than generic test sampling or
static cone analysis.

### Program and observer

The program has finite-valued configuration variables and a feature model that
defines valid complete configurations. A test fixes all nonconfiguration
inputs. Two configurations are redundant for this testing objective when they
execute the same bytecode trace. The introduction calls one configuration per
unique trace a revealing subdomain for the test.

The observer is therefore an execution trace under configuration inputs, not a
requested-root map of contextual graph selections. It can retain distinctions
from ordinary control flow and effects, while it need not attach symbolic
values to the trace.

### Algorithm

Figure 4 maintains a concrete feature assignment and a stack ordered by first
read. A newly read optional feature is pushed; SAT checks whether the current
partial assignment is extendable to a valid configuration and flips the
initial false value when necessary. After one test execution, depth-first
backtracking changes the last reachable decision whose true branch remains
unexplored, skipping unsatisfiable prefixes.

The current stack and values describe a cylinder of valid configurations:
variables not read by the execution remain unconstrained. Each execution also
provides a concrete representative. The implementation does not emit the
cylinder as an SMT guard API, compute a symbolic residual for the test output,
or group traces modulo logical equivalence.

### Guarantee and boundaries

The paper repeatedly describes the reduction as optimal because SPLat executes
one configuration per distinct reachable trace and covers all valid
configurations represented by the reached partial assignments. The algorithm
text gives the satisfiability/backtracking argument, but there is no numbered
soundness, completeness, or nonredundancy theorem.

Correct re-execution requires a reset operation that restores initial program
state. External effects can make simply restarting a runtime unsound, and the
paper requires the user to provide the needed reset behavior. The Groupon case
study also caps exploration at sixteen configurations for 2,695 tests, so that
industrial experiment is not exhaustive evidence.

### Evidence locations

- Abstract and Section 1, pp. 257--259: unique-trace objective, optimality
  claim, feature constraints, and contributions.
- Sections 3.1--3.3 and Figure 4, pp. 259--262: partial assignments, SAT
  interface, accessed-variable stack, backtracking, and worked coverage.
- Sections 3.4--3.6, pp. 262--263: reset assumption, incremental-solver
  opportunity, and implementation.
- Sections 4.1--4.3, pp. 263--266: experiments, industrial exploration cap,
  and validity threats.
- Section 5, pp. 266--267: Korat, shared execution, sampling, and static
  analysis comparisons.

## Bearing on RQs

What is directly established by the work: demand-populated configuration
decisions, feasible partial-assignment cylinders, concrete witnesses, and
exhaustive reachable-trace exploration under the stated reset and feature-model
assumptions.

Our interpretation or inference: if each configuration read corresponded to a
static selection site and the test trace were restricted to requested-root
enabled closure, SPLat's stack would be an operational discovery mechanism for
a sparse selection record. That correspondence is not proved, and stack order
is extra information absent from the survey's unordered observation map.

Could it subsume our proposed contribution: it subsumes broad claims of first
demand-guided enumeration over dynamically consulted finite choices. It does
not provide exact symbolic input guards, residual functions, contextual DAG
site identity, or one canonical record per selection-observation fiber.

## Evidence limits

- “Optimal” is relative to distinct concrete execution traces for one test, not
  to the survey's selection observer or to logically minimal guards.
- The algorithm is described and justified but not packaged as a numbered
  end-to-end theorem.
- Re-execution correctness depends on reset behavior for state and effects.
- The evaluation is empirical; the industrial run deliberately caps some
  configuration explorations.
