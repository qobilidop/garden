#!/bin/bash
# Claude Code status line: model name + context-usage bar.
# Reads the harness's stdin JSON; python3 (no jq dependency on macOS).
python3 -c '
import json, sys
d = json.load(sys.stdin)
model = d.get("model", {}).get("display_name", "?")
pct = d.get("context_window", {}).get("used_percentage") or 0
pct = int(pct)
filled = min(10, pct // 10)
bar = "▓" * filled + "░" * (10 - filled)
print(f"[{model}] {bar} {pct}%")
'
