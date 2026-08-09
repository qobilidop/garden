# kaivola2025causalfanin — Timed Causal Fanin Analysis

- **Status:** deep-read; critical enabled-closure predecessor
- **Primary source:** https://doi.org/10.1007/s10703-025-00478-1
- **Detailed open source:** https://doi.org/10.34727/2022/isbn.978-3-85448-053-2_16
- **Version read:** 2025 journal metadata, abstract, and publisher preview;
  detailed technical analysis uses the official open-access 2022 FMCAD version
  of record
- **Bibliography keys:** `kaivola2025causalfanin` (expanded journal article),
  `kaivola2022causalfanin` (conference precursor)

## Version boundary

The 2025 Formal Methods in System Design article is the current, expanded
treatment: volume 67(1), pp. 3--26, published online 16 May 2025. Its abstract
states the same central method and FP16 application as the 2022 FMCAD paper.
The full 2025 text was not accessible in the research environment: the
publisher PDF endpoint returned an HTML access page and the available
publisher preview exposed only the first page. Consequently, claims below
about definitions, algorithms, safety, and evaluation are attributed to the
official nine-page 2022 version, not silently projected onto unseen portions
of the expansion. The 2025 article should be cited for the current publication;
the 2022 paper should remain cited wherever a claim depends on the detailed
text inspected here.

The same boundary applies to bibliography chasing. The exact 2025 reference
list was not exposed by the publisher preview, so
`precursor-kaivola2025causalfanin-backward.tsv` is explicitly a fallback
transcription of all 11 references in the official 2022 precursor. It must not
be described as the unseen 2025 bibliography. OpenAlex resolves the exact
2025 DOI to work `W4410434116`, with the journal title *Timed causal fanin
analysis for symbolic simulation*, both authors, and year 2025; it reports zero
forward citations at capture time, hence the exact-DOI forward snapshot has a
header and no result rows.

## Why it matters

Timed causal fanin is a direct hardware precedent for an input- or
property-sensitive enabled closure. Starting at time-indexed signals in a
verification goal, it follows only combinational and sequential dependencies
that may matter under values learned from a preliminary symbolic trace. In
particular, a mux with a concrete selector contributes only its selected data
input. This is much closer to our enabled-edge reachability than ordinary
static cone-of-influence slicing.

It does not, however, observe the selected mux outcomes, partition the input
space by those observations, or enumerate exact guards and residuals.

## Circuit and symbolic model

The source model is a synchronous sequential circuit containing combinational
gates and flip-flops. Verification focuses on one fixed, bounded transaction,
typically

\[
\text{trigger }A\text{ at }t
\Longrightarrow
\text{response }B\text{ at }t+n.
\]

A trace assigns each signal at each cycle either a concrete Boolean, a BDD
expression over symbolic stimulus variables, or the undefined value `X`.
Symbolic variables range exactly over Boolean values; `X` represents lost
information and overapproximates both values. Replacing a computed signal by
`X` is called *weakening*.

The trigger is compiled into the stimulus using parametric substitution. The
resulting symbolic inputs range exactly over trigger-satisfying assignments.
BDD canonicity and simplification then expose both directly and indirectly
implied cycle-specific constants in internal control logic.

## Formal object

Let the preliminary trace give a value to each signal-time pair. The 2022
paper defines two local dependence relations.

For a combinational output signal \(s\) at cycle \(t\), its causal fanin
contains an immediate input \(s_{in}\) when either:

- \(s_{in}\) has a concrete `0` or `1` in the preliminary trace; or
- given the concrete values of the other fanins, changing \(s_{in}\) may
  affect \(s\).

Thus a mux with concrete selectors retains its control and selected data input,
but not unselected data inputs.

For a flip-flop with data input \(s_{in}\), clock \(c\), and held output
\(s_{ff}\), the predecessor at cycle \(t\) is:

- \(s_{in}\) if \(c\) toggles;
- \(s_{ff}\) if \(c\) does not toggle; and
- both if \(c\) is `X`.

For every cycle, \(\operatorname{cfan}(t)\) is the least set satisfying three
closure rules:

1. time-indexed signals referenced by the verification goal are included;
2. a required flip-flop at \(t+1\) adds its flip-flop causal fanin at \(t\);
3. a required combinational output adds its combinational causal fanin in the
   same cycle.

The within-cycle closure stops at flip-flop boundaries; the second rule moves
the traversal backwards in time.

## Algorithm

The method has three passes.

1. Run a preliminary symbolic simulation with the same parametrized stimulus
   and a low dynamic-weakening threshold. Large symbolic expressions become
   `X`, while inexpensive trigger-implied constants remain visible.
2. Traverse backwards from the verification goal and compute every
   \(\operatorname{cfan}(t)\) using the trace-dependent local relations.
