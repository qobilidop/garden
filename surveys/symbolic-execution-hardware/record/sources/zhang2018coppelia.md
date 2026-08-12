---
citekey: zhang2018coppelia
work:
  title: End-to-End Automated Exploit Generation for Validating the Security of Processor Designs
  author: Rui Zhang; Calvin Deutschbein; Peng Huang; Cynthia Sturton
  venue: 51st IEEE/ACM International Symposium on Microarchitecture
  date: 2018
  doi: 10.1109/MICRO.2018.00071
read: full-text
source: https://www.cs.unc.edu/~csturton/papers/micro18.pdf
facets: "relation: core; artifact: rtl; execution: classical; goal: security; evidence: experiment"
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: Coppelia uses backward cycle-level symbolic execution and state stitching to turn processor security conditions into replayed exploits, with failures remaining bound- and model-dependent.
---

# End-to-End Automated Exploit Generation for Validating the Security of Processor Designs

## Evidence

- Coppelia performs hardware-oriented symbolic execution backward from an architectural security condition through RTL cycles, with symbolic instruction/data inputs and satisfiability checks controlling predecessor construction (Sections 3–4).
- Cycle-by-cycle backward reasoning and state stitching avoid naively symbolically executing every reset-to-target prefix. Forward replay validates the constructed instruction sequence against the processor implementation (Sections 4–5).
- The security output is an executable program/trace, not merely a SAT assignment over an unrolled transition relation. This witness connects a design-level vulnerability to software-visible exploitation (Sections 3 and 5).
- The evaluation reports 29 of 31 known vulnerabilities rediscovered and four new vulnerabilities across processor designs, with FPGA replay for generated exploits (Sections 6–7).

## Bearing on RQs

- **RQ1:** Coppelia is classical symbolic execution with a backward search direction; backward versus forward is a strategy, not a separate regime.
- **RQ2:** Processor RTL is the executed artifact, while programs are symbolic environmental inputs and final witnesses.
- **RQ3:** One-cycle summaries and backward stitching reduce prefix exploration but introduce composition and reachability obligations.
- **RQ4–RQ5:** A replayed exploit is strong positive evidence; failure remains bound-, model-, and search-dependent.

## Evidence limits

- The author-hosted primary URL was intermittently unavailable during the update; the paper was read from the indexed primary full text and DOI-aligned copy.
- Results are specific to the modeled cores, threat predicates, instruction bounds, and environment assumptions; they do not imply absence of other vulnerabilities.
