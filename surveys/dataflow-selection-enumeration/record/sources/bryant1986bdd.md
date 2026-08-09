# bryant1986bdd — Graph-Based Algorithms for Boolean Function Manipulation

- **Status:** deep-read
- **Primary source:** https://www.cs.cmu.edu/~bryant/pubdir/ieeetc86.pdf
- **Version read:** author-hosted IEEE article
- **Bibliography key:** `bryant1986bdd`

## Why it matters

Reduced ordered binary decision diagrams provide the classical generic
baseline for compiling an observation function. A root-to-terminal traversal
consults only the variable tests encountered on that input, while reduction
shares equal residual functions and removes tests whose two successors agree.

## Representation and guarantees

Definition 1 represents a Boolean function by a rooted acyclic graph whose
nonterminal vertices test ordered argument indices and whose two outgoing
edges select the low or high successor. Definition 2 gives the recursive
function semantics. Definition 5 removes nodes with equal successors and
merges isomorphic subgraphs. Theorem 1 proves that the resulting graph is
unique up to isomorphism and minimum among ordered function graphs denoting the
same Boolean function (pp. 679--681).

The representation is extensional. A variable omitted from the reduced graph
means that the represented function is independent of that variable; it does
not by itself mean that a graph-level selection site was structurally
unobserved during evaluation.

## Complexity

The abstract and introduction explicitly retain exponential worst cases.
Integer-multiplier output functions require exponentially growing graphs for
every variable order, and representation size can vary substantially with the
chosen order (pp. 677--679, 683--684).

## Relationship to our synthesis

Totalize each graph selection site with an `unobserved` sentinel and compile
the resulting finite observation function. Then every terminal preimage is an
observation fiber. More generally, terminal values may contain an observation
and residual result. This generic representability rules out novelty based
only on sparse input-relative decision records, disjoint guards, or leaf
residuals. A graph-specific result must instead establish a construction,
composition, or complexity property not inherited from decision-diagram
compilation.

## Evidence locations

- Definitions 1--2, pp. 679--680: graph syntax and function semantics.
- Definition 5 and Theorem 1, pp. 680--681: reduction and canonicity.
- Figure 3 discussion, pp. 682--683: omitted variables and order sensitivity.
- Abstract and Appendix, pp. 677 and 690--691: exponential multiplier family.
