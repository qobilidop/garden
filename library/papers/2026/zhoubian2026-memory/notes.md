---
citekey: zhoubian2026-memory
work:
  title: "Memory for Large Language Models"
  author: Sining Zhoubian, Dan Zhang, Evgeny Kharlamov, and Jie Tang
  venue: arXiv preprint
  date: 2026-07-28
  doi: 10.48550/arXiv.2607.25380
  arxiv: 2607.25380 (v1, 2026-07-28; preprint)
sources:
  pdf: https://arxiv.org/pdf/2607.25380v1  # → shadow; pinned to v1
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-10
synthesis: "The durable map separates compute-coupled state from independently operated storage, then asks when memory changes and how long its influence survives; the map is more convincing than its treatment of static MoE experts as explicit memory or its undocumented survey method."
---

# Memory for Large Language Models

Architecture-centric survey of memory inside LLMs: 20 pages, 85 references,
and four diagrams spanning attention caches, recurrent states, writable
parameters, addressable stores, routed experts, and hybrids. Its useful move
is to classify mechanisms by what they *do as storage*, not by whether they
look like a tensor, database, or weight matrix. The paper is clear about its
scope: model architecture and inference-time dynamics, not prompt history,
user profiles, agent reflection traces, vector-database RAG pipelines, or
other harness-level memory. The result is a compact conceptual map, not an
empirical comparison or a reproducible systematic review.

## Three axes separate questions that “memory” often conflates

**Representation** asks whether stored information is inseparable from the
forward computation or has an independently operated interface. Attention
KV caches and recurrent hidden states are *implicit*: even when materialized
as tensors, their reads and writes are fixed by the computation graph.
Dedicated parameter modules, slots, and lookup stores are *explicit* when
they expose autonomous addressing or update semantics.

**Update dynamics** asks when and how memory changes. The coarse split is
offline (training only) versus online (inference-time updates), but the more
useful refinement distinguishes optimization-based writing, learned state
transitions, signal-gated admission or routing, admission/eviction/
consolidation, and objective-induced or structural updates. This makes the
write policy visible instead of treating storage capacity as the whole
design.

**Persistence** asks how long stored information can still affect
computation. The paper usefully refuses to equate horizon with physical
size: a token-level cache can be large yet short-lived, while a fixed-size
recurrent state can compress influence from an unbounded stream. That same
choice creates the central fidelity tradeoff—fine-grained storage grows;
bounded state forgets through compression.

The figures make the taxonomy easier to grasp than the prose: one tree
places the three axes above implicit, explicit, hybrid, systems, and
evaluation branches; companion diagrams show implicit memory as attention,
selective access, and recurrence, then explicit memory as writable modules,
lookup stores, routed experts, and multi-timescale updates.

## The architecture is a set of loss and control tradeoffs

Attention offers high-fidelity, content-addressed working memory, but its KV
state grows with retained tokens and nominal context length does not ensure
effective recall. Sparse and windowed attention therefore implement access
and eviction policies. Recurrent and state-space models replace token-wise
storage with bounded evolving state, gaining streaming efficiency while
making interference and irreversible compression the price.

Explicit mechanisms move the control surface. Writable parameter subsets
and latent slots separate fast adaptation from a stable backbone; lookup
stores make entries individually addressable and let capacity scale apart
from dense computation. Their costs are different rather than absent:
indexing, growth, stale entries, test-time objective mismatch, drift, and the
stability–plasticity problem. Hybrid architectures make allocation itself a
design question—whether high-resolution attention or persistent writes are
fixed in advance or gated by uncertainty, surprise, or predicted utility.

The systems and evaluation sections correctly widen the accounting beyond
accuracy. Compression and paging change the operational memory substrate;
evaluation should distinguish capacity, recall fidelity, persistence,
interference robustness, latency, and storage cost. The paper proposes this
as an agenda, however; it does not supply a common benchmark, a metric suite,
or comparative measurements across the categories.

## The model boundary clarifies agent memory

The exclusion of agent orchestration is productive. [[wang2023-voyager]]'s
verified program library, [[zhang2025-ace]]'s incrementally maintained
playbook, [[karpathy2026-llm-wiki]]'s compiled knowledge layer, and the file
system memory in [[weng2026-harness]] are explicit, persistent stores at the
*system* level, not examples of the model-level architecture surveyed here.
The same questions still transfer—what is addressable, what admits a write,
what is retained, and what is forgotten—but the mechanism and evaluator sit
outside the model. Treating the two layers separately prevents “long
context,” “agent memory,” and “learning” from becoming synonyms.

## Assessment

- **Durable:** the compute-coupled versus independently operated storage
  boundary; the separation of representation, update policy, and effective
  horizon; and the insistence that memory be evaluated as a vector of
  fidelity, persistence, interference, and cost rather than by context
  length alone.
- **Conceptual tension:** the paper excludes ordinary static pretrained
  parameters, yet classifies MoE expert subnetworks as offline explicit
  memory. Sparse routing makes experts conditionally addressable, but it
  does not by itself give them autonomous storage or write semantics. On the
  paper's own definition, MoE is at best a boundary case, not a clean core
  exemplar.
- **Ambiguity:** “long-term” sometimes means influence over a long sequence
  and sometimes persistence across contexts or sessions. A recurrent state
  can satisfy the first while being discarded at the session boundary, so
  the label should never be read as durable cross-session retention without
  checking the mechanism.
- **Weaknesses:** despite calling the review systematic, the paper reports
  no search sources, queries, cutoff, inclusion criteria, selection flow, or
  evidence-assessment procedure. Its broad and very recent roster is useful
  orientation but provides no completeness guarantee. Several architectural
  classifications are interpretive, and the evaluation chapter is a
  research program rather than evidence that the proposed dimensions have
  been isolated successfully.
- **Era-bound:** the 2025–2026 model roster and the claim that memory is
  becoming a first-class design dimension describe a fast-moving preprint
  frontier. The questions travel farther than the named systems.
