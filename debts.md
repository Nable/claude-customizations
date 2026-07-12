# Technical Debts & Issues
> Generato: 2026-07-13 | Progetto: claude-customizations | Stack: Markdown prompts (comandi Claude Code), Bash | Apple Guidelines: No

Questo repository è una libreria di prompt: il "codice" sono i file comando Markdown e `install.sh`. Il debito rilevato riguarda quindi correttezza e coerenza delle istruzioni, robustezza dello script di installazione e allineamento della documentazione.

---

## Sommario

| Categoria | 🔴 Critico | 🟠 Alto | 🟡 Medio | 🟢 Basso | Totale |
|-----------|-----------|---------|----------|----------|--------|
| 1. Qualità Codice | 0 | 0 | 1 | 1 | 2 |
| 2. Architettura | 0 | 1 | 0 | 1 | 2 |
| 3. Gestione Errori | 0 | 0 | 1 | 1 | 2 |
| 4. Performance | 0 | 0 | 0 | 0 | 0 |
| 5. Sicurezza | 0 | 0 | 0 | 0 | 0 |
| 6. Test | 0 | 0 | 0 | 1 | 1 |
| 7. Dipendenze | 0 | 0 | 0 | 0 | 0 |
| 8. Documentazione | 0 | 2 | 1 | 0 | 3 |
| 9. Database | 0 | 0 | 0 | 0 | 0 |
| 10. Build/Config | 0 | 0 | 1 | 0 | 1 |
| **Totale** | **0** | **3** | **4** | **4** | **11** |

---

## 1. Qualità Codice

### DEBT-004 · 🟡 Medio
**Descrizione:** Il comando `/appstore-pages` istruisce Claude a usare il tool `present_files`, che non esiste in Claude Code. È un residuo della vecchia versione skill del comando.
**File:** `commands/App Store Pages Generator/appstore-pages.md` (riga 216)
**Impatto:** L'istruzione non è eseguibile: Claude la ignora silenziosamente o tenta invocazioni inesistenti, con comportamento imprevedibile a fine generazione.
**Soluzione:** Sostituire con un'istruzione concreta ("stampa i percorsi dei file generati e un riepilogo") o rimuovere la frase.

### DEBT-011 · 🟢 Basso
**Descrizione:** `install.sh` appiattisce `commands/*/*.md` in un unico namespace: due cartelle comando con lo stesso basename si sovrascriverebbero in silenzio (`ln -sfn` / `cp`, ultimo vince), senza alcun avviso di collisione.
**File:** `install.sh` (righe 32–37 e 68–73)
**Impatto:** Oggi non ci sono collisioni, ma aggiungendo un comando con nome file già usato uno dei due sparirebbe dall'installazione senza segnalazione.
**Soluzione:** Tenere traccia dei basename già installati nel loop ed emettere un errore (o almeno un warning) in caso di duplicato.

---

## 2. Architettura

