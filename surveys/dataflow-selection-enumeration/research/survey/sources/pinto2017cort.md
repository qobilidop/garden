# pinto2017cort — Factored concolic RTL test generation

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1109/TEST.2017.8242038
- **Version read:** author's Virginia Tech M.S. thesis of the same title, an
  expanded primary account of CORT completed before the ITC paper; conference
  metadata and abstract were cross-checked, but the IEEE version of record was
  not openly obtainable
- **Bibliography key:** `pinto2017cort`

## Why it matters

CORT represents a hardware test-generation campaign as a Test Decision Tree
(TDT) whose control nodes record cycle-qualified mutable RTL guards and whose
data nodes carry concrete input vectors. This makes it a plausible competitor
for structural branch observations. Full reading shows that the TDT is a
heuristically discovered test artifact, however, not an exhaustive symbolic
partition of inputs or outputs.

## Program and semantic model (RQ1, RQ7)

The input is sequential Verilog RTL compiled by Verilator to a cycle-accurate
C++ simulator. CORT extracts an AST and a conventional CFG, instruments branch
coverage and branch-ID trace recording, and analyzes a concrete CFG path one
cycle at a time. The program has registers, memory arrays, cycles, and possibly
multiple synchronous clocks; it is not a finite pure dataflow graph.

The user identifies clocks and reset signals, supplies initialization vectors,
and chooses a search configuration. Concrete simulation supplies the state at
which each factored exploration begins. Clock and reset inputs are immutable.
Array indexes are concretized, and an activated input used as an index is
removed from symbolic analysis. The prototype supports signals only up to 64
bits and can terminate on certain uses between two same-cycle blocking
assignments.

## Represented and emitted objects (RQ2, RQ3, RQ5)

A *concrete trace* is the sequence of assignments and guard outcomes executed
for one or more cycles. An *activated variable* is data-dependent on a
cycle-qualified primary-input symbol; an Activation Table maps such variables
to symbolic expressions. Unstimulated values are read from the simulator and
substituted as constants. An *activated guard* uses an activated value, and a
*mutable guard* is one whose negation, constrained by earlier intersecting
guards, is SMT-satisfiable.

One exploration returns a TDT:

- a data node stores zero or more concrete input vectors as *default stimuli*;
- a control node stores a cycle-qualified mutable guard, the concretely taken
  outcome, and one satisfying *mutation stimulus*; and
- its `default` and `mutate` edges distinguish retaining the sampled execution
  from overwriting inputs with that witness.

Local TDTs are stitched at terminal data nodes into a global tree. A reverse
traversal reconstructs one concrete test by collecting default stimuli and
overwriting them with selected mutation stimuli. The final public object is a
concatenation of concrete tests chosen to cover the branches discovered during
the campaign.

This is partial in two senses: only primary-input-stimulated statements on
sampled concrete traces are symbolized, and the TDT includes only mutable
guards discovered by the chosen explorations. Omitted guards are not proved
inactive for an output; they may instead be unstimulated, immutable,
unexplored, concretized, or outside the bounded exploration.

## Algorithm

1. Translate and instrument the RTL, extract its CFG and AST, and perform a
   restricted constant-domain check for some unreachable branches.
2. Simulate each concrete exploration twice: first recover per-cycle paths and
   required concrete reads; then symbolically evaluate only activated
   statements while replaying the same inputs.
3. For each activated guard, negate its predicate and conjoin earlier mutable
   guards that share cycle-qualified inputs. Ask Z3 for mutation stimuli.
4. Re-simulate each mutated test to check that it reaches the intended branch,
   then build the exploration's TDT.
5. Select a terminal node by random-path, coverage-oriented, or target-oriented
   heuristics. Reconstruct a base test to its state, add an overlap of `Q`
   cycles and `R` random cycles, explore, and stitch the returned TDT.
6. Greedily select data-node tests with the most newly covered branches,
   breaking ties by test length, until every *discovered* branch is covered.

## Guarantees and non-guarantees (RQ4)

The primary evidence is algorithmic and experimental, not a semantic theorem.
Each generated mutation witness is concretely replayed before recording, which
supports witness-level reachability for the tested simulator. There is no proof
that all feasible paths, mutable guards, branches, states, or input regions are
found. Stopping and node selection are heuristic; the implementation's
unreachable-branch analysis is explicitly incomplete.

