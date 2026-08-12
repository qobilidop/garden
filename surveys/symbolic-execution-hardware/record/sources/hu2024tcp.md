---
citekey: hu2024tcp
work:
  title: Using Symbolic Execution to Analyze the Hardware TCP Protocol
  author: Nianhang Hu
  venue: University of Nebraska–Lincoln MS thesis
  date: 2024
read: full-text
source: https://digitalcommons.unl.edu/computerscidiss/241/
facets: "relation: core; artifact: hls; execution: classical; goal: test-coverage; evidence: case-study"
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: Hardware-specific HLS datatypes, streams, and symbolic packet timing make the TCP source qualify, but the evidence does not transfer automatically to generated RTL.
---

# Using Symbolic Execution to Analyze the Hardware TCP Protocol

## Evidence

- The thesis applies KLEE to the C++ source of a real Vitis-HLS TCP stack and makes packet fields, delays, retransmission counts, and related environmental values symbolic (Chapters 2, 5, and 8).
- Hardware specificity is load-bearing: the implementation adds support for arbitrary-width `ap_uint`, `hls::stream`, HLS interfaces, concurrent stream behavior, and clock-linked state that ordinary C/C++ symbolic execution mishandles (Chapter 6).
- KLEE constructs branch path conditions and solves tests. A packet-gap abstraction replaces many concrete idle clock cycles with a symbolic delay to curb time-induced path explosion (Chapter 7; Figure 7.1).
- In the coverage case study, 67 symbolic tests reach 47.47% code coverage versus a 47.46% random plateau after 2,150 tests. The run also exposes buffer-overflow and TCP-header data-offset bugs; a second case study reports path-count reduction after clock-decoupling changes (Chapter 8; Figures 8.1–8.2).

## Bearing on RQs

- **RQ1:** The executor is classical KLEE-style path symbolic execution.
- **RQ2:** This is the strict corpus’s HLS boundary case. It qualifies because hardware-specific datatypes, streams, and timing shape the executor—not merely because the C++ is intended for synthesis.
- **RQ3:** Symbolic packet gaps compress repeated idle cycles, trading a smaller path tree for an abstraction obligation.
- **RQ4–RQ5:** Tests and discovered failures are positive evidence for the HLS source. The thesis does not validate equivalence to generated RTL or prove coverage completeness.

## Evidence limits

- The work focuses on HLS C/C++ verification and explicitly leaves RTL verification to a later design-flow step. Claims therefore apply to the source model, not automatically to synthesized circuitry.
- Coverage remains below 50% in the reported main comparison, and the thesis provides limited hardware/build details, solver statistics, repeated trials, or artifact packaging.
- The 2025 ICCCN paper is treated as a shorter duplicate because its primary full text was unavailable; this note anchors the complete thesis record instead.
