<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>Faktúra č. <xsl:value-of select="invoice/invoice/invoiceNumber"/></title>
                <style>
                    * { margin: 0; padding: 0; box-sizing: border-box; }
                    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 10pt; line-height: 1.5; color: #333; background-color: #f5f5f5; }
                    .invoice-container { max-width: 800px; margin: 40px auto; background: white; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
                    .header-bar { background-color: #4a4a4a; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; }
                    .header-contact { display: flex; align-items: center; gap: 8px; font-size: 9pt; }
                    .header-contact svg { width: 16px; height: 16px; fill: white; }
                    .main-content { padding: 40px; }
                    .top-section { display: flex; justify-content: space-between; margin-bottom: 40px; gap: 40px; }
                    .customer-box, .invoice-details-box { flex: 1; }
                    .section-title { font-size: 10pt; font-weight: 700; text-transform: uppercase; margin-bottom: 12px; color: #333; letter-spacing: 0.5px; }
                    .company-name { font-weight: 700; font-size: 11pt; margin-bottom: 8px; }
                    .info-line { font-size: 9pt; color: #666; margin-bottom: 4px; }
                    .invoice-meta { margin-bottom: 8px; }
                    .invoice-meta-label { font-weight: 600; display: inline-block; min-width: 120px; }
                    .invoice-meta-value { color: #333; }
                    .items-section { margin-bottom: 30px; }
                    .items-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                    .items-table thead { border-bottom: 2px solid #4a4a4a; }
                    .items-table th { text-align: left; padding: 12px 8px; font-weight: 700; text-transform: uppercase; font-size: 9pt; letter-spacing: 0.5px; color: #333; }
                    .items-table th.text-right { text-align: right; }
                    .items-table tbody tr { border-bottom: 1px solid #e0e0e0; }
                    .items-table td { padding: 15px 8px; vertical-align: top; }
                    .items-table td.text-right { text-align: right; }
                    .item-name { font-weight: 600; margin-bottom: 4px; }
                    .item-description { font-size: 9pt; color: #888; font-style: italic; }
                    .totals-section { margin-top: 30px; }
                    .total-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #e0e0e0; }
                    .total-row.grand-total { font-size: 12pt; font-weight: 700; border-top: 2px solid #4a4a4a; border-bottom: none; margin-top: 10px; padding-top: 15px; }
                    .total-label { font-weight: 600; }
                    .total-value { color: #333; }
                    .footer-section { margin-top: 50px; display: flex; justify-content: space-between; gap: 40px; }
                    .terms-box { flex: 1; }
                    .terms-title { font-weight: 700; text-transform: uppercase; margin-bottom: 10px; font-size: 9pt; }
                    .terms-text { font-size: 9pt; color: #666; line-height: 1.6; }
                    .signature-box { text-align: right; }
                    .signature-name { font-weight: 700; font-size: 11pt; margin-bottom: 4px; }
                    .signature-title { font-size: 9pt; color: #666; text-transform: uppercase; }
                    .note-section { margin-top: 30px; padding: 15px; background-color: #f9f9f9; border-left: 3px solid #4a4a4a; }
                    .note-text { font-size: 9pt; color: #666; font-style: italic; }
                    @media print { body { background: white; } .invoice-container { box-shadow: none; margin: 0; } }
                </style>
            </head>
            <body>
                <div class="invoice-container">
                    <!-- Header Bar -->
                    <div class="header-bar">
                        <div class="header-contact">
                            <svg viewBox="0 0 24 24"><path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z"/></svg>
                            <xsl:value-of select="invoice/supplier/phone"/>
                        </div>
                        <div class="header-contact">
                            <svg viewBox="0 0 24 24"><path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/></svg>
                            <xsl:value-of select="invoice/supplier/website"/>
                        </div>
                        <div class="header-contact">
                            <svg viewBox="0 0 24 24"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>
                            <xsl:value-of select="invoice/supplier/street"/>, <xsl:value-of select="invoice/supplier/postalCode"/> <xsl:value-of select="invoice/supplier/city"/>
                        </div>
                    </div>
                    
                    <!-- Main Content -->
                    <div class="main-content">
                        <!-- Top Section: Customer & Invoice Details -->
                        <div class="top-section">
                            <div class="customer-box">
                                <div class="section-title">INVOICE TO:</div>
                                <div class="company-name"><xsl:value-of select="invoice/customer/name"/></div>
                                <div class="info-line"><xsl:value-of select="invoice/customer/street"/></div>
                                <div class="info-line"><xsl:value-of select="invoice/customer/postalCode"/> <xsl:value-of select="invoice/customer/city"/></div>
                                <div class="info-line"><xsl:value-of select="invoice/customer/country"/></div>
                                <div class="info-line" style="margin-top: 8px;">IČO: <xsl:value-of select="invoice/customer/companyId"/></div>
                                <div class="info-line">DIČ: <xsl:value-of select="invoice/customer/taxId"/></div>
                                <div class="info-line">IČ DPH: <xsl:value-of select="invoice/customer/vatId"/></div>
                            </div>
                            
                            <div class="invoice-details-box">
                                <div class="section-title">INVOICE DETAILS:</div>
                                <div class="invoice-meta">
                                    <span class="invoice-meta-label">NO.:</span>
                                    <span class="invoice-meta-value"><xsl:value-of select="invoice/invoice/invoiceNumber"/></span>
                                </div>
                                <div class="invoice-meta">
                                    <span class="invoice-meta-label">DATE:</span>
                                    <span class="invoice-meta-value"><xsl:value-of select="invoice/invoice/issueDate"/></span>
                                </div>
                                <div class="invoice-meta">
                                    <span class="invoice-meta-label">DUE DATE:</span>
                                    <span class="invoice-meta-value"><xsl:value-of select="invoice/invoice/dueDate"/></span>
                                </div>
                                <div class="invoice-meta">
                                    <span class="invoice-meta-label">VARIABLE SYMBOL:</span>
                                    <span class="invoice-meta-value"><xsl:value-of select="invoice/invoice/variableSymbol"/></span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Items Table -->
                        <div class="items-section">
                            <table class="items-table">
                                <thead>
                                    <tr>
                                        <th>ITEM DESCRIPTION</th>
                                        <th class="text-right">QTY</th>
                                        <th class="text-right">PRICE</th>
                                        <th class="text-right">TOTAL</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="invoice/items">
                                        <tr>
                                            <td>
                                                <div class="item-name"><xsl:value-of select="name"/></div>
                                                <xsl:if test="description">
                                                    <div class="item-description"><xsl:value-of select="description"/></div>
                                                </xsl:if>
                                            </td>
                                            <td class="text-right">
                                                <xsl:value-of select="format-number(quantity, '#,##0.##')"/>
                                                <xsl:text> </xsl:text>
                                                <xsl:value-of select="unit"/>
                                            </td>
                                            <td class="text-right">
                                                <xsl:value-of select="format-number(unitPriceExclVat, '#,##0.00')"/>
                                                <xsl:text> </xsl:text>
                                                <xsl:value-of select="/invoice/invoice/currency"/>
                                            </td>
                                            <td class="text-right">
                                                <xsl:value-of select="format-number(lineTotalInclVat, '#,##0.00')"/>
                                                <xsl:text> </xsl:text>
                                                <xsl:value-of select="/invoice/invoice/currency"/>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Totals Section -->
                        <div class="totals-section">
                            <div class="total-row">
                                <span class="total-label">Sub-Total:</span>
                                <span class="total-value">
                                    <xsl:value-of select="format-number(invoice/totals/totalExclVat, '#,##0.00')"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="invoice/invoice/currency"/>
                                </span>
                            </div>
                            <div class="total-row">
                                <span class="total-label">
                                    Tax Vat (<xsl:value-of select="invoice/vatSummary[1]/vatRate"/>%):
                                </span>
                                <span class="total-value">
                                    <xsl:value-of select="format-number(invoice/totals/vatTotal, '#,##0.00')"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="invoice/invoice/currency"/>
                                </span>
                            </div>
                            <div class="total-row grand-total">
                                <span class="total-label">Grand Total:</span>
                                <span class="total-value">
                                    <xsl:value-of select="format-number(invoice/totals/amountDue, '#,##0.00')"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="invoice/invoice/currency"/>
                                </span>
                            </div>
                        </div>
                        
                        <!-- Note Section -->
                        <xsl:if test="invoice/invoice/note">
                            <div class="note-section">
                                <div class="note-text">
                                    <xsl:value-of select="invoice/invoice/note"/>
                                </div>
                            </div>
                        </xsl:if>
                        
                        <!-- Footer Section -->
                        <div class="footer-section">
                            <div class="terms-box">
                                <div class="terms-title">TERMS &amp; CONDITION:</div>
                                <div class="terms-text">
                                    Platba podľa dohody. Faktúra bola vystavená na základe zmluvného vzťahu medzi dodávateľom a odberateľom.
                                </div>
                                <div style="margin-top: 20px;">
                                    <div class="terms-title">Bankové údaje:</div>
                                    <div class="info-line">Banka: <xsl:value-of select="invoice/bankAccount/bankName"/></div>
                                    <div class="info-line">Číslo účtu: <xsl:value-of select="invoice/bankAccount/accountNumber"/></div>
                                    <div class="info-line">IBAN: <xsl:value-of select="invoice/bankAccount/iban"/></div>
                                    <div class="info-line">SWIFT: <xsl:value-of select="invoice/bankAccount/swift"/></div>
                                </div>
                            </div>
                            <div class="signature-box">
                                <div class="signature-name"><xsl:value-of select="invoice/supplier/name"/></div>
                                <div class="signature-title">Dodávateľ</div>
                                <div style="margin-top: 10px;">
                                    <xsl:if test="invoice/issuer/name">
                                        <div class="info-line">Vystavil: <xsl:value-of select="invoice/issuer/name"/></div>
                                    </xsl:if>
                                    <div class="info-line">Dátum vystavenia: <xsl:value-of select="invoice/invoice/issueDate"/></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>