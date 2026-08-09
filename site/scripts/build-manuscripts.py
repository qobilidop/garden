#!/usr/bin/env python3
"""Compile survey manuscripts into site/public/ for deploy.

For each surveys/<slug>/manuscript/ with manuscript.typ (paged
entrypoint) + manuscript-html.typ:
  site/public/surveys/<slug>/manuscript.pdf   (paged wrapper)
  site/public/surveys/<slug>/manuscript.html  (HTML wrapper, styled)

Requires typst (dev image; run via ./dev.sh on the host). The HTML
target is experimental (--features html) — pinned typst version in
.devcontainer/Dockerfile is the compatibility anchor. The stylesheet
(site/src/styles/paper.css) is inlined and data-pagefind-body added so
the paper's full text stays in site search.
"""
import re
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
CSS = REPO / "site" / "src" / "styles" / "paper.css"


def compile_typ(src, out, *flags):
    subprocess.run(
        ["typst", "compile", "--root", str(REPO), *flags, str(src), str(out)],
        check=True,
    )


def main():
    css = CSS.read_text()
    built = []
    for paged in sorted(REPO.glob("surveys/*/manuscript/manuscript.typ")):
        slug = paged.parent.parent.name
        html_src = paged.parent / "manuscript-html.typ"
        out_dir = REPO / "site" / "public" / "surveys" / slug
        out_dir.mkdir(parents=True, exist_ok=True)
        compile_typ(paged, out_dir / "manuscript.pdf")
        out_html = out_dir / "manuscript.html"
        compile_typ(html_src, out_html, "--features", "html", "--format", "html")
        doc = out_html.read_text()
        doc = doc.replace("</head>", f"<style>{css}</style></head>", 1)
        doc = re.sub(r"<body(?![\w-])", '<body data-pagefind-body', doc, count=1)
        out_html.write_text(doc)
        built.append(slug)
    print(f"built {len(built)}: {', '.join(built)}")
    return 0 if built else 1


if __name__ == "__main__":
    sys.exit(main())
