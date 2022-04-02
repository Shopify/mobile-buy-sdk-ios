//
//  MenuItemType.swift
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
	/// A menu item type. 
	public enum MenuItemType: String {
		/// An article link. 
		case article = "ARTICLE"

		/// A blog link. 
		case blog = "BLOG"

		/// A catalog link. 
		case catalog = "CATALOG"

		/// A collection link. 
		case collection = "COLLECTION"

		/// A collection link. 
		case collections = "COLLECTIONS"

		/// A frontpage link. 
		case frontpage = "FRONTPAGE"

		/// An http link. 
		case http = "HTTP"

		/// A page link. 
		case page = "PAGE"

		/// A product link. 
		case product = "PRODUCT"

		/// A search link. 
		case search = "SEARCH"

		/// A shop policy link. 
		case shopPolicy = "SHOP_POLICY"

		case unknownValue = ""
	}
}
