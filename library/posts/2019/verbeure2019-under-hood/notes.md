---
citekey: verbeure2019-under-hood
work:
  title: Under the hood of Formal Verification
  author: Tom Verbeure
  date: 2019-01-04
source: https://tomverbeure.github.io/rtl/2019/01/04/Under-the-Hood-of-Formal-Verification.html  # snapshot + figures (2 PNGs, 1 SVG) → shadow
discussions:
  - https://news.ycombinator.com/item?id=18849617  # 2019-01-07; submission has no comments
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "Open-source RTL formal verification turns assertions and cover goals into solver problems, while richer temporal assertions compile through automata whose determinization makes the hidden state-space cost concrete."
---

# Under the hood of Formal Verification

Verbeure develops an RTL designer's intuition for open-source formal
verification by moving from a generated witness trace to the machinery that
implements temporal assertions. The article is valuable because its two
halves expose both sides of the abstraction: a user can state a compact goal
and let a solver synthesize the stimulus, but the frontend must compile that
goal into state whose growth eventually reappears as a tractability limit.

## A cover goal is an implicit test generator

The starting example is an APB-to-ULPI controller. A three-term `cover`
statement asks for a post-reset execution in which a transmit FIFO has reached
depth ten and is later empty. SymbiYosys produces a roughly 25-cycle waveform
containing the necessary bus transactions without an authored APB master,
loop, start write, or polling sequence.

The trace also violates the author's unstated intent: the solver issues the
start command amid the data writes. That is the example's main lesson. A
formal engine satisfies the encoded harness, not the scenario in the
designer's head. The surprising witness is useful precisely because it
reveals the missing constraint. This is the hardware version of the coverage
contract in [[baldoni2016-symbolic]] and [[yang2026-forbench]]: exhaustiveness
or reachability is always relative to assumptions, observations, and a bound.

The post's introductory "100% certainty" language is therefore too broad when
detached from those conditions. A proof can be conclusive for the RTL model,
property, assumptions, solver semantics, and explored depth; it does not by
itself validate the property or cover analog behavior, tool defects, and an
inaccurate environment model.

## Temporal syntax becomes an automaton

The 2019 open-source flow supported Boolean assertions and limited temporal
operators, while commercial SystemVerilog Assertion frontends supported
richer sequences. Verbeure reconstructs how a sequence such as an `a`
followed by one or two `b` events and then `c` can be represented as a finite
state machine. Overlapping matches create multiple active states, yielding a
nondeterministic automaton. Subset construction produces a deterministic
machine suitable for synthesized logic or the solver-facing RTL
representation.

Parallel sequence evaluation makes the cost visible. The worked machine grows
from five nondeterministic states to sixteen deterministic states, with a
worst-case `2^n` conversion. This is not the same path tree as program symbolic
execution, but it expresses the same conservation law: compact source syntax
can defer alternatives into automaton or formula structure, not abolish them.

The investigation ends by finding that Yosys's Verific frontend already
implemented the practical pipeline: parse SystemVerilog temporal properties,
construct a nondeterministic machine with clocked edges and combinational
links, normalize it, determinize it, and connect the resulting match signal to
RTLIL assertion, assumption, or cover cells. The reader learns the mechanism
by independently rediscovering its architecture before inspecting the real
implementation.

- **Durable:** cover statements as solver-driven directed tests; unexpected
  witnesses as assumption discovery; temporal assertions as automata; and
  determinization as one source of state growth.
- **Era-bound:** the 2019 SymbiYosys/Yosys feature boundary, availability of
  the proprietary Verific parser, linked source revisions, and SpinalHDL
  integration details.
- **Evidence boundary:** this is one worked design and source-reading exercise,
  not a comparison of proof engines or a performance evaluation. Its Hacker
  News submission has no comments, so it supplies no external adjudication.
- **Stake:** the author is documenting his own controller and open-source flow;
  there is no disclosed commercial product claim, but the piece naturally
  emphasizes the tools and limitations encountered in that project.

The result is a useful boundary object for "symbolic execution of hardware."
The user experience is symbolic stimulus and solver-produced traces; the
implementation can instead be described as property compilation plus bounded
or inductive formal checking. A survey should preserve both descriptions and
state which level it is classifying.
