<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
                xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
                xmlns:cn="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
                xmlns:in="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
                xmlns:u="utils"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl"
                version="1.0"
                exclude-result-prefixes="cac cbc u cn in exsl">

	<xsl:output method="html" encoding="UTF-8" indent="no"/>

	<xsl:param name="stylesheet_url" select="'NONE'"/>
	<xsl:param name="language" select="'sk'"/>
	<xsl:param name="mode" select="'document'"/>
	<xsl:param name="download_attachment" select="'false'"/>

	<!-- ============================================================ -->
	<!-- CODELISTS -->
	<!-- ============================================================ -->
	<xsl:variable name="codelists">
		<cl id="iso3166">
			<c id="SK"><t id="sk">Slovensko</t><t id="en">Slovakia</t></c>
			<c id="CZ"><t id="sk">Česko</t><t id="en">Czechia</t></c>
			<c id="AT"><t id="sk">Rakúsko</t><t id="en">Austria</t></c>
			<c id="DE"><t id="sk">Nemecko</t><t id="en">Germany</t></c>
			<c id="PL"><t id="sk">Poľsko</t><t id="en">Poland</t></c>
			<c id="HU"><t id="sk">Maďarsko</t><t id="en">Hungary</t></c>
			<c id="GB"><t id="sk">Veľká Británia</t><t id="en">United Kingdom</t></c>
			<c id="US"><t id="sk">USA</t><t id="en">United States</t></c>
		</cl>
		<cl id="uncl1001invoice">
			<c id="380"><t id="sk">Faktúra (Daňový doklad)</t><t id="en">Commercial invoice</t></c>
			<c id="393"><t id="sk">Fakturovaná faktúra</t><t id="en">Factored invoice</t></c>
			<c id="82"><t id="sk">Faktúra za merané služby</t><t id="en">Metered services invoice</t></c>
			<c id="80"><t id="sk">Ťarchopis za tovar alebo služby</t><t id="en">Debit note related to goods or services</t></c>
			<c id="84"><t id="sk">Ťarchopis za finančné úpravy</t><t id="en">Debit note related to financial adjustments</t></c>
			<c id="395"><t id="sk">Konsignačná faktúra</t><t id="en">Consignment invoice</t></c>
			<c id="575"><t id="sk">Faktúra špeditéra</t><t id="en">Forwarder's invoice</t></c>
			<c id="780"><t id="sk">Faktúra za prepravu</t><t id="en">Freight invoice</t></c>
		</cl>
		<cl id="uncl1001-cn">
			<c id="81"><t id="sk">Dobropis za tovar alebo služby</t><t id="en">Credit note related to goods or services</t></c>
			<c id="83"><t id="sk">Dobropis za finančné úpravy</t><t id="en">Credit note related to financial adjustments</t></c>
			<c id="381"><t id="sk">Dobropis</t><t id="en">Credit note</t></c>
			<c id="396"><t id="sk">Fakturovaný dobropis</t><t id="en">Factored credit note</t></c>
			<c id="532"><t id="sk">Dobropis špeditéra</t><t id="en">Forwarder's credit note</t></c>
		</cl>
	</xsl:variable>

	<!-- ============================================================ -->
	<!-- LABELS (Slovak) -->
	<!-- ============================================================ -->
	<xsl:variable name="labels">
		<g id="document">
			<f id="Invoice"><t id="sk">Faktúra č.</t><t id="en">Invoice No.</t></f>
			<f id="CreditNote"><t id="sk">Dobropis č.</t><t id="en">Credit Note No.</t></f>
			<f id="TaxDocument"><t id="sk">(Daňový doklad)</t><t id="en">(Tax document)</t></f>
		</g>
		<g id="party">
			<f id="Supplier"><t id="sk">Dodávateľ:</t><t id="en">Supplier:</t></f>
			<f id="Customer"><t id="sk">Odberateľ:</t><t id="en">Customer:</t></f>
			<f id="ICO"><t id="sk">IČO:</t><t id="en">Company ID:</t></f>
			<f id="DIC"><t id="sk">DIČ:</t><t id="en">Tax ID:</t></f>
			<f id="ICDPH"><t id="sk">IČ DPH:</t><t id="en">VAT ID:</t></f>
			<f id="EndpointID"><t id="sk">Technická adresa:</t><t id="en">Technical Address:</t></f>
			<f id="PartyIdentification"><t id="sk">Identifikácia:</t><t id="en">Identification:</t></f>
		</g>
		<g id="metadata">
			<f id="VariableSymbol"><t id="sk">Variabilný symbol:</t><t id="en">Variable symbol:</t></f>
			<f id="ConstantSymbol"><t id="sk">Konštantný symbol:</t><t id="en">Constant symbol:</t></f>
			<f id="OrderReference"><t id="sk">Číslo objednávky:</t><t id="en">Order reference:</t></f>
			<f id="DeliveryNote"><t id="sk">Dodací list č.:</t><t id="en">Delivery note No.:</t></f>
			<f id="IssueDate"><t id="sk">Dátum vystavenia:</t><t id="en">Issue date:</t></f>
			<f id="DueDate"><t id="sk">Dátum splatnosti:</t><t id="en">Due date:</t></f>
			<f id="DeliveryDate"><t id="sk">Dátum dodania:</t><t id="en">Delivery date:</t></f>
			<f id="TaxPointDate"><t id="sk">Dátum DPH:</t><t id="en">Tax point date:</t></f>
			<f id="PaymentMethod"><t id="sk">Forma úhrady:</t><t id="en">Payment method:</t></f>
			<f id="Currency"><t id="sk">Mena:</t><t id="en">Currency:</t></f>
			<f id="BuyerReference"><t id="sk">Referencia odberateľa:</t><t id="en">Buyer reference:</t></f>
		</g>
		<g id="payment">
			<f id="Bank"><t id="sk">Peňažný ústav:</t><t id="en">Bank:</t></f>
			<f id="Branch"><t id="sk">Pobočka:</t><t id="en">Branch:</t></f>
			<f id="AccountNumber"><t id="sk">Číslo účtu:</t><t id="en">Account number:</t></f>
			<f id="IBAN"><t id="sk">IBAN:</t><t id="en">IBAN:</t></f>
			<f id="SWIFT"><t id="sk">SWIFT:</t><t id="en">SWIFT:</t></f>
			<f id="PaymentID"><t id="sk">Variabilný symbol:</t><t id="en">Payment ID:</t></f>
		</g>
		<g id="lines">
			<f id="Title"><t id="sk">Fakturujeme Vám za:</t><t id="en">We invoice you for:</t></f>
			<f id="Number"><t id="sk">Číslo</t><t id="en">No.</t></f>
			<f id="Name"><t id="sk">Názov</t><t id="en">Name</t></f>
			<f id="Quantity"><t id="sk">Množstvo</t><t id="en">Quantity</t></f>
			<f id="Unit"><t id="sk">MJ</t><t id="en">Unit</t></f>
			<f id="Discount"><t id="sk">Zľava</t><t id="en">Discount</t></f>
			<f id="PricePerUnit"><t id="sk">Cena za MJ</t><t id="en">Price per unit</t></f>
			<f id="TotalExVAT"><t id="sk">Celkom bez DPH</t><t id="en">Total ex. VAT</t></f>
			<f id="VATRate"><t id="sk">DPH %</t><t id="en">VAT %</t></f>
			<f id="PricePerUnitVAT"><t id="sk">Cena za MJ s DPH</t><t id="en">Price per unit incl. VAT</t></f>
			<f id="TotalVAT"><t id="sk">Celkom s DPH</t><t id="en">Total incl. VAT</t></f>
		</g>
		<g id="tax">
			<f id="RecapTitle"><t id="sk">Rekapitulácia DPH v</t><t id="en">VAT recapitulation in</t></f>
			<f id="Rate"><t id="sk">Sadzba DPH</t><t id="en">VAT rate</t></f>
			<f id="Base"><t id="sk">Základ DPH</t><t id="en">VAT base</t></f>
			<f id="VATAmount"><t id="sk">DPH</t><t id="en">VAT</t></f>
			<f id="StandardRate"><t id="sk">Základná sadzba DPH</t><t id="en">Standard VAT rate</t></f>
			<f id="ReducedRate"><t id="sk">Znížená sadzba DPH</t><t id="en">Reduced VAT rate</t></f>
		</g>
		<g id="totals">
			<f id="Total"><t id="sk">Celkom:</t><t id="en">Total:</t></f>
			<f id="Advance"><t id="sk">Záloha:</t><t id="en">Advance:</t></f>
			<f id="ToPay"><t id="sk">K úhrade:</t><t id="en">To pay:</t></f>
			<f id="TaxExclusive"><t id="sk">Základ dane:</t><t id="en">Tax exclusive:</t></f>
			<f id="TaxInclusive"><t id="sk">Celkom s DPH:</t><t id="en">Tax inclusive:</t></f>
			<f id="Rounding"><t id="sk">Zaokrúhlenie:</t><t id="en">Rounding:</t></f>
			<f id="Prepaid"><t id="sk">Predplatené:</t><t id="en">Prepaid:</t></f>
		</g>
		<g id="footer">
			<f id="Phone"><t id="sk">Tel. číslo:</t><t id="en">Phone:</t></f>
			<f id="Web"><t id="sk">Web:</t><t id="en">Web:</t></f>
			<f id="IssuedBy"><t id="sk">Vystavil:</t><t id="en">Issued by:</t></f>
			<f id="ReceivedBy"><t id="sk">Prevzal:</t><t id="en">Received by:</t></f>
			<f id="Signature"><t id="sk">Podpis a pečiatka</t><t id="en">Signature and stamp</t></f>
			<f id="Note"><t id="sk">Poznámka:</t><t id="en">Note:</t></f>
		</g>
	</xsl:variable>

	<!-- ============================================================ -->
	<!-- NAMED TEMPLATES -->
	<!-- ============================================================ -->
	<xsl:template name="u-codelist">
		<xsl:param name="codelist"/>
		<xsl:param name="code"/>
		<xsl:variable name="cl-node" select="exsl:node-set($codelists)"/>
		<xsl:choose>
			<xsl:when test="$cl-node/cl[@id=$codelist]/c[@id=$code]/t[@id=$language]">
				<xsl:value-of select="$cl-node/cl[@id=$codelist]/c[@id=$code]/t[@id=$language]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="u-label">
		<xsl:param name="part"/>
		<xsl:param name="value"/>
		<xsl:variable name="lb-node" select="exsl:node-set($labels)"/>
		<xsl:choose>
			<xsl:when test="$lb-node/g[@id=$part]/f[@id=$value]/t[@id=$language]">
				<xsl:value-of select="$lb-node/g[@id=$part]/f[@id=$value]/t[@id=$language]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Format number SK style -->
  <xsl:template name="format-amount">
    <xsl:param name="value"/>
    <xsl:param name="currency" select="''"/>
    <xsl:variable name="formatted" select="format-number($value, '#,##0.00')"/>
    <xsl:value-of select="translate(translate($formatted, ',', ' '), '.', ',')"/>
    <xsl:if test="$currency != ''">
      <xsl:text> </xsl:text>
      <xsl:value-of select="$currency"/>
    </xsl:if>
  </xsl:template>

	<!-- Format date SK style -->
	<xsl:template name="format-date">
		<xsl:param name="date"/>
		<xsl:if test="$date != ''">
			<xsl:value-of select="substring($date, 9, 2)"/>
			<xsl:text>.</xsl:text>
			<xsl:value-of select="substring($date, 6, 2)"/>
			<xsl:text>.</xsl:text>
			<xsl:value-of select="substring($date, 1, 4)"/>
		</xsl:if>
	</xsl:template>

	<!-- ============================================================ -->
	<!-- ROOT -->
	<!-- ============================================================ -->
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="$mode = 'document'">
				<xsl:apply-templates select="*" mode="document"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="*" mode="document"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ============================================================ -->
	<!-- INVOICE TEMPLATE -->
	<!-- ============================================================ -->
	<xsl:template match="in:Invoice" mode="document" priority="1000">
		<html lang="sk">
			<head>
				<meta charset="utf-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<title>
					<xsl:call-template name="u-label">
						<xsl:with-param name="part" select="'document'"/>
						<xsl:with-param name="value" select="'Invoice'"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:value-of select="cbc:ID"/>
				</title>
				<style>
