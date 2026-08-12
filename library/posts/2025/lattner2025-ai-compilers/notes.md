---
citekey: lattner2025-ai-compilers
work:
  title: What about TVM, XLA, and AI compilers? (Democratizing AI Compute, Part 6)
  author: Chris Lattner
  date: 2025-03-12
source: https://www.modular.com/blog/democratizing-ai-compute-part-6-what-about-ai-compilers  # snapshot → shadow; figures (1 JPEG, 2 PNGs) → store
discussions:
  - https://news.ycombinator.com/item?id=43349501  # 2025-03-13
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "TVM and XLA show why automatic kernel generation and model partitioning are necessary but insufficient: fixed operator abstractions gain leverage over workload combinations while losing the hardware control and organizational alignment demanded by new accelerators."
---

# What about TVM, XLA, and AI compilers? (Democratizing AI Compute, Part 6)

Part 6 moves one level above portable kernel languages. As frameworks acquired
hundreds or thousands of operations, more datatypes, more model combinations,
and more hardware targets, hand-writing every optimized kernel stopped
scaling. Lattner presents AI compilation as the necessary response, then uses
TVM and XLA to argue that automatic optimization introduced a different
failure mode: the abstraction that makes compilation tractable can hide the
very hardware details a fast-moving workload needs.

## The leverage and the abstraction boundary

Kernel fusion is the post's concrete model. A matrix multiplication followed
by ReLU can either write and reread an intermediate matrix or execute as one
fused kernel that keeps data closer to the processor. A compiler can discover
and generate such combinations instead of relying on a fixed library for
every permutation of operation, datatype, and device. The important claim is
not the post's unqualified suggestion that this can yield a twofold speedup;
it is that compilation changes the unit of reuse from a manually implemented
kernel to transformations over programs.

That leverage depends on the intermediate representation. Lattner argues that
TVM and XLA were designed around the more regular operators of an earlier deep
learning period. Generative-AI kernels such as newer attention variants need
custom datatypes, communication patterns, and detailed memory control. A
fixed operator vocabulary can make common graphs easy to optimize while
turning unanticipated hardware features into escape hatches or downstream
extensions.

## Two project histories, two incentive structures

TVM is presented as an academic and open-source reference implementation that
combined graph optimization, code generation, and autotuning across diverse
targets. Lattner credits its research impact and adoption, but says hardware
vendors maintained incompatible downstream forks, architectural changes
became harder, autotuning made compilation slow, and support for tensor-core
era hardware arrived late. He explicitly labels this an outsider's view. The
post does not provide activity data, compile-time measurements, or broad
benchmarks for its conclusion that TVM fell behind.

The XLA account is partly first-hand: Lattner joined Google Brain in 2017 to
work on TPUs and XLA. He credits XLA with scaling models across large TPU
systems and calls the TPU stack the most successful non-NVIDIA accelerator
platform. His critical distinction is between Google's internal TPU compiler
and public OpenXLA for CPUs and GPUs. They share some infrastructure, but he
says the dominant engineering investment and proprietary code are TPU
specific; GPU execution commonly falls back to CUDA libraries. The resulting
incentive problem is structural: Google's product interest is TPU performance,
not a neutral compiler for competitors' chips.

This is a valuable insider hypothesis, but several supporting claims remain
unmeasured in the post: the number of engineers, the fraction of shared code,
declining community activity, and the rule that no change benefiting other
chips would be prioritized at TPU's expense. They should be read as Lattner's
experience and interpretation, not as an independently established audit of
OpenXLA governance.

## What survives the project snapshots

The comparison yields three requirements beyond the earlier demand for a
reference implementation. A system must preserve full programmability so a
buyer can exploit the silicon it purchased; it must automate enough work to
manage the combinatorial space of operators and datatypes; and it must make
partitioning across devices and machines a first-class capability. TVM is
used to show the value and cost of an open multi-vendor implementation; XLA
shows what strong vertical alignment can accomplish and why that alignment
does not automatically transfer to an open ecosystem.

- **Durable:** kernel fusion as the motivating compiler transformation; the
  tension between a stable operator IR and new low-level mechanisms; and the
  way a sponsor's hardware incentives shape which backends receive first-class
  engineering.
- **Era-bound:** project activity, ownership after NVIDIA's OctoAI acquisition,
  the 2025 OpenXLA governance picture, StableHLO's then-current expressiveness,
  and which workloads used Pallas or CUDA libraries.
- **Caveats:** the essay selects cases and criteria to support an argument; it
  does not compare workload coverage, performance, compiler latency, or
  portability under a common methodology. Its Hacker News submission received
  no substantive comments, so it supplies no external adjudication.
- **Commercial stake:** Modular is developing MAX and Mojo as a unified,
  programmable AI stack. The essay's wishlist -- automatic optimization
  without loss of low-level control, multi-hardware reach, and coherent
  leadership -- is also a product thesis for that stack.
