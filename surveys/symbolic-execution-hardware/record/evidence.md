# Evidence ledger

Each record binds a checkable literature finding downward to source-note
anchors, upward to current `Cxx` claims, and across to the manuscript sections
that use it. Certainty reflects the version and depth actually read.

## Record schema

- **Finding** — one checkable statement established by the listed works.
- **Works** — local source-note citekeys.
- **Anchors** — `sources/<citekey>.md#<heading>` locations.
- **Supports** — claims informed by the finding.
- **Manuscript** — labeled sections that cite the listed works on its strength.
- **Scope** and **Caveat** — boundaries that travel with the finding.
- **Certainty** — `high`, `moderate`, or `low`.

### E001

- **Finding:** The 1979 IBM work describes symbolic simulation as similar to program symbolic execution and applies it to architectural and RTL machine descriptions for correctness and error discovery.
- **Works:** carter1979symbolic
- **Anchors:** sources/carter1979symbolic.md#evidence
- **Supports:** C01,C02
- **Manuscript:** sec-introduction,sec-boundary,sec-lineages
- **Scope:** Bibliographic chronology, terminology, represented levels, and stated purpose.
- **Caveat:** Only the primary abstract and IBM bibliographic record were available; it supports neither algorithmic detail nor absolute priority over every uncaptured antecedent.
- **Certainty:** low

### E002

- **Finding:** SE4RDV executes Verilator-generated C++ with a bit-width-aware KLEE variant, bounds time through a harness, emits concrete tests, and reports replayed RTL coverage on one OpenCores FPU.
- **Works:** zhang2016rtltests
- **Anchors:** sources/zhang2016rtltests.md#evidence
- **Supports:** C01,C02,C03,C05,C06
- **Manuscript:** sec-lineages,sec-artifacts,sec-execution-models,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** The six-page full text and its one-design evaluation.
- **Caveat:** The paper supplies no translation-equivalence theorem, comparative baseline, or cross-design scalability evidence.
- **Certainty:** high

### E003

- **Finding:** Directed and scalable RTL concolic systems use concrete traces plus symbolic branch constraints, target or rank subsequent exploration, and return coverage-directed concrete tests under design- and bound-specific searches.
- **Works:** ahmed2018directed,lyu2021scalable
- **Anchors:** sources/ahmed2018directed.md#evidence;sources/lyu2021scalable.md#evidence
- **Supports:** C01,C02,C04,C05,C06
- **Manuscript:** sec-lineages,sec-execution-models,sec-scaling,sec-contracts,sec-evidence
- **Scope:** RTL concolic algorithms, targets, outputs, and reported experiments in the two papers.
- **Caveat:** Guidance and coverage gains establish time to selected evidence, not global absence or unbounded completeness.
- **Certainty:** high

### E004

- **Finding:** COVERIF performs path-based symbolic hardware/software co-verification, making the coupled model and interface assumptions part of the witnessed behavior.
- **Works:** mukherjee2020coverif
- **Anchors:** sources/mukherjee2020coverif.md#evidence
- **Supports:** C03,C05
- **Manuscript:** sec-artifacts,sec-contracts
- **Scope:** The full arXiv text's operational model, goal, and evaluation.
- **Caveat:** The approach does not make firmware-only symbolic execution hardware symbolic execution, and its result remains relative to the coupled model and selected paths.
- **Certainty:** moderate

### E005

- **Finding:** GreyConE alternates AFL concrete exploration with S2E concolic solving after coverage stalls on compiled SystemC models and reports branch-coverage gains on eleven small benchmarks under fixed engine and total timeouts.
- **Works:** debnath2022greycone
- **Anchors:** sources/debnath2022greycone.md#evidence
- **Supports:** C01,C03,C04,C05,C06
- **Manuscript:** sec-artifacts,sec-execution-models,sec-scaling,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** The arXiv v3 full text corresponding to ITC 2022.
- **Caveat:** Residual uncovered branches are inconclusive; the SystemC-to-LLVM/QEMU semantic bridge, randomized variance, and claimed reachability check are insufficiently specified.
- **Certainty:** high

### E006

- **Finding:** SEIF guides direct RTL symbolic execution with static information-flow paths, bounded stalls, segment pruning, and module fragments; it returns replayable flow witnesses while distinguishing boundedly unaccounted candidates from several kinds of rejection.
- **Works:** ryan2023seif
- **Anchors:** sources/ryan2023seif.md#evidence
- **Supports:** C01,C02,C04,C05,C06,C07
- **Manuscript:** sec-lineages,sec-artifacts,sec-scaling,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** The full arXiv version aligned with HASP 2023.
- **Caveat:** Most negative search results depend on empirical stall/cycle bounds, and intermediate symbolic states are not necessarily reachable from reset.
- **Certainty:** high

### E007

- **Finding:** FuSS snapshots a fuzzer-reached Verilator state, uses angr/Z3 to solve only a nearby RTL-CFG suffix, returns concrete programs to the fuzzing corpus, and reports branch/toggle coverage trajectories on four RISC-V SoCs.
- **Works:** jayasena2025fuss
- **Anchors:** sources/jayasena2025fuss.md#evidence
- **Supports:** C01,C02,C04,C05,C06
- **Manuscript:** sec-lineages,sec-artifacts,sec-execution-models,sec-scaling,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** The author-hosted 24-page ACM manuscript and canonical DOI metadata.
- **Caveat:** The method provides coverage witnesses rather than proofs; the unconditional faster claim exceeds the conditional probability argument and single reported experimental setup.
- **Certainty:** high

### E008

- **Finding:** The cross-level SystemC study implements standalone and paired-reference symbolic execution, reports multiple scenarios and resource/solver/mutation metrics, and explicitly exposes timeout, memory, scheduling, and unsupported-feature limits.
- **Works:** rudkowski2026crosslevel
- **Anchors:** sources/rudkowski2026crosslevel.md#evidence
- **Supports:** C01,C03,C04,C05,C06,C07
- **Manuscript:** sec-artifacts,sec-execution-models,sec-scaling,sec-contracts,sec-evidence,sec-synthesis
- **Scope:** The full arXiv pre-publication text aligned with the 2026 TCAD article.
- **Caveat:** Many larger cases terminate at resource limits; path counts at timeout measure progress, and the tested feature subset omits important SystemC concurrency behavior.
- **Certainty:** high