### DEBT-002 · 🟠 Alto
**Descrizione:** `/publish` indica come fallback la lettura del comando da `~/.claude/commands/<nome>.md`. Nelle installazioni `--project` (Claude Code web, l'unico ambiente per cui quella modalità esiste) i comandi stanno invece in `<progetto>/.claude/commands/` e la home non contiene nulla.
**File:** `commands/Publish Pipeline/publish.md` (riga 34)
**Impatto:** Proprio nell'ambiente in cui il fallback servirebbe (web, dove i symlink sono rotti), il percorso indicato è sbagliato: la pipeline non riesce a recuperare le istruzioni delle fasi.
**Soluzione:** Indicare di cercare prima in `.claude/commands/` del progetto corrente, poi in `~/.claude/commands/`.

### DEBT-009 · 🟢 Basso
**Descrizione:** `CLAUDE.md` dichiara che «i generatori rilevano italiano vs. inglese e producono l'output di conseguenza», ma `app-store-listing.md` e `marketing-advisor.md` hanno template di output interamente in italiano senza alcuna istruzione di rilevamento lingua per la struttura del documento (a differenza di `/release-notes` e `/appstore-pages`, che la gestiscono).
**File:** `CLAUDE.md` (sezione "Language conventions"); `commands/App Store Listing Generator/app-store-listing.md` (righe 40–196); `commands/Marketing Advisor/marketing-advisor.md` (righe 15–279)
**Impatto:** Su un progetto target in inglese questi due comandi generano comunque report con intestazioni italiane, contraddicendo la convenzione dichiarata; chi aggiunge nuovi generatori riceve un'indicazione non rispecchiata dagli esempi esistenti.
**Soluzione:** Aggiungere ai due comandi l'istruzione di adattare il template alla lingua del progetto, oppure circoscrivere la frase in `CLAUDE.md` ai soli generatori che lo fanno.

---

## 3. Gestione Errori

### DEBT-005 · 🟡 Medio
**Descrizione:** `install.sh` gestisce solo il primo argomento `--project`: qualsiasi altro argomento (typo come `--proj`, `--help`, un path passato senza flag) viene ignorato in silenzio e lo script procede con l'installazione symlink di default.
**File:** `install.sh` (righe 18 e 59)
**Impatto:** Un typo nella modalità `--project` installa symlink in `~/.claude/` invece di copiare nel progetto, senza alcun messaggio: l'utente crede di aver aggiornato le copie del progetto ma non è successo.
**Soluzione:** Dopo il blocco `--project`, rifiutare con errore e usage ogni argomento residuo non riconosciuto (`[ $# -eq 0 ] || { echo "Argomento sconosciuto: $1" >&2; exit 1; }`).

### DEBT-008 · 🟢 Basso
**Descrizione:** I loop sui comandi (`for f in "$REPO_DIR"/commands/*/*.md`) non hanno guardia sul glob non espanso: se non ci fossero match, `cp`/`ln` fallirebbe sul pattern letterale con errore criptico (e `set -e` interrompe). Il loop delle skill ha la guardia (`[ -d "$d" ] || continue` con commento dedicato), quello dei comandi no.
**File:** `install.sh` (righe 32 e 68; confronta con la guardia a riga 41 e 79)
**Impatto:** Robustezza incoerente tra i due loop; un repo clonato parzialmente o un refactoring delle cartelle produce un errore poco comprensibile invece di un messaggio chiaro.
**Soluzione:** Aggiungere `[ -f "$f" ] || continue` in testa a entrambi i loop comandi, come già fatto per le skill.

---

## 4. Performance

✅ Nessun problema rilevato

---

## 5. Sicurezza

✅ Nessun problema rilevato

---

## 6. Test

### DEBT-010 · 🟢 Basso
**Descrizione:** `install.sh` è l'unico eseguibile del repo ma non ha alcuna verifica automatica: niente CI, niente `shellcheck`, nessuno smoke test (lo script supporta già `CLAUDE_DIR` override, usato manualmente in passato — vedi `.claude/settings.local.json` — ma il test non è codificato).
**File:** `install.sh` (righe 1–92; assenza di workflow in `.github/`)
**Impatto:** Regressioni nelle due modalità di installazione (symlink e `--project`) si scoprono solo installando davvero su un progetto reale.
**Soluzione:** Aggiungere una GitHub Action che esegua `shellcheck install.sh` e uno smoke test di entrambe le modalità con `CLAUDE_DIR` e un progetto fittizio in una dir temporanea, verificando i file risultanti.

---

## 7. Dipendenze

✅ Nessun problema rilevato

---

## 8. Documentazione

### DEBT-001 · 🟠 Alto
**Descrizione:** Il "Recommended workflow" del Press Kit Generator indica `/app-store-listing → /marketing-advisor → /style-guide → /press-kit`, in contraddizione con l'ordine canonico della pipeline (`/style-guide → /appstore-pages → /app-store-listing → /marketing-advisor → /press-kit`) documentato in `publish.md`, nei README della Publish Pipeline e in `CLAUDE.md`. Manca inoltre la fase `/appstore-pages`.
**File:** `commands/Press Kit Generator/README-en.md` (righe 53–58) e `commands/Press Kit Generator/README-it.md` (righe 53–58)
**Impatto:** Chi segue il README esegue la style guide dopo il listing: `/appstore-pages` non riusa i token e `/app-store-listing` non trova `web-pages/meta.json`, perdendo il riuso di email e URL su cui la pipeline si fonda.
**Soluzione:** Allineare il workflow di entrambi i README all'ordine canonico a cinque fasi (o rimandare a `/publish`).

### DEBT-003 · 🟠 Alto
**Descrizione:** La tabella "Dimensioni richieste da Apple" per gli screenshot è obsoleta: indica 6,5" obbligatorio in alternativa, 5,5" (iPhone 8 Plus) consigliato e iPad 11" obbligatorio. Dalle regole App Store Connect correnti (verificate 2026-07-13) è richiesto solo il formato più grande per famiglia di device — iPhone 6,9" (1320×2868) e iPad 13" (2064×2752) — e Apple riscala automaticamente per gli altri; il 5,5" non è più richiesto.
**File:** `commands/App Store Listing Generator/app-store-listing.md` (righe 139–144)
**Impatto:** Ogni `app-store-listing.md` generato istruisce l'utente a produrre screenshot non più necessari (5,5", iPad 11") e presenta come obbligatori requisiti superati — proprio il tipo di dato "load-bearing" che `CLAUDE.md` chiede di verificare contro le regole correnti.
**Soluzione:** Aggiornare la tabella ai requisiti correnti (6,9" iPhone e 13" iPad obbligatori, il resto opzionale/auto-scalato) e aggiungere nel comando l'istruzione di verificare i formati sulla pagina Apple "Screenshot specifications" a ogni esecuzione.

### DEBT-007 · 🟡 Medio
**Descrizione:** In tutti i 16 README per-comando l'installazione manuale è `cp <nome-comando>.md ~/.claude/commands/...` subito dopo la frase «From the repository root» / «Dalla root del repository»: eseguito dalla root, il `cp` fallisce perché i file stanno in `commands/<Cartella>/`.
**File:** `commands/*/README-en.md` e `commands/*/README-it.md` (es. `commands/Debt Tracker/README-en.md` righe 55–58, stesso pattern negli altri 15 file)
**Impatto:** Il comando copia-incolla documentato non funziona così com'è scritto (`cp: debts-check.md: No such file or directory`).
**Soluzione:** Usare il percorso completo quotato, es. `cp "commands/Debt Tracker/debts-check.md" ~/.claude/commands/`, in tutte le coppie EN/IT.

---

## 9. Database

✅ Nessun problema rilevato

---

## 10. Build/Config

### DEBT-006 · 🟡 Medio
**Descrizione:** Nessuna delle due modalità di `install.sh` rimuove gli artefatti orfani: un comando rinominato o eliminato dal repo resta come copia nel `.claude/commands/` dei progetti (modalità `--project`) o come symlink pendente in `~/.claude/commands/` (modalità default). Le skill sono ripulite solo se ancora esistenti nel repo (`rm -rf` prima della copia), non se rimosse — è già successo con la ex-skill `appstore-pages`, rimossa a mano (vedi permesso `rm ~/.claude/skills/appstore-pages` in `.claude/settings.local.json`).
**File:** `install.sh` (righe 32–37, 40–47, 68–73)
**Impatto:** I progetti target continuano a esporre comandi obsoleti con prompt vecchi, mentre `.customizations-rev` dichiara una revisione aggiornata: lo stato reale delle copie non corrisponde al marker di provenienza.
**Soluzione:** In entrambe le modalità, eliminare prima i file/symlink riconducibili a questo repo che non hanno più una sorgente (es. confrontando con l'elenco corrente dei basename, o rimuovendo i symlink che puntano dentro `$REPO_DIR` ma sono pendenti).

---

## Piano sprint

**Sprint 1 — Correttezza delle istruzioni (🟠 Alto):**
- DEBT-003 — aggiornare la tabella screenshot ai requisiti Apple correnti
- DEBT-001 — allineare il workflow dei README Press Kit all'ordine della pipeline
- DEBT-002 — correggere il percorso di fallback in `/publish` per le installazioni `--project`

**Sprint 2 — Robustezza installazione e docs (🟡 Medio):**
- DEBT-005 — rifiutare argomenti sconosciuti in `install.sh`
- DEBT-006 — pulizia degli artefatti orfani in entrambe le modalità
- DEBT-004 — rimuovere il riferimento a `present_files`
- DEBT-007 — correggere i comandi `cp` nei 16 README

**Backlog (🟢 Basso):** DEBT-008, DEBT-009, DEBT-010, DEBT-011

---

## Note finali

- Il repo è in buona salute: nessun problema critico o di sicurezza; il debito è concentrato in incoerenze documentali tra artefatti (l'esatto rischio che `CLAUDE.md` segnala per la pipeline) e in robustezza di `install.sh`.
- I dati di dominio Apple (limiti caratteri 30/30/170/4000 nei prompt) risultano corretti; solo la tabella screenshot è superata (DEBT-003, verificata via web il 2026-07-13).
- Le coppie README EN/IT sono strutturalmente allineate (stesso numero di heading in tutte le 8 coppie); l'incoerenza del workflow Press Kit (DEBT-001) è presente in entrambe le lingue, quindi le coppie restano equivalenti tra loro.
