# Session 01 — P4PER#4 copy-edit pass

Repo: https://github.com/p4lang/p4per (work in `~/i/p4lang__p4per`).
Branch: `p4per-4`. File: `docs/p4per-4.md` (also briefly `docs/index.md`).

Long interactive editing session refining the P4PER#4 design doc ("P4PER Purpose and Guidelines"). No code; pure prose, structure, and convention work. Many small back-and-forth edits rather than one big rewrite — the user's preferred mode.

## Final document structure (H1/H2/H3)

```
H1: P4PER#4 - P4PER Purpose and Guidelines
H2: What is a P4PER?
H2: P4PER types          # Technical / Informational / Process
H2: P4PER number         # format P4PER#N
H2: P4PER governance     # TST as final authority
H2: P4PER workflow
    H3: P4PER roles      # Author/Champion/Editor/Approver + eligibility list
    H3: P4PER status     # Draft/Accepted/Final/Rejected/Withdrawn/Active + Mermaid diagram
    H3: P4PER lifecycle  # 3 numbered steps
H2: Prior art            # PEPs/EIPs + see-also RFCs/Rust/KEPs
```

Anchors used in cross-refs: `#p4per-types`, `#p4per-number`, `#p4per-governance`, `#p4per-roles`, `#p4per-status`, `#p4per-lifecycle`. If renaming an H3, update cross-refs.

## Key naming decisions (with rationale)

- **H2 "P4PER process" vs "P4PER workflow":** Whole doc *defines* the P4PER process, so naming an inner section "process" is recursive. "Workflow" = the operational machinery within the process. Both terms coexist this way: doc = process, the workflow H2 is the operational subsystem.
- **H3 "P4PER lifecycle" (was "P4PER submission"):** "Submission" didn't cover step 3 (complete related work). "Lifecycle" covers the full journey from issue → PRs → Final. Distinct from `P4PER status` which names the states themselves. Considered: "Working on a P4PER" (verb phrase) — rejected to keep sibling noun-phrase consistency.
- **H2 "P4PER governance" (promoted from H3 "P4 Technical Steering Team"):** TST administers the whole process, broader than workflow. Sits between `P4PER number` and `P4PER workflow`. Eligibility list (TST members / WG chairs) was KEPT under `P4PER roles` per user preference for pedagogical proximity.
- **H2 ordering: types → number → governance → workflow.** First-principles: types is substantive classification (more informative for TOC skimmer); number is administrative; governance is meta; workflow is operational.
- **Section "Inspiration" → "Prior art":** "Inspiration" only fit influences, not the see-also list. "Prior art" covers both.

## Conventions established / confirmed

- **PEPs convention adopted for capitalization:**
  - Statuses CAPITALIZED (Draft, Accepted, Final, Rejected, Withdrawn, Active) — defined terms
  - Types CAPITALIZED (Technical, Informational, Process) — defined terms, also **bolded** in body when they're emphatic refs (e.g., line 70, 79, 107)
  - Roles LOWERCASE (author, champion, editor, approver) in body text — matches PEP 1
  - Roles **bolded** only in their definition list
- **Linking policy: minimal.** Add internal cross-links only when text would be confusing without them. Acceptable existing internal links: `[P4PER number](#p4per-number)`, `[editor](#p4per-roles)` (action-oriented prose), `[P4PER status](#p4per-status)`, `[submission](#p4per-lifecycle)`, `[P4 TST](#p4per-governance)`, etc.
- **Don't add a link to every role/type/status mention** — clutters visually.
- **Reference-style link definitions** (`[@handle]: URL`) for GitHub usernames — NO explanatory comment needed (Markdown idiom is self-evident; consistent with `docs/p4per-4.md`).
- **PR reference format: `org/repo#N`** (e.g., `p4lang/p4per#7`). Kept over `PR#7` because the doc references PRs across multiple repos (P4C, P4Runtime).
- **Dates:** ISO `YYYY-MM-DD` in metadata block; prose dates ("May 2026") OK in body.

## P4PER status section — final structure

Each bullet starts with "The P4PER is …" (subject parallelism). Bolding pattern: state keyword + completion qualifier. Sub-bullets attach state-specific notes.

- Accepted's "related work" framing solves the issue that Process/Informational P4PERs have no implementation: "Related work is defined by the specific P4PER. For Technical P4PERs, it typically includes implementation … If there is no related work, skip Accepted and go directly to Final."
- Rejected/Withdrawn each have their own "kept in the repo as historical records" sub-bullet (user picked per-state sub-bullets over a consolidated trailing sentence).
- Active is constrained to Informational and Process P4PERs only (explicit sub-bullet).
- Diagram intro names two flexibilities explicitly: "not exhaustive: other transitions might be valid (e.g., Accepted → Rejected), and a single PR may cover multiple transitions (e.g., a P4PER going directly to Final)." — Avoided abstract "flexible" word; named the two dimensions.

## P4PER lifecycle section — final structure

3 steps:

1. **Create a tracking issue for the P4PER** — "An author opens an issue … and becomes the P4PER champion" (resolves chicken-and-egg of who's champion before issue exists).
2. **Create and update the P4PER via PRs** — two cases:
    - Draft / Withdrawn → editor approval sufficient
    - Accepted / Final / Active → approver review required; rejection updates the PR to mark as Rejected
3. **Complete any related work** — "any" handles the conditional; ends with "send a PR to move the P4PER to Final."

Coordinator = **champion** (matches role def in `P4PER roles`). At one point user changed to "author(s)" — reverted because Champion is defined as the coordinator.

## User collaboration patterns observed

- User selects text ranges via system reminders to point at what they want reviewed.
- User typically previews wording before applying ("Wdyt?", "Better now?").
- User wants concrete options + reasoning, not just blind application — propose, then apply on "go ahead!".
- User values **internal consistency** (sibling patterns, vocab alignment with parent sections) and **PEP genre conformance** (lowercase roles).
- User declines some flagged nits intentionally — don't keep re-raising:
  - Para 1 of "What is a P4PER?" still has three `or`s and "the feature" twice (lifted from PEP 1).
  - Title `P4PER#4 - P4PER Purpose and Guidelines` still has "P4PER" twice and uses hyphen not em-dash.
- User adds annotations like "(as of 2026-05-30)" / "(created YYYY-MM-DD)" / "(merged YYYY-MM-DD)" for dates.
- Recent commits on branch: `46ada14 Switch from P4PER-N to P4PER#N`, `fede706 Use <...> for auto link rendering`, `1d5c1fa Add "as of"`, `a852423 Fix list indentation (4-space uniformly) according to Zensical/MkDocs style`.

## Style/format rules to remember for this repo

- MkDocs/Zensical site — 4-space indent for nested list items.
- Use `<url>` form for bare links (auto-link rendering).
- Sentence case for headings (e.g., "Prior art", "P4PER governance"). Proper nouns OK as-is ("P4 Technical Steering Team").
- Bold + colon for definitional list items (`- **Author**: …`).
- Mermaid diagrams supported (used for status state machine).

## Open / unfinished

- Document is in "ship-ready" state per repeated user check-ins.
- Unaddressed taste-level items left intentionally: title hyphen, Para 1 of intro, "non-technical areas" wording in Process type, TST `them` pronoun.
- `docs/index.md` index table includes entries for both p4per-4 and p4per-1234; that's separate scope.
- Did NOT edit `docs/index.md` beyond noting the comment removal user did themselves.
- No git commits made this session — pure file edits only.
