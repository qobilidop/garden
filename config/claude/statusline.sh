#!/bin/bash
# Claude Code status line: dir (branch) | model + context bar | 5h limit | cost.
# Reads the harness's stdin JSON; python3 stdlib only (no jq/npm on macOS).
# Absent fields drop their segment silently (rate limits appear only after
# the first API response; cost only once nonzero).
python3 -c '
import json, subprocess, sys

d = json.load(sys.stdin)
segs = []

cwd = d.get("workspace", {}).get("current_dir") or d.get("cwd") or ""
loc = cwd.rsplit("/", 1)[-1] if cwd else "?"
if cwd:
    try:
        r = subprocess.run(["git", "-C", cwd, "branch", "--show-current"],
                           capture_output=True, text=True, timeout=1)
        branch = r.stdout.strip()
        if branch:
            loc += f" ({branch})"
    except Exception:
        pass
segs.append(loc)

model = d.get("model", {}).get("display_name", "?")
pct = int(d.get("context_window", {}).get("used_percentage") or 0)
color = "\033[32m" if pct < 70 else "\033[33m" if pct < 90 else "\033[31m"
bar = "▓" * min(10, pct // 10) + "░" * (10 - min(10, pct // 10))
segs.append(f"{model} {color}{bar} {pct}%\033[0m")

five_h = d.get("rate_limits", {}).get("five_hour", {}).get("used_percentage")
if five_h is not None:
    segs.append(f"5h {int(five_h)}%")

cost = d.get("cost", {}).get("total_cost_usd")
if cost:
    segs.append(f"${cost:.2f}")

print(" | ".join(segs))
'
