# 🔍 Debt Tracker

A Claude Code custom command that analyses the entire codebase, detects concrete technical debt, and produces two files in the project root:

- `debts.md` — a human-readable report for developers, with descriptions, impacts, and suggested fixes
- `debts.json` — a structured version of the same data, ready to be consumed by dashboards or external tools

---

## What it analyses

For each project, the analysis systematically covers:

| # | Category | Examples of issues detected |
|---|----------|-----------------------------|
| 1 | Code Quality | Functions >40 lines, duplication, magic numbers, TODO/FIXME |
| 2 | Architecture | Tight coupling, circular dependencies, SOLID violations |
| 3 | Error Handling | Empty catch blocks, improper force unwrap, silenced errors |
| 4 | Performance | Blocked main thread, O(n²) complexity, retain cycles |
| 5 | Security | Hardcoded credentials, unvalidated input, plaintext data |
| 6 | Testing | Missing critical coverage, brittle tests, stale mocks |
| 7 | Dependencies | Outdated libraries, unpinned versions, known vulnerabilities |
| 8 | Documentation | Undocumented public APIs, missing or outdated README |
| 9 | Database | N+1 queries, SQL injection, unversioned migrations |
| 10 | Build/Config | Debug settings in production, unmanaged env vars |
| 11 | Apple Guidelines | Swift/ObjC/Xcode projects only — deprecated APIs, no Dark Mode, no VoiceOver, missing Privacy Manifest |

Every detected debt is classified by priority:

| Priority | Meaning |
|----------|---------|
| 🔴 Critical | Blocks release, security risk, production crash |
| 🟠 High | Significantly impacts UX or causes frequent regressions |
| 🟡 Medium | Growing debt, plan for next sprint |
| 🟢 Low | Nice-to-have refactoring, backlog |

---

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured

### Install the custom command

From the repository root, run the install script (symlinks every command and skill):

```bash
./install.sh
```

Or copy just this command manually:

```bash
mkdir -p ~/.claude/commands
cp debts-check.md ~/.claude/commands/debts-check.md
```

The command will be available in Claude Code as `/debts-check`.

---

## Usage

Open the project in Claude Code and run:

```
/debts-check
```

Claude will analyse the entire codebase and generate `debts.md` and `debts.json` in the project root. At the end it prints a summary with the total number of debts found per priority level.

---

## Generated file formats

### `debts.md`

```markdown
# Technical Debts & Issues
> Generated: 2026-03-27 | Project: MyApp | Stack: Swift, SwiftUI | Apple Guidelines: Yes

## Summary
| Category | 🔴 Critical | 🟠 High | 🟡 Medium | 🟢 Low | Total |
|----------|------------|--------|----------|-------|-------|
| Security | 1          | 0      | 0        | 0     | 1     |

## 5. Security

### DEBT-001 · 🔴 Critical
**Description:** API key hardcoded in configuration file
**File:** `Sources/Config/APIConfig.swift` (lines 12–14)
**Impact:** Credentials exposed in the repository
**Solution:** Move to environment variables or a .env file excluded from version control
```

### `debts.json`

```json
{
  "generated": "2026-03-27",
  "project": "MyApp",
  "stack": ["Swift", "SwiftUI"],
  "isApple": true,
  "summary": { "critical": 1, "high": 3, "medium": 5, "low": 2, "total": 11 },
  "debts": [
    {
      "id": "DEBT-001",
      "priority": "critical",
      "category": "security",
      "title": "API key hardcoded",
      "description": "...",
      "file": "Sources/Config/APIConfig.swift",
      "lines": "12-14",
      "impact": "...",
      "solution": "..."
    }
  ]
}
```

---

## Notes

- `debts.md` and `debts.json` are intended to be committed alongside the source code, making it easy to track how technical debt evolves over time.
- The two files are always consistent: same IDs, same data.
- On Apple projects (automatically detected by the presence of Swift, ObjC, Xcode, entitlements, or Info.plist/`INFOPLIST_KEY_*` settings), the analysis includes an additional section covering Apple Guidelines.
