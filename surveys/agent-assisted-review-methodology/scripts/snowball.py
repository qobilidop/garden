#!/usr/bin/env python3
"""One backward+forward snowball round from catalog includes, via
OpenAlex. Yields snowball-candidates.tsv (new keys only), logs per-work
counts to logs/snowball.tsv, raw responses to logs/raw/snowball/.
Pre-filter (decision 0004): keep candidates whose title matches the
review-side vocabulary — bounds the compact scale at a logged recall
risk."""
import csv, json, re, time, urllib.parse, urllib.request, pathlib, datetime, sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
RAWD = ROOT / "logs" / "raw" / "snowball"; RAWD.mkdir(parents=True, exist_ok=True)
MAILTO = "qobilidop@gmail.com"
TODAY = datetime.date.today().isoformat()
TITLE_FILTER = re.compile(r"review|screening|synthesis|extraction|meta-analys|survey|systematic|evidence|literature|prisma|appraisal", re.I)

def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": f"sys0-survey/0.1 (mailto:{MAILTO})"})
    for a in range(3):
        try:
            with urllib.request.urlopen(req, timeout=60) as r: return json.loads(r.read())
        except Exception:
            if a == 2: return None
            time.sleep(4 * (a + 1))

def oa_abstract(inv):
    if not inv: return ""
    pos = {}
    for w, idxs in inv.items():
        for i in idxs: pos[i] = w
    return " ".join(pos[i] for i in sorted(pos))[:900]

def keyof(doi, title):
    if doi:
        d = doi.lower().replace("https://doi.org/", "")
        m = re.match(r"10\.48550/arxiv\.(\d{4}\.\d{4,5})", d)
        return f"arxiv:{m.group(1)}" if m else f"doi:{d}"
    return "t:" + re.sub(r"[^a-z0-9]+", "", (title or "").lower())[:80]

cat = list(csv.DictReader(open(ROOT / "catalog.tsv"), delimiter="\t"))
known = {r["key"] for r in cat}
includes = [r for r in cat if r["decision"] == "I"]
print(f"{len(includes)} includes; resolving OpenAlex records", file=sys.stderr)

new = {}
log = ["key\toa_id\tn_refs\tn_cites_fetched\tnew_from_refs\tnew_from_cites"]
for i, r in enumerate(includes):
    rid = r["id"]; key = r["key"]
    if key.startswith("arxiv:"):
        lookup = "https://api.openalex.org/works/doi:10.48550/arxiv." + key.split(":")[1]
    elif key.startswith("doi:"):
        lookup = "https://api.openalex.org/works/doi:" + urllib.parse.quote(key[4:], safe="")
    else:
        log.append(f"{key}\tno-id\t0\t0\t0\t0"); continue
    w = fetch(lookup + "?mailto=" + MAILTO)
    if not w:
        log.append(f"{key}\tlookup-failed\t0\t0\t0\t0"); continue
    oaid = (w.get("id") or "").rsplit("/", 1)[-1]
    refs = w.get("referenced_works") or []
    nr = nc = 0
    # backward: batch-resolve referenced works (50 per call)
    for j in range(0, len(refs), 50):
        ids = "|".join(x.rsplit("/", 1)[-1] for x in refs[j:j+50])
        data = fetch(f"https://api.openalex.org/works?filter=openalex_id:{ids}&per-page=50&select=id,doi,display_name,publication_year,abstract_inverted_index&mailto={MAILTO}")
        if not data: continue
        for rw in data.get("results", []):
            if (rw.get("publication_year") or 0) < 2020: continue
            t = rw.get("display_name") or ""
            if not TITLE_FILTER.search(t): continue
            k = keyof(rw.get("doi"), t)
            if k in known or k in new: continue
            new[k] = dict(key=k, year=rw.get("publication_year"), title=t,
                          id=rw.get("doi") or rw.get("id"), abstract=oa_abstract(rw.get("abstract_inverted_index")), via=f"bwd:{key}")
            nr += 1
    # forward: works citing this one (first 100 by relevance of recency)
    data = fetch(f"https://api.openalex.org/works?filter=cites:{oaid},from_publication_date:2020-01-01&per-page=100&select=id,doi,display_name,publication_year,abstract_inverted_index&mailto={MAILTO}")
    cited_fetched = 0
    if data:
        cited_fetched = len(data.get("results", []))
        for rw in data.get("results", []):
            t = rw.get("display_name") or ""
            if not TITLE_FILTER.search(t): continue
            k = keyof(rw.get("doi"), t)
            if k in known or k in new: continue
            new[k] = dict(key=k, year=rw.get("publication_year"), title=t,
                          id=rw.get("doi") or rw.get("id"), abstract=oa_abstract(rw.get("abstract_inverted_index")), via=f"fwd:{key}")
            nc += 1
    log.append(f"{key}\t{oaid}\t{len(refs)}\t{cited_fetched}\t{nr}\t{nc}")
    if i % 20 == 0: print(f"  {i}/{len(includes)} done, {len(new)} new so far", file=sys.stderr)
    time.sleep(0.3)

(ROOT / "logs" / "snowball.tsv").write_text("\n".join(log) + "\n")
with open(ROOT / "snowball-candidates.tsv", "w") as f:
    f.write("key\tvia\tyear\ttitle\tid\tabstract\n")
    for k, r in sorted(new.items(), key=lambda kv: str(kv[1]["year"])):
        f.write("\t".join([r["key"], r["via"], str(r["year"] or ""), r["title"].replace("\t", " "),
                           str(r["id"]), r["abstract"].replace("\t", " ").replace("\n", " ")]) + "\n")
print(f"snowball round: {len(new)} new candidates -> snowball-candidates.tsv")
