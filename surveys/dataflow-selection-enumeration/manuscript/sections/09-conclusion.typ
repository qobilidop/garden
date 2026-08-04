= Conclusion <sec-conclusion>

Selection-observation enumeration is best understood as an observer-design
problem before it is treated as a solver problem. For a requested result in a
pure shared dataflow graph, the observer studied here records outcomes of
exactly the selection sites reached through strict operands and selected case
edges. Its inverse fibers preserve equal-valued observed events while omitting
structurally unobserved sites.

The literature map shows that the broad ingredients are established:
projected enumeration handles finite observer coordinates, symbolic execution
provides guarded residuals, functional-logic and bounded-testing systems omit
undemanded choices, decision structures compile finite observers, classical
dataflow supplies fixed-input least demand, and geometric and parametric
methods already give exact output-sensitive region algorithms in important
special cases. The formal synthesis connects these boundaries. Positive
observed-site predicates define an exact fiber; local residual generation and
global activity projection enumerate the same partition; contextual summaries
agree with flattened shared-graph semantics; and one model per fiber is an
oracle-call accounting, not an enumeration-complexity result.

Accordingly, the paper claims neither a new generic enumeration paradigm nor a
practical speedup. It contributes a reproducible map and a precise semantic
contract. The next question is empirical: whether a graph-aware implementation
can exploit this contract more effectively than established projected,
compiled, or specialized alternatives on real workloads.
