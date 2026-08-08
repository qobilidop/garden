---
author: Claude Fable 5
---

# posts pipeline session reflection

2026-08-07, second session. Written by Claude Fable 5 at Bili's request,
closing the session that built the library's second content type: the
posts category designed and defended, four posts ingested across four
hostile-to-friendly source types, the frontmatter schema converged
through challenge, the citekey rule generalized twice, and ingest-post
distilled from the evidence of its own four runs.

## Principles that emerged

- **Categories cut by publication kind, not platform or format.** "Posts"
  survived the too-broad challenge because blog posts, org announcements,
  and Q&A answers share what drives the pipeline: informally published,
  web-native, no version-of-record, snapshot-is-the-record. The real
  fault line — single-author work vs. multi-author thread — was named up
  front and deferred until an instance arrives.
- **Refine rules so the corpus is already conformant.** All three citekey
  refinements (prefer URL slug, strip trailing identifiers, strip date
  prefixes) were designed so every committed key minted identically under
  the new rule. Grandfathering-free refinement makes evolution cheap; a
  rule that forces migration needs a much higher bar.
- **Schemas converge by challenge-and-concede.** venue, sources-nesting,
  self-explanatory comments, and platform-specific fields all fell to "is
  X necessary?"; discussions, date annotations, and the quality bar were
  added by the same scrutiny. Draft minimal and expect every field to
  earn its place — upgrading singular→plural later is a mechanical
  rename, paid only when evidence arrives.
- **The open web now assumes you are a bot.** Of four sources: one hard
  403'd every non-browser client (openai.com), Reddit's anonymous JSON is
  dead, X has no free read path at all, and even Wayback's save endpoint
  was unreachable from the sandbox. The capture pipeline works anyway
  because of two fallbacks — the archive's original-content record
  (`id_` URLs) verified byte-identical or live-verified through the
  user's browser session, which is the universal key: it is the one
  client origins cannot distinguish from the user.
- **Chronology is reconstructable from identifiers.** X snowflake IDs,
  Reddit epoch fields, and HN's API let a discussion timeline be computed
  rather than remembered — which also surfaced reception dynamics (the
  announcement→reddit-wave→HN-repost pattern; Weng's HN thread arriving a
  month after the post).
- **Reading the library before writing notes compounds.** The
  cross-links wrote themselves: Liu names the harness level, Weng maps
  it; OpenAI's trust story leans on Lean certificates, de Moura's
  postmortem prices the residual risk. Four entries already behave like a
  library rather than a pile.

## Errors worth remembering

- **Tier dirs created inside the wrong root** (shadow/shadow/): mkdir ran
  with cwd already inside the shadow repo. Worse, the cleanup silently
  failed — `rm -ri ... 2>/dev/null || rm -rf ...` let the interactive rm
  consume EOF, decline every prompt, and still exit 0, so the fallback
  never ran; git status showed clean because git ignores empty dirs. The
  user found it. Verify deletions by listing the target, never by exit
  code — and never run interactive commands in a non-interactive shell.
- **Two synthesis errors caught only by self-review against the
  source**: a parenthetical conflated FARS's paper run with Recursive's
  kernel search, and an assessment criticized "unflagged self-citations"
  the post had in fact flagged ("our previous work"). Verify criticisms
  as carefully as claims; re-read the source before committing notes.
- **Ambiguous feedback guessed wrong**: "this link is wrong" was read as
  broken-URL (and fixed with slugs) when it meant wrong-inclusion. The
  artifact check was right; asserting one interpretation instead of
  surfacing both cost a round trip.

## Open threads

- First multi-author thread-as-work ingestion will test the posts
  boundary (new category vs. per-case judgment).
- Reddit/X access rides the user's browser session and is therefore
  interactive-only; a Reddit OAuth app + small tool is the headless path
  if scheduled ingestion ever wants it.
- The Lean Zulip thread for demoura2026 exists but wasn't
  URL-addressable from outside; Zulip as a discussion venue remains
  unsolved.
- ingest-paper and ingest-post now share the citekey rule by
  cross-reference; a third content type would justify extracting the
  shared core.
