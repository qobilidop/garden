# AI for mathematics

AI systems producing mathematics, and the machinery for trusting what
they produce. Young shelf, two works in deliberate tension:
[[openai2026-ten-advances-in-mathematics]] (the capability claim) and
[[demoura2026-postmortem-for-kernel-soundness-bug]] (the trust
infrastructure's failure mode, published the same day).

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
entry. Open verification questions the current works raise but don't
settle: who checks statement–formalization correspondence (the one
step Lean certificates don't cover); whether the released reasoning
traces support or merely narrate the discovery claims; and how the
five named human follow-up papers to the unit-distance disproof
treat AI-originated results. The kernel-side thread continues too:
verified kernels reaching inductives, and whether comparator-style
daily cross-checking becomes standard practice.
