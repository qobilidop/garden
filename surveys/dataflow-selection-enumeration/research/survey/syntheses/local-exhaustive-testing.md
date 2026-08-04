# Support-local and demand-local exhaustive testing

## Pseudo-exhaustive circuit testing

Pseudo-exhaustive testing (PET) gives the hardware literature's clearest prior
formulation of exhaustive coverage relative to local dataflow support. For a
combinational circuit with output support hyperedges \(k_o\subseteq I\), a test
set $T\subseteq\{0,1\}^{I}$ is pseudo-exhaustive when

\[
  \pi_{k_o}(T)=\{0,1\}^{k_o}
  \quad\text{for every output }o.
\]

The same full vector can cover one local assignment in many cones, and a cone
whose support is contained in another can be dropped as a separate obligation.
This is a covering-array problem over a circuit-derived support hypergraph. It
can be exponentially smaller than repeating or globally multiplying the truth
tables of unrelated cones.

Mumtaz et al. make the projection contract explicit, use a
linear-independence criterion to check whether an LFSR sequence covers a cone,
and reduce simultaneous cone coverage to set cover. Their P-PET variant limits
the exact guarantee to cones below a size cutoff. Earlier work introduced
output-cone testing and circuit segmentation; later work derives generic and
circuit-specific test-length bounds.

## Why it does not enumerate selection observations

PET changes the **test obligation**, not the emitted semantic object. Its
output is ordinarily a set of complete input vectors whose projections cover
all local assignments. It does not emit one partial cone assignment per class,
an exact inverse image, or a residual circuit function.

More importantly, output support is static. In

```text
return select(b, f(x), g(y))
```

the output cone contains both case cones. A pseudo-exhaustive test for that
single output covers every joint assignment to $b,x,y$. The enabled closure
for a concrete input follows only the selected case. Its observation guards
are cylinders in the unselected case inputs, and its residual value is either
`f(x)` or `g(y)`.

Thus PET establishes **support-local exhaustiveness**. Our formal synthesis
uses **demand-local observation**, where locality varies with the input and
requested roots. Neither should be described as the other:

| Dimension | Pseudo-exhaustive testing | Selection-observation enumeration |
|---|---|---|
| Locality | static structural output/segment support | input-relative enabled closure |
| Unit covered | every Boolean assignment to each support | every feasible sparse site/outcome map |
| Emitted artifact | complete concrete test vectors | exact guard, observation, residual, witness |
| Mux treatment | both arms lie in the output cone | only the selected arm is enabled |
| Purpose | fault/defect coverage | enumerate an intensional semantic partition |
| Redundancy criterion | support containment and shared covering rows | equality of the requested observation |

Instrumentation can connect the frameworks but does not erase the difference.
Exposing an observation coordinate as a circuit output makes PET cover all
assignments to its structural support. It does not compute the coordinate's
feasible image or exact fibers, and its test suite can contain many vectors
with the same selection observation.

## Consequence for claims and examples

Do not claim first exhaustive enumeration relative to local dataflow cones,
first reuse of tests across unrelated cone assignments, or first bounds in
terms of maximum local support. Cite PET as a direct hardware predecessor.

The mux example above is also a better motivating example than independent
output cones. It shows precisely why static cone locality and dynamic
selected-edge locality differ, without relying on laziness, side effects, or
solver behavior.

Complexity comparisons must name different output objects. PET test length is
governed by a support hypergraph and can be as low as $2^w$ for maximum cone
size $w$ in important cases. Selection enumeration has an unavoidable
$\Omega(K)$ record lower bound for $K$ feasible observations. Neither bound
dominates the other because one covers projected input tuples and the other
enumerates semantic image elements with guards and residuals.
