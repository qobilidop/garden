---
citekey: jiang2026-solvers
work:
  title: "From Solvers to Research: Large Language Model-Driven Formal Mathematics at the Research Frontier"
  author: Eric Jiang, Xiao Liang, et al. (19 authors, UCLA + LLNL; incl. Terence Tao)
  date: 2026-07-08
  doi: 10.48550/arXiv.2607.07779
  arxiv: 2607.07779 (v1, 2026-07-08; no venue yet)
sources:
  pdf:  # → store; pinned to v1
    url: https://arxiv.org/pdf/2607.07779v1
    archived: https://web.archive.org/web/20260714003709/https://arxiv.org/pdf/2607.07779v1
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "The solver regime is saturated and its benchmarks exhausted; the frontier is research agents — with specification fidelity and the SMT-vs-CAS verification gap as the load-bearing distinctions."
---

# From Solvers to Research: Large Language Model-Driven Formal Mathematics at the Research Frontier

Position paper plus survey from UCLA and LLNL (19 authors — the roster
includes Tao, Bertozzi, Meka, Sahai — with equal-contribution first
authors Jiang and Liang). Thesis: LLM-driven formal mathematics has
mastered the *solver* regime (well-specified competition problems) and
must now become *research agents* — systems that conjecture,
formalize, prove, and interpret at the open frontier. Three
contributions: a taxonomy of LLM-based neural theorem proving, the
first structured empirical snapshot of AI contributions to open Erdős
problems, and a five-barrier diagnosis with a roadmap. The synthesis
below leans on the second and third, which are the durable parts; the
taxonomy is a competent field map that will age like all such maps.

## The saturation argument

The solver claim rests on benchmark history: miniF2F went from ~30%
(2021) to effectively saturated (Seed-Prover 99.6%, one problem
unsolved; Hilbert at 99.2% via recursive subgoal decomposition), and
IMO performance reached medal level (Seed-Prover 5/6 at IMO 2025,
Gemini Deep Think at gold threshold). The methods behind this —
expert iteration with verifier reward (RLPAF), draft-sketch-prove
decomposition, search-in-the-loop training, retrieval over mathlib —
are cataloged in a three-axis taxonomy (training strategies, test-time
adaptation, agentic workflow). The lesson the paper draws is not
triumph but benchmark exhaustion: the gap between saturated
competition benchmarks and research mathematics is the paper's
subject.

## The Erdős snapshot — the empirical core

Six contribution categories, tracked on the community wiki (hosted on
Tao's GitHub — an author is the database's maintainer, which makes
the snapshot authoritative and not independent). The accounting as of
January 2026, with the cumulative plot running to April: genuinely
novel AI-primary full solutions are the *smallest* category (4+, vs
11+ where literature review later found prior work and 11+ where
prior work was known); support work dwarfs everything — AI literature
reviews touch 106 problems and AI-formalized proofs 121, against 44
for all AI-primary-no-prior contributions including partials. The
viewed Fig. 6 makes the shape vivid: dashed support-work curves step
sharply upward with each tool arrival (GPT-5 reviews, Aristotle
formalizations, AlphaProof mass evaluations, Aletheia), solid
novel-solution curves crawl beneath them. The paper's own caveats are
the right ones: selection bias (failures unreported), misformulated
"solutions," and obscurity-vs-difficulty ambiguity. Pattern claimed:
successful solutions are insight-then-short-proof problems; sustained
novel construction remains out of reach.

## Specification fidelity — the sharpest section

The recurring failure the paper documents best: compilation does not
imply semantic correctness. The flagship example — Aristotle's
machine-checked late-2025 "solution" to Erdős #124 proved a weakened
variant omitting the gcd constraint; the original remains open.
Same phenomenon at benchmark scale: formalizers with comparable
headline scores (Herald vs Kimina) yield sharply different downstream
prover success, and miniF2F itself contains problems weakened into
triviality or corrupted into unprovability by translation. This is
the trust layer *above* the kernel: [[demoura2026-kernel-soundness]]
covers the checker being wrong; this covers the checker verifying the
wrong statement. Related operational complaint: AI proofs are bloated
and slow to compile, and the paper calls for refactoring agents to
keep shared libraries maintainable.

## The five barriers

1. **Data/evaluation** — formal corpora are orders of magnitude
   smaller than informal ones; synthetic generation, curriculum
   learning, and mining failed trajectories for subgoals are the
   levers.
2. **Relational structure** — flat libraries and 100^50 search
   spaces; proposal: mathematical knowledge graphs with inexact
   subgraph matching and anti-unification to abstract recurring proof
   motifs into templates.
3. **Verification → discovery** — self-play conjecturing (STP) and
   evolutionary search (AlphaEvolve) exist, but score-function-driven
   evolution can't invent concepts or reorganize frameworks; the
   paper locates the solver/discoverer boundary exactly there.
4. **Tool ecosystem** — the verification gap: SMT solvers emit
   checkable certificates, CAS output can be silently wrong; plus
   fragmented interfaces (a "Proof Agent Interface Protocol" is
   floated) and e-graph/equality-saturation integration.
5. **Human-AI collaboration** — the stated ultimate goal is
   amplification, not autonomy: proof copilots, calibrated
   uncertainty in interfaces, explainable proofs over step dumps. The
   First Proof challenge (ten never-published research problems) is
   endorsed as the clean evaluation paradigm.

## Assessment

- **Durable:** the solver-vs-researcher framing and its
  benchmark-exhaustion argument; the Erdős accounting with its
  rediscovery-dominates-novelty finding; the specification-fidelity
  examples (Erdős #124 will be the standard citation); the SMT-vs-CAS
  verification-gap distinction.
- **Era-bound:** the SOTA tables (half the entries are 2025 technical
  reports), the tool roster, and the Erdős counts, explicitly a moving
  target.
- **Weaknesses:** the taxonomy chapters are citation floods with little
  editorial judgment (contrast [[weng2026-harness]]'s opinionated
  mapping of its field); the roadmap items vary widely in concreteness
  (knowledge-graph and concept-invention sections are aspiration, not
  mechanism); minor dating inconsistency between Table 6 (January) and
  Fig. 6 (April); and the paper predates the August 2026 ten-advances
  announcement — its snapshot stops just before the field's loudest
  claim, which its caveats section reads as written for.

## Relations in this library

- [[openai2026-math-advances]] — this survey supplies
  the evaluative frame the announcement lacks: rediscovery
  accounting, specification-fidelity checking, and selection-bias
  caveats are exactly the questions to ask of the ten claims (and
  the announcement's Lean-certificate move answers only the
  compilation half).
- [[demoura2026-kernel-soundness]] — complementary
  trust layers: kernel soundness below, statement fidelity above.
  Together they bound what "machine-checked" actually certifies.
- [[liu2026-agent-taxonomy]] — the research-agent
  ambition is liu's loop-closing-on-science, and the paper's
  AlphaEvolve critique (score functions bound exploration) sharpens
  why artifact-loop evolution alone doesn't reach discovery.
- [[gao2025-self-evolving-survey]] — genre sibling;
  both surveys' strongest chapters are their evaluation critiques
  (episodic reset there, benchmark saturation and specification
  fidelity here).
