Analizza il progetto e genera un file `marketing.md` nella root con una strategia di marketing completa, pronta all'uso.

Se esiste `app-store-listing.md` nella root, leggilo per recuperare nome, descrizione, categoria e funzionalità dell'app. Altrimenti ricavali da `Info.plist`, `README`, sorgenti e asset.

Identifica: nome app, funzionalità principali (max 5), target audience, categoria, modello di prezzo (free/paid/freemium/subscription), piattaforme supportate.

---

### Output — `marketing.md`

```
# Marketing Plan — {Nome App}
> Generato: {data} | Versione: {versione}

---

## Profilo App

| Campo | Valore |
|-------|--------|
| Nome | {nome} |
| Categoria | {categoria} |
| Target | {target_audience} |
| Modello | {modello_prezzo} |
| Piattaforme | {piattaforme} |
| Proposta di valore | {una_frase_che_spiega_perché_scaricarla} |

### Punti di forza da comunicare

1. {punto_1}
2. {punto_2}
3. {punto_3}

---

## Piattaforme Consigliate

Per ogni piattaforma indica: priorità (🔴 Alta / 🟠 Media / 🟢 Bassa), frequenza consigliata, tipo di contenuto più efficace.

| Piattaforma | Priorità | Frequenza | Formato ideale |
|-------------|----------|-----------|----------------|
| {piattaforma} | {priorità} | {frequenza} | {formato} |

La priorità si basa sul target dell'app: se il target sono sviluppatori usa Hacker News e Twitter/X; se è consumer usa Instagram e TikTok; se è B2B usa LinkedIn.

---

## Piano di Lancio

### Pre-lancio (4–6 settimane prima)

- [ ] {azione_1}
- [ ] {azione_2}
- [ ] {azione_3}
- [ ] Creare landing page con form waitlist
- [ ] Pubblicare su Product Hunt "upcoming"
- [ ] Contattare 5 reviewer/blogger di settore

### Lancio (giorno 0)

- [ ] Pubblicare su Product Hunt
- [ ] Post su tutti i canali social
- [ ] Inviare email alla waitlist
- [ ] Post su Reddit nei subreddit rilevanti
- [ ] Show HN su Hacker News (se target dev)
- [ ] Rispondere a tutti i commenti nelle prime 24h

### Post-lancio (prime 4 settimane)

- [ ] Raccogliere e pubblicare recensioni
- [ ] Produrre contenuto "dietro le quinte"
- [ ] Analizzare keyword ASO e aggiustare
- [ ] Outreach a youtuber/podcaster di settore
- [ ] A/B test degli screenshot in App Store

---

## Esempi di Post per Piattaforma

Per ogni piattaforma genera 3 post pronti all'uso, calibrati sul tono giusto per quella piattaforma. Ogni post deve essere completo (testo + hashtag dove utile) e rispettare i limiti di caratteri.

Genera post per le piattaforme ad alta priorità per quest'app. Scegli tra:

### Twitter / X *(max 280 caratteri)*

**Post 1 — Lancio**
```
{testo_post} {hashtag}
```

**Post 2 — Feature highlight**
```
{testo_post} {hashtag}
```

**Post 3 — Social proof / problema risolto**
```
{testo_post} {hashtag}
```

---

### Instagram *(caption + hashtag block)*

**Post 1 — Lancio**
```
{caption}

{hashtag_block_30_max}
```

**Post 2 — Feature highlight**
```
{caption}

{hashtag_block_30_max}
```

**Post 3 — Behind the scenes / storia sviluppatore**
```
{caption}

