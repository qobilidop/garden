---
citekey: huang2024exhaustive
work:
  title: "Exhaustive Property Oriented Model-Based Testing with Symbolic Finite State Machines"
  author: "Wen-ling Huang, Niklas Krafczyk, Jan Peleska"
  venue: "Science of Computer Programming"
  date: 2024
  doi: 10.1016/j.scico.2023.103005
read: full-text
source: "Technical report (Zenodo 7267975) via https://doi.org/10.5281/zenodo.7267975, corresponding to the 2024 Science of Computer Programming article at https://doi.org/10.1016/j.scico.2023.103005"
retrieved: "-"
notes-by: Codex (initial campaign); Claude Fable 5 (record migration)
notes-date: 2026-08-04
synthesis: "Constructs an exact finite equivalence partition of infinite input/output domains via SMT-enumerated Boolean atoms over a finite observer alphabet — elementary prior art for generic exact enumeration once selection sites are encoded as atoms, leaving open only the graph-specific compact-representation and residualization questions"
---

# Exhaustive Property Oriented Model-Based Testing with Symbolic Finite State Machines

## Evidence

### Why it matters

Huang, Krafczyk, and Peleska explicitly construct an exact finite equivalence
partition of infinite input/output valuation domains from a finite observer
alphabet. They enumerate every satisfiable Boolean atom over guard conditions,
output expressions, and atomic propositions, then reason and generate tests
over sequences of those symbolic classes. The main theorem proves an
exhaustive property-oriented test suite within a stated finite fault domain.

This is a direct antecedent for “enumerate all realizable combinations of a
finite family of observations with SMT and use each combination as a symbolic
class.” It also supplies a strong terminology precedent: *equivalence class*,
*partition*, *symbolic trace*, *representative*, and *exhaustive test suite*.

### Equivalence classes

Let the finite formula alphabet be

\[
  \Sigma=\Sigma_I\cup\Sigma_O\cup AP,
\]

containing every admitted transition guard, output expression, and atomic
proposition relevant to the fault domain. For valuations $\sigma,\sigma'$,

\[
  \sigma\sim_\Sigma\sigma'
  \quad\Longleftrightarrow\quad
  \forall\varphi\in\Sigma.\;
  (\sigma\models\varphi\iff\sigma'\models\varphi).
\]

For every subset $P\subseteq\Sigma$, the construction forms the complete atom

\[
  \varphi_P=
  \bigwedge_{e\in P}e\land
  \bigwedge_{e\in\Sigma\setminus P}\neg e
\]

and keeps it iff satisfiable. Its model set is one equivalence class. The
resulting classes are disjoint and cover all valuations, including when the
underlying domains are real or unbounded integer theories. The worst-case
class count is $2^{|\Sigma|}$; infeasible atoms often make the realized count
much smaller.

The method is a static full-alphabet construction: the truth of every formula
in $\Sigma$ is recorded for every valuation. It has no result-relative notion
that a formula or site is structurally unobserved. A formula can be dropped
only by changing the chosen alphabet or later quotienting its atoms.

### Trace and testing results

The reference and fault-domain implementations are symbolic finite-state
machines (SFSMs) with finite control states but potentially infinite typed
input/output domains. Equivalent point valuations form a finite symbolic
alphabet; concrete traces with the same class sequence reach the same
observable reference state and satisfy the same atomic propositions
(Theorem 2 in the technical report).

The generated finite test suite is exhaustive for every LTL safety property
over $AP$ satisfied by the reference model, assuming the true implementation
lies in a fault domain with a bounded number of observable states and the
declared finite guard/output alphabets. Under a sufficiently discriminating
propositional abstraction, a corollary gives complete language-equivalence
testing.

The test-suite bound is exponential in the implementation/reference state
difference and in the class alphabet. The technical report gives
$O(n^2|A|^{m-n+1})$ as a W-method upper bound and
$|A|=O(2^{|\Sigma_I|+|\Sigma_O|+|AP|})$ for the equivalence-class alphabet.
These are test-suite bounds, not output-sensitive class-enumeration bounds.

### Reduction and separator

For every selection site $q$, add formulas for activity and each observed
outcome to $\Sigma$:

\[
  a_q(x,R),
  \qquad a_q(x,R)\land p_{q,\omega}(x)
  \quad(\omega\in\Omega_q).
\]

The full Boolean atom then determines the totalized observation vector. Thus
the atom partition refines, and after projecting or merging irrelevant truth
coordinates yields, the selection-observation partition. If $\Sigma$ contains
only a mutually exclusive total code for each site's
`unobserved-or-outcome` value, the atoms coincide exactly with its fibers.

### Evidence locations

- Technical-report Chapter 2 and Table 2.1, pp. 13--16: Boolean-atom class
  construction and exponential worst case.
- Chapters 3--5, pp. 27--49: SFSM semantics, exact equivalence relation,
  trace preservation, and exhaustive property-oriented test suite.
- Section 5.6, pp. 48--50: test-suite and class-alphabet complexity.
- Journal Section 4.7: final exhaustiveness theorem and fault-domain
  assumptions.

## Bearing on RQs

This reduction means generic exact enumeration is elementary prior art. The
remaining graph-specific questions are whether the enabled-closure structure
lets us avoid constructing every Boolean atom, whether exact fibers have the
short local form that omits negative inactive-site literals, and how to derive
one symbolic residual per fiber.

The SFSM tests enumerate finite sequences of classes to distinguish black-box
implementations; our algorithm enumerates the one-input image of a pure graph
observer. Their exhaustiveness theorem therefore does not transfer to our
algorithmic delay or residual-correctness claims, but their partition theory
does transfer directly.

Safe claim:

> A finite observation alphabet induces exact SMT-enumerable Boolean-atom
> classes; this is established. Selection observations add an
> input-dependent-domain graph observer whose fibers may admit a more compact
> local representation and symbolic residualization.

## Evidence limits

Zenodo record 5719524 is the shorter 2021 two-author SEFM technical report.
Zenodo record 7267975 is the later three-author comprehensive technical report
covering the theory published in the 2024 Science of Computer Programming
article. Claims here use the latter and the final journal DOI.
