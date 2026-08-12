---
citekey: lattner2025-cuda
work:
  title: What exactly is “CUDA”? (Democratizing AI Compute, Part 2)
  author: Chris Lattner
  date: 2025-02-05
source: https://www.modular.com/blog/democratizing-compute-part-2-what-exactly-is-cuda  # snapshot → shadow; figures (1 PNG) → store
discussions:
  - https://news.ycombinator.com/item?id=42955793  # 2025-02-05
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "CUDA is most usefully understood as a vertically integrated platform—driver, programming model, optimized libraries, and application-level solutions—whose accumulated layers explain both its leverage and the difficulty of replacing it."
---

# What exactly is “CUDA”? (Democratizing AI Compute, Part 2)

The post's main contribution is terminological. “CUDA” can name a C++-derived
kernel language, the driver interface that moves memory and launches work, a
large body of tuned libraries, or complete AI-serving products. Lattner calls
the union the **CUDA Platform** and argues that evaluating an alternative
against only one layer mistakes the competitive object. The better analogy is
an operating system or the Java ecosystem: a branded, integrated software
estate that mediates between hardware and several kinds of developer.

## The layers and their users

The historical sketch moves from fixed-function graphics through the
GeForce3's programmable shaders and Stanford's BrookGPU to NVIDIA's
general-purpose compute platform. At the lowest public level, programmers
write kernels around GPU threads and memory while the driver handles
allocation, transfers, and execution; compilation targets PTX, NVIDIA's
low-level virtual instruction set. The included vector-add example illustrates
the control and incidental detail exposed at this level: pointers, launch
geometry, memory copies, and hardware-specific tuning choices.

CUDA libraries then move the optimization burden from domain developers to
NVIDIA. cuBLAS, cuFFT, and especially cuDNN package operations that would
otherwise require specialist kernels and repeated retuning across device
generations. Frameworks such as TensorFlow and PyTorch depend on that middle
layer. TensorRT, TensorRT-LLM, and Triton Serving move higher again, giving AI
engineers complete optimization and deployment paths that can hide kernel
programming altogether. Four progressively expanded stack diagrams make the
dependency argument concrete: the apparent simplicity at the top rests on
deep, NVIDIA-controlled integration below.

This layered definition also resolves an ambiguity carried forward from
[[lattner2025-deepseek-impact]]. Producing PTX directly may bypass the CUDA C++
front end, but it does not escape the NVIDIA platform or its driver and ISA.
Conversely, replacing the CUDA language alone does not reproduce the tuned
libraries and application products on which mainstream AI frameworks rely.

## Performance portability is the hidden service

The post distinguishes source compatibility from performance portability. A
kernel may continue to execute on a later GPU yet leave new hardware far below
its potential; NVIDIA absorbs much of the recurring rewrite cost in its
closed-source libraries. That is a stronger account of CUDA's value than “a
language that makes GPUs fast”: the platform coordinates evolution across
hardware generations and exposes the result at several levels of abstraction.
It also explains the lock-in. The optimizations, behavior, and accumulated
coverage behind stable APIs are proprietary and cannot be recreated by
implementing the surface syntax.

## Assessment

- **Durable:** the layered platform model; the distinction between code that
  still runs and code that exploits a new architecture; and the observation
  that middleware can carry more ecosystem value than a programming-language
  interface.
- **Era-bound:** the named product stack, its division of labor, and the claim
  that current framework developers can be cleanly divided into kernel,
  model, and application roles. NVIDIA's interfaces and AI frameworks will
  continue to move.
- **Caveats and stake:** this is an accessible architectural history, not an
  inventory, benchmark, or independent study. It compresses contested
  historical priorities into a straight line toward CUDA and gives little
  attention to APIs, language bindings, or open components that complicate
  the proprietary-platform label. Modular's commercial program needs the
  replacement target to be the whole stack: MAX and Mojo are promoted at the
  end as the company's own answer to portability and developer usability.
