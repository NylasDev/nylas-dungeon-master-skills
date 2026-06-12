# Nylas Dungeon Master Skills

Public skills for Dungeon Masters and tabletop roleplaying facilitators.

This repository distills practical DM knowledge into reusable `SKILL.md` files that can be loaded by Hermes Agent and other agents that understand the agent skills format.

## What This Is

A growing library of play-ready procedures for:

- Building memorable NPCs
- Designing encounters
- Running improvisation at the table
- Creating factions, rumors, locations, and quests
- Turning lore into usable session material
- Teaching agents to assist a Dungeon Master without stealing the table's spotlight

## Repository Structure

```text
skills/
  tabletop-rpg/
    dungeon-master-assistant/
      SKILL.md
docs/
  skill-authoring.md
```

Each skill lives in its own folder and has a `SKILL.md` file with YAML frontmatter plus Markdown instructions.

## Using a Skill

A skill can be installed directly from its raw GitHub URL, for example:

```bash
hermes skills install https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/dungeon-master-assistant/SKILL.md
```

Or the repository can be added as a skill source:

```bash
hermes skills tap add https://github.com/NylasDev/nylas-dungeon-master-skills
```

## Skill Format

A minimal skill looks like this:

```markdown
---
name: example-skill
description: Use when doing a specific repeatable task.
version: 1.0.0
author: Sergiu Vataman (Nylas)
license: MIT
metadata:
  hermes:
    tags: [tabletop-rpg, dungeon-master]
---

# Example Skill

## Overview
What this skill does.

## When to Use
- Use it when...

## Procedure
1. Do the thing.
2. Verify the result.

## Common Pitfalls
- Avoid this mistake.

## Verification Checklist
- [ ] The output is usable at the table.
```

## License

MIT License. See `LICENSE`.