/* ===== OBERON-STYLE INVOICE CSS ===== */
* { margin: 0; padding: 0; box-sizing: border-box; }

@page {
  size: A4 portrait;
  margin: 15mm 12mm 15mm 12mm;
}

body {
  font-family: 'Arial', 'Helvetica', sans-serif;
  font-size: 11px;
  line-height: 1.4;
  color: #000;
  background: #fff;
}

.invoice-container {
  width: 190mm;
  margin: 0 auto;
  padding: 5mm;
}

/* Header */
.invoice-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 12px;
  padding-bottom: 8px;
  border-bottom: 2px solid #000;
}

.invoice-title {
  font-size: 18px;
  font-weight: bold;
}

.invoice-subtitle {
  font-size: 11px;
  font-weight: normal;
  color: #333;
}

.invoice-number {
  text-align: right;
  font-size: 14px;
  font-weight: bold;
}

/* Main info table */
.info-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 10px;
}

.info-table td {
  vertical-align: top;
  padding: 4px 6px;
  font-size: 11px;
}

.info-table .label {
  font-weight: bold;
  white-space: nowrap;
  width: 130px;
}

.info-table .value {
  font-weight: normal;
}

/* Party boxes */
.party-section {
  display: flex;
  gap: 10px;
  margin-bottom: 10px;
}

