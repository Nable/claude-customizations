---
description: Genera le pagine HTML support e privacy per l'App Store in web-pages/ (index.html, privacy.html, meta.json) con la grafica reale del progetto
---

# App Store Pages — Support & Privacy

Genera due pagine HTML pronte per l'App Store Apple, sempre nella cartella dedicata **`web-pages/`** nella root del progetto:
- **`web-pages/index.html`** — Pagina di supporto con hero, griglia feature, FAQ, sezione contatto
- **`web-pages/privacy.html`** — Privacy policy completa (GDPR/CCPA)
- **`web-pages/meta.json`** — Metadata della sezione

Le pagine usano **esclusivamente** la grafica del progetto corrente (colori, icona, nome).
Non inventare né usare colori di default: se non trovi un valore, cerca più a fondo o chiedi.

---

## Step 1 — Recupera la email di contatto

**Prima di fare qualsiasi altra cosa**, controlla se esiste `web-pages/meta.json` di una esecuzione precedente: se contiene `email`, riusala senza richiederla. Altrimenti chiedi all'utente:

> "Qual è la email di supporto da inserire nelle pagine? (es. support@tuaapp.com)"

Nella stessa occasione chiedi (opzionale) il **dominio** dove le pagine saranno pubblicate (es. `https://tuaapp.com`): serve ai comandi a valle (es. `/app-store-listing`) per compilare Support URL e Privacy URL. Se l'utente non lo sa, salva `domain: null` e prosegui.

Non procedere finché non hai la email.

---

## Step 2 — Estrai OBBLIGATORIAMENTE la grafica dal progetto

Questi elementi **devono** venire dal progetto. Non usare valori inventati o di esempio.

### 2-pre — Riusa la style guide se esiste

Se esiste `style-guide/style-tokens.json` (generato dal comando `/style-guide`):
1. Controlla il campo `generated`: se più vecchio di 60 giorni, avvisa l'utente e chiedi se riusarlo o ri-estrarre dal codice.
2. Se lo riusi: mappa i colori sulle variabili richieste in 2c usando il campo `usage` di ogni token (`--bg`, `--card`, `--accent1`, ecc.) e prendi il font primario dalla sezione `typography`.
3. In quel caso **salta l'estrazione colori (2c)**. Nome app (2a) e icona (2b) vanno comunque ricavati dal progetto.

Così le pagine restano coerenti con la style guide e con gli altri artefatti che la usano.

### 2a — Nome app
Cerca in ordine:
1. `Info.plist` → `CFBundleDisplayName` o `CFBundleName`
2. `project.pbxproj` → `INFOPLIST_KEY_CFBundleDisplayName` o `PRODUCT_NAME` (i progetti Xcode 13+ con `GENERATE_INFOPLIST_FILE = YES` spesso non hanno un `Info.plist` fisico: le chiavi stanno nei build settings del pbxproj)
3. `Package.swift` → `.name`
4. Se non trovato → chiedi all'utente

### 2b — Icona app (OBBLIGATORIA)
1. Trova `AppIcon.appiconset/` dentro qualsiasi `Assets.xcassets/`
2. Leggi `Contents.json` dentro quella cartella per trovare il file immagine più grande (1024pt o la massima disponibile)
3. Converti in base64:
   ```bash
   base64 -i path/to/icon.png | tr -d '\n'
   ```
4. Embeddila come `<img src="data:image/png;base64,...">`
5. Se proprio non trovata → SVG placeholder con le iniziali dell'app su sfondo del colore accent estratto

### 2c — Colori (OBBLIGATORI — cerca ovunque)

Cerca in questo ordine, usando i primi valori concreti che trovi:

**1. Colorset in Assets.xcassets:**
```bash
find . -name "Contents.json" -path "*/colorset/*"
# oppure
find . -name "*.colorset" -type d
```
Ogni `.colorset/Contents.json` ha questa struttura:
```json
{"colors": [{"color": {"components": {"red": "0.xxx", "green": "0.xxx", "blue": "0.xxx", "alpha": "1.000"}}}]}
```
Converti i componenti (0.0–1.0) in HEX.

