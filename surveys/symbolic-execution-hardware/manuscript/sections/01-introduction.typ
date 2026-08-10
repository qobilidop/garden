= Introduction <sec-introduction>

Symbolic execution is usually introduced with a software program: replace
concrete inputs by symbols, fork at a conditional, accumulate a path
condition, and ask a solver for an input that reaches a target. Baldoni et al.
organize that mature software literature around execution mode, state and
environment modeling, path-space control, and constraint solving
@baldoni2016-symbolic. Digital hardware complicates every noun in that
description. The object may be source RTL, an event-driven HDL process, a
cycle-accurate C++ translation, a SystemC transaction model, an HLS program,
or several levels at once. A "path" may mean a procedural branch trace, a
clocked transition trace, a combination of independently explored RTL
fragments, or no explicit fork at all because alternatives remain inside an
ITE expression.

The terminology also has a history of its own. Hardware researchers used
symbolic simulation to reason over multiple machine inputs decades ago; the
earliest work located by this campaign explicitly described its method as
similar to symbolic execution of programs and applied it across architectural
and register-transfer descriptions @carter1979symbolic. Later symbolic RTL
simulation accumulated event paths while merging values under Boolean control
conditions @kolbl2001rtl. The recent literature imports software engines and
concolic search, but it also rediscovers or deliberately combines the older
hardware lineage. Treating everything as "KLEE for Verilog" therefore hides
the field's main design choices.

This survey asks five questions:

- *RQ1:* Vocabulary and lineage — How have symbolic execution, concolic
  execution, symbolic simulation, and STE been distinguished and connected in
  work on digital hardware designs?
- *RQ2:* Executed artifact — Which design representations are executed — RTL,
  other HDLs, HLS or behavioral models, SystemC/TLM, netlists, or coupled
  cross-level models — and how are hardware concurrency and clocked state
  represented?
- *RQ3:* Alternatives and scaling — Where do alternative behaviors live —
  separate paths, path fragments, symbolic expressions, abstract states, or
  concrete/symbolic hybrids — and which mechanisms control their growth?
- *RQ4:* Verification contract — Which goals are served, what witnesses or
  proofs are produced, and what bounds, approximations, environmental models,
  or harness assumptions qualify the result?
- *RQ5:* Evidence — How are systems evaluated with respect to design scale,
  temporal depth, coverage, solver work, defects, reproducibility, and
  comparison baselines?

Our scope is digital design verification, with RTL at the center. We admit
other HDLs and HLS, SystemC/TLM, gate-level and mixed-level designs whenever a
hardware design model participates symbolically. We exclude symbolic
execution of firmware on otherwise concrete hardware, hardware accelerators
for software symbolic execution, and generic model checking or equivalence
checking that does not operationally execute a design under symbolic values.
Symbolic simulation and symbolic trajectory evaluation (STE) enter
selectively as ancestors and close comparators, not as an attempted survey of
formal hardware verification as a whole.

The survey contributes four things. First, it gives a mechanism-based boundary
for a name that is broad in practice. Second, it maps the field along four
coupled axes: artifact, alternative representation, scaling mechanism, and
verification contract. Third, it distinguishes a result's *search evidence*
from its *semantic guarantee*: a replayable trace is different from bounded
coverage, and both are different from an unbounded proof. Fourth, it proposes
a compact reporting contract that makes evaluations comparable without
requiring every tool to adopt the same architecture.

The organizing thesis is simple: hardware symbolic execution is defined less
by whether an implementation literally forks than by whether it maintains a
symbolic operational relation between design behavior and feasible concrete
executions. That umbrella is useful only after the paper states where
alternatives live, how time and concurrency are modeled, and what evidence
the result actually licenses.
