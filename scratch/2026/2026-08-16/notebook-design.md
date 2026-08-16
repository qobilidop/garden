---
author: Claude Fable 5
---

# Notebook design

Design session, 2026-08-16, third thread of the day (after the
knowledge-layer redesign and the capture/collab surveys). Deepens
notebook/ from charter to concrete conventions. Settled unless marked
open.

## The library definition (settled — promote to AGENTS.md)

> **library/ holds works: bounded, attributable, dated artifacts,
> external to this system, captured with provenance.**

Every clause load-bearing: *bounded* excludes streams and containers
(ingest the episode, never "the podcast"; the post, never "the
blog"); *attributable* + *dated* give identity; *external* excludes
the system's own products (though Bili's own independently published
works pass); *captured with provenance* separates an entry from a
bookmark.

Closure with citekeys: a citekey needs exactly author + year +
nameable identity — the *attributable*, *dated*, *bounded* clauses.
"Belongs in library/" and "can construct a citekey" are the same
test; both operationalize work-ness. Citekeys therefore cover books,
podcasts (per-episode), talks, interviews — the library already holds
the hard cases (org-authored: anthropic2026-riemann-zeta; episodic
series: the lattner2025-* interviews; canonicalized social posts:
karpathy2026-llm-wiki). Small conventions to rule at first instance:
undated works (use retrieval year), unclear author (org/venue),
series-vs-episode (episodes only). Living references (docs sites,
dashboards) fail *bounded* and stay URLs in notes; when a version
matters, ingest a dated snapshot as a work.

## Format (settled)

Markdown, extended only at sanctioned extension points — frontmatter,
wikilink conventions, remark plugins/directives — never invented
syntax. Every extension must degrade gracefully in vanilla renderers
(e.g. future transclusion `![[id]]` degrades to a visible link).
Deliberate anti-Forester call: no custom markup lock-in; content is
the durable layer. Math/code/diagrams/backlinks all come from
existing site machinery (KaTeX, Mermaid, wikilink resolver).

## Entry identity (settled shape; base open)

- Atomic notes, flat dir, sequential IDs as filenames. Sequential
  (not random) because notebook has exactly one writer — the voice
  rule excludes agents, and phone capture targets scratch, not
  notebook. Mint = max+1.
- **Open: decimal vs hexadecimal 4-digit.** Discussion leaned decimal
  (IDs will be spoken — "note 42"; hex doesn't announce its base);
  Bili leans hex on taste. Small stakes; his call; record the base in
  the convention.
- IDs are never reused; gaps are history.
- Flat dir stays flat until a surface actually breaks (first likely:
  GitHub web UI's 1,000-file listing truncation, years away); then
  shard mechanically by ID prefix — zero human categorization, links
  unaffected (links target IDs, not paths).

## Link namespace (settled)

`[[note-{id}]]`, `[[wiki-{slug}]]`, `[[citekey]]` — governed by one
principle: **the prefix marks the system boundary.** Prefixed =
internal coinage (this system's own namespaces); bare = external
identity (a work in the world). Link syntax thereby encodes the
evidence architecture: bare links cite the world, prefixed links
navigate the system. Future internal spaces slot in (`survey-…`).

- Strict grammar: `note-` + exactly the ID pattern, so slugs like a
  hypothetical `wiki-note-taking` page can never misparse.
- Rendering resolves to titles; raw text keeps the type signal.
- The resolver enforces global uniqueness and fails the build on
  unresolved or ambiguous targets (already true).
- **Scratch is outside the link graph** — it expires at reseed, so
  durable layers never link into it (links into an expiring layer are
  dead links by design; the site doesn't render scratch anyway).
  Scratch may use `[[…]]` informally, unresolved; pointers out of
  scratch into durable layers are the distill direction.

## Reading experience (direction settled, build later)

Target UX: Andy Matuschak-style **sliding panes / stacked notes**
(notes.andymatuschak.org; author already in the library —
matuschak2019-tools-thought). Cross-section by design: a trail like
note → wiki page → library note makes the pane stack literally an
evidence trail — rightward motion descends evidence-flows-up, with
each claim's support one pane over.

- Panes are the reading mode for the link-graph layers (notebook,
  wiki, library notes); survey manuscripts and landings stay
  conventional pages; home launches into the graph.
- Each pane carries a lane badge (note / wiki / library) — the
  per-page authorship declaration promoted into navigation chrome,
  derived from which collection the resolver matched.
- Mechanics (own logic, site/src/lib): pages keep canonical
  standalone URLs; client script intercepts internal links, fetches
  content fragments, appends panes; trail encoded as
  `?stack=…` (shareable); no-JS and mobile degrade to ordinary
  navigation.

## Authoring tooling (deferred, order fixed)

Plain md in VSCode now. Rent **Foam** (wikilink completion,
backlinks, graph) before writing anything custom — maintenance
status unverified, check before adopting. The personal VSCode
extension comes later, defined by where Foam chafes: ID minting
command, title-resolving hover/completion for opaque links,
rename-safe workflows. Publishing = notebook joins
site content collections; panes are a separate later project.

## Execution queue (supersedes earlier queue items on notebook)

1. Create notebook/ + AGENTS.md conventions in one change: voice
   rule, epistemic-status line, ID scheme (base decided), link
   namespace + boundary principle, scratch-outside-graph rule,
   **library definition** (its section), evidence-basis convention.
2. Add notebook collection to the site (plain pages first).
3. Foam trial; friction list for the eventual extension.
4. Sliding panes as its own site project when notebook has enough
   pages to make trails real.
