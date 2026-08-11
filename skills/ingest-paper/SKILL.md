---
name: ingest-paper
description: Ingest a research paper into the sys library — canonical PDF to the Drive store, mechanical transcript to shadow, author-labeled synthesis notes to sys. Use when asked to ingest, add, or capture a paper (given a URL, DOI, arXiv id, or title) into the library. For informal web-native writing (blog posts, announcements, Q&A answers), use ingest-post instead.
compatibility: "Requires the sys repo with its private shadow/ checkout, an rclone store: remote, and network access; ./dev.sh supplies pinned tools (rclone, pymupdf4llm) when the host lacks them."
---

# Ingest a paper

Work from the sys repo root. Requires the private `shadow/` checkout and an
rclone `store:` remote; `./dev.sh <cmd>` provides the pinned toolchain
(rclone, pymupdf4llm) when the host lacks it.

## 1. Resolve the work

- Gather metadata: title, first-author surname, year of first public
  appearance, venue, DOI. Verify against Crossref
  (`https://api.crossref.org/works/<doi>`) or the arXiv abs page — never
  trust memory for bibliographic facts.
- Find the version-of-record. An arXiv paper may have been published at a
  venue: the latest arXiv revision is often the camera-ready (check the PDF's
  own header). Record both identities when so. Co-published works (common
  for medical statements — PRISMA appeared in five journals at once): one
  entry, the most-cited DOI primary, capture whichever co-publication is
  accessible, and comment the mapping in frontmatter.
- Locate the PDF via the OA resolvers before hand-probing hosts: Unpaywall
  (`api.unpaywall.org/v2/<doi>?email=<contact>`) returns the best legal
  open-access location or confirms there is none; OpenAlex
  (`api.openalex.org/works/doi:<doi>`, `best_oa_location`) is the
  cross-check. One call replaces the publisher-mirror tour. A
  confirmed-closed answer is a real result: use a verified existing Wayback
  capture as an acquisition fallback or record a queue item instead of
  searching mirrors. When a resolver identifies a legal OA PDF but the host
  serves a bot or JavaScript challenge, make one bounded fallback through an
  official author or institution publication index and follow the exact PDF
  link found there — never guess filenames. Verify its title, authors, DOI or
  venue identity, and PDF header against the registrar record, and note
  author-copy versus version-of-record provenance in frontmatter. If that
  check fails, use an existing verified archive or the queue. Never request
  or wait for a new archive capture during ingestion (`AGENTS.md` §Library).
  The queue is
  `library/queue.md` (one line per work: what it is and what it
  would feed; ingesting removes the line, and identifiers there are
  pointers to verify, not bibliography). (Learned
  2026-08-08: PRISMA/Petersen hunting cost ~6 min that Unpaywall answers
  in seconds.)
- Download only from version-pinned or version-specific URLs: pin the arXiv
  version (`arxiv.org/pdf/<id>v<N>`, never the bare `/pdf/<id>` pointer), or
  use the stable named file linked by an official publication index. Verify
  the download is the right work by opening it, not by filename.

## 2. Citekey

`<lowercase-first-author-surname><year>-<short-label>`. The complete citekey is
at most 28 characters; the label is at most three hyphen-separated tokens.
Choose it in this order:

1. The work's established name or acronym, when one exists: `alphageometry`,
   `alphaproof`, `gpt-f`, `prisma`, `ace`.
2. A concise canonical URL slug, when it names the work rather than an id,
   date, or generic page type: `harness`, `scaling-laws`.
3. One to three distinctive title words, using only what earns its space:
   `symbolic`, `screening`, `slr`.

Drop articles and generic framing (`a survey of`, `guidelines for`,
`towards`, `an approach to`). Strip leading dates from URL slugs
(`2026-07-04-harness` → `harness`) and keep issue numbers, versions, and bare
reference identifiers in `work.title`, not the label. If the candidate
collides, add or replace one meaningful distinguishing word while staying
within the limits; never append an arbitrary `a`/`b`.

The citekey is stable after ingestion and determines every path below; no
lookup tables. The site checks its shape, full length, token count,
path/frontmatter agreement, and uniqueness. Label choice remains a human
judgment.

## 3. Capture to tiers

- **Blob → store**:
  `shadow/store/library/papers/<year>/<citekey>/<citekey>.pdf`
- **Text form → shadow** (always — cheap rereads and grep for every future
  session):
  - PDF source: `tools/transcribe.sh library/papers/<year>/<citekey>/<citekey>.pdf`
    → mechanical markdown transcript at the mirrored shadow path. Never
    retype or "clean up" a transcript by hand — fidelity must be a property
    of the toolchain, not of an agent's transcription.
  - Web-native source (HTML transcription, blog-hosted text): save the page
    as-found into `shadow/library/papers/<year>/<citekey>/` with a
    descriptive `-snapshot.html` name. Derived conversions may be added, but
    never stored instead of the raw capture.
