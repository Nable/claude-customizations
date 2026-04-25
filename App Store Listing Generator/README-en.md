# App Store Listing Generator

A Claude Code custom command that analyses an iOS/macOS project and automatically generates a markdown file with all the information needed to publish the app on Apple App Store Connect.

---

## How it works

```
Claude Code (inside the iOS/macOS project)
──────────────────────────────────────────
Reads Info.plist, xcodeproj, source files
Analyses screens and features
         ↓
Generates app-store-listing.md
```

The command scans the codebase, collects technical data (bundle ID, version, capabilities, dependencies), and analyses the app's functionality to produce a complete draft ready to use in App Store Connect.

---

## What it generates

A single `app-store-listing.md` file in the project root containing:

| Section | Content |
|---------|---------|
| Main metadata | Name, subtitle, promotional text, description, keywords, release notes |
| URLs and contacts | Fields for support URL, marketing URL, privacy policy |
| Classification | Primary/secondary category, copyright, detailed age rating |
| Technical info | Version, bundle ID, deployment target, platforms, capabilities, dependencies |
| Recommended screenshots | List of key screens with suggested overlay text |
| Localisations | Detected primary language + table for additional languages |
| Pricing and availability | Fields for pricing model and markets |
| In-App Purchases | Automatic section if StoreKit is detected in the code |
| Review notes | Test credentials, permission justifications, non-obvious features |
| Pre-submission checklist | Complete list of checks before submitting |

Every text field includes the character count against Apple's limit. Fields that cannot be derived from the code are marked as `[TO BE FILLED]`.

---

## Apple character limits (summary)

| Field | Limit |
|-------|-------|
| App name | 30 characters |
| Subtitle | 30 characters |
| Promotional text | 170 characters |
| Description | 4,000 characters |
| Keywords | 100 characters |
| What's new | 4,000 characters |

---

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured
- An iOS or macOS project with `Info.plist` or `Package.swift`

### Install the custom command

Create the custom commands folder if it doesn't exist:

```bash
mkdir -p ~/.claude/commands
```

Copy the command file:

```bash
cp app-store-listing.md ~/.claude/commands/app-store-listing.md
```

The command will be available in Claude Code as `/project:app-store-listing`.

---

## Usage

Open the iOS/macOS project in Claude Code and run:

```
/project:app-store-listing
```

Claude will analyse the codebase and generate `app-store-listing.md` in the project root.

### Recommended workflow

1. Run `/project:app-store-listing` after completing the release features
2. Open `app-store-listing.md` and fill in the `[TO BE FILLED]` fields (URLs, pricing, contacts)
3. Verify the character counts for name, subtitle, and keywords
4. Copy the text directly into App Store Connect
5. Use the pre-submission checklist as a final guide

---

## Notes

- `app-store-listing.md` is intended to be committed alongside the source code, making it easy to track text changes between releases.
- Keywords and description are written by the command already optimised for ASO (App Store Optimisation), but it's good practice to review them with real search data.
- If the app uses StoreKit, the In-App Purchases section is automatically populated with the products found in the code.
