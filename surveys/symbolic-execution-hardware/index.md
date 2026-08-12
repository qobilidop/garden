# Symbolic Execution of Digital Hardware Designs: A Systematic Map of Path-Conditioned Design Execution

## Summary

A systematic map and critical survey of path-conditioned symbolic execution
for digital hardware designs, with RTL at the center. The survey uses a strict
five-part operational test: a qualifying work executes a design or faithful
representation with symbolic hardware values, constructs predicates for
control- or time-indexed paths, uses feasibility to choose or reconstruct
execution, and makes that mechanism load-bearing in its result.

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

| Paper | Why it matters | Year | Notes |
|---|---|---:|---|
| [Building SystemC Waiting State Automata](https://doi.org/10.14236/ewic/VECOS2011.11) | Earliest mechanism-verified include; scheduler-aware symbolic paths and trace composition | 2011 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/harrath2011wsa.md) |
| [Hardware Verification Using Software Analyzers](https://doi.org/10.1109/ISVLSI.2015.107) | Separates path symbolic execution from BMC and abstract interpretation after Verilog-to-C translation | 2015 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/mukherjee2015software.md) |
| [Generating High Coverage Tests for SystemC Designs Using Symbolic Execution](https://doi.org/10.1109/ASPDAC.2016.7428006) | Extends KLEE with SystemC scheduling, signals, datatypes, and clocks | 2016 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/lin2016systemc.md) |
| [Automatic Generation of High-Coverage Tests for RTL Designs](https://doi.org/10.1109/ICIEA.2016.7603701) | Verilator-to-C++ plus bit-width-aware KLEE and RTL witness replay | 2016 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/zhang2016rtltests.md) |
| [End-to-End Automated Exploit Generation for Validating the Security of Processor Designs](https://doi.org/10.1109/MICRO.2018.00071) | Backward cycle-level execution and replayed processor exploits | 2018 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/zhang2018coppelia.md) |
| [EISec](https://doi.org/10.1109/AsianHOST56390.2022.10022071) | Gate-netlist path execution for information-flow witnesses | 2022 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/fowze2022eisec.md) |
| [Sylvia](https://doi.org/10.34727/2023/isbn.978-3-85448-060-0_19) | Independent RTL path fragments with solver-checked composition | 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/dataflow-selection-enumeration/record/sources/ryan2023sylvia.md) |
| [SEIF](https://doi.org/10.1145/3623652.3623666) | Static-flow landmarks guide bounded RTL path execution and replayable security witnesses | 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/ryan2023seif.md) |

### Concolic and selective-hybrid execution

| Paper | Why it matters | Year | Notes |
|---|---|---:|---|
| [Scalable Test Generation by Interleaving Concrete and Symbolic Execution](https://doi.org/10.1109/VLSID.2014.25) | Reconstructs one time-indexed HDL trace and solves a targeted diversion | 2014 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/qin2014interleaving.md) |
| [Directed Test Generation Using Concolic Testing on RTL Models](https://doi.org/10.23919/DATE.2018.8342260) | Target-aware CFG guidance for concrete/symbolic RTL search | 2018 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/ahmed2018directed.md) |
| [Scalable Concolic Testing of RTL Models](https://doi.org/10.1109/TC.2020.2997644) | Hardware-aware contribution analysis and reuse across a broader evaluation | 2021 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/lyu2021scalable.md) |
| [FuSS](https://doi.org/10.1145/3760529) | Fuzzer prefix, Verilated state snapshot, and local symbolic suffix | 2025 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/jayasena2025fuss.md) |
| [AutoVeriFix+](https://arxiv.org/abs/2603.11489) | Concolic branch refinement embedded in an LLM RTL repair workflow | 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/tan2026autoverifix.md) |

### HLS and cross-level contracts

| Paper | Why it matters | Year | Notes |
|---|---|---:|---|
| [Hardware/Software Co-verification Using Path-based Symbolic Execution](https://arxiv.org/abs/2001.01324) | Makes coupled hardware/software paths and interface assumptions explicit | 2020 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/mukherjee2020coverif.md) |
| [Processor Verification Using Symbolic Execution: A RISC-V Case-Study](https://doi.org/10.23919/DATE56975.2023.10137202) | Co-executes Verilated RTL and an ISS at retired-instruction boundaries | 2023 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/bruns2023processor.md) |
| [Using Symbolic Execution to Analyze the Hardware TCP Protocol](https://digitalcommons.unl.edu/computerscidiss/241/) | Hardware-specific HLS datatypes, streams, and timing, with claims limited to source-level behavior | 2024 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/hu2024tcp.md) |
| [Comparing Methods for the Cross-Level Verification of SystemC Peripherals With Symbolic Execution](https://doi.org/10.1109/TCAD.2025.3641038) | Broad evidence on standalone and reference-coupled SystemC execution, including limits | 2026 | [notes](https://github.com/qobilidop/sys0/blob/main/surveys/symbolic-execution-hardware/record/sources/rudkowski2026crosslevel.md) |
