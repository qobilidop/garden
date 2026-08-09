# li2004solall — SAT all-solutions preimage compilation

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1109/DATE.2004.1268860
- **Version read:** DATE 2004 proceedings PDF from the SIGDA proceedings
  archive
- **Bibliography key:** `li2004solall`

## Why it matters

SOLALL sits at the intersection of circuit SAT, existential projection,
partial solution cubes, search-subspace sharing, and canonical OBDD output. It
therefore constrains broad novelty claims about using all-solutions search and
decision diagrams together. Its actual output is a Boolean preimage over
state variables, not an enumeration of graph-intensional selector
observations.

## Program and semantic model (RQ1, RQ7)

The input is a finite Boolean sequential circuit encoded as structurally
ordered CNF for a target objective. Primary inputs (PIs) and current-state
flip-flops (FFs) are decision variables; primary outputs and next-state
variables may be objectives. Multiple objective cones may be merged.

The desired preimage is the set of FF valuations for which *some* PI valuation
satisfies the target. Thus PI removal is existential projection. The proofs
depend on circuit structure retained in CNF: each gate's output variable is
the first literal of its clauses, decisions start from PIs and FFs, implied
gates are justified, and X-path reachability to the objective identifies the
still-relevant circuit region. The domain is finite and Boolean; there are no
program effects, residual data values, or unbounded execution semantics.

## Represented and emitted objects (RQ2, RQ3, RQ5)

The *search space* is the space containing all feasible solutions. A
*candidate solution* is a vector of valued variables sufficient to satisfy all
CNF clauses. Static objective-cone restriction omits variables that cannot
affect the target. Dynamic X-path analysis can leave additional variables
unvalued when their values no longer affect satisfaction.

The search initially produces a free BDD: decision nodes contain PI or FF
variables, edges may carry implied assignments, terminal nodes denote
satisfaction or conflict, and a *jump* shares a previously explored subgraph
when equal frontier cut sets identify equal remaining search subspaces.

Quantified Jump Back (QJB) avoids enumerating PI-only refinements once a
satisfying valuation is found. Remaining implied PIs are removed from edge
labels. The projected result is therefore a Boolean preimage function over FF
variables, not a list of PI/FF total models. For a fixed requested variable
order, SOLALL can constrain decisions to that order and convert the free BDD
to an OBDD representing the same preimage.

## Algorithm

1. Restrict the structural CNF to the fan-in objective cone and prioritize PI
   and FF decisions.
2. At each search point retain the frontier of valued gates in the objective
   cone. Use equal frontier cut sets to detect an already solved subspace and
   insert a graph jump instead of re-exploring it.
3. Combine conflict-driven clauses with this type-II success-driven sharing.
   Original structural clauses are marked; learned conflict clauses remain
   unmarked and are excluded from cut-set computation so learning cannot
   perturb the structural subspace key.
4. Prefer FF decisions before PIs. Once search reaches a PI-only region and
   finds satisfaction, use QJB to skip its remaining PI refinements.
5. Store decisions in free-BDD nodes and implications on edges, then erase PI
   labels. For OBDD output, force the chosen decision order, expand shared
   jumps to a tree, push implied FF variables down into that order, and turn
   them into BDD nodes.

## Guarantees and non-guarantees (RQ4)

Lemma 1 and Proposition 1 justify restricting the live search to unvalued PIs
and FFs at the ends of X-paths to the objective. Lemmas 2 and 3 justify deleting
CNF clauses outside that region. Theorem 1 states that the frontier of all
valued nodes inside the objective cone uniquely determines the remaining
search space; this is the formal basis for free-BDD subgraph sharing.

The paper claims that SOLALL returns all preimage solutions and that each of
the three free-BDD-to-OBDD conversion steps preserves the represented
solutions. The conversion proof is explicitly omitted as “lengthy.” There is
no separate formal completeness theorem for the whole solver or QJB, although
the construction and experiments treat the projected preimage as exact.

