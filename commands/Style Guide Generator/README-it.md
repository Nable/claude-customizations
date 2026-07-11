# Style Guide Generator

Un comando custom per Claude Code che analizza un progetto app e genera una style guide visiva in HTML: palette colori, tipografia, spacing, radius, ombre, iconografia e componenti di esempio — tutto estratto dal codice reale del progetto.

Lo scopo è avere un artefatto da fornire in input (a persone o AI) per generare altri contenuti — pagine web, materiali marketing, mockup — con lo stesso stile grafico dell'app, senza dover dare accesso al progetto.

---

## Come funziona

```
Claude Code (nel progetto)
──────────────────────────────────────────────────
Estrae colori (Assets.xcassets, SwiftUI, colors.xml, CSS)
Estrae font e gerarchia tipografica
Rileva spacing, corner radius, ombre, iconografia
Estrae l'icona app (embed base64)
         ↓
style-guide/index.html
style-guide/style-tokens.json
```

La pagina HTML **usa essa stessa lo stile estratto** (sfondo, font, colori del progetto): è la prima dimostrazione della style guide. Ogni valore riporta l'origine: file del progetto oppure `derived` se dedotto dalla palette.

---

## File generati

| File | Contenuto |
|------|-----------|
| `style-guide/index.html` | Pagina self-contained con swatch colori (+ dark mode e check WCAG), specimen tipografici renderizzati, scala spacing, campioni radius/ombre, componenti di esempio, blocco CSS variables copiabile |
| `style-guide/style-tokens.json` | Design tokens machine-readable: colori, tipografia, spacing, radius, ombre, iconografia — coerenti con la pagina HTML |

---

## Installazione

### Prerequisiti

- [Claude Code](https://claude.ai/code) installato e configurato

### Installare il comando custom

Crea la cartella dei comandi custom se non esiste:

```bash
mkdir -p ~/.claude/commands
```

Copia il file del comando:

```bash
cp style-guide.md ~/.claude/commands/style-guide.md
```

Il comando sarà disponibile in Claude Code come `/project:style-guide`.

---

## Utilizzo

Apri il progetto in Claude Code ed esegui:

```
/project:style-guide
```

### Uso tipico dell'output

1. Genera la style guide nel progetto dell'app
2. Fornisci `index.html` (o `style-tokens.json`) come contesto quando chiedi a un'AI di generare landing page, banner, pagine di supporto, ecc.
3. Rigenera dopo modifiche rilevanti alla UI: i file vengono sovrascritti

---

## Note

- **Nessun valore inventato**: ciò che non è rilevabile dal codice è `null` con una raccomandazione motivata, mai un valore plausibile spacciato per reale.
- I colori con contrasto WCAG insufficiente vengono segnalati nella pagina ma non corretti: la style guide documenta lo stato reale del progetto.
- Supporta progetti iOS/macOS (inclusi Xcode 13+ senza `Info.plist` fisico), Android e web/cross-platform.
- La lingua della pagina segue quella del progetto (italiano o inglese).
