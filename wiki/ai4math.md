# AI for mathematics

AI systems producing mathematics, and the machinery for trusting what
they produce. Shelf: [[openai2026-ten-advances-in-mathematics]] (the
capability claim), [[demoura2026-postmortem-for-kernel-soundness-bug]]
(the trust infrastructure's failure mode, published the same day), and
[[jiang2026-from-solvers-to-research]] (the field map: position paper
+ survey arguing the solver regime is saturated and the frontier is
research agents).

## The trust architecture

The ten-advances announcement exhibits no mathematics; its evidentiary
weight rests on released Lean certificates — machine-checked proof as
the move that neutralizes skepticism of corporate research claims,
modulo checking that formal statements match informal ones. The
postmortem quantifies the residual risk behind exactly that move: a
kernel implementation bug (phantom parameters escaping type checking
in nested inductives) admitted a `sorry`-free proof of `False`,
reachable through metaprogramming. The layered answer that actually
carries the trust: the kernel must reject ill-typed declarations on
its own (soundness can never depend on the untrusted elaborator
declining to build bad terms), independent checkers cross-check it —
and the exploit's defeat of week-old nanoda required *two distinct
bugs in two implementations*, which is the defense-in-depth arithmetic
working in principle while showing its operational condition: the
checkers only compose if all are kept current. Verified kernels
(lean4lean's in-progress consistency proof) are the next layer; its
inductive handling inherited the bug precisely because it is a port,
not yet a verification.

Above the kernel sits a second trust layer the certificates don't
cover: **statement fidelity**. [[jiang2026-from-solvers-to-research]]
documents it as the field's recurring failure — compilation does not
imply the formal statement captures the intended theorem. The
standard example: Aristotle's machine-checked late-2025 "solution" to
Erdős #124 proved a weakened variant omitting the gcd constraint (the
problem remains open), and formalizers with equal headline scores
yield sharply different downstream prover success. Together the two
layers bound what "machine-checked" certifies: the kernel can be
wrong about the proof, and the formalization can be wrong about the
statement.

## AI on both sides of the ledger

The same week's events place AI at every position: generating the
proofs (ten problems, solution-finding compute framed at "roughly
$2,000"), assisting the exploit (the Collatz "disproof" was
AI-assisted, built deliberately to demonstrate the soundness bug), and
hunting the defects (a cybersecurity-specialized model run over the
kernel found further metaprogramming-only bugs, all caught by current
nanoda). The Breitner hypothesis is the sentence to keep: models are
now strong enough to find kernel soundness bugs, which changes the
threat model for proof infrastructure — certificates invite
adversaries exactly as they reassure reviewers.

## Solvers, not yet researchers

[[jiang2026-from-solvers-to-research]] supplies the shelf's base
rates. Competition benchmarks are exhausted (miniF2F ~30%→99.6% in
four years; IMO at medal level), but the Erdős-problem accounting —
maintained on a co-author's own database — shows genuinely novel
AI-primary solutions are the smallest category, dwarfed by AI
literature reviews and AI-formalized proofs, and outnumbered by
solutions that turned out to be rediscoveries of published work.
Claimed pattern: AI succeeds on insight-then-short-proof problems;
sustained novel construction and concept invention remain the
boundary (score-function-driven evolution à la AlphaEvolve widens
search but reorganizes nothing). This is the frame to apply to any
capability claim on this shelf: check rediscovery, check
specification, expect selection bias in what gets reported.

## The workflow shape

Model-generated arguments → human-assisted manuscripts → Lean
formalization → released per-solution reasoning traces. Alongside it,
an explicit attribution ethic (claiming human authorship for an
AI-generated proof misrepresents both sides) — an early staked
position in a live dispute. In
[[liu2026-a-taxonomy-of-self-evolving-agents]]'s frame, this is the
loop closing on science rather than benchmarks.

## What the shelf needs next

The announcement is deliberately thin; the mathematics lives in the
linked ten-proofs paper — the natural next ingestion, as a papers/
entry, now with jiang2026's checklist to apply (rediscovery,
specification fidelity, selection bias). Open questions the current
works raise but don't settle: *tooling* for statement–formalization
correspondence (jiang2026 names the failure and floats FormalAlign-
style checkers, but nothing settles it); whether the released
reasoning traces support or merely narrate the discovery claims; how
the five named human follow-up papers to the unit-distance disproof
treat AI-originated results; and whether the First Proof challenge
(ten never-published research problems, endorsed by jiang2026 as the
clean evaluation) resists the contamination that saturated the
competition benchmarks. The kernel-side thread continues too:
verified kernels reaching inductives, and whether comparator-style
daily cross-checking becomes standard practice.
