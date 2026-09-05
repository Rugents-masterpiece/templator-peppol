<?xml version="1.0" encoding="UTF-8"?>
<!--
  XSLT 1.0 verzia – zmeny oproti pôvodnej 2.0:
  1. version="2.0" → version="1.0"
  2. Odstránený xmlns:xs (XSLT 1.0 nepoužíva typový systém XS)
  3. xsl:function u:codelist → xsl:template name="codelist" s xsl:with-param
  4. Nový xsl:template name="label" nahrádza neuvedenú u:label funkciu
  5. Pridaný xsl:param name="language" (v 2.0 bol pravdepodobne v nedostupnej časti)
  6. xsl:copy-of select="u:label(...)" → priamy xsl:call-template
  7. Všetky volania u:codelist(...) → xsl:call-template name="codelist"
  8. Kompletne nový moderný CSS dizajn
  9. exclude-result-prefixes aktualizované (odstránené xs)
  POZNÁMKA: Ak v neviditeľnej časti pôvodného súboru existujú ďalšie
  xsl:function alebo iné XSLT 2.0 konštrukcie, tie treba rovnako konvertovať.
-->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
  xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
  xmlns:cn="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
  xmlns:in="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
  xmlns:u="utils"
  version="1.0"
  exclude-result-prefixes="cac cbc u cn in">

    <xsl:output method="html" version="4.0" encoding="UTF-8" indent="no"/>

    <!-- XSLT 1.0 nemá globálne premenné typu xs:string, používame obyčajné parametre -->
    <xsl:param name="language" select="'en'"/>
    <xsl:param name="stylesheet_url" select="'NONE'"/>

    <!-- ============================================ -->
    <!--  Štítky – nahrádza pôvodnú u:label funkciu  -->
    <!-- ============================================ -->
    <xsl:variable name="labels">
        <l id="document">
            <e id="Invoice"><t id="en">Invoice</t><t id="sk">Faktúra</t><t id="no">Faktura</t><t id="de">Rechnung</t></e>
            <e id="CreditNote"><t id="en">Credit Note</t><t id="sk">Dobropis</t><t id="no">Kreditnota</t><t id="de">Gutschrift</t></e>
        </l>
        <l id="party">
            <e id="Supplier"><t id="en">Supplier</t><t id="sk">Dodávateľ</t><t id="no">Leverandør</t><t id="de">Lieferant</t></e>
            <e id="Customer"><t id="en">Customer</t><t id="sk">Odberateľ</t><t id="no">Kunde</t><t id="de">Kunde</t></e>
        </l>
        <l id="tax">
            <e id="Tax"><t id="en">Tax</t><t id="sk">Daň</t><t id="no">Avgift</t><t id="de">Steuer</t></e>
        </l>
        <l id="payment">
            <e id="Payment"><t id="en">Payment</t><t id="sk">Platba</t><t id="no">Betaling</t><t id="de">Zahlung</t></e>
        </l>
    </xsl:variable>

    <!-- Šablóna nahrádza xsl:function name="u:label" -->
    <xsl:template name="label">
        <xsl:param name="category"/>
        <xsl:param name="key"/>
        <xsl:choose>
            <xsl:when test="$labels/l[@id=$category]/e[@id=$key]/t[@id=$language]">
                <xsl:value-of select="$labels/l[@id=$category]/e[@id=$key]/t[@id=$language]/text()"/>
            </xsl:when>
            <xsl:when test="$labels/l[@id=$category]/e[@id=$key]/t[@id='en']">
                <xsl:value-of select="$labels/l[@id=$category]/e[@id=$key]/t[@id='en']/text()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$key"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Šablóna nahrádza xsl:function name="u:codelist" -->
    <xsl:template name="codelist">
        <xsl:param name="codelist"/>
        <xsl:param name="code"/>
        <xsl:choose>
            <xsl:when test="$codelists/cl[@id=$codelist]/c[@id=$code]/t[@id=$language]">
                <xsl:value-of select="$codelists/cl[@id=$codelist]/c[@id=$code]/t[@id=$language]/text()"/>
            </xsl:when>
            <xsl:when test="$codelists/cl[@id=$codelist]/c[@id=$code]/t[@id='en']">
                <xsl:value-of select="$codelists/cl[@id=$codelist]/c[@id=$code]/t[@id='en']/text()"/>
            </xsl:when>
            <xsl:otherwise>
                <span class="mtr">[code:<xsl:value-of select="$codelist"/>:<xsl:value-of select="$code"/>]</span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ============================================ -->
    <!--  Hlavička dokumentu s moderným CSS           -->
    <!-- ============================================ -->
    <xsl:template name="doc-head">
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <xsl:choose>
            <xsl:when test="$stylesheet_url = 'NONE'">
                <link rel="preconnect" href="https://fonts.googleapis.com"/>
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous"/>
                <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
                <style>
/* =============================================
   MODERN INVOICE STYLESHEET
   Čistý, profesionálny dizajn faktúry/dobropisu
   ============================================= */
