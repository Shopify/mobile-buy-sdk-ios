//
//  CategoryFilter.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
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
	/// A filter used to view a subset of products in a collection matching a 
	/// specific category value. 
	open class CategoryFilter {
		/// The id of the category to filter on. 
		open var id: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - id: The id of the category to filter on.
		///
		public static func create(id: String) -> CategoryFilter {
			return CategoryFilter(id: id)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - id: The id of the category to filter on.
		///
		public init(id: String) {
			self.id = id
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("id:\(GraphQL.quoteString(input: id))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
