# wong2018variational — Faster Variational Execution with Transparent Bytecode Transformation

- **Status:** deep-read
- **Primary source:** https://www.cs.cmu.edu/~ckaestne/pdf/oopsla18.pdf
- **Version read:** author-hosted OOPSLA 2018 paper; proofs checked in https://arxiv.org/pdf/1809.04193
- **Bibliography key:** `wong2018variational`

## Why it matters

Variational execution is the closest operational precedent for associating
executed regions with propositional contexts while sharing equal values and
rejoined control flow across many configurations.

## Program and semantic model

The input is a finite Boolean configuration space. A conditional value
partitions configurations into propositional contexts carrying concrete
values, grouping configurations that currently have the same value. A
variational trace is a chronological sequence of variational basic blocks
paired with their execution contexts. Projection to one configuration yields
its concrete block trace (Sections 2.1 and 4.3, pp. 117:5–7 and 117:15–16).

## Algorithm and sharing

The bytecode transformation represents variability in locals, fields, stack
values, arguments, and returns. Incoming mutually exclusive contexts are
disjoined at control-flow joins, permitting one shared execution of a common
block. State alternatives with identical concrete values are merged (Sections
4.1–4.2, pp. 117:11–14).

## Results and guarantees

- The Disjoint Context Lemma says pending contexts of distinct blocks remain
  mutually exclusive (p. 117:15; extended-version Appendix A).
- The Correct Execution Property makes the schedule of simultaneously enabled
  blocks immaterial because they update disjoint contextual states.
- Definition 4.1 defines optimal trace sharing through multiple-trace
  alignment; the Optimal Sharing Property covers acyclic CFGs and CFGs with
  the paper's restricted simple loops (pp. 117:15–16).

The configuration space is finite and known. Native or environmental effects
require models, safe repetition, or aborting; reflection and synchronization
have additional limitations (Section 5.3).

## Complexity

There is no output-polynomial execution bound. The configuration space and
worst-case execution remain exponential. Optimal multiple-trace alignment is
NP-hard, so the evaluation uses a conservative pairwise approximation
(Section 6, p. 117:23).

## Motivating example

The WordPress-like renderer has three options and eight configurations. It
splits only where options affect control and rejoins before a common footer
(Figure 1 and Section 2.1).

## Relationship to our hypothesis

An instrumented selector can expose activity and outcome contexts, and an
unvisited nested selector is naturally absent from a projected execution.
However, individual event contexts overlap over time; they are not a disjoint
partition by complete sparse observation. Equal-valued arms are merged unless
their site outcomes are instrumented before value normalization. The paper
does not enumerate observation fibers, guards paired with residual outputs, or
context-qualified selection identities.

## Evidence locations

- Sections 2.1 and 4.1–4.3, pp. 117:5–16: representation and execution.
- Extended-version Appendix A, pp. 30–34: disjointness and sharing proofs.
- Sections 5.3 and 6, pp. 117:19–23: limitations and complexity.
