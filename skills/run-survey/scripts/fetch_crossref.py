#!/usr/bin/env python3
"""Print compact Crossref metadata for one or more DOI arguments."""

import json
import sys
import urllib.parse
import urllib.request
from urllib.error import HTTPError, URLError


def fetch(doi: str) -> dict:
    encoded = urllib.parse.quote(doi, safe="")
    request = urllib.request.Request(
        f"https://api.crossref.org/works/{encoded}",
        headers={
            "User-Agent": "sys0-surveys/0 (mailto:qobilidop@gmail.com)"
        },
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        return json.load(response)["message"]


def main() -> int:
    if len(sys.argv) < 2:
        print(f"usage: {sys.argv[0]} DOI...", file=sys.stderr)
        return 2

    for doi in sys.argv[1:]:
        try:
            metadata = fetch(doi)
        except (HTTPError, URLError, TimeoutError) as error:
            print(
                json.dumps(
                    {"doi": doi, "error": f"{type(error).__name__}: {error}"},
                    sort_keys=True,
                )
            )
            continue
        authors = [
            ", ".join(
                part
                for part in (author.get("given", ""), author.get("family", ""))
                if part
            )
            for author in metadata.get("author", [])
        ]
        record = {
            "doi": metadata.get("DOI", doi),
            "title": metadata.get("title", []),
            "authors": authors,
            "published": metadata.get("published", {}).get("date-parts", []),
            "container": metadata.get("container-title", []),
            "volume": metadata.get("volume"),
            "issue": metadata.get("issue"),
            "page": metadata.get("page"),
            "article_number": metadata.get("article-number"),
            "type": metadata.get("type"),
            "url": metadata.get("URL"),
        }
        print(json.dumps(record, ensure_ascii=False, sort_keys=True))

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
