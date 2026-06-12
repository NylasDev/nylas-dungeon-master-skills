# Skill Authoring Guide

This guide explains how to write Dungeon Master skills for this repository.

## Goal

A good skill should teach an agent a repeatable tabletop procedure, not just describe a topic.

Bad:

> Write about villains.

Better:

> Use this procedure to create a villain with a motive, public mask, private wound, pressure clock, and three ways the party can discover the truth.

## Required Shape

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
author: Nylas
license: MIT
metadata:
  hermes:
    tags: [tabletop-rpg, dungeon-master]
    related_skills: []
---
```

## Recommended Sections

```markdown
# Skill Title

## Overview
What this skill does and why it matters at the table.

## When to Use
Specific triggers.

## Inputs to Ask For
Only ask for what changes the output.

## Procedure
A numbered workflow.

## Output Format
A clear template the agent should produce.

## Common Pitfalls
Mistakes to avoid.

## Verification Checklist
Concrete checks that make the result table-ready.
```

## Writing Rules

- Make the procedure practical enough to use mid-session.
- Prefer tables, bullets, and templates over essays.
- Preserve the Dungeon Master's authority; the skill assists, it does not take over.
- Ask only for missing information that meaningfully changes the result.
- Include verification steps so outputs can be checked before use.
- Avoid vague advice like "make it interesting" unless you define how.

## Quality Bar

A skill is ready when it can produce something useful in under five minutes:

- An encounter
- An NPC
- A location
- A faction
- A rumor table
- A session recap
- A scene transition
- A villain plan

If the result cannot be used at the table, the skill is not finished.
