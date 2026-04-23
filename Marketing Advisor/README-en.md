# Marketing Advisor

A Claude Code custom command that analyses an iOS/macOS project and generates a complete, ready-to-use marketing plan with pre-written post examples for every platform.

---

## How it works

```
Claude Code (inside the iOS/macOS project)
──────────────────────────────────────────
Reads Info.plist, README, app-store-listing.md
Analyses features and target audience
         ↓
Generates marketing.md
```

The command understands what the app does, who its audience is, and how it's priced — then produces a contextualised marketing strategy with ready-to-use posts, recommended subreddits, reviewer outreach email templates, and a launch plan.

---

## What it generates

A single `marketing.md` file in the project root containing:

| Section | Content |
|---------|---------|
| App profile | Target audience, value proposition, key selling points |
| Recommended platforms | Priority, frequency, and ideal format for each channel |
| Launch plan | Pre-launch, launch day, and post-launch checklists |
| Ready-to-use posts | Twitter/X, Instagram, Reddit, LinkedIn, Product Hunt, Hacker News, Indie Hackers |
| Recommended subreddits | List with notes on each community's rules |
| Outreach | Reviewer categories and email template |
| ASO | Keyword strategy and A/B test suggestions |
| Metrics | What to track, with which tool, and how often |
| Checklist | Complete list to make sure nothing is missed at launch |

---

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured
- An iOS or macOS project

### Install the custom command

Create the custom commands folder if it doesn't exist:

```bash
mkdir -p ~/.claude/commands
```

Copy the command file:

```bash
cp marketing-advisor.md ~/.claude/commands/marketing-advisor.md
```

The command will be available in Claude Code as `/project:marketing-advisor`.

---

## Usage

Open the iOS/macOS project in Claude Code and run:

```
/project:marketing-advisor
```

### Recommended workflow

1. Run `/project:app-store-listing` first — Marketing Advisor reads it to better understand the app
2. Run `/project:marketing-advisor`
3. Review the posts and personalise tone and details
4. Use the checklist as a launch guide

---

## Notes

- Posts are written directly contextualised to the app — not generic templates with placeholders.
- Tone is automatically adapted to the target audience: technical for developer tools, warm and benefit-first for consumer apps, professional for B2B.
- `marketing.md` is intended to be committed alongside the source code and updated with each release.
