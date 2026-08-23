---
description: Genera o aggiorna CHANGELOG.md in formato Keep a Changelog fra due tag git, bilingue IT+EN
argument-hint: [tag-vecchio] [tag-nuovo]
---

Genera la sezione di changelog fra due tag git e la scrive in `CHANGELOG.md` nella root del progetto, in formato [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), con una versione italiana e una inglese.

Il comando **richiede sempre due tag**: il tag vecchio (limite inferiore, escluso) e il tag nuovo (limite superiore, incluso).

---

### Step 1 — Verifica il contesto git

1. `git rev-parse --is-inside-work-tree` → se fallisce, fermati: il progetto non è un repo git.
2. `git tag --list --sort=-creatordate | head -20` → elenco dei tag più recenti.
3. Se il repo non ha **almeno un tag**, fermati e spiegalo all'utente: questo comando lavora fra tag, per un intervallo generico c'è `/release-notes`.
4. Se i tag potrebbero non essere tutti in locale, avvisa che conviene un `git fetch --tags` prima di procedere.

---

### Step 2 — Ottieni i due tag

- Se `$ARGUMENTS` contiene due valori → il **primo è il tag vecchio**, il **secondo è il tag nuovo**.
- Se ne contiene uno solo o nessuno → **chiedi all'utente quelli mancanti**, mostrando l'elenco dei tag recenti dello Step 1 e proponendo come default il penultimo tag (vecchio) e l'ultimo tag (nuovo). Non tirare a indovinare: senza entrambi i tag non si procede.

Validazione (tutta da shell, non a occhio):

| Controllo | Comando | Se fallisce |
|---|---|---|
| Il tag esiste | `git rev-parse -q --verify "refs/tags/<tag>"` | Fermati, mostra i tag simili trovati con `git tag --list "*<parte>*"` |
| L'ordine è corretto | `git merge-base --is-ancestor <vecchio> <nuovo>` | Se è vero il contrario, l'utente ha invertito i tag: segnalalo e chiedi conferma prima di scambiarli. Se nessuno dei due è antenato dell'altro sono su rami divergenti: segnalalo, elenca comunque i commit di `<vecchio>..<nuovo>` e spiega che i commit solo-in-`<vecchio>` restano fuori |
| L'intervallo non è vuoto | `git rev-list --count --no-merges <vecchio>..<nuovo>` | Se è `0`, fermati: non c'è nulla da scrivere, dillo e non toccare `CHANGELOG.md` |

Stampa l'intervallo scelto (`<vecchio>..<nuovo>`, N commit) prima di procedere.

---

### Step 3 — Raccogli i commit

```bash
git log --no-merges --date=short --pretty=format:'%h%x1f%ad%x1f%an%x1f%s%x1f%b%x1e' <vecchio>..<nuovo>
```

- Escludi i merge commit (`--no-merges`) e i commit puramente automatici di bump versione o di aggiornamento del changelog stesso.
- Conserva i riferimenti a PR/issue presenti nel subject (`#123`): vanno riportati nella voce.
- Usa `git show --stat <hash>` (o il diff) quando il messaggio non basta a capire cosa è cambiato davvero. Le voci descrivono **cosa cambia per chi usa il software**, non come è stato implementato.

---

### Step 4 — Classifica ogni commit

Categorie standard Keep a Changelog:

| Categoria | Cosa ci va | Segnali tipici |
|---|---|---|
| **Added / Aggiunto** | Funzionalità nuove | `feat`, "aggiunto", "nuovo", nuovi file di feature |
| **Changed / Modificato** | Comportamenti esistenti che cambiano | `refactor` visibile, "ora…", modifiche a UI/API esistenti |
| **Deprecated / Deprecato** | API o funzioni marcate come obsolete | `@deprecated`, `@available(*, deprecated)` |
| **Removed / Rimosso** | Funzionalità eliminate | "rimosso", "eliminato", cancellazione di file di feature |
| **Fixed / Corretto** | Bug risolti | `fix`, "risolto", "crash", riferimenti a issue |
| **Security / Sicurezza** | Vulnerabilità, credenziali, permessi, cifratura | `security`, CVE, dipendenze aggiornate per vulnerabilità |
| **Internal / Interno** *(estensione, opzionale)* | Manutenzione senza impatto utente: CI, build, test, docs, chore, refactor invisibili | `chore`, `ci`, `build`, `test`, `docs` |

Regole di classificazione:

- Ometti le categorie vuote — non lasciare sezioni con "nessuna modifica".
- **Breaking changes**: se un commit contiene `BREAKING CHANGE:` nel body o `!` dopo il tipo (`feat!:`), la voce va marcata `**BREAKING**` in testa e la sezione della versione si apre con un blocco `> ⚠️ **Breaking changes**` che li elenca.
- `Internal` è l'unica estensione allo standard: tienila per ultima e **omettila del tutto** se l'utente chiede un changelog solo user-facing.
- Un commit produce una sola voce. Più commit sullo stesso cambiamento (fix di un fix, "wip") si fondono in una voce sola, citando tutti gli hash.

