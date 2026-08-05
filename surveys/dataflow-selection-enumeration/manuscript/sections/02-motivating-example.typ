= Motivating example <sec-example>

Let `p` and `r` be Boolean inputs and `x` and `y` be integer inputs. Consider
the shared, pure graph

```text
q_inner = select(r, x + 1, x + 1)
q_outer = select(p, q_inner, y)
return q_outer
```

Here the first case is selected when the Boolean selector is true. Both arms
of `q_inner` are intentionally equal. We request only `q_outer`.

A monolithic value encoding is immediate:

$
  op("ite")(p, op("ite")(r, x + 1, x + 1), y).
$

It simplifies extensionally to $op("ite")(p, x+1, y)$. Neither expression states
the structural partition we intend to enumerate. Write $q_o$ and $q_i$ for the
outer and inner sites. There are exactly three observations:

#block(breakable: false)[
  #table(
    columns: (1.8fr, 1.1fr, 0.8fr),
    align: (left, left, left),
    inset: 5pt,
    stroke: (x: none, y: 0.45pt + rgb("c8ced6")),
    table.header(
      [*Observation*], [*Exact guard*], [*Residual*],
    ),
    [$q_o -> "right"$], [$not p$], [$y$],
    [$q_o -> "left", q_i -> "right"$], [$p and not r$], [$x+1$],
    [$q_o -> "left", q_i -> "left"$], [$p and r$], [$x+1$],
  )
]

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

Third, the guards contain only positive outcome predicates for sites actually
observed in the corresponding record. The first guard does not say anything
about `r`. Its exactness is structural: once `q_outer` chooses `y`, graph
reachability cannot enter the cone containing `q_inner`. The later
exact-local-guard theorem generalizes this lockstep argument to arbitrary
finite shared graphs and multi-case selections.

Fourth, one model per record is not the desired residual. For example,
`p = true`, `r = false`, and `x = 0` witnesses the second record, but the
residual valid on the whole fiber is $x+1$, not the sampled value $1$. Exact
enumeration must combine model discovery with symbolic specialization.

This nested example is intentionally different from a dense ReLU network or a
flat collection of sign tests. In those all-sites-observed special cases, each
observation is a total activation vector and established hyperplane-cell or
neural-region algorithms already enumerate the corresponding guards and affine
maps. The unselected nested site is the minimal feature that exposes the
graph-relative observation policy.