:root {
    --bg: #f4f1ec;
    --card: #ffffff;
    --fg: #111827;
    --fg-secondary: #374151;
    --muted: #6b7280;
    --accent: #059669;
    --accent-dark: #047857;
    --accent-light: #d1fae5;
    --accent-subtle: #ecfdf5;
    --border: #e5e2dc;
    --border-strong: #d1cdc5;
    --header-bg: #0f172a;
    --header-fg: #f8fafc;
    --row-alt: #f9f8f6;
    --danger: #dc2626;
    --radius: 10px;
    --radius-sm: 6px;
    --shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
    --shadow-md: 0 4px 12px rgba(0,0,0,0.07), 0 2px 4px rgba(0,0,0,0.04);
    --shadow-lg: 0 10px 30px rgba(0,0,0,0.08), 0 4px 8px rgba(0,0,0,0.04);
    --font: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
    --transition: 0.2s ease;
}

*, *::before, *::after {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

html {
    font-size: 14px;
    -webkit-text-size-adjust: 100%;
    -ms-text-size-adjust: 100%;
}

body {
    font-family: var(--font);
    font-size: 1rem;
    line-height: 1.65;
    color: var(--fg);
    background-color: var(--bg);
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}

a {
    color: var(--accent);
    text-decoration: none;
    transition: color var(--transition);
}

a:hover {
    color: var(--accent-dark);
    text-decoration: underline;
}

img {
    max-width: 100%;
    height: auto;
    vertical-align: middle;
}

/* ---------- HLAVNÝ KONTAJNER ---------- */
#document {
    max-width: 900px;
    margin: 32px auto;
    padding: 0;
    background: var(--card);
    border-radius: var(--radius);
    box-shadow: var(--shadow-lg);
    overflow: hidden;
}

/* ---------- HLAVIČKA DOKUMENTU ---------- */
#document > h1 {
    background: var(--header-bg);
    color: var(--header-fg);
    padding: 36px 40px 32px;
    font-size: 2rem;
    font-weight: 800;
    letter-spacing: -0.03em;
    line-height: 1.15;
    margin: 0;
    border-radius: var(--radius) var(--radius) 0 0;
}

#document > h1 small {
    display: block;
    margin-top: 6px;
    font-size: 0.5em;
    font-weight: 400;
    color: rgba(248,250,252,0.55);
    letter-spacing: 0.01em;
}

/* ---------- RIADKOVÝ SYSTÉM (flexbox nahrádza float grid) ---------- */
.row, div.line,
#parties dl, #metadata dl, #delivery dl, #payment dl, #totals dl, #tax dl,
.line, .line .details dl, .line .info dl {
    display: flex;
    flex-wrap: wrap;
    margin-left: 0;
    margin-right: 0;
}

/* Stĺpce – flexbox namiesto float */
.col-xs-1, .col-sm-1, .col-md-1, .col-lg-1 { flex: 0 0 8.333%; max-width: 8.333%; padding: 0 12px; }
.col-xs-2, .col-sm-2, .col-md-2, .col-lg-2 { flex: 0 0 16.666%; max-width: 16.666%; padding: 0 12px; }
.col-xs-3, .col-sm-3, .col-md-3, .col-lg-3 { flex: 0 0 25%; max-width: 25%; padding: 0 12px; }
.col-xs-4, .col-sm-4, .col-md-4, .col-lg-4 { flex: 0 0 33.333%; max-width: 33.333%; padding: 0 12px; }
.col-xs-5, .col-sm-5, .col-md-5, .col-lg-5,
#parties dl dt, #metadata dl dt, #delivery dl dt, #payment dl dt, #totals dl dt, #tax dl dt,
.line .details dl dt, .line .info dl dt { flex: 0 0 41.666%; max-width: 41.666%; padding: 0 12px; }
.col-xs-6, .col-sm-6, .col-md-6, .col-lg-6 { flex: 0 0 50%; max-width: 50%; padding: 0 12px; }
.col-xs-7, .col-sm-7, .col-md-7, .col-lg-7,
#parties dl dd, #metadata dl dd, #delivery dl dd, #payment dd, #totals dl dd, #tax dl dd,
.line .details dl dd, .line .info dl dd { flex: 0 0 58.333%; max-width: 58.333%; padding: 0 12px; }
.col-xs-8, .col-sm-8, .col-md-8, .col-lg-8 { flex: 0 0 66.666%; max-width: 66.666%; padding: 0 12px; }
.col-xs-9, .col-sm-9, .col-md-9, .col-lg-9 { flex: 0 0 75%; max-width: 75%; padding: 0 12px; }
.col-xs-10, .col-sm-10, .col-md-10, .col-lg-10 { flex: 0 0 83.333%; max-width: 83.333%; padding: 0 12px; }
.col-xs-11, .col-sm-11, .col-md-11, .col-lg-11 { flex: 0 0 91.666%; max-width: 91.666%; padding: 0 12px; }
.col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 { flex: 0 0 100%; max-width: 100%; padding: 0 12px; }