.party-box {
  flex: 1;
  border: 1px solid #000;
  padding: 8px;
}

.party-box-title {
  font-weight: bold;
  font-size: 11px;
  margin-bottom: 6px;
  text-transform: uppercase;
  border-bottom: 1px solid #000;
  padding-bottom: 3px;
}

.party-box .company-name {
  font-weight: bold;
  font-size: 12px;
  margin-bottom: 4px;
}

.party-box .address-line {
  margin-bottom: 1px;
}

.party-box .id-line {
  margin-top: 4px;
}

.party-box .id-line span {
  display: inline-block;
  width: 50px;
  font-weight: bold;
}

/* Payment info */
.payment-section {
  border: 1px solid #000;
  padding: 8px;
  margin-bottom: 10px;
}

.payment-table {
  width: 100%;
  border-collapse: collapse;
}

.payment-table td {
  padding: 2px 4px;
  font-size: 11px;
}

.payment-table .label {
  font-weight: bold;
  width: 140px;
  white-space: nowrap;
}

/* Lines table */
.lines-title {
  font-weight: bold;
  font-size: 12px;
  margin: 12px 0 6px 0;
  padding: 4px 0;
  border-bottom: 1px solid #000;
}

.lines-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 10px;
  font-size: 10px;
}

.lines-table th {
  background: #e8e8e8;
  border: 1px solid #000;
  padding: 4px 3px;
  font-size: 9px;
  font-weight: bold;
  text-align: center;
  vertical-align: middle;
}

