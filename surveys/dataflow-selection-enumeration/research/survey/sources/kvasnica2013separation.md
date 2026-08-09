# kvasnica2013separation — exact separator representation of saturated outputs

- **Status:** deep-read; high-priority exact-representation baseline
- **Primary source:** https://doi.org/10.1016/j.automatica.2013.02.018
- **Version read:** published Automatica article
- **Bibliography key:** `kvasnica2013separation`

## Contribution

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

## Complexity and boundary

For degree \(\delta\) in state dimension \(n_x\), the explicit LP has roughly
\(\binom{n_x+\delta}{\delta}\) coefficient variables, with further constraints
from the Pólya-expanded vertex polynomials. The implicit construction avoids
vertex enumeration at the cost of more online work. There is no minimum or
canonical representation theorem.

Like clipping, separation is an exact extensional representation of a fixed
controller function. It does not enumerate sparse graph events or retain two
equal-valued selection outcomes as distinct observations.

