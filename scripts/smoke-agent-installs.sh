#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

NPM_CACHE="$TMPDIR/npm-cache"
TMP_HOME="$TMPDIR/home"
TMP_XDG="$TMPDIR/config"
mkdir -p "$NPM_CACHE" "$TMP_HOME" "$TMP_XDG"

mapfile -t AGENTS < <(python3 - <<'PY'
import json
from pathlib import Path
support = json.loads(Path("agent-support.json").read_text())
seen = []
for section in ("skills_cli_agents", "first_class_agents"):
    for entry in support[section]:
        agent_id = entry["id"]
        if agent_id not in seen:
            seen.append(agent_id)
for agent_id in seen:
    print(agent_id)
PY
)

python3 scripts/validate-skills.py

npx --yes skills@latest add . --list >"$TMPDIR/list.txt"
python3 - <<'PY' "$TMPDIR/list.txt"
from pathlib import Path
import sys
text = Path(sys.argv[1]).read_text()
for needle in ("agent-dungeon-master", "dungeon-master-assistant"):
    if needle not in text:
        raise SystemExit(f"Missing {needle} from skills list")
PY

npx --yes skills@latest use . --skill agent-dungeon-master --full-depth >"$TMPDIR/agent-dungeon-master.prompt"
python3 - <<'PY' "$TMPDIR/agent-dungeon-master.prompt"
from pathlib import Path
import sys
text = Path(sys.argv[1]).read_text()
for needle in ("# Agent Dungeon Master", "forever-DMs", "Hidden information"):
    if needle not in text:
        raise SystemExit(f"Missing prompt marker: {needle}")
PY

npx --yes skills@latest use . --skill dungeon-master-assistant --full-depth >"$TMPDIR/dungeon-master-assistant.prompt"
python3 - <<'PY' "$TMPDIR/dungeon-master-assistant.prompt"
from pathlib import Path
import sys
text = Path(sys.argv[1]).read_text()
for needle in ("# Dungeon Master Assistant", "Relationship to Agent Dungeon Master"):
    if needle not in text:
        raise SystemExit(f"Missing prompt marker: {needle}")
PY

install_cmd=(
  npx --yes skills@latest add .
  --skill agent-dungeon-master
  --skill dungeon-master-assistant
)
for agent in "${AGENTS[@]}"; do
  install_cmd+=(--agent "$agent")
done
install_cmd+=(--global --copy --yes)

HOME="$TMP_HOME" XDG_CONFIG_HOME="$TMP_XDG" NPM_CONFIG_CACHE="$NPM_CACHE" \
  "${install_cmd[@]}" >"$TMPDIR/wide-agent-install.txt"

python3 - <<'PY' "$TMP_HOME"
from pathlib import Path
import sys
home = Path(sys.argv[1])
expected = [
    home / ".hermes/skills/agent-dungeon-master/SKILL.md",
    home / ".hermes/skills/dungeon-master-assistant/SKILL.md",
    home / ".openclaw/skills/agent-dungeon-master/SKILL.md",
    home / ".openclaw/skills/dungeon-master-assistant/SKILL.md",
    home / ".agents/skills/agent-dungeon-master/SKILL.md",
    home / ".agents/skills/dungeon-master-assistant/SKILL.md",
]
missing = [str(path) for path in expected if not path.exists()]
if missing:
    raise SystemExit("Missing installed skill files:\n" + "\n".join(missing))
PY

python3 -m json.tool agent-support.json >"$TMPDIR/agent-support.pretty.json"

printf 'Smoke checks passed for %s agent target(s).\n' "${#AGENTS[@]}"
