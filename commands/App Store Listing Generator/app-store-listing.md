Analizza il progetto iOS/macOS e genera un file `app-store-listing.md` nella root del progetto con tutte le informazioni necessarie per la pubblicazione su App Store Connect.

Inizia identificando il tipo di progetto: leggi `Info.plist`, il file `.xcodeproj` o `Package.swift`, `CHANGELOG`, `README`, e scorri le schermate principali (SwiftUI views, Storyboard, ecc.) per capire cosa fa l'app.

---

### Informazioni da raccogliere dal progetto

**Dati tecnici** (ricavati automaticamente):
- Nome app (`CFBundleDisplayName` o `CFBundleName`)
- Bundle ID (`CFBundleIdentifier`)
- Versione (`CFBundleShortVersionString`)
- Build number (`CFBundleVersion`)
- Deployment target (`MinimumOSVersion` / `LSMinimumSystemVersion`)
- Piattaforme supportate (iPhone, iPad, Mac, Vision Pro)
- Orientamenti supportati
- Capability ed entitlement usati (Push, HealthKit, iCloud, ecc.)
- Framework e dipendenze principali
- Lingua principale del progetto

**Contenuto** (derivato dall'analisi dell'app):
- Funzionalità principali (max 10 punti chiave)
- Pubblico target
- Categorie App Store più adatte (primaria + secondaria)
- Suggerimenti per screenshot (una riga per schermata chiave)

---

### Output — `app-store-listing.md`

Genera il file con la seguente struttura. Per ogni campo indica tra parentesi il limite di caratteri Apple dove applicabile. Lascia `[DA COMPILARE]` solo per informazioni che non puoi ricavare dal codice (URL, prezzi, contatti).

