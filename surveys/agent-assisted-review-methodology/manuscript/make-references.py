#!/usr/bin/env python3
"""Generate references.bib from refs.tsv (citekey<TAB>doi:...|arxiv:...).

Entry keys are rewritten to our citekeys. DOI entries come from doi.org
content negotiation (Crossref/DataCite BibTeX); arXiv entries from the
arxiv.org/bibtex endpoint. Failures are reported and must be hand-added
to references-manual.bib, which is concatenated last.
"""
import re
import sys
import time
import urllib.request
from pathlib import Path

HERE = Path(__file__).parent
OUT = HERE / "references.bib"


def fetch(url, accept=None):
    req = urllib.request.Request(url, headers={"User-Agent": "sys0-bibgen"})
    if accept:
        req.add_header("Accept", accept)
    with urllib.request.urlopen(req, timeout=30) as r:
        return r.read().decode("utf-8", "replace")


def main():
    rows = [
        line.split("\t")
        for line in (HERE / "refs.tsv").read_text().splitlines()
        if line.strip()
    ]
    entries, failed = [], []
    for key, ident in rows:
        try:
            if ident.startswith("doi:"):
                bib = fetch(
                    f"https://doi.org/{ident[4:]}",
                    accept="application/x-bibtex",
                )
            elif ident.startswith("arxiv:"):
                bib = fetch(f"https://arxiv.org/bibtex/{ident[6:]}")
            else:
                raise ValueError(f"unknown id scheme: {ident}")
        except Exception as e:
            failed.append((key, ident, str(e)))
            continue
        bib = bib.strip()
        if not bib.startswith("@"):
            failed.append((key, ident, f"non-bibtex response: {bib[:60]!r}"))
            continue
        bib = re.sub(r"^(@\w+\{)[^,]*,", rf"\g<1>{key},", bib, count=1)
        # Brace name particles so citation styles keep them
        # ("van Dinter et al.", not "Dinter et al.").
        bib = bib.replace("author={van Dinter,", "author={{van Dinter},")
        # Crossref emits month=July; typst's biblatex parser only knows
        # the standard three-letter abbreviations.
        bib = re.sub(
            r"\bmonth=([A-Za-z]+)", lambda m: f"month={m.group(1)[:3].lower()}", bib
        )
        entries.append(bib)
        time.sleep(1)
    manual = HERE / "references-manual.bib"
    body = "\n\n".join(entries) + "\n"
    if manual.exists():
        body += "\n" + manual.read_text()
    OUT.write_text(body)
    print(f"{len(entries)} fetched + manual; {len(failed)} failed")
    for key, ident, err in failed:
        print(f"FAILED: {key} ({ident}): {err}", file=sys.stderr)
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
