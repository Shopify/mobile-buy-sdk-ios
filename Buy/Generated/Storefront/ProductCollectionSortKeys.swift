//
//  ProductCollectionSortKeys.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2024 Shopify Inc. All rights reserved.
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
	/// The set of valid sort keys for the ProductCollection query. 
	public enum ProductCollectionSortKeys: String {
		/// Sort by the `best-selling` value. 
		case bestSelling = "BEST_SELLING"

		/// Sort by the `collection-default` value. 
		case collectionDefault = "COLLECTION_DEFAULT"

		/// Sort by the `created` value. 
		case created = "CREATED"

		/// Sort by the `id` value. 
		case id = "ID"

		/// Sort by the `manual` value. 
		case manual = "MANUAL"

		/// Sort by the `price` value. 
		case price = "PRICE"

		/// Sort by relevance to the search terms when the `query` parameter is 
		/// specified on the connection. Don't use this sort key when no search query 
		/// is specified. 
		case relevance = "RELEVANCE"

		/// Sort by the `title` value. 
		case title = "TITLE"

		case unknownValue = ""
	}
}