---

### Step 5 — Versione, data e link di confronto

- **Nome versione**: il tag nuovo ripulito dal prefisso (`v1.4.0` → `1.4.0`). Se il tag nuovo è `HEAD` o un branch, la sezione si intitola `[Unreleased]`.
- **Data**: `git log -1 --format=%ad --date=short <tag-nuovo>` (data del commit taggato), formato `YYYY-MM-DD`.
- **Link di confronto**: ricava l'URL dal remote con `git remote get-url origin`, normalizzando SSH → HTTPS e togliendo il suffisso `.git`:

| Host | Formato del link |
|---|---|
| GitHub | `{repo}/compare/{tag-vecchio}...{tag-nuovo}` |
| GitLab | `{repo}/-/compare/{tag-vecchio}...{tag-nuovo}` |
| Bitbucket | `{repo}/branches/compare/{tag-nuovo}%0D{tag-vecchio}` |
| Altro / nessun remote | `[DA COMPILARE]` |

---

### Step 6 — Scrivi `CHANGELOG.md`

**Se il file non esiste**: crealo con l'intestazione standard e la sezione della versione.

**Se il file esiste**: non riscriverlo. Inserisci la nuova sezione **subito sotto l'intestazione**, prima della prima sezione `## [` esistente, e aggiungi la riga del link di confronto **in cima al blocco dei link** in fondo al file. Tutto il resto (intestazione, versioni precedenti, formattazione, eventuale sezione `[Unreleased]`) resta invariato — verificalo con `git diff CHANGELOG.md` prima di dichiarare fatto.

**Se la versione è già presente** nel file: fermati e chiedi se sostituire quella sezione o annullare. Non duplicarla mai.

---

### Output — formato del file

```markdown
# Changelog

Tutte le modifiche rilevanti di questo progetto sono documentate in questo file.
Il formato segue [Keep a Changelog](https://keepachangelog.com/it/1.1.0/) e il progetto
aderisce al [Semantic Versioning](https://semver.org/lang/it/).

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this
project adheres to [Semantic Versioning](https://semver.org/).

## [1.4.0] - 2026-08-22

> ⚠️ **Breaking changes** — *(solo se presenti)*
> - IT: descrizione della rottura e come adeguarsi
> - EN: description of the break and how to migrate

### 🇮🇹 Italiano

#### Aggiunto
- Esportazione delle note in PDF dalla schermata di dettaglio (`a1b2c3d`)

#### Corretto
- Crash all'avvio su iOS 18 con la libreria condivisa vuota (`e4f5g6h`, #123)

#### Interno
- Migrazione della CI a Xcode 16 (`i7j8k9l`)

### 🇬🇧 English

#### Added
- Export notes as PDF from the detail screen (`a1b2c3d`)

#### Fixed
- Crash on launch on iOS 18 with an empty shared library (`e4f5g6h`, #123)

#### Internal
- Migrated CI to Xcode 16 (`i7j8k9l`)

[1.4.0]: https://github.com/utente/repo/compare/v1.3.0...v1.4.0
```

Le due lingue descrivono **esattamente gli stessi cambiamenti, nello stesso ordine**: stesse voci, stessi hash, stesse categorie. Non è una traduzione libera e nessuna delle due versioni può contenere voci che l'altra non ha.

---

### Regole

- **Mai inventare.** Ogni voce deve corrispondere a commit reali nell'intervallo. Se un messaggio è incomprensibile, leggi il diff; se resta incomprensibile, scrivilo come voce `Interno` col subject originale invece di immaginarne il significato.
- **Voci utente-centriche e in tempo presente**, una riga ciascuna: "Esportazione delle note in PDF" / "Export notes as PDF", non "Aggiunto un `PDFExporter` in `NoteDetailView`".
- **Ordina per impatto** dentro ogni categoria (breaking → funzionalità principali → dettagli), non per ordine cronologico.
- **Hash corti fra backtick** a fine voce, più il riferimento a PR/issue se presente nel commit.
- **Verifica i dati con la shell**, non a memoria: numero di commit, date, esistenza dei tag, URL del remote.
- **Placeholder espliciti**: usa `[DA COMPILARE]` quando l'URL del repository non è ricavabile.
- **Un solo file toccato**: `CHANGELOG.md`. Non committare e non taggare nulla se non è l'utente a chiederlo.

---

### Al termine

Stampa un riepilogo: intervallo usato, versione e data scritte, numero di voci per categoria, se il file è stato creato o aggiornato, e i punti eventualmente rimasti `[DA COMPILARE]`.
