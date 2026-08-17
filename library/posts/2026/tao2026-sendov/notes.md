---
citekey: tao2026-sendov
work:
  title: A digestion of the proof of Sendov’s conjecture
  author: Terence Tao
  date: 2026-08-12
source: https://terrytao.wordpress.com/2026/08/12/a-digestion-of-the-proof-of-sendovs-conjecture/  # snapshot → shadow; figures (3 PNGs) → store
discussions:
  - https://news.ycombinator.com/item?id=49282231  # 2026-08-13
retrieved: 2026-08-16
notes-by: Claude Fable 5
notes-date: 2026-08-16
synthesis: "An AI-generated, Lean-certified resolution of Sendov's conjecture arrived correct but unreadable; Tao's several-day human+AI digestion — tracing each identity to classical literature, simplifying to an elementary argument, re-formalizing at a sixth the size — shows the bottleneck moving from verification to understanding."
---

# A digestion of the proof of Sendov’s conjecture

Tao's expository account of a resolved conjecture, written days after
the event it digests. Lech Mazur used an AI tool (unnamed in the post)
to resolve Sendov's conjecture — every degree-$n \geq 2$ polynomial
with all zeroes in the unit disk has, within distance 1 of each zero, a
critical point — with the proof verified in Lean. The linked proof PDF
and formalization are hosted on proofatlas.ai (the PDF's filename dates
it August 5, 2026). The AI-generated proof was correct but "not
human-digested to be in the form of a publication-ready preprint," and
the post is Tao's several-day digestion, performed "with heavy AI
assistance": placing the argument in the literature, simplifying it,
and re-deriving it as a self-contained blog proof. The digestion
strengthens the result — the argument in fact proves the interior case
outright and so also settles the stronger Phelps–Rodriguez conjecture
(strict inequality unless $a$ is on the unit circle and $p$ is a
scalar multiple of $z^n - a^n$) — and
yields a new proof of Rubinstein's $a=1$ theorem as a bonus.

## The proof, digested

