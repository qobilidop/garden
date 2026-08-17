# AI for mathematics

AI systems producing mathematics, and the machinery for trusting what
they produce. The shelf, by role: the field map
([[jiang2026-solvers]] — solver regime saturated,
research agents are the frontier), the founding methods
([[polu2020-gpt-f]],
[[jiang2022-draft-sketch-prove]],
[[trinh2024-alphageometry]]),
the scale landmarks
([[hubert2025-alphaproof]],
[[novikov2025-alphaevolve]]), the capability claim
([[openai2026-math-advances]]), the open-ended discovery case
([[anthropic2026-riemann-zeta]]), the resolved-conjecture
digestion ([[tao2026-sendov]]), the philosophical frame
([[klowden2026-human-thought]] — the decoupling of form from
thought, and the vocabulary for what certificates leave out), and
the trust infrastructure's failure mode
([[demoura2026-kernel-soundness]], published the
same day as the ten-advances claim).

## How the capability was built

Four method lineages, each anchored by a founding work, converge in
today's systems. **Generate-and-search**:
[[polu2020-gpt-f]]
(GPT-f) cast tactic generation as language modeling, coupled the
model to the verifier, and proposed expert iteration — the recipe
[[hubert2025-alphaproof]]
(AlphaProof) ran at AlphaZero scale to IMO silver, adding test-time
RL on self-generated problem variants as a third scaling axis.
**Informal-guided**: [[jiang2022-draft-sketch-prove]] split labor
between an LLM (structure, from informal drafts) and symbolic
automation (rigor at the leaves) — the decomposition lineage behind
today's subgoal provers. **Neuro-symbolic with synthetic data**:
[[trinh2024-alphageometry]]
(AlphaGeometry) trained on 100M symbolically-generated proofs and
reserved the neural net for exogenous terms (auxiliary
constructions), the one move deduction engines cannot make.
**Evolutionary discovery**: [[novikov2025-alphaevolve]] evolves
programs under a fixed scorer — witnesses and bounds rather than
proofs, the artifact-side complement to the prover lines. Recurring
across all four: the generator is never trusted (verifier, prover,
or scorer gates everything), and scarce formal data is manufactured
(synthetic proofs, auto-formalized curricula, self-generated
variants) rather than awaited.

## The trust architecture

The two corporate capability announcements exhibit little mathematics;
their evidentiary weight rests on linked papers, human review, and released
Lean certificates — machine-checked proof as the move that neutralizes
skepticism of corporate research claims, modulo checking that formal
statements match informal ones. [[anthropic2026-riemann-zeta]] adds an
explicit comparator-checked formalization and two internal mathematicians'
validation, but neither announcement reports an independent statement-fidelity
audit. The postmortem quantifies the residual risk behind exactly that move: a
kernel implementation bug (phantom parameters escaping type checking
in nested inductives) admitted a `sorry`-free proof of `False`,
reachable through metaprogramming. The layered answer that actually
carries the trust: the kernel must reject ill-typed declarations on
its own (soundness can never depend on the untrusted elaborator
declining to build bad terms), independent checkers cross-check it —
and the exploit's defeat of week-old nanoda required *two distinct
bugs in two implementations*, which is the defense-in-depth arithmetic
working in principle while showing its operational condition: the
checkers only compose if all are kept current. Verified kernels
(lean4lean's in-progress consistency proof) are the next layer; its
inductive handling inherited the bug precisely because it is a port,
not yet a verification.

The practices at the trust stack's operating end are visible in
[[hubert2025-alphaproof]]:
every AlphaProof proof gets an independent final check by the
standard Lean toolchain plus an audit that only three accepted
axioms were used — the discipline the postmortem's layered argument
prescribes, run in production.

Above the kernel sits a second trust layer the certificates don't
cover: **statement fidelity**. [[jiang2026-solvers]]
documents it as the field's recurring failure — compilation does not
imply the formal statement captures the intended theorem. The
standard example: Aristotle's machine-checked late-2025 "solution" to
Erdős #124 proved a weakened variant omitting the gcd constraint (the
problem remains open), and formalizers with equal headline scores
yield sharply different downstream prover success. Together the two
layers bound what "machine-checked" certifies: the kernel can be
wrong about the proof, and the formalization can be wrong about the
statement. Both layers were named in advance, from philosophy rather
than incident reports: [[klowden2026-human-thought]] (written over the
year before either failure surfaced) gives the statement-fidelity gap
its cleanest thought experiment — a certified "disproof" of Fermat's
last theorem obtained by letting the naturals start at zero — and adds
a third layer the certificates cannot even express: a formally correct
proof can still be "odorless," carrying no causal narrative of where
the heavy lifting happens, no smell for experts to judge or repair by. [[tao2026-sendov]] shows the audit both layers call for
actually being run: after an AI tool (unnamed in the post) resolved
Sendov's conjecture with a roughly 90,000-line Lean certificate, Tao
re-derived the argument by hand plus AI and produced an independent
~15,000-line formalization against his own restatement — a second
proof object written from understanding, which is stronger fidelity
evidence than any single comparator check, though supplied here by
the one expert best positioned to give it. One elegant inversion: AlphaProof trained on ~80M
auto-formalized statements *without* fidelity checking — a
mistranslated problem is still a well-formed training instance.
Infidelity poisons evaluation but feeds curricula; the layer only
becomes load-bearing when a claim rides on it.

## AI on both sides of the ledger

The same week's events place AI at every position: generating the
proofs (ten problems, solution-finding compute framed at "roughly
$2,000"), assisting the exploit (the Collatz "disproof" was
AI-assisted, built deliberately to demonstrate the soundness bug), and
hunting the defects (a cybersecurity-specialized model run over the
kernel found further metaprogramming-only bugs, all caught by current
nanoda). The Breitner hypothesis is the sentence to keep: models are
now strong enough to find kernel soundness bugs, which changes the
threat model for proof infrastructure — certificates invite
adversaries exactly as they reassure reviewers.

