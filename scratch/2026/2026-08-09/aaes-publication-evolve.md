---
author: Codex GPT-5.6 Sol
---

# Survey publication and landing contracts — /evolve outcomes

This retrospective followed the publication-readiness revision of the
agent-assisted-evidence-synthesis survey, its comparison with the
dataflow-selection-enumeration reference, and the user's final landing-page
corrections. The user approved every proposal.

## Evidence reviewed

- The run-survey skill required a count-heavy landing summary, inline metadata
  rows, a searched-through date, and a topic wikilink. DSE already used a
  content-centered `Summary`, three-link `Links` section, and `Reading list`;
  the user explicitly asked AAES to adopt that style and then replaced its
  record-number summary with a synopsis of the survey's contents.
- Both reference surveys are reviewed and ready for author approval while
  explicitly making no bounded mapping-closure claim. Their unresolved rows
  are disclosed as coverage state rather than hidden or treated as a
  publication blocker.
- The user asked author notes to name each material system compactly with its
  highest version, without a run chronology. Both metadata files now identify
  product families through their highest used version, while DSE's
  method section still duplicated the identities and assistance scopes.
- The shared source-note template still directed local deviations to an old
  README Shape note even though the skill and both references put those choices
  in `protocol.md`.

## Applied

1. **Content-centered landing pages.** `run-survey` now specifies H1, Summary,
   Links, and Reading list. The summary owns subject and synthesis; status owns
   record counts, coverage date, and closure state. The shared validator checks
   the structural headings and the ordered HTML/PDF/record links. AAES's stale
   instruction to copy counts into the landing page was removed.
2. **Publication is not mapping closure.** The skill now separates a reviewed,
   defensible dated snapshot from the stronger optional bounded-closure claim.
   Status files carry distinct publication and coverage states, enforced by the
   shared validator; the existing no-add and all-dispositions checklist applies
   only when making a mapping-closure claim.
3. **Concise, complete model disclosure.** The author note names each materially
   contributing product family once, through the highest version used, with a
   truthful family-level scope and no run chronology. Material model
   differences remain individually named when aggregation would misattribute
   work. Incidental calls remain procedure or provenance. The duplicated DSE
   method disclosure was reduced to procedure-specific facts and a pointer to
   the title note.
4. **Subtraction.** The obsolete README Shape-note instruction was replaced by
   the protocol-based rule already used by both references.

## Verification

- Independent spec-to-instance and instance-to-spec audits agreed on the four
  changes and surfaced the reference-instance and contract residues corrected
  here.
- Both survey validators pass with the new landing and status guards.
- The shared validator compiles, the skill remains below its size budget, and
  the manuscript builder passes after the DSE disclosure edit.
- Git history proved the model attribution for six DSE publication-review
  notes; those `notes-by` values now name Codex GPT-5.6 Sol.

## Staged, not promoted

- DSE's initial-campaign source-note `notes-by` fields name Codex without an
  exact model. The local protocol now marks those values as legacy provenance;
  recovering exact models remains a separate migration to perform only where
  history proves the attribution, never by guessing.
- Both references state prose-ledger ownership clearly and fully grade their
  evidence records. No new rule was added: canonical ownership is already a
  project convention, and no partial-certainty failure occurred in this
  session.

## Rejected

None.
