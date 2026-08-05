# Reproducibility and release toolchain

Version 1.0 is built through `./dev.sh ./scripts/check.sh`. The release build is
intentionally fixed to the following inputs:

- Ubuntu 24.04 image digest
  `sha256:561618e2c15bf2397621dd04f96926663a3b5616c189cf7e38db7e82f5c538ea`;
- Ubuntu package snapshot `20260804T000000Z` at
  `snapshot.ubuntu.com`;
- Typst 0.15.1 archive SHA-256
  `a6d077d0a95eed5a2eba715b2dae06be954f624ccbf85758a03f389ded33118c`;
- PDF creation timestamp `1785801600` (2026-08-04 00:00:00 UTC); and
- exact GitHub Actions commit SHAs recorded in the workflow.

The gate emits PDF/A-2b and checks extractable text, exact author metadata, and
absence of Poppler structural diagnostics. Typst 0.15.1's default tagged output
for this table-heavy manuscript triggers Poppler diagnostics for `Suspects` and
`BorderColor` structure attributes. The release therefore disables PDF tags
instead of publishing a malformed tag tree. This is a documented accessibility
limitation, not a PDF/UA claim. A future Typst upgrade should re-enable tagging
only after the same structural gate passes and mathematical alternatives have
been supplied.

The Git tag identifies source, while the GitHub release carries the built PDF
and its SHA-256 checksum. GitHub Pages serves the current `main` build for
convenient reading; the release asset is the immutable citation target.
