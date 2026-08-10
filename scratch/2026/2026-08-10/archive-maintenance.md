---
author: Codex GPT-5.6 Sol
---

# Archive maintenance belongs off the ingestion path

The library initially made every ingestion find or create a Wayback record.
That coupled a durable local-preservation requirement to a slow, eventually
consistent third-party service. The user pushed the design toward a cleaner
boundary: ingestion records the canonical URL and preserves the artifact;
public archive coverage is periodic maintenance.

The resulting design keeps no archive ledger. Library frontmatter contains
only canonical source URLs, while a monthly, repository-read-only workflow
derives the URL inventory, checks public coverage, and submits a bounded
number of confirmed misses. A later run verifies indexing. This avoids
hand-copied external state, ingestion retries, and UI links that were usually
redundant.

Two implementation details carried the principle:

- The site build and archive maintainer share one flat-source parser, so the
  schema cannot drift between display and automation.
- A clean Availability API miss is sufficient to request a capture. CDX is a
  short duplicate-avoidance cross-check, not a dependency that can defer a
  source forever when it times out.

The deployment passed but emitted a Node 20 runtime-deprecation annotation
for GitHub-maintained actions. A green exit code was therefore insufficient
as the whole maintenance signal. The accepted evolution updates the action
majors together and teaches `tend-site` to inspect final annotations even
after successful runs.

No archive-specific agent skill or memory was added. The recurring operation
is fully executable, and the durable policy already lives in `AGENTS.md` and
the ingestion skills; another prose workflow would duplicate those homes.

The first scheduled archive run remains the real-world check: confirm that
anonymous Save Page Now submissions are accepted from the Actions runner and
that the next monthly pass observes their indexed captures.
