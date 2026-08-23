# AGENTS.md

## Public-repo leak review

- Before committing here, re-read the staged diff for private context —
  personal information, private-project details, content copied from
  `shadow/`. Secrets and structure are machine-checked (`hooks/`); private
  context is not machine-checkable and is on you.
- When notes or scratch relate a work to this system, cite only what this
  repository itself shows — never local setup (installed plugins, machine
  details, private repos' contents).

## Guards

- A machine check that runs in more than one place (hooks, dev image,
  CI) pins a single version, and each pin site cross-references the
  others — divergent scanner versions once made CI and hooks disagree
  on the same config.
- Merge commits bypass pre-commit hooks — a load-bearing guard also
  runs at pre-push or in CI (an absorbed repo's oversized files once
  entered through a merge that pre-commit never saw).

## Fan-out

- Subagents inherit no operating rules. A fan-out prompt that could
  touch a gated capability (browser-mediated downloads, deletions,
  pushes) states the gate explicitly — three survey pipelines once
  escalated to the user's browser unprompted.
- A fan-out that delegates *judgment* says so: decisions must be the
  agent's own reading, never a script, regex, or keyword heuristic,
  and each carries a justification specific to its item. The
  orchestrator checks that before consuming the output — distinct
  justifications should roughly equal item count. Two of six screening
  passes once returned classifiers instead of judgments (one an
  explicit program, one 97 decisions sharing 7 template reasons);
  both were plausible in aggregate and invisible from decision counts.
- A subagent's reported statistic is a claim, not primary output.
  Recompute anything destined for a persisted artifact, and check that
  a partition sums to its denominator — a published "49 of 66" survived
  two rounds because nobody noticed 54 + 8 ≠ 66.
- Writing fan-outs default to worktree isolation (clean per-agent
  baseline, mechanical merge-back); read-only fan-outs share the
  tree. When parallel writers must share a tree, their prompts
  forbid git state operations (stash/checkout/reset/restore) — two
  migration agents once ran `git stash`/`pop` under five concurrent
  writers, both seeking the clean baseline a worktree would have
  given them.

## Layer contracts

- A content layer's conventions live in `<layer>/AGENTS.md`, with a
  sibling `CLAUDE.md` shim (`@AGENTS.md`). Nested instruction files do
  not reliably auto-load — Claude Code loads them on reads (not
  writes), Codex walks only the cwd chain, and subagents inherit
  nothing — so: **before writing in a layer, read its AGENTS.md.**
  Layers with contracts so far: `scratch/`.

## Wiki

- `wiki/<topic>.md`: flat, living topic pages distilling the library
  across works — agent-written, human-directed, citing works by
  `[[citekey]]`. Ingestion updates the pages a work touches; a new page
  needs enough accumulated material to synthesize, never a single work.
  No index, no per-page frontmatter: the directory lists, git logs.

## Library

- Frontmatter stores canonical source URLs, never derived archive state:
  posts use `source: <url>` and papers use a flat `sources:` map such as
  `pdf: <url>` or `html: <url>`. Local preservation happens at ingestion;
  `tools/archive-library.mjs` checks public Wayback coverage monthly and
  requests missing captures without writing archive links back into notes.
- After locally preserving a post, post ingestion requests missing Wayback
  coverage but never waits for the resulting capture; a future archive-
  maintenance run verifies accepted submissions. Paper ingestion leaves new
  archive requests to maintenance. When an origin is already inaccessible, a
  verified existing capture may serve as an acquisition fallback; record that
  provenance in a frontmatter comment.

## Site

- `site/` renders the repo to a static site at qobilidop.com (Astro),
  served by Cloudflare Workers static assets (`site/wrangler.jsonc`);
  the build output is plain files, so the host is replaceable. It
  reads exactly `wiki/`, `library/`, and `surveys/*/index.md` — the
  three collections in `site/src/content.config.ts` are the allowlist
  — and writes nothing back; presentation needs never reshape note
  conventions. A survey groups as `index.md` (landing page, the
  citekey/backlink surface) + `record/` (the minimal resumable state:
  method, searches, catalog, evidence notes) + `manuscript/` (Typst
  paper: paged + HTML wrappers over shared `content.typ`/`metadata.typ`,
  standalone by design), compiled into `site/public/` by
  `site/scripts/build-manuscripts.py` (typst pinned in the dev
  image).
- Owned logic lives in `site/src/lib/` (wikilink resolution, backlink
  graph, work metadata); everything else is rented substrate (Astro,
  remark, KaTeX, Pagefind, Mermaid, wrangler). An unresolved `[[target]]` fails
  the build.
- CI builds in the dev image (`.github/workflows/site.yml`) and
  deploys with `npm run deploy`; local builds and emergency deploys
  (same command, OAuth via `wrangler login`) run on the host per
  tend-site.
  `dev.sh` rejects direct package-manager commands because container
  installs would clobber native binaries in the shared `node_modules`.

## Conventions

- A convention found to exist only by imitation gets codified in its
  governing skill in the same change, and machine-checked where
  checkable — unwritten conventions drift (H1 shapes, display names,
  and citation forms all did).
- Every fact has one canonical home; other surfaces point at it,
  never restate it. Derived views are generated, never committed.
  Two files that must agree become one file that cannot disagree.
  (Different altitudes — evidence, understanding, presentation — are
  not duplication.) The one data bug a day of survey work surfaced
  was a hand-copied count drifting from its ledger.
- When a name, vendor, or host is retired, sweep every surface it
  touched in the same change — repo text, CI, DNS records, dashboard
  settings, packages — by searching for the *name*, not by testing
  for function; an inert reference is still debt (the sys0→garden
  rename left 31 files and a vanished CI image; the hosting move left
  a `www` record and a whole standby naming the old host).

## Skills

- Canonical skills live in `skills/<name>/`; deploy each by committed
  relative symlinks in both `.claude/skills/` (read by Claude Code) and
  `.agents/skills/` (the cross-client convention — Codex and other
  agents).

## Mirrored agent configuration

- Before editing canonical user configuration under `config/`, read that
  platform's scoped instructions, run its sync tool with `diff`, and reconcile
  any drift.
