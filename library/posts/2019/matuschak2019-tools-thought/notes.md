---
citekey: matuschak2019-tools-thought
work:
  title: How can we develop transformative tools for thought?
  author: Andy Matuschak and Michael Nielsen
  date: 2019-10
source: https://numinous.productions/ttft/  # snapshot + figures (2 PNGs, 1 SVG) → shadow
discussions:
  - https://news.ycombinator.com/item?id=21152542  # 2019-10-03
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "Transformative tools for thought require an insight-through-making research culture: the tool must generate new understanding of its subject while that understanding recursively changes the medium, under incentives that ordinary product development rarely supplies."
---

# How can we develop transformative tools for thought?

Matuschak and Nielsen ask why computers have produced many useful interfaces
but few media comparable in cognitive consequence to language, writing, or
positional numerals. Their answer is not a feature wishlist. They argue that
transformative media emerge from a research practice in which building a tool
produces original insight into thought, memory, or a target domain, and those
insights in turn reshape the tool. The long essay demonstrates that practice
through *Quantum Country*, then asks what institutions could sustain it.

## The mnemonic medium is a worked prototype

Quantum Country interleaves a technical essay about quantum computing with
retrieval questions. Answers are scheduled for later review, making memory
practice part of the medium rather than a separate deck the reader must author
and maintain. The design claim is broader than "spaced repetition works":
placing carefully written prompts in their explanatory context can make
long-term recall a normal consequence of reading while preserving links to the
ideas that give each answer meaning.

The authors report early usage data. Their *demonstrated retention* metric is
the longest successful interval for each card, summed across 112 questions.
Users reaching six repetitions clustered around roughly 6,000 aggregate days,
or about 54 days per question, after an estimated 95 minutes of review. A small
two-week intervention also compared eight cards with delayed versus ordinary
review. These are useful prototype signals, not an efficacy trial: users
self-selected, the metric measures successful review intervals rather than
transfer or conceptual understanding, sample sizes were small, and overlapping
cards weaken the comparison. The page commendably labels the evidence
preliminary and retains a separate retraction where an analysis error invalidated
one claim.

The Hacker News discussion supplies the missing adversarial reading. Several
experienced spaced-repetition users question whether contextual embedding
improves a fast, mature Anki workflow, while others argue that recall is being
mistaken for understanding. The strongest replies do not negate the prototype;
they narrow the claim from a general solution to learning toward one designed
medium whose transfer and long-term use still need measurement.

## Insight through making is the real method

The essay's central analogy is the Hindu-Arabic numeral system. Positional
notation was simultaneously a mathematical insight and an interface design:
the same digits acquire different values by position while preserving
composable operations. A designer who merely interviewed mathematicians could
improve Roman numerals without necessarily discovering that representation.
Transformative tools must embody comparable subject-matter insight.

This motivates the *insight-through-making* loop. Researchers who regard
implementation as trivial miss what prototypes can reveal; product builders
who regard research as slow product development lack the depth to discover new
cognitive principles. The needed team and culture must operate both sides of
the loop. That is a stronger and more falsifiable proposal than nostalgia for
Engelbart, Kay, or a supposed golden age: a project should be able to say what
new understanding its artifacts produced and how that understanding changed
the next artifact.

## The constraint is institutional as well as technical

The authors argue that many interface ideas are public goods: expensive to
discover, cheap for competitors to copy, and more socially valuable when
widely shared. Distribution, lock-in, brand, or network effects can dominate a
software company's advantage, so deep tool research may be commercially
irrational even when beneficial. They contrast games, whose early sales can
reward novel mechanics before copying catches up, with long-lived tools whose
users need stable mastery. Their tentative answers are philanthropic research
funding or businesses whose moat lies around, rather than inside, the cognitive
innovation.

This institutional argument joins [[olah2017-research-debt]]: both locate a
socially valuable form of interpretive or interface work that current
publication and product incentives underfund. It also sharpens
[[luhmann1981-slip-boxes]] and [[karpathy2026-llm-wiki]]. A maintained note
network is not only storage; its representations and operations determine
which relations a user can notice and which thoughts become cheap enough to
have.

- **Durable:** the mnemonic medium as an integration pattern; the distinction
  between memory support and complete learning; insight-through-making as a
  joint research/design method; and the public-goods account of underinvestment.
- **Era-bound:** Quantum Country's 2019 user data, interface, review schedule,
  and the contemporary examples of product practice and funding.
- **Evidence boundary:** the essay combines a prototype report, informal
  experiments, testimonials, historical analogy, and institutional argument.
  None establishes the headline word *transformative*, and no conventional
  learning baseline measures transfer, comprehension, or attrition.
- **Stake:** the authors built and advocated the mnemonic medium. They are
  unusually candid about its deficiencies and preliminary evidence, but case
  selection and interpretation still come from its creators.

The piece is most useful as a research-program document. Its bar is not
whether a tool makes an existing task faster; it is whether the coupled work
of understanding and making creates a medium in which previously inaccessible
thought becomes ordinary.
