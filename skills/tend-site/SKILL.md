---
name: tend-site
description: Develop and verify the garden website (site/, Astro). Use when changing site/ code or styles, debugging site builds or deploys, or verifying content renders on the published site.
---

# Tend the site

The contract is AGENTS.md §Site: `site/` reads exactly `wiki/`,
`library/`, `notebook/`, `cv/cv.yaml`, and `portfolio/portfolio.yaml`,
read-only; owned logic in `site/src/lib/`; unresolved `[[targets]]` and bare citekey
mentions fail the build via `lintContent()` in `site/src/lib/sitemap.mjs`,
called at config load (`astro.config.mjs`), and an invalid CV or
portfolio record fails it via the zod schemas in `site/src/lib/cv.ts`
and `site/src/lib/portfolio.ts`; `npm run check` (`astro check`, strict
`tsconfig.json`) type-checks `src/` in CI, since the build alone never
does. The logo variants and favicons are built
by `python3 site/scripts/build-brand.py` (stdlib only, runs on the
host) from `brand/logo.svg` and `brand/favicon.svg` into gitignored
`site/public/brand/` and `site/public/favicon.*`, and the CV PDF by
`python3 site/scripts/build-cv.py` (typst from the flake shell) from
`cv/cv.typ` over `cv/cv.yaml` into gitignored `site/public/cv.pdf`; CI
runs both scripts before the Astro build, every step inside `nix
develop` (`flake.nix`, the shell direnv gives the host), so a tool
version changes in one place: the flake lock.

## The loop

- Build: `npm run build` in `site/`. After changing `astro.config.mjs`
  or anything in `src/lib/`, clear caches first:
  `rm -rf .astro node_modules/.astro dist` — the content layer caches
  rendered entries by content hash and serves stale HTML for unchanged
  markdown.
- Errors thrown inside the markdown pipeline are logged but the build
  exits 0 — a check that must gate CI throws at config load instead.
  Verify enforcement by exit code, never by error text.
- The dev server serves unminified CSS; production is minified by
  lightningcss, which optimizes within a rule without seeing the
  cascade — a nameless `animation:` shorthand becomes `animation:
  none` even when later rules set the name. Verify CSS behavior on
  the built output (`npm run build` then `npm run preview`), never on
  the dev server alone.
- Preview: `npm run preview`; use the URL it prints because the port may
  vary. Screenshot with `scripts/shot.mjs` (headless Chrome over the
  DevTools protocol: `--scheme` emulates dark or light, `--hover` fires
  `:hover`, `--frames` samples an animation, `--size` reflows narrow
  layouts, `--reduced-motion` checks the still state) and show the user
  before proposing a commit — visual changes get visual review. Plain
  `chrome --screenshot` clamps the window to ~500px and ignores scheme
  flags; the Chrome extension screenshots localhost only once that site
  is granted in its settings.
- Astro 7's `dev` and `preview` run as detached daemons that outlive
  the session; stop them when done (`npx astro dev stop`, `npx astro
  preview stop`) — a dozen leftovers from past sessions once shared a
  port and served 404s. The CV record (`cv/cv.yaml`) loads at startup:
  restart the dev server after editing it.
- A static renderer is only a typographic smoke test; if no browser is
  available, report responsive, interactive, and browser-engine-specific
  behavior as unverified.
- Deploy: push triggers `.github/workflows/site.yml` (builds in the dev
  image, then `npm run deploy` → Cloudflare Worker `garden` serving
  qobilidop.com). `site.yml`'s push `paths` must name every source the
  site reads (the §Site allowlist) — a source added without its trigger
  path deploys silently stale (`cv/**` was missed in 2026-08). Resolve
  the run by head SHA (`gh run list --json databaseId,headSha`) — `--limit
  1` can race the dispatch and return the previous run — and watch by
  exit code (`gh run watch <id> --exit-status`), then curl
  `https://qobilidop.com/…` for the specific change. Verify a deployed
  PDF with `pdftotext`, never byte or zlib scans: typst's subset fonts
  encode text as glyph IDs (false-negatived 2026-08-23 and 2026-09-07). If GitHub Actions is down, publish from the host: `npm run
  build && npm run deploy` in `site/` (one-time `npx wrangler login`).
  Decision record and what-if runbook:
  `scratch/2026/2026-08-22/hosting-decision.md`.
  Read the run's final annotations even when it succeeds;
  a runtime-deprecation annotation on an action is a maintenance finding,
  not a green-run exemption (Node 20 action drift surfaced this way in
  2026-08).
- `site/node_modules` holds native binaries for the host that
  installed them; an install from another platform against the same
  checkout (a container mount) breaks the build ("Cannot find native
  binding"). Reinstall on the host if it happens.

## Design system

Grayscale tokens in `src/styles/global.css`; the only hues are the
`--paper`/`--post` identity dots (CVD-validated against both surfaces).
Serif prose, sans apparatus, mono citekey handles. The frame is
tokens at the top of `global.css` (36rem measure, 16rem margin
columns, 2.5rem gutters; frame from 58rem, margin hangs from 64rem) with its rationale in the
`body` comment; header, main, and footer share its three columns.
Design decisions trace to researched precedent — match that bar when
changing them. No third-party runtime origins: fonts, scripts,
analytics, and images all ship from the build (portability, and reach
— Google Fonts and public CDNs are blocked in mainland China).
