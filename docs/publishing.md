# Publishing guide

This repository uses portable Agent Skills: a directory containing `SKILL.md` with YAML frontmatter and Markdown instructions.

## Compatibility goals

The skills should work across:

- `npx skills` / skills.sh style installs.
- Hermes Agent direct installs and taps.
- Claude Code installs through `npx skills`.
- Codex installs through `npx skills`.
- OpenClaw/OpenCode-style installs where the Agent Skills format is supported.
- Future official skill catalog review, if maintainers accept the category and quality bar.

## Skill format requirements

Each skill should live at:

```text
skills/<category>/<skill-name>/SKILL.md
```

Required frontmatter:

```yaml
---
name: skill-name
description: Use when <specific trigger>. Explains <specific workflow>.
version: 1.0.0
author: Sergiu Vataman (Nylas)
license: MIT
metadata:
  hermes:
    tags: [tabletop-rpg, dungeon-master]
    related_skills: []
---
```

Rules:

- `name` must match the parent folder.
- `name` should use lowercase letters, numbers, and hyphens.
- `description` must stay under 1024 characters. Keep it much shorter when possible because some agents use descriptions for discovery.
- The body should be practical: overview, when to use, procedure, templates, pitfalls, and verification.
- Long examples belong in `references/`, `templates/`, or `examples/`, not bloating the first screen of `SKILL.md`.

## npx skills

List skills from GitHub:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --list
```

Use a skill without installing it:

```bash
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master --full-depth
```

Install a skill globally for a supported agent:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master -g -a claude-code -y
```

If a nested skill is not found, add `--full-depth` for commands that support it.

## Hermes Agent

Inspect before installing:

```bash
hermes skills inspect https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md
```

Install directly:

```bash
hermes skills install https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md --category tabletop-rpg --yes
```

Add the GitHub repo as a tap:

```bash
hermes skills tap add NylasDev/nylas-dungeon-master-skills
```

Current Hermes `tap add` expects GitHub shorthand (`owner/repo`), not a full URL.

Publish when the repo is stable:

```bash
hermes skills publish skills/tabletop-rpg/agent-dungeon-master --to github --repo NylasDev/nylas-dungeon-master-skills
```

Run `hermes skills publish --help` before publishing. Do not publish from a dirty branch.

## Claude Code and Codex

Use `npx skills` for first release. It can install Agent Skills into supported agent directories without duplicating the repository layout.

If formal marketplace or plugin distribution becomes useful later, add platform-specific metadata then. Do not duplicate `SKILL.md` files prematurely.

## OpenClaw/OpenCode

Keep the frontmatter portable and avoid Hermes-only assumptions in the skill text. Hermes-specific metadata can live under `metadata.hermes` without breaking other consumers.

## Official catalog path

If submitting to an official skill catalog later:

1. Keep this repository strong first.
2. Include examples, templates, validation output, and a clear README.
3. Expect maintainers to request category, wording, or licensing changes.
4. Submit a separate PR to the target catalog only after `main` installs cleanly from this repo.

## Public release checklist

Before calling a release ready:

- [ ] `python3 scripts/validate-skills.py` passes.
- [ ] `npx --yes skills@latest add . --list` detects all skills.
- [ ] `npx --yes skills@latest use . --skill agent-dungeon-master --full-depth` produces a sensible prompt.
- [ ] README has current install commands.
- [ ] Public examples are original and sourcebook-safe.
- [ ] No assistant/coauthor attribution phrases are present.
- [ ] The branch is pushed and reviewed before merge.
