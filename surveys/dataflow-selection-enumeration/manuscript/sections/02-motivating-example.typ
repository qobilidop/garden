= Problem setup by example <sec-example>

Let `p` and `r` be Boolean inputs and `x` and `y` be integer inputs. Consider
the shared, pure graph

```text
q_inner = select(r, x + 1, x + 1)
q_outer = select(p, q_inner, y)
return q_outer
```

Here the first case is selected when the Boolean selector is true, so we label
the outcomes `left` (true) and `right` (false). Both arms of `q_inner` are
intentionally equal. We request only `q_outer`.

A monolithic value encoding is immediate:

$
  op("ite")(p, op("ite")(r, x + 1, x + 1), y).
$

It simplifies extensionally to $op("ite")(p, x+1, y)$. Neither expression states
the structural partition we intend to enumerate. Write $q_o$ and $q_i$ for the
outer and inner sites. @tab-motivating lists the three observations.

#figure(
  block(breakable: false)[
    #table(
    columns: (1.8fr, 1.1fr, 0.8fr),
    align: (left, left, left),
    inset: 5pt,
    stroke: (x: none, y: 0.45pt + luma(200)),
    table.header(
      [*Observation*], [*Exact guard*], [*Residual*],
    ),
    [$q_o -> "right"$], [$not p$], [$y$],
    [$q_o -> "left", q_i -> "right"$], [$p and not r$], [$x+1$],
    [$q_o -> "left", q_i -> "left"$], [$p and r$], [$x+1$],
    )
  ],
  caption: [Exact observations for the nested-selection example; witnesses are
  omitted from the table, and one is given below.],
  kind: table,
) <tab-motivating>

The example separates four notions.

First, `q_inner` is _structurally unobserved_ when $not p$. Assigning it a
wildcard in a Boolean implicant would be weaker: a wildcard may also cover
executions in which the site is observed but its outcome is irrelevant to some
other formula. The totalized observation uses a dedicated `unobserved`
sentinel; the sparse API omits the coordinate.

Second, the two $p$-true records have equal residual expressions. They remain
different because the observer records which outcome of `q_inner` was reached.
A quotient by output value, residual function, or maximal affine behavior
would merge them. That quotient is legitimate for a different objective but is
not this observer.

This distinction has a concrete specification role even without assigning
operational significance to evaluation order. An event-aware validation task
may ask whether every source selection outcome remains represented after graph
rewriting, lowering, or component substitution. The two inner outcomes then
belong to different records despite equal values. A value-only equivalence
checker deliberately chooses a coarser observer and merges them. The framework
does not declare one policy universally preferable; it makes the policy an
explicit part of the problem statement.

Third, the observed-outcome guards contain predicates only for sites actually
observed in the corresponding record. The first guard does not say anything
about `r`. Its exactness is structural: once `q_outer` chooses `y`, graph
reachability cannot enter the cone containing `q_inner`. The later
exact observed-outcome guard theorem generalizes this lockstep argument to arbitrary
finite shared graphs and multi-case selections.

Fourth, one model per record is not the desired residual. For example,
`p = true`, `r = false`, and `x = 0` witnesses the second record, but the
residual valid on the whole fiber is $x+1$, not the sampled value $1$. Exact
enumeration must combine model discovery with symbolic specialization.

This nested example is intentionally different from a dense ReLU network or a
flat collection of strict sign tests. When the caller domain excludes all test
boundaries, each observation is a total activation vector and established
full-dimensional cell algorithms already enumerate the corresponding guards
and affine maps. The unselected nested site is the minimal feature that exposes
the graph-relative observation policy.

== Framework at a glance

The concrete observer is easy to compute. Start at the requested root set. At
an ordinary operation, walk to every operand. At a selection, always walk to
its selector and only to the case roots enabled by that outcome. Record each
selection occurrence reached by this backward walk and its outcome. Two inputs
belong to the same observation fiber exactly when these records match.

The formal section gives names to the pieces: $G$ is the graph, $R$ the
requested root set, $A$ the caller-domain predicate, $D_G(x,R)$ the nodes
reached by the walk, and $T_G(x,R)$ its selection record. For one feasible
record $tau$, its fiber $F_tau$ is the input group with record $tau$, while
$Gamma_tau$ is an exact formula for that group. The rest of the paper asks how
existing methods discover these groups and represent their formulas, residual
output expressions, and sample inputs.

An implementation-oriented reading path is this example, the opening and
comparison table of @sec-related, the two constructions in @sec-algorithms,
and @sec-conclusion. The intervening definitions and proofs make the contracts
and transfer conditions precise.
