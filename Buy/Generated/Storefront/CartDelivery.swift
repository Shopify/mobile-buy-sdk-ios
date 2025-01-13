//
//  CartDelivery.swift
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
	/// The delivery properties of the cart. 
	open class CartDeliveryQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartDelivery

		/// Selectable addresses to present to the buyer on the cart. 
		///
		/// - parameters:
		///     - selected: Filter the addresses by selected status.
		///
		@discardableResult
		open func addresses(alias: String? = nil, selected: Bool? = nil, _ subfields: (CartSelectableAddressQuery) -> Void) -> CartDeliveryQuery {
			var args: [String] = []

			if let selected = selected {
				args.append("selected:\(selected)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CartSelectableAddressQuery()
			subfields(subquery)

			addField(field: "addresses", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}
	}

	/// The delivery properties of the cart. 
	open class CartDelivery: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartDeliveryQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "addresses":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartDelivery.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CartSelectableAddress(fields: $0) }

				default:
				throw SchemaViolationError(type: CartDelivery.self, field: fieldName, value: fieldValue)
			}
		}

		/// Selectable addresses to present to the buyer on the cart. 
		open var addresses: [Storefront.CartSelectableAddress] {
			return internalGetAddresses()
		}

		open func aliasedAddresses(alias: String) -> [Storefront.CartSelectableAddress] {
			return internalGetAddresses(alias: alias)
		}

		func internalGetAddresses(alias: String? = nil) -> [Storefront.CartSelectableAddress] {
			return field(field: "addresses", aliasSuffix: alias) as! [Storefront.CartSelectableAddress]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}
