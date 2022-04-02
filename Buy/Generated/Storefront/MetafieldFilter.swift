//
//  MetafieldFilter.swift
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
	/// A filter used to view a subset of products in a collection matching a 
	/// specific metafield value. Only the following metafield types are currently 
	/// supported: - `number_integer` - `number_decimal` - `single_line_text_field` 
	/// - `boolean` as of 2022-04. 
	open class MetafieldFilter {
		/// The namespace of the metafield to filter on. 
		open var namespace: String

		/// The key of the metafield to filter on. 
		open var key: String

		/// The value of the metafield. 
		open var value: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - namespace: The namespace of the metafield to filter on.
		///     - key: The key of the metafield to filter on.
		///     - value: The value of the metafield.
		///
		public static func create(namespace: String, key: String, value: String) -> MetafieldFilter {
			return MetafieldFilter(namespace: namespace, key: key, value: value)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - namespace: The namespace of the metafield to filter on.
		///     - key: The key of the metafield to filter on.
		///     - value: The value of the metafield.
		///
		public init(namespace: String, key: String, value: String) {
			self.namespace = namespace
			self.key = key
			self.value = value
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("namespace:\(GraphQL.quoteString(input: namespace))")

			fields.append("key:\(GraphQL.quoteString(input: key))")

			fields.append("value:\(GraphQL.quoteString(input: value))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