{hashtag_block_30_max}
```

---

### Reddit

Per ogni post indica il subreddit consigliato.

**Post 1 — Lancio** | r/{subreddit}
Titolo: `{titolo}`
```
{corpo_post}
```

**Post 2 — Ask for feedback** | r/{subreddit}
Titolo: `{titolo}`
```
{corpo_post}
```

**Post 3 — Valore educativo / tip** | r/{subreddit}
Titolo: `{titolo}`
```
{corpo_post}
```

---

### LinkedIn *(tono professionale)*

**Post 1 — Lancio**
```
{testo_post}
```

**Post 2 — Problema → soluzione**
```
{testo_post}
```

---

### Product Hunt

**Tagline** *(max 60 caratteri)*
```
{tagline} ({n} caratteri)
```

**Descrizione** *(max 260 caratteri)*
```
{descrizione} ({n} caratteri)
```

**Primo commento del founder** *(post da pubblicare subito dopo il lancio)*
```
{commento_founder}
```

---

### Hacker News *(solo se target developer)*

**Show HN**
Titolo: `Show HN: {titolo}`
```
{corpo — max 2 paragrafi, tono tecnico, no hype}
```

---

### Indie Hackers *(solo se indie / bootstrapped)*

Titolo: `{titolo}`
```
{corpo — racconta la storia, include numeri reali o target, chiedi feedback}
```

---

## Subreddit Consigliati

Elenca i subreddit più rilevanti per questa app, con indicazione del tipo di post accettato e le regole da rispettare.

| Subreddit | Membri (stima) | Tipo post ok | Note regole |
|-----------|---------------|--------------|-------------|
| r/{nome} | {stima} | {tipo} | {note} |

---

## Outreach — Reviewer e Creator

Suggerisci categorie di creator/blogger/podcaster da contattare per review o menzioni.

| Tipo | Esempi di canali/formati | Cosa offrire |
|------|--------------------------|--------------|
| {tipo} | {esempi} | {offerta} |

### Template email di outreach

```
Oggetto: {oggetto_email}

{corpo_email_template}
```

---

## ASO — App Store Optimization

### Keyword strategy

Keyword principali da presidiare (ad alta rilevanza per questa app):

| Keyword | Difficoltà stimata | Volume stimato | Posizione target |
|---------|--------------------|----------------|------------------|
| {keyword} | Alta / Media / Bassa | Alto / Medio / Basso | Top 3 / Top 10 |

### Suggerimenti A/B test

- [ ] {suggerimento_screenshot}
- [ ] {suggerimento_icona}
- [ ] {suggerimento_testo_promozionale}

---

## Metriche da Monitorare

| Metrica | Tool | Frequenza controllo |
|---------|------|---------------------|
| Download giornalieri | App Store Connect | Giornaliera |
| Conversione pagina App Store | App Store Connect | Settimanale |
| Rating medio | App Store Connect | Settimanale |
| Impression ricerca | App Store Connect | Settimanale |
| Traffico referral | {analytics_tool} | Settimanale |
| Menzioni social | {tool} | Giornaliera |

---

## Checklist Marketing

- [ ] Profilo Twitter/X creato e bio aggiornata
- [ ] Pagina Instagram creata con link in bio
- [ ] Landing page o sito con link App Store
- [ ] Privacy Policy pubblicata online
- [ ] Press kit pronto (icona, screenshot, descrizione breve)
- [ ] Email di supporto attiva
- [ ] Risposta automatica configurata
- [ ] Account Product Hunt creato
- [ ] 5+ reviewer contattati prima del lancio
- [ ] Calendario editoriale del primo mese pianificato
```

---

### Regole

- Tono dei post: adattalo al target. App per sviluppatori → tono diretto e tecnico. App consumer → tono caldo e benefit-first. App B2B → tono professionale con ROI.
- I post devono essere **pronti all'uso**: nessun placeholder generico, tutto contestualizzato all'app analizzata.
- Hashtag su Twitter/X: max 2–3, solo quelli davvero usati nel settore.
- Hashtag su Instagram: block da 20–30, mix di grandi (#productivity, 2M+) e di nicchia (#{nicchia}app, <50K).
- Reddit: mai promuovere direttamente senza valore. I post "Ask for feedback" e quelli educativi sono sempre meglio accolti dei post promozionali.
- Product Hunt: il commento del founder è cruciale — deve ringraziare, spiegare la genesi dell'app e chiedere feedback specifico.
- Hacker News: zero hype, zero aggettivi come "amazing" o "revolutionary". Solo fatti e tecnica.
- Se non riesci a determinare un dato (es. numero iscritti di un subreddit), usa una stima ragionata e indicala come tale.
- Non inventare nomi di creator specifici: usa categorie ("YouTuber di produttività con 100K+ iscritti") invece di nomi propri.
