#!/usr/bin/env python3
"""Generate references.bib from references.tsv (citekey<TAB>doi:...|arxiv:...).

Usage: make_references.py --manuscript surveys/<slug>/manuscript

Entry keys are rewritten to our citekeys. DOI entries come from doi.org
content negotiation (Crossref/DataCite BibTeX); arXiv entries from the
arxiv.org/bibtex endpoint. Failures leave the existing output untouched;
an entry added to references-manual.bib satisfies the same citekey.
"""
import argparse
import html
import os
import re
import sys
import tempfile
import time
import urllib.request
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("--manuscript", required=True, type=Path,
                    help="manuscript directory holding references.tsv")
HERE = parser.parse_args().manuscript.resolve()
OUT = HERE / "references.bib"


def split_fields(body):
    """Split a BibTeX entry body into fields at brace depth zero."""
    fields, depth, cur = [], 0, []
    for ch in body:
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
        if ch == "," and depth == 0:
            fields.append("".join(cur))
            cur = []
        else:
            cur.append(ch)
    fields.append("".join(cur))
    return [f.strip() for f in fields if f.strip()]


def fmt(entry):
    """Re-emit an entry in canonical layout: one lowercased field per
    line, values verbatim. Sources differ (Crossref: one line; arXiv:
    multi-line; manual: hand-wrapped) — this makes them uniform."""
    m = re.match(r"@(\w+)\s*\{\s*([^,]*),(.*)\}\s*$", entry.strip(), re.S)
    if not m:
        return entry.strip()
    kind, key, body = m.groups()
    lines = []
    for field in split_fields(body):
        name, _, value = field.partition("=")
        name, value = name.strip().lower(), html.unescape(value.strip())
        if name == "doi":
            value = value.replace("{https://doi.org/", "{")
        if name == "pages":
            repeated = re.fullmatch(r"\{([^{}]+?)(?:--|–|-)\1\}", value)
            if repeated:
                value = "{" + repeated.group(1) + "}"
        lines.append(f"  {name} = {value},")
    return "@" + kind.lower() + "{" + key.strip() + ",\n" + "\n".join(lines) + "\n}"


def fetch(url, accept=None):
    req = urllib.request.Request(url, headers={"User-Agent": "sys0-bibgen"})
    if accept:
        req.add_header("Accept", accept)
    with urllib.request.urlopen(req, timeout=30) as r:
        return r.read().decode("utf-8", "replace")


def entries_from(raw):
    """Parse and canonically format every BibTeX entry in raw.

    Anything before the first entry (header comments) is preamble, not
    an entry."""
    return [fmt("@" + entry) for entry in re.split(r"^@", raw, flags=re.M)[1:] if entry.strip()]


def entry_key(entry):
    match = re.match(r"@\w+\s*\{\s*([^,]+),", entry)
    if not match:
        raise ValueError(f"cannot parse BibTeX key: {entry[:60]!r}")
    return match.group(1).strip()


def main():
    rows = []
    for lineno, line in enumerate(
        (HERE / "references.tsv").read_text().splitlines(), start=1
    ):
        if not line.strip():
            continue
        fields = line.split("\t")
        if len(fields) != 2 or not all(fields):
            print(
                f"FAILED: references.tsv:{lineno}: expected citekey<TAB>identifier",
                file=sys.stderr,
            )
            return 1
        rows.append(tuple(fields))

    keys = [key for key, _ in rows]
    identifiers = [ident for _, ident in rows]
    if len(keys) != len(set(keys)):
        print("FAILED: duplicate citekey in references.tsv", file=sys.stderr)
        return 1
    if len(identifiers) != len(set(identifiers)):
        print("FAILED: duplicate identifier in references.tsv", file=sys.stderr)
        return 1

    manual = HERE / "references-manual.bib"
    manual_entries = entries_from(manual.read_text()) if manual.exists() else []
    manual_keys = [entry_key(entry) for entry in manual_entries]
    if len(manual_keys) != len(set(manual_keys)):
        print("FAILED: duplicate citekey in references-manual.bib", file=sys.stderr)
        return 1

    entries, failed = [], []
    for key, ident in rows:
        if key in manual_keys:
            continue
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
        if ident.startswith("arxiv:"):
            bib = re.sub(r"^@misc", "@article", bib, count=1, flags=re.I)
            if not re.search(r"\bjournal\s*=", bib, flags=re.I):
                bib = re.sub(
                    r",?\s*\}\s*$",
                    f",\n  journal={{arXiv preprint arXiv:{ident[6:]}}}\n}}",
                    bib,
                    count=1,
                )
        # Brace name particles so citation styles keep them
        # ("van Dinter et al.", not "Dinter et al.").
        bib = bib.replace("author={van Dinter,", "author={{van Dinter},")
        # Crossref emits month=July; typst's biblatex parser only knows
        # the standard three-letter abbreviations.
        bib = re.sub(
            r"\bmonth=([A-Za-z]+)", lambda m: f"month={m.group(1)[:3].lower()}", bib
        )
        entries.append(fmt(bib))
        time.sleep(1)
    if failed:
        print(f"no output written ({len(failed)} unresolved entries)", file=sys.stderr)
        for key, ident, err in failed:
            print(f"FAILED: {key} ({ident}): {err}", file=sys.stderr)
        return 1

    entries.extend(manual_entries)
    marker = (
        "% Generated by make-references.py — edit references.tsv or\n"
        "% references-manual.bib instead; hand edits here are overwritten.\n\n"
    )
    payload = marker + "\n\n".join(entries) + "\n"
    fd, tmp_name = tempfile.mkstemp(dir=HERE, prefix=".references.", suffix=".tmp")
    try:
        with os.fdopen(fd, "w") as tmp:
            tmp.write(payload)
            tmp.flush()
            os.fsync(tmp.fileno())
        os.replace(tmp_name, OUT)
    finally:
        if os.path.exists(tmp_name):
            os.unlink(tmp_name)
    print(f"{len(entries)} entries (0 failed)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
