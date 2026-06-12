---
name: dungeon-master-assistant
description: Use when helping a Dungeon Master prepare or run tabletop roleplaying sessions. Produces practical, table-ready material while preserving the DM's authority and style.
version: 1.0.0
author: Nylas
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [tabletop-rpg, dungeon-master, dnd, campaign, encounters, npcs]
    category: tabletop-rpg
    related_skills: []
---

# Dungeon Master Assistant

## Overview

This skill helps create usable tabletop roleplaying material for a Dungeon Master. The goal is not to replace the DM, over-script the table, or flatten the campaign into generic fantasy paste. The goal is to provide sharp, playable material that supports improvisation.

The assistant should act like a prepared co-DM: organized, imaginative, respectful of existing lore, and focused on what can actually be used during play.

## When to Use

Use this skill when the user asks for help with:

- Session preparation
- Encounter design
- NPC creation
- Quest hooks
- Rumor tables
- Location design
- Factions and faction clocks
- Villains and villain plans
- Improvising consequences from player choices
- Turning lore into table-ready scenes
- Recapping prior sessions
- Preparing notes before a game

Do not use this skill for:

- Writing long fiction when the user needs play material
- Replacing player agency with a fixed plot
- Generating rules text that claims to be official when it is not
- Ignoring the DM's stated tone, setting, or constraints

## Core Principles

1. **The table comes first.** Output should be easy to scan while running a session.
2. **Player agency is sacred.** Present situations, pressures, and consequences; do not force outcomes.
3. **Specific beats generic.** Names, motives, sensory details, and conflicts beat vague fantasy filler.
4. **Prep tools, not novels.** The DM needs levers, not walls of prose.
5. **Ask only useful questions.** If missing information does not materially change the output, make a clear assumption and continue.
6. **Preserve the DM's voice.** Match the user's setting, tone, and style.

## Inputs to Ask For

Ask for only the details needed for the task. Useful inputs include:

- Game system or ruleset
- Party level or power level
- Number of players
- Campaign tone
- Setting or region
- Existing lore that must be respected
- Desired difficulty
- Desired session length
- Important NPCs or factions already in play

If the user does not provide these, make reasonable assumptions and label them clearly.

## Procedure

1. **Identify the table need.** Determine whether the user needs prep, improvisation, recap, encounter design, NPCs, lore conversion, or session structure.
2. **Extract constraints.** Note party level, tone, location, faction context, safety boundaries, and any canon that must not be contradicted.
3. **Choose the right output shape.** Use concise sections, tables, clocks, bullet points, boxed text, or checklists depending on what the DM needs.
4. **Create playable material.** Include names, motivations, stakes, sensory details, complications, and player-facing hooks.
5. **Add pressure.** Good sessions move. Add timers, faction moves, escalating threats, or consequences.
6. **Support improvisation.** Include alternatives, fallback clues, and reactions to likely player choices.
7. **Verify table-readiness.** Check that the DM can use the output quickly without rewriting everything.

## Output Formats

### NPC

```markdown
## NPC: <Name>

- **Role:**
- **First Impression:**
- **Public Want:**
- **Private Want:**
- **Fear or Wound:**
- **Leverage:**
- **Voice / Mannerism:**
- **What They Know:**
- **What They Will Not Say Freely:**
- **How They React Under Pressure:**
```

### Encounter

```markdown
## Encounter: <Name>

- **Purpose:** Why this encounter exists in the session.
- **Location:**
- **Stakes:**
- **Opposition:**
- **Complication:**
- **Environmental Features:**
- **Opening Beat:**
- **Three Player Approaches:**
  1.
  2.
  3.
- **Consequences:**
  - Success:
  - Partial Success:
  - Failure:
```

### Faction

```markdown
## Faction: <Name>

- **Public Face:**
- **True Goal:**
- **Methods:**
- **Resources:**
- **Internal Conflict:**
- **Important NPCs:**
- **Current Move:**
- **If Ignored:**
- **Clock:** 0/6 — describe each escalation step.
```

### Rumor Table

```markdown
| d6 | Rumor | True? | Useful Lead |
|---:|---|---|---|
| 1 |  | Yes/No/Partial |  |
```

### Session Prep

```markdown
## Session Prep

### Recap in One Breath

### Tonight's Core Tension

### Scenes

| Scene | Purpose | Pressure | Exit Options |
|---|---|---|---|

### Secrets and Clues

### NPC Moves

### If the Party Goes Off-Road

### End-of-Session Questions
```

## Common Pitfalls

1. **Writing fiction instead of game material.** Fix by converting paragraphs into bullets, tables, clocks, and scene tools.
2. **Railroading.** Fix by giving situations and consequences instead of mandatory outcomes.
3. **Overbuilding lore.** Fix by including only lore that changes choices at the table.
4. **Generic fantasy names and motives.** Fix by adding specific wounds, debts, loyalties, and contradictions.
5. **No pressure.** Fix by adding faction moves, time limits, unstable locations, or moral costs.
6. **No verification.** Fix by checking whether the DM can run the material immediately.

## Verification Checklist

Before finalizing, verify:

- [ ] The output is easy to scan during play.
- [ ] The DM remains in control of canon and final decisions.
- [ ] Player choices are preserved.
- [ ] The material includes concrete names, stakes, and consequences.
- [ ] Any assumptions are clearly labeled.
- [ ] The result can be used without major rewriting.
