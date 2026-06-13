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

## Install with npx skills

List the skills in this repo:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --list
```

Install a specific skill globally for a supported agent:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master -g -a claude-code -y
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --skill dungeon-master-assistant -g -a claude-code -y
```

Use a skill without installing it:

```bash
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master --full-depth
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master --agent codex --full-depth
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
docs/
  publishing.md
  release-checklist.md
  skill-authoring.md
examples/
  agent-dungeon-master/
    live-play-turn.md
    solo-campaign-start.md
scripts/
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
