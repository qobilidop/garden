# Symbolic Execution of Digital Hardware Designs: A Systematic Map of Artifacts, Execution Models, and Verification Contracts

## Summary

A systematic map and critical survey of symbolic execution for digital
hardware designs, with RTL at the center and other HDLs, HLS, SystemC/TLM,
generated executable models, and mixed-level systems included when the
hardware design itself participates symbolically. The survey traces the field
from early machine symbolic simulation through RTL path and concolic execution
to recent fragment, hybrid-fuzzing, cross-level, and testbench-directed
systems. It organizes the literature by executed artifact, location of
behavioral alternatives, scaling mechanism, and verification contract.

## Links

- [Manuscript (HTML)](manuscript.html)
- [Manuscript (PDF)](manuscript.pdf)
- [Survey record](https://github.com/qobilidop/sys0/tree/main/surveys/symbolic-execution-hardware/record)

## Reading list

The critical and historical anchor works for the architectural comparison.
Paper links point to canonical sources; notes point to the exact evidence home
used by the survey.

### Historical lineage

| Paper | Why it matters | Year | Notes |
|---|---|---:|---|
| [Symbolic Simulation for Correct Machine Design](https://doi.org/10.1109/DAC.1979.1600119) | Earliest campaign-located hardware work explicitly connecting machine symbolic simulation to program symbolic execution | 1979 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/carter1979symbolic.md) |
| [Symbolic RTL Simulation](https://doi.org/10.1145/378239.378278) | Event-driven RTL execution with guarded controls, ITE merging, event accumulation, and replay | 2001 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/kolbl2001rtl.md) |

### RTL path and concolic execution

| Paper | Why it matters | Year | Notes |
|---|---|---:|---|
| [Automatic Generation of High-Coverage Tests for RTL Designs using Software Techniques and Tools](https://doi.org/10.1109/ICIEA.2016.7603701) | Verilator-to-C++ plus bit-width-aware KLEE establishes the translation-based architecture | 2016 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/zhang2016rtltests.md) |
| [Directed Test Generation using Concolic Testing on RTL Models](https://doi.org/10.23919/DATE.2018.8342260) | Target-guided concrete/symbolic RTL search | 2018 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/ahmed2018directed.md) |
| [Scalable Concolic Testing of RTL Models](https://doi.org/10.1109/TC.2020.2997644) | Broader RTL scaling and evaluation of concolic guidance | 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/lyu2021scalable.md) |
| [Sylvia: Countering the Path Explosion Problem in the Symbolic Execution of Hardware Designs](https://doi.org/10.34727/2023/isbn.978-3-85448-060-0_19) | Independent RTL path fragments plus solver-checked composition | 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/ryan2023sylvia.md) |
| [SEIF: Augmented Symbolic Execution for Information Flow in Hardware Designs](https://doi.org/10.1145/3623652.3623666) | Static-flow landmarks guide bounded RTL path execution and replayable security witnesses | 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/ryan2023seif.md) |

### High-level designs, hybrids, and cross-level systems

| Paper | Why it matters | Year | Notes |
|---|---|---:|---|
| [Hardware/Software Co-verification Using Path-based Symbolic Execution](https://arxiv.org/abs/2001.01324) | Mixed hardware/software paths make interface and environment assumptions explicit | 2020 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/mukherjee2020coverif.md) |
| [GreyConE: Greybox fuzzing+Concolic execution guided test generation for high level design](https://doi.org/10.1109/ITC50671.2022.00059) | Alternating fuzzing and concolic execution for compiled SystemC designs | 2022 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/debnath2022greycone.md) |
| [FuSS: Coverage-Directed Hardware Fuzzing with Selective Symbolic Execution](https://doi.org/10.1145/3760529) | Snapshot-based local symbolic suffixes extend RTL fuzzing coverage | 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/jayasena2025fuss.md) |
| [Comparing Methods for the Cross-Level Verification of SystemC Peripherals with Symbolic Execution](https://doi.org/10.1109/TCAD.2025.3641038) | Standalone and reference-coupled SystemC execution with unusually broad positive and negative evidence | 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/rudkowski2026crosslevel.md) |
| [Forbench: Symbolic Simulation Helps Make Your Testbench More Formal](https://arxiv.org/abs/2608.01045) | Merged design states with forks driven by procedural testbench conditions | 2026 | [[yang2026-forbench]] |
