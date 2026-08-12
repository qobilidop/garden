= Introduction <sec-introduction>

In the canonical software account, symbolic execution replaces inputs with
symbols, advances a program state, forks or otherwise distinguishes branch
outcomes, accumulates a path condition, and asks a solver whether that path is
feasible @baldoni2016-symbolic. Moving this idea to digital hardware changes
the object being executed. A branch belongs to one of several concurrent HDL
processes; state updates at clock or delta-cycle boundaries; a generated C++
model may stand between RTL and the executor; reset and an environmental
testbench determine which symbolic states are reachable. A hardware “path” is
therefore not merely a list of source-level branch outcomes.

Terminology obscures this point. Hardware papers also use *symbolic
simulation* for evaluating a circuit over symbolic values, *symbolic
trajectory evaluation* (STE) for abstract trajectories, *bounded model
checking* (BMC) for solving unrolled transition formulas, and *concolic
testing* for generating a new input from the symbolic predicate of a concrete
trace. All can use the same SMT solver and return a counterexample. That
surface overlap does not make them one method.

This survey follows path-conditioned execution. Its earliest
mechanism-verified included work, rather than its earliest use of a label, is a
2011 SystemC semantics that carries symbolic stores and path conditions,
checks feasibility, and composes scheduler-aware traces between waits
@harrath2011wsa. The bounded corpus then develops through direct and translated
RTL execution, concolic test generation, security-guided backward and forward
search, HLS-source execution with hardware datatypes, and cross-level
co-execution. This history is narrower than symbolic hardware reasoning as a
whole, but it is methodologically coherent.

The survey asks five questions:

- *RQ1:* Definition and regimes — Which works actually perform classical,
  concolic/dynamic, or selective/hybrid symbolic execution of a digital
  hardware design, and how do those regimes differ operationally?
- *RQ2:* Executed artifact — Which design representations are executed — RTL,
  other HDLs, HLS or behavioral models, SystemC/TLM, netlists, or coupled
  cross-level models — and how are hardware concurrency and clocked state
  represented?
- *RQ3:* Paths and scaling — What constitutes a path through concurrent,
  clocked hardware; how are path-conditioned alternatives enumerated,
  reconstructed, composed, merged, or selected; and which mechanisms control
  their growth?
- *RQ4:* Verification contract — Which goals are served, what witnesses or
  proofs are produced, and what bounds, approximations, environmental models,
  or harness assumptions qualify the result?
- *RQ5:* Evidence — How are systems evaluated with respect to design scale,
  temporal depth, coverage, solver work, defects, reproducibility, and
  comparison baselines?

The contributions are fourfold. First, a five-part operational test separates
path-conditioned execution from adjacent symbolic methods. Second, a bounded
systematic map describes the verified corpus by execution regime and artifact.
Third, a critical synthesis connects path meaning, hardware semantics, scaling
mechanisms, and result contracts. Fourth, a compact reporting tuple makes
positive witnesses, bounded completion, and inconclusive search outcomes
comparable without requiring a common implementation architecture.

The principal finding is intentionally modest: symbolic execution of hardware
is a viable survey topic, but it is a specialized verification niche rather
than a synonym for formal hardware verification. Its small size is evidence
about the field, not a reason to enlarge the denominator with neighboring
methods.
