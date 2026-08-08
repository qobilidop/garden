---
citekey: demoura2026-postmortem-for-kernel-soundness-bug
work:
  title: "Postmortem for Kernel Soundness Bug #14576"
  author: Leonardo de Moura
  date: 2026-08-01
source:
  url: https://leodemoura.github.io/blog/2026-8-1-postmortem-for-kernel-soundness-bug-14576/
  archived: https://web.archive.org/web/20260802053903/https://leodemoura.github.io/blog/2026-8-1-postmortem-for-kernel-soundness-bug-14576/
  # predates retrieved, but verified byte-identical to the capture
discussions:
  - https://news.ycombinator.com/item?id=49137060  # 2026-08-01
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-07
---

# Notes: Postmortem for Kernel Soundness Bug #14576

First-party incident postmortem by Lean's creator (Lean FRO chief
architect), published four days after the fix. The incident: on July 25,
2026, Ramana Kumar published an AI-assisted, `sorry`-free "disproof" of
the Collatz conjecture — deliberately built to demonstrate a soundness
bug, not a serious mathematical claim. Kiran Gopinathan reduced it to a
small proof of `False` and opened lean4#14576 on July 28; a fix was
pushed one hour after the report, reviewed by Joachim Breitner, and
released as patches.

## The bug and its boundary

When the kernel eliminates a nested occurrence under an inductive type
whose parameters are phantom (not mentioned in constructor fields), those
parameters vanish from the generated auxiliary type and escape type
checking — an ill-typed argument there yields an accepted proof of
`False`. Reachable only through metaprogramming (declarations sent to the
kernel directly); the elaborator catches the ill-typed term. The post is
emphatic that this is an implementation bug, not a hole in Lean's
meta-theory.

## The defense-in-depth story is the interesting part

The exploit also passed a week-old version of nanoda, the main
independent Rust checker — but via a second, unrelated bug (nanoda
skipped verifying the type name in a projection node; already fixed a
week earlier from Jeremy Chen's report). The proof was crafted so the
expression the official kernel never inspects was one old-nanoda
accepted. So cross-checking with an independent kernel did its job in
principle — defeating it required two distinct bugs in two
implementations — but only if both checkers are current. lean4lean
inherited the kernel bug (its inductive handling is a port), and its
in-progress consistency proof doesn't yet cover inductives, though
completing that verification would have surfaced the bug.

Two timing observations worth keeping: Kumar can't rule out that the
model had seen the nanoda bug report, and Breitner's hypothesis is that
the coincidence reflects models now being strong enough to find such
bugs. AI appears on both sides of the ledger — the exploit was
AI-assisted, and in response Daniel Selsam at OpenAI ran a
cybersecurity-specialized AI over the kernel, finding further bugs (all
fixed, all caught by current nanoda, all metaprogramming-only).

## Position taken

Against restricting metaprogramming as a remedy: the elaborator is
untrusted by design, soundness cannot depend on an untrusted component
declining to build bad terms (attackers can write `.olean` files or
modify memory anyway), and the kernel must reject ill-typed declarations
on its own — the separation being "one of the main advantages of proof
terms." Remediation listed: regression tests in the Kernel Arena, a
stricter parameter check (lean4#14582), invariant hardening, nanoda now
run by default on comparator.live and tracked daily, and outreach to
experts for new and verified kernels.

## Assessment

A model postmortem: specific mechanics, named credits, a one-hour fix, no
defensiveness, and an explicit architectural argument instead of a
feel-good process fix. For this library it is the direct counterweight to
openai2026-ten-advances-in-mathematics, whose evidentiary story leans on
Lean certificates neutralizing skepticism of corporate math claims — this
incident quantifies the residual risk behind that move (kernel
implementation bugs exist) and shows why the layered answer (independent
checkers kept current, eventually verified kernels) is what actually
carries the trust. Durable: the two-independent-bugs arithmetic of
defense in depth, and the untrusted-elaborator principle. Era-bound: the
specific PR inventory. The Breitner hypothesis — models strong enough to
find soundness bugs change the threat model for proof infrastructure —
is the sentence most worth remembering.
