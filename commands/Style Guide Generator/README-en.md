# Style Guide Generator

A Claude Code custom command that analyses an app project and generates a visual style guide in HTML: colour palette, typography, spacing, radii, shadows, iconography, and sample components — all extracted from the project's real code.

The goal is an artefact you can hand as input (to people or AI) to generate other content — web pages, marketing materials, mockups — matching the app's visual style, without giving access to the project.

---

## How it works

```
Claude Code (inside the project)
──────────────────────────────────────────────────
Extracts colours (Assets.xcassets, SwiftUI, colors.xml, CSS)
Extracts fonts and the typographic hierarchy
Detects spacing, corner radii, shadows, iconography
Extracts the app icon (base64 embed)
         ↓
style-guide/index.html
style-guide/style-tokens.json
```

The HTML page **is itself rendered with the extracted style** (the project's background, fonts, and colours): it is the first demonstration of the style guide. Every value carries its origin: a project file, or `derived` when deduced from the palette.

---

## Generated files

| File | Content |
|------|---------|
| `style-guide/index.html` | Self-contained page with colour swatches (+ dark mode and WCAG checks), rendered type specimens, spacing scale, radius/shadow samples, sample components, copyable CSS variables block |
| `style-guide/style-tokens.json` | Machine-readable design tokens: colours, typography, spacing, radii, shadows, iconography — consistent with the HTML page |

---

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured

### Install the custom command

Create the custom commands folder if it doesn't exist:

```bash
mkdir -p ~/.claude/commands
```

Copy the command file:

```bash
cp style-guide.md ~/.claude/commands/style-guide.md
```

The command will be available in Claude Code as `/style-guide`.

---

## Usage

Open the project in Claude Code and run:

```
/style-guide
```

### Typical use of the output

1. Generate the style guide inside the app project
2. Provide `index.html` (or `style-tokens.json`) as context when asking an AI to generate landing pages, banners, support pages, etc.
3. Regenerate after significant UI changes: the files are overwritten

---

## Notes

- **No invented values**: anything not detectable from the code is `null` with a motivated recommendation, never a plausible value passed off as real.
- Colours failing WCAG contrast are flagged on the page but not corrected: the style guide documents the project's real state.
- Supports iOS/macOS projects (including Xcode 13+ without a physical `Info.plist`), Android, and web/cross-platform.
- The page language follows the project's language (Italian or English).
