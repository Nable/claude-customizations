Analizza il progetto e genera le pagine HTML statiche necessarie alla pubblicazione, salvandole nella cartella `docs/` nella root del progetto.

Identifica prima la piattaforma leggendo la struttura del progetto:
- **iOS / macOS**: presenza di `Info.plist`, `.xcodeproj`, `.xcworkspace`, `Package.swift` con target Apple
- **Android**: presenza di `AndroidManifest.xml`, `build.gradle` / `build.gradle.kts`, sorgenti Kotlin o Java
- **Cross-platform** (Flutter, React Native, ecc.): entrambe le strutture presenti

Se esiste `app-store-listing.md` nella root, leggilo per recuperare nome app, descrizione e categoria. Altrimenti ricava i dati da `Info.plist`, `AndroidManifest.xml` o `README`.

Raccogli dal progetto:
- Nome app e versione
- Bundle ID / Application ID
- Permessi e capability dichiarati (entitlements iOS, `uses-permission` Android, `NSUsageDescription` keys, StoreKit, HealthKit, ecc.)
- SDK di terze parti rilevati (Firebase, Crashlytics, AdMob, Mixpanel, ecc.)
- Se l'app richiede un account utente (presenza di autenticazione nel codice)

---

### Pagine da generare

**Sempre** (entrambe le piattaforme richiedono entrambe):

| File | Scopo | Richiesto da |
|------|-------|-------------|
| `docs/privacy.html` | Privacy Policy | App Store Connect, Google Play Console |
| `docs/support.html` | Pagina di supporto | App Store Connect, Google Play Console |

---

### Specifiche HTML

Ogni pagina deve essere:
- **Self-contained**: nessuna dipendenza esterna, tutto inline (CSS nel `<style>`, nessun CDN)
- **Mobile-first responsive**: leggibile su iPhone/Android senza zoom
- **Dark mode**: rispetta `prefers-color-scheme: dark`
- **Accessibile**: contrasto sufficiente, font-size base ≥16px, `lang` attribute corretto
- **Leggera**: niente JavaScript, niente framework

Palette colori: sfondo bianco (#ffffff / #1c1c1e dark), testo #1d1d1f (#f5f5f7 dark), accent #0071e3 (blue Apple).

Header con nome app e logo placeholder, footer con data ultimo aggiornamento e copyright.

---

### `docs/privacy.html` — Privacy Policy

Genera una privacy policy **calibrata sui permessi reali del progetto**. Per ogni permission o capability rilevata, includi la sezione corrispondente.

Struttura della pagina:

```
[Header: nome app + "Privacy Policy"]

Ultimo aggiornamento: {data_generazione}

1. Informazioni che raccogliamo
   → Sezioni generate dinamicamente in base ai permessi rilevati:

   [Se location / NSLocationWhenInUseUsageDescription / ACCESS_FINE_LOCATION]
   • Dati di posizione — come vengono usati, quando, se condivisi

   [Se camera / NSCameraUsageDescription / CAMERA]
   • Foto e video — solo locali o caricati, retention

   [Se contacts / NSContactsUsageDescription / READ_CONTACTS]
   • Rubrica — scopo dell'accesso

   [Se HealthKit / NSHealthShareUsageDescription]
   • Dati sulla salute — trattamento speciale GDPR

   [Se microfono / NSMicrophoneUsageDescription / RECORD_AUDIO]
   • Audio — registrazione, archiviazione, condivisione

   [Se identificatori / tracking / ATT]
   • Identificatori del dispositivo — IDFA, uso per advertising

   [Se push notifications]
   • Notifiche push — token, come viene usato

   [Se Firebase Analytics / Crashlytics / simili]
   • Dati di utilizzo e diagnostica — tool usati, link privacy terze parti

   [Se autenticazione / account utente]
   • Dati account — email, nome, come archiviati

   [Se acquisti in-app / StoreKit]
   • Dati di acquisto — gestiti da Apple/Google, non da noi

   [Se nessun permesso rilevato]
   • L'app non raccoglie dati personali.

2. Come usiamo i dati
   → Lista puntata calibrata sulle sezioni precedenti

3. Condivisione con terze parti
   → Elenca gli SDK rilevati con link alle rispettive privacy policy
   → Se nessuno: "Non condividiamo dati con terze parti."

4. Conservazione dei dati
   → Policy di retention, dove vengono archiviati i dati

5. I tuoi diritti
   → GDPR (utenti EU): accesso, rettifica, cancellazione, portabilità
   → CCPA (utenti California): disclosure, opt-out
   → Come esercitarli (email [DA COMPILARE])

6. Minori
   → L'app non è diretta a bambini sotto i 13 anni (o indicazione contraria se rilevata dalla categoria)

7. Modifiche a questa policy
   → Comunicazione tramite aggiornamento in-app o email

8. Contatti
   → [DA COMPILARE — email privacy]
   → [DA COMPILARE — nome sviluppatore / azienda]
   → [DA COMPILARE — indirizzo]
```

---

### `docs/support.html` — Pagina di Supporto

Struttura della pagina:

```
[Header: nome app + "Supporto"]

[Hero: nome app, versione, icona placeholder, badge App Store / Google Play a seconda della piattaforma]

---

Come possiamo aiutarti?
[Campo di ricerca — solo UI, no JS, link a mailto]

---

Domande frequenti
→ Genera 5–8 FAQ contestualizzate alle funzionalità rilevate nel progetto.
  Esempi: "Come faccio a [azione principale]?", "Perché l'app richiede accesso a [permesso]?",
  "Come cancello il mio account?", "Come ripristino gli acquisti?"
  Usa accordion CSS-only (checkbox hack) per espandere/collassare.

---

Contattaci
→ Card con:
   - Email: [DA COMPILARE]
   - Tempo di risposta stimato: entro 48 ore
   - Form mailto: oggetto precompilato "[Nome App] — Supporto | v{versione}"

---

[Se iOS] Valutaci sull'App Store
→ Link placeholder [DA COMPILARE — App Store URL]

[Se Android] Valutaci su Google Play
→ Link placeholder [DA COMPILARE — Play Store URL]

---

[Footer: © {anno} [DA COMPILARE — Nome Sviluppatore] · Privacy Policy (link a privacy.html) · Versione {versione}]
```

---

### Al termine

Stampa un riepilogo con:
- Piattaforma/e rilevate
- Permessi trovati e sezioni privacy generate di conseguenza
- Elenco file creati con path
- Istruzioni per pubblicare su GitHub Pages:
  ```
  1. Vai su Settings → Pages nel tuo repository
  2. Source: Deploy from a branch
  3. Branch: main (o master) · Folder: /docs
  4. Le URL saranno: https://{username}.github.io/{repo}/privacy
                     https://{username}.github.io/{repo}/support
  ```
- Campi `[DA COMPILARE]` rimasti, elencati per file

---

### Regole

- Genera HTML completo e valido: `<!DOCTYPE html>`, `<html lang="it">`, `<meta charset>`, `<meta viewport>`, `<title>`.
- Tutto il CSS è inline nel `<style>` dell'`<head>`. Zero classi Tailwind, zero Bootstrap, zero CDN.
- I testi devono essere in italiano, a meno che il progetto non sia chiaramente in inglese (README in inglese, commenti in inglese) — in quel caso genera in inglese.
- Le FAQ devono essere specifiche all'app, non generiche. Usa le funzionalità reali rilevate nel codice.
- Non inventare dati di contatto: usa sempre `[DA COMPILARE]` per email, nome sviluppatore, indirizzo.
- Se `docs/` esiste già, non sovrascrivere file che non siano `privacy.html` e `support.html`.
