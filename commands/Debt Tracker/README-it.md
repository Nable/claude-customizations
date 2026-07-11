# 🔍 Debt Tracker

Un comando custom per Claude Code che analizza l'intera codebase, rileva il debito tecnico concreto e produce due file nella root del progetto:

- `debts.md` — report leggibile per gli sviluppatori, con descrizioni, impatti e soluzioni suggerite
- `debts.json` — versione strutturata degli stessi dati, pronta per dashboard o tool esterni

---

## Cosa analizza

Per ogni progetto, l'analisi copre sistematicamente:

| # | Categoria | Esempi di problemi rilevati |
|---|-----------|------------------------------|
| 1 | Qualità Codice | Funzioni >40 righe, duplicazioni, magic numbers, TODO/FIXME |
| 2 | Architettura | Accoppiamento forte, dipendenze circolari, violazioni SOLID |
| 3 | Gestione Errori | Catch vuoti, force unwrap impropri, errori silenziati |
| 4 | Performance | Main thread bloccato, complessità O(n²), retain cycle |
| 5 | Sicurezza | Credenziali hardcoded, input non validati, dati in chiaro |
| 6 | Test | Copertura critica assente, test fragili, mock obsoleti |
| 7 | Dipendenze | Librerie obsolete, versioni non pinned, vulnerabilità note |
| 8 | Documentazione | API pubbliche non documentate, README mancante o obsoleto |
| 9 | Database | Query N+1, SQL injection, migration non versionate |
| 10 | Build/Config | Impostazioni debug in produzione, env vars non gestite |
| 11 | Apple Guidelines | Solo progetti Swift/ObjC/Xcode — API deprecate, no Dark Mode, no VoiceOver, Privacy Manifest mancante |

Ogni debito rilevato è classificato per priorità:

| Priorità | Significato |
|----------|-------------|
| 🔴 Critico | Blocca il rilascio, rischio sicurezza, crash in produzione |
| 🟠 Alto | Impatta significativamente la UX o causa regressioni frequenti |
| 🟡 Medio | Debito in crescita, da pianificare nel prossimo sprint |
| 🟢 Basso | Refactoring nice-to-have, backlog |

---

## Installazione

### Prerequisiti

- [Claude Code](https://claude.ai/code) installato e configurato

### Installare il comando custom

Dalla root del repository, esegui lo script di installazione (symlinka tutti i comandi e le skill):

```bash
./install.sh
```

Oppure copia manualmente solo questo comando:

```bash
mkdir -p ~/.claude/commands
cp debts-check.md ~/.claude/commands/debts-check.md
```

Il comando sarà disponibile in Claude Code come `/debts-check`.

---

## Utilizzo

Apri il progetto in Claude Code ed esegui:

```
/debts-check
```

Claude analizzerà l'intera codebase e genererà `debts.md` e `debts.json` nella root del progetto. Al termine stampa un riepilogo con il totale dei debiti trovati per livello di priorità.

---

## Formato dei file generati

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

## Note

- `debts.md` e `debts.json` sono pensati per essere committati insieme al codice: così è facile tracciare l'evoluzione del debito tecnico nel tempo.
- I due file sono sempre coerenti: stessi ID, stessi dati.
- Sui progetti Apple (rilevati automaticamente dalla presenza di file Swift, ObjC, Xcode, entitlements o Info.plist/`INFOPLIST_KEY_*`), l'analisi include la sezione aggiuntiva sulle Apple Guidelines.
