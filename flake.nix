{
  description = "garden: the project dev shell (site build, CV, library tools)";

  inputs = {
    # The host layer pins nixpkgs for every machine; this flake follows that
    # pin, so host and project tools come from one nixpkgs and one lock
    # cannot drift from the other. Relative path inputs need Nix >= 2.26.
    host.url = "path:./config/nix";
    nixpkgs.follows = "host/nixpkgs";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forEachSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            # site/: Astro build and wrangler deploy (npm ci on the host)
            nodejs_24
            # cv/: cv.typ over cv.yaml (site/scripts/build-cv.py)
            typst
            # site/scripts/*.py are stdlib-only; uv runs tools/ with the
            # pinned pymupdf4llm from tools/uv.lock (nixpkgs' is stale)
            python3
            uv
            # leak guard (hooks/check.sh). Pin site: must match
            # GITLEAKS_VERSION in .github/workflows/gitleaks.yml; the
            # gitleaks-pin check below enforces it.
            gitleaks
          ];
        };
      });

      # `nix flake check` fails when nixpkgs' gitleaks (this shell and the
      # host layer, one lock) drifts from the CI workflow's pin.
      checks = forEachSystem (pkgs: {
        gitleaks-pin =
          let
            workflow = builtins.readFile ./.github/workflows/gitleaks.yml;
            pinned = builtins.head (builtins.match ".*GITLEAKS_VERSION: ([0-9.]+).*" workflow);
            actual = pkgs.gitleaks.version;
          in
          if pinned == actual then
            pkgs.runCommand "gitleaks-pin-ok" { } "echo ${actual} > $out"
          else
            throw "gitleaks pin mismatch: workflow ${pinned}, nixpkgs ${actual}";
      });

      formatter = forEachSystem (pkgs: pkgs.nixfmt);
    };
}