## Solvers, not yet researchers

[[jiang2026-solvers]] supplies the shelf's base
rates. Competition benchmarks are exhausted (miniF2F ~30%→99.6% in
four years — AlphaProof holds that endpoint; IMO at medal level and
climbing), but the Erdős-problem accounting —
maintained on a co-author's own database — shows genuinely novel
AI-primary solutions are the smallest category, dwarfed by AI
literature reviews and AI-formalized proofs, and outnumbered by
solutions that turned out to be rediscoveries of published work.
Claimed pattern: AI succeeds on insight-then-short-proof problems;
sustained novel construction and concept invention remain the
boundary. [[novikov2025-alphaevolve]] sits exactly on it: within
evaluator reach it produced provably correct new mathematics (the
4×4 rank-48 result, Erdős minimum-overlap and kissing-number
improvements), yet its exploration is bound to predefined scoring
functions — it widens search without reorganizing concepts, which is
the survey's precise diagnosis of where discovery stops.
[[anthropic2026-riemann-zeta]] sits just across that boundary without
overturning it: an open-ended attack on the Riemann hypothesis failed, but a
31-million-output-token search composed prior analytic-number-theory results
into a stronger adjacent bound. This is more research-shaped than evaluator
optimization, yet still the insight-then-short-argument regime
[[jiang2026-solvers]] says works best; the internal search of 54 papers is
evidence against rediscovery, not an independent literature review.
And the rediscovery check itself has a growing hazard:
[[klowden2026-human-thought]] reports first-hand "citogenesis" — AI
deep-research literature surveys posted to the Erdős problems site
became the same tools' authoritative source, interfering with later
searches for genuinely new literature. The evidence base for "is this
new?" is being polluted by the instruments that ask it.
[[tao2026-sendov]] then moves the base rate itself: a long-open named
conjecture resolved outright by an AI tool in the hands of an
individual outside the field — well past the survey's
smallest-category precedents — while confirming the regime diagnosis,
because the digested proof is elementary and identity-driven, an
insight-then-short-proof argument whose every ingredient Tao traces to
1948–2025 literature (the combination, not the parts, is new: the
rediscovery check run by hand at expert level). The same post shows
the boundary holding on the other side: the surviving generalizations
(Borcea, Schmeisser, Smale) resisted Tao's own AI attempts, with
[[novikov2025-alphaevolve]] cited in its counterexample-search
register as evidence they are at least not false. This is
the frame to apply to any
capability claim on this shelf: check rediscovery, check
specification, expect selection bias in what gets reported.

## The workflow shape

The common spine is model-generated arguments → human-reviewed manuscripts →
Lean formalization → released reasoning traces. The search regimes differ:
[[openai2026-math-advances]] presents ten selected endpoints and their
certificates, while [[anthropic2026-riemann-zeta]] exposes one failed target,
650 discarded first-pass ideas, and a second pass of roughly 60 specialized
subagents whose adjacent result survived model attack, human review, and
formalization. Alongside it, OpenAI stakes an explicit attribution ethic
(claiming human authorship for an AI-generated proof misrepresents both sides).
In
[[liu2026-agent-taxonomy]]'s frame, this is the
loop closing on science rather than benchmarks.

The spine now has a named stage after the certificate:
[[tao2026-sendov]]'s "digestion" — placing the machine-checked proof
in the literature, simplifying it to its load-bearing ideas, and
re-formalizing the streamlined argument at a sixth the original's
size. Correctness arrives settled; understanding is the remaining
labor, and it is itself AI-saturated (a ChatGPT session, Gemini
figures, further agents for the Lean port) with the human supplying
attribution and judgment. Tao's sibling digestion posts make this a
genre rather than a one-off — the clearest picture yet of the durable
human role downstream of AI proof production. The genre has a theory:
[[klowden2026-human-thought]] predicted that as verified deduction is
outsourced, human effort migrates to the "penumbra" — motivation,
heuristics, attribution, the narrative the formal core cannot carry —
which is a description of digestion written months before the
practice matured, by one of its practitioners. The frame is already
exported beyond mathematics: [[ye2026-cake]] cites Tao's
proof-abundance observation as a design requirement for a GPU-kernel
compiler — agent-generated artifacts must stay inspectable because
abundance moves the bottleneck to verification and understanding.

## What the shelf needs next

The announcement is deliberately thin; the mathematics lives in the
linked ten-proofs paper — the natural next ingestion, as a papers/
entry, now with [[jiang2026-solvers]]'s checklist to apply (rediscovery,
specification fidelity, selection bias). Open questions the current
works raise but don't settle: *tooling* for statement–formalization
correspondence ([[jiang2026-solvers]] names the failure and floats FormalAlign-
style checkers, but nothing settles it); whether the released
reasoning traces support or merely narrate the discovery claims; how
the five named human follow-up papers to the unit-distance disproof
treat AI-originated results; and whether the First Proof challenge
(ten never-published research problems, endorsed by [[jiang2026-solvers]] as the
clean evaluation) resists the contamination that saturated the
competition benchmarks. The Anthropic case adds its own next checks: an
independent rediscovery search, peer review of the 67.2% argument, and an audit
that the released Lean theorem matches the informal lower-bound claim.
[[tao2026-sendov]] adds two more: the identity and workings of Mazur's
unnamed tool (the headline capability claim currently rests on the
claimant plus the certificate), and whether digestion scales — who
performs it for results without a world-expert volunteer, and at what
cost. The
kernel-side thread continues too:
verified kernels reaching inductives, and whether comparator-style
daily cross-checking becomes standard practice.
