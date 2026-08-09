# albert2023dpor — Context-sensitive optimal DPOR with observers

- **Status:** deep-read; exact observer-preserving schedule quotient
- **Primary source:** https://doi.org/10.1016/j.jss.2023.111730
- **Version read:** open-access author full text and publisher record
- **Bibliography key:** `albert2023dpor`

## Evidence locations

- Algorithm: combines state-relative commutation with future-event observers,
  constructing dependencies lazily and exploiting their interaction.
- Correctness and optimality results: the retained executions cover all
  maximal equivalence classes without duplicate representatives under the
  defined conditional independence.
- Evaluation: reported cases obtain exponential reductions over either
  context-sensitive or observer-only DPOR.

## Relationship and evidence limit

The journal extension reinforces exact requested-observer-relative omission
as established prior art. It quotients concurrent schedules, not caller inputs,
and emits neither exact input guards nor typed residual values.
