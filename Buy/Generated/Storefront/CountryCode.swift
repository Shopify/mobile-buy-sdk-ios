//
//  CountryCode.swift
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
	/// ISO 3166-1 alpha-2 country codes with some differences. 
	public enum CountryCode: String {
		/// Andorra. 
		case ad = "AD"

		/// United Arab Emirates. 
		case ae = "AE"

		/// Afghanistan. 
		case af = "AF"

		/// Antigua & Barbuda. 
		case ag = "AG"

		/// Anguilla. 
		case ai = "AI"

		/// Albania. 
		case al = "AL"

		/// Armenia. 
		case am = "AM"

		/// Netherlands Antilles. 
		case an = "AN"

		/// Angola. 
		case ao = "AO"

		/// Argentina. 
		case ar = "AR"

		/// Austria. 
		case at = "AT"

		/// Australia. 
		case au = "AU"

		/// Aruba. 
		case aw = "AW"

		/// Åland Islands. 
		case ax = "AX"

		/// Azerbaijan. 
		case az = "AZ"

		/// Bosnia & Herzegovina. 
		case ba = "BA"

		/// Barbados. 
		case bb = "BB"

		/// Bangladesh. 
		case bd = "BD"

		/// Belgium. 
		case be = "BE"

		/// Burkina Faso. 
		case bf = "BF"

		/// Bulgaria. 
		case bg = "BG"

		/// Bahrain. 
		case bh = "BH"

		/// Burundi. 
		case bi = "BI"

		/// Benin. 
		case bj = "BJ"

		/// St. Barthélemy. 
		case bl = "BL"

		/// Bermuda. 
		case bm = "BM"

		/// Brunei. 
		case bn = "BN"

		/// Bolivia. 
		case bo = "BO"

		/// Caribbean Netherlands. 
		case bq = "BQ"

		/// Brazil. 
		case br = "BR"

		/// Bahamas. 
		case bs = "BS"

		/// Bhutan. 
		case bt = "BT"

		/// Bouvet Island. 
		case bv = "BV"

		/// Botswana. 
		case bw = "BW"

		/// Belarus. 
		case by = "BY"

		/// Belize. 
		case bz = "BZ"

		/// Canada. 
		case ca = "CA"

		/// Cocos (Keeling) Islands. 
		case cc = "CC"

		/// Congo - Kinshasa. 
		case cd = "CD"

		/// Central African Republic. 
		case cf = "CF"

		/// Congo - Brazzaville. 
		case cg = "CG"

		/// Switzerland. 
		case ch = "CH"

		/// Côte d’Ivoire. 
		case ci = "CI"

		/// Cook Islands. 
		case ck = "CK"

		/// Chile. 
		case cl = "CL"

		/// Cameroon. 
		case cm = "CM"

		/// China. 
		case cn = "CN"

		/// Colombia. 
		case co = "CO"

		/// Costa Rica. 
		case cr = "CR"

		/// Cuba. 
		case cu = "CU"

		/// Cape Verde. 
		case cv = "CV"

		/// Curaçao. 
		case cw = "CW"

		/// Christmas Island. 
		case cx = "CX"

		/// Cyprus. 
		case cy = "CY"

		/// Czechia. 
		case cz = "CZ"

		/// Germany. 
		case de = "DE"

		/// Djibouti. 
		case dj = "DJ"

		/// Denmark. 
		case dk = "DK"

		/// Dominica. 
		case dm = "DM"

		/// Dominican Republic. 
		case `do` = "DO"

		/// Algeria. 
		case dz = "DZ"

		/// Ecuador. 
		case ec = "EC"

		/// Estonia. 
		case ee = "EE"

		/// Egypt. 
		case eg = "EG"

		/// Western Sahara. 
		case eh = "EH"

		/// Eritrea. 
		case er = "ER"

		/// Spain. 
		case es = "ES"

		/// Ethiopia. 
		case et = "ET"

		/// Finland. 
		case fi = "FI"

		/// Fiji. 
		case fj = "FJ"

		/// Falkland Islands. 
		case fk = "FK"

		/// Faroe Islands. 
		case fo = "FO"

		/// France. 
		case fr = "FR"

		/// Gabon. 
		case ga = "GA"

		/// United Kingdom. 
		case gb = "GB"

		/// Grenada. 
		case gd = "GD"

		/// Georgia. 
		case ge = "GE"

		/// French Guiana. 
		case gf = "GF"

		/// Guernsey. 
		case gg = "GG"

		/// Ghana. 
		case gh = "GH"

		/// Gibraltar. 
		case gi = "GI"

		/// Greenland. 
		case gl = "GL"

		/// Gambia. 
		case gm = "GM"

		/// Guinea. 
		case gn = "GN"

		/// Guadeloupe. 
		case gp = "GP"

		/// Equatorial Guinea. 
		case gq = "GQ"

		/// Greece. 
		case gr = "GR"

		/// South Georgia & South Sandwich Islands. 
		case gs = "GS"

		/// Guatemala. 
		case gt = "GT"

		/// Guinea-Bissau. 
		case gw = "GW"

		/// Guyana. 
		case gy = "GY"

		/// Hong Kong SAR China. 
		case hk = "HK"

		/// Heard & McDonald Islands. 
		case hm = "HM"

		/// Honduras. 
		case hn = "HN"

		/// Croatia. 
		case hr = "HR"

		/// Haiti. 
		case ht = "HT"

		/// Hungary. 
		case hu = "HU"

		/// Indonesia. 
		case id = "ID"

		/// Ireland. 
		case ie = "IE"

		/// Israel. 
		case il = "IL"

		/// Isle of Man. 
		case im = "IM"

		/// India. 
		case `in` = "IN"

		/// British Indian Ocean Territory. 
		case io = "IO"

		/// Iraq. 
		case iq = "IQ"

		/// Iran. 
		case ir = "IR"

		/// Iceland. 
		case `is` = "IS"

		/// Italy. 
		case it = "IT"

		/// Jersey. 
		case je = "JE"

		/// Jamaica. 
		case jm = "JM"

		/// Jordan. 
		case jo = "JO"

		/// Japan. 
		case jp = "JP"

		/// Kenya. 
		case ke = "KE"

		/// Kyrgyzstan. 
		case kg = "KG"

		/// Cambodia. 
		case kh = "KH"

		/// Kiribati. 
		case ki = "KI"

		/// Comoros. 
		case km = "KM"

		/// St. Kitts & Nevis. 
		case kn = "KN"

		/// North Korea. 
		case kp = "KP"

		/// South Korea. 
		case kr = "KR"

		/// Kuwait. 
		case kw = "KW"

		/// Cayman Islands. 
		case ky = "KY"

		/// Kazakhstan. 
		case kz = "KZ"

		/// Laos. 
		case la = "LA"

		/// Lebanon. 
		case lb = "LB"

		/// St. Lucia. 
		case lc = "LC"

		/// Liechtenstein. 
		case li = "LI"

		/// Sri Lanka. 
		case lk = "LK"

		/// Liberia. 
		case lr = "LR"

		/// Lesotho. 
		case ls = "LS"

		/// Lithuania. 
		case lt = "LT"

		/// Luxembourg. 
		case lu = "LU"

		/// Latvia. 
		case lv = "LV"

		/// Libya. 
		case ly = "LY"

		/// Morocco. 
		case ma = "MA"

		/// Monaco. 
		case mc = "MC"

		/// Moldova. 
		case md = "MD"

		/// Montenegro. 
		case me = "ME"

		/// St. Martin. 
		case mf = "MF"

		/// Madagascar. 
		case mg = "MG"

		/// North Macedonia. 
		case mk = "MK"

		/// Mali. 
		case ml = "ML"

		/// Myanmar (Burma). 
		case mm = "MM"

		/// Mongolia. 
		case mn = "MN"

		/// Macao SAR China. 
		case mo = "MO"

		/// Martinique. 
		case mq = "MQ"

		/// Mauritania. 
		case mr = "MR"

		/// Montserrat. 
		case ms = "MS"

		/// Malta. 
		case mt = "MT"

		/// Mauritius. 
		case mu = "MU"

		/// Maldives. 
		case mv = "MV"

		/// Malawi. 
		case mw = "MW"

		/// Mexico. 
		case mx = "MX"

		/// Malaysia. 
		case my = "MY"

		/// Mozambique. 
		case mz = "MZ"

		/// Namibia. 
		case na = "NA"

		/// New Caledonia. 
		case nc = "NC"

		/// Niger. 
		case ne = "NE"

		/// Norfolk Island. 
		case nf = "NF"

		/// Nigeria. 
		case ng = "NG"

		/// Nicaragua. 
		case ni = "NI"

		/// Netherlands. 
		case nl = "NL"

		/// Norway. 
		case no = "NO"

		/// Nepal. 
		case np = "NP"

		/// Nauru. 
		case nr = "NR"

		/// Niue. 
		case nu = "NU"

		/// New Zealand. 
		case nz = "NZ"

		/// Oman. 
		case om = "OM"

		/// Panama. 
		case pa = "PA"

		/// Peru. 
		case pe = "PE"

		/// French Polynesia. 
		case pf = "PF"

		/// Papua New Guinea. 
		case pg = "PG"

		/// Philippines. 
		case ph = "PH"

		/// Pakistan. 
		case pk = "PK"

		/// Poland. 
		case pl = "PL"

		/// St. Pierre & Miquelon. 
		case pm = "PM"

		/// Pitcairn Islands. 
		case pn = "PN"

		/// Palestinian Territories. 
		case ps = "PS"

		/// Portugal. 
		case pt = "PT"

		/// Paraguay. 
		case py = "PY"

		/// Qatar. 
		case qa = "QA"

		/// Réunion. 
		case re = "RE"

		/// Romania. 
		case ro = "RO"

		/// Serbia. 
		case rs = "RS"

		/// Russia. 
		case ru = "RU"

		/// Rwanda. 
		case rw = "RW"

		/// Saudi Arabia. 
		case sa = "SA"

		/// Solomon Islands. 
		case sb = "SB"

		/// Seychelles. 
		case sc = "SC"

		/// Sudan. 
		case sd = "SD"

		/// Sweden. 
		case se = "SE"

		/// Singapore. 
		case sg = "SG"

		/// St. Helena. 
		case sh = "SH"

		/// Slovenia. 
		case si = "SI"

		/// Svalbard & Jan Mayen. 
		case sj = "SJ"

		/// Slovakia. 
		case sk = "SK"

		/// Sierra Leone. 
		case sl = "SL"

		/// San Marino. 
		case sm = "SM"

		/// Senegal. 
		case sn = "SN"

		/// Somalia. 
		case so = "SO"

		/// Suriname. 
		case sr = "SR"

		/// South Sudan. 
		case ss = "SS"

		/// São Tomé & Príncipe. 
		case st = "ST"

		/// El Salvador. 
		case sv = "SV"

		/// Sint Maarten. 
		case sx = "SX"

		/// Syria. 
		case sy = "SY"

		/// Eswatini. 
		case sz = "SZ"

		/// Turks & Caicos Islands. 
		case tc = "TC"

		/// Chad. 
		case td = "TD"

		/// French Southern Territories. 
		case tf = "TF"

		/// Togo. 
		case tg = "TG"

		/// Thailand. 
		case th = "TH"

		/// Tajikistan. 
		case tj = "TJ"

		/// Tokelau. 
		case tk = "TK"

		/// Timor-Leste. 
		case tl = "TL"

		/// Turkmenistan. 
		case tm = "TM"

		/// Tunisia. 
		case tn = "TN"

		/// Tonga. 
		case to = "TO"

		/// Turkey. 
		case tr = "TR"

		/// Trinidad & Tobago. 
		case tt = "TT"

		/// Tuvalu. 
		case tv = "TV"

		/// Taiwan. 
		case tw = "TW"

		/// Tanzania. 
		case tz = "TZ"

		/// Ukraine. 
		case ua = "UA"

		/// Uganda. 
		case ug = "UG"

		/// U.S. Outlying Islands. 
		case um = "UM"

		/// United States. 
		case us = "US"

		/// Uruguay. 
		case uy = "UY"

		/// Uzbekistan. 
		case uz = "UZ"

		/// Vatican City. 
		case va = "VA"

		/// St. Vincent & Grenadines. 
		case vc = "VC"

		/// Venezuela. 
		case ve = "VE"

		/// British Virgin Islands. 
		case vg = "VG"

		/// Vietnam. 
		case vn = "VN"

		/// Vanuatu. 
		case vu = "VU"

		/// Wallis & Futuna. 
		case wf = "WF"

		/// Samoa. 
		case ws = "WS"

		/// Kosovo. 
		case xk = "XK"

		/// Yemen. 
		case ye = "YE"

		/// Mayotte. 
		case yt = "YT"

		/// South Africa. 
		case za = "ZA"

		/// Zambia. 
		case zm = "ZM"

		/// Zimbabwe. 
		case zw = "ZW"

		case unknownValue = ""
	}
}
