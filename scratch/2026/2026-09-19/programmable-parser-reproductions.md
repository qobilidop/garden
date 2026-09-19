---
author: Claude Fable 5.1
---

# Programmable packet parser hardware: reproduction series and benchmark plan

Working notes from one conversation on 2026-09-19, compressed from a
literature survey and three rebuildability audits run by subagents.
Nothing has been built. This note is the starting reference for the
reproduction work.

Verification marks: **[read]** full text read by an agent this
session; **[abstract]** abstract or metadata only; **[second-hand]**
numbers taken from a later paper's comparison table; **[spot]**
re-checked by the main session against the source or a primary API;
**[inferred]** an agent's inference, not stated in the source;
**[unverified]** not checked. Citation counts are Semantic Scholar,
read 2026-09-19; Google Scholar was not queried. No artifact was
built or run by anyone this session.

## Goal and decisions

- **Goal.** Reproduce a small number of papers on *programmable packet
  parser hardware*, one repository per paper, to learn the prior art
  deeply. The unsaid motivation, stated mid-conversation: build a
  shared **packet parser benchmark suite** that hardware, software,
  and compiler research can all use. ParserHawk (SIGCOMM 2025, Bili a
  co-author) had trouble finding a good benchmark suite; that is the
  need.
- **Selection criterion.** Papers that pair a *hardware design* with a
  *programming model*, so a reproduction rebuilds both and shows how
  they fit together. Agents fill the gaps.
- **Out of scope.** Generated-RTL flows (P4 → VHDL/HLS/SystemVerilog):
  compile-time programmability is not the kind of interest here. They
  stay only as possible fixed-function baselines.
- **Start with one.** Commit to one paper first; decide on the rest
  after it.
- **Order.** Reproduce first, design the bench after: two or three
  reproductions show which workloads and metrics the field actually
  shares. Shared infrastructure emerges from the second repository,
  not before the first.
- **Open.** How this relates to nanuk, whose first stage is a parser
  (feeds it, replaces its early stages, or stays separate). Raised,
  not answered.

## Taxonomy: two axes

Microcode is a kind of instruction; encoding is not what separates the
designs. Two independent questions do:

1. How is the next step selected: content match (TCAM), header-type
   table, or program counter and branch?
2. How is the hardware unrolled: one engine iterated in time, or a
   pipeline of stages in space?

