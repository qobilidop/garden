# Evidence ledger

Each record binds a checkable literature finding downward to source-note
anchors, upward to current `Cxx` claims, and across to manuscript sections.
Certainty reflects the version and depth actually read.

## Record schema

- **Finding** — one checkable statement established by the listed works.
- **Works** — local source-note citekeys.
- **Anchors** — `sources/<citekey>.md#<heading>` locations.
- **Supports** — claims informed by the finding.
- **Manuscript** — labeled sections that cite the listed works on its strength.
- **Scope** and **Caveat** — boundaries that travel with the finding.
- **Certainty** — `high`, `moderate`, or `low`.

### E001

- **Finding:** Harrath et al. define SystemC symbolic states with a symbolic store and path condition, use satisfiability to retain executions, model scheduler and delta-cycle steps, and compose traces between waits into an automaton.
- **Works:** harrath2011wsa
- **Anchors:** sources/harrath2011wsa.md#evidence
- **Supports:** C01,C03,C06
- **Manuscript:** sec-introduction,sec-boundary,sec-lineages,sec-artifacts,sec-execution-models
- **Scope:** The restricted SystemC operational semantics and worked construction in the complete paper.
- **Caveat:** It is the earliest mechanism-verified include found by this campaign, not a universal historical-priority claim; the paper supplies illustrative rather than scalability evidence.
- **Certainty:** high

### E002

- **Finding:** Hardware path execution appears both in direct scheduler-aware SystemC and in RTL-to-C/C++ flows: included systems maintain path conditions, fork on feasibility, advance bounded hardware time, and return concrete tests or assertion witnesses.
- **Works:** mukherjee2015software,lin2016systemc,zhang2016rtltests
- **Anchors:** sources/mukherjee2015software.md#evidence;sources/lin2016systemc.md#evidence;sources/zhang2016rtltests.md#evidence
- **Supports:** C01,C03,C05,C07
- **Manuscript:** sec-boundary,sec-lineages,sec-artifacts,sec-execution-models,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** The supported HDL/SystemC subsets, translations, harnesses, and bounded experiments described by the three papers.
- **Caveat:** None proves fidelity to every production simulator or all RTL/SystemC features, and SE4RDV evaluates only one principal design.
- **Certainty:** high

### E003

- **Finding:** RTL concolic systems collect or reconstruct a concrete path's symbolic constraints, select and negate a target branch, solve for a new test, and resimulate it; recent use extends this loop to LLM-generated RTL repair.
- **Works:** ahmed2018directed,lyu2021scalable,tan2026autoverifix
- **Anchors:** sources/ahmed2018directed.md#evidence;sources/lyu2021scalable.md#evidence;sources/tan2026autoverifix.md#evidence
- **Supports:** C02,C04,C05,C07
- **Manuscript:** sec-boundary,sec-lineages,sec-execution-models,sec-scaling,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** Target-directed RTL test generation, its scalable extension, and the concolic stage of AutoVeriFix+.
- **Caveat:** Guidance and high branch coverage establish time to selected evidence, not unreachable-code proofs or unbounded correctness; AutoVeriFix+ additionally inherits an LLM-generated oracle.
- **Certainty:** high

### E004

- **Finding:** Selective-hybrid systems use concrete simulation or fuzzing for a prefix/frontier and invoke symbolic path solving only for selected time frames or local suffixes, returning tests to concrete execution.
- **Works:** qin2014interleaving,jayasena2025fuss
- **Anchors:** sources/qin2014interleaving.md#evidence;sources/jayasena2025fuss.md#evidence
- **Supports:** C02,C04,C05,C07
- **Manuscript:** sec-boundary,sec-lineages,sec-execution-models,sec-scaling,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** Trace-reconstructed HDL constraints in Qin and Mishra and snapshot-localized RTL symbolic execution in FuSS.
- **Caveat:** Both are budgeted test generators; chosen traces, local targets, state reconstruction, and handoff policies can omit behavior.
- **Certainty:** high

### E005

- **Finding:** Hardware security systems use forward, backward, or statically guided path execution to generate Trojan patterns, processor exploits, or information-flow witnesses, with replay or outcome partitions qualifying the result.
- **Works:** zhang2018coppelia,fowze2022eisec,ryan2023seif
- **Anchors:** sources/zhang2018coppelia.md#evidence;sources/fowze2022eisec.md#evidence;sources/ryan2023seif.md#evidence
- **Supports:** C04,C05,C06,C07
- **Manuscript:** sec-lineages,sec-artifacts,sec-execution-models,sec-scaling,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** The processor, netlist-information-flow, and RTL-information-flow models evaluated in the three papers.
- **Caveat:** Bounds, under-constrained initial states, static overapproximations, and reset reachability prevent a successful search procedure from becoming a general absence proof.
- **Certainty:** high

### E006

- **Finding:** Mixed-level symbolic execution can couple hardware/software paths, Verilated RTL with an instruction-set model, or low- and high-level SystemC peripherals, making translation, reference-model, observation, and timing relations part of the verification contract.
- **Works:** mukherjee2020coverif,bruns2023processor,rudkowski2026crosslevel
- **Anchors:** sources/mukherjee2020coverif.md#evidence;sources/bruns2023processor.md#evidence;sources/rudkowski2026crosslevel.md#evidence
- **Supports:** C03,C05,C07
- **Manuscript:** sec-lineages,sec-artifacts,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** The coupled models and evaluated scenarios in the three complete texts.
- **Caveat:** Agreement is relative to the selected interface and reference, while many larger SystemC runs terminate at time, memory, or solver limits.
- **Certainty:** high

### E007

- **Finding:** The HLS TCP thesis extends KLEE for `ap_uint`, `hls::stream`, concurrent stream behavior, and clock-linked state, then uses symbolic packet gaps to generate tests and expose source-level failures.
- **Works:** hu2024tcp
- **Anchors:** sources/hu2024tcp.md#evidence
- **Supports:** C03,C04,C05,C06,C07
- **Manuscript:** sec-lineages,sec-artifacts,sec-scaling,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** The Vitis-HLS TCP C++ source and two thesis case studies.
- **Caveat:** Generated RTL is not validated; the result applies to the HLS source model and reported coverage remains below 50 percent.
- **Certainty:** high

### E008

- **Finding:** Evaluations range from single-design coverage cases to multi-design comparisons and cross-level mutation studies, but differ in structural scale, temporal bound, completion, baseline contract, and resource accounting.
- **Works:** zhang2016rtltests,ryan2023seif,jayasena2025fuss,rudkowski2026crosslevel
- **Anchors:** sources/zhang2016rtltests.md#evidence;sources/ryan2023seif.md#evidence;sources/jayasena2025fuss.md#evidence;sources/rudkowski2026crosslevel.md#evidence
- **Supports:** C05,C07
- **Manuscript:** sec-evidence,sec-synthesis
- **Scope:** The critical empirical studies deep-read in this campaign.
- **Caveat:** The evidence supports qualitative comparison of contracts and reporting practice, not an effect-size meta-analysis or tool ranking.
- **Certainty:** high
