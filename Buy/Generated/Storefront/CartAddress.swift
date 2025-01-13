//
//  CartAddress.swift
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

/// A delivery address of the buyer that is interacting with the cart. 
public protocol CartAddress {
}

extension Storefront {
	/// A delivery address of the buyer that is interacting with the cart. 
	open class CartAddressQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartAddress

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// A delivery address of the buyer that is interacting with the cart. 
		@discardableResult
		open func onCartDeliveryAddress(subfields: (CartDeliveryAddressQuery) -> Void) -> CartAddressQuery {
			let subquery = CartDeliveryAddressQuery()
			subfields(subquery)
			addInlineFragment(on: "CartDeliveryAddress", subfields: subquery)
			return self
		}
	}

	/// A delivery address of the buyer that is interacting with the cart. 
	open class UnknownCartAddress: GraphQL.AbstractResponse, GraphQLObject, CartAddress {
		public typealias Query = CartAddressQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownCartAddress.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> CartAddress {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownCartAddress.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "CartDeliveryAddress": return try CartDeliveryAddress.init(fields: fields)

				default:
				return try UnknownCartAddress.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}
