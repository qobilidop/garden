#!/usr/bin/env python3
"""Compile survey manuscripts into site/public/ for deploy.

For each surveys/<slug>/manuscript/ with manuscript.typ (paged
entrypoint) + manuscript-html.typ:
  site/public/surveys/<slug>/manuscript.pdf   (paged wrapper)
  site/public/surveys/<slug>/manuscript.html  (HTML wrapper, styled)

Requires typst (dev image; run via ./dev.sh on the host). The HTML
target is experimental (--features html) — pinned typst version in
.devcontainer/Dockerfile is the compatibility anchor. The stylesheet
(site/src/styles/paper.css) is inlined, a section navigator is derived
from numbered h2 headings, and data-pagefind-body is added so the paper's
full text stays in site search.
"""
import html
import re
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
CSS = REPO / "site" / "src" / "styles" / "paper.css"
H2 = re.compile(r"<h2(?P<attrs>[^>]*)>(?P<contents>.*?)</h2>", re.DOTALL)
SECTION_NUMBER = re.compile(r"^(?P<number>\d+)\.\s")
TAG = re.compile(r"<[^>]+>")
CSS_COMMENT = re.compile(r"/\*.*?\*/", re.DOTALL)
CSS_RULE = re.compile(r"(?P<selectors>[^{}]+)\{(?P<declarations>[^{}]*)\}")
MATH_ROOT_SELECTOR = re.compile(r"(?:^|[\s>+~])math(?:[#.:\[].*)?$", re.IGNORECASE)
ORDINARY_MATH_DISPLAY = re.compile(
    r"(?:^|;)\s*display\s*:\s*(?:block|inline)\s*(?:!important\s*)?(?:;|$)",
    re.IGNORECASE,
)

SECTION_NAV_SCRIPT = """<script>
(() => {
  const nav = document.querySelector('.paper-toc');
  if (!nav) return;

  const entries = Array.from(nav.querySelectorAll('a[href^="#"]'))
    .map((link) => ({ link, section: document.querySelector(link.hash) }))
    .filter(({ section }) => section);
  if (!entries.length) return;

  let scheduled = false;
  const updateCurrentSection = () => {
    scheduled = false;
    const threshold = Math.max(96, window.innerHeight * 0.18);
    let current = entries[0];
    for (const entry of entries) {
      if (entry.section.getBoundingClientRect().top > threshold) break;
      current = entry;
    }
    for (const entry of entries) {
      if (entry === current) {
        entry.link.setAttribute('aria-current', 'location');
      } else {
        entry.link.removeAttribute('aria-current');
      }
    }
    current.link.scrollIntoView({ block: 'nearest' });
  };
  const scheduleUpdate = () => {
    if (scheduled) return;
    scheduled = true;
    window.requestAnimationFrame(updateCurrentSection);
  };

  window.addEventListener('scroll', scheduleUpdate, { passive: true });
  window.addEventListener('resize', scheduleUpdate);
  window.addEventListener('hashchange', scheduleUpdate);
  updateCurrentSection();
})();
</script>"""


def compile_typ(src, out, *flags):
    subprocess.run(
        ["typst", "compile", "--root", str(REPO), *flags, str(src), str(out)],
        check=True,
    )


def validate_paper_css(css):
    """Reject CSS that changes a MathML root from native math layout."""
    css_without_comments = CSS_COMMENT.sub("", css)
    for rule in CSS_RULE.finditer(css_without_comments):
        selectors = rule.group("selectors").split(",")
        targets_math_root = any(
            MATH_ROOT_SELECTOR.search(selector.strip()) for selector in selectors
        )
        if not targets_math_root:
            continue
        if not ORDINARY_MATH_DISPLAY.search(rule.group("declarations")):
            continue
        raise ValueError(
            "paper.css must preserve native MathML layout; "
            "do not set a math root to ordinary display: block or inline"
        )


def validate_html_output(doc, slug):
    """Keep cross-format navigation on the survey landing page."""
    if re.search(r'<a\b[^>]*href="[^"]*manuscript\.pdf(?:[?#][^"]*)?"', doc):
        raise ValueError(
            f"{slug}: manuscript HTML links directly to its PDF; "
            "link to the landing page instead"
        )


def add_section_nav(doc):
    """Derive a compact page navigator from the manuscript's numbered h2s."""
    sections = []

    def prepare_heading(match):
        attrs = match.group("attrs")
        contents = match.group("contents")
        title = html.unescape(TAG.sub("", contents)).strip()
        numbered = SECTION_NUMBER.match(title)
        if not numbered:
            return match.group(0)

        heading_id = re.search(r'\bid="([^"]+)"', attrs)
        if heading_id:
            section_id = heading_id.group(1)
        else:
            section_id = f"section-{numbered.group('number')}"
            attrs += f' id="{section_id}"'
        sections.append((section_id, title))
        return f"<h2{attrs}>{contents}</h2>"

    doc = H2.sub(prepare_heading, doc)
    if not sections:
        return doc

    items = "".join(
        f'<li><a href="#{html.escape(section_id, quote=True)}">'
        f"{html.escape(title)}</a></li>"
        for section_id, title in sections
    )
    nav = (
        '<nav class="paper-toc" aria-label="Contents" data-pagefind-ignore>'
        '<div class="paper-toc-title">Contents</div>'
        f"<ol>{items}</ol></nav>"
    )
    doc = re.sub(
        r"(<body\b[^>]*>)", lambda match: f"{match.group(1)}{nav}", doc, count=1
    )
    return doc.replace("</body>", f"{SECTION_NAV_SCRIPT}</body>", 1)


def main():
    css = CSS.read_text()
    validate_paper_css(css)
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
        validate_html_output(doc, slug)
        doc = doc.replace("</head>", f"<style>{css}</style></head>", 1)
        doc = re.sub(r"<body(?![\w-])", '<body data-pagefind-body', doc, count=1)
        doc = add_section_nav(doc)
        out_html.write_text(doc)
        built.append(slug)
    print(f"built {len(built)}: {', '.join(built)}")
    return 0 if built else 1


if __name__ == "__main__":
    sys.exit(main())
