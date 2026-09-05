# Templator Peppol

Lokálny nástroj na vizualizáciu elektronických faktúr vytvorených podľa
Peppol BIS Billing 3.0. Projekt umožňuje načítať UBL/XML faktúru, vybrať
transformačnú XSLT šablónu a zobraziť výsledný HTML dokument.

## Funkcie

- výber XML faktúry zo serverovej knižnice,
- výber XSLT šablóny zo serverovej knižnice,
- nahratie vlastného XML a XSLT súboru,
- transformácia XML na HTML pomocou `DOMParser` a `XSLTProcessor`,
- náhľad vygenerovanej faktúry v iframe,
- zobrazenie vygenerovaného HTML zdrojového kódu,
- stiahnutie použitého XML, XSLT a výsledného HTML,
- moderná responzívna šablóna `oberon-modern-1`,
- prepínač režimu tlače na A4 na výšku,
- QR kód Pay by Square vo vygenerovanej faktúre,
- slovenské formátovanie dátumov a súm.

## Štruktúra

- `templator/code/index.html` – webové UI a klientská transformácia,
- `templator/code/docs` – odkaz na dokumenty dostupné cez webový server,
- `docs/xml` – vzorové a doplnené XML faktúry,
- `docs/sablony` – XSLT transformačné šablóny.

## Referenčné súbory

- `docs/xml/efaktura-refimo-1.xml` – pôvodné referenčné XML,
- `docs/xml/efaktura-refimo-2.xml` – doplnené referenčné XML,
- `docs/sablony/oberon-klasik.xslt` – pôvodná šablóna,
- `docs/sablony/oberon-vyhotovena-1.xslt` – šablóna s doplnenými údajmi,
- `docs/sablony/oberon-modern-1.xslt` – modernizovaná šablóna s A4 režimom.

Vzorkové kontaktné údaje a adresy v doplnenom XML sú testovacie údaje.

## Spustenie

Z adresára `templator/code`:

```bash
python3 -m http.server 10001 --bind 0.0.0.0
```

Webové UI je potom dostupné na `http://<IP-adresa-počítača>:10001/`.

## Poznámka k transformácii

Transformácia prebieha v prehliadači. Na načítanie serverových súborov musí byť
webové UI spustené z HTTP servera; pri otvorení HTML súboru priamo z disku
nemusia fungovať požiadavky `fetch()`.
