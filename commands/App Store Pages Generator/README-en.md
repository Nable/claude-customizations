# App Store Pages Generator

A Claude Code custom command that generates the HTML pages App Store Connect requires — support and privacy policy — in the project's dedicated `web-pages/` folder, using exclusively the app's real graphics (colors, icon, name).

---

## How it works

```
Claude Code (inside the project)
──────────────────────────────────────────────────
Reuses style-guide/style-tokens.json when present
(otherwise extracts colors from Assets.xcassets and code)
Extracts icon (base64), name, language, features, permissions
Asks only for: support email (+ optional domain)
         ↓
web-pages/index.html     (support: hero, features, FAQ, contact)
web-pages/privacy.html   (GDPR/CCPA privacy policy)
web-pages/meta.json      (metadata reused by later runs)
```

If `index.html`/`privacy.html`/`meta.json` from previous runs exist in the project root, they are **migrated** into `web-pages/` (after verifying they really are the App Store pages).

---

## Generated files

| File | Content |
|------|---------|
| `web-pages/index.html` | Self-contained support page: hero with icon, feature grid from real code, contextual FAQ, contact section |
| `web-pages/privacy.html` | Tailored privacy policy: real permissions (`NS*UsageDescription`), actual network connections, truthful analytics section |
| `web-pages/meta.json` | Email, domain, palette, language — reused by `/app-store-listing` and by regenerations |

---

## Installation

From the repository root run `./install.sh`, or:

```bash
mkdir -p ~/.claude/commands
cp appstore-pages.md ~/.claude/commands/appstore-pages.md
```

The command will be available in Claude Code as `/appstore-pages`.

---

## Usage

```
/appstore-pages
```

### Recommended workflow

```
/style-guide   →   /appstore-pages   →   /app-store-listing
```

With the style guide already generated, the pages reuse the design tokens (no color re-extraction); the listing downstream picks up email and URLs from `meta.json`.

---

## Notes

- Standalone pages: inline CSS, base64 icon, no external dependencies, responsive.
- Colors come only from the project; WCAG contrast is verified, with adjustments recorded in `meta.json`.
- Language detected from the project (`.lproj`, `.xcstrings`, `INFOPLIST_KEY_*`): Italian or English.
- Supports Xcode 13+ projects without a physical `Info.plist`.
