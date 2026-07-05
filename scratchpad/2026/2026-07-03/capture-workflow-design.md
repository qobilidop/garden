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
| Direct Contents API from Shortcut | GitHub only | none (no workflow) | same PAT scope as dispatch (Contents R/W), but append = GET-sha → decode → append → PUT on device: racy (409, no retry), and formatting logic frozen into each Shortcut |
| iCloud file + Mac relay | GitHub + Apple (already trusted — the frontend is an iOS Shortcut) | launchd job on Mac drains file into repo | zero credentials on phone; offline capture works; but Mac becomes a daemon dependency and latency is minutes-to-hours. Documented escape hatch if PAT-on-phone ever becomes unacceptable (note: bypasses the dispatch interface rather than reusing it) |
| Working Copy (git on iOS) | GitHub + a paid third-party app | none | offline commit queue is nice, but adds an app to the trust set |
| `repository_dispatch` | GitHub only | Action on dispatch events | authenticated-only trigger; no public surface; dumb clients, logic in repo; chosen |

Key insight: frontends are swappable clients; the dispatch payload is the
stable interface. Build the repo-side workflow once.

## Design

### 1. Ingestion workflow — `.github/workflows/capture.yml`

- Trigger: `repository_dispatch`, event types `capture-thought`, `capture-link`.
- Payloads (`ts` = client-side local timestamp, ISO 8601 with offset):
  - `capture-thought`: `{ text, ts }`
  - `capture-link`: `{ url, title, comment, ts }`
- Behavior: append to `scratchpad/yyyy/yyyy-mm-dd.md` (created if absent),
  commit with `GITHUB_TOKEN` (no new secrets). No sections, no state:
  - Thought → timestamped bullet.
  - Link → timestamped `- [title](url) — comment` bullet.
- Day file and timestamp derive from the payload `ts`, not runner clock:
  capture time ≠ run time (queued runs), and the runner is UTC — an evening
  capture would otherwise land in the wrong day file.
- Commit message: `Capture: <first few words>`.
- Concurrency: `concurrency` group with `queue: max`. The default group
  behavior cancels older pending runs (only the newest pending run is kept),
  and the payload lives in the run — rapid captures would be silently
  dropped. `queue: max` keeps up to 100 pending runs. Belt-and-suspenders:
  the commit step also does a pull-rebase-push retry loop.

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

- No PAT-free capture path (fallback: edit the scratchpad day file via GitHub
  web/app).
- Capture is asynchronous: Shortcut gets immediate 204; commit lands seconds later.
- No offline capture: the dispatch POST fails without network; the Shortcut
  surfaces the error but the text is lost unless retried manually. The
  iCloud + Mac relay alternative would fix this if it ever matters.
- Commits pushed with `GITHUB_TOKEN` don't trigger other workflows. Harmless
  today, but if the website ever renders the scratchpad, captures won't
  trigger `deploy-website.yml`.

## Testing

- Drive dispatches with `gh api` / `curl` to verify formatting and appending.
- Verify the Shortcut manually against both use cases.

## Open questions

- ~~Larger repo design discussion (pending) may relocate the target file/repo.~~
  Resolved: target is the scratchpad day file (digital-life-system-design.md).
- Entry format details can change freely; only the workflow's append logic is
  affected.