/* Špecifické rozloženia z pôvodného CSS */
.line .number { flex: 0 0 8.333%; max-width: 8.333%; padding: 0 12px; text-align: center; }

#metadata dl dt { flex: 0 0 33.333%; max-width: 33.333%; }
#metadata dl dd { flex: 0 0 66.666%; max-width: 66.666%; }

/* ---------- SEKCE A KARTY ---------- */
#parties, #metadata, #totals, #delivery, #attachments, #tax, #payment, #details {
    padding: 0 40px;
}

#parties {
    padding-top: 28px;
}

#metadata {
    padding-top: 28px;
}

.row {
    margin-bottom: 0;
}

.row + .row {
    border-top: 1px solid var(--border);
}

h3 {
    font-size: 0.7rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: var(--accent);
    margin: 0 0 14px;
    padding-bottom: 8px;
    border-bottom: 2px solid var(--accent-light);
}

/* ---------- DEFINIČNÉ ZOZNAMY ---------- */
dl {
    margin: 0;
}

dt {
    font-size: 0.78rem;
    font-weight: 600;
    color: var(--muted);
    text-transform: uppercase;
    letter-spacing: 0.04em;
    padding: 0 12px 2px;
    clear: both;
    margin-bottom: 1px;
}

dd {
    font-size: 0.95rem;
    font-weight: 500;
    color: var(--fg);
    padding: 0 12px 10px;
    margin: 0;
}

#totals dl dd {
    text-align: right;
    margin-bottom: 12px;
}

/* ---------- TABUĽKY ---------- */
.table, #tax table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 16px;
    font-size: 0.9rem;
}

.table > thead > tr > th, #tax table > thead > tr > th,
.table > thead > tr > td, #tax table > thead > tr > td,
.table > tbody > tr > th, #tax table > tbody > tr > th,
.table > tbody > tr > td, #tax table > tbody > tr > td,
.table > tfoot > tr > th, #tax table > tfoot > tr > th,
.table > tfoot > tr > td, #tax table > tfoot > tr > td {
    padding: 10px 12px;
    line-height: 1.5;
    vertical-align: top;
    border-bottom: 1px solid var(--border);
}

.table > thead > tr > th, #tax table > thead > tr > th {
    font-size: 0.7rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: var(--muted);
    background: var(--row-alt);
    border-bottom: 2px solid var(--border-strong);
    vertical-align: bottom;
}

.table > tbody > tr:nth-of-type(odd), #tax table > tbody > tr:nth-of-type(odd) {
    background: transparent;
}

.table > tbody > tr:nth-of-type(even), #tax table > tbody > tr:nth-of-type(even) {
    background: var(--row-alt);
}

.table > tbody > tr:hover, #tax table > tbody > tr:hover {
    background: var(--accent-subtle);
}

/* ---------- ODDEĽOVAČ ---------- */
hr {
    display: none;
    margin: 0;
}

/* ---------- POLOŽKY DOKUMENTU ---------- */
div.line {
    clear: both;
    page-break-inside: avoid;
    margin-bottom: 0;
    padding: 16px 40px;
    border-bottom: 1px solid var(--border);
    transition: background var(--transition);
}

div.line:hover {
    background: var(--accent-subtle);
}

div.linesupport {
    background: var(--row-alt) !important;
    padding: 10px 40px;
    margin: 0;
    border-radius: 0;
}

div.linetotal {
    border-bottom: 1px solid var(--border-strong);
    border-top: 2px solid var(--accent);
    padding: 12px 40px;
    margin: 0;
    background: var(--accent-subtle);
    font-weight: 700;
}

div.total {
    border-bottom: 3px solid var(--accent);
    border-top: 2px solid var(--accent);
    font-weight: 800;
    font-size: 1.1rem;
    padding: 14px 40px;
    margin: 0;
    background: var(--accent-light);
    color: var(--accent-dark);
}

/* ---------- POZNÁMKY ---------- */
p.note {
    font-style: italic;
    color: var(--muted);
    font-size: 0.9rem;
    padding: 0 40px;
    margin: 12px 0;
}

/* ---------- PRÍLOHY ---------- */
#attachments ul {
    padding-left: 0;
    list-style: none;
    margin: 0;
}

#attachments ul li {
    margin-bottom: 8px;
    padding: 8px 12px;
    background: var(--row-alt);
    border-radius: var(--radius-sm);
    font-size: 0.9rem;
    border-left: 3px solid var(--accent);
    transition: background var(--transition);
}

#attachments ul li:hover {
    background: var(--accent-subtle);
}

/* ---------- LOGO ---------- */
#logo {
    max-height: 56px;
    max-width: 220px;
    float: right;
    margin: 12px 16px 0 0;
    object-fit: contain;
}

/* ---------- PATIČKA ---------- */
#footer {
    margin: 24px 40px 16px;
    padding: 16px 20px;
    background: var(--row-alt);
    border-radius: var(--radius-sm);
    font-size: 0.72rem;
    color: var(--muted);
    line-height: 1.7;
}

