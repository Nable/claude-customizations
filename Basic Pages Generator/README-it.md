# Basic Pages Generator

Un comando custom per Claude Code che analizza un progetto iOS, Android o cross-platform e genera le pagine HTML statiche obbligatorie per la pubblicazione su App Store Connect e Google Play Console.

---

## Come funziona

```
Claude Code (nel progetto)
──────────────────────────────────────────
Rileva piattaforma (iOS / Android / entrambe)
Legge permessi, capability, SDK di terze parti
Legge app-store-listing.md se presente
         ↓
docs/privacy.html
docs/support.html
```

La privacy policy non è generica: viene calibrata sui permessi e gli SDK reali trovati nel progetto. Se l'app usa la fotocamera, la sezione "Foto e video" viene inclusa; se non usa la posizione, quella sezione non compare.

---

## Pagine generate

| File | Contenuto | Richiesto da |
|------|-----------|-------------|
| `docs/privacy.html` | Privacy policy calibrata sui permessi reali | App Store Connect, Google Play Console |
| `docs/support.html` | Supporto con FAQ contestualizzate, form contatto, badge store | App Store Connect, Google Play Console |

---

## Caratteristiche delle pagine

- **Self-contained**: nessuna dipendenza esterna, niente CDN
- **Mobile-first responsive**: ottimizzate per la lettura da smartphone
- **Dark mode**: rispettano `prefers-color-scheme: dark`
- **Accessibili**: contrasto adeguato, font-size ≥ 16px
- **Pronte per GitHub Pages**: basta abilitare `/docs` come source

---

## Cosa analizza

**iOS / macOS:**
- `NSUsageDescription` keys in `Info.plist` → sezioni privacy
- Entitlements → HealthKit, iCloud, Push, ecc.
- Import StoreKit → sezione acquisti in-app

**Android:**
- `uses-permission` in `AndroidManifest.xml` → sezioni privacy
- Gradle dependencies → SDK di terze parti (Firebase, AdMob, ecc.)

**Entrambi:**
- SDK analytics/crash rilevati → elencati nella sezione terze parti con link alle loro privacy policy
- Presenza di autenticazione → sezione dati account

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
cp generate-basic-pages.md ~/.claude/commands/generate-basic-pages.md
```

Il comando sarà disponibile in Claude Code come `/project:generate-basic-pages`.

---

## Utilizzo

Apri il progetto in Claude Code ed esegui:

```
/project:generate-basic-pages
```

Al termine, Claude stampa:
- Piattaforma/e rilevate
- Permessi trovati e sezioni privacy generate
- Path dei file creati
- Istruzioni per pubblicare su GitHub Pages
- Elenco dei campi `[DA COMPILARE]` rimasti

### Workflow consigliato

1. Esegui `/project:generate-basic-pages`
2. Apri `docs/privacy.html` e `docs/support.html` e compila i `[DA COMPILARE]` (email, nome sviluppatore, URL store)
3. Abilita GitHub Pages su `/docs` nel repository
4. Incolla gli URL in App Store Connect / Google Play Console

---

## Note

- Le pagine sono in italiano se il progetto è in italiano, in inglese se il progetto è in inglese.
- Non sovrascrive altri file già presenti in `docs/`.
- Le FAQ nella pagina di supporto sono generate in base alle funzionalità reali dell'app, non sono generiche.
- Per aggiornare le pagine dopo aver aggiunto nuovi permessi, ri-esegui il comando: verrà rigenerato solo `privacy.html` e `support.html`.
