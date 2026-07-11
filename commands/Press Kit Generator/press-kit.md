---
description: Genera un press kit (pagina HTML self-contained + testi copia-incolla) per stampa, blogger e creator
---

Analizza il progetto e genera un press kit nella cartella dedicata `press-kit/` nella root del progetto:

- **`press-kit/index.html`** — pagina self-contained da condividere con stampa e creator
- **`press-kit/press-kit.md`** — gli stessi testi in markdown, per copia-incolla rapido

Se la cartella contiene già i due file, sovrascrivili (rigenerazione).

---

### Step 1 — Raccogli i dati

**Riusa gli artefatti esistenti prima di ri-analizzare** (in ordine):
1. `app-store-listing.md` → nome, descrizione, categoria, funzionalità, target
2. `marketing.md` → proposta di valore, punti di forza
3. `style-guide/style-tokens.json` → colori e font, senza ri-estrarli dal codice

Per ciò che manca, estrai dal progetto: nome app, icona (`AppIcon.appiconset` → base64), funzionalità principali, piattaforme, versione. Nei progetti Xcode 13+ senza `Info.plist` fisico cerca `INFOPLIST_KEY_*` e `MARKETING_VERSION` in `project.pbxproj`.

**Chiedi all'utente solo** ciò che non è rilevabile: email press/contatto, URL (sito, App Store), nome sviluppatore/azienda, data di lancio. Per il resto non fare domande. Ciò che l'utente non sa indicare resta `[DA COMPILARE]`.

---

### Step 2 — `press-kit/index.html`

Pagina standalone: CSS inline, icona in base64, nessuna dipendenza esterna, responsive (`max-width: 600px`). Usa i colori e i font del progetto (dai token o estratti).

Sezioni nell'ordine:

1. **Hero** — icona, nome app, tagline, badge piattaforme e versione
2. **Fact sheet** — tabella: sviluppatore, categoria, prezzo, piattaforme, versione minima OS, data di lancio, sito, App Store
3. **Descrizioni boilerplate** — tre lunghezze: **50**, **100** e **250 parole**, ciascuna in italiano e inglese, ognuna in un blocco con pulsante "Copia" (clipboard API)
4. **Funzionalità principali** — max 6, con una riga di spiegazione ciascuna
5. **Asset** — l'icona mostrata nelle varie dimensioni con link al download (data-URI); istruzioni su quali screenshot esportare e in quali formati
6. **Contatti stampa** — email e link, con mailto precompilato

---

### Step 3 — `press-kit/press-kit.md`

Gli stessi contenuti in markdown puro (fact sheet come tabella, boilerplate nelle tre lunghezze in entrambe le lingue, feature, contatti), pensato per essere allegato o incollato in una email.

---

### Regole

- **Boilerplate**: rispetta i target di 50/100/250 parole — verifica con la shell (`wc -w`), non a occhio; segnala il conteggio accanto a ogni blocco.
- **Coerenza**: se `app-store-listing.md` esiste, le descrizioni devono derivare da quelle (adattate alla lunghezza), non essere riscritte da zero.
- **Mai inventare**: prezzi, date, URL e recensioni non rilevabili → `[DA COMPILARE]`. Niente citazioni di stampa fittizie.
- HTML e markdown devono contenere gli stessi testi.
- La lingua della pagina segue quella del progetto; i boilerplate sono sempre bilingui (IT + EN).
