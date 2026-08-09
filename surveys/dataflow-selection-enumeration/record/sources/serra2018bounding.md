---
citekey: serra2018bounding
work:
  title: "Bounding and Counting Linear Regions of Deep Neural Networks"
  author: "Thiago Serra, Christian Tjandraatmadja, Srikumar Ramalingam"
  venue: "ICML 2018"
  date: 2018
read: full-text
source: "ICML 2018 paper and official supplement via https://proceedings.mlr.press/v80/serra18b.html"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Exactly enumerates and counts feasible dense ReLU activation patterns of a bounded network via branch-and-bound MILP — predating Balestriero and LeCun, but for the all-sites-observed special case rather than sparse enabled-closure observations"
---

# Bounding and Counting Linear Regions of Deep Neural Networks

## Evidence

### Why it matters

Serra, Tjandraatmadja, and Ramalingam exactly enumerate or count the feasible
dense activation patterns of a bounded ReLU network through mixed-integer
linear programming. This predates Balestriero and LeCun and independently
defeats any claim that exact feasible neural activation-pattern enumeration is
new.

### Object and encoding

Definition 1 calls the set of inputs that produce the same activation pattern
a *linear region*. The paper explicitly notes that adjacent regions with
different activation patterns can, in degenerate cases, represent the same
affine map. Its regions are therefore graph-intensional activation cells, not
necessarily maximal extensional pieces.

Section 5 assumes a bounded polyhedral input domain and introduces one binary
activation variable per ReLU, continuous positive and complementary neuron
outputs, and big-\(M\) constraints (1)--(6). Theorem 11 proves that those
constraints reproduce each ReLU when the bounds are valid.

A one-tree branch-and-bound procedure resumes after each integer solution to
enumerate activation assignments. On activation boundaries the binary
variable could otherwise take either value, so program \(\mathcal P\)
maximizes the minimum positive active output. Positive optimum distinguishes
the full-dimensional nondegenerate regions intended for counting and avoids
boundary double-counting.

The supplement proves that the represented regions are finite unions of
polyhedra and gives an unrestricted-input corollary when a sufficiently large
valid \(M\) exists. That corollary is existential; it does not construct the
bound for an arbitrary network.

### Complexity and assumptions

The paper gives no output-polynomial complexity theorem for enumeration.
Branch-and-bound can explore exponentially many binary patterns, and the
reported small-network runs already take up to hundreds of thousands of
seconds. Practical exactness requires a bounded polytope, correct big-\(M\)
bounds, a complete MIP solver, and careful treatment of degeneracy.

### Evidence locations

- Definition 1 and footnote, paper p. 2: activation-pattern region and
  degeneracy caveat.
- Section 5, paper pp. 6--8: bounded-domain MIP, one-tree enumeration, and
  boundary objective.
- Theorem 11, paper p. 7: exact ReLU encoding.
- Supplement, Theorem 20 and Corollary 21: polyhedral regions and
  unrestricted-input existence result.

## Bearing on RQs

Dense ReLU activation patterns correspond to a fixed-domain observation map:
every unit contributes one coordinate. The method returns feasible total
patterns and can recover their polyhedral guards. It does not omit a unit
because an outer selection chose a different case, request only selected
result roots, retain a typed symbolic residual, or distinguish structural
absence from an existentially projected variable.

The paper establishes exact activation-pattern feasibility, not sparse
enabled-closure observations. It should nevertheless be cited whenever the
manuscript introduces the all-sites-observed affine special case.

## Evidence limits

Read at full-text level (ICML 2018 paper and official supplement); the note
records no evidence-quality caveats beyond the scope boundary above.
