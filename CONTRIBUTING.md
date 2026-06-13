# Contributing

Thanks for helping make this skill library useful instead of turning it into another dusty binder of fantasy mush.

## Project goal

This repository teaches agents how to run and support tabletop roleplaying games. The core direction is `agent-dungeon-master`: an agent that can DM a complete campaign, especially for forever-DMs who want to play as the hero.

`dungeon-master-assistant` is still useful, but it supports a human DM. Do not blur those roles.

## Public author and license

Use this author field in public skill frontmatter:

```yaml
author: Sergiu Vataman (Nylas)
license: MIT
```

The license copyright should remain:

```text
Copyright (c) 2026 Sergiu Vataman (Nylas)
```

Do not add assistant attribution, coauthor trailers, or generated-by footers unless the maintainer explicitly asks for them.

## Skill shape

Prefer class-level skills.

Good:

- `agent-dungeon-master`
- `dungeon-master-assistant`
- `villain-and-faction-engine`
- `solo-player-dm`
- `living-world-consequences`

Bad:

- `session-one-notes`
- `dragon-jump-example`
- `fix-readme-today`
- `nylas-feedback-june-12`

Session-specific notes belong in `references/`, `templates/`, or `examples/` under an existing skill.

## Writing rules

- Write practical procedures, not essays.
- Preserve player agency.
- Keep hidden DM information hidden during play.
- Rotate spotlight across player tastes.
- Turn wild ideas into rolls, costs, complications, or mini-games where possible.
- Use bullets, tables, and templates when they help the DM at the table.
- Avoid generic fantasy filler.
- Keep public examples original.

## Sourcebook hygiene

Do not copy protected material into public repo files.

Avoid publishing:

- Rulebook prose.
- Stat blocks.
- Boxed text.
- Adventure room descriptions.
- Protected setting prose.
- Proprietary tables.
- Class, spell, item, feat, or monster text from protected sources.

If a user provides private material, use it as private context for that user's table. Public contributions should extract methods and write original examples.

See `skills/tabletop-rpg/agent-dungeon-master/references/sourcebook-hygiene.md`.

## Validation

Before opening a PR, run:

```bash
python3 scripts/validate-skills.py
npx --yes skills@latest add . --list
```

If you changed `agent-dungeon-master`, also run:

```bash
npx --yes skills@latest use . --skill agent-dungeon-master --full-depth
```

## PR checklist

- [ ] The branch is not `main`.
- [ ] New skills are class-level or the content is placed under an existing skill.
- [ ] Every `SKILL.md` starts with YAML frontmatter.
- [ ] `name` matches the parent directory.
- [ ] Descriptions are concise and under 1024 characters.
- [ ] Public examples are original.
- [ ] No assistant/coauthor/generated-by attribution appears.
- [ ] Validation passes.
- [ ] The PR explains what philosophy, workflow, or public packaging changed.
