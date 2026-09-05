<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
 xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
 xmlns:inv="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
 exclude-result-prefixes="cac cbc inv">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:decimal-format name="eu" decimal-separator="," grouping-separator=" "/>
<xsl:template name="money"><xsl:param name="v"/><xsl:param name="c" select="'EUR'"/><xsl:value-of select="format-number(number($v),'0.00','eu')"/><xsl:text> </xsl:text><xsl:value-of select="$c"/></xsl:template>
<xsl:template name="address"><xsl:param name="p"/><dl>
 <dt>Názov</dt><dd><xsl:value-of select="$p/cac:PartyName/cbc:Name"/></dd>
 <dt>IČO</dt><dd><xsl:value-of select="$p/cac:PartyIdentification/cbc:ID"/></dd>
 <dt>IČ DPH</dt><dd><xsl:value-of select="$p/cac:PartyTaxScheme/cbc:CompanyID"/></dd>
 <dt>Adresa</dt><dd><xsl:value-of select="$p/cac:PostalAddress/cbc:StreetName"/><br/><xsl:value-of select="$p/cac:PostalAddress/cbc:PostalZone"/><xsl:text> </xsl:text><xsl:value-of select="$p/cac:PostalAddress/cbc:CityName"/><br/><xsl:value-of select="$p/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/></dd>
 <dt>Endpoint ID</dt><dd><xsl:value-of select="$p/cbc:EndpointID"/> <span class="text-muted">(<xsl:value-of select="$p/cbc:EndpointID/@schemeID"/>)</span></dd>
