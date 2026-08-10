---
name: tend-wiki
description: Steward the wiki/ topic layer — decide when accumulated library material earns a new page, weave newly ingested works into the pages they touch, and reshape pages whose titles no longer name their argument. Use for ingestion writebacks, when asked to update or tend the wiki, or when library notes have accumulated enough cross-work material to synthesize a new page.
---

# Tend the wiki

The constitution is AGENTS.md §Wiki: flat living topic pages distilling
the library across works, agent-written and human-directed, citing works
by `[[citekey]]`, no index, no per-page frontmatter. This skill is the
craft on top of it. The layer's own theory is in the library —
[[karpathy2026-llm-wiki]] (the compiled layer over raw sources) and
[[luhmann1981-slip-boxes]] (the store must surprise;
below critical mass it is a mere container).

## When a page exists

- A page is a cross-work argument, never a single work's summary — that
  is what `library/.../notes.md` is for. The threshold test: can you
  state two or more section-level theses that each need multiple
  citekeys to argue? If not, the material keeps accreting in notes
  files until it can.
- Cite only ingested works — every `[[citekey]]` resolves in
  `library/`. A work worth citing that isn't ingested is an ingestion
  queue item, not a dangling link.
- Surveys join the wiki from the other side: each survey landing page
  carries `**Topic context:** [[<topic>]]`, so the topic page a
  survey cites should acknowledge the survey (`[[<survey-slug>]]`)
  where its findings bear on the argument — the join is two-way.

## Page anatomy

- Titles and headings are sentence case, proper nouns keeping their
  canonical casing ("AI for mathematics", never "AI for Mathematics") —
  the wiki convention (Wikipedia MOS): capitals then carry information,
  and titles read as prose when linked inline.
- H1 names the topic. The opening paragraph defines it in one or two
  sentences, then gives the shelf: every cited work as `[[citekey]]`
  with a parenthetical role — what part it plays on this page ("the
  field map", "the founding exemplar"), not its title restated.
- H2 sections are theses, not categories: "Craft is scheduled, not
  trait-based", never "Overview" or "Related work". Each section argues
  across works; a work may appear in several sections, doing different
  work in each.
- A closing section may hold what the argument leaves open — questions
  future ingestions should answer — and, where honest, the local
  instantiation: how this repository itself runs the pattern, citing
  only what the repo shows (public-repo rule).

## Writeback (per ingested work)

- Reread the page before touching it. Place the new work at the exact
  points it bears: extend the sentence, or rewrite the passage when the
  work changes the story — never an appended "recent additions" block,
  and never a new section unless the work genuinely opens a new thesis.
- Update the shelf with the work's role. Resolve open questions the
  work answers; add the ones it raises.
- When a work touches no existing page and cannot yet anchor a new one,
  the writeback is legitimately empty — say so rather than forcing a
  mention.

## Writing bar

- Transformation, not compression: a section must say something no
  single cited work says — the relations are the content
  ([[luhmann1981-slip-boxes]]'s surprise criterion
  is the layer's standing test). A paragraph that reads as serial
  per-work summaries fails it.
- Source from the works' notes files; open the shadow transcript only
  when the notes can't support the claim being written — and then fix
  the notes too, since they failed their reconstruction bar.
- State disagreements between works as disagreements; smoothing them
  into consensus destroys exactly the information the page exists to
  hold.

## Reshaping

- Rename when the H1 no longer names what the page argues; split when
  one section's shelf could sustain its own page by the threshold test
  above. Flat namespace, git carries history — no redirects or stubs.
- Fix inbound `[[citekey]]`-style references only where they exist;
  pages cite works, so reshaping rarely breaks links.

## Close

- Self-review every changed claim against the cited work's notes, with
  the same care for criticisms as for claims.
- Wiki edits ride the ingestion commit when part of a writeback;
  standalone tending gets its own commit. Commits are human-gated and
  end with the agent's attribution trailer.
