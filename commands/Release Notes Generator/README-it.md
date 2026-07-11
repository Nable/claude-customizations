# Release Notes Generator

Un comando custom per Claude Code che analizza la cronologia git del progetto e genera `release-notes.md` con il testo "Cosa c'è di nuovo" pronto per App Store Connect, più un changelog tecnico completo.

---

## Come funziona

```
Claude Code (nel progetto)
──────────────────────────────────────────────────
Determina l'intervallo (ultimo tag → HEAD, o argomenti)
Classifica i commit (feature / miglioramento / fix / interno)
Legge i diff quando il messaggio non basta
Rileva versione e lingua del progetto
         ↓
release-notes.md
```

Le voci interne (refactor, CI, chore) restano nel changelog tecnico ma non compaiono nelle note utente. Il testo per App Store Connect è scritto in linguaggio utente-centrico e verificato contro il limite di 4.000 caratteri.

---

## Utilizzo

```
/release-notes                  # dall'ultimo tag a HEAD
/release-notes v1.2.0           # da v1.2.0 a HEAD
/release-notes v1.2.0 v1.3.0    # intervallo esplicito
```

## Installazione

Dalla root del repository esegui `./install.sh`, oppure:

```bash
mkdir -p ~/.claude/commands
cp release-notes.md ~/.claude/commands/release-notes.md
```

Il comando sarà disponibile in Claude Code come `/release-notes`.

---

## Note

- Il "Cosa c'è di nuovo" viene generato nella lingua principale del progetto **e** in inglese.
- Nessuna feature inventata: se nell'intervallo non ci sono modifiche visibili all'utente, il comando lo dice e propone un testo minimo segnalandolo come generico.
- Il conteggio caratteri è verificato via shell, non stimato.
