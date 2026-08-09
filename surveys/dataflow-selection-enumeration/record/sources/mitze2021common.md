---
citekey: mitze2021common
work:
  title: "State Space Sets With Common Optimal Feedback Laws for Nonlinear MPC"
  author: "Ruth Mitze, Raphael Dyrska, Kai König, Martin Mönnigmann"
  venue: "PC 2021"
  date: 2021
  doi: 10.1109/PC52310.2021.9447473
read: full-text
source: "Full arXiv preprint (2009.04187), https://arxiv.org/abs/2009.04187, conference metadata checked against https://doi.org/10.1109/PC52310.2021.9447473"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Extends first-action reuse to nonlinear MPC: when enough first-input active constraints have full rank, a constant first action is determined and every optimal active set containing that subset shares it, though the exact common-action unions are only approximated from inside by ellipsoids while the returned control itself remains exact."
---

# State Space Sets With Common Optimal Feedback Laws for Nonlinear MPC

## Evidence

### Contribution

Mitze, Dyrska, König, and Mönnigmann extend first-action reuse to nonlinear
MPC. When enough first-input active constraints have full rank, they determine
a constant first action. Every optimal active set containing that subset shares
the same requested action even though the complete control trajectories can
differ.

The exact common-action unions are approximated from inside by ellipsoids. The
coverage is approximate, but the returned control is not: inside a certified
ellipsoid the exact action is reused, and outside it the original optimal
control problem is solved. Underestimation reduces hit rate without changing
the returned optimal feedback.

## Bearing on RQs

The work reinforces König–Mönnigmann's output-projection precedent but does
not define sparse selection-event observations or input-dependent graph-site
domains.

## Evidence limits

Offline region construction, union, and ellipsoid fitting restrict the method
to modest problems, and the paper gives no asymptotic enumeration theorem.
