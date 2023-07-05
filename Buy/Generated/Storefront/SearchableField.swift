//
//  SearchableField.swift
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
	/// Specifies the list of resource fields to search. 
	public enum SearchableField: String {
		/// Author of the page or article. 
		case author = "AUTHOR"

		/// Body of the page or article or product description or collection 
		/// description. 
		case body = "BODY"

		/// Product type. 
		case productType = "PRODUCT_TYPE"

		/// Tag associated with the product or article. 
		case tag = "TAG"

		/// Title of the page or article or product title or collection title. 
		case title = "TITLE"

		/// Variant barcode. 
		case variantsBarcode = "VARIANTS_BARCODE"

		/// Variant SKU. 
		case variantsSku = "VARIANTS_SKU"

		/// Variant title. 
		case variantsTitle = "VARIANTS_TITLE"

		/// Product vendor. 
		case vendor = "VENDOR"

		case unknownValue = ""
	}
}