</dl></xsl:template>
<xsl:template match="/inv:Invoice">
<html lang="sk"><head><meta charset="utf-8"/><meta name="viewport" content="width=device-width, initial-scale=1"/><title>Faktúra <xsl:value-of select="cbc:ID"/></title><style>/* =============================================
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
}</style>
<style>
.invoice-lines{width:100%;border-collapse:collapse} .invoice-lines th,.invoice-lines td{padding:10px 12px;border-bottom:1px solid var(--border);vertical-align:top} .invoice-lines th{background:var(--row-alt);font-size:.7rem;text-transform:uppercase;letter-spacing:.06em;text-align:left} .invoice-lines td.num,.invoice-lines th.num{text-align:right;white-space:nowrap} .warning{margin:20px 40px;padding:14px 16px;border-left:4px solid #d97706;background:#fffbeb;color:#92400e;border-radius:6px} @media print{.warning{display:none}}
</style></head><body><div id="document">
<h1>Faktúra <small>Daňový doklad · typ 380</small></h1>
<div class="row"><div id="parties" class="col-sm-6 col-md-7"><h3>Dodávateľ</h3><xsl:call-template name="address"><xsl:with-param name="p" select="cac:AccountingSupplierParty/cac:Party"/></xsl:call-template><h3>Odberateľ</h3><xsl:call-template name="address"><xsl:with-param name="p" select="cac:AccountingCustomerParty/cac:Party"/></xsl:call-template></div>
<div id="metadata" class="col-sm-6 col-md-5"><h3>Údaje faktúry</h3><dl>
<dt>Číslo faktúry</dt><dd><strong><xsl:value-of select="cbc:ID"/></strong></dd>
<dt>Dátum vystavenia</dt><dd><xsl:value-of select="cbc:IssueDate"/></dd>
<dt>Dátum splatnosti</dt><dd><xsl:value-of select="cbc:DueDate"/></dd>
<dt>Mena</dt><dd><xsl:value-of select="cbc:DocumentCurrencyCode"/></dd>
<dt>Variabilný symbol</dt><dd><xsl:value-of select="cac:PaymentMeans/cbc:PaymentID"/></dd>
<dt>Profil</dt><dd><xsl:value-of select="cbc:ProfileID"/></dd>
</dl></div></div>
<div class="row"><div id="totals" class="col-sm-4"><h3>Sumy</h3><dl>
<dt>Základ dane</dt><dd><xsl:call-template name="money"><xsl:with-param name="v" select="cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount"/><xsl:with-param name="c" select="cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount/@currencyID"/></xsl:call-template></dd>
<dt>Suma s DPH</dt><dd><xsl:call-template name="money"><xsl:with-param name="v" select="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/><xsl:with-param name="c" select="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount/@currencyID"/></xsl:call-template></dd>
<dt>Na úhradu</dt><dd><strong><xsl:call-template name="money"><xsl:with-param name="v" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/><xsl:with-param name="c" select="cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/></xsl:call-template></strong></dd>
</dl></div>
<div id="delivery" class="col-sm-4"><h3>Bankové spojenie</h3><dl><dt>IBAN</dt><dd><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"/></dd><dt>SWIFT/BIC</dt><dd><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID"/></dd><dt>Majiteľ účtu</dt><dd><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:Name"/></dd></dl></div>
<div id="attachments" class="col-sm-4"><h3>PEPPOL</h3><dl><dt>Customization ID</dt><dd style="word-break:break-word"><xsl:value-of select="cbc:CustomizationID"/></dd><dt>Typ dokladu</dt><dd><xsl:value-of select="cbc:InvoiceTypeCode"/></dd></dl></div></div>
<div class="row"><div id="tax" class="col-sm-12"><h3>Rekapitulácia DPH</h3><table><thead><tr><th>Kategória</th><th class="text-right">Sadzba</th><th class="text-right">Základ</th><th class="text-right">DPH podľa XML</th></tr></thead><tbody>
<xsl:for-each select="cac:TaxTotal/cac:TaxSubtotal"><tr><td><xsl:value-of select="cac:TaxCategory/cbc:ID"/></td><td class="text-right"><xsl:value-of select="format-number(number(cac:TaxCategory/cbc:Percent),'0.##','eu')"/> %</td><td class="text-right"><xsl:call-template name="money"><xsl:with-param name="v" select="cbc:TaxableAmount"/><xsl:with-param name="c" select="cbc:TaxableAmount/@currencyID"/></xsl:call-template></td><td class="text-right"><xsl:call-template name="money"><xsl:with-param name="v" select="cbc:TaxAmount"/><xsl:with-param name="c" select="cbc:TaxAmount/@currencyID"/></xsl:call-template></td></tr></xsl:for-each>
</tbody></table></div></div>
<div id="details"><h3>Položky</h3><div class="table-responsive"><table class="invoice-lines"><thead><tr><th>#</th><th>Názov</th><th class="num">Množstvo</th><th>MJ</th><th class="num">Jedn. cena</th><th class="num">Sadzba DPH</th><th class="num">Základ</th></tr></thead><tbody>
<xsl:for-each select="cac:InvoiceLine"><tr><td><xsl:value-of select="cbc:ID"/></td><td><strong><xsl:value-of select="cac:Item/cbc:Name"/></strong></td><td class="num"><xsl:value-of select="format-number(number(cbc:InvoicedQuantity),'0.###','eu')"/></td><td><xsl:value-of select="cbc:InvoicedQuantity/@unitCode"/></td><td class="num"><xsl:call-template name="money"><xsl:with-param name="v" select="cac:Price/cbc:PriceAmount"/><xsl:with-param name="c" select="cac:Price/cbc:PriceAmount/@currencyID"/></xsl:call-template></td><td class="num"><xsl:value-of select="format-number(number(cac:Item/cac:ClassifiedTaxCategory/cbc:Percent),'0.##','eu')"/> %</td><td class="num"><xsl:call-template name="money"><xsl:with-param name="v" select="cbc:LineExtensionAmount"/><xsl:with-param name="c" select="cbc:LineExtensionAmount/@currencyID"/></xsl:call-template></td></tr></xsl:for-each>
</tbody></table></div></div>
<div class="total"><div class="row"><div class="col-sm-6">Celkom na úhradu</div><div class="col-sm-6 text-right"><xsl:call-template name="money"><xsl:with-param name="v" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/><xsl:with-param name="c" select="cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/></xsl:call-template></div></div></div>
<div id="footer"><div>Dokument: UBL Invoice 2.x / Peppol BIS Billing 3.0</div><div>Vygenerované z XML pomocou opravenej XSLT 1.0 šablóny.</div></div>
</div></body></html>
</xsl:template></xsl:stylesheet>