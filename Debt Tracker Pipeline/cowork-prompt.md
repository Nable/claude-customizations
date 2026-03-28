Cerca tutti i file `debts.json` nelle sottocartelle del workspace (non ricorsivo oltre il primo livello).

Con i dati raccolti, genera una singola dashboard HTML interattiva e salvala come `debts-dashboard.html` nella root del workspace.

La dashboard deve contenere:

1. **Header** con data ultimo aggiornamento e numero totale di progetti analizzati

2. **Sommario globale** — barre o contatori aggregati su tutti i progetti per priorità:
   - 🔴 Critico, 🟠 Alto, 🟡 Medio, 🟢 Basso

3. **Sommario per progetto** — una card per ogni progetto con nome, stack, data analisi e breakdown priorità

4. **Tabella debiti** filtrabile e ordinabile con colonne:
   - ID (usa i codici esatti dal JSON, es. DEBT-001)
   - Progetto
   - Priorità
   - Categoria
   - Titolo
   - File
   - Righe

5. **Filtri** per: progetto, priorità, categoria

6. **Vista dettaglio** — click su una riga espande descrizione, impatto e soluzione suggerita

Usa i codici DEBT-XXX esattamente come presenti nei file, senza modificarli.
Non inventare dati: usa solo ciò che trovi nei file JSON.
