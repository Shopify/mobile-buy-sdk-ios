//
//  LanguageCode.swift
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
	/// ISO 639-1 language codes supported by Shopify. 
	public enum LanguageCode: String {
		/// Afrikaans. 
		case af = "AF"

		/// Akan. 
		case ak = "AK"

		/// Amharic. 
		case am = "AM"

		/// Arabic. 
		case ar = "AR"

		/// Assamese. 
		case `as` = "AS"

		/// Azerbaijani. 
		case az = "AZ"

		/// Belarusian. 
		case be = "BE"

		/// Bulgarian. 
		case bg = "BG"

		/// Bambara. 
		case bm = "BM"

		/// Bangla. 
		case bn = "BN"

		/// Tibetan. 
		case bo = "BO"

		/// Breton. 
		case br = "BR"

		/// Bosnian. 
		case bs = "BS"

		/// Catalan. 
		case ca = "CA"

		/// Chechen. 
		case ce = "CE"

		/// Central Kurdish. 
		case ckb = "CKB"

		/// Czech. 
		case cs = "CS"

		/// Church Slavic. 
		case cu = "CU"

		/// Welsh. 
		case cy = "CY"

		/// Danish. 
		case da = "DA"

		/// German. 
		case de = "DE"

		/// Dzongkha. 
		case dz = "DZ"

		/// Ewe. 
		case ee = "EE"

		/// Greek. 
		case el = "EL"

		/// English. 
		case en = "EN"

		/// Esperanto. 
		case eo = "EO"

		/// Spanish. 
		case es = "ES"

		/// Estonian. 
		case et = "ET"

		/// Basque. 
		case eu = "EU"

		/// Persian. 
		case fa = "FA"

		/// Fulah. 
		case ff = "FF"

		/// Finnish. 
		case fi = "FI"

		/// Filipino. 
		case fil = "FIL"

		/// Faroese. 
		case fo = "FO"

		/// French. 
		case fr = "FR"

		/// Western Frisian. 
		case fy = "FY"

		/// Irish. 
		case ga = "GA"

		/// Scottish Gaelic. 
		case gd = "GD"

		/// Galician. 
		case gl = "GL"

		/// Gujarati. 
		case gu = "GU"

		/// Manx. 
		case gv = "GV"

		/// Hausa. 
		case ha = "HA"

		/// Hebrew. 
		case he = "HE"

		/// Hindi. 
		case hi = "HI"

		/// Croatian. 
		case hr = "HR"

		/// Hungarian. 
		case hu = "HU"

		/// Armenian. 
		case hy = "HY"

		/// Interlingua. 
		case ia = "IA"

		/// Indonesian. 
		case id = "ID"

		/// Igbo. 
		case ig = "IG"

		/// Sichuan Yi. 
		case ii = "II"

		/// Icelandic. 
		case `is` = "IS"

		/// Italian. 
		case it = "IT"

		/// Japanese. 
		case ja = "JA"

		/// Javanese. 
		case jv = "JV"

		/// Georgian. 
		case ka = "KA"

		/// Kikuyu. 
		case ki = "KI"

		/// Kazakh. 
		case kk = "KK"

		/// Kalaallisut. 
		case kl = "KL"

		/// Khmer. 
		case km = "KM"

		/// Kannada. 
		case kn = "KN"

		/// Korean. 
		case ko = "KO"

		/// Kashmiri. 
		case ks = "KS"

		/// Kurdish. 
		case ku = "KU"

		/// Cornish. 
		case kw = "KW"

		/// Kyrgyz. 
		case ky = "KY"

		/// Latin. 
		case la = "LA"

		/// Luxembourgish. 
		case lb = "LB"

		/// Ganda. 
		case lg = "LG"

		/// Lingala. 
		case ln = "LN"

		/// Lao. 
		case lo = "LO"

		/// Lithuanian. 
		case lt = "LT"

		/// Luba-Katanga. 
		case lu = "LU"

		/// Latvian. 
		case lv = "LV"

		/// Malagasy. 
		case mg = "MG"

		/// Māori. 
		case mi = "MI"

		/// Macedonian. 
		case mk = "MK"

		/// Malayalam. 
		case ml = "ML"

		/// Mongolian. 
		case mn = "MN"

		/// Moldavian. 
		case mo = "MO"

		/// Marathi. 
		case mr = "MR"

		/// Malay. 
		case ms = "MS"

		/// Maltese. 
		case mt = "MT"

		/// Burmese. 
		case my = "MY"

		/// Norwegian (Bokmål). 
		case nb = "NB"

		/// North Ndebele. 
		case nd = "ND"

		/// Nepali. 
		case ne = "NE"

		/// Dutch. 
		case nl = "NL"

		/// Norwegian Nynorsk. 
		case nn = "NN"

		/// Norwegian. 
		case no = "NO"

		/// Oromo. 
		case om = "OM"

		/// Odia. 
		case or = "OR"

		/// Ossetic. 
		case os = "OS"

		/// Punjabi. 
		case pa = "PA"

		/// Polish. 
		case pl = "PL"

		/// Pashto. 
		case ps = "PS"

		/// Portuguese. 
		case pt = "PT"

		/// Portuguese (Brazil). 
		case ptBr = "PT_BR"

		/// Portuguese (Portugal). 
		case ptPt = "PT_PT"

		/// Quechua. 
		case qu = "QU"

		/// Romansh. 
		case rm = "RM"

		/// Rundi. 
		case rn = "RN"

		/// Romanian. 
		case ro = "RO"

		/// Russian. 
		case ru = "RU"

		/// Kinyarwanda. 
		case rw = "RW"

		/// Sanskrit. 
		case sa = "SA"

		/// Sardinian. 
		case sc = "SC"

		/// Sindhi. 
		case sd = "SD"

		/// Northern Sami. 
		case se = "SE"

		/// Sango. 
		case sg = "SG"

		/// Serbo-Croatian. 
		case sh = "SH"

		/// Sinhala. 
		case si = "SI"

		/// Slovak. 
		case sk = "SK"

		/// Slovenian. 
		case sl = "SL"

		/// Shona. 
		case sn = "SN"

		/// Somali. 
		case so = "SO"

		/// Albanian. 
		case sq = "SQ"

		/// Serbian. 
		case sr = "SR"

		/// Sundanese. 
		case su = "SU"

		/// Swedish. 
		case sv = "SV"

		/// Swahili. 
		case sw = "SW"

		/// Tamil. 
		case ta = "TA"

		/// Telugu. 
		case te = "TE"

		/// Tajik. 
		case tg = "TG"

		/// Thai. 
		case th = "TH"

		/// Tigrinya. 
		case ti = "TI"

		/// Turkmen. 
		case tk = "TK"

		/// Tongan. 
		case to = "TO"

		/// Turkish. 
		case tr = "TR"

		/// Tatar. 
		case tt = "TT"

		/// Uyghur. 
		case ug = "UG"

		/// Ukrainian. 
		case uk = "UK"

		/// Urdu. 
		case ur = "UR"

		/// Uzbek. 
		case uz = "UZ"

		/// Vietnamese. 
		case vi = "VI"

		/// Volapük. 
		case vo = "VO"

		/// Wolof. 
		case wo = "WO"

		/// Xhosa. 
		case xh = "XH"

		/// Yiddish. 
		case yi = "YI"

		/// Yoruba. 
		case yo = "YO"

		/// Chinese. 
		case zh = "ZH"

		/// Chinese (Simplified). 
		case zhCn = "ZH_CN"

		/// Chinese (Traditional). 
		case zhTw = "ZH_TW"

		/// Zulu. 
		case zu = "ZU"

		case unknownValue = ""
	}
}
