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

## npx skills checks

```bash
npx --yes skills@latest add . --list
npx --yes skills@latest use . --skill agent-dungeon-master --full-depth | sed -n '1,220p'
npx --yes skills@latest use . --skill dungeon-master-assistant --full-depth | sed -n '1,180p'
```

Expected: both skills are found, and generated prompts include the right operating instructions.

## Hermes checks

Before merge, inspect raw branch URLs if needed. After merge, inspect `main`:

```bash
hermes skills inspect https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md
hermes skills tap add NylasDev/nylas-dungeon-master-skills
```

Hermes tap add expects `owner/repo`.

## Attribution and sourcebook scan

```bash
python3 scripts/validate-skills.py

grep -RInE "Player'?s Handbook|Dungeon Master'?s Guide|Monster Manual|Forgotten Realms|Waterdeep|Strahd|Baldur" README.md CONTRIBUTING.md docs skills examples || true
```

Expected: no assistant/coauthor credit language. Any sourcebook/legal terms that appear should be in sourcebook-hygiene discussion, not copied gameplay material.

## GitHub PR

```bash
git status --short
git add README.md CONTRIBUTING.md docs scripts skills examples .github
git commit -m "feat: prepare dungeon master skills for public release"
git push -u origin HEAD
gh pr create --base main --head "$(git branch --show-current)" --title "feat: prepare dungeon master skills for public release" --body-file /tmp/agent-dm-public-release-pr.md
```

The PR body should include:

- Summary of skill changes.
- New docs, templates, examples, and validation.
- Commands run.
- Note that public examples are original and sourcebook-safe.
- Questions for Nylas about voice, safety level, defaults, and platform packaging.

## After merge

```bash
npx --yes skills@latest add NylasDev/nylas-dungeon-master-skills --list
npx --yes skills@latest use NylasDev/nylas-dungeon-master-skills --skill agent-dungeon-master --full-depth | sed -n '1,180p'
hermes skills inspect https://raw.githubusercontent.com/NylasDev/nylas-dungeon-master-skills/main/skills/tabletop-rpg/agent-dungeon-master/SKILL.md
```
