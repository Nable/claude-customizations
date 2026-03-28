Analizza la codebase e genera due file nella root del progetto: `debts.md` e `debts.json`.

Individua prima il tipo di progetto e stack. Se rilevi file Swift, ObjC, Xcode, entitlements o Info.plist, includi anche l'analisi **Apple Guidelines** (sezione 11).

Esamina sistematicamente ogni file cercando problemi **concreti** (con percorso e righe) nelle categorie:

1. Qualità Codice — funzioni >40r, SRP, duplicazioni, magic numbers, TODO/FIXME
2. Architettura — accoppiamento, dipendenze circolari, SOLID, logica in view
3. Gestione Errori — catch vuoti, force unwrap/cast impropri, errori silenziati
4. Performance — main thread bloccato, O(n²), retain cycle, lazy loading
5. Sicurezza — credenziali hardcoded, input non validati, dati in chiaro
6. Test — copertura critica assente, test fragili, mock obsoleti
7. Dipendenze — obsolete, non pinned, vulnerabilità note
8. Documentazione — API non documentate, README mancante/obsoleto
9. Database — N+1, SQL injection, migration non versionata, indici mancanti
10. Build/Config — debug in prod, env vars, bundle settings
11. Apple Guidelines *(solo se Apple)* — API deprecate/private, no async/await, no Dynamic Type/Dark Mode/VoiceOver, touch target <44pt, Privacy Manifest, entitlements superflui

---

### Output 1 — `debts.md` (per sviluppatori)

Formato ogni debito:
```
### DEBT-NNN · {EMOJI} {Priorità}
**Descrizione:** ...
**File:** `path/file` (righe X–Y)
**Impatto:** ...
**Soluzione:** ...
```

Priorità: 🔴 Critico · 🟠 Alto · 🟡 Medio · 🟢 Basso

Il file include: header con data/progetto/stack, tabella sommario per categoria e priorità, sezioni 1–10 (+ 11 se Apple), piano sprint, note finali. Sezioni vuote: "✅ Nessun problema rilevato".

---

### Output 2 — `debts.json` (per Cowork/dashboard)

Struttura compatta, niente markdown, niente emoji nel testo:

```json
{
  "generated": "YYYY-MM-DD",
  "project": "<nome cartella root>",
  "stack": ["<tecnologia>"],
  "isApple": true,
  "summary": {
    "critical": 0,
    "high": 0,
    "medium": 0,
    "low": 0,
    "total": 0
  },
  "debts": [
    {
      "id": "DEBT-001",
      "priority": "critical",
      "category": "security",
      "title": "<titolo breve>",
      "description": "<descrizione>",
      "file": "<path/file>",
      "lines": "X-Y",
      "impact": "<impatto>",
      "solution": "<soluzione>"
    }
  ]
}
```

Valori priority: `critical`, `high`, `medium`, `low`.
Valori category: `code-quality`, `architecture`, `error-handling`, `performance`, `security`, `testing`, `dependencies`, `documentation`, `database`, `build-config`, `apple-guidelines`.

---

**Regole generali:** ID univoci progressivi (DEBT-001…), solo problemi con riferimento a codice reale, ordina per priorità decrescente dentro ogni sezione. I due file devono essere coerenti: stessi ID, stessi dati.
