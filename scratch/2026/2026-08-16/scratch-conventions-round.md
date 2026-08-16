---
author: Claude Fable 5
---

# Scratch conventions round

Fourth thread of 2026-08-16, after the notebook design round. Revisited
scratch/ structure, tested a claim empirically, and restructured where
the conventions live. Changes in this round are executed, not queued.

## Structure: no sharding, no new metadata

- Measured before opining: 20 day-dirs, 50 notes in 2026; busiest day
  9 files. No surface near breaking (first would be GitHub's
  1,000-entry listing truncation). Keep `{yyyy}/{yyyy-mm-dd}/`; if
  sharding is ever needed, `{yyyy}/{mm}/{yyyy-mm-dd}/` — the
  full-date leaf stays because paths are quoted out of context and
  the date must survive alone (agent search: unique greppable leaf).
  `{yyyy}/{mm}/{dd}/` rejected.
- No `date:` frontmatter (duplicates the path — two files that must
  agree), no created/updated timestamps (git is canonical, and scratch
  is the one layer where git metadata is safe by construction: notes
  and their history expire together at reseed).

## The ordering test

Claim tested: intra-day note order is recoverable from prose. Blind
protocol — order the nine 2026-08-08 notes from prose alone, then
check git. Result 9/9 correct, but the win came entirely from
dependency structure (X uses what Y created: first-ever /evolve,
skill v1 before v2 before pin-removal), while the explicit temporal
phrases were unreliable ("evening" was 13:27–14:18; "second /evolve
of the day" undercounted). Refinement now in scratch/AGENTS.md:
state dependencies, not clock words. Bonus findings: the adversarial
review note committed at 08-09 00:01 while living in the 08-08 dir —
capture-date convention behaving correctly, and a case where a
cross-validating date field would have flagged a false positive; the
1,291-work campaign ran in the ~2h between 14:18 and 16:25.

Timezone side-question: git stores epoch + recorded offset; repo
history shows -0700/-0800 seasonal split (484/31) = US Pacific
inferable, plus 42 +0000 commits — the 2026-08-04 absorbed-survey
manuscript push from a UTC-clocked environment. Offset records the
machine, not the person. Bili explicitly fine with the disclosure.

## Conventions restructure (executed this round)

- **scratch/AGENTS.md** now carries the layer's conventions, with a
  `CLAUDE.md` `@AGENTS.md` shim. Root AGENTS.md's Scratch section
  replaced by a Layer contracts section with the dispatch rule.
  Mechanics verified against current docs (v2.1.233): Claude Code has
  no native AGENTS.md discovery ("reads CLAUDE.md, not AGENTS.md");
  nested CLAUDE.md loads on *reads* in the directory, write-first
  ordering undocumented; imports expand at load time. Hence the
  dispatch rule at root is the mechanism for the write path (and for
  Codex's cwd-chain walk, and for subagents, which inherit nothing);
  on-demand loading covers readers as a bonus.
- **author: frontmatter now required for every scratch note,
  including Bili's** (`author: Bili Dong`). Rationale: the
  absence-means-Bili convention failed silently (a forgotten field =
  misattribution); a required field fails loudly. Migration cost was
  zero — all 50 existing notes already carried the field.
- **hooks/lint.sh** added (convention lint, charter-separate from
  check.sh's leak guard), chained in pre-commit. Whole-tree check, so
  merge commits can't smuggle violations past it. Enforcement
  verified by outcome: injected violation → exit 1, cleaned → exit 0.

## Still open at round close

- Notebook ID base: decimal vs hex — Bili's call, pending.
- Notebook creation change (notebook/AGENTS.md joins the layer
  contracts; carries the library definition and link namespace per
  notebook-design.md).
- Phone-capture thread parked OPEN (its own note).
