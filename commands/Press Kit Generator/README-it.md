# Press Kit Generator

Un comando custom per Claude Code che analizza il progetto e genera un press kit completo nella cartella `press-kit/`: una pagina HTML self-contained da condividere con stampa, blogger e creator, più gli stessi testi in markdown per copia-incolla rapido.

---

## Come funziona

```
Claude Code (nel progetto)
──────────────────────────────────────────────────
Riusa app-store-listing.md, marketing.md,
style-guide/style-tokens.json se presenti
Estrae dal progetto ciò che manca (icona, feature, versione)
Chiede solo: contatti press, URL, sviluppatore
         ↓
press-kit/index.html
press-kit/press-kit.md
```

---

## Cosa contiene

| Sezione | Contenuto |
|---------|-----------|
| Hero | Icona, nome, tagline, badge piattaforme |
| Fact sheet | Sviluppatore, categoria, prezzo, piattaforme, data lancio, link |
| Boilerplate | Descrizioni da 50 / 100 / 250 parole, in italiano e inglese, con pulsante "Copia" |
| Funzionalità | Le 6 feature principali con spiegazione |
| Asset | Icona scaricabile nelle varie dimensioni + istruzioni screenshot |
| Contatti stampa | Email e link con mailto precompilato |

---

## Utilizzo

```
/press-kit
```

## Installazione

Dalla root del repository esegui `./install.sh`, oppure:

```bash
mkdir -p ~/.claude/commands
cp press-kit.md ~/.claude/commands/press-kit.md
```

Il comando sarà disponibile in Claude Code come `/press-kit`.

### Workflow consigliato

```
/app-store-listing   →   /marketing-advisor   →   /style-guide   →   /press-kit
```

Il Press Kit Generator riusa gli artefatti dei comandi precedenti: descrizioni coerenti con il listing, colori e font dalla style guide.

---

## Note

- I conteggi parole dei boilerplate sono verificati via shell, non stimati.
- Nessun dato inventato: prezzi, date e URL non rilevabili restano `[DA COMPILARE]`; niente citazioni di stampa fittizie.
- La pagina è self-contained: CSS inline, icona in base64, nessuna dipendenza esterna.
- La pagina è sempre in inglese; solo la sezione boilerplate è bilingue (italiano + inglese).