3. Run the full symbolic verification after weakening every signal-time pair
   outside the computed sets to `X`. An optimization weakens only the boundary
   feeding the retained cone.

The preliminary run is not merely timed constant propagation: constants can
follow from the combination of the trigger, parametric substitution, circuit
logic, and canonical BDD simplification.

## Guarantees

The 2022 paper states that weakening is safe: proving a property on the
weakened trace implies it on the unweakened trace with the same stimulus. It
also argues that the timed causal fanin contains every signal-time pair that
may contribute to the goal, so Step 3 never weakens a contributing value.

These are prose arguments grounded in the local rules; the paper does not give
a numbered theorem or a machine-checked proof. The set is minimal among sets
closed under the published rules. That is not a proof that it is a globally
smallest semantic support: unknown values and local `may affect` tests can
retain dependencies that a stronger relational analysis could remove.

Dynamic weakening in the preliminary run sacrifices precision, not safety. If
an internal control remains `X` instead of simplifying to a constant, both
possible dependencies remain in the causal fanin.

## Complexity and performance

The paper gives no asymptotic bound for the complete method. Once the
preliminary values and local fanin relations are available, computing the least
closure is an ordinary backwards reachability problem and is linear in the
visited portion of the time-unrolled circuit graph. This linearity statement is
our inference, not a result claimed by the paper.

The expensive phases are symbolic simulation and discovering constants. BDD
expressions may grow exponentially in the number of symbolic input bits;
dynamic weakening caps individual preliminary expressions by replacing them
with `X`, but can enlarge the retained fanin and does not give an end-to-end
polynomial bound. The full verification can still be capacity-limited.

The FP16 evaluation deliberately does not report time or memory ratios against
an unweakened baseline for the hard cases because that baseline is infeasible.
Instead it reports engineering outcomes: FMA bring-up fell from several
quarters for a higher-precision decomposed proof to a couple of weeks; FP16
division and square root proofs completed in roughly six to eight weeks; and
all FP16 operations, including multiplication, fused multiply-add, division,
and square root, were verified closed box.

## Motivating example

The running circuit combines a one-cycle adder and a two-cycle multiplier on a
shared result path. The property requests a correct add result in the next
cycle when an add is issued now and no conflicting multiply was issued in the
previous cycle.

Parametric substitution makes the current add controls concrete. The previous
`not multiply` condition remains symbolically represented, but internal
control simplification proves the multiplier-valid signal false. Backwards
timed causal fanin therefore follows the adder and shared result logic while
excluding the multiplier datapath. This example is useful for our paper
because static transitive fanin would retain both datapaths, whereas a
trace-conditioned enabled closure does not.

## Relationship to enabled closure and observation fibers

### What is directly established by the work?

- output-rooted, cycle-indexed backwards relevance;
- input/property-sensitive pruning of combinational fanin;
- selected-input behavior for concretely controlled muxes;
- time-sensitive predecessor selection for state elements; and
- safe abstraction of everything outside the retained closure.

### What is our interpretation or inference?

On a time-unrolled mux graph, timed causal fanin is a close analogue of our
enabled closure \(D_G(x,R)\). A concrete mux selector enables its selector edge
and selected case edge; a clock outcome similarly determines which temporal
predecessor is enabled. Establishing literal equality would require fixing an
encoding of gates, clocks, `X`, and ordinary-node operand policy, and is not a
theorem of the source paper.

The source method normally analyzes a symbolic region described by one
verification trigger, not one concrete input. A selector that remains symbolic
causes multiple possible fanins to be retained. Its causal fanin can therefore
behave like a safe union or overapproximation of several per-input enabled
closures.

### Could it subsume our proposed contribution?

It subsumes any broad claim that cycle-sensitive, property-directed circuit
fanin or mux-guided demand is new. It does not define the selection observation

\[
T_G(x,R):Q\rightharpoonup\Omega,
\]

record observed site outcomes, distinguish equal-valued selected alternatives,
or form inverse-image fibers of that deterministic observer. There is one
relevance set for a verification task, not an exhaustive disjoint table of
input guards and residual functions. No complexity result is parameterized by
the number of feasible observations.

## Evidence locations

- 2025 article metadata and abstract: current version, scope, and FP16 claim.
- 2022 Sections II--III, pp. 100--104: symbolic values, `X`, weakening,
  parametric substitution, local causal-fanin rules, least closure, and safety
  argument.
- 2022 Figures 5--8, pp. 103--104: shared adder/multiplier example.
- 2022 Sections IV--V, pp. 105--107: industrial context, complexity limits,
  proof effort, and FP16 results.

## Assessment

This work merits **critical** status for the enabled-closure axis. It is the
closest circuit-specific predecessor found for trace-conditioned backward
reachability through selection and state edges. It does not answer the
observation-fiber or compositional-summary problem, so its critical status
should constrain the demand/relevance claim rather than collapse the paper's
entire thesis.
