# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A personal library of **Claude Code customizations** — reusable slash commands and skills, not an application. There is no code to build, no test suite, and no lint step. Every deliverable is a Markdown prompt that is authored here, then copied (or symlinked) into `~/.claude/commands/` or `~/.claude/skills/` to be used against *other* projects (mostly iOS/macOS/Android apps).

When working here you are editing **prompt content**, not software. "Correctness" means the instructions are unambiguous, self-consistent, and produce the documented output files.

## Two kinds of customization

- **Commands** — a single instruction Markdown file (no frontmatter) that tells Claude what to analyze and what file(s) to generate. Each lives under `commands/<Command Name>/`, is installed to `~/.claude/commands/<name>.md`, and is invoked as `/project:<name>`. Examples: `commands/App Store Listing Generator/app-store-listing.md`, `commands/Debt Tracker Pipeline/debts-check.md`.
- **Skills** — a `SKILL.md` with YAML frontmatter (`name`, `description`) under `skills/<skill-name>/`. The `description` is trigger text: it lists the phrases/keywords that should activate the skill, so it must be written for matching, not just documentation. Example: `skills/appstore-pages/SKILL.md`.

Each command folder also holds bilingual docs: `README-en.md` and `README-it.md`. `README.md` at the root is the bilingual index (Commands and Skills sections, EN + IT) linking to each. Keep the index and per-folder READMEs in sync when adding, renaming, or moving a customization.

## Language conventions

- **Prompt/command content is written in Italian** (the instructions Claude follows).
- **Per-folder READMEs are bilingual** (`-en` / `-it` pairs that must stay equivalent).
- Generated output adapts to the *target* project's language: the generators detect Italian vs. English (e.g. `CFBundleDevelopmentRegion`) and produce output accordingly.

## Conventions shared by every generator

These patterns recur across all commands/skills and should be preserved in any new one:

- **Extract from the target project, never invent.** Values (app name, colors, icon, permissions, features) must come from real files — `Info.plist`, `project.pbxproj`, `Package.swift`, `Assets.xcassets`, `AndroidManifest.xml`, UI source. If a value can't be found, either search harder, ask the user, or emit an explicit placeholder — do not fabricate.
- **Explicit placeholders for the unknowable.** Use `[DA COMPILARE]` (Italian commands) / `[TO BE FILLED]` (English docs) for things not derivable from code: URLs, prices, contact emails, developer name.
- **Output goes into the target project**, typically the project root (`app-store-listing.md`, `brand-identity.md`, `debts.md` + `debts.json`) or `docs/` (`privacy.html`, `support.html`). Skills like `appstore-pages` produce standalone HTML with all CSS inline and images embedded as base64 — no external CDNs or relative asset paths.
- **Cross-artifact consistency.** When a command emits paired files (e.g. `debts.md` + `debts.json`), they must share the same IDs and data. When output feeds another command (brand identity reads `app-store-listing.md` / `marketing.md` if present), respect that dependency chain.
- **Apple/App Store domain.** Character limits (name 30, subtitle 30, promo 170, description/notes 4000), ASO optimization, age-rating logic, and privacy/permission mapping are load-bearing details — verify them against Apple's current rules rather than trusting memory when editing.

## Editing guidance

- Preserve each file's existing structure and output template verbatim unless the change is the point — downstream tooling (e.g. a Cowork dashboard consuming `debts.json`) depends on the exact schema.
- A skill's `description` frontmatter is functional. If you change what a skill does, update its trigger keywords too.
