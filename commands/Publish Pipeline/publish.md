---
description: Esegue l'intera pipeline di pubblicazione — style guide, pagine App Store, listing, marketing, press kit — in sequenza
argument-hint: [step da cui ripartire, 1-5]
---

Esegui l'intera pipeline di pubblicazione del progetto, in questo ordine. Ogni fase produce artefatti che le fasi successive riusano:

| # | Fase | Produce | Riusa |
|---|------|---------|-------|
| 1 | `/style-guide` | `style-guide/` (stile visivo + tokens) | — |
| 2 | `/appstore-pages` | `web-pages/` (support + privacy) | tokens (1) |
| 3 | `/app-store-listing` | `app-store-listing.md` | URL e email da `web-pages/meta.json` (2) |
| 4 | `/marketing-advisor` | `marketing.md` | listing (3) |
| 5 | `/press-kit` | `press-kit/` | listing (3), marketing (4), tokens (1) |

---

### Step 0 — Raccogli subito tutti gli input

Per non interrompere la pipeline a metà, chiedi all'utente **in un'unica volta**, prima di iniziare:

1. Email di supporto (usata dalle pagine web e dal listing)
2. Dominio dove saranno pubblicate le pagine web (opzionale — se manca, gli URL restano `[DA COMPILARE]`)
3. Nome sviluppatore/azienda per copyright e press kit (opzionale)
4. Email press, se diversa da quella di supporto (opzionale)

Poi non fare più domande "anagrafiche": passa queste risposte a ogni fase. Le fasi possono comunque chiedere chiarimenti sul *contenuto* se indispensabile.

---

### Esecuzione

- Esegui le fasi **nell'ordine indicato**: le dipendenze sono reali (le pagine usano i tokens, il listing usa `meta.json`, ecc.).
- Invoca ogni fase con il tool SlashCommand. Se un comando non risulta installato, leggi il file da `~/.claude/commands/<nome>.md` e seguine direttamente le istruzioni.
- **Artefatti già presenti**: se una fase trova il proprio output già esistente, confronta la data di generazione con l'ultima modifica del progetto; se recente chiedi se riusarlo (default) o rigenerarlo.
- **Ripartenza**: se `$ARGUMENTS` contiene un numero 1–5, salta le fasi precedenti e riparti da lì, riusando gli artefatti esistenti (verifica che ci siano; se mancano, avvisa e proponi di eseguire le fasi mancanti).
- Se una fase fallisce, fermati e riporta il problema: non proseguire con artefatti incompleti.

---

### Al termine

Stampa un riepilogo unico:

1. **Artefatti** — elenco di tutto ciò che è stato generato o riusato, con percorso e data
2. **Campi da completare** — tutti i `[DA COMPILARE]` rimasti, raggruppati per file
3. **Prossimi passi manuali** — pubblicare `web-pages/` sul dominio, incollare i metadati in App Store Connect, distribuire il press kit
