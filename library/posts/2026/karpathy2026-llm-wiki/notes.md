---
citekey: karpathy2026-llm-wiki
work:
  title: LLM Wiki
  author: Andrej Karpathy
  date: 2026-04-04
source:  # snapshot + pinned-revision raw → shadow; no figures
  url: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
  archived: https://web.archive.org/web/20260806213748/https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
  # snapshot predates retrieved (SPN timing out); article text verified
  # identical to the capture. The gist has exactly one revision
  # (ac46de1, 2026-04-04); the raw file at that sha is also in shadow,
  # archived at
  # https://web.archive.org/web/20260629170211/https://gist.githubusercontent.com/karpathy/442a6bf555914893e9891c11519de94f/raw/ac46de1ad27f92b28ac95459c782c07f6b8c964a/llm-wiki.md
  # (verified byte-identical). Original appearance: the 2026-04-02 X
  # post "LLM Knowledge Bases" (first discussions entry) — the gist is
  # the author's revised canonical form; text capture in shadow.
discussions:
  - https://x.com/karpathy/status/2039805659525644595  # 2026-04-02
  - https://x.com/karpathy/status/2040470801506541998  # 2026-04-04
  - https://news.ycombinator.com/item?id=47640875  # 2026-04-04
  - https://www.reddit.com/r/LocalLLaMA/comments/1sclfs6/  # 2026-04-04
  - https://www.reddit.com/r/OntologyEngineering/comments/1shks1y/  # 2026-04-10
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
---

# Notes: LLM Wiki

A ~12KB single-file gist proposing a pattern for personal knowledge
management with LLM agents: instead of RAG-style retrieval that
rediscovers knowledge on every query, the LLM incrementally compiles
sources into a persistent markdown wiki and keeps it current. It is
deliberately an "idea file" — abstract on purpose, meant to be handed
to the reader's own agent, which instantiates the specifics. The gist
is the author's revised canonicalization of an X post from two days
earlier that had drawn tens of millions of views; category: workflow
pattern from a practitioner's own use, one experience report deep, no
evaluation — its contribution is a crisp reframing and a name, not
evidence.

## The pattern

The reframe: RAG rediscovers, a wiki accumulates. Retrieval-at-query
leaves nothing behind; compilation produces a compounding artifact
where cross-references, flagged contradictions, and synthesis persist
between questions. Three layers with strict ownership: **raw sources**
(immutable, human-curated), **the wiki** (LLM-written and
LLM-maintained; the human reads but doesn't write), and **the schema**
(a CLAUDE.md/AGENTS.md-style conventions document, co-evolved with the
human, that makes the agent a disciplined maintainer). Three
operations: **ingest** (one source touches 10–15 wiki pages), **query**
(answers filed back into the wiki so explorations compound —
the writeback is what makes questions accumulate rather than
evaporate), and **lint** (periodic health checks: contradictions, stale
claims, orphan pages, missing cross-references). Navigation is a
maintained `index.md` plus append-only `log.md` with greppable entry
prefixes — explicitly positioned as sufficient at moderate scale
against embedding infrastructure. Lineage claimed to Bush's Memex, with
the sharp addendum that the Memex's unsolved problem was who does the
maintenance; the LLM is the answer because maintenance cost drops to
near zero, and maintenance burden — not reading or thinking — is why
humans abandon wikis.

## The idea-file form

The second contribution is the publishing form itself. The follow-up X
post frames it: in the agent era there is less need to share code —
share the idea, and the recipient's agent builds a fitted
instance. The gist closes on the same note: everything is optional and
modular, and the document's job is only to communicate the pattern.
This makes the work a prompt as much as a post — a genre the library
may see more of.

## Original vs. gist

The 2026-04-02 X original (captured in shadow alongside the snapshot)
carries details the gist dropped: the one scale datapoint (a research
wiki of ~100 articles / ~400K words holding up without dedicated RAG),
a further-explorations section on synthetic data and finetuning the
wiki into weights, and a closing claim that the pattern deserves a real
product. The gist adds the business/team use case, the Tolkien Gateway
analogy, the qmd search tool pointer, and the Memex framing. Neither
supersedes the other cleanly; the gist is the canonical statement, the
tweet the more concrete report.

## Reception

At capture: 21.7M views on the original post, 7.2M on the follow-up;
the HN thread (296 points, 95 comments) landed within the hour of the
gist's publication. The derivative wave was immediate — the HN sweep shows
implementation Show-HNs within days and steadily since (one hit 260
points by late April), and communities read the pattern into their own
frames (the r/OntologyEngineering thread claims it as convergent
ontology engineering — markdown instead of OWL). The pattern's names
("LLM wiki", "idea file") circulated detached from the text, which is
exactly the decay mode this library guards against by capturing the
record.

## Assessment

- **Durable:** the compile-vs-retrieve distinction; writeback of
  answers; lint as a named maintenance ritual; the schema as co-evolved
  configuration; the maintenance-cost explanation for why personal
  wikis historically die. These are structural claims, not tool claims.
- **Era-bound:** the Obsidian/Marp/Dataview/qmd specifics, and the
  no-RAG-needed position, which the author himself scopes to small
  scale and one wiki.
- **Unverified:** every workflow claim is a single practitioner's
  self-report — persuasive, uncheckable from the record.

The deliberate abstraction is honest about being untestable: there is
no method here to fail, only a shape to instantiate.

## Relations in this library

- [[zhang2025-agentic-context-engineering]] — same instinct (compile
  experience into a persistent, incrementally-updated artifact rather
  than re-derive), but ACE's warning applies: updates without a
  reliable feedback signal degrade. The wiki's implicit feedback is the
  human reading every page in Obsidian; unsupervised batch-ingest
  weakens exactly that check.
- [[vincent2026-the-therapist-pattern]] — the ownership split is the
  same: the LLM is the designated writer to a versioned surface, the
  human directs. Karpathy's rule that the human rarely edits the wiki
  directly is that pattern at wiki scale.
- [[weng2026-harness]] — the schema document is harness: configuration
  co-evolved with use, doing for wiki maintenance what harness
  engineering does for task execution.
- [[wang2023-voyager]] — the earliest library entry with a compiled,
  persistent, retrieval-indexed artifact of accumulated capability;
  the wiki generalizes the skill library from procedures to knowledge.
- This repo's own library is a sibling instantiation that predates the
  ingestion of this work: immutable captures in shadow (raw layer),
  synthesis notes in sys (wiki layer), skills and AGENTS.md as the
  schema layer, with provenance and verification conventions the gist
  leaves to the reader.
