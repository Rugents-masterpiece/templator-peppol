<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:Invoice="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="sk">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>Faktúra <xsl:value-of select="//cbc:ID"/></title>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }
                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        font-size: 14px;
                        line-height: 1.6;
                        color: #333;
                        background-color: #f5f5f5;
                        padding: 20px;
                    }
                    .invoice-container {
                        max-width: 900px;
                        margin: 0 auto;
                        background: white;
                        box-shadow: 0 0 20px rgba(0,0,0,0.1);
                    }
                    .header {
                        background: #4a5568;
                        color: white;
                        padding: 30px 40px;
                    }
                    .header-title {
                        font-size: 24px;
                        font-weight: 600;
                        margin-bottom: 10px;
                    }
                    .header-supplier {
                        font-size: 14px;
                        margin-bottom: 15px;
                        opacity: 0.9;
                    }
                    .header-contact {
                        display: flex;
                        justify-content: space-between;
                        flex-wrap: wrap;
                        gap: 15px;
                        font-size: 12px;
                        margin-top: 20px;
                        padding-top: 20px;
                        border-top: 1px solid rgba(255,255,255,0.2);
                    }
                    .header-contact span {
                        display: flex;
                        align-items: center;
                        gap: 5px;
                    }
                    .content {
                        padding: 40px;
                    }
                    .info-section {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 40px;
                        gap: 40px;
                    }
                    .info-box {
                        flex: 1;
                    }
                    .info-box h3 {
                        font-size: 12px;
                        text-transform: uppercase;
                        color: #2d3748;
                        margin-bottom: 15px;
                        font-weight: 600;
                    }
                    .customer-box {
                        background: #f7fafc;
                        padding: 20px;
                        border-radius: 4px;
                        border-left: 4px solid #4a5568;
                    }
                    .customer-box .company-name {
                        font-weight: 600;
                        font-size: 16px;
                        margin-bottom: 8px;
                        color: #2d3748;
                    }
                    .customer-box p {
                        margin-bottom: 5px;
                        color: #4a5568;
                        font-size: 13px;
                    }
                    .invoice-details-box {
                        padding: 20px;
                    }
                    .invoice-details-box .detail-row {
                        margin-bottom: 10px;
                    }
                    .invoice-details-box .detail-label {
                        font-weight: 600;
                        color: #2d3748;
                        font-size: 12px;
                    }
                    .invoice-details-box .detail-value {
                        color: #4a5568;
                    }
                    .items-table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-bottom: 30px;
                    }
                    .items-table thead {
                        border-bottom: 2px solid #e2e8f0;
                    }
                    .items-table th {
                        text-align: left;
                        padding: 12px 0;
                        font-weight: 600;
                        color: #2d3748;
                        text-transform: uppercase;
                        font-size: 12px;
                    }
                    .items-table th.text-right {
                        text-align: right;
                    }
                    .items-table td {
                        padding: 15px 0;
                        border-bottom: 1px solid #e2e8f0;
                        vertical-align: top;
                    }
                    .items-table td.text-right {
                        text-align: right;
                    }
                    .items-table .item-name {
                        font-weight: 600;
                        color: #2d3748;
                        margin-bottom: 5px;
                    }
                    .items-table .item-description {
                        color: #718096;
                        font-size: 12px;
                    }
                    .totals-section {
                        margin-top: 30px;
                    }
                    .totals-row {
                        display: flex;
                        justify-content: space-between;
                        padding: 10px 0;
                        border-bottom: 1px solid #e2e8f0;
                    }
                    .totals-row.total {
                        font-size: 18px;
                        font-weight: 600;
                        color: #2d3748;
                        border-bottom: none;
                        border-top: 2px solid #4a5568;
                        margin-top: 10px;
                        padding-top: 15px;
                    }
                    .vat-summary {
                        margin-top: 30px;
                        padding: 20px;
                        background: #f7fafc;
                        border-radius: 4px;
                    }
                    .vat-summary h3 {
                        font-size: 12px;
                        text-transform: uppercase;
                        color: #2d3748;
                        margin-bottom: 15px;
                    }
                    .vat-row {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 8px;
                        font-size: 13px;
                    }
                    .bank-info {
                        margin-top: 30px;
                        padding: 20px;
                        background: #f7fafc;
                        border-radius: 4px;
                    }
                    .bank-info h3 {
                        font-size: 12px;
                        text-transform: uppercase;
                        color: #2d3748;
                        margin-bottom: 15px;
                    }
                    .terms-section {
                        margin-top: 40px;
                        padding-top: 30px;
                        border-top: 1px solid #e2e8f0;
                    }
                    .terms-section h3 {
                        font-size: 12px;
                        text-transform: uppercase;
                        color: #2d3748;
                        margin-bottom: 10px;
                    }
                    .terms-section p {
                        color: #718096;
                        font-size: 12px;
                        line-height: 1.8;
                    }
                    .footer {
                        margin-top: 50px;
                        text-align: right;
                        padding-top: 30px;
                        border-top: 1px solid #e2e8f0;
                    }
                    .footer .company-name {
                        font-weight: 600;
                        font-size: 16px;
                        color: #2d3748;
                    }
                    .footer .company-role {
                        color: #718096;
                        font-size: 12px;
                        text-transform: uppercase;
                    }
                    @media print {
                        body {
                            background: white;
                            padding: 0;
                        }
                        .invoice-container {
                            box-shadow: none;
                        }
                    }
                    @media (max-width: 768px) {
                        .info-section {
                            flex-direction: column;
                            gap: 20px;
                        }
                        .header-contact {
                            flex-direction: column;
                        }
                    }
                </style>
            </head>
            <body>
                <div class="invoice-container">
                    <!-- Header -->
                    <div class="header">
                        <div class="header-title">FAKTÚRA</div>
                        <div class="header-supplier">
                            <xsl:value-of select="//cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name"/>
                            <xsl:text> | DIČ: </xsl:text>
                            <xsl:value-of select="//cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
                        </div>
                        <div class="header-contact">
                            <xsl:if test="//cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName">
                                <span>
                                    <xsl:value-of select="//cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:StreetName"/>, 
                                    <xsl:value-of select="//cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="//cac:AccountingSupplierParty/cac:Party/cac:PostalAddress/cbc:CityName"/>
                                </span>
                            </xsl:if>
                            <xsl:if test="//cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID">
                                <span>IČO: <xsl:value-of select="//cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID"/></span>
                            </xsl:if>
                        </div>
                    </div>
                    
                    <!-- Content -->
                    <div class="content">
                        <!-- Invoice To and Details - SWAPPED ORDER -->
                        <div class="info-section">
                            <!-- Customer (INVOICE TO) - NOW FIRST -->
                            <div class="info-box">
                                <h3>FAKTÚROVANÉ:</h3>
                                <div class="customer-box">
                                    <div class="company-name">
                                        <xsl:value-of select="//cac:AccountingCustomerParty/cac:Party/cac:PartyName/cbc:Name"/>
                                    </div>
                                    <p>
                                        <xsl:value-of select="//cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:StreetName"/>
                                    </p>
                                    <p>
                                        <xsl:value-of select="//cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:PostalZone"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="//cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cbc:CityName"/>
                                    </p>
                                    <p>
                                        <xsl:value-of select="//cac:AccountingCustomerParty/cac:Party/cac:PostalAddress/cac:Country/cbc:IdentificationCode"/>
                                    </p>
                                    <p style="margin-top: 10px; font-size: 12px;">
                                        IČO: <xsl:value-of select="//cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID"/>
                                    </p>
                                    <p style="font-size: 12px;">
                                        IČ DPH: <xsl:value-of select="//cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
                                    </p>
                                </div>
                            </div>
                            
                            <!-- Invoice Details - NOW SECOND -->
                            <div class="info-box">
                                <h3>DETAILY FAKTÚRY:</h3>
                                <div class="invoice-details-box">
                                    <div class="detail-row">
                                        <div class="detail-label">ČÍSLO FAKTÚRY:</div>
                                        <div class="detail-value"><xsl:value-of select="//cbc:ID"/></div>
                                    </div>
                                    <div class="detail-row">
                                        <div class="detail-label">DÁTUM VYSTAVENIA:</div>
                                        <div class="detail-value"><xsl:value-of select="//cbc:IssueDate"/></div>
                                    </div>
                                    <div class="detail-row">
                                        <div class="detail-label">DÁTUM SPLATNOSTI:</div>
                                        <div class="detail-value"><xsl:value-of select="//cbc:DueDate"/></div>
                                    </div>
                                    <div class="detail-row">
                                        <div class="detail-label">MENA:</div>
                                        <div class="detail-value"><xsl:value-of select="//cbc:DocumentCurrencyCode"/></div>
                                    </div>
                                    <div class="detail-row">
                                        <div class="detail-label">VARIABILNÝ SYMBOL:</div>
                                        <div class="detail-value"><xsl:value-of select="//cac:PaymentMeans/cbc:PaymentID"/></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Items Table -->
                        <table class="items-table">
                            <thead>
                                <tr>
                                    <th style="width: 40%;">POLOŽKA</th>
                                    <th class="text-right" style="width: 15%;">MNOŽSTVO</th>
                                    <th class="text-right" style="width: 20%;">CENA ZA MJ</th>
                                    <th class="text-right" style="width: 25%;">CELKOM</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="//cac:InvoiceLine">
                                    <tr>
                                        <td>
                                            <div class="item-name">
                                                <xsl:value-of select="cac:Item/cbc:Name"/>
                                            </div>
                                            <xsl:if test="cbc:AccountingCost">
                                                <div class="item-description">
                                                    <xsl:value-of select="cbc:AccountingCost"/>
                                                </div>
                                            </xsl:if>
                                        </td>
                                        <td class="text-right">
                                            <xsl:value-of select="cbc:InvoicedQuantity"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="cbc:InvoicedQuantity/@unitCode"/>
                                        </td>
                                        <td class="text-right">
                                            <xsl:value-of select="format-number(cac:Price/cbc:PriceAmount, '#,##0.00')"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="cac:Price/cbc:PriceAmount/@currencyID"/>
                                        </td>
                                        <td class="text-right">
                                            <xsl:value-of select="format-number(cbc:LineExtensionAmount, '#,##0.00')"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="cbc:LineExtensionAmount/@currencyID"/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                        
                        <!-- VAT Summary -->
                        <div class="vat-summary">
                            <h3>REKAPITULÁCIA DPH</h3>
                            <xsl:for-each select="//cac:TaxTotal/cac:TaxSubtotal">
                                <div class="vat-row">
                                    <span>
                                        Sadzba DPH <xsl:value-of select="cac:TaxCategory/cbc:Percent"/>% 
                                        (<xsl:value-of select="cac:TaxCategory/cbc:ID"/>):
                                    </span>
                                    <span>
                                        Základ: <xsl:value-of select="format-number(cbc:TaxableAmount, '#,##0.00')"/>
                                        <xsl:text> | </xsl:text>
                                        DPH: <xsl:value-of select="format-number(cbc:TaxAmount, '#,##0.00')"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="cbc:TaxAmount/@currencyID"/>
                                    </span>
                                </div>
                            </xsl:for-each>
                        </div>
                        
                        <!-- Bank Info -->
                        <div class="bank-info">
                            <h3>BANKOVÉ ÚDAJE</h3>
                            <p>
                                <strong>Názov účtu:</strong> 
                                <xsl:value-of select="//cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:Name"/>
                            </p>
                            <p>
                                <strong>IBAN:</strong> 
                                <xsl:value-of select="//cac:PaymentMeans/cac:PayeeFinancialAccount/cbc:ID"/>
                            </p>
                            <p>
                                <strong>SWIFT/BIC:</strong> 
                                <xsl:value-of select="//cac:PaymentMeans/cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID"/>
                            </p>
                            <xsl:if test="//cac:PaymentMeans/cbc:PaymentID">
                                <p>
                                    <strong>Variabilný symbol:</strong> 
                                    <xsl:value-of select="//cac:PaymentMeans/cbc:PaymentID"/>
                                </p>
                            </xsl:if>
                        </div>
                        
                        <!-- Totals -->
                        <div class="totals-section">
                            <div class="totals-row">
                                <span>Celkom bez DPH:</span>
                                <span>
                                    <xsl:value-of select="format-number(//cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount, '#,##0.00')"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="//cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount/@currencyID"/>
                                </span>
                            </div>
                            <div class="totals-row">
                                <span>DPH spolu:</span>
                                <span>
                                    <xsl:value-of select="format-number(//cac:TaxTotal/cbc:TaxAmount, '#,##0.00')"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="//cac:TaxTotal/cbc:TaxAmount/@currencyID"/>
                                </span>
                            </div>
                            <div class="totals-row total">
                                <span>Celkom na úhradu:</span>
                                <span>
                                    <xsl:value-of select="format-number(//cac:LegalMonetaryTotal/cbc:PayableAmount, '#,##0.00')"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="//cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/>
                                </span>
                            </div>
                        </div>
                        
                        <!-- Terms -->
                        <div class="terms-section">
                            <h3>PODMIENKY PLATBY:</h3>
                            <p>
                                Úhradu prosíme vykonať do dátumu splatnosti uvedeného na faktuře. 
                                Ako variabilný symbol použite číslo faktúry.
                                Za oneskorenú platbu môžu byť účtované dodatočné poplatky.
                            </p>
                        </div>
                        
                        <!-- Footer -->
                        <div class="footer">
                            <div class="company-name">
                                <xsl:value-of select="//cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name"/>
                            </div>
                            <div class="company-role">DODÁVATEĽ</div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>