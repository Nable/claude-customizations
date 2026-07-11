# 🔍 Debt Tracker Pipeline

Una pipeline basata su strumenti Anthropic per rilevare automaticamente i debiti tecnici nei tuoi progetti e aggregarli in una dashboard interattiva aggiornata ogni giorno.

---

## Come funziona

La pipeline è composta da due strumenti che lavorano in sequenza:

```
Claude Code (per progetto)          Claude Cowork (giornaliero)
────────────────────────            ───────────────────────────
Analizza la codebase          →     Legge tutti i debts.json
Genera debts.md                     Aggrega i dati
Genera debts.json             →     Genera debts-dashboard.html
```

**Claude Code** viene eseguito manualmente (o su trigger) all'interno di ogni progetto. Analizza l'intera codebase, rileva i debiti tecnici e produce due file nella root del progetto:

- `debts.md` — report leggibile per gli sviluppatori, con descrizioni, impatti e soluzioni suggerite
- `debts.json` — versione strutturata degli stessi dati, consumata dalla dashboard

**Claude Cowork** gira ogni giorno in modo automatico. Raccoglie tutti i `debts.json` presenti nelle sottocartelle del workspace e genera una singola `debts-dashboard.html` con vista aggregata su tutti i progetti.

---

## Struttura del workspace

```
workspace/
├── ProjectA/
│   ├── debts.md               ← report per sviluppatori
│   └── debts.json             ← dati strutturati
├── ProjectB/
│   ├── debts.md
│   └── debts.json
└── debts-dashboard.html       ← dashboard aggregata (generata da Cowork)
```

---

## Cosa analizza Claude Code

Per ogni progetto, l'analisi copre sistematicamente:

| # | Categoria | Esempi di problemi rilevati |
|---|-----------|----------------------------|
| 1 | Qualità Codice | Funzioni >40 righe, duplicazioni, magic numbers, TODO/FIXME |
| 2 | Architettura | Accoppiamento eccessivo, dipendenze circolari, violazioni SOLID |
| 3 | Gestione Errori | Catch vuoti, force unwrap impropri, errori silenziati |
| 4 | Performance | Main thread bloccato, complessità O(n²), retain cycle |
| 5 | Sicurezza | Credenziali hardcoded, input non validati, dati in chiaro |
| 6 | Test | Copertura critica assente, test fragili, mock obsoleti |
| 7 | Dipendenze | Librerie obsolete, versioni non pinned, vulnerabilità note |
| 8 | Documentazione | API non documentate, README mancante o obsoleto |
| 9 | Database | Query N+1, SQL injection, migration non versionata |
| 10 | Build/Config | Debug in produzione, env vars non gestite |
| 11 | Apple Guidelines | Solo per progetti Swift/ObjC/Xcode — API deprecate, no Dark Mode, no VoiceOver, Privacy Manifest mancante |

Ogni debito rilevato viene classificato per priorità:

| Priorità | Significato |
|----------|-------------|
| 🔴 Critico | Blocca la release, rischio sicurezza, crash in produzione |
| 🟠 Alto | Impatta l'UX significativamente o causa regressioni frequenti |
| 🟡 Medio | Debito crescente, da pianificare nel prossimo sprint |
| 🟢 Basso | Refactoring opportunistico, backlog |

---

## Cosa contiene la dashboard

La `debts-dashboard.html` generata da Cowork include:

- **Header** con data di aggiornamento e numero di progetti analizzati
- **Sommario globale** con contatori aggregati per priorità su tutti i progetti
- **Card per progetto** con nome, stack, data analisi e breakdown priorità
- **Tabella debiti** filtrabile e ordinabile per progetto, priorità e categoria
- **Vista dettaglio** — click su una riga per espandere descrizione, impatto e soluzione

---

## Installazione

### Prerequisiti

- [Claude Code](https://claude.ai/code) installato e configurato
- Accesso a [Claude Cowork](https://claude.ai/cowork)
- Un workspace con uno o più progetti nelle sottocartelle

### 1. Installare il comando custom in Claude Code

Crea la cartella dei comandi custom se non esiste:

```bash
mkdir -p ~/.claude/commands
```

Copia il file del comando:

```bash
cp debts-check.md ~/.claude/commands/debts-check.md
```

Il comando sarà disponibile in Claude Code come `/project:debts-check`.

### 2. Configurare il prompt schedulato in Claude Cowork

1. Apri [Claude Cowork](https://claude.ai/cowork)
2. Crea un nuovo prompt schedulato
3. Imposta la frequenza su **giornaliero**
4. Incolla il contenuto di `cowork-prompt.md` come testo del prompt
5. Assicurati che il workspace puntato da Cowork sia la root che contiene le cartelle dei tuoi progetti

---

## Utilizzo

### Analizzare un progetto

Apri il progetto in Claude Code ed esegui:

```
/project:debts-check
```

Claude analizzerà l'intera codebase e genererà `debts.md` e `debts.json` nella root del progetto. Al termine stampa un riepilogo con il totale dei debiti trovati per priorità.

### Visualizzare la dashboard

La dashboard `debts-dashboard.html` viene rigenerata automaticamente ogni giorno da Cowork. Aprila direttamente nel browser dalla root del workspace.

Per aggiornarla manualmente fuori dal ciclo giornaliero, esegui il prompt Cowork manualmente dall'interfaccia.

---

## Formato dei file generati

### `debts.md`

```markdown
# Technical Debts & Issues
> Generato: 2026-03-27 | Progetto: MyApp | Stack: Swift, SwiftUI | Apple Guidelines: Sì

## Sommario
| Categoria  | 🔴 Critico | 🟠 Alto | 🟡 Medio | 🟢 Basso | Totale |
|------------|-----------|---------|---------|---------|--------|
| Sicurezza  | 1         | 0       | 0       | 0       | 1      |

## 5. Sicurezza

### DEBT-001 · 🔴 Critico
**Descrizione:** API key hardcoded nel file di configurazione
**File:** `Sources/Config/APIConfig.swift` (righe 12–14)
**Impatto:** Esposizione delle credenziali nel repository
**Soluzione:** Spostare in variabili d'ambiente o in un file .env escluso dal versioning
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

## Note

- I file `debts.md` e `debts.json` sono pensati per essere versionati insieme al codice sorgente, così da tracciare l'evoluzione dei debiti nel tempo.
- La dashboard non è versionata: viene rigenerata ogni giorno da Cowork e può essere aggiunta al `.gitignore`.
- Su progetti Apple (rilevati automaticamente dalla presenza di file Swift, ObjC, Xcode, entitlements o Info.plist), l'analisi include una sezione aggiuntiva sulle Apple Guidelines.
