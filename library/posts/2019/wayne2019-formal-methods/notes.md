---
citekey: wayne2019-formal-methods
work:
  title: Why Don't People Use Formal Methods?
  author: Hillel Wayne
  date: 2019-01-21
source: https://www.hillelwayne.com/post/why-dont-people-use-formal-methods/
discussions:
  - https://news.ycombinator.com/item?id=18965274  # 2019-01-22
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "Formal-methods adoption is not one cost curve: full code verification faces proof and specification costs, while design verification is technically lighter but socially detached from executable code and ordinary development workflows."
---

# Why Don't People Use Formal Methods?

Wayne replaces the stock answer—formal methods are too expensive except for
airplanes—with two different adoption stories. He separates code specification
and verification from design specification and verification, then argues that
full code proof remains economically specialized while model-checked design
specification is often affordable but culturally hard to value. The taxonomy
is explicitly local to the essay, but it prevents "formal methods" from hiding
several distinct activities behind one adoption rate.

## Code verification pays for the last fraction

Before proving code correct, one must express correctness. Wayne groups code
specifications as external theorems, embedded preconditions and invariants, or
types. The first difficulty is validation: a proof only connects an
implementation to its formal statement, not that statement to the user's
actual need. The deeper difficulty is specification itself. Human concepts are
often easier to demonstrate with examples than to turn into exhaustive
mathematics.

Proof then adds its own stack of expertise: mathematics, software, the domain,
the program, and the prover. Expressive language features such as mutation,
aliasing, concurrency, overflow, or higher-order functions complicate the
logic, while restricting the language makes ordinary implementation harder.
SMT solvers moved useful classes of obligations from creative proof search
toward automated constraint solving, but they did not erase that tradeoff.

The economic conclusion is appropriately incremental. Full verification can
be essential, but tests, types, contracts, fuzzing, and partial proofs often
buy most of the reliability at much lower cost. The Hacker News discussion
strongly supports this domain-sensitive reading: practitioners report value
for immutable smart contracts, protocols, distributed designs, and ASICs,
while others locate the bottleneck in changing requirements, tool friction,
third-party systems, or the unverified environment. The thread is evidence of
heterogeneous use conditions, not a quantitative adoption study.

## Design verification has a different bottleneck

At the design level, implementation detail can be abstracted away so that
component interactions, failure cases, and temporal behavior become explicit.
Model checking replaces a handwritten correctness proof with exploration of a
state space and returns a counterexample when a property fails. That lowers
the proof-skill barrier but introduces state explosion, unbounded models, and
the need to decide what the abstraction includes.

Wayne's strongest observation is social: a design model is neither executable
product code nor automatically synchronized with it. Developers already
neglect documentation and diagrams for the same reason. The act of formalizing
a design can expose ambiguity before model checking begins, but that benefit
is difficult to demonstrate to someone who has never performed it. The design
artifact's weak coupling to implementation therefore matters as much as solver
performance.

This places the post beside [[baldoni2016-symbolic]] without making the terms
synonymous. Symbolic execution is one family inside the broader formal-methods
landscape; theorem proving, model checking, types, contracts, and disciplined
testing offer different objects and guarantees. [[verbeure2019-under-hood]]
and [[gisselquist2024-verification]] show the same distinction in digital
hardware, where formal engines are combined with assertions, cover goals,
simulation, mutation, and coverage rather than replacing them all.

- **Durable:** split adoption questions by artifact and guarantee; distinguish
  validation of the specification from verification against it; and compare
  full proof with partial, cheaper correctness mechanisms.
- **Era-bound:** tool capabilities, ecosystem usability, production examples,
  and historical chronology as presented in 2019.
- **Caveats:** this is an informed historical and economic essay, not a
  systematic survey. Several productivity and defect figures are secondary
  claims, and the author flags both his lack of historian training and greater
  expertise on design specification.
- **Commercial stake:** Wayne disclosed that he ran TLA+ and Alloy workshops
  and promoted his book and consulting. His conclusion favoring design
  specification is therefore both a reasoned argument and aligned with his
  work.

The practical lesson is not "use formal methods" or "do not." Name the layer,
property, failure cost, environment model, and maintenance coupling first;
only then does an adoption question have a coherent denominator.
