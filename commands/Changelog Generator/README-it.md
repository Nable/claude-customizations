# 📝 Changelog Generator

Un comando custom per Claude Code che genera il changelog fra **due tag git** e lo scrive in `CHANGELOG.md` nella root del progetto, in formato [Keep a Changelog](https://keepachangelog.com/it/1.1.0/), con una versione italiana e una inglese.

---

## Cosa fa

1. Chiede (o riceve come argomenti) il **tag vecchio** e il **tag nuovo**
2. Valida i tag da shell: esistono, sono nell'ordine giusto, l'intervallo non è vuoto
3. Analizza i commit di `<tag-vecchio>..<tag-nuovo>` (merge commit esclusi), leggendo il diff quando il messaggio non basta
4. Classifica ogni commit nelle categorie Keep a Changelog e marca i breaking change
5. Scrive la nuova sezione di versione **in cima** al `CHANGELOG.md` esistente, preservando tutto lo storico — o crea il file se non c'è

### Categorie

| Categoria | Cosa ci va |
|-----------|------------|
| Aggiunto / Added | Funzionalità nuove |
| Modificato / Changed | Comportamenti esistenti che cambiano |
| Deprecato / Deprecated | API o funzioni marcate come obsolete |
| Rimosso / Removed | Funzionalità eliminate |
| Corretto / Fixed | Bug risolti |
| Sicurezza / Security | Vulnerabilità, credenziali, permessi, cifratura |
| Interno / Internal *(estensione opzionale)* | Manutenzione senza impatto utente: CI, build, test, docs |

Le categorie vuote non compaiono. I breaking change aprono la sezione con un blocco `⚠️` dedicato.

---

## Installazione

### Prerequisiti

- [Claude Code](https://claude.ai/code) installato e configurato
- Un progetto con repo git e almeno un tag (`git fetch --tags` se lavori su un clone parziale)

### Installare il comando custom

Dalla root del repository, esegui lo script di installazione (symlinka tutti i comandi e le skill):

```bash
./install.sh
```

Oppure copia manualmente solo questo comando:

```bash
mkdir -p ~/.claude/commands
cp changelog.md ~/.claude/commands/changelog.md
```

Il comando sarà disponibile in Claude Code come `/changelog`.

---

## Utilizzo

Apri il progetto in Claude Code ed esegui:

```
/changelog v1.3.0 v1.4.0
```

Il primo argomento è il tag vecchio (escluso dall'intervallo), il secondo il tag nuovo (incluso).

Senza argomenti il comando mostra i tag recenti e chiede quali usare, proponendo penultimo e ultimo:

```
/changelog
```

Come tag nuovo si può passare anche `HEAD`: la sezione risultante si intitola `[Unreleased]`.

---

## Formato del file generato

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

[1.4.0]: https://github.com/utente/repo/compare/v1.3.0...v1.4.0
```

Il link di confronto in fondo viene costruito dal remote `origin` (GitHub, GitLab, Bitbucket); se non è ricavabile, resta `[DA COMPILARE]`.

---

## Note

- Le due lingue descrivono gli stessi cambiamenti nello stesso ordine: stesse voci, stessi hash, stesse categorie.
- Un `CHANGELOG.md` esistente non viene mai riscritto: la nuova sezione è inserita sotto l'intestazione e la riga del link in cima al blocco dei link.
- Se la versione è già presente nel file, il comando si ferma e chiede se sostituirla.
- Il comando tocca solo `CHANGELOG.md`: non committa e non crea tag.
- Differenza rispetto a [`/release-notes`](../Release%20Notes%20Generator/README-it.md): `/changelog` produce il documento tecnico da committare nel repo, `/release-notes` il testo "Cosa c'è di nuovo" per App Store Connect.
