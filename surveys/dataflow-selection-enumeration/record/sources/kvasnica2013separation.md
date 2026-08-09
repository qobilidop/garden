---
citekey: kvasnica2013separation
work:
  title: "Complexity Reduction of Explicit Model Predictive Control via Separation"
  author: "Michal Kvasnica, Juraj Hledík, Ivana Rauová, Miroslav Fikar"
  venue: "Automatica"
  date: 2013
  doi: 10.1016/j.automatica.2013.02.018
read: full-text
source: "Published Automatica article, https://doi.org/10.1016/j.automatica.2013.02.018"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Stores only unsaturated controller regions and distinguishes maximum- from minimum-saturated portions via a separating function proven pointwise equal to the original continuous PWA controller — an exact extensional representation, not a sparse graph-event enumerator that retains distinct equal-valued outcomes."
---

# Complexity Reduction of Explicit Model Predictive Control via Separation

## Evidence

### Contribution

Kvasnica, Hledík, Rauová, and Fikar store only unsaturated controller regions
and distinguish maximum- from minimum-saturated portions using a separating
function. Lemma 3.1 establishes pointwise equality between the resulting
representation and the original continuous PWA controller.

An explicit polynomial separator is constructed from vertices, Pólya
positivity, and one linear program. An alternative implicit separator uses
projection and intersection toward the unsaturated set. Fixed polynomial and
Pólya degrees give sufficient construction tests: LP infeasibility does not
prove that no separator exists. The implicit construction assumes continuity,
a convex domain, and a suitable interior point.

### Complexity

For degree \(\delta\) in state dimension \(n_x\), the explicit LP has roughly
\(\binom{n_x+\delta}{\delta}\) coefficient variables, with further constraints
from the Pólya-expanded vertex polynomials. The implicit construction avoids
vertex enumeration at the cost of more online work. There is no minimum or
canonical representation theorem.

## Bearing on RQs

Like clipping, separation is an exact extensional representation of a fixed
controller function. It does not enumerate sparse graph events or retain two
equal-valued selection outcomes as distinct observations.

## Evidence limits

Read at full-text (Automatica) level; the source note recorded no dedicated
evidence-locations or weaknesses section beyond the complexity caveat already
stated above (no minimum or canonical representation theorem is given).
