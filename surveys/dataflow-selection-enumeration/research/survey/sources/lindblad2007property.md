# lindblad2007property — Property Directed Generation of First-Order Test Data

- **Status:** deep-read; critical partial-cylinder predecessor
- **Primary record:** https://research.chalmers.se/publication/111863
- **Version read:** author manuscript presented at TFP 2007; proceedings
  volume 8 published in 2008
- **Open copy:**
  https://web.archive.org/web/20221011155516id_/http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.116.2439&rep=rep1&type=pdf
- **Bibliography key:** `lindblad2007property`

## Why it matters

Lindblad's generator is the closest semantic predecessor for partial input
cylinders. It starts a pure Boolean property on an entirely unknown
first-order algebraic input, refines a metavariable only when evaluation is
blocked on it, and returns immediately when the observer becomes `true`. Its
output is explicitly a **partial constructor term** (PCT); every remaining
metavariable denotes all total constructor refinements of that term.

This predates Lazy SmallCheck and defeats claims of first property-directed
refinement, first exact partial-term representation of many satisfying inputs,
or first use of parallel Boolean evaluation to discover a result before every
input component is known.

## Language and partial reduction

The core is a lazy first-order functional language with algebraic datatypes,
constructor-complete case expressions, metavariables, and `select-case` terms.
Several cases in a `select-case` reduce in parallel; the evaluator may continue
with any case whose scrutinee becomes a constructor. If every case is blocked,
the result records the union of blocking metavariables.

A closure maps refined metavariables to constructor applications whose
arguments are fresh metavariables. Head reduction produces either a
constructor or `blkd_M t`. It preserves the set $M$ of unknown positions whose
constructors could unblock the current observer calculation.

Parallel conjunction is the motivating example. If either side becomes
`false`, the entire result becomes known even when the other side remains
unknown. This can remove a large constructor subtree, subject to the
source-language requirement that parallel alternatives define the same
function.

## Search and emitted object

For a predicate $t[x]$ over algebraic type $\tau$, `init` replaces $x$ by a
fresh metavariable. Search then applies three rules:

- on `true`, `compose` returns the current PCT, retaining every uninstantiated
  metavariable;
- on `false`, it backtracks; and
- on `blkd_M t`, it chooses one $m\in M$, refines $m$ by each constructor of
  its type, partially re-evaluates, and recurses.

The choice of blocker is operational. The implementation uses a fair queue,
incremental re-evaluation of only terms blocked by the changed metavariable,
depth bounds, and iterative deepening for recursive types.

For a PCT $p$, let $\gamma(p)$ be its set of total ground constructor
instances. The paper defines $u\subseteq v$ by
$\gamma(u)\subseteq\gamma(v)$. Hence each returned PCT is explicitly a
symbolic cylinder of total satisfying values, not merely a search prefix.

## Correctness status

Because `select-case` may choose among parallel evaluation paths, the paper
defines $mhn(t)$ as all possible head-reduction results. Its proposed conditions
are:

- soundness: for every returned PCT $u$, `true` belongs to
  $mhn(t[x:=u])$; and
- completeness: for every PCT $u$ whose every reduction is `true`, some
  returned $v$ satisfies $u\subseteq v$.

The paper explicitly says these properties were not proved. It relies on the
user ensuring the parallel alternatives are extensionally consistent. The
conditions also do not state that returned cylinders are disjoint, maximal, or
unique; different blocker schedules can fragment the same satisfying region.

## Performance boundary

Experiments compare search sizes for finite groups, leftist heaps, strongly
connected graphs, regular expressions, and typed terms. Favorable examples
show two-to-three-order-of-magnitude reductions over unguided generation. No
general OutputP, DelayP, or solver complexity result is given; strict or weakly
constraining observers can still expose the whole bounded constructor space.

## Exact relationship to selection observations

Replace the Boolean predicate by equality with a target observation,
$\Omega_{G,R}(x)=o$. Lindblad's search then emits PCT cylinders contained in
that fiber. Unlike Korat, it emits the partial cylinder itself rather than every
represented total input. Unlike our target result, however:

- the target observation $o$ is presupposed rather than discovered;
- several PCTs can cover fragments of one fiber;
- no formula unions them into the exact full inverse image;
- no stable graph selection-site identity is part of the partial input;
- no symbolic residual graph value is returned; and
- exhaustiveness for infinite recursive inputs depends on external bounds and
  fairness, not merely finite observer range.

The closest adaptation would let the observer return an observation code and
group PCTs by that code. This inherits sound cylinders but still needs exact
fiber aggregation, duplicate suppression, residualization, and termination.

Safe claim:

> Lindblad establishes property-blocked refinement and partial constructor
> terms representing sets of satisfying total inputs. Our remaining target is
> one exact graph-observer fiber and residual per realizable observation, not
> partial-input cylinder discovery itself.

## Evidence locations

- Sections 1--2, manuscript pp. XXI-1--XXI-3: motivation, lazy instantiation,
  parallel evaluation, and functional-logic relationship.
- Sections 3.1--3.3, pp. XXI-4--XXI-6: metavariables, closures, blocked sets,
  and partial reduction.
- Section 3.4 and Figure 3, pp. XXI-6--XXI-7: search algorithm and PCT output.
- Section 3.5, pp. XXI-7--XXI-8: represented-ground-instance inclusion and
  unproved soundness/completeness conditions.
- Sections 3.6--4, pp. XXI-8--XXI-12: implementation and empirical search
  reductions.

