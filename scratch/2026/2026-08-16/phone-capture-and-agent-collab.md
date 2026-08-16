---
author: Claude Fable 5
---

# Phone capture and agent collaboration surfaces

Design session, 2026-08-16, continuing the knowledge-layer redesign
(same day, separate thread). Status: OPEN — direction agreed, nothing
built; parked deliberately for later discussion.

## Capture pipeline (direction agreed)

Goal: creating or updating a scratch note from the phone as easy as
texting. Architecture decided, not built:

**Dumb pipe, agent pump.** Telegram bot → Cloudflare Worker → GitHub
contents API → `scratch/YYYY/YYYY-MM-DD/<slug>.md`. First line becomes
H1 + slug mechanically; body verbatim; one message = one note; no
`author:` frontmatter because the prose is Bili's. No LLM in the
capture hot path — paraphrase would blur the authorship line, and
every component is a way to lose a note. Structure arrives later via
the normal session pump.

- **Routing:** one worker, two destinations — default chat → sys0
  scratch (public); a prefix or second chat → den scratch (private).
  Gives the semantic-leak concern a one-keystroke answer.
- **v1 luxury (only one):** reply-to-append — replying to a prior
  capture appends to that note (GET-sha-PUT).
- **Provenance:** contents API author = Bili, committer =
  capture-bot, so phone captures are greppable in git log.
- **Code home:** `tools/` (canonical in repo, deployed via wrangler);
  Val Town is the lazier substrate at the cost of code living outside
  the repo.

Security model (verified 2026-08-16):

- Telegram bots are never private; privacy is enforced in worker
  code: sender-ID allowlist + webhook `secret_token` header check.
  Open capture channel = untrusted text into the agent pipeline
  (lethal-trifecta leg — willison2025-lethal-trifecta), so the
  allowlist is load-bearing, not cosmetic. Disable group joins.
- The bot has no GitHub identity; the write capability is a
  fine-grained PAT (contents:write, only sys0 + den, ≤366-day expiry
  — needs a one-time reminder like the rclone client_id one) stored
  as a worker secret. Blast radius of full compromise: markdown
  writes to two repos, revocable. No "accident" channel exists for
  other bots — GitHub write is always an explicit grant.
- **Verified:** GitHub push protection blocks secrets server-side on
  contents-API commits to public repos (409), on by default — Layer 0
  survives the phone path; local hooks are bypassed but CI scanning
  (Layer 3) still runs. Worker must surface 409s back into chat, not
  drop the note silently.

Messaging-surface survey (2026-08-16, primary-sourced; the worker
core is surface-agnostic — build the platform adapter thin):

- **Telegram** — baseline: free-form messages, webhook push, minimal
  ceremony, offline queueing.
- **Cloudflare Email Workers** — co-first, dark horse: first-party
  serverless inbound email on a custom domain, no new app, capture
  from anything. Weaker sender auth (spoofable) → secret address +
  DKIM/SPF check. Natural second adapter on the same worker.
- **Discord** — serverless only via slash-command interactions
  (`/note …`); ordinary DMs require a persistent gateway.
- **Matrix** — a plain account can register an HTTP pusher at the
  worker (webhook-native, no self-hosting); unverified caveat: push
  payloads may be content-redacted → may need a sync fetch.
- **Slack** — Events API push, likely free-tier OK (weakly verified);
  oversized for the job unless a Claude channel materializes.
- **Signal** — tooling healthy but structurally needs an always-on
  linked-device daemon; only worth it for transport privacy. Note:
  Telegram bot chats and email are NOT E2E — fine for public-bound
  captures, a consideration for den-routed ones.
- **WhatsApp** (Meta business ceremony) and **iMessage** (no API;
  Shortcuts-relay hack) — out.

## Agent discussion/collaboration surfaces (survey, no decision)

Frame: three collaboration models — (1) agent resident in your chat,
(2) you visiting the agent's workspace, (3) collaboration through
artifacts. sys0 is already a disciplined (3); local + cloud sessions
are (2); the gap is (1)'s standing, phone-reachable, multi-day
channel.

SOTA as of 2026-08 (two research passes, vendor pages partly
secondary-sourced):

- **Model 1 converged on "single persistent teammate identity,
  @-mentioned in channels":** Claude Tag (Slack, beta; most complete
  — channel memory, skills/MCP, repo work; Team/Enterprise only, not
  individual plans), Devin in Slack (production, from $20/mo, opaque
  compute-unit metering), Codex in Slack (fragmented across
  surfaces). Open-source frontier: Buzz (Block, Nostr keypair
  identity, weeks old), MindRoom (agents as Matrix users, bridges),
  OpenClaw (one identity across ~29 channels) — all young, all
  pointing at "agent identity as an account, not an API call."
- **Model 2 is mature:** Claude Code cloud sessions with device
  handoff (GA) + Remote Control from phone into local sessions
  (research preview, individual default-on, push notifications) +
  cross-session messaging between local sessions (GA) — all included
  in the existing plan. Claude Cowork (beta, Max-first rollout) is
  the near-term watch: broader-than-code delegation steered from
  phone. Elsewhere: Cursor cloud agents (iOS app, shareable steering
  URLs), Codex cloud (mobile needs a live Mac), Jules (web-only).
- **Model 3 mainstream:** Copilot coding agent (issue → PR), GitLab
  Duo GA, Devin tickets. sys0's issues stay disabled by design —
  value in worktree — so this model runs through files here, not
  tickets.
- Ecosystem: AGENTS.md now Linux-Foundation-stewarded across 28+
  tools; framework layer consolidated (AutoGen → maintenance mode).

Working conclusion (to revisit): don't buy an org-gated chat
teammate; exploit what the plan includes (Remote Control + cloud
handoff + local session team), watch Cowork/Tag/Buzz/MindRoom. If a
standing chat channel is ever added, the rule that makes it safe:
**chat is a stream; its residue is pumped into the repo** — and the
capture bot is that pump.

## Open questions for the next session

1. Build the capture worker? (Surface: Telegram confirmed acceptable;
   email adapter as second?) Domain on Cloudflare needed for email.
2. Den routing: adopt from v0, or start sys0-only?
3. Where does capture-bot config/secrets documentation live
   (tools/ README vs AGENTS.md line)?
4. Whether a standing agent chat channel is wanted at all, or Remote
   Control covers the need in practice.
