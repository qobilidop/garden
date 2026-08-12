# Execution and scaling

## Current conclusion

The catalog stores one primary regime. Classical execution maintains symbolic
states; concolic execution reconstructs or follows a concrete trace;
selective/hybrid execution requires an independently progressing non-symbolic
engine with its own evolving frontier or corpus and two-way candidate exchange
with the symbolic executor. Concrete replay alone does not meet that criterion.
The resulting 14/15/2 counts are therefore a reproducible partition rather than
a claim that every concrete/symbolic handoff is a separate regime.

Scaling mechanisms have local effects, not a common conservation law. Guidance
can reduce time to a target; trace reconstruction can reduce simultaneous state;
fragments can reduce local construction; caching can avoid repeated solving;
and selective handoffs can keep long prefixes concrete. Each may shift work to
formula size, compatibility checks, corpus management, handoff reconstruction,
or semantic validation, and abstractions may deliberately quotient behavior.
There is no conserved numerical quantity across these ledgers.

## Support and limits

Ahmed and Lyu support target guidance and reuse; Qin supports trace
reconstruction; Coppelia supports backward search; Sylvia supports fragment
construction plus a remaining compatibility product; Hu supports a temporal
abstraction; FuSS supports a fuzzer/symbolic handoff. These cases establish
mechanisms and observed gains under their experiments, not an impossibility
theorem. The illustrative independent-binary-choice calculation is a direct
worst-case derivation and must be labeled as such.

## Manuscript consequence

Report the primary-regime classification rule, present the four ledgers as a review
checklist, and require end-to-end measurements plus the distinctions omitted.
Never describe the checklist as a conservation principle.
