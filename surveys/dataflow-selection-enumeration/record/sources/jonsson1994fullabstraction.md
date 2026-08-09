# jonsson1994fullabstraction — Fully abstract dataflow trace semantics

- **Status:** screened; compositional trace-model boundary
- **Primary source:** https://doi.org/10.1007/BF02280834
- **Institutional record:** https://ri.diva-portal.org/smash/record.jsf?pid=diva2%3A1041380
- **Version read:** institutional abstract and expanded report metadata
- **Bibliography key:** `jonsson1994fullabstraction`

## Evidence locations

- Model: nondeterministic Kahn-style nodes communicate over unbounded FIFO
  channels, with trace order retaining information needed for composition.
- Full-abstraction result: the trace model equates exactly the networks that
  cannot be distinguished by the declared network contexts.
- Generalization: the semantics extends beyond FIFO to asynchronous networks
  with other channel disciplines, including unordered or lossy channels.

## Relationship and evidence limit

This is a stronger channel-model and trace-guarantee boundary than a generic
dataflow input-output semantics. It observes whole communication traces rather
than requested internal site outcomes and does not enumerate caller-input
fibers or residual values.
