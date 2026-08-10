---
author: Codex GPT-5.6 Sol
---

# Dataflow survey readability — /evolve outcomes

## Evidence reviewed

- The readability revision in commit `912e067` separated base semantics from
  compositional extensions, moved cross-literature synthesis after the
  algorithmic treatment, added notation and parameter lookup tables, and
  split dense tables instead of shrinking their type.
- The dataflow survey exposed a brittle rendered-section pointer in the
  theory-mode guidance.
- Comparing the dataflow survey with the agent-assisted evidence-synthesis
  survey exposed duplicated accountability and assistance disclosures between
  title-page author notes and method prose.

## Applied

1. Theory-mode guidance now points to stable named section handles rather than
   rendered section numbers. This removes coordinates that drift when the
   manuscript is reorganized.
2. The survey skill now assigns disclosure ownership explicitly: the title-page
   author note owns human accountability, named systems and assistance scope,
   evidence-use policy, and the public-record pointer. Method and validity prose
   contain only procedure-specific facts and consequences and point back to the
   note. The agent-assisted evidence-synthesis manuscript was aligned with that
   rule.

## Staged

- **Progressive formal disclosure.** A theory manuscript is easier to read when
  it introduces base semantics before compositional extensions, places
  comparison synthesis after the detailed algorithms and complexity results,
  gives compact lookup tables for notation and parameters, and splits dense
  tables rather than solving density with smaller type. This remains a
  one-manuscript observation; promote it into theory-mode guidance only if it
  recurs.

## Filtered

- No new PDF/HTML parity rule: the existing PDF and site workflows already own
  rendering verification.
- No metadata-filename rule: the survey skill already specifies the naming
  convention.
- No global batch-patching rule: existing bulk-edit verification guidance is
  sufficient, and this session produced no persistent failure needing a new
  guard.

## Rejected

None.
