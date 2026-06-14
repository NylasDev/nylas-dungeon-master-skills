# Skill authoring guide

This guide explains how to write Dungeon Master skills for this repository.

## Goal

A good skill teaches an agent a repeatable tabletop procedure. It should help the agent produce something usable at the table, not merely describe a topic.

Bad:

> Write about villains.

Better:

> Use this procedure to create a villain with a motive, public mask, private wound, pressure clock, and three ways the party can discover the truth.

## Skill types

Prefer class-level skills: broad reusable behaviors that an agent can load for a whole class of tasks.

Good examples:

- `agent-dungeon-master`
- `dungeon-master-assistant`
- `villain-and-faction-engine`
- `solo-player-dm`
- `living-world-consequences`

Avoid one-off session skills like `session-1-notes` or `dragon-jump-example`. Put those details in `references/`, `templates/`, or `examples/` under an existing skill.

## Required shape

Every skill should live here:

```text
skills/<category>/<skill-name>/SKILL.md
```

Every `SKILL.md` should start with frontmatter:

```yaml
---
name: skill-name
description: Use when <specific trigger>. Explains <specific workflow>.
version: 1.0.0
author: Sergiu Vataman (Nylas)
license: MIT
platforms: [linux, macos, windows]
compatibility: "Portable Agent Skills format; no external tools required."
homepage: https://github.com/NylasDev/nylas-dungeon-master-skills
user-invocable: true
metadata:
  hermes:
    tags: [tabletop-rpg, dungeon-master]
    category: tabletop-rpg
    related_skills: []
  agentskills:
    category: games
  openclaw:
    always: true
    category: tabletop-rpg
    userInvocable: true
---
```

Rules:

- `name` must match the parent folder.
- `name` should use lowercase letters, numbers, and hyphens.
- `description` must be under 1024 characters, and should stay under 160 characters for OpenClaw/slash-command discovery.
- `homepage` points marketplaces and installers back to the canonical repository.
- `user-invocable: true` keeps the skill available for explicit `/skill`-style invocation.
- `metadata.hermes`, `metadata.agentskills`, and `metadata.openclaw` should all be present.
- The body must not be empty.

## Recommended sections

```markdown
# Skill title

## Overview
What this skill does and why it matters at the table.

## When to use
Specific triggers and counter-triggers.

## Inputs to ask for
Only ask for what changes the output.

## Procedure
A numbered workflow.

## Output format
A clear template the agent should produce.

## Common pitfalls
Mistakes to avoid.

## Verification checklist
Concrete checks that make the result table-ready.
```

Not every skill needs exactly these headings, but every skill needs a clear trigger, a usable procedure, pitfalls, and verification.

## Writing rules

- Make the procedure practical enough to use mid-session.
- Prefer tables, bullets, and templates over essays.
- Preserve player agency; present situations and consequences, not forced outcomes.
- Keep hidden DM information hidden during in-world play.
- Ask only for missing information that meaningfully changes the result.
- Include verification steps so outputs can be checked before use.
- Avoid vague advice like "make it interesting" unless you define how.
- Preserve Nylas' core DM philosophy: PCs are heroes, creativity beats denial, spotlight rotates, rules serve table fun, and the world remembers choices.

## Sourcebook hygiene

Public skills and examples must be original or license-safe. Do not copy rulebook prose, stat blocks, boxed text, adventure room descriptions, protected setting prose, proprietary tables, or class/spell/item text.

If a user provides private source material, use it as private table context. Public repository content should distill methods and write original examples.

## Quality bar

A skill is ready when it can produce something useful in under five minutes:

- An opening scene.
- A ruling.
- An encounter.
- An NPC.
- A location.
- A faction.
- A rumor table.
- A session recap.
- A scene transition.
- A villain plan.
- A campaign ledger update.

If the result cannot be used at the table, the skill is not finished.

## Validation

Run:

```bash
python3 scripts/validate-skills.py
bash scripts/smoke-agent-installs.sh
npx --yes skills@latest add . --list
```

If the skill should be public-release ready, also test `npx skills use` for the changed skill and update `agent-support.json` if platform metadata changes.
