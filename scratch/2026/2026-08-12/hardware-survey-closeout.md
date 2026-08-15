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

## Adversarial repair must preserve the survey shape

Two rounds of reviewer work drifted toward new provenance ledgers and an
oversized local checker. The user twice redirected the work to the established
survey convention and asked for a file-by-file comparison with existing
surveys. `run-survey` now requires that comparison against both reference
implementations and adds a convention-auditor role. A divergence is either
locally justified or codified with its checks before migration. This adds some
friction to a genuinely better structure, but the explicit codify-and-validate
escape hatch preserves that path.

The same closeout also confirmed two rules already promoted during the
campaign: survey-specific source notes remain local even when a general note
exists, linked through `canonical-note`; and corrective provenance stays in
the catalog/log spine unless a new file owns genuinely different data.

## Table headers are artifact semantics

The long corpus table looked valid in Typst but lost its header on the
continuation PDF page, while three visually bold HTML header rows were emitted
as `<td>` cells. Both survived source-level and build checks. The final artifact
gate now checks repeated PDF headers and semantic HTML `<th>` cells, and the
Typst reference records the working pattern. Small decorative tables are not
forced to paginate; the rule applies when a changed table spans pages.

As a subtraction, the same evolution removed a duplicated screening-vocabulary
fragment from `run-survey`; it carried no distinct rule.

## The reverse audit changed the validator contract

The required instance-to-spec pass found that the first evolve draft described
the visible convention without fully preserving its update semantics. The
shared validator now treats audit partitions and transition fields as
checkpoint facts that later key-bearing audits may supersede; binds origin and
external events through unambiguous composite selectors; verifies delegated
denominators and keys; checks transition intersections and one-row corrections;
and exposes audit-group, addition-batch, and query-registry quantities for
publication-surface checks. The hardware checker now binds all live corpus,
search, note, evidence, repair, and facet counts wherever they are published.

The audit also resolved smaller specification gaps: count-only surveys have an
explicit optional-ledger configuration; mapping-depth evidence has a declared
altitude; all log markers and RFC 4180 parsing live in one reference; exact
rationale uniqueness is narrowly forensic; and `canonical-note` links are
checked for work identity. One missing key in a delegated Sylvia bibliography
was added to the local catalog as an excluded boundary comparator, making the
external key-level binding real rather than merely asserted.

A second reverse pass found that a regex can appear delimiter-aware while
consuming the separator needed to find the next repeated marker. Marker parsing
now uses a non-consuming boundary, malformed marker-shaped text fails unless a
named append-only repair supersedes it, and the reference surveys exercise that
repair path. A final mutation-oriented pass further required the target to be
demonstrably malformed, the repair to reproduce its exact disposition keys,
and only transitions *later* than an event to supersede that event's decision.
The same pass separated an audit's rescreen denominator from its
catalog-addition count, removed unneeded procedural numerals from presentation,
and made cross-survey note identity registrar-first rather than citekey-first.

All proposals in both passes were approved. No proposal was rejected, and no
user memory or global rule was added because the lessons are local to the
survey and site workflows.