The TDT does not define input predicates for its leaves, exact coverage of the
input domain, or pairwise-disjoint regions. It is neither canonical nor unique:
random stimuli, exploration order, `Q`, `R`, and search heuristics affect it,
and overlap can rediscover mutable guards. It stores concrete witnesses rather
than residual symbolic outputs.

The paper calls the final test “optimal,” but Algorithm 1 is a greedy set-cover
heuristic. No minimality theorem is given, and the evaluation explicitly
observes a longer result caused by greedy accumulation. The defensible claim
is a short test covering every branch discovered in that run, not a globally
minimum test or complete reachable-branch coverage.

## Complexity and redundancy avoidance (RQ6)

CORT avoids constructing whole-trace symbolic path constraints by carrying
symbolic expressions only through activated statements, substituting concrete
values elsewhere, and factoring a long run into bounded explorations. The
state reached by a concrete base test allows analysis to resume far from reset;
overlap controls how much symbolic input influence crosses a factor boundary.

The thesis provides no asymptotic or output-sensitive bound. Larger exploration
radius and overlap expose more guards but increase symbolic work; smaller
values rely more on random stimuli and can miss branches. It reports empirical
speedups and coverage, including 0.12–430.38 seconds and 84.72–100 percent
overall branch coverage in its extended table, but the result depends on
experimentally chosen parameters and iteration budgets.

## Motivating examples (RQ8)

The central example buffers two input bytes, later forms a 16-bit register,
and branches on whether it equals `0xDEAD`. A random trace reaches the false
outcome. Symbolic propagation through only the activated buffer and register
assignments discovers a mutation of the first two input bytes to `0xAD` and
`0xDE`; a TDT control node at cycle 4 records that witness. A later exploration
starts from the mutated state and is stitched onto the empty child.

The `b12` experiment requires more than 500 correct guesses and over 30,000
cycles to reach a winning state. It demonstrates CORT's ability to restart
short symbolic explorations from deep concrete states, but also makes clear
that the global artifact represents a stateful testing campaign rather than a
finite pure expression's exact observation fibers.

## Relationship to our hypothesis

### What is directly established by the work?

Cycle-local dynamic input dependence, concrete substitution, factored
state-based concolic exploration, a TDT of discovered mutable guards and
witnesses, and greedy construction of high-branch-coverage RTL tests.

### What is our interpretation or inference?

A TDT control node resembles a contextual site/outcome record, but it is
qualified by a cycle on one sampled stateful trace. It records one mutation
witness, not the complete guard of all inputs producing that outcome. Concrete
substitution is a dynamic-slicing optimization rather than semantic
output-demand closure.

### Could it subsume our proposed contribution?

No. It subsumes broad claims about input-stimulated RTL slicing, contextual
branch records, factored test exploration, and witness reuse. It does not
enumerate all distinct sparse observations, give their exact fibers or
residual outputs, respect shared pure-DAG identity, or establish coverage,
disjointness, uniqueness, or output-sensitive complexity. After full reading
it should be retained as a high-value comparison, not a critical competitor
requiring its own closure chase.

## Evidence locations

- Thesis Sections 3.1–3.3, pp. 21–31: traces, activation, concrete
  substitution, guard intersection, SMT mutation, and replay.
- Thesis Section 4.1, pp. 36–39, especially Figure 4.1: TDT node meanings,
  reconstruction, and the `0xDEAD` example.
- Thesis Sections 4.2.2–4.2.4, pp. 42–48, especially Figures 4.4–4.6 and
  Algorithm 1: factored exploration, stitching, heuristics, and greedy test
  selection.
- Thesis Section 4.3, pp. 48–54, especially Tables 4.2–4.4: empirical coverage,
  runtime, test lengths, and exploration-length tradeoffs.
- Thesis Section 5.1, pp. 55–57: implementation limitations and the explicit
  observation that the TDT lacks state sharing and should become a graph.

## Questions and possible weaknesses

- The conference version was not openly available; claims above use the
  author's expanded thesis and should cite thesis page numbers when precision
  matters.
- A theorem connecting activated-statement concretization to full RTL
  semantics is absent.
- “Optimal” should not be repeated without qualification because the stated
  selection algorithm is greedy.
