# Release checklist

Run this before calling the repository public-release ready.

## Branch state

```bash
git fetch origin --prune
git status --short --branch
git log --oneline origin/main..HEAD
```

Expected: a focused release branch, not `main`, with only intended commits ahead of `origin/main`.

## Skill validation

```bash
python3 scripts/validate-skills.py
```

Expected: zero errors.

## npx skills and agent compatibility checks

```bash
bash scripts/smoke-agent-installs.sh
npx --yes skills@latest add . --list
npx --yes skills@latest use . --skill agent-dungeon-master --full-depth
npx --yes skills@latest use . --skill dungeon-master-assistant --full-depth
```

Expected: both skills are found, prompts include the right operating instructions, and temporary installs for Hermes Agent and OpenClaw create the expected skill files.

## Hermes and OpenClaw checks

Before merge, inspect raw branch URLs if needed. After merge, inspect `main`:

```bash
hermes skills inspect https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md
hermes skills tap add NylasDev/nylas-dungeon-master-skills
npx --yes skills@latest add . --skill agent-dungeon-master --skill dungeon-master-assistant --agent hermes-agent --global --copy --yes
npx --yes skills@latest add . --skill agent-dungeon-master --skill dungeon-master-assistant --agent openclaw --global --copy --yes
```

Hermes tap add expects `owner/repo`. For local destructive hygiene, run global install smoke tests with a temporary `HOME` as `scripts/smoke-agent-installs.sh` does.

## Attribution and sourcebook scan

```bash
python3 scripts/validate-skills.py

grep -RInE "Player'?s Handbook|Dungeon Master'?s Guide|Monster Manual|Forgotten Realms|Waterdeep|Strahd|Baldur" README.md CONTRIBUTING.md docs skills examples || true
```

Expected: no assistant/coauthor credit language. Any sourcebook/legal terms that appear should be in sourcebook-hygiene discussion, not copied gameplay material.

## GitHub PR

```bash
git status --short
git add README.md CONTRIBUTING.md agent-support.json docs scripts skills examples .github
git commit -m "feat: add multi-agent skill support"
git push -u origin HEAD
gh pr create --base main --head "$(git branch --show-current)" --title "feat: add multi-agent skill support" --body-file /tmp/agent-support-pr.md
```

The PR body should include:

- Summary of compatibility metadata and docs changes.
- Agent support matrix updates.
- New install helper and smoke validation.
- Commands run.
- Note that public examples remain original and sourcebook-safe.

## After merge

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --list
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master --full-depth | sed -n '1,180p'
hermes skills inspect https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md
```
