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
  <xsl:param name="language" select="'en'"/>
  <xsl:param name="mode" select="'document'"/>
  <xsl:param name="download_attachment" select="'false'"/>

  <!-- ============================================================ -->
  <!-- CODELISTS VARIABLE (result tree fragment) -->
  <!-- ============================================================ -->
  <xsl:variable name="codelists">
    <cl id="iso3166">
      <c id="AD">
        <t id="en">Andorra</t>
        <t id="no">Andorra</t>
      </c>
      <c id="AE">
        <t id="en">United Arab Emirates</t>
        <t id="no">De forente arabiske emirater</t>
      </c>
      <c id="AF">
        <t id="en">Afghanistan</t>
        <t id="no">Afghanistan</t>
      </c>
      <c id="AG">
        <t id="en">Antigua and Barbuda</t>
        <t id="no">Antigua og Barbuda</t>
      </c>
      <c id="AI">
        <t id="en">Anguilla</t>
        <t id="no">Anguilla</t>
      </c>
      <c id="AL">
        <t id="en">Albania</t>
        <t id="no">Albania</t>
      </c>
      <c id="AM">
        <t id="en">Armenia</t>
        <t id="no">Armenia</t>
      </c>
      <c id="AO">
        <t id="en">Angola</t>
        <t id="no">Angola</t>
      </c>
      <c id="AQ">
        <t id="en">Antarctica</t>
        <t id="no">Antarktis</t>
      </c>
      <c id="AR">
        <t id="en">Argentina</t>
        <t id="no">Argentina</t>
      </c>
      <c id="AS">
        <t id="en">American Samoa</t>
        <t id="no">Amerikansk Samoa</t>
      </c>
      <c id="AT">
        <t id="en">Austria</t>
        <t id="no">Østerrike</t>
      </c>
      <c id="AU">
        <t id="en">Australia</t>
        <t id="no">Australia</t>
      </c>
      <c id="AW">
        <t id="en">Aruba</t>
        <t id="no">Aruba</t>
      </c>
      <c id="AX">
        <t id="en">Åland Islands</t>
        <t id="no">Åland</t>
      </c>
      <c id="AZ">
        <t id="en">Azerbaijan</t>
        <t id="no">Aserbajdsjan</t>
      </c>
      <c id="BA">
        <t id="en">Bosnia and Herzegovina</t>
        <t id="no">Bosnia-Hercegovina</t>
      </c>
      <c id="BB">
        <t id="en">Barbados</t>
        <t id="no">Barbados</t>
      </c>
      <c id="BD">
        <t id="en">Bangladesh</t>
        <t id="no">Bangladesh</t>
      </c>
      <c id="BE">
        <t id="en">Belgium</t>
        <t id="no">Belgia</t>
      </c>
      <c id="BF">
        <t id="en">Burkina Faso</t>
        <t id="no">Burkina Faso</t>
      </c>
      <c id="BG">
        <t id="en">Bulgaria</t>
        <t id="no">Bulgaria</t>
      </c>
      <c id="BH">
        <t id="en">Bahrain</t>
        <t id="no">Bahrain</t>
      </c>
      <c id="BI">
        <t id="en">Burundi</t>
        <t id="no">Burundi</t>
      </c>
      <c id="BJ">
        <t id="en">Benin</t>
        <t id="no">Benin</t>
      </c>
      <c id="BL">
        <t id="en">Saint Barthélemy</t>
        <t id="no">Saint-Barthélemy</t>
      </c>
      <c id="BM">
        <t id="en">Bermuda</t>
        <t id="no">Bermuda</t>
      </c>
      <c id="BN">
        <t id="en">Brunei Darussalam</t>
        <t id="no">Brunei</t>
      </c>
      <c id="BO">
        <t id="en">Bolivia, Plurinational State of</t>
        <t id="no">Bolivia</t>
      </c>
      <c id="BQ">
        <t id="en">Bonaire, Sint Eustatius and Saba</t>
        <t id="no">Bonaire, Sint Eustatius og Saba</t>
      </c>
      <c id="BR">
        <t id="en">Brazil</t>
        <t id="no">Brasil</t>
      </c>
      <c id="BS">
        <t id="en">Bahamas</t>
        <t id="no">Bahamas</t>
      </c>
      <c id="BT">
        <t id="en">Bhutan</t>
        <t id="no">Bhutan</t>
      </c>
      <c id="BV">
        <t id="en">Bouvet Island</t>
        <t id="no">Bouvetøya</t>
      </c>
      <c id="BW">
        <t id="en">Botswana</t>
        <t id="no">Botswana</t>
      </c>
      <c id="BY">
        <t id="en">Belarus</t>
        <t id="no">Hviterussland</t>
      </c>
      <c id="BZ">
        <t id="en">Belize</t>
        <t id="no">Belize</t>
      </c>
      <c id="CA">
        <t id="en">Canada</t>
        <t id="no">Canada</t>
      </c>
      <c id="CC">
        <t id="en">Cocos (Keeling) Islands</t>
        <t id="no">Kokosøyene</t>
      </c>
      <c id="CD">
        <t id="en">Congo, the Democratic Republic of the</t>
        <t id="no">Den demokratiske republikken Kongo</t>
      </c>
      <c id="CF">
        <t id="en">Central African Republic</t>
        <t id="no">Den sentralafrikanske republikk</t>
      </c>
      <c id="CG">
        <t id="en">Congo</t>
        <t id="no">Republikken Kongo</t>
      </c>
      <c id="CH">
        <t id="en">Switzerland</t>
        <t id="no">Sveits</t>
      </c>
      <c id="CI">
        <t id="en">Côte d'Ivoire</t>
        <t id="no">Elfenbenskysten</t>
      </c>
      <c id="CK">
        <t id="en">Cook Islands</t>
        <t id="no">Cookøyene</t>
      </c>
      <c id="CL">
        <t id="en">Chile</t>
        <t id="no">Chile</t>
      </c>
      <c id="CM">
        <t id="en">Cameroon</t>
        <t id="no">Kamerun</t>
      </c>
      <c id="CN">
        <t id="en">China</t>
        <t id="no">Kina</t>
      </c>
      <c id="CO">
        <t id="en">Colombia</t>
        <t id="no">Colombia</t>
      </c>
      <c id="CR">
        <t id="en">Costa Rica</t>
        <t id="no">Costa Rica</t>
      </c>
      <c id="CU">
        <t id="en">Cuba</t>
        <t id="no">Cuba</t>
      </c>
      <c id="CV">
        <t id="en">Cabo Verde</t>
        <t id="no">Kapp Verde</t>
      </c>
      <c id="CW">
        <t id="en">Curaçao</t>
        <t id="no">Curaçao</t>
      </c>
      <c id="CX">
        <t id="en">Christmas Island</t>
        <t id="no">Christmasøya</t>
      </c>
      <c id="CY">
        <t id="en">Cyprus</t>
        <t id="no">Kypros</t>
      </c>
      <c id="CZ">
        <t id="en">Czechia</t>
        <t id="no">Tsjekkia</t>
      </c>
      <c id="DE">
        <t id="en">Germany</t>
        <t id="no">Tyskland</t>
      </c>
      <c id="DJ">
        <t id="en">Djibouti</t>
        <t id="no">Djibouti</t>
      </c>
      <c id="DK">
        <t id="en">Denmark</t>
        <t id="no">Danmark</t>
      </c>
      <c id="DM">
        <t id="en">Dominica</t>
        <t id="no">Dominica</t>
      </c>
      <c id="DO">
        <t id="en">Dominican Republic</t>
        <t id="no">Den dominikanske republikk</t>
      </c>
      <c id="DZ">
        <t id="en">Algeria</t>
        <t id="no">Algerie</t>
      </c>
      <c id="EC">
        <t id="en">Ecuador</t>
        <t id="no">Ecuador</t>
      </c>
      <c id="EE">
        <t id="en">Estonia</t>
        <t id="no">Estland</t>
      </c>
      <c id="EG">
        <t id="en">Egypt</t>
        <t id="no">Egypt</t>
      </c>
      <c id="EH">
        <t id="en">Western Sahara</t>
        <t id="no">Vest-Sahara</t>
      </c>
      <c id="ER">
        <t id="en">Eritrea</t>
        <t id="no">Eritrea</t>
      </c>
      <c id="ES">
        <t id="en">Spain</t>
        <t id="no">Spania</t>
      </c>
      <c id="ET">
        <t id="en">Ethiopia</t>
        <t id="no">Etiopia</t>
      </c>
      <c id="FI">
        <t id="en">Finland</t>
        <t id="no">Finland</t>
      </c>
      <c id="FJ">
        <t id="en">Fiji</t>
        <t id="no">Fiji</t>
      </c>
      <c id="FK">
        <t id="en">Falkland Islands (Malvinas)</t>
        <t id="no">Falklandsøyene</t>
      </c>
      <c id="FM">
        <t id="en">Micronesia, Federated States of</t>
        <t id="no">Mikronesiaføderasjonen</t>
      </c>
      <c id="FO">
        <t id="en">Faroe Islands</t>
        <t id="no">Færøyene</t>
      </c>
      <c id="FR">
        <t id="en">France</t>
        <t id="no">Frankrike</t>
      </c>
      <c id="GA">
        <t id="en">Gabon</t>
        <t id="no">Gabon</t>
      </c>
      <c id="GB">
        <t id="en">United Kingdom of Great Britain and Northern Ireland</t>
        <t id="no">Storbritannia</t>
      </c>
      <c id="GD">
        <t id="en">Grenada</t>
        <t id="no">Grenada</t>
      </c>
      <c id="GE">
        <t id="en">Georgia</t>
        <t id="no">Georgia</t>
      </c>
      <c id="GF">
        <t id="en">French Guiana</t>
        <t id="no">Fransk Guyana</t>
      </c>
      <c id="GG">
        <t id="en">Guernsey</t>
        <t id="no">Guernsey</t>
      </c>
      <c id="GH">
        <t id="en">Ghana</t>
        <t id="no">Ghana</t>
      </c>
      <c id="GI">
        <t id="en">Gibraltar</t>
        <t id="no">Gibraltar</t>
      </c>
      <c id="GL">
        <t id="en">Greenland</t>
        <t id="no">Grønland</t>
      </c>
      <c id="GM">
        <t id="en">Gambia</t>
        <t id="no">Gambia</t>
      </c>
      <c id="GN">
        <t id="en">Guinea</t>
        <t id="no">Guinea</t>
      </c>
      <c id="GP">
        <t id="en">Guadeloupe</t>
        <t id="no">Guadeloupe</t>
      </c>
      <c id="GQ">
        <t id="en">Equatorial Guinea</t>
        <t id="no">Ekvatorial-Guinea</t>
      </c>
      <c id="GR">
        <t id="en">Greece</t>
        <t id="no">Hellas</t>
      </c>
      <c id="GS">
        <t id="en">South Georgia and the South Sandwich Islands</t>
        <t id="no">Sør-Georgia og Sør-Sandwichøyene</t>
      </c>
      <c id="GT">
        <t id="en">Guatemala</t>
        <t id="no">Guatemala</t>
      </c>
      <c id="GU">
        <t id="en">Guam</t>
        <t id="no">Guam</t>
      </c>
      <c id="GW">
        <t id="en">Guinea-Bissau</t>
        <t id="no">Guinea-Bissau</t>
      </c>
      <c id="GY">
        <t id="en">Guyana</t>
        <t id="no">Guyana</t>
      </c>
      <c id="HK">
        <t id="en">Hong Kong</t>
        <t id="no">Hongkong</t>
      </c>
      <c id="HM">
        <t id="en">Heard Island and McDonald Islands</t>
        <t id="no">Heard- og McDonaldøyene</t>
      </c>
      <c id="HN">
        <t id="en">Honduras</t>
        <t id="no">Honduras</t>
      </c>
      <c id="HR">
        <t id="en">Croatia</t>
        <t id="no">Kroatia</t>
      </c>
      <c id="HT">
        <t id="en">Haiti</t>
        <t id="no">Haiti</t>
      </c>
      <c id="HU">
        <t id="en">Hungary</t>
        <t id="no">Ungarn</t>
      </c>
      <c id="ID">
        <t id="en">Indonesia</t>
        <t id="no">Indonesia</t>
      </c>
      <c id="IE">
        <t id="en">Ireland</t>
        <t id="no">Irland</t>
      </c>
      <c id="IL">
        <t id="en">Israel</t>
        <t id="no">Israel</t>
      </c>
      <c id="IM">
        <t id="en">Isle of Man</t>
        <t id="no">Man</t>
      </c>
      <c id="IN">
        <t id="en">India</t>
        <t id="no">India</t>
      </c>
      <c id="IO">
        <t id="en">British Indian Ocean Territory</t>
        <t id="no">Det britiske territoriet i Indiahavet</t>
      </c>
      <c id="IQ">
        <t id="en">Iraq</t>
        <t id="no">Irak</t>
      </c>
      <c id="IR">
        <t id="en">Iran, Islamic Republic of</t>
        <t id="no">Iran</t>
      </c>
      <c id="IS">
        <t id="en">Iceland</t>
        <t id="no">Island</t>
      </c>
      <c id="IT">
        <t id="en">Italy</t>
        <t id="no">Italia</t>
      </c>
      <c id="JE">
        <t id="en">Jersey</t>
        <t id="no">Jersey</t>
      </c>
      <c id="JM">
        <t id="en">Jamaica</t>
        <t id="no">Jamaica</t>
      </c>
      <c id="JO">
        <t id="en">Jordan</t>
        <t id="no">Jordan</t>
      </c>
      <c id="JP">
        <t id="en">Japan</t>
        <t id="no">Japan</t>
      </c>
      <c id="KE">
        <t id="en">Kenya</t>
        <t id="no">Kenya</t>
      </c>
      <c id="KG">
        <t id="en">Kyrgyzstan</t>
        <t id="no">Kirgisistan</t>
      </c>
      <c id="KH">
        <t id="en">Cambodia</t>
        <t id="no">Kambodsja</t>
      </c>
      <c id="KI">
        <t id="en">Kiribati</t>
        <t id="no">Kiribati</t>
      </c>
      <c id="KM">
        <t id="en">Comoros</t>
        <t id="no">Komorene</t>
      </c>
      <c id="KN">
        <t id="en">Saint Kitts and Nevis</t>
        <t id="no">Saint Kitts og Nevis</t>
      </c>
      <c id="KP">
        <t id="en">Korea, Democratic People's Republic of</t>
        <t id="no">Nord-Korea</t>
      </c>
      <c id="KR">
        <t id="en">Korea, Republic of</t>
        <t id="no">Sør-Korea</t>
      </c>
      <c id="KW">
        <t id="en">Kuwait</t>
        <t id="no">Kuwait</t>
      </c>
      <c id="KY">
        <t id="en">Cayman Islands</t>
        <t id="no">Caymanøyene</t>
      </c>
      <c id="KZ">
        <t id="en">Kazakhstan</t>
        <t id="no">Kasakhstan</t>
      </c>
      <c id="LA">
        <t id="en">Lao People's Democratic Republic</t>
        <t id="no">Laos</t>
      </c>
      <c id="LB">
        <t id="en">Lebanon</t>
        <t id="no">Libanon</t>
      </c>
      <c id="LC">
        <t id="en">Saint Lucia</t>
        <t id="no">Saint Lucia</t>
      </c>
      <c id="LI">
        <t id="en">Liechtenstein</t>
        <t id="no">Liechtenstein</t>
      </c>
      <c id="LK">
        <t id="en">Sri Lanka</t>
        <t id="no">Sri Lanka</t>
      </c>
      <c id="LR">
        <t id="en">Liberia</t>
        <t id="no">Liberia</t>
      </c>
      <c id="LS">
        <t id="en">Lesotho</t>
        <t id="no">Lesotho</t>
      </c>
      <c id="LT">
        <t id="en">Lithuania</t>
        <t id="no">Litauen</t>
      </c>
      <c id="LU">
        <t id="en">Luxembourg</t>
        <t id="no">Luxembourg</t>
      </c>
      <c id="LV">
        <t id="en">Latvia</t>
        <t id="no">Latvia</t>
      </c>
      <c id="LY">
        <t id="en">Libya</t>
        <t id="no">Libya</t>
      </c>
      <c id="MA">
        <t id="en">Morocco</t>
        <t id="no">Marokko</t>
      </c>
      <c id="MC">
        <t id="en">Monaco</t>
        <t id="no">Monaco</t>
      </c>
      <c id="MD">
        <t id="en">Moldova, Republic of</t>
        <t id="no">Moldova</t>
      </c>
      <c id="ME">
        <t id="en">Montenegro</t>
        <t id="no">Montenegro</t>
      </c>
      <c id="MF">
        <t id="en">Saint Martin (French part)</t>
        <t id="no">Saint-Martin</t>
      </c>
      <c id="MG">
        <t id="en">Madagascar</t>
        <t id="no">Madagaskar</t>
      </c>
      <c id="MH">
        <t id="en">Marshall Islands</t>
        <t id="no">Marshalløyene</t>
      </c>
      <c id="MK">
        <t id="en">Macedonia, the former Yugoslav Republic of</t>
        <t id="no">Makedonia</t>
      </c>
      <c id="ML">
        <t id="en">Mali</t>
        <t id="no">Mali</t>
      </c>
      <c id="MM">
        <t id="en">Myanmar</t>
        <t id="no">Myanmar</t>
      </c>
      <c id="MN">
        <t id="en">Mongolia</t>
        <t id="no">Mongolia</t>
      </c>
      <c id="MO">
        <t id="en">Macao</t>
        <t id="no">Macao</t>
      </c>
      <c id="MP">
        <t id="en">Northern Mariana Islands</t>
        <t id="no">Nord-Marianene</t>
      </c>
      <c id="MQ">
        <t id="en">Martinique</t>
        <t id="no">Martinique</t>
      </c>
      <c id="MR">
        <t id="en">Mauritania</t>
        <t id="no">Mauritania</t>
      </c>
      <c id="MS">
        <t id="en">Montserrat</t>
        <t id="no">Montserrat</t>
      </c>
      <c id="MT">
        <t id="en">Malta</t>
        <t id="no">Malta</t>
      </c>
      <c id="MU">
        <t id="en">Mauritius</t>
        <t id="no">Mauritius</t>
      </c>
      <c id="MV">
        <t id="en">Maldives</t>
        <t id="no">Maldivene</t>
      </c>
      <c id="MW">
        <t id="en">Malawi</t>
        <t id="no">Malawi</t>
      </c>
      <c id="MX">
        <t id="en">Mexico</t>
        <t id="no">Mexico</t>
      </c>
      <c id="MY">
        <t id="en">Malaysia</t>
        <t id="no">Malaysia</t>
      </c>
      <c id="MZ">
        <t id="en">Mozambique</t>
        <t id="no">Mosambik</t>
      </c>
      <c id="NA">
        <t id="en">Namibia</t>
        <t id="no">Namibia</t>
      </c>
      <c id="NC">
        <t id="en">New Caledonia</t>
        <t id="no">Ny-Caledonia</t>
      </c>
      <c id="NE">
        <t id="en">Niger</t>
        <t id="no">Niger</t>
      </c>
      <c id="NF">
        <t id="en">Norfolk Island</t>
        <t id="no">Norfolkøya</t>
      </c>
      <c id="NG">
        <t id="en">Nigeria</t>
        <t id="no">Nigeria</t>
      </c>
      <c id="NI">
        <t id="en">Nicaragua</t>
        <t id="no">Nicaragua</t>
      </c>
      <c id="NL">
        <t id="en">Netherlands</t>
        <t id="no">Nederland</t>
      </c>
      <c id="NO">
        <t id="en">Norway</t>
        <t id="no">Norge</t>
      </c>
      <c id="NP">
        <t id="en">Nepal</t>
        <t id="no">Nepal</t>
      </c>
      <c id="NR">
        <t id="en">Nauru</t>
        <t id="no">Nauru</t>
      </c>
      <c id="NU">
        <t id="en">Niue</t>
        <t id="no">Niue</t>
      </c>
      <c id="NZ">
        <t id="en">New Zealand</t>
        <t id="no">New Zealand</t>
      </c>
      <c id="OM">
        <t id="en">Oman</t>
        <t id="no">Oman</t>
      </c>
      <c id="PA">
        <t id="en">Panama</t>
        <t id="no">Panama</t>
      </c>
      <c id="PE">
        <t id="en">Peru</t>
        <t id="no">Peru</t>
      </c>
      <c id="PF">
        <t id="en">French Polynesia</t>
        <t id="no">Fransk Polynesia</t>
      </c>
      <c id="PG">
        <t id="en">Papua New Guinea</t>
        <t id="no">Papua Ny-Guinea</t>
      </c>
      <c id="PH">
        <t id="en">Philippines</t>
        <t id="no">Filippinene</t>
      </c>
      <c id="PK">
        <t id="en">Pakistan</t>
        <t id="no">Pakistan</t>
      </c>
      <c id="PL">
        <t id="en">Poland</t>
        <t id="no">Polen</t>
      </c>
      <c id="PM">
        <t id="en">Saint Pierre and Miquelon</t>
        <t id="no">Saint-Pierre og Miquelon</t>
      </c>
      <c id="PN">
        <t id="en">Pitcairn</t>
        <t id="no">Pitcairnøyene</t>
      </c>
      <c id="PR">
        <t id="en">Puerto Rico</t>
        <t id="no">Puerto Rico</t>
      </c>
      <c id="PS">
        <t id="en">Palestine, State of</t>
        <t id="no">Palestina</t>
      </c>
      <c id="PT">
        <t id="en">Portugal</t>
        <t id="no">Portugal</t>
      </c>
      <c id="PW">
        <t id="en">Palau</t>
        <t id="no">Palau</t>
      </c>
      <c id="PY">
        <t id="en">Paraguay</t>
        <t id="no">Paraguay</t>
      </c>
      <c id="QA">
        <t id="en">Qatar</t>
        <t id="no">Qatar</t>
      </c>
      <c id="RE">
        <t id="en">Réunion</t>
        <t id="no">Réunion</t>
      </c>
      <c id="RO">
        <t id="en">Romania</t>
        <t id="no">Romania</t>
      </c>
      <c id="RS">
        <t id="en">Serbia</t>
        <t id="no">Serbia</t>
      </c>
      <c id="RU">
        <t id="en">Russian Federation</t>
        <t id="no">Russland</t>
      </c>
      <c id="RW">
        <t id="en">Rwanda</t>
        <t id="no">Rwanda</t>
      </c>
      <c id="SA">
        <t id="en">Saudi Arabia</t>
        <t id="no">Saudi-Arabia</t>
      </c>
      <c id="SB">
        <t id="en">Solomon Islands</t>
        <t id="no">Salomonøyene</t>
      </c>
      <c id="SC">
        <t id="en">Seychelles</t>
        <t id="no">Seychellene</t>
      </c>
      <c id="SD">
        <t id="en">Sudan</t>
        <t id="no">Sudan</t>
      </c>
      <c id="SE">
        <t id="en">Sweden</t>
        <t id="no">Sverige</t>
      </c>
      <c id="SG">
        <t id="en">Singapore</t>
        <t id="no">Singapore</t>
      </c>
      <c id="SH">
        <t id="en">Saint Helena, Ascension and Tristan da Cunha</t>
        <t id="no">St. Helena, Ascension og Tristan da Cunha</t>
      </c>
      <c id="SI">
        <t id="en">Slovenia</t>
        <t id="no">Slovenia</t>
      </c>
      <c id="SJ">
        <t id="en">Svalbard and Jan Mayen</t>
        <t id="no">Svalbard og Jan Mayen</t>
      </c>
      <c id="SK">
        <t id="en">Slovakia</t>
        <t id="no">Slovakia</t>
      </c>
      <c id="SL">
        <t id="en">Sierra Leone</t>
        <t id="no">Sierra Leone</t>
      </c>
      <c id="SM">
        <t id="en">San Marino</t>
        <t id="no">San Marino</t>
      </c>
      <c id="SN">
        <t id="en">Senegal</t>
        <t id="no">Senegal</t>
      </c>
      <c id="SO">
        <t id="en">Somalia</t>
        <t id="no">Somalia</t>
      </c>
      <c id="SR">
        <t id="en">Suriname</t>
        <t id="no">Surinam</t>
      </c>
      <c id="SS">
        <t id="en">South Sudan</t>
        <t id="no">Sør-Sudan</t>
      </c>
      <c id="ST">
        <t id="en">Sao Tome and Principe</t>
        <t id="no">São Tomé og Príncipe</t>
      </c>
      <c id="SV">
        <t id="en">El Salvador</t>
        <t id="no">El Salvador</t>
      </c>
      <c id="SX">
        <t id="en">Sint Maarten (Dutch part)</t>
        <t id="no">Sint Maarten</t>
      </c>
      <c id="SY">
        <t id="en">Syrian Arab Republic</t>
        <t id="no">Syria</t>
      </c>
      <c id="SZ">
        <t id="en">Swaziland</t>
        <t id="no">Swaziland</t>
      </c>
      <c id="TC">
        <t id="en">Turks and Caicos Islands</t>
        <t id="no">Turks- og Caicosøyene</t>
      </c>
      <c id="TD">
        <t id="en">Chad</t>
        <t id="no">Tsjad</t>
      </c>
      <c id="TF">
        <t id="en">French Southern Territories</t>
        <t id="no">De franske sørterritorier</t>
      </c>
      <c id="TG">
        <t id="en">Togo</t>
        <t id="no">Togo</t>
      </c>
      <c id="TH">
        <t id="en">Thailand</t>
        <t id="no">Thailand</t>
      </c>
      <c id="TJ">
        <t id="en">Tajikistan</t>
        <t id="no">Tadsjikistan</t>
      </c>
      <c id="TK">
        <t id="en">Tokelau</t>
        <t id="no">Tokelau</t>
      </c>
      <c id="TL">
        <t id="en">Timor-Leste</t>
        <t id="no">Øst-Timor</t>
      </c>
      <c id="TM">
        <t id="en">Turkmenistan</t>
        <t id="no">Turkmenistan</t>
      </c>
      <c id="TN">
        <t id="en">Tunisia</t>
        <t id="no">Tunisia</t>
      </c>
      <c id="TO">
        <t id="en">Tonga</t>
        <t id="no">Tonga</t>
      </c>
      <c id="TR">
        <t id="en">Turkey</t>
        <t id="no">Tyrkia</t>
      </c>
      <c id="TT">
        <t id="en">Trinidad and Tobago</t>
        <t id="no">Trinidad og Tobago</t>
      </c>
      <c id="TV">
        <t id="en">Tuvalu</t>
        <t id="no">Tuvalu</t>
      </c>
      <c id="TW">
        <t id="en">Taiwan, Province of China</t>
        <t id="no">Taiwan</t>
      </c>
      <c id="TZ">
        <t id="en">Tanzania, United Republic of</t>
        <t id="no">Tanzania</t>
      </c>
      <c id="UA">
        <t id="en">Ukraine</t>
        <t id="no">Ukraina</t>
      </c>
      <c id="UG">
        <t id="en">Uganda</t>
        <t id="no">Uganda</t>
      </c>
      <c id="UM">
        <t id="en">United States Minor Outlying Islands</t>
        <t id="no">USAs ytre småøyer</t>
      </c>
      <c id="US">
        <t id="en">United States of America</t>
        <t id="no">USA</t>
      </c>
      <c id="UY">
        <t id="en">Uruguay</t>
        <t id="no">Uruguay</t>
      </c>
      <c id="UZ">
        <t id="en">Uzbekistan</t>
        <t id="no">Usbekistan</t>
      </c>
      <c id="VA">
        <t id="en">Holy See</t>
        <t id="no">Vatikanstaten</t>
      </c>
      <c id="VC">
        <t id="en">Saint Vincent and the Grenadines</t>
        <t id="no">Saint Vincent og Grenadinene</t>
      </c>
      <c id="VE">
        <t id="en">Venezuela, Bolivarian Republic of</t>
        <t id="no">Venezuela</t>
      </c>
      <c id="VG">
        <t id="en">Virgin Islands, British</t>
        <t id="no">De britiske Jomfruøyer</t>
      </c>
      <c id="VI">
        <t id="en">Virgin Islands, U.S.</t>
        <t id="no">De amerikanske Jomfruøyer</t>
      </c>
      <c id="VN">
        <t id="en">Viet Nam</t>
        <t id="no">Vietnam</t>
      </c>
      <c id="VU">
        <t id="en">Vanuatu</t>
        <t id="no">Vanuatu</t>
      </c>
      <c id="WF">
        <t id="en">Wallis and Futuna</t>
        <t id="no">Wallis og Futuna</t>
      </c>
      <c id="WS">
        <t id="en">Samoa</t>
        <t id="no">Samoa</t>
      </c>
      <c id="YE">
        <t id="en">Yemen</t>
        <t id="no">Jemen</t>
      </c>
      <c id="YT">
        <t id="en">Mayotte</t>
        <t id="no">Mayotte</t>
      </c>
      <c id="ZA">
        <t id="en">South Africa</t>
        <t id="no">Sør-Afrika</t>
      </c>
      <c id="ZM">
        <t id="en">Zambia</t>
        <t id="no">Zambia</t>
      </c>
      <c id="ZW">
        <t id="en">Zimbabwe</t>
        <t id="no">Zimbabwe</t>
      </c>
    </cl>
    <cl id="uncl1001invoice">
      <c id="380">
        <t id="en">Commercial invoice</t>
        <t id="no">Kommersiell faktura</t>
      </c>
      <c id="393">
        <t id="en">Factored invoice</t>
        <t id="no">Factored invoice</t>
      </c>
      <c id="82">
        <t id="en">Metered services invoice</t>
        <t id="no">Metered services invoice</t>
      </c>
      <c id="80">
        <t id="en">Debit note related to goods or services</t>
        <t id="no">Debit note related to goods or services</t>
      </c>
      <c id="84">
        <t id="en">Debit note related to financial adjustments</t>
        <t id="no">Debit note related to financial adjustments</t>
      </c>
      <c id="395">
        <t id="en">Consignment invoice</t>
        <t id="no">Consignment invoice</t>
      </c>
      <c id="575">
        <t id="en">Forwarder's invoice</t>
        <t id="no">Forwarder's invoice</t>
      </c>
      <c id="780">
        <t id="en">Freight invoice</t>
        <t id="no">Freight invoice</t>
      </c>
    </cl>
    <cl id="uncl1001-cn">
      <c id="81">
        <t id="en">Credit note related to goods or services</t>
        <t id="no">Credit note related to goods or services</t>
      </c>
      <c id="83">
        <t id="en">Credit note related to financial adjustments</t>
        <t id="no">Credit note related to financial adjustments</t>
      </c>
      <c id="381">
        <t id="en">Credit note</t>
        <t id="no">Credit note</t>
      </c>
      <c id="396">
        <t id="en">Factored credit note</t>
        <t id="no">Factored credit note</t>
      </c>
      <c id="532">
        <t id="en">Forwarder's credit note</t>
        <t id="no">Forwarder's credit note</t>
      </c>
    </cl>
  </xsl:variable>

  <!-- ============================================================ -->
  <!-- LABELS VARIABLE (result tree fragment) -->
  <!-- ============================================================ -->
  <xsl:variable name="labels">
    <g id="attachments">
      <f id="Attachments">
        <t id="en">Attachments</t>
        <t id="no">Vedlegg</t>
      </f>
      <f id="Download">
        <t id="en">Download</t>
        <t id="no">Last ned</t>
      </f>
      <f id="Embedded">
        <t id="en">Embedded</t>
        <t id="no">Innebygd</t>
      </f>
    </g>
    <g id="delivery">
      <f id="Address">
        <t id="en">Address</t>
        <t id="no">Adresse</t>
      </f>
      <f id="Delivery">
        <t id="en">Delivery</t>
        <t id="no">Leveringssted</t>
      </f>
      <f id="DeliveryDate">
        <t id="en">Date</t>
        <t id="no">Dato</t>
      </f>
      <f id="DeliveryID">
        <t id="en">Location</t>
        <t id="no">Identifikator</t>
      </f>
    </g>
    <g id="document">
      <f id="CreditNote">
        <t id="en">Credit Note</t>
        <t id="no">Kreditnota</t>
      </f>
      <f id="Invoice">
        <t id="en">Invoice</t>
        <t id="no">Faktura</t>
      </f>
    </g>
    <g id="item">
      <f id="BuyersItemIdentification">
        <t id="en">Buyers Item Identification</t>
        <t id="no">Kjøpers vareidentifikator</t>
      </f>
      <f id="CommodityClassification">
        <t id="en">Commodity Classification</t>
        <t id="no">Klassifisering</t>
      </f>
      <f id="OriginCountry">
        <t id="en">Origin Country</t>
        <t id="no">Opprinnelseland</t>
      </f>
      <f id="SellersItemIdentification">
        <t id="en">Sellers Item Identification</t>
        <t id="no">Selgers vareidentifikator</t>
      </f>
      <f id="StandardItemIdentification">
        <t id="en">Standard Item Identification</t>
        <t id="no">Registrert vareidentifikator</t>
      </f>
    </g>
    <g id="line">
      <f id="Allowance">
        <t id="en">Allowance</t>
        <t id="no">Rabatt</t>
      </f>
      <f id="AllowanceIncluded">
        <t id="en">Included allowance</t>
        <t id="no">Inkludert rabatt</t>
      </f>
      <f id="AllowanceTotalAmount">
        <t id="en">Allowance Total</t>
        <t id="no">Rabattotal</t>
      </f>
      <f id="Charge">
        <t id="en">Charge</t>
        <t id="no">Gebyr</t>
      </f>
      <f id="ChargeIncluded">
        <t id="en">Included charge</t>
        <t id="no">Inkludert gebyr</t>
      </f>
      <f id="ChargeTotalAmount">
        <t id="en">Charge Total</t>
        <t id="no">Gebyrtotal</t>
      </f>
      <f id="DocumentReference">
        <t id="en">Document Reference</t>
        <t id="no">Dokumentreferanse</t>
      </f>
      <f id="InvoicePeriod">
        <t id="en">Invoice Period</t>
        <t id="no">Fakturaperiode</t>
      </f>
      <f id="LineExtensionAmount">
        <t id="en">Line Total</t>
        <t id="no">Linjetotal</t>
      </f>
      <f id="OrderLineReference">
        <t id="en">Order Line</t>
        <t id="no">Ordrelinje</t>
      </f>
    </g>
    <g id="metadata">
      <f id="AccountingCost">
        <t id="en">Accounting Cost</t>
        <t id="no">Kontering</t>
      </f>
      <f id="BuyerReference">
        <t id="en">Buyer Reference</t>
        <t id="no">Kjøpers referanse</t>
      </f>
      <f id="ContractDocumentReference">
        <t id="en">Contract Reference</t>
        <t id="no">Kontraktsnummer</t>
      </f>
      <f id="DespatchDocumentReference">
        <t id="en">Despatch Reference</t>
        <t id="no">Pakkseddel</t>
      </f>
      <f id="DocumentCurrencyCode">
        <t id="en">Currency</t>
        <t id="no">Valuta</t>
      </f>
      <f id="DueDate">
        <t id="en">Due Date</t>
        <t id="no">Betalingsfrist</t>
      </f>
      <f id="ID">
        <t id="en">Identifier</t>
        <t id="no">Identifikator</t>
      </f>
      <f id="InvoiceDocumentReference">
        <t id="en">Preceding Invoice Reference</t>
        <t id="no">Fakturareferanse</t>
      </f>
      <f id="InvoicePeriod">
        <t id="en">Invoice Period</t>
        <t id="no">Fakturaperiode</t>
      </f>
      <f id="IssueDate">
        <t id="en">Issue Date</t>
        <t id="no">Utstedt</t>
      </f>
      <f id="Metadata">
        <t id="en">Metadata</t>
        <t id="no">Metadata</t>
      </f>
      <f id="ObjectIdentifier">
        <t id="en">Call for Tender/Lot</t>
        <t id="no">Objektidentifikator</t>
      </f>
      <f id="OrderReference">
        <t id="en">Order Reference</t>
        <t id="no">Ordrenummer</t>
      </f>
      <f id="OriginatorDocumentReference">
        <t id="en">Originator Reference</t>
        <t id="no">Kildeidentifikator</t>
      </f>
      <f id="ProjectReference">
        <t id="en">Project Reference</t>
        <t id="no">Prosjektreferanse</t>
      </f>
      <f id="ReceiptDocumentReference">
        <t id="en">Receipt Reference</t>
        <t id="no">Kvitteringsreferanse</t>
      </f>
      <f id="TaxCurrencyCode">
        <t id="en">Tax Currency</t>
        <t id="no">MVA-valuta</t>
      </f>
      <f id="TaxPointDate">
        <t id="en">Tax Date</t>
        <t id="no">MVA-dato</t>
      </f>
    </g>
    <g id="party">
      <f id="BankingReference">
        <t id="en">Banking Reference</t>
        <t id="no">Bankidentifikator</t>
      </f>
      <f id="Customer">
        <t id="en">Customer</t>
        <t id="no">Kunde</t>
      </f>
      <f id="EndpointID">
        <t id="en">Technical Address</t>
        <t id="no">Teknisk adresse</t>
      </f>
      <f id="PartyIdentification">
        <t id="en">Party Identification</t>
        <t id="no">Aktøridentifikator</t>
      </f>
      <f id="PartyTaxScheme">
        <t id="en">Tax Identification</t>
        <t id="no">MVA-identifikator</t>
      </f>
      <f id="Supplier">
        <t id="en">Supplier</t>
        <t id="no">Leverandør</t>
      </f>
    </g>
    <g id="payment">
      <f id="Payment">
        <t id="en">Payment</t>
        <t id="no">Betaling</t>
      </f>
    </g>
    <g id="tax">
      <f id="Category">
        <t id="en">Category</t>
        <t id="no">Kategori</t>
      </f>
      <f id="Tax">
        <t id="en">Tax</t>
        <t id="no">Merverdiavgift</t>
      </f>
      <f id="TaxableAmount">
        <t id="en">Taxable</t>
        <t id="no">Grunnlag</t>
      </f>
      <f id="TaxAmount">
        <t id="en">Tax</t>
        <t id="no">MVA</t>
      </f>
      <f id="Total">
        <t id="en">Total</t>
        <t id="no">Total</t>
      </f>
    </g>
    <g id="total">
      <f id="PayableAmount">
        <t id="en">Payable</t>
        <t id="no">Payable</t>
      </f>
      <f id="PayableRoundingAmount">
        <t id="en">Rounding Amount</t>
        <t id="no">Avrunding</t>
      </f>
      <f id="PrepaidAmount">
        <t id="en">Prepaid</t>
        <t id="no">Forhåndsbetalt</t>
      </f>
      <f id="TaxExclusiveAmount">
        <t id="en">Tax Exclusive</t>
        <t id="no">Før MVA</t>
      </f>
      <f id="TaxInclusiveAmount">
        <t id="en">Tax Inclusive</t>
        <t id="no">Etter MVA</t>
      </f>
      <f id="Totals">
        <t id="en">Totals</t>
        <t id="no">Totaler</t>
      </f>
    </g>
  </xsl:variable>

  <!-- ============================================================ -->
  <!-- NAMED TEMPLATES (replacing XSLT 2.0 functions) -->
  <!-- ============================================================ -->

  <!-- u:codelist() → named template -->
  <xsl:template name="u-codelist">
    <xsl:param name="codelist"/>
    <xsl:param name="code"/>
    <xsl:variable name="cl-node" select="exsl:node-set($codelists)"/>
    <xsl:choose>
      <xsl:when test="$cl-node/cl[@id=$codelist]/c[@id=$code]/t[@id=$language]">
        <xsl:value-of select="$cl-node/cl[@id=$codelist]/c[@id=$code]/t[@id=$language]"/>
      </xsl:when>
      <xsl:otherwise>
        <span class="mtr">
          [code:<xsl:value-of select="$codelist"/>:<xsl:value-of select="$code"/>]
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- u:label() → named template -->
  <xsl:template name="u-label">
    <xsl:param name="part"/>
    <xsl:param name="value"/>
    <xsl:variable name="lb-node" select="exsl:node-set($labels)"/>
    <xsl:choose>
      <xsl:when test="$lb-node/g[@id=$part]/f[@id=$value]/t[@id=$language]">
        <xsl:value-of select="$lb-node/g[@id=$part]/f[@id=$value]/t[@id=$language]"/>
      </xsl:when>
      <xsl:otherwise>
        <span class="mtr">
          [label:<xsl:value-of select="$part"/>.<xsl:value-of select="$value"/>]
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- tokenize replacement (recursive) -->
  <xsl:template name="tokenize-newline">
    <xsl:param name="text"/>
    <xsl:param name="delimiter" select="'&#10;'"/>
    <xsl:choose>
      <xsl:when test="contains($text, $delimiter)">
        <xsl:value-of select="normalize-space(substring-before($text, $delimiter))"/>
        <br/>
        <xsl:call-template name="tokenize-newline">
          <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space($text)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- replace whitespace replacement (recursive) -->
  <xsl:template name="remove-whitespace">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text, ' ')">
        <xsl:call-template name="remove-whitespace">
          <xsl:with-param name="text" select="concat(substring-before($text, ' '), substring-after($text, ' '))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($text, '&#10;')">
        <xsl:call-template name="remove-whitespace">
          <xsl:with-param name="text" select="concat(substring-before($text, '&#10;'), substring-after($text, '&#10;'))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($text, '&#13;')">
        <xsl:call-template name="remove-whitespace">
          <xsl:with-param name="text" select="concat(substring-before($text, '&#13;'), substring-after($text, '&#13;'))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($text, '&#9;')">
        <xsl:call-template name="remove-whitespace">
          <xsl:with-param name="text" select="concat(substring-before($text, '&#9;'), substring-after($text, '&#9;'))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- DOC HEAD with MODERN CSS -->
  <!-- ============================================================ -->
  <xsl:template name="doc-head">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <xsl:choose>
      <xsl:when test="$stylesheet_url = 'NONE'">
        <style>
          :root {
          --color-primary: #2563eb;
          --color-primary-light: #dbeafe;
          --color-primary-dark: #1d4ed8;
          --color-success: #059669;
          --color-warning: #d97706;
          --color-danger: #dc2626;
          --color-gray-50: #f9fafb;
          --color-gray-100: #f3f4f6;
          --color-gray-200: #e5e7eb;
          --color-gray-300: #d1d5db;
          --color-gray-400: #9ca3af;
          --color-gray-500: #6b7280;
          --color-gray-600: #4b5563;
          --color-gray-700: #374151;
          --color-gray-800: #1f2937;
          --color-gray-900: #111827;
          --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
          --font-mono: 'JetBrains Mono', 'Fira Code', monospace;
          --radius-sm: 6px;
          --radius-md: 10px;
          --radius-lg: 16px;
          --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
          --shadow-md: 0 4px 6px -1px rgba(0,0,0,0.07), 0 2px 4px -2px rgba(0,0,0,0.05);
          --shadow-lg: 0 10px 15px -3px rgba(0,0,0,0.08), 0 4px 6px -4px rgba(0,0,0,0.04);
          --shadow-xl: 0 20px 25px -5px rgba(0,0,0,0.08), 0 8px 10px -6px rgba(0,0,0,0.04);
          --spacing-xs: 4px;
          --spacing-sm: 8px;
          --spacing-md: 16px;
          --spacing-lg: 24px;
          --spacing-xl: 32px;
          --spacing-2xl: 48px;
          }

          *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

          html { font-size: 16px; -webkit-text-size-adjust: 100%; scroll-behavior: smooth; }

          body {
          font-family: var(--font-sans);
          font-size: 0.9375rem;
          line-height: 1.6;
          color: var(--color-gray-800);
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          min-height: 100vh;
          padding: var(--spacing-xl) var(--spacing-md);
          }

          #document {
          max-width: 1100px;
          margin: 0 auto;
          background: #fff;
          border-radius: var(--radius-lg);
          box-shadow: var(--shadow-xl);
          padding: var(--spacing-2xl);
          position: relative;
          overflow: hidden;
          }

          #document::before {
          content: '';
          position: absolute;
          top: 0; left: 0; right: 0;
          height: 4px;
          background: linear-gradient(90deg, var(--color-primary), #7c3aed, #ec4899);
          }

          h1 {
          font-size: 2rem;
          font-weight: 800;
          color: var(--color-gray-900);
          margin-bottom: var(--spacing-lg);
          letter-spacing: -0.025em;
          line-height: 1.2;
          }

          h1 small {
          display: block;
          font-size: 0.875rem;
          font-weight: 500;
          color: var(--color-gray-500);
          margin-top: var(--spacing-xs);
          letter-spacing: 0;
          }

          h2 { font-size: 1.5rem; font-weight: 700; color: var(--color-gray-900); margin: var(--spacing-xl) 0 var(--spacing-md); }
          h3 {
          font-size: 0.8125rem;
          font-weight: 700;
          text-transform: uppercase;
          letter-spacing: 0.08em;
          color: var(--color-gray-500);
          margin-bottom: var(--spacing-md);
          padding-bottom: var(--spacing-sm);
          border-bottom: 2px solid var(--color-gray-100);
          }

          p { margin-bottom: var(--spacing-md); }
          a { color: var(--color-primary); text-decoration: none; transition: color 0.2s; }
          a:hover { color: var(--color-primary-dark); text-decoration: underline; }

          small, .small { font-size: 0.8125rem; color: var(--color-gray-500); }
          strong { font-weight: 600; }
          em { font-style: italic; color: var(--color-gray-600); }

          .mtr { color: var(--color-danger); font-family: var(--font-mono); font-size: 0.8125rem; }

          /* Layout */
          .row { display: flex; flex-wrap: wrap; margin: 0 calc(-1 * var(--spacing-md)); }
          .row > [class*="col-"] { padding: 0 var(--spacing-md); }
          .col-sm-2 { flex: 0 0 16.666%; max-width: 16.666%; }
          .col-sm-3 { flex: 0 0 25%; max-width: 25%; }
          .col-sm-4 { flex: 0 0 33.333%; max-width: 33.333%; }
          .col-sm-5 { flex: 0 0 41.666%; max-width: 41.666%; }
          .col-sm-6 { flex: 0 0 50%; max-width: 50%; }
          .col-sm-7 { flex: 0 0 58.333%; max-width: 58.333%; }
          .col-sm-8 { flex: 0 0 66.666%; max-width: 66.666%; }
          .col-sm-9 { flex: 0 0 75%; max-width: 75%; }
          .col-sm-10 { flex: 0 0 83.333%; max-width: 83.333%; }
          .col-sm-11 { flex: 0 0 91.666%; max-width: 91.666%; }
          .col-sm-12 { flex: 0 0 100%; max-width: 100%; }
          .col-md-5 { flex: 0 0 41.666%; max-width: 41.666%; }
          .col-md-7 { flex: 0 0 58.333%; max-width: 58.333%; }
          .col-xs-6 { flex: 0 0 50%; max-width: 50%; }

          @media (max-width: 768px) {
          .row { flex-direction: column; }
          .row > [class*="col-"] { flex: 0 0 100%; max-width: 100%; }
          #document { padding: var(--spacing-lg); border-radius: var(--radius-md); }
          body { padding: var(--spacing-md); }
          h1 { font-size: 1.5rem; }
          }

          /* Definition Lists */
          dl { margin-bottom: var(--spacing-md); }
          dt {
          font-size: 0.75rem;
          font-weight: 600;
          text-transform: uppercase;
          letter-spacing: 0.05em;
          color: var(--color-gray-500);
          margin-bottom: 2px;
          padding-top: var(--spacing-sm);
          }
          dd { margin-bottom: var(--spacing-sm); color: var(--color-gray-800); margin-left: 0; }

          /* Cards / Sections */
          #parties, #metadata, #totals, #delivery, #attachments, #tax, #payment {
          margin-bottom: var(--spacing-xl);
          }

          /* Tables */
          table {
          width: 100%;
          border-collapse: separate;
          border-spacing: 0;
          margin-bottom: var(--spacing-lg);
          border-radius: var(--radius-md);
          overflow: hidden;
          border: 1px solid var(--color-gray-200);
          }
          thead th {
          background: var(--color-gray-50);
          font-size: 0.75rem;
          font-weight: 700;
          text-transform: uppercase;
          letter-spacing: 0.05em;
          color: var(--color-gray-600);
          padding: var(--spacing-md);
          border-bottom: 2px solid var(--color-gray-200);
          text-align: left;
          }
          tbody td {
          padding: var(--spacing-sm) var(--spacing-md);
          border-bottom: 1px solid var(--color-gray-100);
          font-size: 0.875rem;
          }
          tbody tr:last-child td { border-bottom: none; }
          tbody tr:hover { background: var(--color-gray-50); }
          tfoot td {
          padding: var(--spacing-md);
          font-weight: 700;
          border-top: 2px solid var(--color-gray-200);
          background: var(--color-gray-50);
          }
          .text-right { text-align: right; }
          .text-center { text-align: center; }

          /* Line items */
          div.line {
          border: 1px solid var(--color-gray-200);
          border-radius: var(--radius-md);
          padding: var(--spacing-lg);
          margin-bottom: var(--spacing-md);
          background: #fff;
          transition: box-shadow 0.2s, border-color 0.2s;
          page-break-inside: avoid;
          }
          div.line:hover {
          border-color: var(--color-primary);
          box-shadow: var(--shadow-md);
          }
          div.line .number {
          display: inline-flex;
          align-items: center;
          justify-content: center;
          width: 32px; height: 32px;
          background: var(--color-primary-light);
          color: var(--color-primary);
          font-weight: 700;
          font-size: 0.8125rem;
          border-radius: 50%;
          margin-bottom: var(--spacing-sm);
          }

          div.linesupport {
          background: var(--color-gray-50);
          border-radius: var(--radius-sm);
          padding: var(--spacing-sm) var(--spacing-md);
          margin: var(--spacing-sm) 0;
          font-size: 0.8125rem;
          color: var(--color-gray-600);
          }

          div.linetotal {
          border-top: 1px solid var(--color-gray-200);
          padding-top: var(--spacing-md);
          margin-top: var(--spacing-md);
          }

          div.total {
          background: linear-gradient(135deg, var(--color-gray-50), var(--color-primary-light));
          border-radius: var(--radius-md);
          padding: var(--spacing-md) var(--spacing-lg);
          margin: var(--spacing-md) 0;
          font-weight: 700;
          border: 1px solid var(--color-gray-200);
          }

          /* Notes */
          p.note {
          font-style: italic;
          color: var(--color-gray-600);
          background: var(--color-gray-50);
          border-left: 3px solid var(--color-primary);
          padding: var(--spacing-sm) var(--spacing-md);
          border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
          margin: var(--spacing-sm) 0;
          font-size: 0.875rem;
          }

          /* Footer */
          #footer {
          margin-top: var(--spacing-2xl);
          padding-top: var(--spacing-lg);
          border-top: 1px solid var(--color-gray-200);
          font-size: 0.75rem;
          color: var(--color-gray-400);
          font-family: var(--font-mono);
          }

          /* Logo */
          #logo {
          max-height: 60px;
          max-width: 200px;
          float: right;
          margin-bottom: var(--spacing-md);
          }

          /* Attachments */
          #attachments ul { list-style: none; padding: 0; }
          #attachments ul li {
          padding: var(--spacing-sm) var(--spacing-md);
          border: 1px solid var(--color-gray-200);
          border-radius: var(--radius-sm);
          margin-bottom: var(--spacing-sm);
          font-size: 0.875rem;
          transition: background 0.2s;
          }
          #attachments ul li:hover { background: var(--color-gray-50); }

          /* Labels / Badges */
          .label {
          display: inline-block;
          padding: 2px 8px;
          font-size: 0.6875rem;
          font-weight: 600;
          border-radius: 9999px;
          text-transform: uppercase;
          letter-spacing: 0.03em;
          }

          /* Utility */
          .clearfix::after { content: ''; display: table; clear: both; }
          .pull-right { float: right; }
          .pull-left { float: left; }

          /* Print styles */
          @media print {
          body { background: #fff; padding: 0; }
          #document { box-shadow: none; border-radius: 0; padding: 20mm; max-width: 100%; }
          #document::before { display: none; }
          div.line:hover { border-color: var(--color-gray-200); box-shadow: none; }
          #footer { display: none; }
          a[href]::after { content: ''; }
          h3 { break-after: avoid; }
          div.line, tr { break-inside: avoid; }
          }

          /* Responsive helpers */
          @media (max-width: 576px) {
          .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6,
          .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11 {
          flex: 0 0 100%; max-width: 100%;
          }
          }
        </style>
      </xsl:when>
      <xsl:otherwise>
        <link rel="stylesheet" href="{$stylesheet_url}"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- DOC FOOTER -->
  <!-- ============================================================ -->
  <xsl:template name="doc-footer">
    <div id="footer">
      <div>
        Document: <xsl:value-of select="namespace-uri()"/>::<xsl:value-of select="local-name()"/>
      </div>
      <div>
        Customization: <xsl:value-of select="cbc:CustomizationID"/>
      </div>
      <div>
        Profile: <xsl:value-of select="cbc:ProfileID"/>
      </div>
    </div>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- ROOT TEMPLATE -->
  <!-- ============================================================ -->
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="$mode = 'document'">
        <xsl:apply-templates select="*" mode="document"/>
      </xsl:when>
      <xsl:when test="$mode = 'help'">
        <xsl:call-template name="mode_help"/>
      </xsl:when>
      <xsl:when test="$mode = 'translation'">
        <xsl:call-template name="mode_translation"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="mode_unknown"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- CREDIT NOTE TEMPLATE -->
  <!-- ============================================================ -->
  <xsl:template match="cn:CreditNote[starts-with(normalize-space(cbc:CustomizationID), 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0')]" mode="document" priority="1000">
    <html lang="{$language}">
      <head>
        <xsl:call-template name="doc-head"/>
        <title>
          <xsl:call-template name="u-label">
            <xsl:with-param name="part" select="'document'"/>
            <xsl:with-param name="value" select="local-name()"/>
          </xsl:call-template>
        </title>
      </head>
      <body>
        <div id="document">
          <h1>
            <xsl:call-template name="u-label">
              <xsl:with-param name="part" select="'document'"/>
              <xsl:with-param name="value" select="local-name()"/>
            </xsl:call-template>
            <br/>
            <small>
              <xsl:call-template name="u-codelist">
                <xsl:with-param name="codelist" select="'uncl1001-cn'"/>
                <xsl:with-param name="code" select="cbc:CreditNoteTypeCode"/>
              </xsl:call-template>
            </small>
          </h1>
          <div class="row">
            <div id="parties" class="col-sm-6 col-md-7">
              <h3>
                <xsl:call-template name="u-label">
                  <xsl:with-param name="part" select="'party'"/>
                  <xsl:with-param name="value" select="'Supplier'"/>
                </xsl:call-template>
              </h3>
              <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party" mode="party-with-contact"/>
              <h3>
                <xsl:call-template name="u-label">
                  <xsl:with-param name="part" select="'party'"/>
                  <xsl:with-param name="value" select="'Customer'"/>
                </xsl:call-template>
              </h3>
              <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party" mode="party-with-contact"/>
            </div>
            <div id="metadata" class="col-sm-6 col-md-5">
              <xsl:call-template name="metadata"/>
              <xsl:apply-templates select="cbc:Note" mode="common"/>
            </div>
          </div>
          <div class="row">
            <div id="totals" class="col-sm-4">
              <xsl:apply-templates select="cac:LegalMonetaryTotal" mode="total"/>
            </div>
            <div id="delivery" class="col-sm-4">
              <xsl:call-template name="delivery-block"/>
            </div>
            <div id="attachments" class="col-sm-4">
              <xsl:call-template name="attachments-block"/>
            </div>
          </div>
          <div class="row">
            <div id="tax" class="col-sm-6">
              <h3>
                <xsl:call-template name="u-label">
                  <xsl:with-param name="part" select="'tax'"/>
                  <xsl:with-param name="value" select="'Tax'"/>
                </xsl:call-template>
              </h3>
              <xsl:apply-templates select="cac:TaxTotal[cac:TaxSubtotal]" mode="tax"/>
              <xsl:apply-templates select="cac:TaxRepresentativeParty" mode="party"/>
            </div>
            <div id="payment" class="col-sm-6">
              <h3>
                <xsl:call-template name="u-label">
                  <xsl:with-param name="part" select="'payment'"/>
                  <xsl:with-param name="value" select="'Payment'"/>
                </xsl:call-template>
              </h3>
              <xsl:apply-templates select="cac:PaymentMeans" mode="payment"/>
              <xsl:apply-templates select="cac:PayeeParty" mode="party"/>
              <xsl:apply-templates select="cac:PaymentTerms" mode="payment"/>
            </div>
          </div>
          <hr style="border:none;border-top:1px solid var(--color-gray-200);margin:var(--spacing-xl) 0;"/>
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

  <!-- ============================================================ -->
  <!-- INVOICE TEMPLATE -->
  <!-- ============================================================ -->
  <xsl:template match="in:Invoice[starts-with(normalize-space(cbc:CustomizationID), 'urn:cen.eu:en16931:2017#compliant#urn:fdc:peppol.eu:2017:poacc:billing:3.0')]" mode="document" priority="1000">
    <html lang="{$language}">
      <head>
        <xsl:call-template name="doc-head"/>
        <title>
          <xsl:call-template name="u-label">
            <xsl:with-param name="part" select="'document'"/>
            <xsl:with-param name="value" select="local-name()"/>
          </xsl:call-template>
        </title>
      </head>
      <body>
        <div id="document">
          <h1>
            <xsl:call-template name="u-label">
              <xsl:with-param name="part" select="'document'"/>
              <xsl:with-param name="value" select="local-name()"/>
            </xsl:call-template>
            <br/>
            <small>
              <xsl:call-template name="u-codelist">
                <xsl:with-param name="codelist" select="'uncl1001invoice'"/>
                <xsl:with-param name="code" select="cbc:InvoiceTypeCode"/>
              </xsl:call-template>
            </small>
          </h1>
          <div class="row">
            <div id="parties" class="col-sm-6 col-md-7">
              <h3>
                <xsl:call-template name="u-label">
                  <xsl:with-param name="part" select="'party'"/>
                  <xsl:with-param name="value" select="'Supplier'"/>
                </xsl:call-template>
              </h3>
              <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party" mode="party-with-contact"/>
              <h3>
                <xsl:call-template name="u-label">
                  <xsl:with-param name="part" select="'party'"/>
                  <xsl:with-param name="value" select="'Customer'"/>
                </xsl:call-template>
              </h3>
              <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party" mode="party-with-contact"/>
            </div>
            <div id="metadata" class="col-sm-6 col-md-5">
              <xsl:call-template name="metadata"/>
              <xsl:apply-templates select="cbc:Note" mode="common"/>
            </div>
          </div>
          <div class="row">
            <div id="totals" class="col-sm-4">
              <xsl:apply-templates select="cac:LegalMonetaryTotal" mode="total"/>
            </div>
            <div id="delivery" class="col-sm-4">
              <xsl:call-template name="delivery-block"/>
            </div>
            <div id="attachments" class="col-sm-4">
              <xsl:call-template name="attachments-block"/>
            </div>
          </div>
          <div class="row">
            <div id="tax" class="col-sm-6">
              <h3>
                <xsl:call-template name="u-label">
                  <xsl:with-param name="part" select="'tax'"/>
                  <xsl:with-param name="value" select="'Tax'"/>
                </xsl:call-template>
              </h3>
              <xsl:apply-templates select="cac:TaxTotal[cac:TaxSubtotal]" mode="tax"/>
              <xsl:apply-templates select="cac:TaxRepresentativeParty" mode="party"/>
            </div>
            <div id="payment" class="col-sm-6">
              <h3>
                <xsl:call-template name="u-label">
                  <xsl:with-param name="part" select="'payment'"/>
                  <xsl:with-param name="value" select="'Payment'"/>
                </xsl:call-template>
              </h3>
              <xsl:apply-templates select="cac:PaymentMeans" mode="payment"/>
              <xsl:apply-templates select="cac:PayeeParty" mode="party"/>
              <xsl:apply-templates select="cac:PaymentTerms" mode="payment"/>
            </div>
          </div>
          <hr style="border:none;border-top:1px solid var(--color-gray-200);margin:var(--spacing-xl) 0;"/>
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

  <!-- ============================================================ -->
  <!-- HELP MODE -->
  <!-- ============================================================ -->
  <xsl:template name="mode_help">
    <html lang="en">
      <head>
        <xsl:call-template name="doc-head"/>
        <title>Help</title>
      </head>
      <body>
        <div id="document">
          <h1>Help</h1>
          <h2>Supported modes</h2>
          <ul>
            <li>
              <code>document</code> - Parsing of business document. (Default)
            </li>
            <li>
              <code>help</code> - Viewing this page.
            </li>
            <li>
              <code>translation</code> - List of all translatable strings.
            </li>
          </ul>
          <h2>Parameters</h2>
          <dl>
            <dt>download_attachment</dt>
            <dd>
              Default value: <code>false</code>
            </dd>
            <dt>language</dt>
            <dd>
              Default value: <code>en</code>
            </dd>
            <dt>mode</dt>
            <dd>
              Default value: <code>document</code>
            </dd>
            <dt>stylesheet_url</dt>
            <dd>
              Default value: <code>NONE</code>
            </dd>
          </dl>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- TRANSLATION MODE -->
  <!-- ============================================================ -->
  <xsl:template name="mode_translation">
    <html lang="en">
      <head>
        <xsl:call-template name="doc-head"/>
        <title>Translation</title>
      </head>
      <body>
        <div id="document">
          <h1>Translation</h1>
          <p>
            Use parameter <code>language</code> to change language.
          </p>
          <h2>Labels</h2>
          <ul style="list-style:none;padding:0;">
            <xsl:variable name="lb-node" select="exsl:node-set($labels)"/>
            <xsl:for-each select="$lb-node/g">
              <xsl:variable name="g" select="@id"/>
              <xsl:for-each select="f">
                <li>
                  <xsl:value-of select="$g"/>.<xsl:value-of select="@id"/> =
                  <xsl:call-template name="u-label">
                    <xsl:with-param name="part" select="$g"/>
                    <xsl:with-param name="value" select="@id"/>
                  </xsl:call-template>
                </li>
              </xsl:for-each>
            </xsl:for-each>
          </ul>
          <xsl:variable name="cl-node" select="exsl:node-set($codelists)"/>
          <xsl:for-each select="$cl-node/cl">
            <xsl:variable name="cl" select="@id"/>
            <h2>
              Codelist: <xsl:value-of select="@id"/>
            </h2>
            <ul style="list-style:none;padding:0;">
              <xsl:for-each select="c">
                <li>
                  <xsl:value-of select="@id"/> =
                  <xsl:call-template name="u-codelist">
                    <xsl:with-param name="codelist" select="$cl"/>
                    <xsl:with-param name="code" select="@id"/>
                  </xsl:call-template>
                </li>
              </xsl:for-each>
            </ul>
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- UNKNOWN MODE -->
  <!-- ============================================================ -->
  <xsl:template name="mode_unknown">
    <html lang="en">
      <head>
        <xsl:call-template name="doc-head"/>
        <title>Unknown mode</title>
      </head>
      <body>
        <div id="document">
          <h1>Unknown mode</h1>
          <p>
            Provided mode <code>
              <xsl:value-of select="$mode"/>
            </code> is unknown. Please use mode <code>help</code> for more information.
          </p>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- ATTACHMENTS -->
  <!-- ============================================================ -->
  <xsl:template name="attachments-block">
    <h3>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'attachments'"/>
        <xsl:with-param name="value" select="'Attachments'"/>
      </xsl:call-template>
    </h3>
    <xsl:choose>
      <xsl:when test="cac:AdditionalDocumentReference[cac:Attachment]">
        <ul>
          <xsl:apply-templates select="cac:AdditionalDocumentReference[cac:Attachment]" mode="attachment"/>
        </ul>
      </xsl:when>
      <xsl:otherwise>
        <em>No attachments provided.</em>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="cac:AdditionalDocumentReference[cac:Attachment]" mode="attachment">
    <li>
      <xsl:value-of select="cbc:ID"/>
      <xsl:if test="cbc:DocumentDescription">
        <br/>
        <small>
          <xsl:value-of select="cbc:DocumentDescription"/>
        </small>
      </xsl:if>
      <br/>
      <xsl:apply-templates select="cac:Attachment/*" mode="attachment"/>
    </li>
  </xsl:template>

  <xsl:template match="cac:ExternalReference" mode="attachment">
    <small>
      <a href="{cbc:URI}">
        <xsl:value-of select="cbc:URI"/>
      </a>
    </small>
  </xsl:template>

  <xsl:template match="cbc:EmbeddedDocumentBinaryObject" mode="attachment">
    <xsl:choose>
      <xsl:when test="$download_attachment = 'true'">
        <small>
          <a download="{@filename}">
            <xsl:attribute name="href">
              data:<xsl:value-of select="@mimeCode"/>;base64,<xsl:call-template name="remove-whitespace">
                <xsl:with-param name="text" select="text()"/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:call-template name="u-label">
              <xsl:with-param name="part" select="'attachments'"/>
              <xsl:with-param name="value" select="'Download'"/>
            </xsl:call-template>
            &#160;<xsl:value-of select="@filename"/>
          </a> (<xsl:value-of select="@mimeCode"/>)
        </small>
      </xsl:when>
      <xsl:otherwise>
        <small>
          <xsl:call-template name="u-label">
            <xsl:with-param name="part" select="'attachments'"/>
            <xsl:with-param name="value" select="'Embedded'"/>
          </xsl:call-template>: <xsl:value-of select="@filename"/> (<xsl:value-of select="@mimeCode"/>)
        </small>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="attachment"/>

  <!-- ============================================================ -->
  <!-- COMMON TEMPLATES -->
  <!-- ============================================================ -->
  <xsl:template match="cbc:ID" mode="common">
    <small>
      <xsl:value-of select="@schemeID"/>:
    </small>
    <xsl:value-of select="text()"/>
  </xsl:template>

  <xsl:template match="cbc:*[ends-with(local-name(), 'Amount')]" mode="common">
    <xsl:value-of select="format-number(text(), '###,##0.00')"/>&#160;<small>
      <xsl:value-of select="@currencyID"/>
    </small>
  </xsl:template>

  <xsl:template match="cac:*[ends-with(local-name(), 'Period')]" mode="common">
    <xsl:apply-templates select="cbc:StartDate" mode="common"/> - <xsl:apply-templates select="cbc:EndDate" mode="common"/>
  </xsl:template>

  <xsl:template match="cac:*[ends-with(local-name(), 'Date')]" mode="common">
    <xsl:value-of select="text()"/>
  </xsl:template>

  <xsl:template match="cac:*[ends-with(local-name(), 'TaxCategory')]" mode="common">
    <small>
      <xsl:value-of select="cac:TaxScheme/cbc:ID"/>:
    </small>
    <xsl:value-of select="cbc:ID"/>
    <small>
      &#160;(<xsl:value-of select="cbc:Percent"/>%)
    </small>
    <xsl:if test="cbc:TaxExemptionReason">
      <br/>
      <small>
        <xsl:value-of select="cbc:TaxExemptionReason"/>
      </small>
    </xsl:if>
  </xsl:template>

  <xsl:template match="cbc:*[ends-with(local-name(), 'Quantity')]" mode="common">
    <xsl:value-of select="text()"/>&#160;<small>
      <xsl:value-of select="@unitCode"/>
    </small>
  </xsl:template>

  <xsl:template match="cbc:Note" mode="common">
    <p class="note">
      <xsl:call-template name="tokenize-newline">
        <xsl:with-param name="text" select="text()"/>
      </xsl:call-template>
    </p>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- DELIVERY -->
  <!-- ============================================================ -->
  <xsl:template name="delivery-block">
    <h3>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'delivery'"/>
        <xsl:with-param name="value" select="'Delivery'"/>
      </xsl:call-template>
    </h3>
    <xsl:apply-templates select="cac:Delivery" mode="delivery"/>
  </xsl:template>

  <xsl:template match="cac:Delivery" mode="delivery">
    <div style="margin-bottom: var(--spacing-md);">
      <dl>
        <xsl:apply-templates select="cbc:ActualDeliveryDate" mode="delivery"/>
        <xsl:apply-templates select="cac:DeliveryLocation/cbc:ID" mode="delivery"/>
        <xsl:apply-templates select="cac:DeliveryLocation/cac:Address" mode="delivery"/>
      </dl>
    </div>
  </xsl:template>

  <xsl:template match="cbc:ActualDeliveryDate" mode="delivery">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'delivery'"/>
        <xsl:with-param name="value" select="'DeliveryDate'"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:value-of select="text()"/>
    </dd>
  </xsl:template>

  <xsl:template match="cbc:ID" mode="delivery">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'delivery'"/>
        <xsl:with-param name="value" select="'DeliveryID'"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:apply-templates select="current()" mode="common"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:Address" mode="delivery">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'delivery'"/>
        <xsl:with-param name="value" select="'Address'"/>
      </xsl:call-template>
    </dt>
    <dd>
      <div>
        <xsl:value-of select="cbc:StreetName"/>
      </div>
      <div>
        <xsl:value-of select="cbc:AdditionalStreetName"/>
      </div>
      <div>
        <span>
          <xsl:value-of select="cbc:PostalZone"/>
        </span>
        <span>&#160;</span>
        <span>
          <xsl:value-of select="cbc:CityName"/>
        </span>
      </div>
      <div>
        <xsl:value-of select="cbc:CountrySubentity"/>
      </div>
      <div>
        <xsl:call-template name="u-codelist">
          <xsl:with-param name="codelist" select="'iso3166'"/>
          <xsl:with-param name="code" select="cac:Country/cbc:IdentificationCode"/>
        </xsl:call-template>
      </div>
    </dd>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- ITEM TEMPLATES -->
  <!-- ============================================================ -->
  <xsl:template match="cac:Item" mode="item-info">
    <xsl:apply-templates select="cbc:Name" mode="item-info"/>
    <xsl:apply-templates select="cbc:Description" mode="item-info"/>
  </xsl:template>

  <xsl:template match="cbc:Name" mode="item-info">
    <div>
      <strong>
        <xsl:value-of select="text()"/>
      </strong>
    </div>
  </xsl:template>

  <xsl:template match="cbc:Description" mode="item-info">
    <div>
      <xsl:value-of select="text()"/>
    </div>
  </xsl:template>

  <xsl:template match="cac:Item" mode="item-details">
    <xsl:apply-templates select="*" mode="item-details"/>
  </xsl:template>

  <xsl:template match="cac:BuyersItemIdentification" mode="item-details">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'item'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:value-of select="cbc:ID"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:SellersItemIdentification" mode="item-details">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'item'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:value-of select="cbc:ID"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:StandardItemIdentification" mode="item-details">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'item'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:apply-templates select="cbc:ID" mode="common"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:CommodityClassification" mode="item-details">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'item'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <small>
        <xsl:value-of select="cbc:ItemClassificationCode/@listID"/>:
      </small>
      <xsl:value-of select="cbc:ItemClassificationCode"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:OriginCountry" mode="item-details">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'item'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:call-template name="u-codelist">
        <xsl:with-param name="codelist" select="'iso3166'"/>
        <xsl:with-param name="code" select="cbc:IdentificationCode"/>
      </xsl:call-template>
    </dd>
  </xsl:template>

  <xsl:template match="cac:ClassifiedTaxCategory | cbc:Name | cbc:Description | cac:AdditionalItemProperty" mode="item-details"/>

  <xsl:template match="*" mode="item-details">
    <div>
      [<xsl:value-of select="local-name()"/>]
    </div>
  </xsl:template>

  <xsl:template match="cac:AdditionalItemProperty" mode="item-properties">
    <dt>
      <xsl:value-of select="cbc:Name"/>
    </dt>
    <dd>
      <xsl:value-of select="cbc:Value"/>
    </dd>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- LINE TEMPLATES -->
  <!-- ============================================================ -->
  <xsl:template match="cac:AllowanceCharge[cbc:ChargeIndicator='false']" mode="line">
    <div class="row">
      <div class="col-sm-11">
        <xsl:value-of select="cbc:AllowanceChargeReason"/>
        <xsl:if test="cbc:AllowanceChargeReasonCode">
          &#160;<small>
            (<xsl:value-of select="cbc:AllowanceChargeReasonCode"/>)
          </small>
        </xsl:if>
      </div>
    </div>
    <div class="linetotal">
      <div class="row">
        <div class="col-sm-7">
          <xsl:call-template name="u-label">
            <xsl:with-param name="part" select="'line'"/>
            <xsl:with-param name="value" select="'Allowance'"/>
          </xsl:call-template>
        </div>
        <div class="col-sm-2">
          <xsl:apply-templates select="cac:TaxCategory" mode="common"/>
        </div>
        <div class="col-sm-2 text-right">
          -<xsl:apply-templates select="cbc:Amount" mode="common"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="cac:AllowanceCharge[cbc:ChargeIndicator='true']" mode="line">
    <div class="row">
      <div class="col-sm-11">
        <xsl:value-of select="cbc:AllowanceChargeReason"/>
        <xsl:if test="cbc:AllowanceChargeReasonCode">
          &#160;<small>
            (<xsl:value-of select="cbc:AllowanceChargeReasonCode"/>)
          </small>
        </xsl:if>
      </div>
    </div>
    <div class="linetotal">
      <div class="row">
        <div class="col-sm-7">
          <xsl:call-template name="u-label">
            <xsl:with-param name="part" select="'line'"/>
            <xsl:with-param name="value" select="'Charge'"/>
          </xsl:call-template>
        </div>
        <div class="col-sm-2">
          <xsl:apply-templates select="cac:TaxCategory" mode="common"/>
        </div>
        <div class="col-sm-2 text-right">
          <xsl:apply-templates select="cbc:Amount" mode="common"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="cac:InvoiceLine | cac:CreditNoteLine" mode="line">
    <div class="line">
      <div class="number">
        <xsl:value-of select="cbc:ID"/>
      </div>
      <div class="col-sm-10" style="flex:1;">
        <div class="row">
          <div class="info col-sm-6">
            <xsl:apply-templates select="cac:Item" mode="item-info"/>
            <xsl:apply-templates select="cbc:Note" mode="common"/>
            <xsl:if test="cac:InvoicePeriod | cac:OrderLineReference | cac:DocumentReference">
              <dl>
                <xsl:apply-templates select="cac:InvoicePeriod" mode="line"/>
                <xsl:if test="normalize-space(cac:OrderLineReference/cbc:LineID)">
                  <dt>
                    <xsl:call-template name="u-label">
                      <xsl:with-param name="part" select="'line'"/>
                      <xsl:with-param name="value" select="'OrderLineReference'"/>
                    </xsl:call-template>
                  </dt>
                  <dd>
                    <xsl:value-of select="cac:OrderLineReference/cbc:LineID"/>
                  </dd>
                </xsl:if>
                <xsl:apply-templates select="cac:DocumentReference" mode="line"/>
              </dl>
            </xsl:if>
          </div>
          <div class="details col-sm-6">
            <xsl:if test="cac:Item/cac:AdditionalItemProperty">
              <dl>
                <xsl:apply-templates select="cac:Item/cac:AdditionalItemProperty" mode="item-properties"/>
              </dl>
            </xsl:if>
            <dl>
              <xsl:apply-templates select="cac:Item" mode="item-details"/>
            </dl>
          </div>
        </div>
        <xsl:apply-templates select="cac:Price" mode="line"/>
        <xsl:apply-templates select="cac:AllowanceCharge" mode="line-ac"/>
      </div>
    </div>
    <div class="linetotal">
      <div class="row">
        <div class="col-sm-3">
          <xsl:apply-templates select="cbc:InvoicedQuantity" mode="common"/>
        </div>
        <div class="col-sm-4">
          <xsl:value-of select="cbc:AccountingCost"/>
        </div>
        <div class="col-sm-2">
          <xsl:apply-templates select="cac:Item/cac:ClassifiedTaxCategory" mode="common"/>
        </div>
        <div class="col-sm-2 text-right">
          <xsl:apply-templates select="cbc:LineExtensionAmount" mode="common"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="cac:InvoicePeriod" mode="line">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'line'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:apply-templates select="current()" mode="common"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:DocumentReference" mode="line">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'line'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:apply-templates select="cbc:ID" mode="common"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:Price" mode="line">
    <div class="linesupport">
      <div class="row">
        <div class="col-sm-9">
          Price á <xsl:apply-templates select="cbc:BaseQuantity" mode="common"/>
        </div>
        <div class="col-sm-3 text-right">
          <xsl:apply-templates select="cbc:PriceAmount" mode="common"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="cac:AllowanceCharge[cbc:ChargeIndicator='true']" mode="line-ac">
    <div class="linesupport">
      <div class="row">
        <div class="col-sm-9">
          <xsl:call-template name="u-label">
            <xsl:with-param name="part" select="'line'"/>
            <xsl:with-param name="value" select="'ChargeIncluded'"/>
          </xsl:call-template>: <xsl:value-of select="cbc:AllowanceChargeReason"/>
        </div>
        <div class="col-sm-3 text-right">
          <xsl:apply-templates select="cbc:Amount" mode="common"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="cac:AllowanceCharge[cbc:ChargeIndicator='false']" mode="line-ac">
    <div class="linesupport">
      <div class="row">
        <div class="col-sm-9">
          <xsl:call-template name="u-label">
            <xsl:with-param name="part" select="'line'"/>
            <xsl:with-param name="value" select="'AllowanceIncluded'"/>
          </xsl:call-template>: <xsl:value-of select="cbc:AllowanceChargeReason"/>
        </div>
        <div class="col-sm-3 text-right">
          -<xsl:apply-templates select="cbc:Amount" mode="common"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="cbc:LineExtensionAmount | cbc:ChargeTotalAmount" mode="line">
    <div class="total">
      <div class="row">
        <div class="col-xs-6 col-sm-8">
          <xsl:call-template name="u-label">
            <xsl:with-param name="part" select="'line'"/>
            <xsl:with-param name="value" select="local-name()"/>
          </xsl:call-template>
        </div>
        <div class="col-xs-6 col-sm-2 text-right">
          <xsl:apply-templates select="current()" mode="common"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="cbc:AllowanceTotalAmount" mode="line">
    <div class="total">
      <div class="row">
        <div class="col-xs-6 col-sm-8">
          <xsl:call-template name="u-label">
            <xsl:with-param name="part" select="'line'"/>
            <xsl:with-param name="value" select="local-name()"/>
          </xsl:call-template>
        </div>
        <div class="col-xs-6 col-sm-2 text-right">
          -<xsl:apply-templates select="current()" mode="common"/>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*" mode="line">
    <div>
      [<xsl:value-of select="local-name()"/>]
    </div>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- METADATA -->
  <!-- ============================================================ -->
  <xsl:template name="metadata">
    <h3>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'metadata'"/>
        <xsl:with-param name="value" select="'Metadata'"/>
      </xsl:call-template>
    </h3>
    <dl>
      <xsl:apply-templates select="cbc:ID" mode="metadata-detail"/>
      <xsl:apply-templates select="cbc:BuyerReference" mode="metadata-detail"/>
      <xsl:apply-templates select="cac:ProjectReference" mode="metadata-detail"/>
      <xsl:apply-templates select="cbc:IssueDate" mode="metadata-detail"/>
      <xsl:apply-templates select="cbc:DueDate" mode="metadata-detail"/>
      <xsl:apply-templates select="cbc:TaxPointDate" mode="metadata-detail"/>
      <xsl:apply-templates select="cac:InvoicePeriod" mode="metadata-detail"/>
      <xsl:apply-templates select="cbc:AccountingCost" mode="metadata-detail"/>
      <xsl:apply-templates select="cac:OrderReference" mode="metadata-detail"/>
      <xsl:apply-templates select="cac:BillingReference" mode="metadata-detail-exact"/>
      <xsl:apply-templates select="cac:DespatchDocumentReference" mode="metadata-detail"/>
      <xsl:apply-templates select="cac:ReceiptDocumentReference" mode="metadata-detail"/>
      <xsl:apply-templates select="cac:OriginatorDocumentReference" mode="metadata-detail"/>
      <xsl:apply-templates select="cac:ContractDocumentReference" mode="metadata-detail"/>
      <xsl:apply-templates select="cac:AdditionalDocumentReference[cbc:ID[@schemeID]]" mode="metadata-detail-exact"/>
      <xsl:apply-templates select="cbc:DocumentCurrencyCode" mode="metadata-detail"/>
      <xsl:apply-templates select="cbc:TaxCurrencyCode" mode="metadata-detail"/>
    </dl>
  </xsl:template>

  <xsl:template match="cac:BillingReference" mode="metadata-detail-exact">
    <xsl:for-each select="cac:InvoiceDocumentReference">
      <xsl:apply-templates select="." mode="metadata-detail"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="cac:AdditionalDocumentReference" mode="metadata-detail-exact">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'metadata'"/>
        <xsl:with-param name="value" select="'ObjectIdentifier'"/>
      </xsl:call-template>
    </dt>
    <dd>
      <small>
        <xsl:value-of select="cbc:ID/@schemeID"/>:
      </small>
      <xsl:value-of select="cbc:ID"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:*[ends-with(local-name(), 'Period')]" mode="metadata-detail">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'metadata'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:apply-templates select="current()" mode="common"/>
      <xsl:if test="cbc:DescriptionCode">
        <span>
          (<xsl:value-of select="cbc:DescriptionCode"/>)
        </span>
      </xsl:if>
    </dd>
  </xsl:template>

  <xsl:template match="cac:*[ends-with(local-name(), 'Reference')]" mode="metadata-detail">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'metadata'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:value-of select="cbc:ID"/>
      <xsl:if test="cbc:IssueDate">
        <span>
          (<xsl:value-of select="cbc:IssueDate"/>)
        </span>
      </xsl:if>
    </dd>
  </xsl:template>

  <xsl:template match="cbc:*" mode="metadata-detail">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'metadata'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:value-of select="text()"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:*" mode="metadata-detail">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'metadata'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:value-of select="."/>
    </dd>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- PARTY TEMPLATES -->
  <!-- ============================================================ -->
  <xsl:template match="cac:Party | cac:PayeeParty | cac:TaxRepresentativeParty" mode="party-with-contact">
    <div class="row" style="margin-bottom:var(--spacing-md);">
      <div class="col-md-7">
        <xsl:if test="cac:PartyName | cac:PostalAddress">
          <div style="margin-bottom: var(--spacing-md);">
            <xsl:apply-templates select="cac:PartyName" mode="party"/>
            <xsl:apply-templates select="cac:PostalAddress" mode="party"/>
          </div>
        </xsl:if>
        <xsl:if test="cac:PartyLegalEntity">
          <div style="margin-bottom: var(--spacing-md);">
            <xsl:apply-templates select="cac:PartyLegalEntity" mode="party"/>
          </div>
        </xsl:if>
      </div>
      <div class="col-md-5">
        <xsl:apply-templates select="cac:Contact" mode="party"/>
      </div>
    </div>
    <xsl:if test="cbc:EndpointID | cac:PartyLegalEntity/cbc:CompanyID | cac:PartyIdentification | cac:PartyTaxScheme">
      <dl style="margin-bottom: var(--spacing-md);">
        <xsl:apply-templates select="cac:PartyIdentification[cbc:ID[@schemeID]]" mode="party"/>
        <xsl:apply-templates select="cac:PartyIdentification[cbc:ID[not(@schemeID)]]" mode="party"/>
        <xsl:apply-templates select="cac:PartyTaxScheme" mode="party"/>
        <xsl:apply-templates select="cbc:EndpointID" mode="party"/>
      </dl>
    </xsl:if>
  </xsl:template>

  <xsl:template match="cac:Party | cac:PayeeParty | cac:TaxRepresentativeParty" mode="party">
    <xsl:if test="cac:PartyName | cac:PostalAddress">
      <div style="margin-bottom: var(--spacing-md);">
        <xsl:apply-templates select="cac:PartyName" mode="party"/>
        <xsl:apply-templates select="cac:PartyLegalEntity/cbc:RegistrationName" mode="party"/>
        <xsl:apply-templates select="cac:PostalAddress" mode="party"/>
      </div>
    </xsl:if>
    <xsl:if test="cbc:EndpointID | cac:PartyIdentification | cac:PartyTaxScheme">
      <dl style="margin-bottom: var(--spacing-md);">
        <xsl:apply-templates select="cac:PartyLegalEntity/cbc:CompanyID" mode="party"/>
        <xsl:apply-templates select="cac:PartyIdentification[cbc:ID[@schemeID]]" mode="party"/>
        <xsl:apply-templates select="cac:PartyIdentification[cbc:ID[not(@schemeID)]]" mode="party"/>
        <xsl:apply-templates select="cac:PartyTaxScheme" mode="party"/>
        <xsl:apply-templates select="cbc:EndpointID" mode="party"/>
      </dl>
    </xsl:if>
  </xsl:template>

  <xsl:template match="cac:PartyName" mode="party">
    <div>
      <strong>
        <xsl:value-of select="cbc:Name"/>
      </strong>
    </div>
  </xsl:template>

  <xsl:template match="cac:PostalAddress" mode="party">
    <xsl:if test="cbc:StreetName">
      <div>
        <xsl:value-of select="cbc:StreetName"/>
      </div>
    </xsl:if>
    <xsl:if test="cbc:AdditionalStreetName">
      <div>
        <xsl:value-of select="cbc:AdditionalStreetName"/>
      </div>
    </xsl:if>
    <xsl:if test="cac:AddressLine">
      <xsl:for-each select="cac:AddressLine">
        <div>
          <xsl:value-of select="cbc:Line"/>
        </div>
      </xsl:for-each>
    </xsl:if>
    <xsl:if test="cbc:PostalZone and cbc:CityName">
      <div>
        <span>
          <xsl:value-of select="cbc:PostalZone"/>
        </span>
        <span>&#160;</span>
        <span>
          <xsl:value-of select="cbc:CityName"/>
        </span>
      </div>
    </xsl:if>
    <xsl:if test="cbc:CountrySubentity">
      <div>
        <xsl:value-of select="cbc:CountrySubentity"/>
      </div>
    </xsl:if>
    <xsl:if test="cac:Country">
      <div>
        <xsl:call-template name="u-codelist">
          <xsl:with-param name="codelist" select="'iso3166'"/>
          <xsl:with-param name="code" select="cac:Country/cbc:IdentificationCode"/>
        </xsl:call-template>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="cac:PartyIdentification[cbc:ID[@schemeID]]" mode="party">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'party'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:apply-templates select="cbc:ID" mode="common"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:PartyIdentification[cbc:ID[not(@schemeID)]]" mode="party">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'party'"/>
        <xsl:with-param name="value" select="'BankingReference'"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:value-of select="cbc:ID"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:PartyLegalEntity" mode="party">
    <div>
      <strong>
        <xsl:value-of select="cbc:RegistrationName"/>
      </strong> (<xsl:value-of select="cbc:CompanyLegalForm"/>)
    </div>
    <div>
      <small>
        <xsl:value-of select="cbc:CompanyID/@schemeID"/>:
      </small>
      <xsl:value-of select="cbc:CompanyID"/>
    </div>
  </xsl:template>

  <xsl:template match="cac:PartyLegalEntity/cbc:CompanyID" mode="party">
    <dt>Legal Company Identifier</dt>
    <dd>
      <xsl:value-of select="text()"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:PartyTaxScheme" mode="party">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'party'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <small>
        <xsl:value-of select="cac:TaxScheme/cbc:ID"/>:
      </small>
      <xsl:value-of select="cbc:CompanyID"/>
    </dd>
  </xsl:template>

  <xsl:template match="cbc:EndpointID" mode="party">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'party'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <small>
        <xsl:value-of select="@schemeID"/>:
      </small>
      <xsl:value-of select="text()"/>
    </dd>
  </xsl:template>

  <xsl:template match="cac:Contact" mode="party">
    <div style="margin-bottom: var(--spacing-md);">
      <div>
        <xsl:value-of select="cbc:Name"/>
      </div>
      <div>
        tlf: <xsl:value-of select="cbc:Telephone"/>
      </div>
      <div>
        <a href="mailto:{cbc:ElectronicMail}">
          <xsl:value-of select="cbc:ElectronicMail"/>
        </a>
      </div>
    </div>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- PAYMENT -->
  <!-- ============================================================ -->
  <xsl:template match="cac:PaymentMeans" mode="payment">
    <div class="row" style="margin-bottom:var(--spacing-md);">
      <div class="col-sm-2">
        <xsl:value-of select="cbc:PaymentMeansCode"/>
      </div>
      <div class="col-sm-10" style="flex:1;">
        <dl>
          <dt>PaymentID</dt>
          <dd>
            <xsl:value-of select="cbc:PaymentID"/>
          </dd>
          <dt>Account</dt>
          <dd>
            <xsl:value-of select="cac:PayeeFinancialAccount/cbc:ID"/> (<xsl:value-of select="cac:PayeeFinancialAccount/cac:FinancialInstitutionBranch/cbc:ID"/>)
          </dd>
        </dl>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="cac:PaymentTerms" mode="payment">
    <xsl:apply-templates select="cbc:Note" mode="common"/>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- TAX -->
  <!-- ============================================================ -->
  <xsl:template match="cac:TaxTotal" mode="tax">
    <table>
      <thead>
        <tr>
          <th>
            <xsl:call-template name="u-label">
              <xsl:with-param name="part" select="'tax'"/>
              <xsl:with-param name="value" select="'Category'"/>
            </xsl:call-template>
          </th>
          <th style="width:20%;">
            <xsl:call-template name="u-label">
              <xsl:with-param name="part" select="'tax'"/>
              <xsl:with-param name="value" select="'TaxableAmount'"/>
            </xsl:call-template>
          </th>
          <th style="width:20%;">
            <xsl:call-template name="u-label">
              <xsl:with-param name="part" select="'tax'"/>
              <xsl:with-param name="value" select="'TaxAmount'"/>
            </xsl:call-template>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="cac:TaxSubtotal" mode="tax"/>
      </tbody>
      <tfoot>
        <xsl:apply-templates select="cbc:TaxAmount" mode="tax"/>
        <xsl:apply-templates select="../cac:TaxTotal[not(cac:TaxSubtotal)]/cbc:TaxAmount" mode="tax"/>
      </tfoot>
    </table>
  </xsl:template>

  <xsl:template match="cac:TaxSubtotal" mode="tax">
    <tr>
      <td>
        <xsl:apply-templates select="cac:TaxCategory" mode="common"/>
      </td>
      <td class="text-right">
        <xsl:apply-templates select="cbc:TaxableAmount" mode="common"/>
      </td>
      <td class="text-right">
        <xsl:apply-templates select="cbc:TaxAmount" mode="common"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="cbc:TaxAmount" mode="tax">
    <tr>
      <td colspan="2">
        <xsl:call-template name="u-label">
          <xsl:with-param name="part" select="'tax'"/>
          <xsl:with-param name="value" select="'Total'"/>
        </xsl:call-template>
      </td>
      <td class="text-right">
        <xsl:apply-templates select="." mode="common"/>
      </td>
    </tr>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- TOTALS -->
  <!-- ============================================================ -->
  <xsl:template match="cac:LegalMonetaryTotal" mode="total">
    <h3>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'total'"/>
        <xsl:with-param name="value" select="'Totals'"/>
      </xsl:call-template>
    </h3>
    <dl>
      <xsl:apply-templates select="cbc:TaxExclusiveAmount | cbc:TaxInclusiveAmount | cbc:PrepaidAmount | cbc:PayableRoundingAmount | cbc:PayableAmount" mode="total"/>
    </dl>
  </xsl:template>

  <xsl:template match="cbc:PayableAmount" mode="total">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'total'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <strong>
        <xsl:apply-templates select="current()" mode="common"/>
      </strong>
    </dd>
  </xsl:template>

  <xsl:template match="cbc:*" mode="total">
    <dt>
      <xsl:call-template name="u-label">
        <xsl:with-param name="part" select="'total'"/>
        <xsl:with-param name="value" select="local-name()"/>
      </xsl:call-template>
    </dt>
    <dd>
      <xsl:apply-templates select="current()" mode="common"/>
    </dd>
  </xsl:template>

  <!-- ============================================================ -->
  <!-- UNKNOWN DOCUMENT -->
  <!-- ============================================================ -->
  <xsl:template match="*" mode="document">
    <html lang="{$language}">
      <head>
        <xsl:call-template name="doc-head"/>
        <title>Unknown document type</title>
      </head>
      <body>
        <div id="document">
          <h1>Unknown document type</h1>
          <p>The document you tried to render was not recognized.</p>
        </div>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>