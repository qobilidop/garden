#!/usr/bin/env python3
"""Compile the CV PDF into site/public/ for deploy.

cv/cv.yaml is the canonical record; cv/cv.typ is the paged view over
it. Output: site/public/cv.pdf (gitignored, like all derived views).

Requires typst (pinned in .devcontainer/Dockerfile; the host install
must match that version — run via ./dev.sh if it doesn't).
"""
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
OUT = REPO / "site" / "public" / "cv.pdf"


def main() -> int:
    OUT.parent.mkdir(parents=True, exist_ok=True)
    result = subprocess.run(
        ["typst", "compile", "--root", str(REPO), str(REPO / "cv" / "cv.typ"), str(OUT)],
    )
    if result.returncode != 0:
        return result.returncode
    print(f"built {OUT.relative_to(REPO)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
