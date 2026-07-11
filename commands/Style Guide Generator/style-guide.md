---
description: Estrae lo stile visivo dell'app e genera style-guide/index.html + style-tokens.json da usare come input per altri contenuti
---

Analizza il progetto e genera una style guide visiva nella cartella dedicata `style-guide/` nella root del progetto:

- **`style-guide/index.html`** — pagina HTML self-contained che documenta e **mostra** lo stile grafico dell'app
- **`style-guide/style-tokens.json`** — design tokens machine-readable, coerenti con la pagina HTML

**Scopo:** questi file vengono forniti come input (a persone o AI) per generare altri contenuti — pagine web, materiali marketing, mockup — con lo stesso stile grafico dell'app. La pagina deve essere così completa che chi la riceve possa replicare lo stile **senza accesso al progetto**.

Se la cartella `style-guide/` contiene già i due file, sovrascrivili (rigenerazione).

---

### Step 1 — Estrai lo stile dal progetto (mai inventare)

Identifica prima piattaforma e stack (iOS/macOS, Android, web/cross-platform). Nei progetti Xcode 13+ con `GENERATE_INFOPLIST_FILE = YES` non esiste un `Info.plist` fisico: cerca le chiavi `INFOPLIST_KEY_*` in `project.pbxproj`.

**Colori** — cerca in ordine, annotando per ogni valore il file di origine:
1. `*.colorset/Contents.json` in `Assets.xcassets` (componenti 0.0–1.0 → HEX; registra anche le varianti dark appearance)
2. SwiftUI `Color(...)`, `.accentColor`, `UIColor`/`NSColor` con `red:green:blue:`
3. Hex literal nel codice (`#RRGGBB`, `hex: "..."`)
4. Android: `colors.xml`, temi Compose
5. Web: CSS variables, `tailwind.config`, SCSS

**Tipografia:**
- Font custom: `UIAppFonts` (Info.plist o pbxproj), file `.ttf`/`.otf` nel bundle, `Font.custom(...)`, `fontFamily` Android, `@font-face` CSS
- Se solo font di sistema → indica SF Pro (Apple) / Roboto (Android) / system-ui (web)
- Gerarchia: raccogli le dimensioni e i pesi effettivamente usati (`.font(.title)`, `.fontWeight(...)`, size esplicite) e mappale sui livelli Display / H1 / H2 / Body / Caption / Button

**Geometria e profondità:**
- Spacing: valori ricorrenti di `padding`/`spacing` → deduci la grid base (4pt o 8pt) e la scala
- Corner radius: valori di `cornerRadius` / `RoundedRectangle` / `border-radius`
- Ombre: parametri di `.shadow(...)` / `elevation` / `box-shadow`

**Icona app e iconografia:**
- Icona: file più grande in `AppIcon.appiconset` → embeddila in base64 nella pagina
- Iconografia: SF Symbols / Material Icons / set custom negli asset; stile (outline/filled) e peso prevalente

**Dark mode:** se gli asset hanno varianti dark o il codice usa `colorScheme`, documenta entrambe le palette.

---

### Step 2 — `style-guide/index.html`

Pagina standalone: CSS tutto inline nel `<style>`, icona in base64, nessuna dipendenza esterna, responsive (media query `max-width: 600px`). **La pagina stessa usa lo stile estratto**: sfondo, font e colori del progetto — è la prima dimostrazione della style guide.

Sezioni nell'ordine:

1. **Header** — icona app, nome, piattaforma, data di generazione
2. **Palette** — uno swatch per colore con: nome, campione, HEX, RGB, uso, origine (`file` se estratto, `derived` se dedotto); varianti dark mode affiancate se presenti; esito del check contrasto WCAG (AA 4.5:1, AAA 7:1) per le coppie testo/sfondo
3. **Tipografia** — specimen **renderizzato** per ogni livello della gerarchia (testo di esempio mostrato con font, peso, dimensione e interlinea reali) + tabella riassuntiva
4. **Spacing & layout** — grid base e scala spacing con barre proporzionali di esempio
5. **Radius & ombre** — campioni renderizzati per ogni valore
6. **Iconografia** — set, stile, peso, esempi
7. **Componenti** — esempi renderizzati costruiti con i token: button primario e secondario, card, input, badge
8. **Design tokens** — blocco `:root { ... }` con tutte le CSS variables, copiabile, identico ai valori del JSON

---

### Step 3 — `style-guide/style-tokens.json`

```json
{
  "app": "<nome app>",
  "generated": "YYYY-MM-DD",
  "platform": "iOS | macOS | Android | web",
  "extractedFrom": ["<file analizzati>"],
  "colors": {
    "<nome>": {
      "hex": "#RRGGBB",
      "darkMode": "#RRGGBB | null",
      "usage": "<uso>",
      "source": "<path/file> | derived"
    }
  },
  "typography": {
    "fontPrimary": { "name": "<font>", "source": "<file> | system" },
    "fontSecondary": { "name": "<font> | null" },
    "scale": {
      "display": { "size": 0, "weight": "<peso>", "lineHeight": 0 },
      "h1": {}, "h2": {}, "body": {}, "caption": {}, "button": {}
    }
  },
  "spacing": { "baseGrid": 8, "scale": [4, 8, 16, 24, 32] },
  "radius": { "<nome>": 0 },
  "shadows": { "<nome>": "<valore css>" },
  "iconography": { "set": "<SF Symbols | Material | custom>", "style": "<outline | filled>", "weight": "<peso>" }
}
```

Adatta le chiavi ai valori realmente trovati: non lasciare sezioni fittizie. Se una categoria non è rilevabile, usa `null` e aggiungi una nota `"recommendation"` motivata.

---

### Regole

- **Mai inventare valori.** Ogni token viene dal progetto (`source: <file>`) o è dedotto coerentemente dalla palette trovata (`source: derived`). Se non rilevabile → `null` + raccomandazione, mai un valore plausibile spacciato per reale.
- **HTML e JSON devono essere coerenti**: stessi valori, stessi nomi dei token.
- I colori con contrasto insufficiente vanno segnalati nella pagina, **non corretti in silenzio**: la style guide documenta lo stato reale del progetto.
- **I rapporti di contrasto WCAG vanno calcolati, non stimati**: usa uno script (formula della luminanza relativa WCAG) via shell per ogni coppia testo/sfondo riportata.
- La lingua della pagina segue quella del progetto (rilevala da `CFBundleDevelopmentRegion`/`INFOPLIST_KEY_*`, cartelle `*.lproj`, String Catalogs `.xcstrings`; altrimenti inglese).
- Al termine stampa: percorso dei file creati, numero di colori/font/token estratti, ed eventuali categorie non rilevate con la relativa raccomandazione.