#footer div {
    margin-bottom: 2px;
}

/* ---------- CHYBOVÉ ZNAČENIE ---------- */
span.mtr {
    color: var(--danger);
    font-weight: 600;
    font-size: 0.85em;
    background: #fef2f2;
    padding: 1px 6px;
    border-radius: 4px;
}

/* ---------- TEXTOVÉ TRIEDY ---------- */
.text-left { text-align: left; }
.text-right, #totals dl dd { text-align: right; }
.text-center, .line .number { text-align: center; }
.text-justify { text-align: justify; }
.text-nowrap { white-space: nowrap; }
.text-muted { color: var(--muted); }
.text-uppercase { text-transform: uppercase; }
.text-lowercase { text-transform: lowercase; }

/* ---------- ZNAČKY ---------- */
.label {
    display: inline-block;
    padding: 2px 10px;
    font-size: 0.72rem;
    font-weight: 700;
    line-height: 1.6;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    border-radius: 100px;
    letter-spacing: 0.02em;
}
.label-default { background: var(--muted); }
.label-primary { background: var(--accent); }
.label-success { background: #059669; }
.label-info { background: #0891b2; }
.label-warning { background: #d97706; }
.label-danger { background: var(--danger); }

/* ---------- POLOŽKA DETAIL ---------- */
#details {
    padding-top: 24px;
    padding-bottom: 8px;
}

#details h3 {
    margin-bottom: 16px;
}

.line .details dl, .line .info dl {
    margin-bottom: 8px;
}

/* ---------- RESPONZÍVNY DIZAJN ---------- */
@media (max-width: 640px) {
    #document {
        margin: 0;
        border-radius: 0;
        box-shadow: none;
    }

    #document > h1 {
        padding: 24px 20px 20px;
        font-size: 1.5rem;
        border-radius: 0;
    }

    #parties, #metadata, #totals, #delivery, #attachments, #tax, #payment, #details {
        padding: 0 20px;
    }

    div.line, div.linesupport, div.linetotal, div.total, p.note {
        padding-left: 20px;
        padding-right: 20px;
    }

    #footer {
        margin: 16px 20px 12px;
    }

    #logo {
        max-height: 36px;
        max-width: 120px;
    }

    /* Na mobiloch stĺpce pod sebou */
    .col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6,
    .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12,
    #parties dl dt, #parties dl dd, #metadata dl dt, #metadata dl dd,
    #delivery dl dt, #delivery dl dd, #payment dl dt, #payment dd,
    #totals dl dt, #totals dl dd, #tax dl dt, #tax dl dd,
    .line .details dl dt, .line .details dl dd,
    .line .info dl dt, .line .info dl dd,
    .line .number {
        flex: 0 0 100%;
        max-width: 100%;
    }

    #totals dl dd {
        text-align: left;
    }

    .table-responsive {
        width: 100%;
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
        margin-bottom: 16px;
    }
}

@media (min-width: 641px) and (max-width: 991px) {
    #metadata dl dt { flex: 0 0 33.333%; max-width: 33.333%; }
    #metadata dl dd { flex: 0 0 66.666%; max-width: 66.666%; }
}

