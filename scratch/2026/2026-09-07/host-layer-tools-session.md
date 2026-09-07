---
author: Claude Fable 5.1
---

# Host layer, day two: garden flake, CI bootstrap, terminal stack

Written after the host-config decision note's "Done since" section and
the surveys spin-off note, at the end of the same day. One session:
layer 2 (the garden root flake, dev image retired), `host-config.yml`
(Ubuntu bootstrap on a clean runner, macOS build, lock agreement), a
host prune, and the terminal stack — Ghostty, Starship, GitHub Dark
Default fixed, JetBrainsMonoNL Nerd Font at 13 with ligatures off —
each chosen by a research pass against Bili's stated criteria.

## Principles that emerged

- **Nix provides, the OS registers.** zsh comes from `home.nix`; only
  the `/etc/shells` and passwd records belong to Ubuntu. Bili caught
  the apt install of a second zsh in CI ("shouldn't zsh be managed by
  nix?"); the fix moved the one OS-owned step into `bootstrap.sh`,
  where CI exercises it.
- **Record the fact, not a policy, when the want is visibility.**
  "I want to update manually" was wired as greedy casks with in-app
  updaters off; the real want was knowing which apps update
  themselves. `darwin.nix` now carries two lists composed into the
  cask list with an assertion against overlap, and every app keeps
  its own updater.
- **A follows-through-path flake input is one declared pin with two
  recorded copies.** Nix neither refreshes nor checks the root copy
  when the host lock moves; `nix flake lock` does not repair it,
  `nix flake update host` does. The lint hook and the locks CI job
  compare the two revisions.
- **Turn a preference off at the artifact, not per app.** Ligatures
  off by choosing the font's NL cut holds in Ghostty, VS Code, and any
  future app without a flag to keep in sync.
- **Measure the font, do not describe it.** fontTools on the two
  files settled Fira Mono against JetBrains Mono in a table (three
  weights and no italic against eight with italics; x-height 0.527
  against 0.550 em at equal width) where prose would have argued.

## Errors worth remembering

- Two misreads of one-line preferences (theme "default", "manual
  update"), each costing a commit, a CI run, and a reversal. Now in
  the flag-deviations memory as a second pattern.
- `ls -t` and `find -newer` in `/nix/store` pick arbitrary files
  (mtimes are epoch); a stale Ghostty config was printed as the built
  one. Find generated files by content grep. In tend-host.
- The unmatched-glob rule was violated four times in one day while
  present in the global rules. The rule was restructured into
  per-trap bullets, and `home.nix` now turns `nomatch` off for
  non-interactive zsh, tested in an isolated `ZDOTDIR`.
- A `;` after a failed commit let `git push` run. The push carried an
  already-intended commit, so no harm; the mechanism is real.

## Process residue for /evolve

Staged (single occurrence each):

- Gated steps chain with `&&`, never `;` — a failed commit followed
  by `;` still pushes.
- Before adding an OS-level install (apt, a formula), check whether
  the Nix layer already provides the thing; the OS may own only a
  registration step.
- `gh run view --log` and the job-logs API return nothing until the
  whole run completes, even for a finished failed job; wait, or
  cancel the run to read it sooner.
- Long compound verification commands had their displayed output
  truncated several times, showing only the tail; keep each
  verification call small enough to read whole, or write to a file
  and grep.
- Relative-path flake follows fetch nothing transitive: the Site CI
  log showed no Homebrew or nix-darwin fetches. A single root flake
  absorbing `config/nix` would have paid those fetches on every
  `nix develop`.

## Evolve outcome (run at session end)

Accepted and applied, all: (P1) `skills/tend-host` — the config/nix
loop and traps, with a reference for evaluating a candidate tool,
theme, or font; (P2) root AGENTS.md — two lock files with one pin, and
the layer-contract list extended to `config/*`; (P3) `/result`
gitignored at the root; (P4) subtraction — the host-config memory cut
from ~2000 words of narrative to ~400 of rulings, gates, pending, and
pointers; (P5) the flag-deviations memory gains the two-readings
pattern; (P7a) the global shell-discipline bullet split into one
bullet per trap in both mirrored configs; (P7b) `nomatch` off for
non-interactive zsh in `home.nix`; (P8) the staged items above; (P9)
untracked `__pycache__` debris of the removed run-survey skill
deleted; (P10) this note. Bili's ruling on P7: both, with the machine
fix scoped to non-interactive shells so interactive zsh still errors
on a mistyped glob. Nothing rejected.