Canonicity belongs only to the final reduced ordered representation under a
fixed variable order. The free BDD and search are not canonical. The paper
does not claim a unique enumeration of solution cubes, cube minimality, or
pairwise disjoint emitted records. Root-to-true OBDD paths describe disjoint
decision regions by standard BDD semantics, but the API object is one shared
Boolean function rather than an explicit region enumeration.

## Complexity and redundancy avoidance (RQ6)

SOLALL avoids redundant search by objective-cone slicing, dynamic X-path
pruning, memoizing solved subspaces by smaller structural frontier cut sets,
combining success- and conflict-driven learning, existentially skipping PI
refinements, and sharing the result as a free BDD. This is a direct precedent
for compiling all solutions while avoiding one blocking clause per model.

The paper notes that naive all-solutions search can require exponential time,
OBDD memory can be exponential, and general free-BDD-to-OBDD conversion is
NP-hard. Its ordered-search construction is practical but does not establish a
polynomial or output-sensitive bound. Experimental tables report that SOLALL
finishes the tested ISCAS89 preimages in under one second with at most 14.1 MB,
where a type-I blocking solver aborts on several 128 MB cases; these are
empirical results for selected EG properties, not worst-case guarantees.

## Motivating examples (RQ8)

Figure 1 contrasts a few large satisfying cubes with many smaller cubes,
motivating success-driven pruning. Figure 2 shows two decision-tree locations
with the same remaining search subspace; equal cut sets permit one location to
jump to and share the other's solved graph. Figure 3 distinguishes the static
objective cone from the current X-path region and frontier.

Figures 5 and 6 make the projection distinction explicit: FF decisions sit
above PI-only search regions; QJB skips PI refinements, while implied PI labels
are removed from edges. The surviving free BDD represents current states, and
the subsequent ordered conversion represents the same projected preimage as a
canonical Boolean function.

## Relationship to our hypothesis

### What is directly established by the work?

All-solutions SAT search can compile a projected circuit preimage into a
shared decision graph, memoize semantically identical remaining search spaces
using structural cut sets, remove PI variables existentially, and produce a
fixed-order OBDD.

### What is our interpretation or inference?

PI projection is analogous to hiding non-observation variables, and a
frontier-keyed jump is analogous to memoizing equal residual problems. But the
retained coordinates are all FF state variables, selected externally by the
preimage problem; they are not dynamically active selector occurrences. The
terminal object is a Boolean set of states, not one record per sparse
observation paired with a residual value.

### Could it subsume our proposed contribution?

It subsumes broad claims of first combining all-solutions SAT, existential
projection, dynamic omission, search DAG sharing, or canonical OBDD output in
hardware verification. It does not define selector-site observations, demand
closure, residual output functions, or an output-sensitive enumeration of
observation fibers. General AllSAT/OBDD and modern projected-enumeration
sources already cover its conceptual cluster more broadly. After full reading
SOLALL should remain a high-value deep-read comparison, but not a critical
competitor requiring a separate closure chase.

## Evidence locations

- Section 1 and Figure 1, proceedings pp. 272–273: all-solutions objective,
  type-I versus type-II learning, and output overview.
- Sections 2–3, Figures 2–3, Definitions 1–3, Lemmas 1–3, Proposition 1, and
  Theorem 1, pp. 273–275: free BDD, objective cones, X-paths, reduced cut sets,
  and subspace identity.
- Section 4 and Figure 4, p. 275: marked structural CNF combined with conflict
  learning.
- Section 5 and Figures 5–6, pp. 275–276: QJB, PI projection, and edge-carried
  implications.
- Section 6, p. 276: NP-hard general conversion and the three ordered
  conversion steps; correctness proof omitted.
- Section 7 and Tables 1–2, pp. 276–277: experimental time and memory results.

## Questions and possible weaknesses

- The exact soundness conditions for QJB are explained operationally rather
  than isolated as a theorem.
- The conversion's correctness proof is omitted, so canonicity must be
  qualified as the standard property of the resulting reduced OBDD under its
  fixed order, not a new proved property of the free BDD.
- The experiments compare representations and machines imperfectly and do not
  include output serialization or general worst-case behavior.