.lines-table td {
  border: 1px solid #000;
  padding: 4px 3px;
  vertical-align: top;
}

.lines-table .num { text-align: center; }
.lines-table .right { text-align: right; }
.lines-table .left { text-align: left; }

.lines-table .item-name {
  font-weight: bold;
}

.lines-table .item-note {
  font-size: 9px;
  color: #333;
  margin-top: 2px;
}

/* Tax recap */
.tax-section {
  margin-bottom: 10px;
}

.tax-title {
  font-weight: bold;
  font-size: 11px;
  margin-bottom: 4px;
}

.tax-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 10px;
}

.tax-table th {
  background: #e8e8e8;
  border: 1px solid #000;
  padding: 4px 6px;
  font-weight: bold;
  text-align: center;
}

.tax-table td {
  border: 1px solid #000;
  padding: 4px 6px;
}

.tax-table .right { text-align: right; }
.tax-table .left { text-align: left; }

/* Totals */
.totals-section {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 12px;
}

.totals-box {
  width: 280px;
  border: 2px solid #000;
  padding: 8px;
}

.totals-table {
  width: 100%;
  border-collapse: collapse;
}

.totals-table td {
  padding: 3px 4px;
  font-size: 11px;
}

.totals-table .label {
  font-weight: bold;
}

.totals-table .value {
  text-align: right;
  font-weight: bold;
}

.totals-table .total-row td {
  border-top: 1px solid #000;
  font-size: 13px;
  font-weight: bold;
  padding-top: 6px;
}

/* Notes */
.notes-section {
  margin: 10px 0;
  padding: 8px;
  border: 1px solid #999;
  background: #f9f9f9;
  font-size: 10px;
}

.notes-section .note-title {
  font-weight: bold;
  margin-bottom: 4px;
}

/* Footer */
.invoice-footer {
  margin-top: 20px;
  padding-top: 10px;
  border-top: 1px solid #000;
  display: flex;
  justify-content: space-between;
  font-size: 10px;
}

.footer-left { }
.footer-right { text-align: right; }

.signature-area {
  margin-top: 30px;
  display: flex;
  justify-content: space-between;
}

.signature-box {
  width: 200px;
  text-align: center;
}

.signature-line {
  border-top: 1px solid #000;
  margin-top: 40px;
  padding-top: 4px;
  font-size: 9px;
}

/* Print */
@media print {
  body { font-size: 10px; }
  .invoice-container { width: 100%; padding: 0; }
  .no-print { display: none; }
}

