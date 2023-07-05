//
//  CartMetafieldsSetInput.swift
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
	/// The input fields for a cart metafield value to set. 
	open class CartMetafieldsSetInput {
		/// The ID of the cart resource. 
		open var ownerId: GraphQL.ID

		/// The key name of the cart metafield. 
		open var key: String

		/// The data to store in the cart metafield. The data is always stored as a 
		/// string, regardless of the metafield's type. 
		open var value: String

		/// The type of data that the cart metafield stores. The type of data must be a 
		/// [supported type](https://shopify.dev/apps/metafields/types). 
		open var type: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - ownerId: The ID of the cart resource.
		///     - key: The key name of the cart metafield.
		///     - value: The data to store in the cart metafield. The data is always stored as a string, regardless of the metafield's type. 
		///     - type: The type of data that the cart metafield stores. The type of data must be a [supported type](https://shopify.dev/apps/metafields/types). 
		///
		public static func create(ownerId: GraphQL.ID, key: String, value: String, type: String) -> CartMetafieldsSetInput {
			return CartMetafieldsSetInput(ownerId: ownerId, key: key, value: value, type: type)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - ownerId: The ID of the cart resource.
		///     - key: The key name of the cart metafield.
		///     - value: The data to store in the cart metafield. The data is always stored as a string, regardless of the metafield's type. 
		///     - type: The type of data that the cart metafield stores. The type of data must be a [supported type](https://shopify.dev/apps/metafields/types). 
		///
		public init(ownerId: GraphQL.ID, key: String, value: String, type: String) {
			self.ownerId = ownerId
			self.key = key
			self.value = value
			self.type = type
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("ownerId:\(GraphQL.quoteString(input: "\(ownerId.rawValue)"))")

			fields.append("key:\(GraphQL.quoteString(input: key))")

			fields.append("value:\(GraphQL.quoteString(input: value))")

			fields.append("type:\(GraphQL.quoteString(input: type))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
