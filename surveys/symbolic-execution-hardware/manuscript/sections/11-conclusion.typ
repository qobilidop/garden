= Limitations and conclusion <sec-conclusion>

This survey has three deliberate limits. It is a bounded systematic map of
declared databases, queries, depths, and citation chases through 10 August
2026; terminology and incomplete metadata may still hide work. It centers
symbolic execution and admits symbolic simulation and STE selectively, so it
is not a census of formal hardware verification. Finally, full-text evidence
is concentrated in the critical set. Abstract-level records inform the map
and chronology but not detailed claims about algorithms or performance.

Within those limits, the literature supports a coherent scope. Symbolic
execution of digital hardware designs includes more than classical path
forking and less than every solver-backed hardware analysis. Its common object
is a digital design model advanced operationally under symbolic values, with a
stated relation to feasible concrete executions and a verification result.
RTL is the natural center; other HDLs, HLS, SystemC/TLM, generated models, and
mixed-level systems belong when the hardware design itself participates
symbolically.

The selected history is usefully read through two coexisting lineages.
Hardware symbolic simulation established guarded multi-input execution;
software-style symbolic and concolic execution brought path search, mature
solvers, and test generation. Some modern systems recombine these choices
through fragments, static guidance, fuzzing handoffs, cross-level composition,
and testbench-directed forks, without establishing universal inheritance from
both traditions. These mechanisms move
difficulty among executor states, symbolic representations, solvers, and
harnesses. Their value depends on matching that distribution to the observer
and result contract.

The field will become easier to compare when every claim names the executed
artifact, initial state, time and scheduling model, environment, approximation
policy, returned evidence, and completion status. That reporting discipline is
not bookkeeping. It is what turns a powerful run into a result another
engineer can interpret, replay, and build upon.