**2. Colori SwiftUI nel codice:**
```bash
grep -r "Color(" --include="*.swift" .
grep -r "\.accentColor\|AccentColor\|brandColor\|primaryColor\|backgroundColor" --include="*.swift" .
```

**3. Hex literal nel codice:**
```bash
grep -rE '#[0-9A-Fa-f]{6}' --include="*.swift" .
grep -rE 'hex:\s*"[0-9A-Fa-f]{6}"' --include="*.swift" .
```

**4. UIColor/NSColor RGB:**
```bash
grep -r "UIColor\|NSColor" --include="*.swift" . | grep "red:"
```

**Variabili da costruire obbligatoriamente dal progetto:**
- `--bg` → colore di sfondo principale (il più scuro o neutro trovato)
- `--card` → colore card/pannelli (leggermente più chiaro dello sfondo)
- `--sidebar` → colore navbar (vicino allo sfondo)
- `--border` → colore bordi (spesso trasparente o muted)
- `--accent1` → colore principale/brand (il più caratteristico dell'app)
- `--accent2` → colore secondario/complementare
- `--text` → colore testo principale
- `--muted` → colore testo secondario/disabilitato

Se trovi solo alcuni colori, deduci gli altri in modo coerente con la palette trovata (es. se hai un accent vivace, scegli uno sfondo neutro che lo valorizzi).

**Contrasto (WCAG AA):** verifica che `--text` su `--bg` e su `--card` raggiunga almeno **4.5:1**, e `--muted` almeno **3:1**. Se un colore estratto non contrasta, schiarisci/scurisci la variante usata nelle pagine mantenendo la tonalità del progetto, e registra l'aggiustamento in `meta.json` → `adjustments`.

### 2d — Lingua

`index.html` e `privacy.html` sono **sempre in inglese**, indipendentemente dalla lingua del progetto o del suo pubblico. Non rilevare né chiedere la lingua per queste pagine: sono i testi legali/di supporto rivolti anche a Apple review e ad audience internazionale, quindi restano in inglese in ogni caso.

---

## Step 3 — Raccogli info sull'app dal codice

Non chiedere all'utente — estrai dai file:

- **Piattaforma**: `IPHONEOS_DEPLOYMENT_TARGET` → iOS, `MACOSX_DEPLOYMENT_TARGET` → macOS
- **Versione minima OS**: dal valore di quei campi in `project.pbxproj` o `Info.plist`
- **Feature principali**: dai nomi di View, ViewModel, Model, e dai commenti Swift
- **Storage**: cerca `SwiftData`, `CoreData`, `CloudKit`, `UserDefaults`, `Realm`
- **Rete**: cerca `URLSession`, `Alamofire`, `Firebase`, `Supabase`, `Apollo` (GraphQL)
- **Permessi**: tutte le chiavi `NS*UsageDescription` in `Info.plist` (o `INFOPLIST_KEY_NS*UsageDescription` in `project.pbxproj`)
- **Analytics/Crash**: Firebase, Mixpanel, Amplitude, Sentry, Crashlytics

---

## Step 4 — Struttura HTML (layout da rispettare)

Questa è la struttura da replicare. I contenuti visivi (colori, icona, font-size, spacing) devono essere fedeli all'esempio; i testi e i dati vengono dal progetto.

### Elementi comuni

**CSS base:**
```css
* { box-sizing: border-box; margin: 0; padding: 0; }
body {
  background: var(--bg);
  color: var(--text);
  font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Helvetica Neue', Arial, sans-serif;
  line-height: 1.6;
  min-height: 100vh;
}
```

**Navbar** (sticky, height 64px, backdrop-filter blur):
- Sinistra: icona (36×36, border-radius 9px) + nome app (17px, weight 600)
- Destra: link "Support" e "Privacy" (14px, muted; attivo: accent1)

**Footer** (border-top, testo muted, 13px):
- `© [anno] [NomeApp]. All rights reserved.`
- Link: Support | Privacy Policy | Contact

### index.html

**Hero** (padding 80px top, radial gradient accent1 al 10%):
- Icona 96×96, border-radius 22px, box-shadow
- `<h1>` con gradient clip `accent1 → accent2`, 42px, weight 700
- `<p>` descrizione, 18px, muted
- Badge pill: dot verde + piattaforma e versione

**Feature grid** (CSS grid, auto-fill minmax 280px, gap 16px):
- Card: background card, border, border-radius 14px, padding 24px
- Contenuto: emoji icon (28px), h3 (15px, weight 600), p (13px, muted)

**FAQ** (`<details>` accordion):
- Card per ogni item, border-radius 12px
- Summary: 15px, weight 500, `+`/`−` a destra in accent1
- Body: 14px, muted, padding 0 22px 18px

**Contact section** (card centrata, radial gradient in fondo):
- Chip label + h2 + p descrizione
- Button gradient accent1→accent2, border-radius 12px
- Email testo sotto il button

### privacy.html

**Hero** (padding 64px, radial gradient accent2/purple al 10%):
- Icona 80×80
- `<h1>` gradient accent2→accent1, 36px
- Badge "Last updated: [mese anno]" — usa la data corrente al momento della generazione

**Sezioni** (`.privacy-section`: card, border-radius 16px, padding 32px 36px, margin-bottom 16px):
1. 🔒 Core principle + `.highlight-box` (background accent1 al 7%, border accent1 al 20%)
2. 💾 Where data lives — lista puntata (bullet in accent1)
3. 🔌 Network connections — tabella `.data-table` con `.badge-no` (verde)
4. 🛡️ Required permissions — lista
5. 📊 Analytics — lista
6. 👶 Children's privacy
7. ⚖️ Rights (GDPR/CCPA)
8. 📋 Policy changes

**Contact card** (stessa struttura di index.html ma h2 "Privacy questions?")

---

## Step 5 — Salva e presenta

### 5a — Prepara la cartella `web-pages/`

1. Crea la cartella `web-pages/` nella root del progetto se non esiste.
2. **Migrazione**: se nella root del progetto esistono già `index.html`, `privacy.html` o `meta.json` (generati da esecuzioni precedenti), spostali in `web-pages/` prima di generare i nuovi file. Non lasciare copie nella root.
   - Attenzione: sposta solo file che sono chiaramente le pagine App Store (verifica il contenuto se c'è ambiguità — es. un `index.html` che appartiene a un sito web del progetto NON va toccato; in caso di dubbio chiedi all'utente).

### 5b — Salva i tre file

```
web-pages/index.html
web-pages/privacy.html
web-pages/meta.json
```

I nuovi file generati sovrascrivono quelli eventualmente migrati. Se l'utente indica esplicitamente un'altra destinazione, usa quella. Infine usa `present_files`.

**Schema `meta.json`:**
```json
{
  "app": "<nome app>",
  "generated": "YYYY-MM-DD",
  "language": "en",
  "email": "<email di supporto>",
  "domain": "https://<dominio di pubblicazione> | null",
  "platform": "iOS | macOS",
  "minOSVersion": "<versione minima>",
  "colors": {
    "bg": "#RRGGBB", "card": "#RRGGBB", "sidebar": "#RRGGBB", "border": "#RRGGBB",
    "accent1": "#RRGGBB", "accent2": "#RRGGBB", "text": "#RRGGBB", "muted": "#RRGGBB"
  },
  "adjustments": ["<colori modificati per contrasto WCAG, con valore originale e nuovo>"]
}
```
Alla esecuzione successiva questo file permette di riusare `email` (Step 1) e confrontare la palette senza ripetere le domande.

---

## Regole assolute

1. **Colori**: sempre e solo dal progetto. Mai valori inventati o copiati dall'esempio.
2. **Icona**: sempre dal progetto, embeddita in base64. Mai placeholder se l'icona esiste.
3. **Testi/feature/FAQ**: sempre dal codice del progetto, mai generici se il codice è disponibile.
4. **No CSS framework esterni** — tutto inline nel `<style>`.
5. **Pagine standalone** — nessuna dipendenza esterna.
6. **Icona in base64** — mai path relativi.
7. **Responsive** — media query per `max-width: 600px`.
8. **Output sempre in `web-pages/`** — mai file sparsi nella root; se ne trovi di precedenti nella root, spostali (vedi Step 5a).
9. **Lingua**: `index.html` e `privacy.html` sono sempre in inglese, a prescindere dalla lingua del progetto.
