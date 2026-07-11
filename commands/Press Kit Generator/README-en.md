# Press Kit Generator

A Claude Code custom command that analyses the project and generates a complete press kit in the `press-kit/` folder: a self-contained HTML page to share with press, bloggers and creators, plus the same texts in markdown for quick copy-paste.

---

## How it works

```
Claude Code (inside the project)
──────────────────────────────────────────────────
Reuses app-store-listing.md, marketing.md,
style-guide/style-tokens.json when present
Extracts what's missing from the project (icon, features, version)
Asks only for: press contacts, URLs, developer name
         ↓
press-kit/index.html
press-kit/press-kit.md
```

---

## What it contains

| Section | Content |
|---------|---------|
| Hero | Icon, name, tagline, platform badges |
| Fact sheet | Developer, category, price, platforms, launch date, links |
| Boilerplate | 50 / 100 / 250-word descriptions, in Italian and English, with "Copy" buttons |
| Features | The 6 main features with one-line explanations |
| Assets | Downloadable icon in multiple sizes + screenshot instructions |
| Press contacts | Email and links with prefilled mailto |

---

## Usage

```
/press-kit
```

## Installation

From the repository root run `./install.sh`, or:

```bash
mkdir -p ~/.claude/commands
cp press-kit.md ~/.claude/commands/press-kit.md
```

The command will be available in Claude Code as `/press-kit`.

### Recommended workflow

```
/app-store-listing   →   /marketing-advisor   →   /style-guide   →   /press-kit
```

The Press Kit Generator reuses artefacts from the previous commands: descriptions consistent with the listing, colours and fonts from the style guide.

---

## Notes

- Boilerplate word counts are verified via shell, not estimated.
- No invented data: prices, dates and URLs that can't be detected remain `[TO BE FILLED]`; no fictional press quotes.
- The page is self-contained: inline CSS, base64 icon, no external dependencies.
