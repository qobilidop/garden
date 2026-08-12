---
citekey: fowze2022eisec
work:
  title: EISec: Exhaustive Information Flow Security of Hardware Intellectual Property Utilizing Symbolic Execution
  author: Farhaan Fowze; Muhtadi Choudhury; Domenic Forte
  venue: Asian Hardware Oriented Security and Trust Symposium
  date: 2022
  doi: 10.1109/AsianHOST56390.2022.10022071
read: full-text
source: https://dforte.ece.ufl.edu/wp-content/uploads/sites/65/2022/10/elsec.pdf
facets: "relation: core; artifact: gate-netlist; execution: classical; goal: security; evidence: experiment"
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: EISec executes netlist-derived C paths to produce information-flow witnesses, with translation fidelity and under-constrained initial state limiting its exhaustive language.
---

# EISec: Exhaustive Information Flow Security of Hardware Intellectual Property Utilizing Symbolic Execution

## Evidence

- EISec starts from a gate-level netlist, identifies sequential state, and emits a claimed functionally equivalent C representation in which KLEE tracks symbolic primary inputs and states (method section and workflow figure).
- KLEE retains concurrent path states and path conditions; feasibility determines which executions survive. The tool returns control sequences and value ranges that reproduce information-flow-policy violations (method and security-analysis sections).
- Under-constrained initialization broadens the explored state space beyond reset-reachable states. This helps enumerate possible flows but weakens any claim that every report is reachable in the deployed environment (threat model and limitations discussion).
- Evaluation applies the method to cryptographic and FSM benchmarks and reports runtime, explored states/paths, and detected policy violations. Constraint caching is presented as a principal optimization (evaluation tables).

## Bearing on RQs

- **RQ1:** EISec qualifies as classical path execution; DOSCrack’s later straight-line symbolic equation construction does not automatically inherit that classification.
- **RQ2:** The netlist-to-C relation is the semantic bridge, and the initial-state model is especially consequential.
- **RQ3:** Parallel KLEE states and caching control repeated work but do not eliminate path/state growth.
- **RQ4–RQ5:** Returned patterns are positive witnesses under the model; “exhaustive” is qualified by translation, initialization, solver completion, and bounds.

## Evidence limits

- The origin returned errors during the final update; evidence was checked against the previously indexed primary full text and DOI metadata.
- No independent equivalence proof or broad industrial benchmark validates the netlist-to-C transformation and under-constrained reachability assumptions.
