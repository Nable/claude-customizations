# Publish Pipeline

A Claude Code custom command that orchestrates the entire publishing pipeline: a single invocation runs every generator in this repository in sequence, passing artefacts from one stage to the next.

---

## How it works

```
/publish
────────────────────────────────────────────────
Step 0  Asks once: email, domain, developer name
   1    /style-guide        → style-guide/  (style + tokens)
   2    appstore-pages skill → web-pages/   (uses the tokens)
   3    /app-store-listing  → app-store-listing.md (uses meta.json)
   4    /marketing-advisor  → marketing.md  (uses the listing)
   5    /press-kit          → press-kit/    (reuses everything)
────────────────────────────────────────────────
Summary: artefacts, [TO BE FILLED] fields, next steps
```

All "registry" inputs (email, domain, developer) are asked once upfront: no stage repeats the same questions.

---

## Usage

```
/publish        # full pipeline
/publish 3      # restart from stage 3, reusing existing artefacts
```

If a stage finds its output already present and recent, it asks whether to reuse it (default) or regenerate.

## Installation

From the repository root run `./install.sh` (which also installs every command the pipeline invokes), or copy manually:

```bash
mkdir -p ~/.claude/commands
cp publish.md ~/.claude/commands/publish.md
```

The command will be available in Claude Code as `/publish`.

**Prerequisite:** the other commands in this repository and the appstore-pages skill must be installed (`./install.sh` does it automatically).

---

## Notes

- The stage order is not arbitrary: the web pages use the design tokens, the listing reads URLs and email from `web-pages/meta.json`, marketing reads the listing, the press kit reuses everything.
- If a stage fails, the pipeline stops and reports the problem: no incomplete artefacts downstream.
- At the end it prints a summary of every remaining `[TO BE FILLED]` field, grouped by file.
