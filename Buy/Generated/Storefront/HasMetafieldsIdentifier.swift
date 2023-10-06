//
//  HasMetafieldsIdentifier.swift
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
	/// The input fields to identify a metafield on an owner resource by namespace 
	/// and key. 
	open class HasMetafieldsIdentifier {
		/// The container the metafield belongs to. If omitted, the app-reserved 
		/// namespace will be used. 
		open var namespace: Input<String>

		/// The identifier for the metafield. 
		open var key: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		public static func create(key: String, namespace: Input<String> = .undefined) -> HasMetafieldsIdentifier {
			return HasMetafieldsIdentifier(key: key, namespace: namespace)
		}

		private init(key: String, namespace: Input<String> = .undefined) {
			self.namespace = namespace
			self.key = key
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(key: String, namespace: String? = nil) {
			self.init(key: key, namespace: namespace.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch namespace {
				case .value(let namespace): 
				guard let namespace = namespace else {
					fields.append("namespace:null")
					break
				}
				fields.append("namespace:\(GraphQL.quoteString(input: namespace))")
				case .undefined: break
			}

			fields.append("key:\(GraphQL.quoteString(input: key))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
