# Evaluating a candidate tool, app, theme, or font

Bili's standing criteria for host choices (2026-09-07 rulings on the
terminal, prompt, theme, and font): open source; popular; some
readability or legibility rationale, not aesthetics alone; both light
and dark where it applies; one consistent experience on macOS and
Ubuntu; solid basics over features; and the decision written into
the repo. Every fact below comes from a query, never from memory.

## Availability and version in the locked nixpkgs

```sh
REV=$(python3 -c "import json;print(json.load(open('config/nix/flake.lock'))['nodes']['nixpkgs']['locked']['rev'])")
nix eval --raw "github:NixOS/nixpkgs/$REV#<attr>.version"
nix eval --json "github:NixOS/nixpkgs/$REV#<attr>" --apply 'p: { v = p.version; platforms = p.meta.platforms; broken = p.meta.broken or false; }'
# Nerd Font variants: nix eval --json ...#nerd-fonts --apply 'n: builtins.attrNames n'
```

A GUI app is a cask on macOS, apt on Ubuntu; only its config comes
from home-manager. Check the cask: `brew info --cask --json=v2 <name>`
(`version`, `auto_updates`).

## Popularity and maintenance

```sh
gh api repos/<owner>/<repo> --jq '"\(.stargazers_count) pushed \(.pushed_at[0:10]) archived=\(.archived)"'
gh api repos/<owner>/<repo>/tags --jq '.[].name' | head -4      # release cadence
```

Read the README for a maintenance notice: Powerlevel10k declares
"very limited support"; WezTerm has had no tagged release since
2024-02; Intel One Mono was archived 2026-09-07. GitHub's `releases`
page fetched through a summarizer often shows only nightlies — use
the tags API.

## VS Code extensions: identifiers and install counts

The marketplace search page is a JavaScript shell; query the gallery
API instead (POST, one call per term):

```sh
curl -sS -X POST 'https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery' \
  -H 'Content-Type: application/json' -H 'Accept: application/json;api-version=7.1-preview.1' \
  -d '{"filters":[{"criteria":[{"filterType":8,"value":"Microsoft.VisualStudio.Code"},{"filterType":10,"value":"<term>"}],"pageSize":8,"sortBy":4,"sortOrder":0}],"flags":256}'
```

Then confirm the attribute exists in the locked overlay
(`pkgs.vscode-extensions.<publisher>.<name>` first,
`pkgs.nix-vscode-extensions.vscode-marketplace.<publisher>.<name>`
second). An "official" port may not be on the marketplace at all
(Flexoki ships only theme JSON in its repo).

## Ghostty themes

Bundled names come from the iTerm2-Color-Schemes `ghostty/`
directory (`gh api repos/mbadolato/iTerm2-Color-Schemes/contents/ghostty
--jq '.[].name'`); on a machine with Ghostty, `ghostty +list-themes`
previews them live.

## Fonts: measure, do not describe

```sh
nix develop -c uv run --no-project --with fonttools python - <font files> <<'PY'
import sys; from fontTools.ttLib import TTFont
for p in sys.argv[1:]:
    f = TTFont(p); os2 = f["OS/2"]; upm = f["head"].unitsPerEm; n = f["name"]
    print(n.getDebugName(16) or n.getDebugName(1), n.getDebugName(5))
    print("  x-height", round(os2.sxHeight/upm, 3), "cap", round(os2.sCapHeight/upm, 3),
          "advance", round(f["hmtx"][f.getBestCmap()[ord("m")]][0]/upm, 3))
    print("  features", sorted({r.FeatureTag for r in f["GSUB"].table.FeatureList.FeatureRecord}))
PY
```

Styles come from the file list (Fira Mono: three weights, no italic).
`calt`/`liga` in the feature list means programming ligatures exist;
an `NL` cut has them removed at the font level, which is how
ligatures were turned off everywhere at once.
