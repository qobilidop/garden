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
  own header). Record both identities when so.
- Download only from immutable URLs: pin the arXiv version
  (`arxiv.org/pdf/<id>v<N>`, never the bare `/pdf/<id>` pointer). Verify the
  download is the right work by opening it, not by filename.

## 2. Citekey

`<lowercase-first-author-surname><year>-<slug>`. Slug precedence, first
match wins:

1. The canonical URL's slug, when the work is web-native and the URL ends
   in readable words (not an id, date, or hash) — the author's own
   compression of their title. Take the shorter of URL slug and title form.
   Example: `openai2026-ten-advances-in-mathematics`.
2. The kebab-cased title, truncated at the first colon. Example:
   `gao2025-a-survey-of-self-evolving-agents`.

Normalize candidates before comparing: strip leading date prefixes from
URL slugs (`2026-07-04-harness` → `harness`) and trailing reference
identifiers from titles (issue numbers like `#14576`, version tags, bare
numbers) — those stay in `work.title`; restore one to the slug only to
break a collision.

The citekey determines every path below; no lookup tables.

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
  date: <publication date>
  doi: <doi if one exists>          # identifies the work — lives here, not under sources
  arxiv: <id vN + note> (if applicable)
sources:
  pdf:  # → store
    url: <immutable download url>
    archived: <wayback snapshot url>
  html: # → shadow snapshot (when a web-native source exists)
    url: <page url>
    archived: <wayback snapshot url>
retrieved: <today>
notes-by: <agent name + model, or human name>
notes-date: <today>
---
```

Every source gets an `archived` Wayback URL — public verifiability for a
public repo (check `https://archive.org/wayback/available?url=<url>`).
Immutable blobs (published PDFs, versioned arXiv URLs): any existing
snapshot suffices. Mutable pages (HTML): the snapshot must be no older than
`retrieved`, else trigger `https://web.archive.org/save/<url>`.

`tools/capture.sh --blob|--page <url> <dest>` runs the mechanical tier —
fetch, availability, gzip-aware `id_` verification, SPN trigger — and
reports JSON (exit 2 = no verified record; fall back manually).

Archive fallbacks, in order, when SPN won't cooperate (523/429 overload,
302s that never materialize):

1. An existing snapshot verified identical to the capture — fetch the
   `id_` record (`web.archive.org/web/<ts>id_/<url>`; the response may be
   gzipped, decompress before comparing).
2. For a versioned arXiv URL with no snapshot of its own: a bare-pointer
   snapshot captured while it served that version, verified
   sha256-identical to the download, recorded with a frontmatter comment.
3. When the publisher gates the version-of-record itself (OpenReview
   challenge pages block curl and WebFetch): fetch the blob from a
   Wayback `id_` record.

Never record an `archived:` URL that wasn't verified against the
artifact.

## 5. Synthesis notes

- Read the shadow text form (transcript/snapshot), not the PDF — that is
  what it exists for. For long works, navigate by heading structure and read
  targeted slices; do not skip the parts a fair assessment needs.
- Write transformation, not compression: what someone who understood the
  paper would say, never a condensed transcript. A note writable only with
  the source open belongs in shadow, not here.
- Quality bar (keshav2007, which this library ingested): the frontmatter
  plus opening paragraph should answer the five Cs (category, context,
  correctness, contributions, clarity); the notes should let a reader
  reconstruct the paper's structure and judge its strong and weak points
  without opening the blob. Include an honest assessment section — what is
  durable, what is era-bound or overclaimed.
- Attribution: one living notes file per author, updated on reread — no
  dated copies. Agent synthesis is `notes.md` with `notes-by` naming agent +
  model. Human notes are `notes-<name>.md`, created only when distilled
  content exists.
- Writeback: update the `wiki/` topic pages this work touches
  (AGENTS.md §Wiki).
- Before proposing commits, self-review the notes against the source:
  every attribution (who did what) and number re-checked, and every
  criticism verified as carefully as a claim.

## 6. Close

- `tools/store.sh push` — uploads the blob and regenerates
  `shadow/store.manifest.json` (explicit copy only; nothing deletes).
- Verify all tiers exist at the citekey paths, then propose the two commits
  (sys: notes; shadow: text form + manifest), each ending with the agent's
  attribution trailer (`Co-Authored-By: <agent + model> <email>`). Commit
  only on the user's word.
