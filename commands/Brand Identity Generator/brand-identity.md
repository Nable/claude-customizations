Analizza il progetto e genera un file `brand-identity.md` nella root con la definizione completa della brand identity dell'app.

Se presenti, leggi in ordine: `app-store-listing.md`, `marketing.md`, `README`, `Info.plist` / `AndroidManifest.xml`. Ricava da questi file: nome app, categoria, funzionalità principali, target audience, tono del copy esistente (stringhe UI, onboarding, messaggi di errore).

Analizza anche:
- Colori usati nel codice UI (SwiftUI `Color`, `UIColor`, Android `colors.xml`, CSS se cross-platform) → palette esistente
- Font dichiarati (`UIFontDescriptor`, `Font` SwiftUI, `fontFamily` Android, `Info.plist` UIAppFonts) → tipografia esistente
- Icona app se presente (`Assets.xcassets`, `ic_launcher`) → descrizione caratteristiche visive
- Stringhe dell'interfaccia (`Localizable.strings`, `strings.xml`, testi SwiftUI/Compose) → tono di voce attuale

---

### Output — `brand-identity.md`

```
# Brand Identity — {Nome App}
> Generato: {data} | Versione: {versione}

---

## 1. Fondamenta del Brand

### Mission
*Cosa fa l'app e perché esiste — una frase, presente, orientata al beneficio dell'utente.*

{mission}

### Vision
*Dove vuole arrivare il brand a lungo termine — ispirazionale, futuro.*

{vision}

### Valori del Brand
*3–5 valori che guidano ogni decisione di prodotto e comunicazione.*

| Valore | Descrizione | Come si manifesta nell'app |
|--------|-------------|---------------------------|
| {valore} | {descrizione} | {esempio_concreto} |

### Personalità del Brand
*Il brand come persona: scegli 4–5 aggettivi e spiega cosa significano in pratica.*

| Tratto | Significa | Non significa |
|--------|-----------|---------------|
| {tratto} | {cosa_è} | {cosa_non_è} |

---

## 2. Tono di Voce

### Profilo

{descrizione_tono — es. "Diretto ma caldo. Usa frasi brevi. Non usa gergo tecnico."}

### Spettro del Tono

Posiziona il brand su questi assi (indica con ● la posizione):

```
Formale    ○ — ○ — ● — ○ — ○    Informale
Serio      ○ — ○ — ○ — ● — ○    Giocoso
Autorevole ● — ○ — ○ — ○ — ○    Umile
Distante   ○ — ○ — ● — ○ — ○    Vicino
```

### Do's e Don'ts Comunicativi

| ✅ Fa | ❌ Non fa |
|-------|----------|
| {esempio_positivo} | {esempio_negativo} |

### Esempi di Tono

**Messaggio di benvenuto:**
> {esempio}

**Messaggio di errore:**
> {esempio}

**Notifica push:**
> {esempio}

**Schermata vuota (empty state):**
> {esempio}

**Chiamata all'azione (CTA):**
> {esempio}

---

## 3. Identità Visiva

### Palette Colori

Per ogni colore indica: nome, hex, RGB, uso principale. Se ricavato dal codice segnalalo con *(da codice)*.

#### Colori Primari

| Nome | HEX | RGB | Uso |
|------|-----|-----|-----|
| {nome} | `{hex}` | {rgb} | {uso} |

#### Colori Secondari

| Nome | HEX | RGB | Uso |
|------|-----|-----|-----|
| {nome} | `{hex}` | {rgb} | {uso} |

#### Colori Neutri

| Nome | HEX | RGB | Uso |
|------|-----|-----|-----|
| {nome} | `{hex}` | {rgb} | {uso} |

#### Colori Semantici

| Stato | HEX | Uso |
|-------|-----|-----|
| Successo | `{hex}` | Conferme, completamento azioni |
| Errore | `{hex}` | Messaggi di errore, distruttivi |
| Attenzione | `{hex}` | Warning, azioni irreversibili |
| Informazione | `{hex}` | Tooltip, note |

#### Dark Mode
{indicazione_se_supportata_e_come_variano_i_colori}

#### Accessibilità
{verifica_contrasto_WCAG — indica quali coppie testo/sfondo superano AA (4.5:1) e AAA (7:1)}

---

### Tipografia

Se i font sono ricavati dal codice, segnalalo con *(da codice)*.

#### Font Primario
- **Nome:** {nome_font} *(da codice / suggerito)*
- **Categoria:** Serif / Sans-serif / Monospace / Display
- **Usi:** Titoli, headline, elementi prominenti
- **Alternativa sistema:** {SF Pro / Roboto / system-ui}

#### Font Secondario
- **Nome:** {nome_font} *(da codice / suggerito)*
- **Categoria:** {categoria}
- **Usi:** Corpo del testo, label, caption

#### Gerarchia Tipografica

| Livello | Font | Peso | Dimensione | Interlinea | Uso |
|---------|------|------|------------|------------|-----|
| Display | {font} | {peso} | {size}pt | {leading} | Hero, splash |
| H1 | {font} | {peso} | {size}pt | {leading} | Titoli schermata |
| H2 | {font} | {peso} | {size}pt | {leading} | Sezioni |
| Body | {font} | {peso} | {size}pt | {leading} | Testo principale |
| Caption | {font} | {peso} | {size}pt | {leading} | Note, metadata |
| Button | {font} | {peso} | {size}pt | — | CTA, azioni |

---

### Icona App

{descrizione_delle_caratteristiche_visive_rilevate — forma, sfondo, colori, stile illustrazione, metafora visiva. Se non analizzabile, fornisci linee guida per la creazione.}

**Linee guida:**
- Forma sfondo: {quadrato_pieno / gradiente / illustrazione / lettera}
- Palette usata: {colori_principali}
- Stile: {flat / illustrativo / 3D / minimalista}
- Leggibile a 29×29pt: {sì / da verificare}
- Funziona su sfondo chiaro e scuro: {sì / da verificare}

---

### Stile Visivo Generale

#### Iconografia
- **Stile:** {outline / filled / duotone / custom}
- **Set consigliato:** {SF Symbols / Material Icons / Phosphor / custom}
- **Peso visivo:** {light / regular / medium / bold}
- **Corner radius:** {sharp / slightly rounded / rounded / pill}

#### Illustrazioni ed Empty State
- **Stile:** {flat / isometrico / illustrativo / fotografico / nessuno}
- **Palette:** {usa i colori del brand / monocromatica / seppia}
- **Tono:** {serio / leggero / playful}

#### Spaziatura e Layout
- **Grid base:** {4pt / 8pt}
- **Border radius componenti:** {0 / 8 / 12 / 16}pt
- **Elevazione / ombre:** {flat / subtle / pronounced}

---

## 4. Messaggi Chiave

### Proposta di Valore Unica (UVP)
*Una frase che spiega cosa fa l'app, per chi, e perché è diversa. Max 15 parole.*

> {uvp}

### Tagline
*Breve, memorabile, riflette personalità e valore. Max 6 parole.*

> {tagline}

### Elevator Pitch
*30 secondi. Problema → soluzione → differenziatore.*

{elevator_pitch}

### Messaggi per Canale

| Canale | Messaggio principale | Tono |
|--------|---------------------|------|
| App Store (prima riga descrizione) | {messaggio} | {tono} |
| Twitter/X bio | {messaggio} | {tono} |
| Instagram bio | {messaggio} | {tono} |
| LinkedIn | {messaggio} | {tono} |
| Product Hunt tagline | {messaggio} | {tono} |

---

## 5. Personas

*2–3 profili utente derivati dall'analisi delle funzionalità e del target rilevato.*

### Persona 1 — {nome_fittizio}

| Campo | Dettaglio |
|-------|-----------|
| Età | {range} |
| Occupazione | {occupazione} |
| Obiettivo principale | {obiettivo} |
| Frustrazione attuale | {pain_point} |
| Come usa l'app | {scenario_uso} |
| Device principale | {iPhone / Android / entrambi} |
| Momento d'uso | {mattina / sera / lavoro / commute / ecc.} |

**Citazione rappresentativa:**
> "{frase_che_potrebbe_dire}"

---

### Persona 2 — {nome_fittizio}

| Campo | Dettaglio |
|-------|-----------|
| Età | {range} |
| Occupazione | {occupazione} |
| Obiettivo principale | {obiettivo} |
| Frustrazione attuale | {pain_point} |
| Come usa l'app | {scenario_uso} |
| Device principale | {device} |
| Momento d'uso | {momento} |

**Citazione rappresentativa:**
> "{frase_che_potrebbe_dire}"

---

## 6. Presenza Digitale

### Naming

| Canale | Handle consigliato | Disponibilità |
|--------|-------------------|---------------|
| App Store / Play Store | {nome_app} | — |
| Twitter / X | @{handle} | Da verificare |
| Instagram | @{handle} | Da verificare |
| TikTok | @{handle} | Da verificare |
| YouTube | {nome_canale} | Da verificare |
| LinkedIn (pagina) | {nome_pagina} | Da verificare |
| Dominio web | {dominio}.com / .app / .io | Da verificare |

### Email Brand

| Scopo | Indirizzo consigliato |
|-------|----------------------|
| Supporto | support@{dominio} |
| Privacy | privacy@{dominio} |
| Press | press@{dominio} |
| Generale | hello@{dominio} |

---

## 7. Linee Guida d'Uso del Brand

### Logo e Nome App

**Usa:**
- Il nome app con la maiuscola corretta: **{NomeApp}**
- Spazi minimi attorno al logo: almeno {n}px su ogni lato
- Su sfondi approvati: {bianco / nero / colore_primario}

**Non usare:**
- Versioni distorte, ruotate o con colori non approvati
- Il nome app in tutto maiuscolo o tutto minuscolo (salvo eccezioni specifiche)
- Il logo su sfondi che riducono il contrasto sotto 3:1

### Colori

**Usa:**
- La palette definita in sezione 3 per tutti i materiali digitali
- I colori semantici (successo/errore) solo per i loro scopi specifici

**Non usare:**
- Gradienti non approvati
- Colori al di fuori della palette per elementi branded

### Tipografia

**Usa:**
- I pesi e le dimensioni definiti nella gerarchia tipografica
- Il font di sistema ({SF Pro / Roboto}) come fallback

**Non usare:**
- Più di 2 font diversi nella stessa schermata
- Testo sotto i 12pt in produzione

---

## 8. Checklist Brand Identity

- [ ] Mission e vision condivise con il team
- [ ] Palette colori testata per accessibilità WCAG AA
- [ ] Dark mode verificata per tutti i colori
- [ ] Gerarchia tipografica implementata nel design system
- [ ] Icona app testata a 29pt, 60pt, 1024pt
- [ ] Handle social verificati e registrati
- [ ] Dominio registrato
- [ ] Linee guida condivise con designer e copywriter
- [ ] Tono di voce applicato a tutte le stringhe UI esistenti
- [ ] Personas validate con almeno 3 utenti reali
```

---

### Regole

- I colori ricavati dal codice hanno priorità su quelli suggeriti: segnala sempre *(da codice)* quando un valore è estratto.
- Se nel codice esistono colori semantici non denominati (es. `Color(hex: "#FF3B30")`), identificali e nominali.
- Le personas devono essere derivate dalla categoria e funzionalità reali dell'app, non generiche.
- Il tono di voce deve riflettere le stringhe UI già presenti nel progetto: se il copy esistente è formale, non suggerire un tono informale senza segnalarlo come cambiamento intenzionale.
- Per ogni sezione visiva, distingui chiaramente tra ciò che è ricavato dal progetto e ciò che è una raccomandazione.
- Non inventare colori, font o valori di spaziatura: se non rilevabili, indica "da definire" e fornisci una raccomandazione motivata.
- Lo spettro del tono di voce usa `●` per la posizione attuale e `○` per le posizioni non occupate — adattalo al profilo reale dell'app.
