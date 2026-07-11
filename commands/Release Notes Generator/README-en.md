# Release Notes Generator

A Claude Code custom command that analyses the project's git history and generates `release-notes.md` with the "What's New" text ready for App Store Connect, plus a complete technical changelog.

---

## How it works

```
Claude Code (inside the project)
──────────────────────────────────────────────────
Determines the range (last tag → HEAD, or arguments)
Classifies commits (feature / improvement / fix / internal)
Reads diffs when the message isn't enough
Detects the project's version and language
         ↓
release-notes.md
```

Internal entries (refactors, CI, chores) stay in the technical changelog but never appear in the user-facing notes. The App Store Connect text is written in user-centric language and verified against the 4,000-character limit.

---

## Usage

```
/release-notes                  # from the last tag to HEAD
/release-notes v1.2.0           # from v1.2.0 to HEAD
/release-notes v1.2.0 v1.3.0    # explicit range
```

## Installation

From the repository root run `./install.sh`, or:

```bash
mkdir -p ~/.claude/commands
cp release-notes.md ~/.claude/commands/release-notes.md
```

The command will be available in Claude Code as `/release-notes`.

---

## Notes

- The "What's New" text is generated in the project's primary language **and** in English.
- No invented features: if the range contains no user-visible changes, the command says so and proposes a minimal text, flagged as generic.
- Character counts are verified via shell, not estimated.
