#!/usr/bin/env bash
set -euo pipefail

SOURCE="${SKILL_SOURCE:-NylasDev/nylas-dungeon-master-skills}"
GLOBAL=0
YES=1
COPY=0
ALL_SKILLS=0
SKILLS=()
AGENTS=()
LIST_ONLY=0
HERMES_NATIVE=0

usage() {
  cat <<'USAGE'
Install the Dungeon Master skills into one or more agent skill directories.

Usage:
  scripts/install-agent-skills.sh [options]

Options:
  --agent <id>        Agent target for npx skills, repeatable.
                      Examples: hermes-agent, openclaw, claude-code, codex,
                      opencode, cursor, github-copilot, gemini-cli.
  --skill <name>      Skill to install, repeatable. Defaults to agent-dungeon-master.
  --all-skills        Install both repository skills.
  --global, -g        Install globally/user-level instead of project-level.
  --project           Install project-level (default).
  --copy              Copy files instead of symlinking where supported.
  --source <source>   Source repo or path. Default: NylasDev/nylas-dungeon-master-skills.
  --list              Only list skills in the source; do not install.
  --hermes-native     Use Hermes native tap/raw install instead of npx skills.
  --help, -h          Show this help.

Examples:
  scripts/install-agent-skills.sh --global --agent hermes-agent --all-skills
  scripts/install-agent-skills.sh --global --agent openclaw --all-skills
  scripts/install-agent-skills.sh --agent claude-code --agent codex --skill agent-dungeon-master
  scripts/install-agent-skills.sh --hermes-native
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent|-a)
      AGENTS+=("$2")
      shift 2
      ;;
    --skill|-s)
      SKILLS+=("$2")
      shift 2
      ;;
    --all-skills)
      ALL_SKILLS=1
      shift
      ;;
    --global|-g)
      GLOBAL=1
      shift
      ;;
    --project)
      GLOBAL=0
      shift
      ;;
    --copy)
      COPY=1
      shift
      ;;
    --source)
      SOURCE="$2"
      shift 2
      ;;
    --list)
      LIST_ONLY=1
      shift
      ;;
    --hermes-native)
      HERMES_NATIVE=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ "$ALL_SKILLS" == "1" ]]; then
  SKILLS=(agent-dungeon-master dungeon-master-assistant)
elif [[ ${#SKILLS[@]} -eq 0 ]]; then
  SKILLS=(agent-dungeon-master)
fi

if [[ "$HERMES_NATIVE" == "1" ]]; then
  if ! command -v hermes >/dev/null 2>&1; then
    echo "hermes command not found. Install Hermes Agent or omit --hermes-native." >&2
    exit 1
  fi
  hermes skills tap add NylasDev/nylas-dungeon-master-skills || true
  for skill in "${SKILLS[@]}"; do
    hermes skills install "https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/${skill}/SKILL.md" --category tabletop-rpg --yes
  done
  exit 0
fi

SKILLS_CMD=(npx --yes skills@latest)

if [[ "$LIST_ONLY" == "1" ]]; then
  "${SKILLS_CMD[@]}" add "$SOURCE" --list
  exit 0
fi

if [[ ${#AGENTS[@]} -eq 0 ]]; then
  echo "No --agent provided. Listing available skills instead of guessing where to install." >&2
  "${SKILLS_CMD[@]}" add "$SOURCE" --list
  echo >&2
  echo "Re-run with one or more --agent values, e.g. --agent hermes-agent --agent openclaw." >&2
  exit 0
fi

cmd=("${SKILLS_CMD[@]}" add "$SOURCE")
for skill in "${SKILLS[@]}"; do
  cmd+=(--skill "$skill")
done
for agent in "${AGENTS[@]}"; do
  cmd+=(--agent "$agent")
done
if [[ "$GLOBAL" == "1" ]]; then
  cmd+=(--global)
fi
if [[ "$COPY" == "1" ]]; then
  cmd+=(--copy)
fi
if [[ "$YES" == "1" ]]; then
  cmd+=(--yes)
fi

printf 'Running:'
printf ' %q' "${cmd[@]}"
printf '\n'
exec "${cmd[@]}"
