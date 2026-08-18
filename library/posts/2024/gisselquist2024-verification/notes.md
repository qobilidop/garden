---
citekey: gisselquist2024-verification
work:
  title: My Personal Journey in Verification
  author: Dan Gisselquist
  date: 2024-07-06
source: https://zipcpu.com/formal/2024/07/06/verifjourney.html  # snapshot + figures (2 SVGs) → shadow
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "Hardware verification quality grew by adding complementary failure detectors—formal contracts, cover and induction, configuration sweeps, integration tooling, mutation and code coverage, and self-checking simulation—because each apparently complete method left a different blind spot."
---

# My Personal Journey in Verification

Gisselquist gives a longitudinal practitioner account of how "working in
hardware" repeatedly failed as a quality criterion. Manual inspection and
happy-path simulation missed bugs; formal proofs found many of them but left
assumption and integration gaps; coverage metrics exposed untested structure
without establishing behavior; and component tests did not exercise software
drivers. The result is not a championing of one technique but an argument for
a portfolio whose methods fail differently.

## Formal changed the questions, not only the bug count

SymbiYosys found latent defects in a FIFO and then across previously deployed
designs, including the ZipCPU. The author's response matured from adding
assertions opportunistically to four reusable proof practices:

- bidirectional interface property sets swap assumptions and assertions across
  a master/slave boundary, reducing the risk of assuming behavior no component
  guarantees;
- cover checks test that ostensibly proven behavior is reachable and catch
  vacuity such as an incorrect reset polarity;
- induction reaches beyond shallow traces, at the cost of substantial proof
  engineering; and
- a formal contract states a component's behavioral essence, while parameter
  sweeps check configurations that a single simulation build silently omits.

This makes property engineering part of the artifact. A solver can exhaust
the wrong contract, pass vacuously under an impossible environment, or verify
one parameterization of a family. Formal coverage and complementary property
roles test the harness rather than treating it as trusted setup.

The account also gives a practical scaling boundary. Exhaustive search becomes
expensive, so Gisselquist verifies components rather than entire designs.
Verified leaves can still be miswired. His response was not a larger proof but
stronger composition: redesigned bus interconnects, linting, named ports, and
AutoFPGA-generated connections reduce integration errors by construction.

## Independent detectors reveal independent holes

Mutation coverage with Yosys deliberately corrupts the design and asks whether
the test suite notices. In one ZipCPU experiment, simulations detected roughly
70% of mutations and formal properties 95–98%. Those numbers are personal
measurements under an awkward setup, not general tool rankings. Their useful
result was diagnostic: simulation never exercised the debug port, so mutations
there survived. Tool friction also mattered—moving embedded formal properties
out of the mutated module conflicted with the then-open-source flow—and the
author ultimately declined to adopt MCY.

Ordinary code and signal coverage helped find further holes but could also be
gamed by activity unrelated to the intended behavior. The eventual workflow
combines formal tests, simulation, coverage, and self-checking testbenches. A
bus-functional model and device model let many scripts exercise the same
device-under-test environment; varying bus width and configuration catches
errors a single happy path hides. The final open gap is hardware/software
co-verification: a realistic driver test needs a CPU, memory, toolchain,
console, and peripheral models beyond the component repository.

This complements [[verbeure2019-under-hood]]. Verbeure shows how a compact
cover goal can synthesize a trace; Gisselquist shows why cover, proof,
simulation, mutation, and integration checks must cross-check one another.
It also qualifies the broad adoption economics in
[[wayne2019-formal-methods]]: for reusable RTL components, proof cost can be
amortized across products, while whole-system scope remains the limiting cost.

- **Durable:** verify assumptions from the opposite interface role; use cover
  to detect vacuity; sweep parameterizations; test the tests with mutation;
  and preserve independent methods instead of treating coverage as proof.
- **Era-bound:** named tool limitations, source links, the author's current
  ZipCPU harness, and the unresolved 2024 driver-testing architecture.
- **Evidence boundary:** the post is a retrospective from one designer and
  codebase. Bug counts and mutation percentages are neither controlled nor
  broadly representative, and no indexed Hacker News discussion was found.
- **Commercial stake:** Gisselquist sells engineering and formal-training
  services and presents verified reusable components as valuable inventory.
  The failures and abandoned tools reported here make the account more
  informative, but its recommendations remain grounded in his workflow.

The strongest survey lesson is methodological: no tool's own success metric
is an adequate evaluation of the verification system. Assertions need cover,
tests need mutation, components need integration checks, and hardware needs a
path to the software that will exercise it.
