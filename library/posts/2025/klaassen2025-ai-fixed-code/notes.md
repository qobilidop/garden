---
citekey: klaassen2025-ai-fixed-code
work:
  title: My AI Had Already Fixed the Code Before I Saw It
  author: Kieran Klaassen
  date: 2025-08-18  # page marks an update on 2026-04-23; capture reflects the updated version
source: https://every.to/source-code/my-ai-had-already-fixed-the-code-before-i-saw-it
  # paywalled past the free preview at the first capture (2026-08-07); the
  # 2026-09-07 browser capture holds the full essay (newsletter edition,
  # one sponsor block), and these notes cover all of it
discussions:
  - https://news.ycombinator.com/item?id=44941899  # 2025-08-18
  - https://lethain.com/everyinc-compound-engineering/  # 2026-01-19
retrieved: 2026-09-07
notes-by: "Claude Fable 5; Claude Fable 5.1"
notes-date: 2026-09-07
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

## The worked example

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

## Five uses at Cora

The essay lists what the practice has been applied to, each a loop
that turns an event into a durable artifact: production errors → agents
that investigate the crash, reproduce it from logs, and ship the fix
*with* the tests that keep the category closed ("every failure a
one-time event"); recorded design sessions → documented rationale that
new teammates inherit; reviewer agents with distinct expertise — a
"Kieran reviewer" that enforces the author's taste, a Rails-expert
reviewer, a performance reviewer; an agent that detects interface
changes and produces before/after screenshots across sizes and themes
(a 30-minute manual task removed); and one agent per piece of reviewer
feedback, resolving ten concerns in the time one used to take. The
reviewer file in the essay's own screenshot (capture `#fig-14`)
is a persona agent under `.claude/agents/`, not a CLAUDE.md fragment:
numbered principles such as "existing code modifications — be very
strict" against "new code — be pragmatic," a framework-specific
convention with a FAIL/PASS pair, and "hard-to-test code = poor
structure that needs refactoring."

## The five-step playbook

1. **Teach through work.** Capture every decision as it is made:
   CLAUDE.md holds taste in plain language (guard clauses over nested
   ifs, naming), an llms.txt holds the architectural principles that
   survive restructuring. "Keep it short, keep it alive."
2. **Turn failures into upgrades.** Where most engineers fix and move
   on, add the test, update the rule, and write the evaluation. The
   example is a missed daily Brief: tests for delivery lapses,
   monitoring rules, and a continuous evaluation of the pipeline.
3. **Orchestrate in parallel.** Three lanes on one monitor
   (`#fig-15`): a planning agent that reads issues and writes
   implementation plans, a delegating agent that turns plans into code
   and tests, a reviewing agent that checks output against CLAUDE.md —
   in the screenshot three different products, Claude Code, Friday,
   and Amp. Scaling is bounded by orchestration skill and compute, not
   headcount.
4. **Keep context lean but yours.** Do not copy "ultimate CLAUDE.md"
   files; ten specific rules beat a hundred generic ones, and rules
   that stop serving get deleted — "living context means pruning as
   much as growing." The test offered: the files should read like the
   author's own software philosophy.
5. **Trust the process, verify output.** Resist reviewing every line;
   verify through tests, evals, and spot checks, and when something
   comes back wrong, teach the system why.

The closing exhortation is concrete: start one experiment log, fix
the next avoidable failure at the category level, open three
terminals.

## Assessment

The essay's contribution is the name and the frame, not novel
machinery — a reader comment preserved in the Wayback record makes the
standing critique ("a list of well-known good engineering practices;
machines speed up the feedback cycle"), and it is fair as far as it
goes: what is new is that an agent closes the loop cheaply enough for
the compounding to actually happen. Read in full, the playbook is more
disciplined than the slogan suggests: two of its five steps are about
restraint (prune context, do not micromanage), and the reviewer
screenshot shows taste encoded as checkable rules with pass/fail
examples rather than as prose exhortation.

- **Numbers, self-reported and without denominators:** time-to-ship
  "from over a week to 1–3 days," review cycles "from days to hours,"
  bugs caught before production "increased substantially," the
  four-of-ten to nine-of-ten detector run, and "$400 per month for
  what used to cost $400,000 per year." None is measured against a
  control; treat them as the author's experience on one product.

- **Reception (delayed):** the HN thread was modest (17 points), but
  by January 2026 Will Larson was endorsing the practice as "an
  extremely effective way to convert intuited best-practices into
  something specific, concrete, and largely automatic," and Every
  shipped an open-source compounding-engineering plugin for Claude
  Code.
- **Unverifiable as-told:** the opening anecdote.
- **Era-bound:** the Cora specifics and the named tools (Claude Code,
  Friday, Amp, Warp); the llms.txt convention for architecture rules
  is one team's choice, not an established standard.
- **Provenance:** the first capture was the free preview; the full
  essay entered the record on 2026-09-07. Will Larson's later
  restatement of the loop as plan → work → review → compound is his
  own compression, not the essay's step names.
- **In this library:** [[vincent2025-superpowers]] is the twin from the
  same season — Klaassen names the philosophy, Vincent ships the
  machinery — and both independently converge on
  lessons-earned-from-real-work as the input to harness growth, which
  [[liu2026-agent-taxonomy]] would file as harness
  self-improvement whose loop closes in code review. For the evolve
  skill, this is the philosophy citation: rules route from failures
  ("every bug becomes a permanent lesson"), the locus that compounds
  is the codified workflow, and step 4 is the subtraction principle
  stated by a practitioner — prune rules that stop serving, prefer ten
  specific rules to a hundred generic ones.