@media screen {
  body { background: #f0f0f0; padding: 20px; }
  .invoice-container {
    background: #fff;
    box-shadow: 0 2px 10px rgba(0,0,0,0.15);
    padding: 15mm;
  }
}
				</style>
			</head>
			<body>
				<div class="invoice-container">

					<!-- HEADER -->
					<div class="invoice-header">
						<div>
							<div class="invoice-title">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'document'"/>
									<xsl:with-param name="value" select="'Invoice'"/>
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:value-of select="cbc:ID"/>
							</div>
							<div class="invoice-subtitle">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'document'"/>
									<xsl:with-param name="value" select="'TaxDocument'"/>
								</xsl:call-template>
							</div>
						</div>
					</div>

					<!-- SUPPLIER & CUSTOMER -->
					<div class="party-section">
						<div class="party-box">
							<div class="party-box-title">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'party'"/>
									<xsl:with-param name="value" select="'Supplier'"/>
								</xsl:call-template>
							</div>
							<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party" mode="party-box"/>
						</div>
						<div class="party-box">
							<div class="party-box-title">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'party'"/>
									<xsl:with-param name="value" select="'Customer'"/>
								</xsl:call-template>
							</div>
							<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party" mode="party-box"/>
						</div>
					</div>

					<!-- PAYMENT & METADATA INFO -->
					<div class="payment-section">
						<table class="payment-table">
							<tr>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'payment'"/>
										<xsl:with-param name="value" select="'PaymentID'"/>
									</xsl:call-template>
								</td>
								<td class="value"><xsl:value-of select="cac:PaymentMeans/cbc:PaymentID"/></td>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'metadata'"/>
										<xsl:with-param name="value" select="'IssueDate'"/>
									</xsl:call-template>
								</td>
								<td class="value">
									<xsl:call-template name="format-date">
										<xsl:with-param name="date" select="cbc:IssueDate"/>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'metadata'"/>
										<xsl:with-param name="value" select="'ConstantSymbol'"/>
									</xsl:call-template>
								</td>
								<td class="value">0308</td>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'metadata'"/>
										<xsl:with-param name="value" select="'DueDate'"/>
									</xsl:call-template>
								</td>
								<td class="value">
									<xsl:call-template name="format-date">
										<xsl:with-param name="date" select="cbc:DueDate"/>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'metadata'"/>
										<xsl:with-param name="value" select="'DeliveryDate'"/>
									</xsl:call-template>
								</td>
								<td class="value">
									<xsl:choose>
										<xsl:when test="cac:Delivery/cbc:ActualDeliveryDate">
											<xsl:call-template name="format-date">
												<xsl:with-param name="date" select="cac:Delivery/cbc:ActualDeliveryDate"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="format-date">
												<xsl:with-param name="date" select="cbc:IssueDate"/>
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'metadata'"/>
										<xsl:with-param name="value" select="'PaymentMethod'"/>
									</xsl:call-template>
								</td>
								<td class="value">Prevodný príkaz</td>
							</tr>
							<tr>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'payment'"/>
										<xsl:with-param name="value" select="'IBAN'"/>
									</xsl:call-template>
								</td>
								<td class="value"><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"/></td>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'payment'"/>
										<xsl:with-param name="value" select="'SWIFT'"/>
									</xsl:call-template>
								</td>
								<td class="value"><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID"/></td>
							</tr>
							<tr>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'payment'"/>
										<xsl:with-param name="value" select="'Bank'"/>
									</xsl:call-template>
								</td>
								<td class="value"><xsl:value-of select="cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:Name"/></td>
								<td class="label">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'metadata'"/>
										<xsl:with-param name="value" select="'Currency'"/>
									</xsl:call-template>
								</td>
								<td class="value"><xsl:value-of select="cbc:DocumentCurrencyCode"/></td>
							</tr>
						</table>
					</div>

					<!-- INVOICE LINES -->
					<div class="lines-title">
						<xsl:call-template name="u-label">
							<xsl:with-param name="part" select="'lines'"/>
							<xsl:with-param name="value" select="'Title'"/>
						</xsl:call-template>
					</div>

					<table class="lines-table">
						<thead>
							<tr>
								<th style="width:30px;">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'lines'"/>
										<xsl:with-param name="value" select="'Number'"/>
									</xsl:call-template>
								</th>
								<th style="width:auto;">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'lines'"/>
										<xsl:with-param name="value" select="'Name'"/>
									</xsl:call-template>
								</th>
								<th style="width:55px;">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'lines'"/>
										<xsl:with-param name="value" select="'Quantity'"/>
									</xsl:call-template>
								</th>
								<th style="width:35px;">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'lines'"/>
										<xsl:with-param name="value" select="'Unit'"/>
									</xsl:call-template>
								</th>
								<th style="width:70px;">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'lines'"/>
										<xsl:with-param name="value" select="'PricePerUnit'"/>
									</xsl:call-template>
								</th>
								<th style="width:75px;">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'lines'"/>
										<xsl:with-param name="value" select="'TotalExVAT'"/>
									</xsl:call-template>
								</th>
								<th style="width:40px;">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'lines'"/>
										<xsl:with-param name="value" select="'VATRate'"/>
									</xsl:call-template>
								</th>
								<th style="width:75px;">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'lines'"/>
										<xsl:with-param name="value" select="'PricePerUnitVAT'"/>
									</xsl:call-template>
								</th>
								<th style="width:75px;">
									<xsl:call-template name="u-label">
										<xsl:with-param name="part" select="'lines'"/>
										<xsl:with-param name="value" select="'TotalVAT'"/>
									</xsl:call-template>
								</th>
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="cac:InvoiceLine" mode="line-row"/>
						</tbody>
					</table>

					<!-- TAX RECAPITULATION -->
					<div class="tax-section">
						<div class="tax-title">
							<xsl:call-template name="u-label">
								<xsl:with-param name="part" select="'tax'"/>
								<xsl:with-param name="value" select="'RecapTitle'"/>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:value-of select="cbc:DocumentCurrencyCode"/>
						</div>
						<table class="tax-table">
							<thead>
								<tr>
									<th class="left" style="width:40%;">
										<xsl:call-template name="u-label">
											<xsl:with-param name="part" select="'tax'"/>
											<xsl:with-param name="value" select="'Rate'"/>
										</xsl:call-template>
									</th>
									<th class="right" style="width:30%;">
										<xsl:call-template name="u-label">
											<xsl:with-param name="part" select="'tax'"/>
											<xsl:with-param name="value" select="'Base'"/>
										</xsl:call-template>
									</th>
									<th class="right" style="width:30%;">
										<xsl:call-template name="u-label">
											<xsl:with-param name="part" select="'tax'"/>
											<xsl:with-param name="value" select="'VATAmount'"/>
										</xsl:call-template>
									</th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="cac:TaxTotal/cac:TaxSubtotal" mode="tax-row"/>
							</tbody>
						</table>
					</div>

					<!-- TOTALS -->
					<div class="totals-section">
						<div class="totals-box">
							<table class="totals-table">
								<tr>
									<td class="label">
										<xsl:call-template name="u-label">
											<xsl:with-param name="part" select="'totals'"/>
											<xsl:with-param name="value" select="'Total'"/>
										</xsl:call-template>
									</td>
									<td class="value">
										<xsl:call-template name="format-amount">
											<xsl:with-param name="value" select="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/>
											<xsl:with-param name="currency" select="cbc:DocumentCurrencyCode"/>
										</xsl:call-template>
									</td>
								</tr>
								<tr>
									<td class="label">
										<xsl:call-template name="u-label">
											<xsl:with-param name="part" select="'totals'"/>
											<xsl:with-param name="value" select="'Advance'"/>
										</xsl:call-template>
									</td>
									<td class="value">
										<xsl:call-template name="format-amount">
											<xsl:with-param name="value" select="cac:LegalMonetaryTotal/cbc:PrepaidAmount"/>
											<xsl:with-param name="currency" select="cbc:DocumentCurrencyCode"/>
										</xsl:call-template>
									</td>
								</tr>
								<tr class="total-row">
									<td class="label">
										<xsl:call-template name="u-label">
											<xsl:with-param name="part" select="'totals'"/>
											<xsl:with-param name="value" select="'ToPay'"/>
										</xsl:call-template>
									</td>
									<td class="value">
										<xsl:call-template name="format-amount">
											<xsl:with-param name="value" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/>
											<xsl:with-param name="currency" select="cbc:DocumentCurrencyCode"/>
										</xsl:call-template>
									</td>
								</tr>
							</table>
						</div>
					</div>

					<!-- NOTES -->
					<xsl:if test="cbc:Note">
						<div class="notes-section">
							<div class="note-title">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'footer'"/>
									<xsl:with-param name="value" select="'Note'"/>
								</xsl:call-template>
							</div>
							<xsl:value-of select="cbc:Note"/>
						</div>
					</xsl:if>

					<!-- FOOTER -->
					<div class="invoice-footer">
						<div class="footer-left">
							<div>
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'footer'"/>
									<xsl:with-param name="value" select="'IssuedBy'"/>
								</xsl:call-template>
								<xsl:text> _________________________</xsl:text>
							</div>
						</div>
						<div class="footer-right">
							<div>
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'footer'"/>
									<xsl:with-param name="value" select="'ReceivedBy'"/>
								</xsl:call-template>
								<xsl:text> _________________________</xsl:text>
							</div>
						</div>
					</div>

					<div class="signature-area">
						<div class="signature-box">
							<div class="signature-line">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'footer'"/>
									<xsl:with-param name="value" select="'Signature'"/>
								</xsl:call-template>
							</div>
						</div>
						<div class="signature-box">
							<div class="signature-line">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'footer'"/>
									<xsl:with-param name="value" select="'Signature'"/>
								</xsl:call-template>
							</div>
						</div>
					</div>

				</div>
			</body>
		</html>
	</xsl:template>

	<!-- ============================================================ -->
	<!-- CREDIT NOTE TEMPLATE -->
	<!-- ============================================================ -->
	<xsl:template match="cn:CreditNote" mode="document" priority="1000">
		<html lang="sk">
			<head>
				<meta charset="utf-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<title>
					<xsl:call-template name="u-label">
						<xsl:with-param name="part" select="'document'"/>
						<xsl:with-param name="value" select="'CreditNote'"/>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:value-of select="cbc:ID"/>
				</title>
			</head>
			<body>
				<div class="invoice-container">
					<div class="invoice-header">
						<div>
							<div class="invoice-title">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'document'"/>
									<xsl:with-param name="value" select="'CreditNote'"/>
								</xsl:call-template>
								<xsl:text> </xsl:text>
								<xsl:value-of select="cbc:ID"/>
							</div>
						</div>
					</div>
					<!-- Similar structure as Invoice -->
					<div class="party-section">
						<div class="party-box">
							<div class="party-box-title">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'party'"/>
									<xsl:with-param name="value" select="'Supplier'"/>
								</xsl:call-template>
							</div>
							<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party" mode="party-box"/>
						</div>
						<div class="party-box">
							<div class="party-box-title">
								<xsl:call-template name="u-label">
									<xsl:with-param name="part" select="'party'"/>
									<xsl:with-param name="value" select="'Customer'"/>
								</xsl:call-template>
							</div>
							<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party" mode="party-box"/>
						</div>
					</div>
					<!-- Lines -->
					<div class="lines-title">
						<xsl:call-template name="u-label">
							<xsl:with-param name="part" select="'lines'"/>
							<xsl:with-param name="value" select="'Title'"/>
						</xsl:call-template>
					</div>
					<table class="lines-table">
						<thead>
							<tr>
								<th>Č.</th><th>Názov</th><th>Množstvo</th><th>MJ</th>
								<th>Cena/MJ</th><th>Celkom bez DPH</th><th>DPH%</th><th>Celkom s DPH</th>
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="cac:CreditNoteLine" mode="line-row"/>
						</tbody>
					</table>
					<!-- Totals -->
					<div class="totals-section">
						<div class="totals-box">
							<table class="totals-table">
								<tr class="total-row">
									<td class="label">K úhrade:</td>
									<td class="value">
										<xsl:call-template name="format-amount">
											<xsl:with-param name="value" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/>
											<xsl:with-param name="currency" select="cbc:DocumentCurrencyCode"/>
										</xsl:call-template>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

	<!-- ============================================================ -->
	<!-- PARTY BOX TEMPLATE -->
	<!-- ============================================================ -->
	<xsl:template match="cac:Party" mode="party-box">
		<div class="company-name">
			<xsl:value-of select="cac:PartyName/cbc:Name"/>
		</div>
		<xsl:if test="cac:PostalAddress/cbc:StreetName">
			<div class="address-line"><xsl:value-of select="cac:PostalAddress/cbc:StreetName"/></div>
		</xsl:if>
		<xsl:if test="cac:PostalAddress/cbc:PostalZone or cac:PostalAddress/cbc:CityName">
			<div class="address-line">
				<xsl:value-of select="cac:PostalAddress/cbc:PostalZone"/>
				<xsl:text>  </xsl:text>
				<xsl:value-of select="cac:PostalAddress/cbc:CityName"/>
			</div>
		</xsl:if>
		<xsl:if test="cac:PostalAddress/cac:Country/cbc:IdentificationCode">
			<div class="address-line">
				<xsl:call-template name="u-codelist">
					<xsl:with-param name="codelist" select="'iso3166'"/>
					<xsl:with-param name="code" select="cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>
				</xsl:call-template>
			</div>
		</xsl:if>
		<div class="id-line">
			<span>
				<xsl:call-template name="u-label">
					<xsl:with-param name="part" select="'party'"/>
					<xsl:with-param name="value" select="'ICO'"/>
				</xsl:call-template>
			</span>
			<xsl:value-of select="cac:PartyIdentification/cbc:ID"/>
		</div>
		<xsl:if test="cac:PartyTaxScheme/cbc:CompanyID">
			<div class="id-line">
				<span>
					<xsl:call-template name="u-label">
						<xsl:with-param name="part" select="'party'"/>
						<xsl:with-param name="value" select="'ICDPH'"/>
					</xsl:call-template>
				</span>
				<xsl:value-of select="cac:PartyTaxScheme/cbc:CompanyID"/>
			</div>
		</xsl:if>
	</xsl:template>

	<!-- ============================================================ -->
	<!-- INVOICE LINE ROW -->
	<!-- ============================================================ -->
	<xsl:template match="cac:InvoiceLine | cac:CreditNoteLine" mode="line-row">
		<xsl:variable name="qty" select="cbc:InvoicedQuantity | cbc:CreditedQuantity"/>
		<xsl:variable name="price" select="cac:Price/cbc:PriceAmount"/>
		<xsl:variable name="lineTotal" select="cbc:LineExtensionAmount"/>
		<xsl:variable name="vatPercent" select="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent"/>
		<xsl:variable name="priceWithVAT" select="$price * (1 + $vatPercent div 100)"/>
		<xsl:variable name="lineTotalWithVAT" select="$lineTotal * (1 + $vatPercent div 100)"/>

		<tr>
			<td class="num"><xsl:value-of select="cbc:ID"/></td>
			<td class="left">
				<div class="item-name"><xsl:value-of select="cac:Item/cbc:Name"/></div>
				<xsl:if test="cac:Item/cbc:Description">
					<div class="item-note"><xsl:value-of select="cac:Item/cbc:Description"/></div>
				</xsl:if>
			</td>
			<td class="right"><xsl:value-of select="format-number($qty, '##0')"/></td>
			<td class="num"><xsl:value-of select="$qty/@unitCode"/></td>
			<td class="right">
				<xsl:call-template name="format-amount">
					<xsl:with-param name="value" select="$price"/>
				</xsl:call-template>
			</td>
			<td class="right">
				<xsl:call-template name="format-amount">
					<xsl:with-param name="value" select="$lineTotal"/>
				</xsl:call-template>
			</td>
			<td class="num"><xsl:value-of select="format-number($vatPercent, '##0')"/>%</td>
			<td class="right">
				<xsl:call-template name="format-amount">
					<xsl:with-param name="value" select="$priceWithVAT"/>
				</xsl:call-template>
			</td>
			<td class="right">
				<xsl:call-template name="format-amount">
					<xsl:with-param name="value" select="$lineTotalWithVAT"/>
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>

	<!-- ============================================================ -->
	<!-- TAX SUBTOTAL ROW -->
	<!-- ============================================================ -->
	<xsl:template match="cac:TaxSubtotal" mode="tax-row">
		<xsl:variable name="percent" select="cac:TaxCategory/cbc:Percent"/>
		<tr>
			<td class="left">
				<xsl:choose>
					<xsl:when test="$percent >= 20">
						<xsl:call-template name="u-label">
							<xsl:with-param name="part" select="'tax'"/>
							<xsl:with-param name="value" select="'StandardRate'"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:value-of select="format-number($percent, '##0')"/>%
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="u-label">
							<xsl:with-param name="part" select="'tax'"/>
							<xsl:with-param name="value" select="'ReducedRate'"/>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:value-of select="format-number($percent, '##0')"/>%
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td class="right">
				<xsl:call-template name="format-amount">
					<xsl:with-param name="value" select="cbc:TaxableAmount"/>
				</xsl:call-template>
			</td>
			<td class="right">
				<xsl:call-template name="format-amount">
					<xsl:with-param name="value" select="cbc:TaxAmount"/>
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>

	<!-- ============================================================ -->
	<!-- UNKNOWN DOCUMENT -->
	<!-- ============================================================ -->
	<xsl:template match="*" mode="document">
		<html lang="sk">
			<head><meta charset="utf-8"/><title>Neznámy dokument</title></head>
			<body>
				<div class="invoice-container">
					<h1>Neznámy typ dokumentu</h1>
					<p>Dokument sa nepodarilo rozpoznať.</p>
				</div>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>