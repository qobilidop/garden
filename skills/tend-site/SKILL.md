---
name: tend-site
description: Develop and verify the garden website (site/, Astro) — the build/preview/deploy loop, its cache and environment traps, and where the site's contract and lints live. Use when changing site/ code or styles, debugging site builds or deploys, or verifying content renders on the published site.
---

# Tend the site

The contract is AGENTS.md §Site: `site/` reads exactly `wiki/`,
`library/`, and `surveys/*/index.md`, read-only; owned logic in
`site/src/lib/`; unresolved `[[targets]]` and bare citekey mentions
fail the build via `lintContent()` in `site/src/lib/sitemap.mjs`,
called at config load (`astro.config.mjs`). Survey manuscripts are
compiled separately — `./dev.sh python3 site/scripts/build-manuscripts.py`
(typst, pinned in the dev image; the HTML target is experimental) into
gitignored `site/public/surveys/`; CI runs the same script before the
Astro build, and a push that changes `.devcontainer/` races the image
republish — the proven recovery, runnable as one background chain:
`gh run watch <dev-image-run> --exit-status && gh workflow run
site.yml`, then watch the new run and curl the live page.

## The loop

- Build: `npm run build` in `site/`. After changing `astro.config.mjs`
  or anything in `src/lib/`, clear caches first:
  `rm -rf .astro node_modules/.astro dist` — the content layer caches
  rendered entries by content hash and serves stale HTML for unchanged
  markdown.
- Errors thrown inside the markdown pipeline are logged but the build
  exits 0 — a check that must gate CI throws at config load instead.
  Verify enforcement by exit code, never by error text.
- Preview: `npm run preview`; use the URL it prints because the port may
  vary. Screenshot and show the user before proposing a commit — visual
  changes get visual review.
- Survey manuscript presentation: compare representative HTML renders
  with the corresponding equation- or layout-heavy PDF pages; typography
  and mathematical structure should stay visually close even though
  pagination differs. On render trouble, open
  `skills/run-survey/references/typst.md`. A static renderer is only a
  typographic smoke test; if no browser is available, report responsive,
  interactive, and browser-engine-specific behavior as unverified.
- Deploy: push triggers `.github/workflows/site.yml` (builds in the dev
  image, then `npm run deploy` → Cloudflare Worker `garden` serving
  qobilidop.com). Watch by exit code (`gh run watch <id>
  --exit-status`), then curl `https://qobilidop.com/…` for the specific
  change. If GitHub Actions is down, publish from the host: `npm run
  build && npm run deploy` in `site/` (one-time `npx wrangler login`).
  Decision record and what-if runbook:
  `scratch/2026/2026-08-22/hosting-decision.md`.
  Read the run's final annotations even when it succeeds;
  a runtime-deprecation annotation on an action is a maintenance finding,
  not a green-run exemption (Node 20 action drift surfaced this way in
  2026-08).
- Never run npm installs or builds through `dev.sh` against the host
  checkout: the mount shares `site/node_modules`, and Linux binaries
  clobber the macOS ones ("Cannot find native binding"). `dev.sh`
  rejects direct `npm`, `npx`, `yarn`, and `pnpm` invocations; reinstall
  on the host if an indirect invocation causes the same failure.

## Design system

Grayscale tokens in `src/styles/global.css`; the only hues are the
`--paper`/`--post` identity dots (CVD-validated against both surfaces).
Serif prose, sans apparatus, mono citekey handles; 44rem measure.
Design decisions trace to researched precedent — match that bar when
changing them. No third-party runtime origins: fonts, scripts,
analytics, and images all ship from the build (portability, and reach
— Google Fonts and public CDNs are blocked in mainland China).
