//
//  CurrencyCode.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

extension Storefront {
	/// Currency codes 
	public enum CurrencyCode: String {
		/// United Arab Emirates Dirham (AED) 
		case aed = "AED"

		/// Afghan Afghani (AFN) 
		case afn = "AFN"

		/// Albanian Lek (ALL) 
		case all = "ALL"

		/// Armenian Dram (AMD) 
		case amd = "AMD"

		/// Netherlands Antillean Guilder 
		case ang = "ANG"

		/// Angolan Kwanza (AOA) 
		case aoa = "AOA"

		/// Argentine Pesos (ARS) 
		case ars = "ARS"

		/// Australian Dollars (AUD) 
		case aud = "AUD"

		/// Aruban Florin (AWG) 
		case awg = "AWG"

		/// Azerbaijani Manat (AZN) 
		case azn = "AZN"

		/// Bosnia and Herzegovina Convertible Mark (BAM) 
		case bam = "BAM"

		/// Barbadian Dollar (BBD) 
		case bbd = "BBD"

		/// Bangladesh Taka (BDT) 
		case bdt = "BDT"

		/// Bulgarian Lev (BGN) 
		case bgn = "BGN"

		/// Bahraini Dinar (BHD) 
		case bhd = "BHD"

		/// Brunei Dollar (BND) 
		case bnd = "BND"

		/// Bolivian Boliviano (BOB) 
		case bob = "BOB"

		/// Brazilian Real (BRL) 
		case brl = "BRL"

		/// Bahamian Dollar (BSD) 
		case bsd = "BSD"

		/// Bhutanese Ngultrum (BTN) 
		case btn = "BTN"

		/// Botswana Pula (BWP) 
		case bwp = "BWP"

		/// Belarusian Ruble (BYR) 
		case byr = "BYR"

		/// Belize Dollar (BZD) 
		case bzd = "BZD"

		/// Canadian Dollars (CAD) 
		case cad = "CAD"

		/// Congolese franc (CDF) 
		case cdf = "CDF"

		/// Swiss Francs (CHF) 
		case chf = "CHF"

		/// Chilean Peso (CLP) 
		case clp = "CLP"

		/// Chinese Yuan Renminbi (CNY) 
		case cny = "CNY"

		/// Colombian Peso (COP) 
		case cop = "COP"

		/// Costa Rican Colones (CRC) 
		case crc = "CRC"

		/// Cape Verdean escudo (CVE) 
		case cve = "CVE"

		/// Czech Koruny (CZK) 
		case czk = "CZK"

		/// Danish Kroner (DKK) 
		case dkk = "DKK"

		/// Dominican Peso (DOP) 
		case dop = "DOP"

		/// Algerian Dinar (DZD) 
		case dzd = "DZD"

		/// Egyptian Pound (EGP) 
		case egp = "EGP"

		/// Ethiopian Birr (ETB) 
		case etb = "ETB"

		/// Euro (EUR) 
		case eur = "EUR"

		/// Fijian Dollars (FJD) 
		case fjd = "FJD"

		/// United Kingdom Pounds (GBP) 
		case gbp = "GBP"

		/// Georgian Lari (GEL) 
		case gel = "GEL"

		/// Ghanaian Cedi (GHS) 
		case ghs = "GHS"

		/// Gambian Dalasi (GMD) 
		case gmd = "GMD"

		/// Guatemalan Quetzal (GTQ) 
		case gtq = "GTQ"

		/// Guyanese Dollar (GYD) 
		case gyd = "GYD"

		/// Hong Kong Dollars (HKD) 
		case hkd = "HKD"

		/// Honduran Lempira (HNL) 
		case hnl = "HNL"

		/// Croatian Kuna (HRK) 
		case hrk = "HRK"

		/// Haitian Gourde (HTG) 
		case htg = "HTG"

		/// Hungarian Forint (HUF) 
		case huf = "HUF"

		/// Indonesian Rupiah (IDR) 
		case idr = "IDR"

		/// Israeli New Shekel (NIS) 
		case ils = "ILS"

		/// Indian Rupees (INR) 
		case inr = "INR"

		/// Icelandic Kronur (ISK) 
		case isk = "ISK"

		/// Jersey Pound 
		case jep = "JEP"

		/// Jamaican Dollars (JMD) 
		case jmd = "JMD"

		/// Jordanian Dinar (JOD) 
		case jod = "JOD"

		/// Japanese Yen (JPY) 
		case jpy = "JPY"

		/// Kenyan Shilling (KES) 
		case kes = "KES"

		/// Kyrgyzstani Som (KGS) 
		case kgs = "KGS"

		/// Cambodian Riel 
		case khr = "KHR"

		/// Comorian Franc (KMF) 
		case kmf = "KMF"

		/// South Korean Won (KRW) 
		case krw = "KRW"

		/// Kuwaiti Dinar (KWD) 
		case kwd = "KWD"

		/// Cayman Dollars (KYD) 
		case kyd = "KYD"

		/// Kazakhstani Tenge (KZT) 
		case kzt = "KZT"

		/// Laotian Kip (LAK) 
		case lak = "LAK"

		/// Lebanese Pounds (LBP) 
		case lbp = "LBP"

