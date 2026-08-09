---
citekey: bernardinello2016revealsexcludes
work:
  title: "Non-Interference Notions Based on Reveals and Excludes Relations for Petri Nets"
  author: "Luca Bernardinello, Görkem Kılınç, Lucia Pomello"
  venue: "ToPNoC XI"
  date: 2016
  doi: 10.1007/978-3-662-53401-4_3
read: full-text
source: "Open PNSE 2015 preliminary full text: https://ceur-ws.org/Vol-1372/paper4.pdf (cross-checked against the canonical 2016 ToPNoC XI record at https://doi.org/10.1007/978-3-662-53401-4_3 and https://boa.unimib.it/handle/10281/146399)"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Reveals/excludes relations formalize occurrence-count and negative (non-occurrence) information flow between Petri-net transitions in maximal runs — a semantic predecessor to later finite-prefix reveals algorithms, over transition occurrence rather than an enumerated observer image"
---

# Non-Interference Notions Based on Reveals and Excludes Relations for Petri Nets

## Evidence

### Evidence locations

- Section 2 (preliminary pp. 60--62) fixes finite ordinary Petri nets with
  nonempty transition presets; behavior may be infinite and is represented by
  the maximal branching process or unfolding. Section 3 (p. 63) adds a
  progress assumption, so the relations quantify over maximal unfolding runs.
- Section 3, Definitions 4--6 (pp. 63--64), lifts information-flow relations
  from occurrence-net events to net transitions. `t1` excludes `t2` when no
  maximal run containing `t1` contains `t2`; `t1` reveals `t2` when every such
  run contains `t2`; extended reveals allows a set of observed transitions to
  imply that some member of another set occurs.
- Definition 7 (p. 65) introduces `n`-repeated reveals. It restricts to runs
  containing exactly `n` occurrences of the observed transition, takes the
  inclusion-maximal such runs, and asks whether each contains the revealed
  transition. The relation is undefined when no such run exists. Propositions
  1--2 (pp. 65--66) relate the one-occurrence and increasing-count cases.
- Sections 4.1--4.4, Definitions 8--11 (pp. 69--73), partition transitions
  into nonempty low and high sets and define RNI, `k`-ERNI, `n`-ReRNI, and
  PNNI. In particular, `n`-ReRNI assumes a low observer can count repeated
  occurrences, while PNNI combines reveals with excludes to capture positive
  and negative information.
- Section 5 (p. 75) states that these new notions apply to general Petri nets,
  unlike the recalled older notions restricted there to 1-safe nets. The
  distinctions concern inference about both past and inevitable future
  occurrence or nonoccurrence.
- The conclusion (pp. 76--77) proposes a future multiset-parametric reveals
  relation and says algorithms, including finite-prefix checking, are only
  beginning to be explored. The paper gives definitions and comparison
  propositions, not a decision algorithm or complexity bound.

## Bearing on RQs

The 2016 ToPNoC chapter is canonical; the identically titled open PNSE 2015
paper is its preliminary primary version and receives no separate key. This is
a semantic predecessor of Adobbati et al.'s later finite-prefix algorithms but
remains distinct: it introduces occurrence-count observation and negative
excludes/non-interference, whereas the 2022 free-choice footprint construction
forgets multiplicity and the 2024 bounded equal-conflict work supplies later
exact parametric-reveals algorithms.

## Evidence limits

Its observer ranges over transition occurrence or nonoccurrence in maximal
Petri-net runs. It neither enumerates the observer image nor constructs
caller-input inverse fibers, guards, or typed residual program values.