Prior status: known for $n \leq 8$ (a sequence ending with Brown–Xiang)
and for sufficiently large $n$ (Tao's own 2020 paper), with the
threshold unquantifiable because that argument used qualitative
ingredients like analytic continuation. The digested proof is
"remarkably elementary": nothing beyond the fundamental theorem of
algebra, basic Möbius facts, and a special case of the Maclaurin
inequality derivable from AM–HM plus induction.

The architecture treats the zeroes $z_j$ and the reciprocal-shifted
critical points $q_j$ (critical points written $a - 1/q_j$, so the
distance-$\geq 1$ hypothesis becomes $q_j$ in the unit disk) as almost
independent objects that "communicate" only through four identities
obtained by inspecting $p$ and $p'$ at a few points: a centroid
identity (classical — Popoviciu 1948), a polar identity (the $a$ vs
$1/a$ inversion trick familiar from Dégot; implicit in Mazur's §5), and
two origin identities (extracted from Mazur's equation (6.3); close to
identities of Dégot, Mir–Nazir–Wani, and — for $a=1$ — Rubinstein). From these, two
inequalities in a normalized parameter $\alpha := \frac{n-1}{2}(1-a^2)$
and a proximity measure $\beta(1)$: a "polar inequality" forcing one
feasible region and a harder "origin inequality" (via a defect lemma
reducing to points on the unit circle, proved by sinh superadditivity)
forcing another. The two regions are disjoint — the post's feasibility plots (one explicitly
Gemini-generated) show the polar region below
$\beta = \frac{\alpha}{3+\alpha}$ and the origin region well above it —
so a counterexample cannot exist. Closing the gap quantitatively needs
$\alpha \leq 17$, a by-hand elimination of $n > 200$ (numeric bound
0.399 against a threshold of 1), computer assistance for
$5 \leq n \leq 200$ (worst case $n = 53$, where the relevant bound
reaches only 0.853; illustrated by an applet and verified in Lean), and
a short classical argument for $n \leq 4$.

## Digestion as a workflow stage

The post names and demonstrates a stage the capability announcements in
this library leave implicit: after machine-checked correctness, someone
still has to make the proof *understood* — attributed to its
antecedents, simplified to its load-bearing ideas, and cheap to check.
Every identity gets a provenance line into 1948–2025 literature; the
inequalities are extracted from specific equations of the AI proof and
then simplified further (some simplifications Tao's own, one bound —
the $\sqrt{h^2+9}$ estimate with its unimprovable constant 9 —
explicitly "an AI-generated argument"). The digestion itself is
AI-saturated across vendors: a linked ChatGPT session covers "a
portion" of the work (the rest pen-and-paper or "further AI agents"),
a figure is Gemini-generated, and an AI agent produced Tao's new
Lean formalization — about 15,000 lines against roughly 90,000 for the
original, a 6× compression that is itself a measure of what digestion
buys. The blog's sidebar shows sibling posts digesting the Jacobian
conjecture counterexample and the HRT counterexample: "digestion" is
becoming a recurring genre, a named human role downstream of AI proof
production.

## Limits, honestly reported

Section 5 is a map of what the method does not do. The strengthenings —
Borcea (moment-averaged zeroes), Schmeisser (convex hull), Zhang's
common generalization, Tang–Zhang ($\sum |q_j|^\lambda \geq n-1$), and
Smale's problem — all remain open; for each, some hypothesis behind the
four identities fails. AlphaEvolve found no counterexamples to Borcea,
Schmeisser, or Smale (reported in Tao's November 2025 post), and Tao's
"desultory attempts to use AI tools to attack these questions" came to
"without much notable success." The closing reflection is
methodological: the proof's narrow-communication structure is
remarkable, but progress on the generalizations may need approaches
using global features of the polynomial.

## Against the library

The trust stack matches [[openai2026-math-advances]] and
[[anthropic2026-riemann-zeta]] — AI argument, Lean certificate, human
exposition — but the sociology inverts. There the organization claimed
and the certificate defended; here an individual outside the field's
establishment produced the certified proof, and the field's leading
expert (whose own 2020 large-$n$ result the elementary argument
supersedes) spent days performing exactly the independent expert
scrutiny those entries flagged as missing, in public, with attribution
to the AI throughout. On [[jiang2026-solvers]]'s map this is a genuinely
open named conjecture falling to AI — past the survey's
smallest-category precedents — yet consistent with its diagnosis: the
final argument is elementary and identity-driven, insight-then-short-
proof rather than new concepts, and the rediscovery check (every
ingredient traced to prior literature; the combination new) is here
done by hand at expert level. The AlphaEvolve negative results cited as
evidence for the surviving conjectures are [[novikov2025-alphaevolve]]
operating in its counterexample-search register. The verification
caveats of [[demoura2026-kernel-soundness]] still apply to both Lean
artifacts, but statement fidelity — the other trust layer — is
addressed better than anywhere else on this shelf: a second,
independent formalization written against a human re-derivation of the
statement.

## Assessment

- **Durable:** the digestion pattern itself — correctness settled by
  machine, understanding supplied by expert-plus-AI labor, measured
  concretely by the 90k→15k formalization compression; the
  narrow-communication proof architecture; the provenance tracing that
  turns an opaque proof into cumulative literature.
- **Era-bound:** the specific AI-assistance inventory (ChatGPT log,
  Gemini figures, unnamed agents); proofatlas.ai as host; the applet.
- **Caveats:** the post never names Mazur's AI tool, so the headline
  "AI resolved it" rests on Mazur's claim as relayed by Tao plus the
  linked artifacts; neither Lean development has been examined here;
  the digestion is a blog post, not a refereed paper, and Tao notes a
  publication-ready preprint is what the original proof still lacks.
  Tao has an evident stake (his conjecture-adjacent program, his prior
  partial result), which he discloses by citation rather than
  concealing.
