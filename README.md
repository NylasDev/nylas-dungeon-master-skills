# Nylas Dungeon Master Skills

Public agent skills for running and preparing tabletop roleplaying games.

The main promise is simple: agents should be able to DM complete campaigns, especially for forever-DMs who want to be the player character and hero for once. The skills here teach agents to run scenes, preserve hidden information, rotate spotlight, make rulings, track consequences, and keep the table fun without copying protected rulebook text.

## Who this is for

- Players who want an agent to run a solo or small-party campaign.
- Forever-DMs who want to experience mystery, danger, and discovery from the player side.
- Human DMs who want table-ready prep help.
- Agent builders who want portable `SKILL.md` files for tabletop RPG workflows.

## Available skills

| Skill | Use when |
|---|---|
| `agent-dungeon-master` | An agent should run a tabletop RPG or solo campaign as the DM. |
| `dungeon-master-assistant` | A human DM wants prep, NPCs, encounters, factions, recaps, or table-ready notes. |

## Quick start

List the skills in this repo:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --list
```

Use a skill without installing it:

```bash
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills@agent-dungeon-master --full-depth
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills@dungeon-master-assistant --full-depth
```

Install both skills directly into Hermes Agent and OpenClaw:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills \
  --skill agent-dungeon-master \
  --skill dungeon-master-assistant \
  --agent hermes-agent \
  --agent openclaw \
  --global \
  --copy \
  --yes
```

Install for Claude Code and Codex instead:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills \
  --skill agent-dungeon-master \
  --skill dungeon-master-assistant \
  --agent claude-code \
  --agent codex \
  --global \
  --copy \
  --yes
```

Important little CLI goblin: `skills use --agent` currently renders prompts for a smaller set of agents, but `skills add --agent` is the wide install path. Do not use `skills use --agent hermes-agent` as proof Hermes is unsupported.

## Agent compatibility

This repo now documents and validates wide agent support instead of just hoping every agent goblin guesses correctly.

- First-class targets: Hermes Agent and OpenClaw.
- Skills CLI targets include Claude Code, Codex, OpenCode, Cursor, GitHub Copilot, Gemini CLI, Goose, Windsurf, Zed, Cline, Roo, Kilo, Kiro, Antigravity, Droid, and AMP.
- Compatibility metadata lives in each `SKILL.md` under `metadata.hermes`, `metadata.agentskills`, and `metadata.openclaw`.
- The support matrix lives in `agent-support.json`.
- Full install notes live in `docs/agent-compatibility.md`.
- Helper installer: `scripts/install-agent-skills.sh`.

Install from a local clone with the helper script:

```bash
git clone https://github.com/NylasDev/nylas-dungeon-master-skills.git
cd nylas-dungeon-master-skills
scripts/install-agent-skills.sh --global --copy --all-skills --agent hermes-agent --agent openclaw
```

Run non-destructive compatibility smoke checks from a clone:

```bash
bash scripts/smoke-agent-installs.sh
```

## Install with Hermes Agent

Install directly from raw GitHub URLs:

```bash
hermes skills install https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md --category tabletop-rpg --yes
hermes skills install https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/dungeon-master-assistant/SKILL.md --category tabletop-rpg --yes
```

Add the repository as a Hermes skill tap:

```bash
hermes skills tap add NylasDev/nylas-dungeon-master-skills
```

Inspect a skill before installing it:

```bash
hermes skills inspect https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md
```

## Repository structure

```text
README.md
LICENSE
CONTRIBUTING.md
agent-support.json
docs/
  agent-compatibility.md
  publishing.md
  release-checklist.md
  skill-authoring.md
examples/
  agent-configs/
    openclaw.example.jsonc
  agent-dungeon-master/
    live-play-turn.md
    solo-campaign-start.md
scripts/
  install-agent-skills.sh
  smoke-agent-installs.sh
  validate-skills.py
skills/
  tabletop-rpg/
    agent-dungeon-master/
      SKILL.md
      references/
      templates/
    dungeon-master-assistant/
      SKILL.md
```

Each skill lives in its own folder and has a `SKILL.md` file with YAML frontmatter plus Markdown instructions. Long examples, templates, and support material live beside the skill in `references/` and `templates/`.

## Examples

- `examples/agent-dungeon-master/solo-campaign-start.md` shows a safe original solo campaign opener.
- `examples/agent-dungeon-master/live-play-turn.md` shows the difference between interactive DM play and prose that steals agency.

## Validation

Run the local validator before opening a PR:

```bash
python3 scripts/validate-skills.py
bash scripts/smoke-agent-installs.sh
npx --yes skills@latest add . --list
npx --yes skills@latest use . --skill agent-dungeon-master --full-depth
```

The validator checks skill frontmatter, names, descriptions, author/license fields, missing support files, and public attribution hygiene.

## Sourcebook and legal hygiene

This repository teaches DM craft. It does not republish rulebooks, adventures, stat blocks, boxed text, protected setting prose, or proprietary tables.

If a user provides private campaign material or a book they own, an agent may use it as private context for that user's table. Public repo content should extract original procedures and examples instead of copying protected expression. See `skills/tabletop-rpg/agent-dungeon-master/references/sourcebook-hygiene.md`.

## Contributing

Read `CONTRIBUTING.md` and `docs/skill-authoring.md` before opening a PR. Prefer class-level skills and support files over tiny one-off skills.

## License

MIT License. See `LICENSE`.
