# Claude Customizations

EN

A repository for storing customizations for Claude Code: custom commands and skills to run inside your app projects.

## Commands

Install a command by copying its `.md` file into `~/.claude/commands/`, then invoke it from the Claude Code CLI with `/project:<name>`.

| Command | Description | Invocation |
|---------|-------------|------------|
| [App Store Listing Generator](./commands/App%20Store%20Listing%20Generator/README-en.md) | Analyses an iOS/macOS project and generates `app-store-listing.md` with all the App Store Connect metadata: ASO-optimised name, subtitle, description and keywords, age rating, screenshots plan, pre-submission checklist. | `/project:app-store-listing` |
| [Debt Tracker Pipeline](./commands/Debt%20Tracker%20Pipeline/README-en.md) | Scans the codebase for concrete technical debt (quality, architecture, security, performance, Apple guidelines…) and generates `debts.md` for developers plus `debts.json` for dashboards. | `/project:debts-check` |
| [Marketing Advisor](./commands/Marketing%20Advisor/README-en.md) | Analyses the project (reading `app-store-listing.md` if present) and generates `marketing.md` with a ready-to-use marketing strategy. | `/project:marketing-advisor` |
| [Style Guide Generator](./commands/Style%20Guide%20Generator/README-en.md) | Extracts the app's real visual style (colours, typography, spacing, radii, shadows, icon) and generates `style-guide/index.html` + `style-guide/style-tokens.json`, to be used as input for generating other content with the same look. | `/project:style-guide` |

## Skills

Install a skill by copying its folder into `~/.claude/skills/`. Skills are triggered automatically when your request matches their description — no slash command needed.

| Skill | Description | Invocation |
|-------|-------------|------------|
| [App Store Pages](./skills/appstore-pages/SKILL.md) | Generates the App Store support and privacy HTML pages (`web-pages/index.html`, `web-pages/privacy.html`, `web-pages/meta.json`) using the project's real colours, icon and features. | Ask e.g. *"create the support page for my app"* or mention "App Store pages", "privacy page" |

---

IT

Repository finalizzato alla conservazione delle personalizzazioni per Claude Code: comandi custom e skill da eseguire nei progetti delle tue app.

## Comandi

Installa un comando copiando il suo file `.md` in `~/.claude/commands/`, poi invocalo dalla CLI di Claude Code con `/project:<nome>`.

| Comando | Descrizione | Invocazione |
|---------|-------------|-------------|
| [App Store Listing Generator](./commands/App%20Store%20Listing%20Generator/README-it.md) | Analizza un progetto iOS/macOS e genera `app-store-listing.md` con tutti i metadati per App Store Connect: nome, sottotitolo, descrizione e keywords ottimizzati ASO, valutazione età, piano screenshot, checklist pre-invio. | `/project:app-store-listing` |
| [Debt Tracker Pipeline](./commands/Debt%20Tracker%20Pipeline/README-it.md) | Scansiona la codebase alla ricerca di debito tecnico concreto (qualità, architettura, sicurezza, performance, linee guida Apple…) e genera `debts.md` per gli sviluppatori più `debts.json` per le dashboard. | `/project:debts-check` |
| [Marketing Advisor](./commands/Marketing%20Advisor/README-it.md) | Analizza il progetto (leggendo `app-store-listing.md` se presente) e genera `marketing.md` con una strategia di marketing pronta all'uso. | `/project:marketing-advisor` |
| [Style Guide Generator](./commands/Style%20Guide%20Generator/README-it.md) | Estrae lo stile visivo reale dell'app (colori, tipografia, spacing, radius, ombre, icona) e genera `style-guide/index.html` + `style-guide/style-tokens.json`, da usare come input per generare altri contenuti con la stessa grafica. | `/project:style-guide` |

## Skill

Installa una skill copiando la sua cartella in `~/.claude/skills/`. Le skill si attivano automaticamente quando la richiesta corrisponde alla loro descrizione — non serve uno slash command.

| Skill | Descrizione | Invocazione |
|-------|-------------|-------------|
| [App Store Pages](./skills/appstore-pages/SKILL.md) | Genera le pagine HTML di supporto e privacy per l'App Store (`web-pages/index.html`, `web-pages/privacy.html`, `web-pages/meta.json`) usando colori, icona e funzionalità reali del progetto. | Chiedi ad es. *"crea la pagina di supporto per la mia app"* o menziona "pagina supporto", "privacy page" |
