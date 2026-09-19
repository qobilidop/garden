---
author: Claude Fable 5.1
---

# Software packet processor abstractions: VPP, DPDK, XDP, and attempts to unify them

Notes from one exploratory conversation on 2026-09-19. Not a project
and not a plan: a record of what was looked at, what was verified, and
which questions stayed open. Bili's stance at the end: the ideas are
not yet clear enough to start anything.

Verification marks: **[read]** the primary source was read in this
session; **[api]** GitHub API or registry page queried directly;
**[snippet]** search-result summary only; **[memory]** model
recollection, unchecked.

## VPP in one screen

FD.io VPP is a userspace dataplane built on one idea: process a
*vector* of packets (up to 256) through one graph node at a time,
instead of one packet through the whole path. [memory]

- Gains: the node's code stays in the instruction cache across the
  vector; headers of the next packets can be prefetched; per-frame
  costs are amortized. Vectors grow under load, so per-packet cost
  falls as load rises. `show runtime` reports vectors/call.
- The dataplane is a directed graph of nodes. A node is a C function
  over a frame of buffer indices; it assigns each packet a next-node
  index. Drop is a node.
- Feature arcs are per-interface insertion points; plugins register
  nodes and hook into arcs at run time.
- Nodes communicate through `vnet_buffer(b)` opaque metadata unions —
  a contract held by convention, not by types.
- The graph may be cyclic (tunnel decap re-enters `ip4-input`).

## Node graph versus RMT

The node graph is more expressive than RMT, but only because it
constrains nothing: a node is arbitrary C. The comparison is between
two kinds of thing.

- RMT is a *machine model*. Its restrictions (fixed stages, one
  match-action per stage, no loops, per-stage memory) buy a guarantee:
  a program that fits runs at line rate, and the program is analyzable.
- The node graph is a *software architecture pattern* (Click's element
  graph plus batching). Its merits are composition and scheduling —
  the stage boundary is where batching happens — not flexibility.
- A node graph can express the dataflow of any P4 architecture (RMT is
  a linear chain; v1model adds a traffic-manager node with
  clone/resubmit/recirculate edges). It cannot express what defines
  RMT: resource budgets and the line-rate guarantee.
- The unexplored middle: free graph wiring with nodes that have
  declared semantics (typed metadata in and out, declared state,
  declared next-set). PSA/PNA are a fixed graph of programmable
  blocks; VPP is a free graph of opaque blocks.

## Three abstractions compared

| | VPP | DPDK rte_graph | XDP |
|---|---|---|---|
| Unit | node over a frame | node over a frame | program over one packet |
| Next | edge index | edge index | verdict code / tail call |
| Batching | explicit | explicit | hidden in the driver |
| Graph | global, run-time mutable | per-core object, static | none (jump table) |
| Inter-unit metadata | `vnet_buffer` opaque | mbuf dynfield | `data_meta` / per-CPU map |
| State | any C (bihash, pools) | any C (rte_hash, rte_lpm) | maps only |
| Code restrictions | none | none | verifier |
| Guarantees | none | none | termination, memory safety |
| Control plane | binary API, CLI, stats | build your own | maps + bpf syscalls |

All [memory]; rte_graph details (introduced around 20.05, a later
multi-core dispatch model, recent feature arcs) were not re-checked.

- DPDK is a toolkit, and ships several optional abstractions at
  different layers: burst I/O with no processing model; `rte_graph`
  (VPP's model as a library); `rte_pipeline`/SWX (P4-shaped, the
  `p4c-dpdk` target); eventdev (a scheduling and ordering contract
  across cores, silent on per-packet logic).
- VPP typically uses DPDK only for NIC drivers, and has native drivers
  that skip it.
- XDP sits between RMT and VPP on the restrictiveness axis: arbitrary
  logic, but bounded and checked.
- The three units share one shape: `(packet bytes, metadata, declared
  state) → (fate, packet', metadata')`. They differ in batching
  visibility, fate encoding, metadata location, and table backing.
  XDP's verifier is the binding constraint among them.

## An observation on batching

Vectorized execution reorders work: packet 2 passes node A before
packet 1 reaches node B. This is semantics-preserving when state is
scoped per node and each node sees packets in order. Caveats:
divergent paths that rejoin present a permuted order to a stateful
node after the join; multi-worker execution needs per-thread or locked
state. Nobody was found stating "scalar per-packet semantics equals
batched execution under a dispatch model" as a theorem (small search;
a negative, not a proof of absence).

## Prior art: P4 onto VPP

