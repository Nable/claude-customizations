# Publish Pipeline

Un comando custom per Claude Code che orchestra l'intera pipeline di pubblicazione: con una sola invocazione esegue in sequenza tutti i generatori del repository, passando gli artefatti da una fase alla successiva.

---

## Come funziona

```
/publish
────────────────────────────────────────────────
Step 0  Chiede una sola volta: email, dominio, sviluppatore
   1    /style-guide        → style-guide/  (stile + tokens)
   2    skill appstore-pages → web-pages/   (usa i tokens)
   3    /app-store-listing  → app-store-listing.md (usa meta.json)
   4    /marketing-advisor  → marketing.md  (usa il listing)
   5    /press-kit          → press-kit/    (riusa tutto)
────────────────────────────────────────────────
Riepilogo: artefatti, campi [DA COMPILARE], prossimi passi
```

Tutti gli input "anagrafici" (email, dominio, sviluppatore) vengono chiesti una sola volta all'inizio: nessuna fase ripete le stesse domande.

---

## Utilizzo

```
/publish        # pipeline completa
/publish 3      # riparte dalla fase 3, riusando gli artefatti esistenti
```

Se una fase trova il proprio output già presente e recente, chiede se riusarlo (default) o rigenerarlo.

## Installazione

Dalla root del repository esegui `./install.sh` (installa anche tutti i comandi richiamati), oppure copia manualmente:

```bash
mkdir -p ~/.claude/commands
cp publish.md ~/.claude/commands/publish.md
```

Il comando sarà disponibile in Claude Code come `/publish`.

**Prerequisito:** gli altri comandi del repository e la skill appstore-pages devono essere installati (con `./install.sh` lo sono automaticamente).

---

## Note

- L'ordine delle fasi non è arbitrario: le pagine web usano i design tokens, il listing legge URL ed email da `web-pages/meta.json`, il marketing legge il listing, il press kit riusa tutto.
- Se una fase fallisce la pipeline si ferma e riporta il problema: niente artefatti incompleti a valle.
- Al termine stampa il riepilogo di tutti i campi `[DA COMPILARE]` rimasti, raggruppati per file.
