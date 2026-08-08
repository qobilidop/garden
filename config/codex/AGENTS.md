# config/codex

Canonical Codex user configuration; live copies and merged settings live in
`~/.codex` (or `$CODEX_HOME`).

Before editing anything here, run `./sync.sh diff` and reconcile drift
(usually `pull` first). Edit in this directory, then run `./sync.sh push`.

`config.toml` is a managed overlay, not a complete snapshot. Keep durable user
preferences here. Do not add authentication, histories, memories, caches,
trusted-project records, marketplace timestamps, generated MCP settings,
connector IDs, command-approval rules, or product-provisioned plugins from the
`openai-bundled`, `openai-curated`, and `openai-primary-runtime` marketplaces.

`user-AGENTS.md` maps to the global `~/.codex/AGENTS.md`; its different name
prevents these global rules from also becoming this directory's project rules.
`coauthor.py` maps to `~/.codex/bin/coauthor`. It reads the active thread's
runtime metadata and deliberately fails closed if Codex changes that internal
state format; test it from an active session after Codex upgrades.
