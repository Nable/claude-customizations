# 📝 Changelog Generator

A Claude Code custom command that generates the changelog between **two git tags** and writes it to `CHANGELOG.md` in the project root, in [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format, with an Italian and an English version.

---

## What it does

1. Asks for (or takes as arguments) the **old tag** and the **new tag**
2. Validates both tags via the shell: they exist, they are in the right order, the range is not empty
3. Analyses the commits in `<old-tag>..<new-tag>` (merge commits excluded), reading the diff whenever the message is not enough
4. Classifies every commit into the Keep a Changelog categories and flags breaking changes
5. Inserts the new version section **at the top** of the existing `CHANGELOG.md`, preserving the whole history — or creates the file if there is none

### Categories

| Category | What goes in it |
|----------|-----------------|
| Added / Aggiunto | New features |
| Changed / Modificato | Existing behaviour that changes |
| Deprecated / Deprecato | APIs or functions marked obsolete |
| Removed / Rimosso | Features that were dropped |
| Fixed / Corretto | Bug fixes |
| Security / Sicurezza | Vulnerabilities, credentials, permissions, encryption |
| Internal / Interno *(optional extension)* | Maintenance with no user impact: CI, build, tests, docs |

Empty categories are omitted. Breaking changes open the section with a dedicated `⚠️` block.

---

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured
- A project with a git repo and at least one tag (`git fetch --tags` if you work on a shallow clone)

### Install the custom command

From the repository root, run the install script (symlinks every command and skill):

```bash
./install.sh
```

Or copy just this command manually:

```bash
mkdir -p ~/.claude/commands
cp changelog.md ~/.claude/commands/changelog.md
```

The command will be available in Claude Code as `/changelog`.

---

## Usage

Open the project in Claude Code and run:

```
/changelog v1.3.0 v1.4.0
```

The first argument is the old tag (excluded from the range), the second is the new tag (included).

With no arguments, the command lists the recent tags and asks which ones to use, suggesting the last two:

```
/changelog
```

You can also pass `HEAD` as the new tag: the resulting section is titled `[Unreleased]`.

---

## Generated file format

```markdown
# Changelog

Tutte le modifiche rilevanti di questo progetto sono documentate in questo file.
Il formato segue [Keep a Changelog](https://keepachangelog.com/it/1.1.0/) e il progetto
aderisce al [Semantic Versioning](https://semver.org/lang/it/).

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this
project adheres to [Semantic Versioning](https://semver.org/).

## [1.4.0] - 2026-08-22

### 🇮🇹 Italiano

#### Aggiunto
- Esportazione delle note in PDF dalla schermata di dettaglio (`a1b2c3d`)

#### Corretto
- Crash all'avvio su iOS 18 con la libreria condivisa vuota (`e4f5g6h`, #123)

### 🇬🇧 English

#### Added
- Export notes as PDF from the detail screen (`a1b2c3d`)

#### Fixed
- Crash on launch on iOS 18 with an empty shared library (`e4f5g6h`, #123)

[1.4.0]: https://github.com/user/repo/compare/v1.3.0...v1.4.0
```

The compare link at the bottom is built from the `origin` remote (GitHub, GitLab, Bitbucket); when it cannot be derived it stays `[TO BE FILLED]`.

---

## Notes

- Both languages describe the same changes in the same order: same entries, same hashes, same categories.
- An existing `CHANGELOG.md` is never rewritten: the new section goes under the header and the link line at the top of the link block.
- If the version is already in the file, the command stops and asks whether to replace it.
- The command only touches `CHANGELOG.md`: it never commits and never creates tags.
- How it differs from [`/release-notes`](../Release%20Notes%20Generator/README-en.md): `/changelog` produces the technical document to commit into the repo, `/release-notes` produces the "What's New" copy for App Store Connect.
