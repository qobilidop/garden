# What “demand” means across the literature

The term does not name one established object. At least five technically
different notions occur in the closest work.

| Tradition | Demand or relevance is | Returned or retained object | Not equivalent to |
|---|---|---|---|
| Anand et al. | usefulness of unexplored function paths for reaching one target location | partial summaries, calling contexts, and a target witness | backward value dependence or all-observation enumeration |
| Antoy et al. and Echahed | a redex that every constructor-normalizing continuation must eventually reduce | narrowing derivation and solution substitution | one input's selected graph slice |
| Xia et al. | requested definedness of an output partial value | least sufficient input approximation and cost | internal selector-site history |
| Saunders-Evans and Winskel | finite input-event configuration enabling a computation event | causal computation configuration | symbolic input-region partition |
| Raymond et al. | temporal safety constraint describing admissible test prefixes | one randomized satisfying trajectory | structural dependency or exhaustive enumeration |

The formal synthesis therefore avoids using bare *demand* as its primary noun.
For input `x` and requested roots `R`, it defines the **enabled closure**
`D_G(x,R)` by graph reachability through all strict operands and only the cases
selected by `x`. The **selection observation** is the partial site-outcome map
whose domain is the selection sites in that closure.

This definition resembles backward demand analysis but differs in purpose. It
does not determine a lazy runtime schedule, find a least partial input, search
for one target, or preserve a general causal history. It specifies an
intensional observer whose inverse images partition all caller inputs.

## Consequence for positioning

The survey should describe prior work with each source's own terminology and
use “active in an observation” only as a locally defined adjective. The
cross-literature result is not that demand is new, but that superficially
similar omission mechanisms preserve different observers:

- unvisited because structurally outside the enabled closure;
- unneeded for every normalizing continuation;
- absent from a least partial value;
- projected away existentially;
- omitted as a logical don't-care; or
- merged because residual values coincide.
