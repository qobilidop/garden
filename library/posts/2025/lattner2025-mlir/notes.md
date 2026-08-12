---
citekey: lattner2025-mlir
work:
  title: What about the MLIR compiler infrastructure? (Democratizing AI Compute, Part 8)
  author: Chris Lattner
  date: 2025-04-08
source: https://www.modular.com/blog/democratizing-ai-compute-part-8-what-about-the-mlir-compiler-infrastructure
discussions:
  - https://news.ycombinator.com/item?id=43640622  # 2025-04-10
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "MLIR succeeded as shared infrastructure for building heterogeneous compilers, but its dialect extensibility could not itself supply the product leadership, reference stack, or aligned incentives needed to unify AI software."
---

# What about the MLIR compiler infrastructure? (Democratizing AI Compute, Part 8)

Part 8 is both an origin account and a correction to an overbroad measure of
success. Lattner describes creating MLIR at Google to stop frameworks and
hardware teams from rebuilding compiler machinery. Its dialect system did
make reusable, multi-level compiler infrastructure widely available. The AI
ecosystem nevertheless remained fragmented because infrastructure for
building compilers is not an end-to-end compiler product.

## The origin and the dialect bet

Lattner traces MLIR to work on TPUs and other Google ASICs around 2018. With
four colleagues, he explored how one representation could accommodate
framework graphs, hardware-specific operations, and transformations at
multiple abstraction levels. The answer was not a universal fixed IR but an
extensible framework: dialects can define their own operations, types, and
semantics while sharing parsing, analysis, transformation, and lowering
infrastructure.

This is the post's most important contribution. MLIR sought to unify compiler
implementation, not erase domain-specific representations. Different levels
could coexist and be transformed without forcing TensorFlow graphs, tensor
algebra, accelerator instructions, and LLVM-level code into one vocabulary.
Lattner's first-person account is valuable primary testimony about the design
intent, though the remembered dialogue and causal narrative are not a complete
project history.

The account credits early internal adoption across Google ASIC, mobile, and
TensorFlow Lite teams, followed by open sourcing through the LLVM Foundation
and open design meetings. MLIR then became infrastructure under projects such
as OpenXLA and Triton and reached non-AI domains including CIRCT hardware
design and quantum compilation. On its original terms -- enabling many
specialized compilers to share a foundation -- Lattner judges it a success.

## Why infrastructure did not become an AI platform

Demand for an end-to-end path from TensorFlow or PyTorch to every accelerator
pulled the project beyond that infrastructure mission. Teams upstreamed
general arithmetic, tensor, and linear-algebra dialects while downstream
projects built competing complete stacks. Lattner argues that the expansion
happened before the core and governance had stabilized. Early dialect choices
reflected TensorFlow and OpenXLA needs more than later PyTorch and generative-AI
workloads, while broad contribution made incompatible ambitions difficult to
steer.

The post describes a second mechanism: early MLIR developers dispersed from
Google to competing hardware companies. Shared infrastructure remained useful,
but employer incentives directed contributors toward proprietary downstream
stacks. The result was an identity problem. “MLIR” could mean the
domain-independent framework or a loose collection of AI-related dialects,
even though neither the foundation nor those dialects constituted a usable AI
solution by itself.

Lattner welcomes a newer governance structure with area teams separating Core
from dialect concerns and proposes giving the AI dialect collection another
name. That is a coherent remedy for scope confusion, not evidence that the
underlying commercial conflicts have disappeared.

## Reading the success and failure claims carefully

The essay is notably self-correcting: it calls its own AI-platform scorecard
“wildly unfair” to MLIR Core and distinguishes the successful toolkit from an
unrealized unification ambition. The central lesson is that modular technical
architecture permits plural implementations; it does not choose a product
roadmap, guarantee a performant reference stack, or align competitors.

Several broader claims are not demonstrated here. “Nearly every major AI
stack,” incomplete or contested dialects, and no MLIR-AI downstream stack
matching CUDA are not backed by a defined inventory or benchmark. The causal
link from early scaling to later fragmentation is Lattner's management
interpretation. The Hacker News submission received no comments and therefore
does not independently test it.

- **Durable:** dialects as a way to share infrastructure without imposing one
  abstraction level; the separation of toolkit success from product success;
  and the fact that technical modularity cannot replace governance or aligned
  incentives.
- **Era-bound:** the 2025 area-team structure, the boundaries and maturity of
  particular dialects, contributor affiliations, and which downstream stacks
  matched then-current CUDA workloads.
- **Caveats:** this is a founder's retrospective that blends direct memory,
  architectural explanation, and a theory of organizational failure. It is
  not a contributor survey or empirical study of the downstream ecosystem.
- **Commercial stake:** Modular builds a vertically coordinated compiler and
  AI platform using lessons associated with MLIR. The distinction between
  open infrastructure and a coherent end-to-end product explains both MLIR's
  limits and the market role Modular claims for itself.
