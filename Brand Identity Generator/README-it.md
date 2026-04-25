# Brand Identity Generator

Un comando custom per Claude Code che analizza un progetto app e genera un documento completo di brand identity: fondamenta del brand, identità visiva (palette, tipografia, icona), tono di voce, messaggi chiave, personas e linee guida d'uso.

---

## Come funziona

```
Claude Code (nel progetto)
──────────────────────────────────────────────────
Legge app-store-listing.md, marketing.md, README
Estrae colori dal codice UI (SwiftUI, Android XML)
Estrae font dichiarati nel progetto
Analizza stringhe UI per il tono di voce
         ↓
Genera brand-identity.md
```

Dove possibile, il documento è costruito a partire da dati reali del progetto (colori, font, copy esistente) e non da template generici. Ogni valore estratto dal codice è marcato esplicitamente.

---

## Cosa contiene `brand-identity.md`

| Sezione | Contenuto |
|---------|-----------|
| **Fondamenta** | Mission, vision, valori, personalità del brand |
| **Tono di voce** | Profilo, spettro su 4 assi, do's & don'ts, esempi per ogni tipo di messaggio UI |
| **Palette colori** | Primari, secondari, neutri, semantici — con HEX e RGB; verifica contrasto WCAG; note dark mode |
| **Tipografia** | Font primario e secondario, gerarchia completa con pesi e dimensioni |
| **Icona app** | Descrizione caratteristiche visive rilevate + linee guida |
| **Stile visivo** | Iconografia, illustrazioni, spaziatura, border radius, elevazione |
| **Messaggi chiave** | UVP, tagline, elevator pitch, messaggi calibrati per canale |
| **Personas** | 2–3 profili utente derivati dalla categoria e funzionalità reali |
| **Presenza digitale** | Handle social consigliati, domini, indirizzi email per ruolo |
| **Linee guida uso** | Regole per logo, colori e tipografia |
| **Checklist** | Lista di controllo per completare l'identità |

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
cp brand-identity.md ~/.claude/commands/brand-identity.md
```

Il comando sarà disponibile in Claude Code come `/project:brand-identity`.

---

## Utilizzo

Apri il progetto in Claude Code ed esegui:

```
/project:brand-identity
```

### Workflow consigliato

Esegui i comandi nell'ordine in cui ognuno alimenta il successivo:

```
/project:app-store-listing   →   /project:marketing-advisor   →   /project:brand-identity
```

Il Brand Identity Generator legge i file generati dai comandi precedenti per evitare analisi ridondanti e mantenere coerenza tra i documenti.

---

## Note

- I colori estratti dal codice (SwiftUI `Color`, `UIColor`, Android `colors.xml`) hanno priorità sulle raccomandazioni: vengono riportati con il marker *(da codice)*.
- Il tono di voce viene derivato dalle stringhe UI esistenti nel progetto: se il copy attuale è formale, il documento lo riflette e segnala eventuali cambiamenti come scelte intenzionali.
- Il file è pensato per essere condiviso con designer e copywriter come riferimento unico per l'identità del brand.