| Step selection | Temporal (one engine, iterated) | Spatial (pipeline of stages) |
|---|---|---|
| Content match (TCAM + action RAM) | Gibb / RMT / Tofino; Kangaroo | Intel IPU parser model (ParserHawk's second target) |
| Header-type table → wide microcode word | | Attig & Brebner |
| PC + narrow instructions | Zolfaghari | same group's HPSR 2021 "Run-to-Completion versus Pipelined" [abstract] |

- Horizontal microcode iterated in time (Gibb) and the same idea
  unrolled in space (Attig & Brebner) differ from a vertical
  instruction stream (Zolfaghari).
- The compiler is limited by a different resource in each: TCAM rows;
  stages and per-stage microcode capacity; instructions and cycles.
- ParserHawk covers two cells of the content-match row. The survey
  found no compiler benchmark covering the other two rows.

The three picks, one per row: **Gibb 2013 (with the RMT parser)**,
**Attig & Brebner 2011**, **Zolfaghari 2020** (third slot reopened,
see its audit).

## Survey: papers on programmable parser hardware

Ranked roughly by influence. Reproducibility is for one person with
open tools.

| # | Paper | Cites | Hardware + programming system | Artifact | Repro |
|---|---|---|---|---|---|
| 1 | Gibb, Varghese, Horowitz, McKeown, "Design Principles for Packet Parsers", ANCS 2013, doi:10.1109/ANCS.2013.6665172 [read] | 126 [spot] | TCAM+RAM programmable parser, fixed parser; parse-graph format, table generation with clustering | `grg/parser-gen` (not the paper's version; LICENSE empty [spot]) | medium |
| 2 | Bosshart et al., RMT, SIGCOMM 2013, doi:10.1145/2486001.2486011, parser in §4.1, §5.1, Fig. 6 [read] | 1198 | same generator and graphs as #1 | — | with #1 |
| 3 | Attig & Brebner, "400 Gb/s Programmable Packet Parsing on a Single FPGA", ANCS 2011, doi:10.1109/ANCS.2011.12 [read] | 110 [spot] | microcoded pipeline; PP language + compiler; became Xilinx SDNet | none, closed | low |
| 4 | Kozanitis, Huber, Singh, Varghese, Kangaroo, INFOCOM 2010, doi:10.1109/INFCOM.2010.5462139 [read] | 49 [spot] | CAM lookahead parser; offline DP algorithm bounding CAM entries | none | medium |
| 5 | Benáček, Puš, Kubátová, "P4-to-VHDL", FCCM 2016, doi:10.1109/FCCM.2016.46 [abstract, numbers second-hand] | 53 [spot] | generated RTL; origin of the "simple/full parser" workloads | none | low |
| 6 | Santiago da Silva, Boyer, Langlois, P4 → HLS parsers, FPGA 2018, doi:10.1145/3174243.3174270 [read] | 37 | generated RTL via Vivado HLS | repo, no license, Vivado HLS 2015.4 | low–medium |
| 7 | Cabal et al., "Configurable FPGA Packet Parser for Terabit Networks", FPGA 2018, doi:10.1145/3174243.3174250 [read] | 26 | generated RTL, multi-packet-per-word bus | none | low |
| 8 | Zolfaghari, Rossi, Nurmi, "A custom processor for protocol-independent packet parsing", MICPRO 72, 2020, doi:10.1016/j.micpro.2019.102910 [read] | 12 | parser ISA, 4-stage pipeline, no TCAM; no toolchain | none | low–medium |
| 9 | Liu et al., HyperParser, APNet 2021, doi:10.1145/3469393.3469399 [read] | 6 [spot] | butterfly extraction + TCAM; configuration generation thin | `FPGA-Networking/HyperParser`, Verilog + testbenches, no license | medium |
| 10 | Garg & Boutros, "From Patterns to Parsers", arXiv:2607.16058, 2026 preprint [read] | 0 | generated SystemVerilog (fixed-function) from P4 / Snort via an IR | `boutros-lab/patterns-to-parsers`, MIT [spot] | high, not run |

Adjacent (compilers and verifiers modelling parser hardware):

- ParserHawk, SIGCOMM 2025, doi:10.1145/3718958.3750484 [read]:
  CEGIS synthesis of TCAM-row parsers for the Tofino and Intel IPU
  models; 29 benchmarks from Gibb's graphs, production parsers
  (switch.p4, sai.p4, DASH), synthetic patterns, with rewrites; repo
  `ParserHawk/ParserHawk`, no license file. Baselines: p4c's
  open-sourced Tofino backend (`backends/tofino/bf-p4c/parde`), the
  closed IPU compiler, Gibb's parser-gen.
- Leapfrog, PLDI 2022, doi:10.1145/3519939.3523715 [read]: translation
  validation of parser-gen's hardware table output against the source
  graph; Apache-2.0; large benchmarks need hundreds of GB of RAM.

Abstract-only or unread, in scope: Puš/Kekely/Kořenek (ANCS 2012,
DDECS 2014); the Mashreghi-Moghadam / PrismParser line (ISCAS 2022,
2023; Future Internet 2024); Cheng et al. PParser (Computer Networks
2025, 23 citations); Yazdinejad P4-to-SDNet (ICCKE 2018); P5 (ANCS
2017); Septinus et al. FSM-based engine (SAMOS 2010).

### What the survey says about benchmarking

- No dedicated hardware-parser benchmark suite was found. Nearest:
  Whippersnapper (SOSR 2017, doi:10.1145/3050220.3050231), black-box
  whole-target latency; repo last pushed 2017.
- Baseline numbers are almost always copied from the earlier paper,
  not re-run (explicit in HyperParser, Zolfaghari, Garg & Boutros),
  across process nodes (45 / 28 / 14 nm), FPGA generations, and
  post-synthesis versus post-place-and-route results.
- Workloads are mostly prose. Gibb's parse graphs are the only set
  published as files and the most reused (RMT, HyperParser, Leapfrog,
  ParserHawk). No canonical P4 source was found for the "simple/full
  parser" pair; "full" is 2× VLAN/MPLS in #5 and #6, 4× in #7.
- None of the read papers uses real packet traces; throughput is
  clock × bus width, raw in some papers and worst-case effective in
  others.
- Costs never separated: the extraction contract (5-tuple, all fields,
  or a 4 Kb header vector; #6 shows 40–100 % LUT difference); run-time
  programmable versus regenerate-and-resynthesize; TCAM accounting.
- Input formats: the FPGA line takes P4; the ASIC line uses Gibb's
  text format or prose.

## Benchmark suite: design positions so far

- **Shape: workloads × targets.** A compiler benchmark needs a parse
  spec plus a target constraint model and reports resource use (TCAM
  entries, stages, instructions, compile time); no RTL needed. A
  hardware benchmark runs the same spec compiled onto RTL (area, fmax,
  latency). A software benchmark reuses the spec and oracle with a
  different harness. Each reproduction contributes one target:
  hardware model, RTL, baseline compiler. The compiler track is the
  cheapest and the one with a known need.
- **Three layers.** (1) Workloads: parse graphs plus packets,
  target-neutral, each tagged with the features it uses
  (variable-length headers, TLV, stack depth, lookahead width,
  checksum in parser); targets declare supported tiers. (2) Oracle:
  per packet, accept/reject, extracted fields, payload offset; a
  hardware testbench needs a software reference parser anyway.
  (3) Metrics and harness: where hardware and software differ.
- **Hardware versus software.** Hardware cost is set mostly by the
  spec (depth, fan-out, widths) and barely by traffic; software cost
  depends heavily on traffic. A hardware bench varies graphs, a
  software bench varies traces. Never one leaderboard.
- **Workload format.** Reasons against P4 as the normative format:
  TLV and variable-length handling is clumsy and target-dependent; the
  parser is tied to P4's type and architecture model; a bench needs
  serializable workloads, declared features, and generated expected
  outputs. Position reached: the Pakeles IR is already this format
  (conformance corpus of IR, packet, expected = the oracle layer), so
  the bench is a consumer of it, not a second format. Caveats: a
  format that expresses TLV does not make a target able to parse it;
  P4 import is needed for the reproductions regardless; publish a P4
  projection of every P4-expressible workload and list the rest as
  "not expressible in P4". Not decided; each reproduction uses its
  paper's input format and records what that format could not express.
- **A target model declares** both its step-selection mechanism and
  its unrolling (the two taxonomy axes).
- **Per reproduction, record** what the paper measured, on what, and
  against what. Those records are the bench's requirements.

## Rebuildability audits

Common findings:

- None of the three papers specifies enough for a full rebuild. The
  difficulty is fidelity, not engineering: gaps are easy to fill and
  easy to mistake for the paper's design.
- The same parts are missing everywhere: streaming interface, packet
  framing, fields straddling words, back-to-back packets, the output
  contract, a real testbench. These are the bench's shared
  infrastructure: packet generator, reference interpreter,
  co-simulation harness.
- No area, power, or fmax figure is reproducible with open tools, only
  trends. Exactly reproducible results are structural: table entries,
  cycle counts, compiler outputs.
- Practice: tag every component **specified** (with section),
  **inferred**, or **invented**; keep the decision log as the
  repository's main document; build the reference interpreter first;
  pin the exactly-reproducible results as tests.

### Gibb 2013 (with the RMT parser)

Difficulty: no L component. Fixed parser M; programmable datapath M;
TCAM S (behavioural or flop-based); action RAM M; field extraction
S–M; header vector S; table generation M (exact Table 1 counts M–L);
testbench S–M; evaluation flow M.

Specified:
- Abstract model, fixed design (§4.2, Figs. 5–6), programmable design
  (§4.3, Figs. 7–8): state + selected bytes → TCAM, first match wins;
  RAM gives next state, advance, next lookup offsets. Key = 8 b state
  + 2 × 16 b = 40 b; TCAM 256 × 40 b; header vector 4 Kb (§6.3).
  RMT §5.1 adds action RAM 256 × 128 b, 16 × 40 Gb/s at 1 GHz.
- Table generation, §5.2 Eq. 1, with a cut-and-solve heuristic for
  multi-parent nodes (order-dependent).
- Table 1, big-union, 16 b lookups [arithmetic spot-checked]:

  | Lookups | Entries | Width (b) | Size (b) |
  |---|---|---|---|
  | 1 | 113 | 24 | 2712 |
  | 2 | 105 | 40 | 4200 |
  | 3 | 99 | 56 | 5544 |
  | 4 | 102 | 72 | 7344 |

- Fig. 15f: fixed 2.6 mm² versus programmable 4.4 mm² at 45 nm,
  640 Gb/s aggregate. RMT Fig. 6: 2.9–3.0 M gates fixed versus 5.6 M
  programmable (1.6 M from TCAM + action RAM).
- Evaluation: Synopsys DC G-2012.06, TSMC 45 nm, over 500 parsers.

Gaps the paper leaves:
- TCAM and RAM cost model (no open macro; underlies the "programmable
  costs about 2×" conclusion).
- Action-word layout, extracts per cycle, granularity.
- Eq. 1's `Entries`, `W`, `NewOffset`, base and infeasible cases,
  variable-length and multi-cycle headers, heuristic visiting order;
  Table 1's B and window parameters.
- Window size, stall behaviour, TCAM-miss behaviour, "done" encoding,
  back-to-back packets.
- Extract lists for the Fig. 3 graphs; clock targets; gate definition;
  power method; the sweep points.

Reference code `grg/parser-gen` (HEAD 06c5543, 2020-09-10) [read, not
run]:
- README: "*not* the same version used to produce results for the
  paper", fewer parameters [spot]. LICENSE is 0 bytes [spot].
- Pipeline: text graph → `make_json.py` → `make_tcam.py` → Genesis2
  (Perl) expands `.svp` templates to SystemVerilog → VCS. No
  synthesis scripts, no TCAM/RAM area model, no sweep scripts. The
  TCAM is a simulation-only `casex` with entries baked in; no write
  port anywhere.
- Fills: input format (pseudo-fields for MPLS lookahead, repeat
  counters, first header is root; seven example graphs); window of two
  16-byte registers, combinational lookup, stall until bytes valid,
  state 255 = done, miss → 255; 12 byte-extracts per cycle, which
  implies action data far wider than RMT's 128 b; per-byte header
  vector with valid bits; clustering in about 4.5 k lines of Python 2
  with heuristics the paper does not mention.
- Example graphs are not the Fig. 3 graphs (the enterprise example
  adds ARP/RARP and ICMPv6).
- Testbench sends packets one at a time with idle gaps; no
  back-to-back or line-rate test; VCS-only tasks.
- Python 2; a `lib2to3` auto-port failed. Rewrite rather than revive.

Reproducibility: Table 1 widths and sizes exact, entry counts trend
only; Figs. 15a–f trends only; mm² and die-share figures not
reproducible (die sizes cited from private correspondence). Whether
the repository's big-union graph gives 28 nodes / 677 paths or 105
entries is [unverified].

Noted in the paper: Fig. 10a and Fig. 9b disagree on IPv4 lookup count
(protocol at byte 9 is not reachable by offsets 0 and 6 with 16 b
lookups); programmability cost is stated as "doubles", "almost twice",
and "1.5–3×"; Gibb Fig. 15f and RMT Fig. 6 give different gate splits
for a nominally identical design point; Eq. 1 double-counts shared
subgraphs in a DAG (optimal only for trees).

Lead: Gibb's thesis, chapter 2 (`purl.stanford.edu/ns046rz4288`),
likely holds the missing parameters [unverified, not fetched].

### Attig & Brebner 2011

About a quarter of a rebuild is specified; the rest is design
decision. Difficulty: language surface S, semantics S–M, expression
sublanguage S (with PX rules); compiler stage-occupancy S–M,
expression lowering M, microcode format M, HDL emission M, update
check M; hardware top level S–M, lookup S, **locate L** (segments
straddling words at 1024–2048 b), extract S–M (best-specified block),
compute M, key builder M, errors S, **multi-packet-per-word L**;
benchmarks S to write, high risk for comparability; testbench M;
evaluation M for an analogous sweep, exact replication not possible.

Specified:
- PP: `class NAME { struct {...} method ... }`; methods `next_header`,
  `header_size` (compulsory), `key_builder`, `earliest`, `latest`;
  outer-loop pseudocode (§1.1). Two printed examples only: the IPv4
  class (§2) and the full VlanAndMpls program (Fig. 4).
- Compiler inputs: target throughput → bus width, max parse depth →
  stage count (5 in all experiments); per-stage header-type occupancy.
- Stage template of five components; pipelined shifter with 16 choices
  per stage; if-else as three parallel pipelines plus select; microcode
  in four sections (Fig. 3); store is flip-flops + mux or BRAM.
- Worked numbers that check out: 156-bit IPv4 segment; 92 = 12 + 80
  shift; VlanAndMpls compiles to one 16-bit extract unit, one equality
  unit, one if-else unit, all three types from stage 3.
- Tables 1–2: 1024 b → 302–343 Gb/s, 9.2–14.9 % of a Virtex-7 870HT;
  2048 b → 561–687 Gb/s, 17.2–23.1 %; ISE 13.1. Latency ÷ period gives
  integer cycle counts identical at both widths: 98 / 103 / 113 / 148
  [inferred].

Gaps: grammar; class-ID namespace (class IDs and wire values share one
integer space); operator set, widths, signedness; microcode field
widths and opcodes (the 136-bit figure is not derivable from the
text); all interfaces, framing, and stage timing; packet delay lines;
key packing; update interface and atomicity; nine of ten benchmark
programs; any test data.

Scope note: the 400 Gb/s / 600 Mpps small-packet configuration is a
proposal in §6 for a different part (1140XT), with 4096-bit operation
left to future work [spot]; the measured designs are single-pipeline,
on a device that was pending at the time. Rebuilding the single
pipeline is faithful to what was measured and removes one of the two
L items.

Supplementary public sources:
- Brebner & Jiang, IEEE Micro 34(1), 2014 [read]: PX as PP's
  descendant; near-complete PX OpenFlow parser; "packets must start on
  data word boundaries".
- SDNet PX language guide UG1016 v2017.4 [read in part]: full
  descendant syntax, operator precedence, natural-width rule, unsigned
  modulo arithmetic, constant-distance shifts. PX is not PP (PX selects
  next class by name or map, PP by numeric field value); use as a
  declared prior.
- SDNet UG1012 [skimmed]: AXI-Stream + tuple side-channel, AXI4-Lite
  control, stimulus file formats, generated C++ model.
- Patents, read through summaries only [unverified in full]:
  US8385340B1 (compute: operand stack, 3-bit ALU opcode, sizing rule),
  US8443102B1 (locate/extract), US8780914B2 (multi-packet per word;
  a different scheme from the paper's "four copies"). Two are listed
  active until 2031 and 2033; a consideration for a public rebuild,
  not analysed.

Open-flow note: no open place-and-route for the XC7VH870T
[unverified, from memory]; Yosys gives LUT/FF counts only.

Noted in the paper: `header_size` (§2–4) versus `next_offset` (Fig. 4,
§5); the printed VlanAndMpls program yields a parse failure for any
non-VLAN, non-MPLS inner EtherType; "408 bits at each stage"
contradicts per-stage occupancy in the same paragraph; §4.4's operator
list omits the multiplication used in §2.

### Zolfaghari 2020

**No programming system exists**: no assembler, compiler, or printed
program; the P4 mapping in §VII is hand-done prose; the same group's
IEEE Access 2020 paper lists a P4 compiler as future work [read]. The
paper does not meet the hardware-plus-programming-model criterion as
published. A rebuild is a new design compatible with the paper at
block-diagram and cycle-count level.

Difficulty: instruction format M (all encodings invented); registers
S; packet buffer M; PHV filler S–M; pipeline M (counter
load-versus-decrement hazards undefined); program control M; NHRU
S–M; branch catalyst S; branch condition evaluator S, fully invented;
stack / TLV loop M; payload forwarder S–M; memories M; assembler S,
compiler M–L; programs S–M; testbench M; evaluation M.

Specified:
- 96-bit instruction, 21 fields (Table II; widths sum to 96): branch
  type 2, branch condition 3, five 5-bit extraction modes, four 6-bit
  addresses, NH resolve iterations 7, header segment size 2 (0/1/2/4
  bytes), PHV filler mode 4, PHV addresses 4/4/6/6, stack select 1,
  stack push 1, unused 7. No decode stage.
- Pipeline FI / FH / EX / WB at 2.0 GHz. Control priority (Table I):
  reset > header-counter expiry > payload-counter expiry > branch.
- NHRU: 8 parallel 16-bit comparators per access, multi-access search,
  default address. Branch catalyst: same structure, single access.
- Output: RMT-style packet header vector, 7 banks, up to 4 written per
  cycle.
- Printed program data: Ethernet comparands {0x8100, 0x8847, 0x0800,
  0x86dd}; IPv4 protocol comparands {1, 2, 6, 9, 0x11, 0x29, 0x33,
  0x73}.
- Evaluation: VHDL, Synopsys DC J-2014.09-SP4, 28 nm UTBB FD-SOI,
  synthesis only.

Gaps: bit positions; the 32 extraction modes, 16 PHV filler modes,
branch types and conditions; no branch-target or reference-value field
in Table II; counter widths and load semantics (IHL scaling, IPv4
versus IPv6 length conventions); hazard, stall, and flush rules; stack
depth and pop-on-header-end; memory depths, implementation, write
port, and how one instruction memory serves many instances at 2 GHz;
buffer and PHV interfaces; packet delimiting; any testbench.

Exactly reproducible: Tables III and IV (cycle counts), under a timing
model [inferred] from Figs. 10, 12–15: standalone header = instructions
+ 3; an NHRU or branch-catalyst branch fetches its target 4 cycles
after EX; header-counter expiry costs 1 bubble; final header adds 3
drain cycles. Stacks: 25 / 28 / 35 / 43 cycles. Worst case 592 b ÷
(43 × 0.5 ns) = 27.5 Gb/s, header bits only. Matching requires
assuming MPLS branches on the S bit and ICMPv6 on Type via the branch
catalyst.

Not reproducible: area, power, and the RMT comparison (RMT's 1.7 mm²
is cited from private correspondence; different libraries).

Noted in the paper [Table V totals spot-checked in the text;
arithmetic recomputed]:
- Per instance 21,511 µm², shared memories 123,916 µm². 32 instances =
  812,268 µm², matching the stated 0.8 mm². 128 instances = about
  2.88 mm², not within 1.7 mm²; about 73 fit. The 3.4 Tbps "factor of
  5" figure assumes 128.
- Table V component gate counts sum to 296,994; the printed total is
  358,838. Areas sum to the printed 145,427 µm².
- "Branches have a penalty of one cycle" (§V) versus 5 idle fetch
  cycles in Figs. 13–14.
- The 53 % figure compares mm², the 66 % figure compares gates.
- PHV address widths do not map onto RMT's 64 × 8 / 96 × 16 / 64 × 32
  layout despite the stated output equivalence.

Leads [abstract only]: NORCAS 2018 (introduces the program control
unit; most likely home of encodings), ASAP 2018 (first version), the
Tampere doctoral thesis (trepo.tuni.fi/handle/10024/124250). The
accepted manuscripts and thesis sit behind bot checks the audit did
not attempt to pass; open them in a normal browser.

## Plan as it stands

1. **Gibb 2013 with the RMT parser section.** Rewrite the generator in
   Python 3; behavioural TCAM; RTL through Verilator, then Yosys /
   OpenROAD on an open PDK for the fixed-versus-programmable trend.
   Pin the Table 1 trend as a test. Fetch thesis chapter 2 first.
   Yields the content-match target that ParserHawk and the Tofino
   backend can later run against.
2. **Attig & Brebner 2011**, single pipeline only, PX semantics as the
   declared prior. Pin the VlanAndMpls compile as a test. Kangaroo is
   the shorter alternative second step: same target class as Gibb, a
   second compiler for it.
3. **Third slot open.** Options: keep Zolfaghari as the hardware
   target and write the compiler as original work; read the three
   Tampere sources first, then decide; or search again for a
   PC-and-instructions parser that ships a toolchain. Preference when
   this note was written: read the Tampere sources first.

Temporary files from this session (PDFs, extracted text, the
parser-gen clone) were in the Claude session scratchpad and do not
persist.
