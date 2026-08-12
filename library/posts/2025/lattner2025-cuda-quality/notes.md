---
citekey: lattner2025-cuda-quality
work:
  title: CUDA is the incumbent, but is it any good? (Democratizing AI Compute, Part 4)
  author: Chris Lattner
  date: 2025-02-20
source: https://www.modular.com/blog/democratizing-ai-compute-part-4-cuda-is-the-incumbent-but-is-it-any-good
discussions:
  - https://news.ycombinator.com/item?id=43121375  # 2025-02-20
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "CUDA has no context-free quality verdict: its mature ecosystem helps application developers, its low-level control taxes performance engineers, its vendor boundary blocks portable software, and its accumulated compatibility burden may constrain NVIDIA itself."
---

# CUDA is the incumbent, but is it any good? (Democratizing AI Compute, Part 4)

The question in the title is decomposed by stakeholder. For application-level
AI engineers, CUDA's ubiquity means that frameworks and packages usually
target NVIDIA hardware, but coordinating driver, toolkit, framework, and
container versions is fragile. For kernel and model-performance engineers,
the platform exposes enough control to reach high performance, yet newer GPU
features can require PTX, architecture-specific knowledge, and long C++
compile/debug cycles. For portable-software builders, CUDA is definitionally
vendor-specific. For NVIDIA, the same installed base and compatibility promise
that generate revenue also create a large maintenance surface.

This is a valuable correction to a one-dimensional benchmark comparison:
platform quality includes availability, usability, performance control,
portability, and the cost of evolution, and those properties accrue to
different parties. It also qualifies [[lattner2025-cuda-success]]. A
self-reinforcing ecosystem can be both a competitive advantage and a source of
technical debt.

## Four views of the trade-off

The application-developer section grounds versioning friction in two linked
failure reports and argues that containerized products such as NIM solve
particular deployment paths by adding another opaque, NVIDIA-controlled layer.
The performance section points to FlashAttention-3 and DeepSeek as cases where
teams descend to PTX, then treats Tensor Core programming and CUDA C++'s
language/tooling mismatch with Python-centric AI research as further iteration
costs. The portability section observes that a CUDA backend cannot run on
other vendors' accelerators and that maintaining parallel optimized paths is
expensive enough to favor the largest installed base.

The NVIDIA section turns the critique inward. CUDA supports a winner-takes-
most position -- the post cites a report estimating roughly 98% of 2023 data-
center GPU shipments -- but NVIDIA must staff and retune an enormous software
estate for each architecture. It invokes Jim Keller's “swamp” analogy and
Blackwell compatibility documentation to argue that backward compatibility
can eventually conflict with access to new hardware behavior.

## Limits of the case

The evidence is illustrative rather than systematic: two compatibility
incidents, a meme, a cartoon, vendor documentation, a market-share report, and
expert quotations. Several strong formulations also blur the layers that the
previous post carefully separated. Direct CUDA kernel work is C++-centered,
but the broader CUDA Platform has Python bindings, libraries, frameworks, and
other front ends. Generating PTX bypasses the CUDA C++ compiler path, not
NVIDIA's driver, instruction-set contract, or platform. And the need to retune
for new hardware does not by itself show that CUDA has failed to evolve; it
also follows from exposing increasingly specialized hardware.

## Assessment

- **Durable:** evaluating infrastructure separately for application users,
  performance specialists, portability maintainers, and the platform owner;
  separating functional compatibility from performance portability; and
  recognizing backward compatibility as both ecosystem capital and a future
  design constraint.
- **Era-bound:** the CUDA-version examples, NIM, the cited 2023 market share,
  Hopper/Blackwell PTX details, current Tensor Core interfaces, and the exact
  Python/C++ workflow split.
- **Caveats and stake:** the post is an informed but prosecutorial brief. It
  documents real friction while selecting evidence that supports a CUDA-
  replacement thesis and does not compare failure rates, engineering cost, or
  performance against alternatives. Lattner leads Modular, which markets MAX
  and Mojo around portable performance; the diagnosis maps directly onto the
  capabilities the company intends to sell.
