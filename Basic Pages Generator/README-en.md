# Basic Pages Generator

A Claude Code custom command that analyses an iOS, Android, or cross-platform project and generates the static HTML pages required for publishing on App Store Connect and Google Play Console.

---

## How it works

```
Claude Code (inside the project)
──────────────────────────────────────────
Detects platform (iOS / Android / both)
Reads permissions, capabilities, third-party SDKs
Reads app-store-listing.md if present
         ↓
docs/privacy.html
docs/support.html
```

The privacy policy is not generic: it is tailored to the actual permissions and SDKs found in the project. If the app uses the camera, the "Photos and videos" section is included; if it doesn't use location, that section won't appear.

---

## Generated pages

| File | Content | Required by |
|------|---------|-------------|
| `docs/privacy.html` | Privacy policy tailored to real permissions | App Store Connect, Google Play Console |
| `docs/support.html` | Support page with contextualised FAQs, contact form, store badges | App Store Connect, Google Play Console |

---

## Page features

- **Self-contained**: no external dependencies, no CDN
- **Mobile-first responsive**: optimised for reading on smartphones
- **Dark mode**: respects `prefers-color-scheme: dark`
- **Accessible**: adequate contrast, font-size ≥ 16px
- **GitHub Pages ready**: just enable `/docs` as source

---

## What it analyses

**iOS / macOS:**
- `NSUsageDescription` keys in `Info.plist` → privacy sections
- Entitlements → HealthKit, iCloud, Push, etc.
- StoreKit imports → in-app purchases section

**Android:**
- `uses-permission` in `AndroidManifest.xml` → privacy sections
- Gradle dependencies → third-party SDKs (Firebase, AdMob, etc.)

**Both:**
- Analytics/crash SDKs detected → listed in the third-party section with links to their privacy policies
- Presence of authentication → account data section

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
cp generate-basic-pages.md ~/.claude/commands/generate-basic-pages.md
```

The command will be available in Claude Code as `/project:generate-basic-pages`.

---

## Usage

Open the project in Claude Code and run:

```
/project:generate-basic-pages
```

When done, Claude prints:
- Detected platform(s)
- Found permissions and generated privacy sections
- Path of created files
- Instructions for publishing on GitHub Pages
- List of remaining `[TO BE FILLED]` fields

### Recommended workflow

1. Run `/project:generate-basic-pages`
2. Open `docs/privacy.html` and `docs/support.html` and fill in the `[TO BE FILLED]` fields (email, developer name, store URLs)
3. Enable GitHub Pages on `/docs` in your repository
4. Paste the URLs into App Store Connect / Google Play Console

---

## Notes

- Pages are generated in Italian if the project is in Italian, in English if the project is in English.
- Does not overwrite other files already present in `docs/`.
- FAQs on the support page are generated based on the app's real features, not generic placeholders.
- To update pages after adding new permissions, re-run the command: only `privacy.html` and `support.html` will be regenerated.
