<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" 
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" 
    xmlns:cn="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" 
    xmlns:in="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" 
    version="1.0" 
    exclude-result-prefixes="cac cbc cn in">
    
    <xsl:output method="html" version="4.01" encoding="UTF-8" indent="no"/>
    <xsl:param name="stylesheet_url" select="'NONE'"/>
    
    <!-- XSLT 1.0 compatible string replace template -->
    <xsl:template name="string-replace">
        <xsl:param name="string"/>
        <xsl:param name="search"/>
        <xsl:param name="replace"/>
        <xsl:choose>
            <xsl:when test="contains($string, $search)">
                <xsl:value-of select="substring-before($string, $search)"/>
                <xsl:value-of select="$replace"/>
                <xsl:call-template name="string-replace">
                    <xsl:with-param name="string" select="substring-after($string, $search)"/>
                    <xsl:with-param name="search" select="$search"/>
                    <xsl:with-param name="replace" select="$replace"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- XSLT 1.0 compatible tokenize template -->
    <xsl:template name="tokenize">
        <xsl:param name="text"/>
        <xsl:param name="delimiter" select="'&#10;'"/>
        <xsl:if test="$text">
            <xsl:choose>
                <xsl:when test="contains($text, $delimiter)">
                    <xsl:value-of select="normalize-space(substring-before($text, $delimiter))"/>
                    <xsl:text>|</xsl:text>
                    <xsl:call-template name="tokenize">
                        <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
                        <xsl:with-param name="delimiter" select="$delimiter"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space($text)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="doc-head">
        <meta charset="utf-8"/>
        <style>
            body {
                font-family: Arial, sans-serif;
                font-size: 10pt;
                margin: 0;
                padding: 20px;
                background-color: #fff;
            }
            .invoice-container {
                max-width: 800px;
                margin: 0 auto;
                border: 1px solid #ddd;
                padding: 20px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .logo-section {
                width: 40%;
            }
            .logo {
                width: 80px;
                height: 80px;
                background-color: #6b4c9a;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .company-info {
                font-size: 9pt;
                line-height: 1.4;
            }
            .invoice-details {
                width: 55%;
                border: 2px solid #000;
                padding: 10px;
            }
            .invoice-title {
                font-size: 14pt;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .field-row {
                display: flex;
                margin-bottom: 5px;
            }
            .field-label {
                width: 40%;
                font-weight: bold;
            }
            .field-value {
                width: 60%;
            }
            .parties-section {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .party-box {
                width: 48%;
                border: 2px solid #000;
                padding: 10px;
            }
            .party-title {
                font-weight: bold;
                margin-bottom: 10px;
                border-bottom: 1px solid #000;
                padding-bottom: 5px;
            }
            .info-grid {
                display: flex;
                flex-wrap: wrap;
                margin-bottom: 20px;
            }
            .info-item {
                width: 33.33%;
                margin-bottom: 5px;
            }
            .info-label {
                font-weight: bold;
            }
            table.invoice-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            table.invoice-table th {
                border: 1px solid #000;
                padding: 5px;
                text-align: left;
                font-weight: bold;
                background-color: #f0f0f0;
            }
            table.invoice-table td {
                border: 1px solid #000;
                padding: 5px;
            }
            .totals-section {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .tax-summary {
                width: 60%;
            }
            .total-box {
                width: 35%;
                border: 2px solid #000;
                padding: 10px;
            }
            .total-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 5px;
            }
            .total-label {
                font-weight: bold;
            }
            .footer {
                margin-top: 30px;
                border-top: 1px solid #000;
                padding-top: 10px;
                font-size: 9pt;
            }
            .footer-grid {
                display: flex;
                justify-content: space-between;
            }
            .note {
                font-style: italic;
                color: #666;
                margin: 10px 0;
            }
            h1, h2, h3 {
                margin: 0 0 10px 0;
            }
            .text-right {
                text-align: right;
            }
            .text-center {
                text-align: center;
            }
        </style>
    </xsl:template>
    
    <xsl:template match="/in:Invoice | /cn:CreditNote">
        <html>
            <head>
                <xsl:call-template name="doc-head"/>
                <title>Faktúra <xsl:value-of select="cbc:ID"/></title>
            </head>
            <body>
                <div class="invoice-container">
                    <!-- Header with logo and invoice details -->
                    <div class="header">
                        <div class="logo-section">
                            <div class="logo">LOGO</div>
                            <div class="company-info">
                                <strong><xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name"/></strong><br/>
                                <xsl:variable name="addr" select="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress"/>
                                <xsl:value-of select="$addr/cbc:StreetName"/><br/>
                                <xsl:value-of select="$addr/cbc:PostalZone"/> <xsl:value-of select="$addr/cbc:CityName"/><br/>
                                <xsl:value-of select="$addr/cac:Country/cbc:IdentificationCode"/>
                            </div>
                        </div>
                        <div class="invoice-details">
                            <div class="invoice-title">Faktúra č.: <xsl:value-of select="cbc:ID"/></div>
                            <div class="field-row">
                                <div class="field-label">Dátum vystavenia:</div>
                                <div class="field-value"><xsl:value-of select="cbc:IssueDate"/></div>
                            </div>
                            <div class="field-row">
                                <div class="field-label">Dátum splatnosti:</div>
                                <div class="field-value"><xsl:value-of select="cbc:DueDate"/></div>
                            </div>
                            <div class="field-row">
                                <div class="field-label">Variabilný symbol:</div>
                                <div class="field-value"><xsl:value-of select="cbc:ID"/></div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Parties section -->
                    <div class="parties-section">
                        <div class="party-box">
                            <div class="party-title">Dodávateľ:</div>
                            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party" mode="party"/>
                        </div>
                        <div class="party-box">
                            <div class="party-title">Odberateľ:</div>
                            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party" mode="party"/>
                        </div>
                    </div>
                    
                    <!-- Invoice lines table -->
                    <table class="invoice-table">
                        <thead>
                            <tr>
                                <th>Číslo</th>
                                <th>Názov</th>
                                <th class="text-center">Množstvo</th>
                                <th class="text-right">Cena za MJ</th>
                                <th class="text-right">Celkom bez DPH</th>
                                <th class="text-center">DPH %</th>
                                <th class="text-right">Celkom s DPH</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:apply-templates select="cac:InvoiceLine" mode="line"/>
                        </tbody>
                    </table>
                    
                    <!-- Totals section -->
                    <div class="totals-section">
                        <div class="tax-summary">
                            <h3>Rekapitulácia DPH</h3>
                            <xsl:apply-templates select="cac:TaxTotal/cac:TaxSubtotal" mode="tax"/>
                        </div>
                        <div class="total-box">
                            <xsl:apply-templates select="cac:LegalMonetaryTotal" mode="total"/>
                        </div>
                    </div>
                    
                    <!-- Payment info -->
                    <div class="note">
                        <xsl:apply-templates select="cac:PaymentMeans" mode="payment"/>
                    </div>
                    
                    <!-- Footer -->
                    <div class="footer">
                        <div class="footer-grid">
                            <div>
                                <strong>Tel. číslo:</strong> <xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:Telephone"/><br/>
                                <strong>Web:</strong> <xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:Contact/cbc:ElectronicMail"/>
                            </div>
                            <div class="text-right">
                                Podpis a pečiatka
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="cac:Party" mode="party">
        <div><xsl:value-of select="cac:PartyName/cbc:Name"/></div>
        <xsl:variable name="addr" select="cac:PostalAddress"/>
        <div><xsl:value-of select="$addr/cbc:StreetName"/></div>
        <div><xsl:value-of select="$addr/cbc:PostalZone"/> <xsl:value-of select="$addr/cbc:CityName"/></div>
        <div><xsl:value-of select="$addr/cac:Country/cbc:IdentificationCode"/></div>
        <div style="margin-top: 10px;">
            <xsl:for-each select="cac:PartyTaxScheme">
                <div>IČ DPH: <xsl:value-of select="cbc:CompanyID"/></div>
            </xsl:for-each>
            <xsl:for-each select="cac:PartyLegalEntity/cbc:CompanyID">
                <div>IČO: <xsl:value-of select="."/></div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template match="cac:InvoiceLine" mode="line">
        <tr>
            <td><xsl:value-of select="cbc:ID"/></td>
            <td><xsl:value-of select="cac:Item/cbc:Name"/></td>
            <td class="text-center"><xsl:value-of select="cbc:InvoicedQuantity"/></td>
            <td class="text-right"><xsl:value-of select="cac:Price/cbc:PriceAmount"/></td>
            <td class="text-right"><xsl:value-of select="cbc:LineExtensionAmount"/></td>
            <td class="text-center">
                <xsl:value-of select="cac:Item/cac:ClassifiedTaxCategory/cbc:Percent"/>
            </td>
            <td class="text-right">
                <xsl:value-of select="cbc:LineExtensionAmount * (1 + cac:Item/cac:ClassifiedTaxCategory/cbc:Percent div 100)"/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="cac:TaxSubtotal" mode="tax">
        <div>
            Sadzba DPH <xsl:value-of select="cac:TaxCategory/cbc:Percent"/>%: 
            Základ <xsl:value-of select="cbc:TaxableAmount"/>, 
            DPH <xsl:value-of select="cbc:TaxAmount"/>
        </div>
    </xsl:template>
    
    <xsl:template match="cac:LegalMonetaryTotal" mode="total">
        <div class="total-row">
            <span class="total-label">Celkom bez DPH:</span>
            <span><xsl:value-of select="cbc:TaxExclusiveAmount"/></span>
        </div>
        <div class="total-row">
            <span class="total-label">DPH:</span>
            <span><xsl:value-of select="cbc:TaxInclusiveAmount - cbc:TaxExclusiveAmount"/></span>
        </div>
        <div class="total-row" style="border-top: 2px solid #000; padding-top: 5px; margin-top: 5px;">
            <span class="total-label">Celkom s DPH:</span>
            <span><xsl:value-of select="cbc:PayableAmount"/></span>
        </div>
    </xsl:template>
    
    <xsl:template match="cac:PaymentMeans" mode="payment">
        <div>
            <strong>Bankové spojenie:</strong><br/>
            IBAN: <xsl:value-of select="cac:PayeeFinancialAccount/cbc:ID"/><br/>
            Banka: <xsl:value-of select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID"/>
        </div>
    </xsl:template>
    
</xsl:stylesheet>