/* ---------- TLAČ ---------- */
@media print {
    @page {
        margin: 12mm;
        size: A4;
    }

    *, *::before, *::after {
        background: transparent !important;
        color: #000 !important;
        box-shadow: none !important;
        text-shadow: none !important;
    }

    html {
        font-size: 10pt;
    }

    body {
        background: #fff !important;
    }

    #document {
        max-width: 100%;
        margin: 0;
        padding: 0;
        border-radius: 0;
        box-shadow: none;
    }

    #document > h1 {
        background: #1a1a1a !important;
        color: #fff !important;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
        border-radius: 0;
        padding: 18pt 0;
        text-align: center;
    }

    #document > h1 small {
        color: rgba(255,255,255,0.6) !important;
    }

    h3 {
        color: #333 !important;
        border-bottom-color: #999 !important;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
    }

    div.linetotal, div.total {
        background: #eee !important;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
        color: #000 !important;
    }

    div.linesupport {
        background: #f5f5f5 !important;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
    }

    .row + .row {
        border-top: 1px solid #ccc;
    }

    div.line {
        border-bottom: 1px solid #ddd;
        padding: 8pt 0;
    }

    div.line:hover {
        background: transparent !important;
    }

    a, a:visited {
        text-decoration: underline;
    }

    a[href]::after {
        content: " (" attr(href) ")";
        font-size: 0.8em;
    }

    a[href^="#"]::after,
    a[href^="javascript:"]::after {
        content: "";
    }

    .table > thead > tr > th {
        border-bottom: 2px solid #333 !important;
        background: #eee !important;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
    }

    .table > tbody > tr:nth-of-type(even) {
        background: #f9f9f9 !important;
    }

    #footer {
        display: none !important;
    }

    #logo {
        max-height: 40pt;
    }

    .label {
        border: 1px solid #000;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
    }

    #attachments ul li {
        border-left: 2px solid #333;
        background: #f5f5f5 !important;
    }

    /* Zabrániť rozdeleniu sekcí */
    .row, div.line, .table, #tax table {
        page-break-inside: avoid;
    }

    thead {
        display: table-header-group;
    }

    tr {
        page-break-inside: avoid;
    }

    h2, h3 {
        page-break-after: avoid;
    }

    p {
        orphans: 3;
        widows: 3;
    }
}
                </style>
            </xsl:when>
            <xsl:otherwise>
                <link rel="stylesheet" href="{$stylesheet_url}"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- ============================================ -->
    <!--  Patička dokumentu                          -->
    <!-- ============================================ -->
    <xsl:template name="doc-footer">
        <div id="footer">
            <div>Document: <xsl:value-of select="namespace-uri()"/>::<xsl:value-of select="local-name()"/></div>
            <div>Customization: <xsl:value-of select="cbc:CustomizationID"/></div>
            <div>Profile: <xsl:value-of select="cbc:ProfileID"/></div>
        </div>
    </xsl:template>

    <!-- ============================================ -->
    <!--  CreditNote – hlavnná šablóna dokumentu      -->
    <!-- ============================================ -->
    <xsl:template match="cn:CreditNote[starts-with(normalize-space(cbc:CustomizationID/text()), 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0')]" mode="document" priority="1000">
        <html lang="{$language}">
            <head>
                <xsl:call-template name="doc-head"/>
                <title>
                    <xsl:call-template name="label">
                        <xsl:with-param name="category" select="'document'"/>
                        <xsl:with-param name="key" select="local-name()"/>
                    </xsl:call-template>
                </title>
            </head>
            <body>
                <div id="document">
                    <h1>
                        <xsl:call-template name="label">
                            <xsl:with-param name="category" select="'document'"/>
                            <xsl:with-param name="key" select="local-name()"/>
                        </xsl:call-template>
                        <small>
                            <xsl:call-template name="codelist">
                                <xsl:with-param name="codelist" select="'uncl1001-cn'"/>
                                <xsl:with-param name="code" select="cbc:CreditNoteTypeCode/text()"/>
                            </xsl:call-template>
                        </small>
                    </h1>
                    <div class="row">
                        <div id="parties" class="col-sm-6 col-md-7">
                            <h3>
                                <xsl:call-template name="label">
                                    <xsl:with-param name="category" select="'party'"/>
                                    <xsl:with-param name="key" select="'Supplier'"/>
                                </xsl:call-template>
                            </h3>
                            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party" mode="party-with-contact"/>
                            <h3>
                                <xsl:call-template name="label">
                                    <xsl:with-param name="category" select="'party'"/>
                                    <xsl:with-param name="key" select="'Customer'"/>
                                </xsl:call-template>
                            </h3>
                            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party" mode="party-with-contact"/>
                        </div>
                        <div id="metadata" class="col-sm-6 col-md-5">
                            <xsl:apply-templates select="cbc:Note" mode="common"/>
                        </div>
                    </div>
                    <div class="row">
                        <div id="totals" class="col-sm-4">
                            <xsl:apply-templates select="cac:LegalMonetaryTotal" mode="total"/>
                        </div>
                        <div id="delivery" class="col-sm-4">

                        </div>
                        <div id="attachments" class="col-sm-4">

                        </div>
                    </div>
                    <div class="row">
                        <div id="tax" class="col-sm-6">
                            <h3>
                                <xsl:call-template name="label">
                                    <xsl:with-param name="category" select="'tax'"/>
                                    <xsl:with-param name="key" select="'Tax'"/>
                                </xsl:call-template>
                            </h3>
                            <xsl:apply-templates select="cac:TaxTotal[cac:TaxSubtotal]" mode="tax"/>
                            <xsl:apply-templates select="cac:TaxRepresentativeParty" mode="party"/>
                        </div>
                        <div id="payment" class="col-sm-6">
                            <h3>
                                <xsl:call-template name="label">
                                    <xsl:with-param name="category" select="'payment'"/>
                                    <xsl:with-param name="key" select="'Payment'"/>
                                </xsl:call-template>
                            </h3>
                            <xsl:apply-templates select="cac:PaymentMeans" mode="payment"/>
                            <xsl:apply-templates select="cac:PayeeParty" mode="party"/>
                            <xsl:apply-templates select="cac:PaymentTerms" mode="payment"/>
                        </div>
                    </div>
                    <hr/>
                    <div id="details">
                        <h3>Details</h3>
                        <xsl:apply-templates select="cac:AllowanceCharge[cbc:ChargeIndicator='true']" mode="line"/>
                        <xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:ChargeTotalAmount" mode="line"/>
                        <xsl:apply-templates select="cac:AllowanceCharge[cbc:ChargeIndicator='false']" mode="line"/>
                        <xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount" mode="line"/>
                        <xsl:apply-templates select="cac:CreditNoteLine" mode="line"/>
                        <xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:LineExtensionAmount" mode="line"/>
                    </div>
                    <xsl:call-template name="doc-footer"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- ============================================ -->
    <!--  Invoice – hlavnná šablóna dokumentu         -->
    <!-- ============================================ -->
    <xsl:template match="in:Invoice[starts-with(normalize-space(cbc:CustomizationID/text()), 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0')]" mode="document" priority="1000">
        <html lang="{$language}">
            <head>
                <xsl:call-template name="doc-head"/>
                <title>
                    <xsl:call-template name="label">
                        <xsl:with-param name="category" select="'document'"/>
                        <xsl:with-param name="key" select="local-name()"/>
                    </xsl:call-template>
                </title>
            </head>
            <body>
                <div id="document">
                    <h1>
                        <xsl:call-template name="label">
                            <xsl:with-param name="category" select="'document'"/>
                            <xsl:with-param name="key" select="local-name()"/>
                        </xsl:call-template>
                        <small>
                            <xsl:call-template name="codelist">
                                <xsl:with-param name="codelist" select="'uncl1001invoice'"/>
                                <xsl:with-param name="code" select="cbc:InvoiceTypeCode/text()"/>
                            </xsl:call-template>
                        </small>
                    </h1>
                    <div class="row">
                        <div id="parties" class="col-sm-6 col-md-7">
                            <h3>
                                <xsl:call-template name="label">
                                    <xsl:with-param name="category" select="'party'"/>
                                    <xsl:with-param name="key" select="'Supplier'"/>
                                </xsl:call-template>
                            </h3>
                            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party" mode="party-with-contact"/>
                            <h3>
                                <xsl:call-template name="label">
                                    <xsl:with-param name="category" select="'party'"/>
                                    <xsl:with-param name="key" select="'Customer'"/>
                                </xsl:call-template>
                            </h3>
                            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party" mode="party-with-contact"/>
                        </div>
                        <div id="metadata" class="col-sm-6 col-md-5">
              
                            <xsl:apply-templates select="cbc:Note" mode="common"/>
                        </div>
                    </div>
                    <div class="row">
                        <div id="totals" class="col-sm-4">
                            <xsl:apply-templates select="cac:LegalMonetaryTotal" mode="total"/>
                        </div>
                        <div id="delivery" class="col-sm-4">
           
                        </div>
                        <div id="attachments" class="col-sm-4">
              
                        </div>
                    </div>
                    <div class="row">
                        <div id="tax" class="col-sm-6">
                            <h3>
                                <xsl:call-template name="label">
                                    <xsl:with-param name="category" select="'tax'"/>
                                    <xsl:with-param name="key" select="'Tax'"/>
                                </xsl:call-template>
                            </h3>
                            <xsl:apply-templates select="cac:TaxTotal[cac:TaxSubtotal]" mode="tax"/>
                            <xsl:apply-templates select="cac:TaxRepresentativeParty" mode="party"/>
                        </div>
                        <div id="payment" class="col-sm-6">
                            <h3>
                                <xsl:call-template name="label">
                                    <xsl:with-param name="category" select="'payment'"/>
                                    <xsl:with-param name="key" select="'Payment'"/>
                                </xsl:call-template>
                            </h3>
                            <xsl:apply-templates select="cac:PaymentMeans" mode="payment"/>
                            <xsl:apply-templates select="cac:PayeeParty" mode="party"/>
                            <xsl:apply-templates select="cac:PaymentTerms" mode="payment"/>
                        </div>
                    </div>
                    <hr/>
                    <div id="details">
                        <h3>Details</h3>
                        <xsl:apply-templates select="cac:AllowanceCharge[cbc:ChargeIndicator='true']" mode="line"/>
                        <xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:ChargeTotalAmount" mode="line"/>
                        <xsl:apply-templates select="cac:AllowanceCharge[cbc:ChargeIndicator='false']" mode="line"/>
                        <xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount" mode="line"/>
                        <xsl:apply-templates select="cac:InvoiceLine" mode="line"/>
                        <xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:LineExtensionAmount" mode="line"/>
                    </div>
                    <xsl:call-template name="doc-footer"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- ============================================ -->
    <!--  Kódové zoznamy (codelists)                  -->
    <!--  POZNÁMKA: Tu pokračuje pôvodný obsah        -->
    <!--  premennej $codelists – všetky cl/c/t        -->
    <!--  prvky zostávajú bez zmeny, lebo            -->
    <!--  nepoužívajú žiadne XSLT 2.0 funkcie.       -->
    <!-- ============================================ -->
    <xsl:variable name="codelists">
        <cl id="iso3166">
            <c id="AD"><t id="en">Andorra</t><t id="no">Andorra</t><t id="sk">Andorra</t><t id="de">Andorra</t></c>
            <c id="AE"><t id="en">United Arab Emirates</t><t id="no">De forente arabiske emirater</t><t id="sk">Spojené arabské emiráty</t><t id="de">Vereinigte Arabische Emirate</t></c>
            <c id="AF"><t id="en">Afghanistan</t><t id="no">Afghanistan</t><t id="sk">Afganistan</t><t id="de">Afghanistan</t></c>
            <c id="AG"><t id="en">Antigua and Barbuda</t><t id="no">Antigua og Barbuda</t><t id="sk">Antigua a Barbuda</t><t id="de">Antigua und Barbuda</t></c>
            <c id="AI"><t id="en">Anguilla</t><t id="no">Anguilla</t><t id="sk">Anguilla</t><t id="de">Anguilla</t></c>
            <c id="AL"><t id="en">Albania</t><t id="no">Albania</t><t id="sk">Albánsko</t><t id="de">Albanien</t></c>
            <c id="AM"><t id="en">Armenia</t><t id="no">Armenia</t><t id="sk">Arménsko</t><t id="de">Armenien</t></c>
            <c id="AO"><t id="en">Angola</t><t id="no">Angola</t><t id="sk">Angola</t><t id="de">Angola</t></c>
            <c id="AQ"><t id="en">Antarctica</t><t id="no">Antarktis</t><t id="sk">Antarktída</t><t id="de">Antarktis</t></c>
            <c id="AR"><t id="en">Argentina</t><t id="no">Argentina</t><t id="sk">Argentína</t><t id="de">Argentinien</t></c>
            <c id="AS"><t id="en">American Samoa</t><t id="no">Amerikansk Samoa</t><t id="sk">Americká Samoa</t><t id="de">Amerikanisch-Samoa</t></c>
            <c id="AT"><t id="en">Austria</t><t id="no">Østerrike</t><t id="sk">Rakúsko</t><t id="de">Österreich</t></c>
            <c id="AU"><t id="en">Australia</t><t id="no">Australia</t><t id="sk">Austrália</t><t id="de">Australien</t></c>
            <c id="AW"><t id="en">Aruba</t><t id="no">Aruba</t><t id="sk">Aruba</t><t id="de">Aruba</t></c>
            <c id="AX"><t id="en">Åland Islands</t><t id="no">Åland</t><t id="sk">Alandy</t><t id="de">Ålandinseln</t></c>
            <c id="AZ"><t id="en">Azerbaijan</t><t id="no">Aserbajdsjan</t><t id="sk">Azerbajdžan</t><t id="de">Aserbaidschan</t></c>
            <c id="BA"><t id="en">Bosnia and Herzegovina</t><t id="no">Bosnia-Hercegovina</t><t id="sk">Bosna a Hercegovina</t><t id="de">Bosnien und Herzegowina</t></c>
            <c id="BB"><t id="en">Barbados</t><t id="no">Barbados</t><t id="sk">Barbados</t><t id="de">Barbados</t></c>
            <c id="BD"><t id="en">Bangladesh</t><t id="no">Bangladesh</t><t id="sk">Bangladéš</t><t id="de">Bangladesch</t></c>
            <c id="BE"><t id="en">Belgium</t><t id="no">Belgia</t><t id="sk">Belgicko</t><t id="de">Belgien</t></c>
            <c id="BF"><t id="en">Burkina Faso</t><t id="no">Burkina Faso</t><t id="sk">Burkina Faso</t><t id="de">Burkina Faso</t></c>
            <c id="BG"><t id="en">Bulgaria</t><t id="no">Bulgaria</t><t id="sk">Bulharsko</t><t id="de">Bulgarien</t></c>
            <c id="BH"><t id="en">Bahrain</t><t id="no">Bahrain</t><t id="sk">Bahrajn</t><t id="de">Bahrain</t></c>
            <c id="BI"><t id="en">Burundi</t><t id="no">Burundi</t><t id="sk">Burundi</t><t id="de">Burundi</t></c>
            <c id="BJ"><t id="en">Benin</t><t id="no">Benin</t><t id="sk">Benin</t><t id="de">Benin</t></c>
            <c id="BL"><t id="en">Saint Barthélemy</t><t id="no">Saint-Barthélemy</t><t id="sk">Saint-Barthélemy</t><t id="de">Saint-Barthélemy</t></c>
            <c id="BM"><t id="en">Bermuda</t><t id="no">Bermuda</t><t id="sk">Bermudy</t><t id="de">Bermuda</t></c>
            <c id="BN"><t id="en">Brunei Darussalam</t><t id="no">Brunei</t><t id="sk">Brunej</t><t id="de">Brunei Darussalam</t></c>
            <c id="BO"><t id="en">Bolivia, Plurinational State of</t><t id="no">Bolivia</t><t id="sk">Bolívia</t><t id="de">Bolivien</t></c>
            <c id="BQ"><t id="en">Bonaire, Sint Eustatius and Saba</t><t id="no">Bonaire, Sint Eustatius og Saba</t><t id="sk">Bonaire, Sint Eustatius a Saba</t><t id="de">Bonaire, Sint Eustatius und Saba</t></c>
            <c id="BR"><t id="en">Brazil</t><t id="no">Brasil</t><t id="sk">Brazília</t><t id="de">Brasilien</t></c>
            <c id="BS"><t id="en">Bahamas</t><t id="no">Bahamas</t><t id="sk">Bahamy</t><t id="de">Bahamas</t></c>
            <c id="BT"><t id="en">Bhutan</t><t id="no">Bhutan</t><t id="sk">Bhután</t><t id="de">Bhutan</t></c>
            <c id="BV"><t id="en">Bouvet Island</t><t id="no">Bouvetøya</t><t id="sk">Bouvetov ostrov</t><t id="de">Bouvetinsel</t></c>
            <c id="BW"><t id="en">Botswana</t><t id="no">Botswana</t><t id="sk">Botswana</t><t id="de">Botswana</t></c>
            <c id="BY"><t id="en">Belarus</t><t id="no">Hviterussland</t><t id="sk">Bielorusko</t><t id="de">Belarus</t></c>
            <c id="BZ"><t id="en">Belize</t><t id="no">Belize</t><t id="sk">Belize</t><t id="de">Belize</t></c>
            <c id="CA"><t id="en">Canada</t><t id="no">Canada</t><t id="sk">Kanada</t><t id="de">Kanada</t></c>
            <c id="CC"><t id="en">Cocos (Keeling) Islands</t><t id="no">Kokosøyene</t><t id="sk">Kokosové ostrovy</t><t id="de">Kokosinseln</t></c>
            <c id="CD"><t id="en">Congo, the Democratic Republic of the</t><t id="no">Den demokratiske republikken Kongo</t><t id="sk">Demokratická republika Kongo</t><t id="de">Demokratische Republik Kongo</t></c>
            <c id="CF"><t id="en">Central African Republic</t><t id="no">Den sentralafrikanske republikk</t><t id="sk">Stredoafrická republika</t><t id="de">Zentralafrikanische Republik</t></c>
            <c id="CG"><t id="en">Congo</t><t id="no">Republikken Kongo</t><t id="sk">Konžská republika</t><t id="de">Republik Kongo</t></c>
            <c id="CH"><t id="en">Switzerland</t><t id="no">Sveits</t><t id="sk">Švajčiarsko</t><t id="de">Schweiz</t></c>
            <c id="CI"><t id="en">Côte d'Ivoire</t><t id="no">Elfenbenskysten</t><t id="sk">Pobrežie Slonoviny</t><t id="de">Elfenbeinküste</t></c>
            <c id="CK"><t id="en">Cook Islands</t><t id="no">Cookøyene</t><t id="sk">Cookove ostrovy</t><t id="de">Cookinseln</t></c>
            <c id="CL"><t id="en">Chile</t><t id="no">Chile</t><t id="sk">Čile</t><t id="de">Chile</t></c>
            <c id="CM"><t id="en">Cameroon</t><t id="no">Kamerun</t><t id="sk">Kamerun</t><t id="de">Kamerun</t></c>
            <!-- Zvyšok krajín ISO 3166 – pridať rovnakou štruktúrou -->
            <!-- ... pokračovanie pôvodných codelists ... -->
        </cl>

        <!-- Ďalšie kódové zoznamy z pôvodného súboru – pridať tu -->
        <!-- <cl id="uncl1001-cn">...</cl> -->
        <!-- <cl id="uncl1001invoice">...</cl> -->
        <!-- atď. -->
    </xsl:variable>

    <!--
        ============================================
        POZNÁMKA K DOPLNENIU:
        ============================================
        V pôvodnom súbore sa nachádzajú ďalšie šablóny,
        ktoré neboli viditeľné v vloženom obsahu.
        Ak používajú XSLT 2.0 konštrukcie, je potrebné
        ich rovnako konvertovať:

        1. Ďalšie xsl:function → xsl:template + xsl:with-param
        2. xsl:for-each-group → vnořený xsl:for-each + xsl:key
        3. xsl:sequence → xsl:copy-of alebo xsl:value-of
        4. XPath 2.0 funkcie (napr. except, intersect, to)
           → alternatívne XPath 1.0 výrazy
        5. Regulárne výrazy (xsl:analyze-string, matches(),
           replace(), tokenize()) → xsl:template s recursívnym
           spracovaním alebo substring/contains kombinácie

        Šablóny, ktoré sa volajú ale nie sú v tomto výpise:
        - xsl:template name="metadata"
        - xsl:template match="..." mode="party-with-contact"
        - xsl:template match="..." mode="party"
        - xsl:template match="..." mode="total"
        - xsl:template name="delivery-block"
        - xsl:template name="attachments-block"
        - xsl:template match="..." mode="tax"
        - xsl:template match="..." mode="payment"
        - xsl:template match="..." mode="line"
        - xsl:template match="..." mode="common"

        Tieto šablóny generujú HTML s triedami, ktoré
        sú už štylizované v novom CSS (dl/dt/dd, .table,
        .line, .linesupport, .linetotal, .total, atď.).
        ============================================
    -->

</xsl:stylesheet>