# Result contracts

## Current conclusion

Positive and negative outcomes answer different propositions. A replayed test,
counterexample, exploit, or mismatch is a portable conclusive existential
result under its reset, clock, environment, and implementation. A soundly
completed bounded analysis can establish a universal negative result within its
declared semantic subset. A timeout, coverage plateau, exhausted heuristic, or
unscheduled target is inconclusive. Neither result type is simply “stronger.”

The common tuple `(artifact, initial state, time, environment, exactness,
result, completion)` separates these obligations. `Exactness` includes the
translation and semantic-conformance argument plus under/over-approximation;
`completion` distinguishes an empty worklist from justified bounded
exhaustiveness by a sound executor.

## Support and limits

SE4RDV, Ahmed, FuSS, and Coppelia replay positive witnesses. SEIF explicitly
partitions contradictory, bounded-failure, semantically rejected, witnessed,
and unaccounted candidates. EISec shows why an under-constrained initial state
weakens deployment conclusions. Cross-level systems show that agreement is
relative to an observation relation and reference model. These examples support
the tuple as a survey proposal, not as an established standard.

## Manuscript consequence

Use “portable conclusive positive outcome,” not “strongest common
denominator”; qualify every exhaustion statement by executor soundness and the
declared subset; and preserve inconclusive outcome categories in evaluation
recommendations.
