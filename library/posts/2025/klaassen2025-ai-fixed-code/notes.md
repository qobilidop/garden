---
citekey: klaassen2025-ai-fixed-code
work:
  title: My AI Had Already Fixed the Code Before I Saw It
  author: Kieran Klaassen
  date: 2025-08-18  # page marks an update on 2026-04-23; capture reflects the updated version
source: https://every.to/source-code/my-ai-had-already-fixed-the-code-before-i-saw-it  # snapshot → shadow
  # the source is paywalled past the free preview; the captured record and
  # these notes are scoped to that preview
discussions:
  - https://news.ycombinator.com/item?id=44941899  # 2025-08-18
  - https://lethain.com/everyinc-compound-engineering/  # 2026-01-19
retrieved: 2026-08-07
notes-by: Claude Fable 5
notes-date: 2026-08-07
synthesis: "Named the philosophy: each unit of engineering should make the next cheaper, and agents close the feedback loop cheaply enough for the compounding to actually happen."
---

# My AI Had Already Fixed the Code Before I Saw It

The essay that coined **compounding engineering** (Kieran Klaassen,
general manager of Cora, Every's email assistant; Source Code column).
Definition, verbatim thesis: build self-improving development systems
where each iteration makes the next faster, safer, better — "every pull
request teaches the system, every bug becomes a permanent lesson, and
every code review updates the defaults," against the default mode where
"you prompt, it codes, you ship. Then you start over." The framing
device is the title anecdote: Claude Code reviewing new work by citing
lessons from three months of past PR feedback, unprompted. The essay's
sharpest move is inverting the unit of work: after three months of this
practice a bug fix "feels half-done if it doesn't prevent its entire
category going forward," and a code review without extractable lessons
is wasted time. The slogan form: create systems that create systems,
then get out of the way.

## The worked example (the part in the record)

Building a "frustration detector" for Cora as TDD where the
implementation is a prompt: hand Claude a real frustrated conversation
→ have it write a failing test → write the detection prompt → let
Claude iterate the prompt against the test, reading its own failure
logs. Because LLM outputs are stochastic, the test runs ten times;
at 4/10 detections Claude analyzes the chains of thought from the six
misses, finds it is missing hedged politeness ("Hmm, not quite" +
repetition), patches the prompt for that pattern, reaches 9/10 — ship.
The whole workflow is then codified in CLAUDE.md, so the next
emotion/behavior detector starts from "use the prompt workflow from the
frustration detector" instead of from scratch. Two durable ideas in
one example: prompts are endlessly refinable implementations because
tests make their failures legible, and the codified *workflow* — not
the artifact — is what compounds.

## Record limitation

Every paywalls the essay past its first section; the snapshot (and the
Wayback record) hold the free preview — definition, thesis, and the
frustration-detector example. The gated remainder contains a five-step
playbook (its existence is corroborated by reader comments visible in
the Wayback record and by Will Larson's post, which describes the loop
as plan → work → review → compound); the step names circulating in
secondary sources are not in this record and are not asserted here.
Upgrade path if a subscription is available: re-capture through the
user's browser session.

## Assessment

The essay's contribution is the name and the frame, not novel
machinery — a reader comment preserved in the Wayback record makes the
standing critique ("a list of well-known good engineering practices;
machines speed up the feedback cycle"), and it is fair as far as it
goes: what is new is that an agent closes the loop cheaply enough for
the compounding to actually happen.

- **Reception (delayed):** the HN thread was modest (17 points), but
  by January 2026 Will Larson was endorsing the practice as "an
  extremely effective way to convert intuited best-practices into
  something specific, concrete, and largely automatic," and Every
  shipped an open-source compounding-engineering plugin for Claude
  Code.
- **Unverifiable as-told:** the opening anecdote.
- **Era-bound:** the Cora and Claude Code specifics.
- **In this library:** [[vincent2025-superpowers]] is the twin from the
  same season — Klaassen names the philosophy, Vincent ships the
  machinery — and both independently converge on
  lessons-earned-from-real-work as the input to harness growth, which
  [[liu2026-agent-taxonomy]] would file as harness
  self-improvement whose loop closes in code review. For the evolve
  skill, this is the philosophy citation: rules route from failures
  ("every bug becomes a permanent lesson") and the locus that
  compounds is the codified workflow.
