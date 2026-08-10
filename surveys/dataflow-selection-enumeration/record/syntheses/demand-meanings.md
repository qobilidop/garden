# Meanings of demand across the literature

The term does not name one established object. At least six technically
different notions occur in the closest work.

| Tradition | Demand or relevance is | Returned or retained object | Not equivalent to |
|---|---|---|---|
| Pingali--Arvind and Avron--Sasson | requested output-token positions and the least legal computation sufficient to define them for fixed stream inputs | reverse demand streams or the least output-complete legal valuation | enumeration of projected selection observations as inputs vary |
| Anand et al. | usefulness of unexplored function paths for reaching one target location | partial summaries, calling contexts, and a target witness | backward value dependence or all-observation enumeration |
| Antoy et al., Echahed, and the Fair Scheme | a redex that every constructor-normalizing continuation must eventually reduce | narrowing derivation, result value, and a computation-local choice fingerprint | one input's selected graph slice or static site map |
| Gligoric et al. | a suspended finite value reaching a non-copy use that requires a concrete visible value | concrete execution state with shared forced values and remaining suspensions | semantic relevance of a selector outcome or backward demand from requested roots |
| Runciman et al. (Lazy SmallCheck) | a tagged constructor hole forced while evaluating a Boolean property | a known Boolean over every bounded refinement, or the next demanded position | a canonical semantic fiber or graph-site observation |
| BLI/BLISS/LISSA/PLI | first access to a symbolic heap field; solver work may additionally demand `repOK` fields | a feasible partial heap/path state representing bounded completions | omission of a selector outside a requested enabled closure |
| Xia et al. | requested definedness of an output partial value | least sufficient input approximation and cost | internal selector-site history |
| Saunders-Evans and Winskel | finite input-event configuration enabling a computation event | causal computation configuration | symbolic input-region partition |
| Raymond et al. | temporal safety constraint describing admissible test prefixes | one randomized satisfying trajectory | structural dependency or exhaustive enumeration |

The formal synthesis therefore avoids using bare *demand* as its primary noun.
For input `x` and requested roots `R`, it defines the **enabled closure**
`D_G(x,R)` by graph reachability through all declared operands of ordinary
nodes and only the cases
selected by `x`. The **selection observation** is the partial site-outcome map
whose domain is the selection sites in that closure.

This definition resembles backward demand analysis but differs in purpose. It
does not determine a lazy runtime schedule, find a least partial input, search
for one target, or preserve a general causal history. It specifies an
intensional observer whose inverse images partition all caller inputs.

## Fixed-input foundation and changed quantification

The classical stream-dataflow lineage is more than a terminological neighbor.
Pingali and Arvind transform each data edge with a reverse demand edge and
prove correctness, liveness, and parsimony compositionally. Avron and Sasson
define the \(D\)-driven evaluation as the least legal valuation satisfying a
fixed output-position demand and prove that such least computations exist
uniformly exactly for stable primitive interpretations. Their
`parallel-or` counterexample also shows why a least computation is not
automatic in a more general language.

For a finite acyclic graph encoded as one-cell streams, let

\[
  \kappa_{G,R}(x)
\]

denote the least legal valuation for concrete input \(x\) and requested roots
\(R\), when the specialization assumptions hold. The selection observation can
then be presented as a projection

\[
  T_G(x,R)=\pi_{\mathrm{sel}}(\kappa_{G,R}(x)).
\]

The established work fixes \(x\) and computes \(\kappa_{G,R}(x)\). Our survey
object changes the quantification: it studies the finite range of this
projection as \(x\) varies symbolically and the exact inverse image of each
range value. The equality between enabled closure and the support of the least
legal valuation must be proved as a specialization theorem; it is not stated
by the prior papers.

Pingali and Arvind Part 2 and Vin, Berman, and Mattson strengthen the
operational side with global graph transformations and backwards critical-node
propagation. They still operate one fixed execution at a time and give no
observation-fiber enumeration. Conversely, this surviving separation does not
make reverse demand propagation, least demanded computation, critical inputs,
or demand-driven evaluation novel.

## Consequence for positioning

The survey should describe prior work with each source's own terminology. For
the synthesis, say that a site is **observed for** \((x,R)\) exactly when it is
in \(D_G(x,R)\); do not use “active selection” as if it were inherited
terminology. The cross-literature result is not that demand is new, but that
superficially similar omission mechanisms preserve different observers:

- unvisited because structurally outside the enabled closure;
- unneeded for every normalizing continuation;
- unforced because no operation requires a concrete value;
- absent from a least partial value;
- projected away existentially;
- omitted as a logical don't-care; or
- merged because residual values coincide.

The delayed-choice distinction is especially important. For `x` in `0..99`
used only in `x < 50`, forcing explores 100 concrete values; a selection
observation has two outcome fibers. For a residual result `x + 1` with no
selection site, forcing again enumerates every value, while the graph observer
has one empty observation and a symbolic residual. Thus *force* is a precise
term in its source semantics, but it is not a synonym for our *observed site*.