- **PVPP** (Choi, Long, Shahbaz, Booth, Keep, Marshall, Kim; SOSR'17
  poster) [read]. P4-14 → `p4c-bm` JSON → custom JSON-to-C compiler →
  VPP plugin. The program becomes its own subgraph beside the vanilla
  nodes (a `PVPP-input` node enabled by CLI, tables as nodes,
  rejoining at `dpdk-output`). 64-byte packets, Ethernet match + TTL
  decrement + MAC rewrite, single node: 7.860 Mpps unoptimized,
  10.209 Mpps optimized, 10.748 Mpps for the hand-tuned VPP
  equivalent (5.25% higher). Largest single gain: reducing tables
  (+17.70%). Unrolling the packet loop gave +0.00% — the code already
  fit in the instruction cache. Multi-node results were left to future
  work; none was found.
  [poster](https://conferences.sigcomm.org/sosr/2017/papers/sosr17-poster-pvpp.pdf)
- **P4VPP**, an fd.io project for a p4c backend targeting VPP, is
  titled "Archived-P4vpp" on the fd.io wiki [snippet; the page
  returned 403]. [wiki](https://wiki.fd.io/view/P4vpp)
- Granularity mismatch: a VPP node is roughly one parse state or one
  table, edits headers in place, and has no deparser. Mapping a whole
  P4 block to one node is simple but pays parse and deparse at block
  boundaries; splitting a block into a subgraph is a compiler problem.

## Prior art: languages and bindings for node-like units

- **KernelScript** (multikernel/kernelscript) [read: README]. OCaml
  compiler, Apache-2.0, 505 stars, beta. One source file yields eBPF
  C, a userspace loader, and kfunc modules. Typed maps, enum `match`,
  `@xdp`/`@tc` program attributes; program lifecycle (`load` before
  `attach`) enforced by types. No formal semantics; safety rests on
  the kernel verifier. The transferable idea: one source for the data
  path and its control plane.
  [repo](https://github.com/multikernel/kernelscript)
- **vpp-plugin** Rust crate (rshearman/vpp-plugin-rs) [read: docs.rs].
  0.2.2, released 2026-08-07, Apache-2.0. `#[vlib_node]`, derived
  `NextNodes` and `ErrorCounters`, async process nodes, feature-arc
  access; states performance parity with C as a goal. A
  general-purpose-language answer to "VPP nodes with better types".
  [docs](https://docs.rs/vpp-plugin/latest/vpp_plugin/)

## Prior art: verified compilers near this space

- **Axon** (Rinard, arXiv 2605.01660) [read: abstract only]. A
  verified compiler whose code and proofs were written in Lean by an
  AI coding agent; combines testing, translation validation, and full
  proofs. Evidence that the cost of Lean compiler proofs has dropped.
  [arXiv](https://arxiv.org/abs/2605.01660)
- **P4Cub** (CPP'23) [snippet]. A Coq-mechanized P4 IR with type
  soundness, one certified compiler pass, and a verification tool.
  [paper](https://www.cs.cornell.edu/~jnfoster/papers/p4cub.pdf)
- **HOL4P4.EXE** (VSTTE'25) [snippet]. A verified P4 software switch
  in HOL4.
  [paper](https://link.springer.com/chapter/10.1007/978-3-032-27340-6_5)

A compiler written in Lean is not thereby verified. Verification needs
a source semantics, a target semantics, and a simulation proof. For a
VPP target the target is C plus vlib macros plus the dispatch runtime;
no Lean formalization of either was found [memory for C]. The honest
shape is a verified middle (type soundness, IR passes, the batching
equivalence above), a thin trusted printer, and testing or translation
validation at the boundary.

## Prior art: one program, several software dataplanes

Grouped by what is unified.

1. **P4 as the single language.** `p4c` backends for eBPF
   (`ebpf_model`, `xdp_model`), DPDK SWX, BMv2 [snippet]; NIKSS (PSA
   on eBPF) [snippet]; T4P4S (DPDK, ODP) [snippet]; P4TC [memory];
   PVPP for VPP [read]. Portability is per *architecture*, not per
   program: the same logic written for PSA, v1model, and `ebpf_model`
   is three programs.
2. **μP4** (Soni, Rifai, Kumar, Doenges, Foster; SIGCOMM'20)
   [snippet]. Architecture-independent modules with defined
   interfaces; the compiler composes them and maps the result onto a
   target architecture. Targets were v1model and Tofino, not software
   dataplanes. Closest academic neighbor to architecture-less blocks;
   to be read closely.
   [paper](https://www.cs.cornell.edu/~jnfoster/papers/microp4.pdf),
   [repo](https://github.com/cornell-netlab/MicroP4)
3. **eBPF bytecode as the portable unit.** DPDK `rte_bpf`, uBPF, eBPF
   for Windows, NIC and FPGA offloads [memory]. userspace-xdp over
   bpftime [read: README]: unmodified XDP programs over DPDK or
   AF_XDP with LLVM JIT/AOT, helper and map-access inlining; 28
   stars, research prototype, `XDP_DROP`/`XDP_TX` only. Unification at
   the ISA level discards parse and table structure. No eBPF node
   plugin for VPP was found.
   [repo](https://github.com/userspace-xdp/userspace-xdp)
4. **Element graphs over pluggable I/O.** Click/FastClick, BESS,
   Polycube [memory]. Unified above I/O; elements remain hand-written
   for one execution model.
5. **One flow-table model, several datapaths.** Open vSwitch over the
   kernel module, DPDK, and AF_XDP [memory]. Real and shipped, but
   fixed-function.
6. **A common programming model** proposed in Tom Herbert's blog
   series comparing DPDK, eBPF/XDP, and P4 [snippet; the posts
   returned 403]: a frontend language lowered to a restricted-C
   intermediate form with eBPF, DPDK, VPP, and hardware backends.
   [post](https://medium.com/@tom_84912/dpdk-vs-ebpf-xdp-vs-p4-and-our-winner-is-7e21c76443a2)

Not found: a single program compiled to a VPP node, an `rte_graph`
node, and an XDP program, with batching owned by the compiler, typed
inter-unit metadata, and a semantics underneath. VPP is the
least-served target.

Why that may be: per-packet logic is a small part of a dataplane, and
the rest (control API, state lifecycle, I/O, operations tooling) is
target-specific; users choose one platform and stay; portability is a
need of those who ship the same function on several platforms. Calico
(iptables, eBPF, VPP dataplanes) [memory] and Juniper CN2 (DPDK
vRouter plus an eBPF kernel dataplane)
[snippet](https://www.juniper.net/documentation/us/en/software/cn-cloud-native23.3/cn-cloud-native-feature-guide/cn-cloud-native-network-feature/topics/concept/cn-cloud-native-ebpf.html)
are examples of the latter. Demand, not feasibility, is the open
question.

## Morpheus

Miano, Sanaee, Risso, Rétvári, Antichi; ASPLOS'22, extended in
IEEE/ACM ToN 2023. Run-time specialization of dataplane code against
live table contents and traffic, with guards that deoptimize when the
control plane changes; works at the LLVM IR level across a DPDK
dataplane and an eBPF one (Polycube). [snippet for the description]

- Repo: [Morpheus-compiler/Morpheus](https://github.com/Morpheus-compiler/Morpheus)
  [api] — Apache-2.0, 36 stars, created 2021-11-16, last push
  2024-04-11, primary language Shell. The organization also holds
  forks of `polycube` (last push 2024-04-11) and `bcc` (2022-11-24);
  which repository holds the LLVM passes was not checked.
- Artifact: [Zenodo 5830832](https://zenodo.org/records/5830832).
- Papers: [ASPLOS'22](https://dl.acm.org/doi/10.1145/3503222.3507769),
  [ToN](https://dl.acm.org/doi/10.1109/TNET.2023.3346286),
  [author's page](https://sebymiano.github.io/publication/2022-morpheus/).
- Relevance: working at LLVM IR, it must rediscover which memory
  accesses are table lookups. A representation with first-class tables
  would hand it that structure — one argument for keeping structure
  above the ISA level.

## Threads left open

- Is a VPP node the same thing as an architecture-less P4 block? The
  calling conventions line up (packet fate as metadata ↔ next index;
  metadata contract ↔ `vnet_buffer`; externs as imports ↔ linked VPP
  libraries), and a block dropped onto a feature arc composes *with*
  the native graph, which PVPP's whole-program subgraph did not.
- A node language with better types than C: next-node as an enum,
  typed inter-node metadata, linear buffers (each enqueued exactly
  once), validity-gated header access; the compiler writes the quad
  loops, prefetch, multiarch variants, trace, and counters.
- Whether restrictions should come from XDP (so the same unit runs
  everywhere) and scheduling from VPP.
- Whether the batching-equivalence theorem is statable and provable at
  small scale, and which language restrictions the proof forces.
- Whether anyone wants portability across software dataplanes.
- Across the day's framings one core stayed fixed: a block is a
  function, state is scoped per block, inter-block metadata is a typed
  contract, externs are imports. Surface language and target were the
  parts that moved.
