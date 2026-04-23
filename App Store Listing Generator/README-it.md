# App Store Listing Generator

Un comando custom per Claude Code che analizza un progetto iOS/macOS e genera automaticamente un file markdown con tutte le informazioni necessarie per pubblicare l'app su Apple App Store Connect.

---

## Come funziona

```
Claude Code (nel progetto iOS/macOS)
────────────────────────────────────
Legge Info.plist, xcodeproj, sorgenti
Analizza schermate e funzionalità
         ↓
Genera app-store-listing.md
```

Il comando scansiona la codebase, raccoglie i dati tecnici (bundle ID, versione, capability, dipendenze) e analizza le funzionalità dell'app per produrre una bozza completa e subito utilizzabile in App Store Connect.

---

## Cosa genera

Un singolo file `app-store-listing.md` nella root del progetto con:

| Sezione | Contenuto |
|---------|-----------|
| Metadati principali | Nome, sottotitolo, testo promozionale, descrizione, keywords, release notes |
| URL e contatti | Campi per support URL, marketing URL, privacy policy |
| Classificazione | Categoria primaria/secondaria, copyright, valutazione età dettagliata |
| Informazioni tecniche | Versione, bundle ID, deployment target, piattaforme, capability, dipendenze |
| Screenshot consigliati | Elenco schermate chiave con testo overlay suggerito |
| Localizzazioni | Lingua principale rilevata + tabella per lingue aggiuntive |
| Prezzi e disponibilità | Campi per modello di prezzo e mercati |
| In-App Purchase | Sezione automatica se StoreKit è rilevato nel codice |
| Note per la revisione | Credenziali di test, permission, funzionalità non ovvie |
| Checklist pre-invio | Lista completa di controlli prima dell'invio |

Ogni campo di testo include il conteggio dei caratteri rispetto al limite Apple. I campi che non possono essere ricavati dal codice sono marcati come `[DA COMPILARE]`.

---

## Limiti caratteri Apple (riepilogo)

| Campo | Limite |
|-------|--------|
| Nome app | 30 caratteri |
| Sottotitolo | 30 caratteri |
| Testo promozionale | 170 caratteri |
| Descrizione | 4.000 caratteri |
| Keywords | 100 caratteri |
| Cosa c'è di nuovo | 4.000 caratteri |

---

## Installazione

### Prerequisiti

- [Claude Code](https://claude.ai/code) installato e configurato
- Un progetto iOS o macOS con `Info.plist` o `Package.swift`

### Installare il comando custom

Crea la cartella dei comandi custom se non esiste:

```bash
mkdir -p ~/.claude/commands
```

Copia il file del comando:

```bash
cp app-store-listing.md ~/.claude/commands/app-store-listing.md
```

Il comando sarà disponibile in Claude Code come `/project:app-store-listing`.

---

## Utilizzo

Apri il progetto iOS/macOS in Claude Code ed esegui:

```
/project:app-store-listing
```

Claude analizzerà la codebase e genererà `app-store-listing.md` nella root del progetto.

### Workflow consigliato

1. Esegui `/project:app-store-listing` dopo aver completato le funzionalità della release
2. Apri `app-store-listing.md` e compila i campi `[DA COMPILARE]` (URL, prezzi, contatti)
3. Verifica i conteggi dei caratteri per nome, sottotitolo e keywords
4. Copia i testi direttamente in App Store Connect
5. Usa la checklist pre-invio come guida finale

---

## Note

- Il file `app-store-listing.md` è pensato per essere versionato insieme al codice, così da tenere traccia delle variazioni dei testi tra una release e l'altra.
- Keywords e descrizione vengono scritti dal comando già ottimizzati per ASO (App Store Optimization), ma è buona pratica rivederli con dati reali di ricerca.
- Se l'app usa StoreKit, la sezione In-App Purchase viene popolata automaticamente con i prodotti trovati nel codice.