```
# App Store Listing — {Nome App}
> Generato: {data} | Versione: {versione} | Bundle ID: {bundle_id}

---

## Metadati Principali

### Nome app *(max 30 caratteri)*
{nome_app} ({n} caratteri)

### Sottotitolo *(max 30 caratteri)*
{sottotitolo} ({n} caratteri)

### Testo promozionale *(max 170 caratteri — modificabile senza nuova versione)*
{testo_promozionale} ({n} caratteri)

### Descrizione *(max 4.000 caratteri)*
{descrizione_completa}

Lunghezza: {n} caratteri

### Parole chiave *(max 100 caratteri, separate da virgola, senza spazi dopo la virgola)*
{keywords}

Lunghezza: {n} caratteri

### Cosa c'è di nuovo *(max 4.000 caratteri)*
{release_notes}

---

## URL e Contatti

| Campo | Valore |
|-------|--------|
| URL di supporto | [DA COMPILARE] |
| URL marketing | [DA COMPILARE] |
| Privacy Policy URL | [DA COMPILARE] |
| Email di supporto | [DA COMPILARE] |

---

## Classificazione

| Campo | Valore |
|-------|--------|
| Categoria primaria | {categoria_primaria} |
| Categoria secondaria | {categoria_secondaria} |
| Copyright | © {anno} [DA COMPILARE — Nome Sviluppatore/Azienda] |
| Valutazione età | {valutazione_eta} |

### Dettaglio valutazione età

| Contenuto | Livello |
|-----------|---------|
| Violenza cartoon o fantasy | Nessuno / Lieve / Moderato / Frequente |
| Violenza realistica | Nessuno / Lieve / Moderato / Frequente |
| Linguaggio volgare | Nessuno / Lieve / Moderato / Frequente |
| Contenuto sessuale | Nessuno / Lieve / Moderato / Frequente |
| Consumo di alcol, tabacco, droghe | Nessuno / Lieve / Moderato / Frequente |
| Gambling | Sì / No |
| Horror / paura | Nessuno / Lieve / Moderato / Frequente |
| Contenuto medico / trattamenti | Sì / No |
| Contenuto generato dagli utenti | Sì / No |
| Accesso non ristretto al web | Sì / No |

Valutazione risultante: {valutazione_eta_risultante}

---

## Informazioni Tecniche

| Campo | Valore |
|-------|--------|
| Versione | {versione} |
| Build number | {build_number} |
| Bundle ID | {bundle_id} |
| Deployment target | {deployment_target} |
| Piattaforme | {piattaforme} |
| Orientamenti | {orientamenti} |

### Capability richieste

{lista_capability}

### Dipendenze principali

{lista_dipendenze}

---

## Screenshot consigliati

Suggerimenti per le schermate da includere (in ordine consigliato):

| # | Schermata | Descrizione testo overlay |
|---|-----------|--------------------------|
{righe_screenshot}

Dimensioni richieste da Apple:
- **6,9" / 6,7"** (iPhone 16 Pro Max / 15 Pro Max) — obbligatorio
- **6,5"** (iPhone 14 Plus / 13 Pro Max) — obbligatorio se non si usa 6,9"/6,7"
- **5,5"** (iPhone 8 Plus) — opzionale, consigliato per compatibilità
- **iPad 13"** — obbligatorio se l'app supporta iPad
- **iPad 11"** — obbligatorio se l'app supporta iPad

---

## Localizzazioni

Lingua principale rilevata: {lingua_principale}

| Lingua | Nome | Sottotitolo | Descrizione | Keywords | Pronto |
|--------|------|-------------|-------------|----------|--------|
| {lingua_principale} | ✅ | ✅ | ✅ | ✅ | ✅ |
{righe_lingue_aggiuntive}

---

## Prezzi e Disponibilità

| Campo | Valore |
|-------|--------|
| Prezzo base | [DA COMPILARE] |
| Modello | [DA COMPILARE — Gratis / Pagamento / Freemium / Abbonamento] |
| Disponibilità | [DA COMPILARE — Tutti i paesi / Selezione specifica] |
| Data rilascio | [DA COMPILARE — Immediata / Pianificata] |

---

## In-App Purchase (se presenti)

{sezione_iap}

---

## Note per la revisione App Store

{note_revisione}

---

## Checklist pre-invio

- [ ] Screenshots caricati per tutti i formati richiesti
- [ ] Privacy Policy URL attivo e raggiungibile
- [ ] Support URL attivo e raggiungibile
- [ ] Tutti i campi obbligatori compilati
- [ ] Privacy Nutrition Labels compilate in App Store Connect
- [ ] Privacy Manifest (`PrivacyInfo.xcprivacy`) incluso nel bundle
- [ ] Export Compliance dichiarata
- [ ] Valutazione età compilata
- [ ] In-App Purchase configurati (se applicabile)
- [ ] Subscription Groups configurati (se applicabile)
- [ ] TestFlight beta completata
- [ ] Credentials per la revisione fornite (se l'app richiede login)
```

---

### Regole

- Scrivi nome, sottotitolo, testo promozionale e keywords **già ottimizzati per ASO** (App Store Optimization): usa termini di ricerca rilevanti, evita la ripetizione del nome app nelle keywords.
- La descrizione deve aprire con il beneficio principale (primo paragrafo = hook), poi elencare le funzionalità, poi chiudere con una CTA.
- Per la valutazione età: analizza capability, entitlement e funzionalità dell'app; in assenza di contenuti espliciti usa "4+" come default.
- Se l'app ha `StoreKit`, `SKPaymentQueue` o `Product` (StoreKit 2), includi la sezione In-App Purchase elencando i prodotti trovati nel codice.
- Le note per la revisione devono includere: credenziali di test se l'app richiede login (usa valori placeholder), spiegazione di funzionalità non ovvie, eventuali permission richieste con motivazione.
- Conta sempre i caratteri e segnala se un campo supera il limite Apple.
- Se non riesci a determinare un valore, usa `[DA COMPILARE]` — non inventare.