- **Synthesis → sys**: `library/papers/<year>/<citekey>/notes.md` (step 5).

## 4. Provenance frontmatter

`notes.md` opens with:

```yaml
---
citekey: <citekey>
work:
  title: <full title>
  author: <authors; "First Author et al. (N authors)" when many>
  venue: <venue, volume/pages if applicable>
  date: <publication date — ISO to known precision: YYYY[-MM[-DD]]; never invent finer parts>
  doi: <doi if one exists>          # identifies the work — lives here, not under sources
  arxiv: <id vN + note> (if applicable)
sources:
  pdf: <immutable download url>  # → store
  html: <page url>               # → shadow snapshot (when a web-native source exists)
  record: <landing page url>     # bibliographic identity only; no capture tier implied
retrieved: <today>
notes-by: <agent name + model, or human name>
notes-date: <today>
synthesis: <the notes' one-sentence take, when they have one>
---
```

Run `tools/capture.sh <url> <dest>` for the mechanical fetch and SHA-256
record. If the origin is already inaccessible, an existing Wayback `id_`
record may supply the artifact only after content or byte verification; note
that acquisition fallback in frontmatter. Archive coverage itself is
external derived state governed by `AGENTS.md` §Library; no `archived:` field
is stored here.

## 5. Synthesis notes

- The H1 is `work.title` verbatim — no prefix, no shortened display
  names; community names (AlphaProof) belong in prose and the
  `synthesis:` line, not the title. `synthesis:` distills the notes'
  argument to one sentence when they have one (the site catalog
  surfaces it); omit it for works merely cataloged.
- Read the shadow text form (transcript/snapshot), not the PDF — that is
  what it exists for. For long works, index headings and figure/table captions
  first, then build a bounded evidence pack from the abstract and framing,
  method core, main results, limitations, and contributions/conflicts. Keep
  each read below the tool's truncation threshold and expand only where a claim
  remains unsupported; a broad dump that truncates and must be reread is not a
  shortcut. Do not skip the parts a fair assessment needs.
- The transcript carries figure captions, not figures. Before writing
  synthesis, view the load-bearing figures directly from the stored PDF
  (read the pages their captions name) — the synthesis should reflect
  what they show.
- Write transformation, not compression: what someone who understood the
  paper would say, never a condensed transcript. A note writable only with
  the source open belongs in shadow, not here.
- Quality bar (keshav2007, which this library ingested): the frontmatter
  plus opening paragraph should answer the five Cs (category, context,
  correctness, contributions, clarity); the notes should let a reader
  reconstruct the paper's structure and judge its strong and weak points
  without opening the blob. Include an honest assessment section — what is
  durable, what is era-bound or overclaimed — as labeled bullets
  (**Durable:**, **Era-bound:**, **Weaknesses:**/**Caveats:**), not one
  dense paragraph; a closing synthesis line may stay prose.
- Attribution: one living notes file per author, updated on reread — no
  dated copies. Agent synthesis is `notes.md` with `notes-by` naming agent +
  model. Human notes are `notes-<name>.md`, created only when distilled
  content exists.
- Writeback: update the `wiki/` topic pages this work touches
  (skills/tend-wiki).
- Before proposing commits, self-review the notes against the source:
  every attribution (who did what) and number re-checked, and every
  criticism verified as carefully as a claim.

## 6. Close

- `tools/store.sh push` — uploads the blob and regenerates
  `shadow/store.manifest.json` (explicit copy only; nothing deletes).
- Run `node tools/check-ingest.mjs <citekey>` after the push. It reuses the
  site's canonical source parser and checks the fresh notes, transcript,
  local blob, and remote-derived manifest entry and byte size without printing
  the library inventory. `sources.html` always promises a direct, non-empty
  snapshot; use `sources.record` for an uncaptured publisher/DOI landing page.
- The transcript is mechanical output and may contain extraction whitespace.
  Preserve it byte-for-byte. At commit time, stage only the intended shadow
  paths first. Then, with the command's working directory set to the absolute
  shadow-repo path, run:

  ```console
  git diff --cached --check -- . ':(exclude,glob)library/papers/**/transcript.md'
  ```

  Let `check-ingest` verify the transcript tier. Never print its full diff
  merely to review whitespace diagnostics.
- Run `npm --prefix site run build` on the host to close source-schema,
  wikilink, and rendering checks. Then propose the two commits (sys: notes;
  shadow: text form + manifest), each ending with the agent's attribution
  trailer (`Co-Authored-By: <agent + model> <email>`). Commit only on the
  user's word. When the request is only to commit and push, successful pushes
  complete it; wait for Pages and verify live routes only when publication or
  deployment verification is in scope.
