# Build Your Own Heroes3-Style Game With VCMI

This tutorial is a practical path from "I installed VCMI" to "I have my own playable game variant".
It focuses on fast feedback first, then scalable mod architecture.

## What You Will Build

By the end of this tutorial, you will have:

1. Your own mod folder with proper `mod.json`.
2. A gameplay tweak that changes core units (first milestone).
3. A test map that uses your mod.
4. A clear roadmap to evolve into a full custom game experience.

## Prerequisites

1. VCMI installed and running.
2. Heroes III data available to VCMI (or your own compatible assets/content setup).
3. A text editor for JSON files.

See platform setup guides in [docs/Readme.md](../Readme.md).

## Milestone 1: First Working Mod In 15 Minutes

### 1) Create your mod folder

In your VCMI data directory:

```text
Mods/
  mytotalconversion/
    mod.json
    Content/
      config/
```

Structure details are described in [Readme.md](Readme.md).

### 2) Create `mod.json`

Create `Mods/mytotalconversion/mod.json`:

```json
{
  "name": "My Total Conversion",
  "description": "My own Heroes3-style version built with VCMI",
  "author": "YourName",
  "version": "0.1.0",
  "modType": "Mechanics",
  "contact": "https://example.com",
  "creatures": [
    "config/creatures.json"
  ]
}
```

Field reference: [Mod_File_Format.md](Mod_File_Format.md).

### 3) Add one gameplay change

Create `Mods/mytotalconversion/Content/config/creatures.json`:

```json
{
  "core:archer": {
    "hitPoints": 12,
    "speed": 5
  },
  "core:marksman": {
    "hitPoints": 12,
    "shots": 30
  }
}
```

This modifies existing units from base game using `core:<id>` syntax.  
Identifier rules: [Game_Identifiers.md](Game_Identifiers.md).

### 4) Enable the mod and test

1. Open VCMI Launcher.
2. Enable `My Total Conversion`.
3. Start a map with Castle units and verify Archer/Marksman stats changed.

If changes do not appear, check JSON syntax and file paths first.

## Milestone 2: Add Your Own Content

After the first successful tweak, move to custom content in this order:

1. New creatures: [Entities_Format/Creature_Format.md](Entities_Format/Creature_Format.md).
2. New factions/towns: [Entities_Format/Faction_Format.md](Entities_Format/Faction_Format.md).
3. New adventure objects: [Map_Object_Format.md](Map_Object_Format.md).
4. New spells/skills/artifacts (same pattern: define JSON + reference in `mod.json`).

Recommended workflow:

1. Clone one existing object and rename IDs.
2. Make it load without conflicts.
3. Replace graphics/sounds incrementally.
4. Test after each small change.

## Milestone 3: Build Your Own World (Maps and Campaigns)

### Map creation

Use VCMI Map Editor to create maps that showcase your mod content:

- Editor guide: [Map_Editor.md](Map_Editor.md)
- Place your custom objects and units
- Save as `.vmap` for VCMI-native workflow

### Campaign creation

For multi-scenario progression:

- Campaign format: [Campaign_Format.md](Campaign_Format.md)

## Milestone 4: Production-Ready Mod Structure

As your project grows, keep this layout:

```text
Mods/mytotalconversion/
  mod.json
  Content/
    config/
      creatures.json
      factions.json
      heroes.json
      spells.json
      objects.json
      artifacts.json
    sprites/
    data/
    sounds/
    music/
    maps/
    video/
```

Supported media formats: [File_Formats.md](File_Formats.md).

## Milestone 5: Balance, Compatibility, and Releases

### Balance loop

1. Change a small set of numbers.
2. Play 2-3 test scenarios.
3. Keep notes for each version in `changelog`.
4. Repeat.

### Compatibility loop

1. Declare `depends`, `softDepends`, and `conflicts` in `mod.json` when needed.
2. Prefer additive JSON operations for lists to reduce conflicts (see [Readme.md](Readme.md)).

### Release loop

1. Tag versions clearly (`0.1.0`, `0.2.0`, `1.0.0`).
2. Keep one stable branch players can trust.
3. Publish to a repository and optionally integrate with VCMI mod distribution workflow.

Publishing notes: [Readme.md](Readme.md) section "Publishing mods in VCMI Repository".

## Suggested 30-Day Plan

1. Week 1: core rebalance mod + first playable map.
2. Week 2: 3-7 custom creatures + unique faction identity draft.
3. Week 3: faction/town implementation + signature mechanics.
4. Week 4: campaign prototype, bug fixing, first public release.

## Common Pitfalls

1. Invalid JSON (missing comma/bracket).
2. Wrong path case in assets (`Sprites` vs `sprites` on case-sensitive platforms).
3. Reusing IDs that collide with other mods.
4. Making too many gameplay changes before first stable test build.

## Next Docs To Open

1. [Mod_File_Format.md](Mod_File_Format.md)
2. [Game_Identifiers.md](Game_Identifiers.md)
3. [Entities_Format/Creature_Format.md](Entities_Format/Creature_Format.md)
4. [Entities_Format/Faction_Format.md](Entities_Format/Faction_Format.md)
5. [Map_Editor.md](Map_Editor.md)

