---
author: Codex GPT-5.6 Sol
---

# A survey landing page should age more slowly than its campaign record

The hardware symbolic-execution survey closed with two user corrections to
its landing page. I had placed retrieval dates and corpus counts in the
summary, then used acronym-only or shortened labels for several reading-list
entries. Both choices departed from the established survey pages. The durable
contract is now explicit in `run-survey`: campaign snapshot bookkeeping stays
in the record and manuscript, while reading-list links use full canonical work
titles. Stable per-work years and quantitative findings remain appropriate in
row annotations.

This retrospective also removed an escape hatch. The prior skill allowed a
summary quantity when it seemed substantive, which made mutable corpus size
easy to rationalize as a finding. The revised rule distinguishes campaign
state from stable per-work evidence instead.

## A prose warning that needed an executable boundary

I ran `./dev.sh npm --prefix site run build` even though both `AGENTS.md` and
`tend-site` already documented that container package commands overwrite the
host checkout's native dependencies. The command reproduced the expected
native-binding failure and required a host reinstall. Because this is a known,
recurring trap, `dev.sh` now rejects direct npm, npx, yarn, and pnpm commands
before Docker starts. The existing rule remains the explanation; the guard is
its enforcement.

## Staged, not promoted

A material scope revision in a live survey should trigger three distinct
operations: re-adjudicate the existing catalog, run new boundary-specific
queries, and chase both citation directions for newly critical works. During
this campaign the user had to ask whether new papers had been searched rather
than only reclassified. The completed survey did all three, but one occurrence
does not yet earn another shared workflow rule; retain it here for recurrence.

The Crossref HTML-entity leak was fixed directly in the bibliography generator
and did not need a second prose rule. Browser-specific responsive validation
was unavailable, but the PDF, static site build, CI deployment, and live route
were checked; an unavailable browser backend is environment state rather than
a durable user or project fact.

All three proposed harness changes were approved. No proposal was rejected,
and no user memory or global rule was added because the lessons are local to
the survey and site workflows.
