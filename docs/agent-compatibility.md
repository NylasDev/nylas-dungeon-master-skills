# Agent compatibility and installation

This repository uses portable Agent Skills: every skill is a directory containing `SKILL.md` plus optional support files. That format is intentionally boring, which is good. Boring formats survive agent-framework fashion wars.

## First-class targets

| Agent / ecosystem | Target id for `npx skills` | Recommended install | Notes |
|---|---:|---|---|
| Hermes Agent | `hermes-agent` | Hermes native tap or `npx skills` | First-class. Hermes can install raw `SKILL.md` URLs, add this repo as a tap, or receive skills through `npx skills`. |
| OpenClaw | `openclaw` | `npx skills` today, ClawHub publish later | Frontmatter stays OpenClaw-compatible. Native OpenClaw expects lowercase hyphenated `name`, short one-line `description`, and `SKILL.md` per folder. |
| Claude Code | `claude-code` | `npx skills` | Good default for users already using Anthropic tooling. |
| Codex | `codex` | `npx skills` | Good default for OpenAI/Codex users. |
| OpenCode | `opencode` | `npx skills` | Uses the shared Agent Skills layout through the CLI. |
| Cursor | `cursor` | `npx skills` | Project or global installation works through the shared CLI. |
| GitHub Copilot | `github-copilot` | `npx skills` | Useful for VS Code / Copilot skill workflows. |
| Gemini CLI | `gemini-cli` | `npx skills` | Use this id, not plain `gemini`, with the Skills CLI. |
| Goose | `goose` | `npx skills` | Installs into Goose skill directories. |
| Windsurf | `windsurf` | `npx skills` | Installs into Windsurf skill directories. |
| Zed | `zed` | `npx skills` | Installs through the universal `.agents/skills` path where applicable. |
| Cline | `cline` | `npx skills` | Installs through the universal `.agents/skills` path. |
| Roo Code | `roo` | `npx skills` | Installs into Roo skill directories. |
| Kilo Code | `kilo` | `npx skills` | Installs into Kilo skill directories. |
| Kiro CLI | `kiro-cli` | `npx skills` | Installs into Kiro skill directories. |
| Antigravity | `antigravity` / `antigravity-cli` | `npx skills` | Choose the id matching the installed product. |
| Droid | `droid` | `npx skills` | Installs into Factory/Droid skill directories. |
| AMP | `amp` | `npx skills` | Installs into `.agents/skills` style directories. |

The Skills CLI supports more targets than this table. See `agent-support.json` for the maintained compatibility list used by this repository.

## Quick install commands

List skills in this repo:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --list
```

Use without installing:

```bash
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills@agent-dungeon-master --full-depth
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills@dungeon-master-assistant --full-depth
```

Install one skill for one agent:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills \
  --skill agent-dungeon-master \
  --agent hermes-agent \
  --global \
  --yes
```

Install both skills for several common agents:

```bash
for agent in hermes-agent openclaw claude-code codex opencode cursor github-copilot; do
  npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills \
    --skill agent-dungeon-master \
    --skill dungeon-master-assistant \
    --agent "$agent" \
    --global \
    --yes
done
```

Or use the repository helper:

```bash
scripts/install-agent-skills.sh --global \
  --agent hermes-agent \
  --agent openclaw \
  --agent claude-code \
  --agent codex \
  --agent opencode \
  --all-skills
```

## Hermes Agent

Hermes gets the throne room treatment. It can use the generic Skills CLI, but the native Hermes flow is cleaner.

Add this GitHub repo as a tap:

```bash
hermes skills tap add NylasDev/nylas-dungeon-master-skills
hermes skills browse
```

Inspect before installing:

```bash
hermes skills inspect https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md
```

Install directly from raw GitHub URLs:

```bash
hermes skills install https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md --category tabletop-rpg --yes
hermes skills install https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/dungeon-master-assistant/SKILL.md --category tabletop-rpg --yes
```

Load explicitly in a Hermes session:

```text
/skill agent-dungeon-master
```

Or start Hermes with a skill preloaded:

```bash
hermes --skills agent-dungeon-master
```

## OpenClaw

OpenClaw supports `SKILL.md` directories with YAML frontmatter. These skills follow OpenClaw's practical constraints:

- `name` is lowercase hyphenated.
- `description` is one line and under 160 characters.
- `user-invocable: true` is present.
- `homepage` points back to this repository.
- `metadata.openclaw.always: true` marks these as no-dependency skills.
- No environment variables, binaries, or external tools are required.

Install through the Skills CLI:

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills \
  --skill agent-dungeon-master \
  --skill dungeon-master-assistant \
  --agent openclaw \
  --global \
  --yes
```

Native local-workspace option:

```bash
git clone https://github.com/NylasDev/nylas-dungeon-master-skills.git
mkdir -p ~/.openclaw/skills
cp -R nylas-dungeon-master-skills/skills/tabletop-rpg/agent-dungeon-master ~/.openclaw/skills/
cp -R nylas-dungeon-master-skills/skills/tabletop-rpg/dungeon-master-assistant ~/.openclaw/skills/
openclaw skills list
```

Workspace `extraDirs` option:

```json5
{
  skills: {
    load: {
      extraDirs: ["/absolute/path/to/nylas-dungeon-master-skills/skills/tabletop-rpg"],
      watch: true
    }
  },
  agents: {
    defaults: {
      skills: ["agent-dungeon-master", "dungeon-master-assistant"]
    }
  }
}
```

A copy-pasteable example lives at `examples/agent-configs/openclaw.example.jsonc`.

### ClawHub later

When you want OpenClaw registry distribution, publish each skill folder separately after logging into ClawHub:

```bash
npm i -g clawhub
clawhub login
clawhub skill publish skills/tabletop-rpg/agent-dungeon-master \
  --slug agent-dungeon-master \
  --name "Agent Dungeon Master" \
  --version 1.1.0 \
  --tags tabletop-rpg,dungeon-master,solo-rpg
clawhub skill publish skills/tabletop-rpg/dungeon-master-assistant \
  --slug dungeon-master-assistant \
  --name "Dungeon Master Assistant" \
  --version 1.1.0 \
  --tags tabletop-rpg,dungeon-master,prep
```

Do a dry run first if ClawHub supports it in your installed version. Publishing is a public registry action; do it only after the branch is merged and the release checklist is green.

## Validation commands

Run these before announcing compatibility:

```bash
python3 scripts/validate-skills.py
bash scripts/smoke-agent-installs.sh
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --list
```

The smoke script checks local CLI discovery and prompt rendering without installing into your actual agent directories. The `add owner/repo --list` check verifies public GitHub installability.

## Design rules for future compatibility

- Keep `SKILL.md` self-contained enough that agents can use it without Hermes-only tools.
- Put agent-specific instructions in docs, not inside the core play instructions.
- Do not duplicate the same skill body into many agent-specific folders. Duplication creates undead documentation. It always comes back hungry.
- Keep descriptions short because multiple agents use them as discovery text.
- Keep sourcebook hygiene strict; public compatibility is useless if the repo becomes a copyright mimic.