		/// Sri Lankan Rupees (LKR) 
		case lkr = "LKR"

		/// Liberian Dollar (LRD) 
		case lrd = "LRD"

		/// Lesotho Loti (LSL) 
		case lsl = "LSL"

		/// Lithuanian Litai (LTL) 
		case ltl = "LTL"

		/// Latvian Lati (LVL) 
		case lvl = "LVL"

		/// Moroccan Dirham 
		case mad = "MAD"

		/// Moldovan Leu (MDL) 
		case mdl = "MDL"

		/// Malagasy Ariary (MGA) 
		case mga = "MGA"

		/// Macedonia Denar (MKD) 
		case mkd = "MKD"

		/// Burmese Kyat (MMK) 
		case mmk = "MMK"

		/// Mongolian Tugrik 
		case mnt = "MNT"

		/// Macanese Pataca (MOP) 
		case mop = "MOP"

		/// Mauritian Rupee (MUR) 
		case mur = "MUR"

		/// Maldivian Rufiyaa (MVR) 
		case mvr = "MVR"

		/// Malawian Kwacha (MWK) 
		case mwk = "MWK"

		/// Mexican Pesos (MXN) 
		case mxn = "MXN"

		/// Malaysian Ringgits (MYR) 
		case myr = "MYR"

		/// Mozambican Metical 
		case mzn = "MZN"

		/// Namibian Dollar 
		case nad = "NAD"

		/// Nigerian Naira (NGN) 
		case ngn = "NGN"

		/// Nicaraguan Córdoba (NIO) 
		case nio = "NIO"

		/// Norwegian Kroner (NOK) 
		case nok = "NOK"

		/// Nepalese Rupee (NPR) 
		case npr = "NPR"

		/// New Zealand Dollars (NZD) 
		case nzd = "NZD"

		/// Omani Rial (OMR) 
		case omr = "OMR"

		/// Peruvian Nuevo Sol (PEN) 
		case pen = "PEN"

		/// Papua New Guinean Kina (PGK) 
		case pgk = "PGK"

		/// Philippine Peso (PHP) 
		case php = "PHP"

		/// Pakistani Rupee (PKR) 
		case pkr = "PKR"

		/// Polish Zlotych (PLN) 
		case pln = "PLN"

		/// Paraguayan Guarani (PYG) 
		case pyg = "PYG"

		/// Qatari Rial (QAR) 
		case qar = "QAR"

		/// Romanian Lei (RON) 
		case ron = "RON"

		/// Serbian dinar (RSD) 
		case rsd = "RSD"

		/// Russian Rubles (RUB) 
		case rub = "RUB"

		/// Rwandan Franc (RWF) 
		case rwf = "RWF"

		/// Saudi Riyal (SAR) 
		case sar = "SAR"

		/// Solomon Islands Dollar (SBD) 
		case sbd = "SBD"

		/// Seychellois Rupee (SCR) 
		case scr = "SCR"

		/// Sudanese Pound (SDG) 
		case sdg = "SDG"

		/// Swedish Kronor (SEK) 
		case sek = "SEK"

		/// Singapore Dollars (SGD) 
		case sgd = "SGD"

		/// Surinamese Dollar (SRD) 
		case srd = "SRD"

		/// South Sudanese Pound (SSP) 
		case ssp = "SSP"

		/// Sao Tome And Principe Dobra (STD) 
		case std = "STD"

		/// Syrian Pound (SYP) 
		case syp = "SYP"

		/// Thai baht (THB) 
		case thb = "THB"

		/// Turkmenistani Manat (TMT) 
		case tmt = "TMT"

		/// Tunisian Dinar (TND) 
		case tnd = "TND"

		/// Turkish Lira (TRY) 
		case `try` = "TRY"

		/// Trinidad and Tobago Dollars (TTD) 
		case ttd = "TTD"

		/// Taiwan Dollars (TWD) 
		case twd = "TWD"

		/// Tanzanian Shilling (TZS) 
		case tzs = "TZS"

		/// Ukrainian Hryvnia (UAH) 
		case uah = "UAH"

		/// Ugandan Shilling (UGX) 
		case ugx = "UGX"

		/// United States Dollars (USD) 
		case usd = "USD"

		/// Uruguayan Pesos (UYU) 
		case uyu = "UYU"

		/// Uzbekistan som (UZS) 
		case uzs = "UZS"

		/// Venezuelan Bolivares (VEF) 
		case vef = "VEF"

		/// Vietnamese đồng (VND) 
		case vnd = "VND"

		/// Vanuatu Vatu (VUV) 
		case vuv = "VUV"

		/// Samoan Tala (WST) 
		case wst = "WST"

		/// Central African CFA Franc (XAF) 
		case xaf = "XAF"

		/// East Caribbean Dollar (XCD) 
		case xcd = "XCD"

		/// West African CFA franc (XOF) 
		case xof = "XOF"

		/// CFP Franc (XPF) 
		case xpf = "XPF"

		/// Yemeni Rial (YER) 
		case yer = "YER"

		/// South African Rand (ZAR) 
		case zar = "ZAR"

		/// Zambian Kwacha (ZMW) 
		case zmw = "ZMW"

		case unknownValue = ""
	}
}
