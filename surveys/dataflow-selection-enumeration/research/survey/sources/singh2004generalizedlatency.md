# singh2004generalizedlatency — Generalized latency-insensitive systems

- **Status:** screened; generalized latency-insensitive architecture boundary
- **Primary source:** https://doi.org/10.1109/DATE.2004.1269025
- **Open author copy:** https://www.michaeltheobald.com/pubs/date.pdf
- **Version read:** complete author copy
- **Bibliography key:** `singh2004generalizedlatency`

## Evidence locations

- Abstract and contribution list: channel use is decoupled so a synchronous
  module reads and writes only the channels needed for the current operation.
- Contribution 2: communication is generalized beyond point-to-point links to
  arbitrary network topologies with synchronous or asynchronous realizations.
- Contribution 3: the architecture extends latency-insensitive composition to
  multiple clock domains.

## Relationship and evidence limit

The work broadens the LI program and hardware boundary and targets throughput,
power, and design flexibility. It does not construct semantic caller-input
fibers for requested internal program sites.
