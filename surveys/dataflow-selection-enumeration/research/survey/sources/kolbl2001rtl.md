# kolbl2001rtl — Symbolic RTL Simulation

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1145/378239.378278
- **Version read:** ACM proceedings PDF
- **Bibliography key:** kolbl2001rtl

## Why it matters

The work combines symbolic branch controls, ITE value merging, event-driven
path accumulation, and replay of context-dependent symbolic-variable
occurrences. It is an early hardware precedent for guarded values and dynamic
occurrence identity.

## Program and semantic model

The simulator executes full RT-level Verilog, including nonsynthesizable
testbenches, delays, asynchronous events, and zero-delay loops. Every
$random execution creates a fresh symbolic variable. Boolean data and control
expressions are represented by BDDs.

## Main definitions

Execution carries a Boolean control condition. A conditional evaluates the then
arm under \(\mathit{control}\land c\) and the else arm under
\(\mathit{control}\land\neg c\). Assignment under a control uses
\(\operatorname{ite}(\mathit{control},\mathit{new},\mathit{old})\).

Event accumulation merges scheduled executions at the same statement and
simulation time by disjoining their controls. Priority accumulation events
handle branch rejoins, partial rejoins, differing statements, and loops.

## Results and guarantees

The scheme symbolically simulates many input traces and can recover a concrete
error replay. The paper states that event accumulation reduces average
complexity, while worst-case complexity remains exponential. It gives no
numbered correctness theorem.

## Algorithm

Branch conditions split the control expression; controlled ITE assignments
merge data. Event-queue entries with compatible program labels and times are
accumulated. Each dynamic $random call appends its fresh variable and control
formula to a list for that statement. To replay an error model, false-control
entries are deleted and active entries provide concrete values in list order.

## Complexity

Path accumulation reduces repeated execution empirically but does not remove
the exponential worst case. Contexts with different iteration counts can merge,
which is why source label and simulation time alone cannot identify dynamic
$random occurrences.

## Terminology

Established terms include *symbolic RTL simulation*, *control expression*,
*event accumulation*, *ITE assignment*, and *error trace*.

## Motivating example

A symbolic value controls a conditional whose arms assign different values.
The example shows disjoint controls, ITE updates, later event merging, and
recovery of which loop executions introduced the symbolic values used in one
error trace.

## Relationship to our hypothesis

### What is directly established by the work?

Branch alternatives are represented by disjoint controls, data values merge by
ITE, asynchronous paths can rejoin, and dynamic symbolic introductions can be
filtered for one concrete replay using their controls.

### What is our interpretation or inference?

Before accumulation, a path can retain branch outcomes even when values agree.
After accumulation and BDD simplification, branch provenance is deliberately
lost. The contextual $random list shows that source identity alone is
insufficient when dynamic occurrences merge.

### Could it subsume our proposed contribution?

It subsumes generic symbolic RTL path splitting, value merging, and concrete
replay. It does not expose an exhaustive graph-relative selector observation,
exact fibers, or residuals per observation. Instrumenting every branch as a
nonmergeable event would change its native abstraction.

## Evidence locations

- Section 3.2, pp. 48–49: branch controls and ITE assignments.
- Section 4, pp. 49–51: event accumulation and exponential worst case.
- Section 5, pp. 51–52: contextual $random occurrence lists and replay.

## Questions and possible weaknesses

- Which transformation invariants would be required if branch provenance were
  made nonmergeable?
- The full Verilog setting is much broader than finite total pure graphs, so
  comparison must not transfer its complexity claims without assumptions.
