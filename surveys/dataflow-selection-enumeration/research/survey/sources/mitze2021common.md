# mitze2021common — same-first-action sets for nonlinear MPC

- **Status:** deep-read; high-priority output-projection successor
- **Primary source:** https://doi.org/10.1109/PC52310.2021.9447473
- **Open copy:** https://arxiv.org/abs/2009.04187
- **Version read:** accessible full preprint and conference metadata
- **Bibliography key:** `mitze2021common`

## Contribution

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

Offline region construction, union, and ellipsoid fitting restrict the method
to modest problems, and the paper gives no asymptotic enumeration theorem.
The work reinforces König--Mönnigmann's output-projection precedent but does
not define sparse selection-event observations or input-dependent graph-site
domains.

