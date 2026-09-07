---
name: tend-host
description: Change and verify the host configuration layer (config/nix — packages, shell, GUI apps, fonts, VS Code, Ghostty, Starship) — the build/verify/ship loop, the Nix store and Homebrew traps, and how a new tool or app is evaluated before it is declared. Use when adding, removing, or configuring anything on Bili's machines, when a switch or the Host config workflow fails, or when comparing candidate tools, fonts, or themes for the host. For the website use tend-site; for the project dev shell (flake.nix at the root) the loop here still applies but the contract is AGENTS.md §Dev shell.
---

# Tend the host

The contract is `config/nix/AGENTS.md`: what lives in which file, how
to apply and update, who updates each GUI app. This skill is the
loop and its traps. Read the contract first when the change touches
a rule it states (PATH order, update ownership, the two lock files).

## The loop

1. **Read the module before setting an option.** Option names and
   defaults come from the locked source, not memory: prefetch the
   input and grep its module (`nix flake prefetch --json
   github:nix-community/home-manager/<rev from config/nix/flake.lock>`,
   then `grep` under `modules/programs/<name>.nix`). Two module
   assertions today (`systemd.enable` and validation under
   `package = null`) would have failed the build unseen otherwise.
2. **Edit, then format:** `nixfmt <files>`; a missing format check
   fails the next build's lint.
3. **Build without switching**, with the flake path absolute:
   `darwin-rebuild build --flake /Users/qobilidop/my/garden/config/nix#mac`.
   Run from the repo root it drops a `result` symlink into the cwd
   (gitignored at both roots now, still delete it). For the Linux
   half: `nix build --dry-run .#homeConfigurations.qobilidop.activationPackage`.
   Capture the log to a file and grep it for `error|deprecated`; the
   build exit alone hides evaluation warnings.
4. **Find the generated file by content, never by time.** Store
   mtimes are all epoch, so `ls -t /nix/store/*-x` and `find -newer`
   return arbitrary paths — this misreported a stale Ghostty config as
   the new one. Use `grep -l '<a string only the new version has>'
   /nix/store/*-ghostty-config` (likewise `*-home-manager-files/...`,
   `*-Brewfile`), and quote store globs or they abort the command.
5. **Validate what home-manager cannot.** With `package = null` the
   Ghostty module writes the config but skips `+validate-config`;
   run the installed app's validator on the store file
   (`/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config
   --config-file=<path>`). VS Code settings: load the generated JSON
   with Python and print the keys you changed.
6. **Commit and push**; `host-config.yml` runs three jobs (Ubuntu
   bootstrap as the real user, macOS system build, lock agreement).
   Get the run id from `gh run list --workflow=host-config.yml
   --limit 1`, then `gh run watch <id> --exit-status` in a background
   call. Job logs are unreadable until the whole run completes, even
   for a finished failed job; to iterate faster, cancel the run.
7. **The switch is Bili's** (`sudo darwin-rebuild switch --flake
   <abs path>#mac`); `sudo -n` fails here. After it: `zsh -lc
   config/nix/verify.sh` from a fresh login shell, `readlink
   /run/current-system` for the generation, then the live files
   (`~/.config/ghostty/config`, VS Code `settings.json`,
   `brew list --cask`). Ghostty and VS Code read config at startup:
   a new window, a restart.
8. **Update procedure:** `nix flake update --flake config/nix`, then
   `nix flake update host` at the repo root (Nix neither refreshes
   nor checks the root lock's copy; the lint hook and the locks job
   compare them), build, switch.

## Traps by surface

- **Homebrew casks**: `brew info --cask --json=v2 <name>` shows
  `auto_updates`; that flag decides which list in `darwin.nix` a cask
  belongs to. `cleanup = "uninstall"` removes an undeclared cask at
  the switch but leaves its `~/Library/Application Support` data.
- **Fonts**: nix-darwin's `fonts.packages` copies into
  `/Library/Fonts/Nix Fonts/<store name>/...`; macOS reads the
  family from name ID 16 (`X Nerd Font`), not ID 1 (`X NF`). Ghostty's
  `+list-fonts` lists only fixed-pitch families, which hides Nerd
  Fonts' double-width variants; `+show-face --string=A` and
  `--cp=0xE0A0` are the authoritative check of what renders.
- **Ghostty**: 1.3.x embeds a symbols-only Nerd Font fallback, so
  prompt glyphs render even without an installed Nerd Font. Themes
  are named exactly as `+list-themes` shows.
- **home-manager on macOS**: `home-manager` is not a command (the
  nix-darwin module drives it); `verify.sh` must not expect it.
  `stdenv.isDarwin` is deprecated for `stdenv.hostPlatform.isDarwin`.
- **The bootstrap**: `bootstrap.sh` runs unmodified in CI as user
  `qobilidop`; a fresh Ubuntu has no zsh, so `home.nix` provides it
  and the bootstrap registers it in `/etc/shells`. The Codex sync
  tool creates `config.toml` on a home Codex never wrote to.

## Evaluating a candidate

Terminal, prompt, theme, and font were each chosen by the same pass:
current facts from primary sources, a table against Bili's stated
criteria, one recommendation, runner-up named with the reason it
lost. Open [references/evaluate-candidate.md](references/evaluate-candidate.md)
for the queries (nixpkgs version and platforms, GitHub stars and
activity, marketplace install counts, font metrics from the file).
