---
citekey: shin2024multitask
work:
  title: "Multiparametric Analysis of Multi-Task Markov Decision Processes: Structure, Invariance, and Reducibility"
  author: "Jaeuk Shin, Insoon Yang"
  venue: "IEEE Control Systems Letters"
  date: 2024
  doi: 10.1109/lcsys.2024.3405958
read: abstract-only
source: "Primary abstract and conference-archive presentation text via https://doi.org/10.1109/LCSYS.2024.3405958 and https://css.paperplaza.net/images/temp/CDC/CDC24_ContentListMedia_3.html"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Multi-task MDP analysis identifies polyhedral reward-parameter regions sharing one optimal policy, an independent instance of requested-result quotienting known only at abstract-evidence depth"
---

# Multiparametric Analysis of Multi-Task Markov Decision Processes: Structure, Invariance, and Reducibility

## Evidence

### Relevance

Shin and Yang formulate a multi-task Markov decision process as a
multiparametric linear program whose parameters are reward functions. Their
published abstract states that the geometric analysis identifies polyhedral
sets of rewards producing the same optimal policy, derives reward
transformations that preserve optimality, and studies lower-dimensional reward
representations.

## Bearing on RQs

This meets the survey's output-quotient trigger: distinct parameter values and
underlying optimization details are grouped by the requested policy. It is
therefore an independent warning that requested-result quotienting is not new.

The object is an extensional optimal-policy quotient, not a contextual record
of which internal selections were reached while evaluating a requested graph
root.

## Evidence limits

The available primary text supports only the high-level policy-region,
invariance, and reducibility statements above. This note does not attribute a
specific enumeration theorem, canonicality result, or complexity bound.
