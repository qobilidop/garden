---
citekey: anthropic2026-riemann-zeta
work:
  title: Learning more about Claude's mathematical capabilities
  author: Anthropic
  date: 2026-08-10
source: https://www.anthropic.com/research/riemann-zeta
discussions:
  - https://news.ycombinator.com/item?id=49247070  # 2026-08-10
  - https://www.reddit.com/r/math/comments/1vkt6av/anthropic_asked_an_unreleased_version_of_claude/  # 2026-08-10
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "A failed attack on the Riemann hypothesis produced a narrower bound by composing earlier mathematics at massive agentic-search scale, with human review and Lean checking supplying evidence but not an independent statement-fidelity audit."
---

# Learning more about Claude's mathematical capabilities

Anthropic's announcement of a mathematical result produced by an
unreleased research version of Claude. It is a capability report and workflow
account, not the technical paper: the linked paper, informal expert note, Lean
formalization, discovery narrative, and detailed transcripts carry the
mathematics and primary evidence. The post's central claim is narrower than its
Riemann-hypothesis framing. Claude did not solve that conjecture; while trying,
it found an argument raising a lower bound for the proportion of zeta zeros on
the critical line from 41.6% to 67.2%.

## The mathematical move

The result combines work by Baluyot, Goldston, Suriajaya, and
Turnage-Butterbaugh, which made Montgomery-style techniques available without
assuming the Riemann hypothesis, with a quadratic-form argument from Bombieri.
Anthropic's short technical synopsis says Claude put the relevant functions in
a space carrying Weil's quadratic form, treated the subspaces arising from
zeros on and off the line together, and applied first- and second-moment
information to bound the form's rank. The claimed novelty is not a new theory
of zeta zeros but the decision to retain positive and negative definiteness in
one non-diagonal quadratic form, making the earlier ingredients yield the
stronger constant.

This is precisely the kind of claim for which rediscovery matters. Claude's
own process downloaded and searched 54 arXiv papers, and several subagents
reviewed, attacked, and independently re-derived the argument. That is useful
internal evidence, not an independent literature review. The post credits
Anthropic mathematicians Levent Alpöge and Ralph Furman with studying and
validating the work and producing the concise informal note; Brian Conrey and
Dan Goldston examined the paper on short notice. It does not claim that the
result has passed conventional peer review.

## Discovery as a search system

The path is more informative than the successful endpoint. Across two Claude
Code sessions, the model emitted 31 million output tokens. An initial pass
generated 650 ideas and found none that worked. A second, day-and-a-half pass
coordinated about 60 subagents, ran 2,400 shell commands, wrote hundreds of
Python scripts, and performed thousands of numerical checks against known zeta
zeros. The footnote accounts for the division of labor: two agents developed
the key ideas, thirteen fed them candidate ideas, thirty unsuccessful agents
explored alternatives, thirteen validated arguments, and two helped draft the
paper. Jarred Sumner, the non-mathematician who initiated the run, reports that
his intervention after the initial prompt was mostly encouragement.

The successful result was therefore an unintended byproduct of a failed,
open-ended target, not the output of a fixed evaluator optimizing a known
quantity. Against [[jiang2026-solvers]], this is stronger evidence for a
research-agent workflow than another saturated-benchmark score, while still
matching that survey's caution: the model composed an extensive human
literature into an insight-plus-short-argument result, exactly the regime in
which its field map says current systems work best. Nothing in the post shows
the model inventing a new concept or reorganizing the subject.

## Evidence and trust

Eric Easley worked with Claude to formalize the result in Lean, and Anthropic
says the released formalization passes Lean's comparator. That provides a
checker-backed proof object rather than asking readers to accept a corporate
claim. It still leaves the two trust layers already visible in this library:
[[demoura2026-kernel-soundness]] concerns whether the checker is sound, while
[[jiang2026-solvers]] concerns whether the checked statement faithfully
captures the mathematical claim. The post links the artifacts but does not
report an independent audit of that correspondence.

Read beside [[openai2026-math-advances]], the evidentiary stack is similar --
model-generated argument, human-prepared exposition, Lean formalization -- but
the discovery shapes differ. OpenAI reported ten targeted solutions and
foregrounded their certificates; Anthropic foregrounds a long, mostly failed
search whose useful result was adjacent to the prompt. The latter supplies a
more concrete account of orchestration cost and negative search, but it still
comes from the organization whose unreleased model is being showcased.

## Assessment

- **Durable:** the failed-target-to-adjacent-result pattern; the disclosed
  division of labor across proposing, developing, checking, and writing; and
  the layered evidence of adversarial model review, human mathematical review,
  and formal verification.
- **Era-bound:** the unnamed research model, token and command counts, and the
  rhetorical emphasis on encouragement as a capability unlock.
- **Caveats:** the post is a primary-source capability claim with strong linked
  artifacts but no conventional peer review; its rediscovery check was run by
  the same system; and a passing formalization does not by itself establish
  statement fidelity. The result should be read as a substantive new bound if
  the linked mathematical and formal artifacts survive independent scrutiny,
  not as progress toward a proof of the Riemann hypothesis itself.
