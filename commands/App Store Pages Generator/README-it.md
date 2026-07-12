# App Store Pages Generator

Un comando custom per Claude Code che genera le pagine HTML richieste da App Store Connect — supporto e privacy policy — nella cartella dedicata `web-pages/` del progetto, usando esclusivamente la grafica reale dell'app (colori, icona, nome).

---

## Come funziona

```
Claude Code (nel progetto)
──────────────────────────────────────────────────
Riusa style-guide/style-tokens.json se presente
(altrimenti estrae colori da Assets.xcassets e codice)
Estrae icona (base64), nome, lingua, feature e permessi
Chiede solo: email di supporto (+ dominio, opzionale)
         ↓
web-pages/index.html     (supporto: hero, feature, FAQ, contatti)
web-pages/privacy.html   (privacy policy GDPR/CCPA)
web-pages/meta.json      (metadata riusati dalle run successive)
```

Se nella root del progetto esistono `index.html`/`privacy.html`/`meta.json` di esecuzioni precedenti, vengono **migrati** in `web-pages/` (con verifica che siano davvero le pagine App Store).

---

## File generati

| File | Contenuto |
|------|-----------|
| `web-pages/index.html` | Pagina di supporto self-contained: hero con icona, griglia feature dal codice reale, FAQ contestuali, sezione contatto |
| `web-pages/privacy.html` | Privacy policy su misura: permessi reali (`NS*UsageDescription`), connessioni di rete effettive, sezione analytics veritiera |
| `web-pages/meta.json` | Email, dominio, palette, lingua — riusati da `/app-store-listing` e dalle rigenerazioni |

---

## Installazione

Dalla root del repository esegui `./install.sh`, oppure:

```bash
mkdir -p ~/.claude/commands
cp appstore-pages.md ~/.claude/commands/appstore-pages.md
```

Il comando sarà disponibile in Claude Code come `/appstore-pages`.

---

## Utilizzo

```
/appstore-pages
```

### Workflow consigliato

```
/style-guide   →   /appstore-pages   →   /app-store-listing
```

Con la style guide già generata, le pagine riusano i design tokens (nessuna ri-estrazione dei colori); il listing a valle recupera email e URL da `meta.json`.

---

## Note

- Pagine standalone: CSS inline, icona in base64, nessuna dipendenza esterna, responsive.
- Colori sempre e solo dal progetto; contrasto WCAG verificato con aggiustamenti registrati in `meta.json`.
- Lingua rilevata dal progetto (`.lproj`, `.xcstrings`, `INFOPLIST_KEY_*`): italiano o inglese.
- Supporta progetti Xcode 13+ senza `Info.plist` fisico.
