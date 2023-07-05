//
//  CartMetafieldDeleteInput.swift
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
	/// The input fields to delete a cart metafield. 
	open class CartMetafieldDeleteInput {
		/// The ID of the cart resource. 
		open var ownerId: GraphQL.ID

		/// The key name of the cart metafield. Can either be a composite key 
		/// (`namespace.key`) or a simple key that relies on the default app-reserved 
		/// namespace. 
		open var key: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - ownerId: The ID of the cart resource.
		///     - key: The key name of the cart metafield. Can either be a composite key (`namespace.key`) or a simple key  that relies on the default app-reserved namespace. 
		///
		public static func create(ownerId: GraphQL.ID, key: String) -> CartMetafieldDeleteInput {
			return CartMetafieldDeleteInput(ownerId: ownerId, key: key)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - ownerId: The ID of the cart resource.
		///     - key: The key name of the cart metafield. Can either be a composite key (`namespace.key`) or a simple key  that relies on the default app-reserved namespace. 
		///
		public init(ownerId: GraphQL.ID, key: String) {
			self.ownerId = ownerId
			self.key = key
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("ownerId:\(GraphQL.quoteString(input: "\(ownerId.rawValue)"))")

			fields.append("key:\(GraphQL.quoteString(input: key))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
