---
description: Genera release notes localizzate e il "Cosa c'è di nuovo" per App Store Connect dalla cronologia git
argument-hint: [ref-da] [ref-a]
---

Analizza la cronologia git del progetto e genera un file `release-notes.md` nella root con le note di rilascio della prossima versione, pronte per App Store Connect.

---

### Step 1 — Determina l'intervallo di commit

1. Se sono stati passati argomenti (`$ARGUMENTS`), usali come intervallo: `<ref-da>..<ref-a>` (il secondo è opzionale, default `HEAD`)
2. Altrimenti: dall'ultimo tag a `HEAD` (`git describe --tags --abbrev=0`)
3. Se non esistono tag → chiedi all'utente da quale commit o data partire

Stampa l'intervallo scelto prima di procedere.

---

### Step 2 — Analizza i commit

- `git log <intervallo>` con messaggio completo; escludi i merge commit automatici
- Classifica ogni commit: **nuova funzionalità** / **miglioramento** / **fix** / **interno** (chore, refactor, CI, build, docs)
- Le voci "interno" non compaiono nelle note utente, solo nel changelog tecnico
- Per capire l'impatto reale sull'utente, guarda anche i file toccati: modifiche a View/UI sono visibili all'utente, modifiche a service/model spesso no
- Se il messaggio di un commit non basta a capire cosa cambia per l'utente, leggi il diff

---

### Step 3 — Determina versione e lingua

- **Versione**: `MARKETING_VERSION` in `project.pbxproj` (o `CFBundleShortVersionString` in `Info.plist`), oppure dal nome del tag di destinazione
- **Lingua principale**: `CFBundleDevelopmentRegion` / `INFOPLIST_KEY_*`, cartelle `*.lproj`, String Catalogs `.xcstrings`; altrimenti inglese

---

### Output — `release-notes.md`

```
# Release Notes — {Nome App} {versione}
> Intervallo: {ref-da}..{ref-a} | Generato: {data}

## Cosa c'è di nuovo *(App Store Connect, max 4.000 caratteri)*

{testo pronto all'uso nella lingua principale}

Lunghezza: {n} caratteri

### English version

{stesso testo in inglese}

Length: {n} characters

---

## Changelog tecnico

### Nuove funzionalità
- {voce} ({hash})

### Miglioramenti
- {voce} ({hash})

### Fix
- {voce} ({hash})

### Interno
- {voce} ({hash})
```

---

### Regole

- **Linguaggio utente-centrico** nel "Cosa c'è di nuovo": "Ora puoi…" invece di "Aggiunto supporto per…"; niente gergo tecnico, niente hash o riferimenti a file.
- **Non inventare feature**: solo ciò che emerge da commit e diff. Se l'intervallo non contiene modifiche visibili all'utente, dillo chiaramente e proponi un testo minimo ("Miglioramenti di stabilità e prestazioni") segnalandolo come generico.
- **Verifica il limite di 4.000 caratteri** con la shell (`printf '%s' "testo" | wc -c`), non a occhio.
- Ordina le voci per impatto sull'utente, non per ordine cronologico.
- Includi sempre la versione inglese oltre alla lingua principale (se la lingua principale è già l'inglese, genera solo quella).
