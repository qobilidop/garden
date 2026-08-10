---
citekey: carter1979symbolic
work:
  title: "Symbolic Simulation for Correct Machine Design"
  author: "William C. Carter, William H. Joyner Jr., Daniel Brand"
  venue: "DAC 1979"
  date: 1979
  doi: 10.1109/DAC.1979.1600119
read: abstract-only
source: "IBM Research publication page, https://research.ibm.com/publications/symbolic-simulation-for-correct-machine-design"
facets: "relation=lineage; artifact=mixed-level; execution=symbolic-simulation; goal=equivalence; evidence=case-study"
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol (survey screening pipeline)
notes-date: 2026-08-10
synthesis: "The earliest located hardware-specific use explicitly describes symbolic simulation as similar to program symbolic execution and applies it across architectural and RTL machine descriptions."
---

# Symbolic Simulation for Correct Machine Design

## Evidence

The IBM Research record dates the paper to 25 June 1979, names the three
authors, and reproduces the abstract. The abstract describes symbolic
simulation as a method similar to symbolic execution of programs. Its stated
object is a machine architecture implemented in microcode, represented by
formal descriptions at both the architectural and register-transfer levels.
It reports use for correctness arguments and for finding implementation errors
that standard test cases can miss. The bibliographic record gives DAC 1979,
pp. 280--286, and DOI 10.1109/DAC.1979.1600119.

## Bearing on RQs

For RQ1, this is the earliest work located by the campaign that explicitly
connects a hardware symbolic-simulation method to program symbolic execution.
For RQ2, it already makes representation level central: architectural and RTL
descriptions are compared. For RQ4, the abstract's contract is implementation
correctness relative to the architectural description, rather than coverage
of source branches. It therefore anchors the selected lineage without implying
that every later symbolic-simulation or STE paper belongs to the core corpus.

## Evidence limits

Only the author-organization publication page and abstract were available for
technical reading. The abstract does not expose the symbolic state semantics,
the handling of alternative behaviors, proof conditions, benchmarks, or the
number and nature of detected errors. Those details are not projected into the
survey. “Earliest” is bounded to the works found under this campaign's stated
sources, searches, citation chases, and closing date; it is not a universal
priority claim.
