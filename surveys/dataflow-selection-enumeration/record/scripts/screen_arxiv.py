#!/usr/bin/env python3
"""Freeze arXiv title-and-abstract search results."""

import argparse
import csv
from datetime import date, datetime, timezone
import json
from pathlib import Path
import re
import sys
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET


API_ROOT = "https://export.arxiv.org/api/query"
USER_AGENT = "dataflow-selection-enumeration/0 (mailto:qobilidop@gmail.com)"
FIELDS = (
    "rank",
    "source_id",
    "year",
    "doi",
    "title",
    "venue",
    "type",
    "abstract",
)
ATOM = "http://www.w3.org/2005/Atom"
ARXIV = "http://arxiv.org/schemas/atom"
OPENSEARCH = "http://a9.com/-/spec/opensearch/1.1/"


def normalized_text(element: ET.Element | None) -> str:
    if element is None or element.text is None:
        return ""
    return " ".join(element.text.split())


def conjunctive_query(query: str) -> str:
    terms = re.findall(r"[A-Za-z0-9]+", query)
    if not terms:
        raise SystemExit("query must contain at least one alphanumeric term")
    return " AND ".join(f'all:"{term}"' for term in terms)


def iso_date(value: str) -> str:
    try:
        return date.fromisoformat(value).isoformat()
    except ValueError as error:
        raise argparse.ArgumentTypeError(f"invalid ISO date: {value}") from error


def collect(
    query: str,
    limit: int,
    from_date: str | None = None,
    to_date: str | None = None,
    raw_query: bool = False,
) -> tuple[dict[str, object], list[dict[str, str]]]:
    if (from_date is None) != (to_date is None):
        raise SystemExit("provide both --from-date and --to-date")
    if from_date and from_date > to_date:
        raise SystemExit("--from-date must not be later than --to-date")

    source_query = query if raw_query else conjunctive_query(query)
    if not source_query.strip():
        raise SystemExit("query must not be empty")
    sort_by = "relevance"
    if from_date:
        start = from_date.replace("-", "")
        end = to_date.replace("-", "")
        source_query = (
            f"({source_query}) AND "
            f"submittedDate:[{start}0000 TO {end}2359]"
        )
        sort_by = "submittedDate"
    parameters = {
        "search_query": source_query,
        "start": "0",
        "max_results": str(limit),
        "sortBy": sort_by,
        "sortOrder": "descending",
    }
    url = f"{API_ROOT}?{urllib.parse.urlencode(parameters)}"
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=60) as response:
        root = ET.parse(response).getroot()

    total_text = root.findtext(f"{{{OPENSEARCH}}}totalResults") or "0"
    records = []
    for entry in root.findall(f"{{{ATOM}}}entry"):
        published = normalized_text(entry.find(f"{{{ATOM}}}published"))
        records.append(
            {
                "source_id": normalized_text(entry.find(f"{{{ATOM}}}id")),
                "year": published[:4],
                "doi": normalized_text(entry.find(f"{{{ARXIV}}}doi")),
                "title": normalized_text(entry.find(f"{{{ATOM}}}title")),
                "venue": normalized_text(entry.find(f"{{{ARXIV}}}journal_ref")),
                "type": "arXiv preprint",
                "abstract": normalized_text(entry.find(f"{{{ATOM}}}summary")),
            }
        )
    metadata = {
        "source": "arXiv API",
        "captured_at": datetime.now(timezone.utc).isoformat(),
        "query": query,
        "source_query": source_query,
        "hits": int(total_text),
        "exported": len(records),
        "sort": f"{sort_by} descending",
    }
    if from_date:
        metadata["from_submitted_date"] = from_date
        metadata["until_submitted_date"] = to_date
    return metadata, records


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser()
    result.add_argument("query")
    result.add_argument("--limit", type=int, default=100)
    result.add_argument("--from-date", type=iso_date)
    result.add_argument("--to-date", type=iso_date)
    result.add_argument(
        "--raw-query",
        action="store_true",
        help="interpret QUERY as arXiv API search syntax",
    )
    result.add_argument("--output", type=Path, required=True)
    return result


def main() -> int:
    args = parser().parse_args()
    if not 1 <= args.limit <= 2000:
        raise SystemExit("arXiv search limit must be in 1..2000")
    metadata, records = collect(
        args.query, args.limit, args.from_date, args.to_date, args.raw_query
    )
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(
            output, fieldnames=FIELDS, dialect="excel-tab", lineterminator="\n"
        )
        writer.writeheader()
        for rank, record in enumerate(records, start=1):
            writer.writerow({"rank": rank, **record})
    print(json.dumps(metadata, ensure_ascii=False, sort_keys=True))
    return 0


if __name__ == "__main__":
    sys.exit(main())
