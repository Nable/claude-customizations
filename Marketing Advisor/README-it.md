# Marketing Advisor

Un comando custom per Claude Code che analizza un progetto iOS/macOS e genera un piano di marketing completo e pronto all'uso, con esempi di post già scritti per ogni piattaforma.

---

## Come funziona

```
Claude Code (nel progetto iOS/macOS)
────────────────────────────────────
Legge Info.plist, README, app-store-listing.md
Analizza funzionalità e target audience
         ↓
Genera marketing.md
```

Il comando capisce cosa fa l'app, chi è il suo pubblico e quanto costa, poi produce una strategia marketing contestualizzata con post pronti, subreddit consigliati, template email per i reviewer e piano di lancio.

---

## Cosa genera

Un singolo file `marketing.md` nella root del progetto con:

| Sezione | Contenuto |
|---------|-----------|
| Profilo app | Target, proposta di valore, punti di forza da comunicare |
| Piattaforme consigliate | Priorità, frequenza e formato ideale per ogni canale |
| Piano di lancio | Checklist pre-lancio, lancio e post-lancio |
| Post pronti | Twitter/X, Instagram, Reddit, LinkedIn, Product Hunt, Hacker News, Indie Hackers |
| Subreddit consigliati | Elenco con note sulle regole di ogni community |
| Outreach | Categorie di reviewer e template email |
| ASO | Keyword strategy e suggerimenti A/B test |
| Metriche | Cosa monitorare, con quale tool e con quale frequenza |
| Checklist | Lista completa per non dimenticare nulla al lancio |

---

## Installazione

### Prerequisiti

- [Claude Code](https://claude.ai/code) installato e configurato
- Un progetto iOS o macOS

### Installare il comando custom

Crea la cartella dei comandi custom se non esiste:

```bash
mkdir -p ~/.claude/commands
```

Copia il file del comando:

```bash
cp marketing-advisor.md ~/.claude/commands/marketing-advisor.md
```

Il comando sarà disponibile in Claude Code come `/project:marketing-advisor`.

---

## Utilizzo

Apri il progetto iOS/macOS in Claude Code ed esegui:

```
/project:marketing-advisor
```

### Workflow consigliato

1. Esegui prima `/project:app-store-listing` — il Marketing Advisor lo legge per capire meglio l'app
2. Esegui `/project:marketing-advisor`
3. Revisiona i post e personalizza tono e dettagli
4. Usa la checklist come guida per il lancio

---

## Note

- I post vengono scritti direttamente contestualizzati sull'app: non sono template generici con placeholder.
- Il tono viene adattato automaticamente al target: tecnico per app developer, caldo e benefit-first per app consumer, professionale per B2B.
- Il file `marketing.md` è pensato per essere versionato insieme al codice, così da aggiornarlo ad ogni release.
