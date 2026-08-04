# narayan1996partitioned — Partitioned ROBDDs

- **Status:** deep-read
- **Primary source:** https://doi.org/10.1109/ICCAD.1996.569909
- **Version read:** proceedings PDF hosted by UC Irvine
- **Bibliography key:** `narayan1996partitioned`

## Why it matters

This work gives a formal, canonical representation of Boolean functions over
covered input windows and proves exponential compactness separations. It rules
out broad novelty claims about partitioned symbolic Boolean functions.

## Program and semantic model

The object is a Boolean function `f` over `n` inputs. Each window and restricted
function is represented by an ROBDD with a chosen variable order.

## Main definitions

Definition 1 represents `f` by pairs `(w_i, f_i)`. Window functions cover the
whole Boolean space, and each `f_i` equals `w_i and f`. Windows need not be
disjoint; when they are pairwise disjoint the representation is called
*orthogonally partitioned*.

## Results and guarantees

For fixed windows and per-window variable orders, the representation is
canonical. The paper exhibits functions whose partitioned ROBDDs are
polynomial while monolithic ROBDDs or even FBDDs are exponential. Boolean
operations can be performed per partition with polynomial aggregate time and
only one partition resident in memory.

## Algorithm

The paper derives Boolean manipulation operations and several heuristic methods
for selecting window functions, including decomposition- and explosion-based
partitioning.

## Complexity

The Hidden Weighted Bit example has an exponential monolithic ROBDD but `O(n)`
windows, each with `O(n^2)` size, for `O(n^3)` total and `O(n^2)` peak space.
The paper also gives operation costs in terms of aggregate and maximum
partition sizes.

## Terminology

*Window function*, *orthogonal partition*, *disjunctive partition*,
*partitioned ROBDD*, and *canonical for fixed windows and orderings* are
important precedents.

## Motivating example

A mux tree selecting an input according to its Hamming weight supplies a
natural control-space partition and an exponential representation separation.

## Relationship to our hypothesis

### What is directly established by the work?

Covered and optionally disjoint input regions paired with exact symbolic
Boolean functions, plus canonicity and exponential compactness results.

### What is our interpretation or inference?

Our selectors induce windows rather than accepting arbitrary chosen windows.
The relevant question is whether the induced windows admit a stronger
output-sensitive construction or minimality property.

### Could it subsume our proposed contribution?

It subsumes partitioned-function representation and generic compactness claims.
It does not define a sparse map of active site outcomes or its fibers.

## Evidence locations

- Section 3, Definition 1: covered window representation and orthogonality.
- Section 3.1, Theorem 3.1: canonicity.
- Sections 3.2.1–3.2.2: exponential compactness separations.
- Section 3.3: manipulation complexity.
- Section 5: automatic partition construction.

## Questions and possible weaknesses

- Is our perfect mux-tree separation simply the Hidden Weighted Bit argument in
  a different parameterization?
- “Canonical” must always be qualified by fixed graph/site identity, just as
  this work qualifies it by fixed windows and variable orders.
