#!/usr/bin/env python3
"""Logged multi-source search for the agent-assisted-review-methodology
survey. Each query: raw JSON to logs/raw/, a row to logs/searches.tsv.
Deduped pool to candidates.tsv. Reruns append new search rows and
rebuild candidates from all raw files present."""
import json, re, sys, time, urllib.parse, urllib.request, pathlib, datetime

ROOT = pathlib.Path(__file__).resolve().parent.parent
RAW = ROOT / "logs" / "raw"; RAW.mkdir(parents=True, exist_ok=True)
LOG = ROOT / "logs" / "searches.tsv"
MAILTO = "qobilidop@gmail.com"
TODAY = datetime.date.today().isoformat()

def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": f"sys0-survey/0.1 (mailto:{MAILTO})"})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(req, timeout=60) as r:
                return json.loads(r.read())
        except Exception as e:
            if attempt == 2: raise
            time.sleep(5 * (attempt + 1))

def oa_abstract(inv):
    if not inv: return ""
    pos = {}
    for w, idxs in inv.items():
        for i in idxs: pos[i] = w
    return " ".join(pos[i] for i in sorted(pos))[:3000]

QUERIES = [
    # (qid, source, human-readable query, url)
    ("oa1", "openalex", '"large language model" "systematic review"', None),
    ("oa2", "openalex", '"large language model" "literature review"', None),
    ("oa3", "openalex", '"language model" "evidence synthesis"', None),
    ("oa4", "openalex", '"citation screening" "language model"', None),
    ("oa5", "openalex", '"data extraction" "large language model" review', None),
    ("s21", "semanticscholar", "large language model systematic review automation", None),
    ("s22", "semanticscholar", "LLM literature review screening agent", None),
    ("s23", "semanticscholar", "evidence synthesis language model reliability", None),
    ("cr1", "crossref", "large language model systematic review automation", None),
    ("ax1", "arxiv", 'all:"systematic review" AND all:"large language model"', None),
    ("ax2", "arxiv", 'all:"literature review" AND all:"language model" AND all:agent', None),
]

def run_query(qid, source, q):
    rows = []
    if source == "openalex":
        url = ("https://api.openalex.org/works?filter=title_and_abstract.search:"
               + urllib.parse.quote(q)
               + ",from_publication_date:2020-01-01&per-page=50&sort=relevance_score:desc&mailto=" + MAILTO)
        data = fetch(url)
        for w in data.get("results", []):
            rows.append(dict(
                id=w.get("doi") or w.get("id"), title=w.get("display_name") or "",
                year=w.get("publication_year"), venue=(w.get("primary_location") or {}).get("source", {}).get("display_name") if (w.get("primary_location") or {}).get("source") else "",
                abstract=oa_abstract(w.get("abstract_inverted_index")), extra=w.get("id") or ""))
    elif source == "semanticscholar":
        url = ("https://api.semanticscholar.org/graph/v1/paper/search?query=" + urllib.parse.quote(q)
               + "&year=2020-&limit=50&fields=title,year,venue,abstract,externalIds,url")
        data = fetch(url)
        for w in data.get("data", []):
            ext = w.get("externalIds") or {}
            wid = ("https://doi.org/" + ext["DOI"]) if ext.get("DOI") else ("arXiv:" + ext["ArXiv"]) if ext.get("ArXiv") else w.get("url") or ""
            rows.append(dict(id=wid, title=w.get("title") or "", year=w.get("year"),
                             venue=w.get("venue") or "", abstract=(w.get("abstract") or "")[:3000], extra=w.get("url") or ""))
    elif source == "crossref":
        url = ("https://api.crossref.org/works?query.bibliographic=" + urllib.parse.quote(q)
               + "&filter=from-pub-date:2020-01-01&rows=50&select=DOI,title,issued,container-title,abstract&mailto=" + MAILTO)
        data = fetch(url)
        for w in data.get("message", {}).get("items", []):
            yr = (w.get("issued", {}).get("date-parts") or [[None]])[0][0]
            rows.append(dict(id="https://doi.org/" + w["DOI"], title=(w.get("title") or [""])[0],
                             year=yr, venue=(w.get("container-title") or [""])[0],
                             abstract=re.sub(r"<[^>]+>", " ", w.get("abstract") or "")[:3000], extra=""))
    elif source == "arxiv":
        url = ("http://export.arxiv.org/api/query?search_query=" + urllib.parse.quote(q)
               + "&start=0&max_results=50&sortBy=relevance")
        req = urllib.request.Request(url, headers={"User-Agent": f"sys0-survey/0.1 (mailto:{MAILTO})"})
        with urllib.request.urlopen(req, timeout=60) as r:
            text = r.read().decode()
        (RAW / f"{qid}-{source}.xml").write_text(text)
        entries = re.findall(r"<entry>(.*?)</entry>", text, re.S)
        for e in entries:
            def tag(t):
                m = re.search(rf"<{t}[^>]*>(.*?)</{t}>", e, re.S)
                return re.sub(r"\s+", " ", m.group(1)).strip() if m else ""
            aid = tag("id")
            year = (tag("published") or "")[:4]
            if year and int(year) < 2020: continue
            rows.append(dict(id=aid, title=tag("title"), year=year, venue="arXiv",
                             abstract=tag("summary")[:3000], extra=aid))
        return rows
    (RAW / f"{qid}-{source}.json").write_text(json.dumps(data, indent=1))
    return rows

def norm_title(t):
    return re.sub(r"[^a-z0-9]+", "", t.lower())[:80]

def main():
    all_rows = {}
    log_lines = []
    if not LOG.exists():
        log_lines.append("date\tqid\tsource\tquery\tresults")
    for qid, source, q, _ in QUERIES:
        try:
            rows = run_query(qid, source, q)
        except Exception as e:
            print(f"{qid} FAILED: {e}", file=sys.stderr)
            log_lines.append(f"{TODAY}\t{qid}\t{source}\t{q}\tFAILED:{e}")
            continue
        log_lines.append(f"{TODAY}\t{qid}\t{source}\t{q}\t{len(rows)}")
        print(f"{qid} {source}: {len(rows)}")
        for r in rows:
            key = None
            rid = (r["id"] or "").lower()
            m = re.search(r"10\.\d{4,}[^\s]*", rid)
            if m: key = "doi:" + m.group(0)
            elif "arxiv" in rid:
                m2 = re.search(r"(\d{4}\.\d{4,5})", rid)
                key = ("arxiv:" + m2.group(1)) if m2 else rid
            else: key = "t:" + norm_title(r["title"])
            if key in all_rows:
                all_rows[key]["qids"] += "," + qid
            else:
                r["qids"] = qid; all_rows[key] = r
        time.sleep(1.5)
    with open(LOG, "a") as f:
        f.write("\n".join(log_lines) + "\n")
    out = ROOT / "candidates.tsv"
    with open(out, "w") as f:
        f.write("key\tqids\tyear\ttitle\tvenue\tid\tabstract\n")
        for key, r in sorted(all_rows.items(), key=lambda kv: str(kv[1].get("year") or "")):
            f.write("\t".join([key, r["qids"], str(r.get("year") or ""),
                               r["title"].replace("\t", " "), str(r.get("venue") or "").replace("\t", " "),
                               str(r["id"]), r["abstract"].replace("\t", " ").replace("\n", " ")]) + "\n")
    print(f"pool: {len(all_rows)} unique candidates -> {out}")

if __name__ == "__main__":
    main()
