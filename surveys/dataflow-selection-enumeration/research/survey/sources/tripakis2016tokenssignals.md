# tripakis2016tokenssignals — Conformance between dataflow and hardware

- **Status:** screened; cross-model event-observation boundary
- **Primary source:** https://doi.org/10.1007/S11265-015-0971-Y
- **Open predecessor:** https://www2.eecs.berkeley.edu/Pubs/TechRpts/2012/EECS-2012-164.html
- **Version read:** journal metadata and complete Berkeley report
- **Bibliography key:** `tripakis2016tokenssignals`

## Evidence locations

- Report Sections 2--3: synchronous finite-state machines model hardware;
  timed asynchronous processes communicating through queues model dataflow.
- Section 4: explicit hardware signals are mapped to primitive dataflow token
  production and consumption events so behaviors of the two models can be
  compared.
- Conformance result: the relation preserves performance properties including
  worst-case throughput and latency.

## Relationship and evidence limit

The work gives a formal event-observation bridge across dataflow and hardware
semantic levels and predates the newer mechanized refinement lineage. It
relates whole behaviors and performance properties; it does not partition all
caller inputs by a requested internal observer or return residual functions.
