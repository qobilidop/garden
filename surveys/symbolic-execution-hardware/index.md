# Symbolic Execution of Digital Hardware Designs: A Systematic Map of Path-Conditioned Design Execution

## Summary

A systematic map and critical survey of path-conditioned symbolic execution
for digital hardware designs, with RTL at the center. The survey uses a strict
five-part operational test: a qualifying work executes a design or documented
derived representation with symbolic hardware values, constructs predicates
for alternatives distinguished by that design representation over control and,
for sequential designs, time, uses feasibility to choose or reconstruct
execution, and makes that mechanism load-bearing in its result. A derived or
HLS representation must document a semantic bridge adequate to the design-level
claim; paths that fork only in an external testbench do not qualify.

The map distinguishes classical, concolic, and selective-hybrid execution.
Symbolic simulation, STE, BMC, trace-only search, and generic
synthesizable-source analysis are treated as adjacent rather than silently
folded into the topic. The survey explains hardware path semantics, semantic
bridges, scaling mechanisms, evidence strength, and the contract needed to
interpret a test, exploit, coverage result, mismatch, or bounded conclusion.

## Links

- [Manuscript (HTML)](manuscript.html)
- [Manuscript (PDF)](manuscript.pdf)
- [Survey record](https://github.com/qobilidop/sys0/tree/main/surveys/symbolic-execution-hardware/record)

## Reading list

The works below anchor the mechanism and evidence synthesis. The complete map
and every exclusion decision are in the survey record.

### Foundations and classical execution

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Building SystemC Waiting State Automata](https://doi.org/10.14236/ewic/VECOS2011.11) | Scheduler-aware symbolic paths and trace composition | VECoS · 2011 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/harrath2011wsa.md) |
| [Hardware Verification Using Software Analyzers](https://doi.org/10.1109/ISVLSI.2015.107) | Verilog-to-C execution separated from BMC and abstract interpretation | ISVLSI · 2015 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/mukherjee2015software.md) |
| [Generating High Coverage Tests for SystemC Designs Using Symbolic Execution](https://doi.org/10.1109/ASPDAC.2016.7428006) | KLEE extended with SystemC scheduling, signals, datatypes, and clocks | ASP-DAC · 2016 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/lin2016systemc.md) |
| [Automatic Generation of High-Coverage Tests for RTL Designs Using Software Techniques and Tools](https://doi.org/10.1109/ICIEA.2016.7603701) | Verilator-to-C++ execution with RTL witness replay | ICIEA · 2016 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/zhang2016rtltests.md) |
| [End-to-End Automated Exploit Generation for Validating the Security of Processor Designs](https://doi.org/10.1109/MICRO.2018.00071) | Backward cycle-level execution and replayed processor exploits | MICRO · 2018 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/zhang2018coppelia.md) |
| [EISec: Exhaustive Information Flow Security of Hardware Intellectual Property Utilizing Symbolic Execution](https://doi.org/10.1109/AsianHOST56390.2022.10022071) | Gate-netlist path execution for information-flow witnesses | AsianHOST · 2022 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/fowze2022eisec.md) |
| [Sylvia: Countering the Path Explosion Problem in the Symbolic Execution of Hardware Designs](https://doi.org/10.34727/2023/isbn.978-3-85448-060-0_19) | Solver-checked composition of independent RTL path fragments | FMCAD · 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/ryan2023sylvia.md) |
| [SEIF: Augmented Symbolic Execution for Information Flow in Hardware Designs](https://doi.org/10.1145/3623652.3623666) | Static-flow landmarks guide replayable RTL security witnesses | HASP · 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/ryan2023seif.md) |

### Concolic and selective-hybrid execution

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Scalable Test Generation by Interleaving Concrete and Symbolic Execution](https://doi.org/10.1109/VLSID.2014.25) | One time-indexed HDL trace with a solver-targeted diversion | VLSID · 2014 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/qin2014interleaving.md) |
| [Directed Test Generation Using Concolic Testing on RTL Models](https://doi.org/10.23919/DATE.2018.8342260) | Target-aware CFG guidance for concrete/symbolic RTL search | DATE · 2018 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/ahmed2018directed.md) |
| [Scalable Concolic Testing of RTL Models](https://doi.org/10.1109/TC.2020.2997644) | Hardware-aware contribution analysis and state reuse | IEEE TC · 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/lyu2021scalable.md) |
| [FuSS: Coverage-Directed Hardware Fuzzing with Selective Symbolic Execution](https://doi.org/10.1145/3760529) | Fuzzer prefix, Verilated state snapshot, and local symbolic suffix | ACM TECS · 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/jayasena2025fuss.md) |
| [AutoVeriFix+: High-Correctness RTL Generation via Trace-Aware Causal Fix and Semantic Redundancy Pruning](https://arxiv.org/abs/2603.11489) | Concolic branch refinement inside an LLM RTL repair workflow | arXiv · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/tan2026autoverifix.md) |

### HLS and cross-level contracts

| Paper | What | Venue · Year | Notes |
|---|---|---|---|
| [Hardware/Software Co-verification Using Path-based Symbolic Execution](https://arxiv.org/abs/2001.01324) | Coupled hardware/software paths with explicit interface assumptions | arXiv · 2020 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/mukherjee2020coverif.md) |
| [Processor Verification Using Symbolic Execution: A RISC-V Case-Study](https://doi.org/10.23919/DATE56975.2023.10137202) | Verilated RTL and ISS co-execution at retirement boundaries | DATE · 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/bruns2023processor.md) |
| [Using Symbolic Execution to Analyze the Hardware TCP Protocol](https://digitalcommons.unl.edu/computerscidiss/241/) | HLS datatypes, streams, and timing with source-level claims | M.S. thesis · 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/hu2024tcp.md) |
| [Comparing Methods for the Cross-Level Verification of SystemC Peripherals With Symbolic Execution](https://doi.org/10.1109/TCAD.2025.3641038) | Standalone and reference-coupled SystemC execution | IEEE TCAD · 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/rudkowski2026crosslevel.md) |
