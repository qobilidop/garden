# Capture workflow design

2026-07-03. Status: draft, not approved for implementation.

## Problem

Capture random thoughts and link+comment notes throughout the day, with minimal
friction (mostly from phone), recorded in GitHub repos. Secure: minimal trust
set, minimal credential blast radius.

## Decision summary

- Ingestion channel: `repository_dispatch` events into the garden repo.
- Repo side: an issue-free GitHub Actions workflow appends captures to the
  scratchpad day file `scratchpad/yyyy/yyyy-mm-dd.md` (amended 2026-07-03;
  originally `inbox.md` — superseded by digital-life-system-design.md, which
  retires `inbox.md`).
- Primary frontend: iOS Shortcut (typed/dictated text; share-sheet link + comment).
- IM bots (Telegram/Signal), CLI, other frontends: optional later clients of the
  same dispatch interface. Not needed for v1.

## Why this shape

The real requirement is a ubiquitous low-friction text input feeding git — not
an IM bot per se. Alternatives considered:

| Option | Trust set | Infra | Verdict |
|---|---|---|---|
| Telegram bot | GitHub + Telegram (non-E2E; retained, subpoena-able) | bot + hosting (serverless or Actions polling) | chat UX not worth the trust/infra cost for v1 |
| Signal bot | GitHub only (E2E transport) | signal-cli + persistent ratchet state; fragile on Actions; impossible on serverless | revisit only if a real need emerges |
| GitHub issues as inbox | GitHub only | Action on issue events | anyone can open issues in a public repo (author filter fixes integrity, not noise); raw captures briefly public |
| `repository_dispatch` | GitHub only | Action on dispatch events | authenticated-only trigger; no public surface; chosen |

Key insight: frontends are swappable clients; the dispatch payload is the
stable interface. Build the repo-side workflow once.

## Design

### 1. Ingestion workflow — `.github/workflows/capture.yml`

- Trigger: `repository_dispatch`, event types `capture-thought`, `capture-link`.
- Payloads:
  - `capture-thought`: `{ text }`
  - `capture-link`: `{ url, title, comment }`
- Behavior: append to `scratchpad/yyyy/yyyy-mm-dd.md` (created if absent),
  commit with `GITHUB_TOKEN` (no new secrets). No sections, no state:
  - Thought → timestamped bullet.
  - Link → timestamped `- [title](url) — comment` bullet.
- Commit message: `Capture: <first few words>`.
- `concurrency` group serializes runs (no races on rapid captures).

### 2. iOS Shortcut — "Capture"

- Entry points: home screen / action button / Siri (text or dictation);
  share sheet (receives URL + page title, prompts for optional comment).
- Action: POST `https://api.github.com/repos/qobilidop/garden/dispatches`
  with event type + payload.
- Credential: fine-grained PAT — garden repo only, Contents read/write only,
  1-year expiry — stored in the Shortcut on device.

## Security posture

- Trust set: GitHub + own devices. No third parties, no inbound endpoints,
  no bots, no polling.
- Strangers have no trigger channel (dispatch requires the PAT).
- PAT blast radius if phone compromised: push commits to the public garden
  repo only — visible in history, revertible; revocable from GitHub settings.

## Accepted trade-offs

- No PAT-free capture path (fallback: edit `inbox.md` via GitHub web/app).
- Capture is asynchronous: Shortcut gets immediate 204; commit lands seconds later.

## Testing

- Drive dispatches with `gh api` / `curl` to verify formatting and appending.
- Verify the Shortcut manually against both use cases.

## Open questions

- ~~Larger repo design discussion (pending) may relocate the target file/repo.~~
  Resolved: target is the scratchpad day file (digital-life-system-design.md).
- Entry format details can change freely; only the workflow's append logic is
  affected.
