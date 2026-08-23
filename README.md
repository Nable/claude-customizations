# Claude Customizations

EN

A repository for storing customizations for Claude Code: custom commands and skills to run inside your app projects.

**Install everything** (symlinks into `~/.claude/`, so a `git pull` updates all):

```bash
./install.sh
```

**Use the commands from Claude Code web too** — copy them into an app project's repo (commit `.claude/` afterwards; re-run after a `git pull` to refresh the copies):

```bash
./install.sh --project ~/Workspaces/MyApp
```

## Commands

Invoke a command from the Claude Code CLI with `/<name>`.

| Command | Description | Invocation |
|---------|-------------|------------|
| [App Store Listing Generator](./commands/App%20Store%20Listing%20Generator/README-en.md) | Analyses an iOS/macOS project and generates `app-store-listing.md` with all the App Store Connect metadata: ASO-optimised name, subtitle, description and keywords, age rating, screenshots plan, pre-submission checklist. | `/app-store-listing` |
| [App Store Pages Generator](./commands/App%20Store%20Pages%20Generator/README-en.md) | Generates the App Store support and privacy HTML pages (`web-pages/index.html`, `privacy.html`, `meta.json`) using the project's real colours, icon and features — reusing the style guide tokens when present. | `/appstore-pages` |
| [Changelog Generator](./commands/Changelog%20Generator/README-en.md) | Generates the changelog between two git tags in [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format, bilingual IT+EN, prepending the new version section to the project's `CHANGELOG.md` without touching the existing history. | `/changelog [old-tag] [new-tag]` |
| [Debt Tracker](./commands/Debt%20Tracker/README-en.md) | Scans the codebase for concrete technical debt (quality, architecture, security, performance, Apple guidelines…) and generates `debts.md` for developers plus `debts.json` for dashboards. | `/debts-check` |
| [Marketing Advisor](./commands/Marketing%20Advisor/README-en.md) | Analyses the project (reading `app-store-listing.md` if present) and generates `marketing.md` with a ready-to-use marketing strategy. | `/marketing-advisor` |
| [Press Kit Generator](./commands/Press%20Kit%20Generator/README-en.md) | Generates `press-kit/` with a self-contained HTML press page and copy-paste texts: fact sheet, 50/100/250-word boilerplates (IT+EN), features, assets, press contacts. | `/press-kit` |
| [Publish Pipeline](./commands/Publish%20Pipeline/README-en.md) | Runs the whole publishing pipeline in one go: style guide → App Store pages → listing → marketing → press kit, asking for shared inputs (email, domain) only once. | `/publish [stage]` |
| [Release Notes Generator](./commands/Release%20Notes%20Generator/README-en.md) | Analyses the git history and generates `release-notes.md` with the "What's New" text ready for App Store Connect plus a technical changelog. | `/release-notes [from] [to]` |
| [Style Guide Generator](./commands/Style%20Guide%20Generator/README-en.md) | Extracts the app's real visual style (colours, typography, spacing, radii, shadows, icon) and generates `style-guide/index.html` + `style-guide/style-tokens.json`, to be used as input for generating other content with the same look. | `/style-guide` |

## Skills

Skills (auto-triggered by natural language, installed under `skills/`) — none at the moment; the folder and `install.sh` are ready for future ones.

---

IT

Repository finalizzato alla conservazione delle personalizzazioni per Claude Code: comandi custom e skill da eseguire nei progetti delle tue app.

**Installa tutto** (symlink in `~/.claude/`: un `git pull` aggiorna tutto):

```bash
./install.sh
```

**Per usare i comandi anche da Claude Code web** — copiali nel repo di un progetto app (poi committa `.claude/`; rilancia dopo un `git pull` per riallineare le copie):

```bash
./install.sh --project ~/Workspaces/MiaApp
```

## Comandi

Invoca un comando dalla CLI di Claude Code con `/<nome>`.

| Comando | Descrizione | Invocazione |
|---------|-------------|-------------|
| [App Store Listing Generator](./commands/App%20Store%20Listing%20Generator/README-it.md) | Analizza un progetto iOS/macOS e genera `app-store-listing.md` con tutti i metadati per App Store Connect: nome, sottotitolo, descrizione e keywords ottimizzati ASO, valutazione età, piano screenshot, checklist pre-invio. | `/app-store-listing` |
| [App Store Pages Generator](./commands/App%20Store%20Pages%20Generator/README-it.md) | Genera le pagine HTML di supporto e privacy per l'App Store (`web-pages/index.html`, `privacy.html`, `meta.json`) con colori, icona e funzionalità reali del progetto — riusando i tokens della style guide se presenti. | `/appstore-pages` |
| [Changelog Generator](./commands/Changelog%20Generator/README-it.md) | Genera il changelog fra due tag git in formato [Keep a Changelog](https://keepachangelog.com/it/1.1.0/), bilingue IT+EN, inserendo la nuova sezione di versione in cima al `CHANGELOG.md` del progetto senza toccare lo storico. | `/changelog [tag-vecchio] [tag-nuovo]` |
| [Debt Tracker](./commands/Debt%20Tracker/README-it.md) | Scansiona la codebase alla ricerca di debito tecnico concreto (qualità, architettura, sicurezza, performance, linee guida Apple…) e genera `debts.md` per gli sviluppatori più `debts.json` per le dashboard. | `/debts-check` |
| [Marketing Advisor](./commands/Marketing%20Advisor/README-it.md) | Analizza il progetto (leggendo `app-store-listing.md` se presente) e genera `marketing.md` con una strategia di marketing pronta all'uso. | `/marketing-advisor` |
| [Press Kit Generator](./commands/Press%20Kit%20Generator/README-it.md) | Genera `press-kit/` con una pagina stampa HTML self-contained e testi copia-incolla: fact sheet, boilerplate da 50/100/250 parole (IT+EN), feature, asset, contatti press. | `/press-kit` |
| [Publish Pipeline](./commands/Publish%20Pipeline/README-it.md) | Esegue l'intera pipeline di pubblicazione in un colpo solo: style guide → pagine App Store → listing → marketing → press kit, chiedendo gli input comuni (email, dominio) una sola volta. | `/publish [fase]` |
| [Release Notes Generator](./commands/Release%20Notes%20Generator/README-it.md) | Analizza la cronologia git e genera `release-notes.md` con il "Cosa c'è di nuovo" pronto per App Store Connect più il changelog tecnico. | `/release-notes [da] [a]` |
| [Style Guide Generator](./commands/Style%20Guide%20Generator/README-it.md) | Estrae lo stile visivo reale dell'app (colori, tipografia, spacing, radius, ombre, icona) e genera `style-guide/index.html` + `style-guide/style-tokens.json`, da usare come input per generare altri contenuti con la stessa grafica. | `/style-guide` |

## Skill

Skill (attivazione automatica da linguaggio naturale, installate da `skills/`) — nessuna al momento; la cartella e `install.sh` sono pronti per quelle future.
