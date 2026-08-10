# LLM memory

Mechanisms by which language-model systems retain and reuse information
across tokens, contexts, tasks, or sessions. Shelf:
[[zhoubian2026-memory]] (the model-architecture map),
[[wang2023-voyager]] (verified procedural memory),
[[zhang2025-ace]] (the structured playbook and its ablations),
[[karpathy2026-llm-wiki]] (compiled knowledge memory),
[[weng2026-harness]] (file-system memory as a harness primitive),
[[gao2025-self-evolving-survey]] (retention, evaluation, and safety), and
[[vincent2025-superpowers]] (memory-to-skill distillation's null result).

## Memory is a stack, not a module

“Memory” names mechanisms at different system layers. Inside the model,
[[zhoubian2026-memory]] distinguishes compute-coupled state—attention caches
and recurrent states—from storage with independently operated addressing or
update semantics, such as writable modules and lookup stores. It then
separates when the store changes from how long its influence survives. That
is an architectural account: prompt history, files, databases, reflection
traces, and agent orchestration are deliberately outside its scope.

The agent shelf occupies that outer layer. [[wang2023-voyager]] persists
verified programs; [[zhang2025-ace]] persists itemized lessons;
[[karpathy2026-llm-wiki]] persists cross-source synthesis; and
[[weng2026-harness]] treats the file system as durable task state. These are
not rival answers to whether a KV cache or recurrent state counts as memory.
They are a second memory plane whose reads, writes, permissions, and
lifecycle are controlled by the harness. A useful description therefore
names both the *substrate* and the *owner of its update policy*; “the agent
has memory” alone says almost nothing.

## The write gate matters more than the container

Across layers, storage becomes memory only through a lifecycle. The
architecture survey's fine-grained update lens—optimization, state
transition, signal-gated admission, eviction, and consolidation—has a direct
system-level analogue. Voyager's critic admits a program only after task
verification. ACE lets LLMs propose small changes but gives deterministic
code the irreversible merge, and its no-label result shows unreliable
feedback can make adaptation worse. The LLM wiki separates immutable raw
sources from an agent-maintained synthesis layer and makes lint a recurring
operation rather than assuming accumulation stays coherent.

The counterexample is revealing: [[vincent2025-superpowers]] mined 2,249
conversation-memory files for candidate skills and rejected almost all of
them because the working skill system had already absorbed the lessons.
More stored experience did not imply more reusable capability. Admission,
deduplication, provenance, verification, and forgetting are therefore the
load-bearing parts; an ever-growing folder or context window is only a
container.

## Every substrate chooses a loss budget

Token-level attention preserves local detail but pays storage and bandwidth
per retained token. Recurrent state keeps a bounded footprint by compressing
history, so interference and lost detail are structural risks. Addressable
stores preserve discrete entries and grow independently of dense
computation, but move the burden to indexing, retrieval, stale content, and
conflicting writes ([[zhoubian2026-memory]]).

Harness memory makes the same trade at a different granularity. ACE's
whole-context rewrites collapse accumulated detail, while itemized deltas
preserve provenance at the cost of pruning and retrieval hygiene.
Karpathy's compiled wiki avoids rediscovering relations on every query, but
requires continuous maintenance. Voyager keeps executable procedures rather
than whole trajectories, deliberately compressing experience into verified
skills. No design retains everything: it chooses what can be forgotten and
which future question will expose the loss.

## Evaluation must cross the persistence boundary

Nominal capacity is not effective memory. The architecture survey calls for
separate measures of capacity, retrieval fidelity, persistence,
interference, and efficiency; long context alone conflates storage with the
ability to use it. At the agent layer, [[gao2025-self-evolving-survey]] finds
that benchmarks usually reset state between tasks, making them structurally
unable to measure accumulation or decay—the property persistent memory was
introduced to supply.

A memory evaluation must therefore last at least as long as the persistence
claim. Within-session memory needs controlled distance, distraction, and
cost curves. Cross-session memory needs sequences of tasks that test useful
transfer, stale or adversarial writes, interference, and eventual
forgetting. A successful write is not evidence of learning; the evidence is
future benefit under the same lifecycle and resource budget, with a gate
outside the component being updated.

## The open seam is internalization

[[weng2026-harness]] predicts that successful harness functions will
gradually move into models while external context and tool interfaces
remain. [[zhoubian2026-memory]] surveys that architectural frontier from the
other side: writable parameters, model-integrated lookup, and hybrid memory
paths increasingly turn retention into a first-class model design choice.
The unresolved question is not whether model or harness memory wins, but
which lifecycle operations can be internalized without losing inspectable
writes, rollback, provenance, and independent evaluation. The safety warning
from [[gao2025-self-evolving-survey]] travels across the seam: persistence
makes poisoning, drift, and reward hacking cumulative too.
