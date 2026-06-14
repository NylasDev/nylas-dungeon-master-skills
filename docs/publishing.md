# Publishing guide

This repository uses portable Agent Skills: a directory containing `SKILL.md` with YAML frontmatter and Markdown instructions.

## Compatibility goals

The skills should work across:

- Hermes Agent native installs and taps.
- `npx skills` / skills.sh style installs.
- OpenClaw local installs and future ClawHub publishing.
- Claude Code, Codex, OpenCode, Cursor, GitHub Copilot, Gemini CLI, Goose, Windsurf, Zed, Cline, Roo, Kilo, Kiro, Antigravity, Droid, AMP, and other Skills CLI targets.
- Future official skill catalog review, if maintainers accept the category and quality bar.

See `docs/agent-compatibility.md` and `agent-support.json` for the maintained support matrix.

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
platforms: [linux, macos, windows]
compatibility: "Portable Agent Skills format; no external tools required."
homepage: https://github.com/NylasDev/nylas-dungeon-master-skills
user-invocable: true
metadata:
  hermes:
    tags: [tabletop-rpg, dungeon-master]
    related_skills: []
  agentskills:
    category: games
  openclaw:
    always: true
---
```

Rules:

- `name` must match the parent folder.
- `name` should use lowercase letters, numbers, and hyphens.
- `description` must stay under 1024 characters and should stay under 160 characters for OpenClaw/slash-command discovery.
- `homepage` should point to this repository so marketplaces can trace source.
- `user-invocable: true` keeps the skill visible for OpenClaw slash-command discovery.
- `metadata.hermes`, `metadata.agentskills`, and `metadata.openclaw` should all be present.
- The body should be practical: overview, when to use, procedure, templates, pitfalls, and verification.
- Long examples belong in `references/`, `templates/`, or `examples/`, not bloating the first screen of `SKILL.md`.

## npx skills

List skills from GitHub:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --list
```

Use a skill without installing it:

```bash
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills@agent-dungeon-master --full-depth
```

Install a skill globally for a supported agent:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master -g -a hermes-agent -y
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master -g -a openclaw -y
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master -g -a claude-code -y
```

`skills use --agent` currently renders prompts only for a smaller subset of agents, but `skills add --agent` supports the wide install matrix documented in `agent-support.json`.
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

## Claude Code, Codex, OpenCode, and other Skills CLI agents

Use `npx skills` for first release. It can install Agent Skills into supported agent directories without duplicating the repository layout.

Supported target ids are tracked in `agent-support.json`. Add new targets there when the Skills CLI adds new agent integrations.

Do not duplicate `SKILL.md` files into one folder per agent. Agent-specific install details belong in `docs/agent-compatibility.md`; the skill content itself should stay portable.

## OpenClaw

Keep the frontmatter portable and avoid Hermes-only assumptions in the skill text. OpenClaw-specific compatibility metadata lives under `metadata.openclaw` and top-level OpenClaw keys such as `user-invocable` and `homepage`.

For registry distribution, publish each skill directory separately with `clawhub skill publish <path>` after logging in. The docs in `docs/agent-compatibility.md` include the exact commands.

## Official catalog path

If submitting to an official skill catalog later:

1. Keep this repository strong first.
2. Include examples, templates, validation output, and a clear README.
3. Expect maintainers to request category, wording, or licensing changes.
4. Submit a separate PR to the target catalog only after `main` installs cleanly from this repo.

## Public release checklist

Before calling a release ready:

- [ ] `python3 scripts/validate-skills.py` passes.
- [ ] `bash scripts/smoke-agent-installs.sh` passes.
- [ ] `npx --yes skills@latest add . --list` detects all skills.
- [ ] `npx --yes skills@latest use . --skill agent-dungeon-master --full-depth` produces a sensible prompt.
- [ ] README has current install commands.
- [ ] `agent-support.json` matches the documented agent support matrix.
- [ ] Public examples are original and sourcebook-safe.
- [ ] No assistant/coauthor attribution phrases are present.
- [ ] The branch is pushed and reviewed before merge.
