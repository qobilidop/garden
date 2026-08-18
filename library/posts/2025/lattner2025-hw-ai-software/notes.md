---
citekey: lattner2025-hw-ai-software
work:
  title: "Why do HW companies struggle to build AI software? (Democratizing AI Compute, Part 9)"
  author: Chris Lattner
  date: 2025-04-22
source: https://www.modular.com/blog/democratizing-ai-compute-part-9-why-do-hw-companies-struggle-to-build-ai-software  # snapshot + figures (1 PNG) → shadow
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "AI-accelerator competition is an organizational and ecosystem problem before it is a chip-design problem: hardware differentiation multiplies the software burden while incumbent-focused community work compounds NVIDIA's advantage."
---

# Why do HW companies struggle to build AI software? (Democratizing AI Compute, Part 9)

The series' diagnosis of why technically credible AI accelerators so often fail
to become usable platforms. Lattner shifts the unit of analysis from compiler
features to the organization and market around them: a hardware company books
revenue on silicon and manages tapeouts, so software tends to be funded as
supporting overhead even though users experience the software ecosystem as the
product. The result is a mismatch between what an alternative accelerator must
ship and what its organization is set up to value.

## The compounding burden

The central mechanism has three coupled parts.

First, AI support is a moving cross product, not a compiler backend. A vendor
must cover models, quantization formats, batch shapes, training and inference,
cloud and edge deployment, and changing frameworks. Every architectural
innovation that differentiates a chip also creates more hardware-specific work
across that product space. This contrasts with the author's account of the CPU
era, when an LLVM backend could inherit much of an existing operating-system
and application ecosystem.

Second, NVIDIA's advantage is supplied by an industry, not just by NVIDIA.
New frameworks, papers, kernels, and optimizations tend to target its current
hardware first. A challenger therefore has to do more than make a workload
run: it must catch a hardware-software combination improved by external
developers while also demonstrating that its own distinct architecture is
worth switching to. Compatibility translators preserve source syntax but
cannot automatically translate kernels tuned for Hopper Tensor Cores, TMA,
and memory hierarchy into good use of a different machine.

Third, short-term business pressure prevents the investment that could reverse
the loop. Software teams handle customer escalations and benchmark demands,
then customize for a large prospective buyer—the post's "chase the whale"
pattern—instead of building reusable infrastructure. Local wins accumulate as
forks, special cases, documentation debt, and knowledge held by individuals.
The platform remains a services project, leaving the next hardware generation
with the same deficit.

## Four organizational boats

The regatta metaphor separates competitors by the constraints they face:

- startups optimize a few benchmark workloads to prove the chip and survive;
  generality and usability do not yet improve the pitch;
- vertically integrated companies can fund bespoke stacks for a narrow set of
  chips and workloads, but users must adopt the whole vertical system;
- large incumbents have resources and installed bases but divide software
  teams across old and new architectures, products, and toolchains; and
- NVIDIA coordinates the leading platform while the surrounding research and
  open-source ecosystem extends it.

This is a useful taxonomy of failure modes, not a demonstrated partition of
the industry. Apple, Google, Intel, AMD, Qualcomm, startups, and NVIDIA appear
as illustrative types; the post supplies no comparative budgets, staffing,
adoption data, or case histories with which to test the categories. The vLLM
hardware-support matrix is the one concrete artifact behind the cross-product
claim, while the rest of the evidence is the author's experience at Intel,
Apple, Google, and SiFive and his interpretation of industry outcomes.

## Assessment

- **Durable:** the product boundary is larger than the chip or compiler. A
  differentiated instruction set without maintained frameworks, kernels,
  debugging, deployment, documentation, and community support is not a usable
  alternative. The conflict between one-customer optimization and a reusable
  platform is also independent of today's model or accelerator names.
- **Durable but not quantified:** ecosystem effort compounds around the
  installed platform, so a challenger must overcome both technical switching
  costs and the direction of third-party optimization. The post makes this
  mechanism plausible but does not measure its size or show that only one
  organizational design can counter it.
- **Era-bound:** Hopper-specific translation problems, vLLM's displayed
  compatibility matrix, the standing of oneAPI, and the claim that competitors
  remain perpetually two years behind describe the 2025 landscape. They are
  examples, not stable laws.
- **Overreach:** saying hardware companies are "structurally incapable" of
  treating software as a product is stronger than the evidence. The author's
  own Apple and Google examples show that unified incentives and vertical
  integration can produce effective hardware-software systems, albeit not
  necessarily portable public platforms.
- **Commercial stake:** this is the transition from the series' critique of
  alternatives to Modular's proposed answer. Framing chip vendors as unable to
  sustain neutral AI infrastructure creates the market category an independent
  software-platform company wants to occupy. That stake does not invalidate
  the organizational diagnosis, but it makes the universal claims and the
  absence of counterexamples especially important.

The post's lasting contribution is the causal frame: software inadequacy is
not merely a lagging implementation backlog. It is reproduced by revenue
models, planning horizons, customer concentration, and an incumbent-centered
ecosystem, so another API or compatibility layer cannot by itself close the
gap.
