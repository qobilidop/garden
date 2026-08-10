# Current position

The field is best organized through two coexisting traditions rather than as a
software technique applied to new syntax. Hardware symbolic simulation keeps
many behaviors inside symbolic values; software-style symbolic and concolic
execution expose branch-conditioned paths and tests. Selected modern systems
recombine operations across that distinction through fragment composition,
static guidance, fuzzing handoffs, cross-level models, and testbench-directed
forks, without establishing universal inheritance from both traditions.

Four questions explain most architectural differences:

1. Which artifact is actually executed?
2. Where do mutually possible behaviors live?
3. Which part of their product is constructed, shared, approximated, or
   postponed?
4. What result is returned, under which bounds and environment?

The main synthesis is a conservation-of-difficulty account. Whole paths,
fragments, ITE/BDD values, abstract states, solver formulas, and concrete
corpora distribute the same behavioral alternatives differently. "Fewer
paths" is not a complete scaling result unless representation size, solver
work, end-to-end resources, completion, and discarded distinctions accompany
it.

The corresponding verification contract is `(artifact, initial state, time,
environment, exactness, result, completion)`. Hardware time and concurrency
make the applicable terms load-bearing, while combinational systems should
mark temporal fields not applicable. A replayable witness establishes one behavior;
bounded completion establishes all modeled behaviors to a horizon; neither
alone establishes an unbounded proof. The empirical literature would become
substantially more comparable by publishing this contract alongside
structural scale, harness effort, outcome partitions, and witness replay.
