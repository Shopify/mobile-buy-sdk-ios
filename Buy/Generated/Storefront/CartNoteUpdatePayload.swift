//
//  CartNoteUpdatePayload.swift
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
	/// Return type for `cartNoteUpdate` mutation. 
	open class CartNoteUpdatePayloadQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartNoteUpdatePayload

		/// The updated cart. 
		@discardableResult
		open func cart(alias: String? = nil, _ subfields: (CartQuery) -> Void) -> CartNoteUpdatePayloadQuery {
			let subquery = CartQuery()
			subfields(subquery)

			addField(field: "cart", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The list of errors that occurred from executing the mutation. 
		@discardableResult
		open func userErrors(alias: String? = nil, _ subfields: (CartUserErrorQuery) -> Void) -> CartNoteUpdatePayloadQuery {
			let subquery = CartUserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of warnings that occurred during the mutation. 
		@discardableResult
		open func warnings(alias: String? = nil, _ subfields: (CartWarningQuery) -> Void) -> CartNoteUpdatePayloadQuery {
			let subquery = CartWarningQuery()
			subfields(subquery)

			addField(field: "warnings", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Return type for `cartNoteUpdate` mutation. 
	open class CartNoteUpdatePayload: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartNoteUpdatePayloadQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "cart":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartNoteUpdatePayload.self, field: fieldName, value: fieldValue)
				}
				return try Cart(fields: value)

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartNoteUpdatePayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CartUserError(fields: $0) }

				case "warnings":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartNoteUpdatePayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CartWarning(fields: $0) }

				default:
				throw SchemaViolationError(type: CartNoteUpdatePayload.self, field: fieldName, value: fieldValue)
			}
		}

		/// The updated cart. 
		open var cart: Storefront.Cart? {
			return internalGetCart()
		}

		func internalGetCart(alias: String? = nil) -> Storefront.Cart? {
			return field(field: "cart", aliasSuffix: alias) as! Storefront.Cart?
		}

		/// The list of errors that occurred from executing the mutation. 
		open var userErrors: [Storefront.CartUserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(alias: String? = nil) -> [Storefront.CartUserError] {
			return field(field: "userErrors", aliasSuffix: alias) as! [Storefront.CartUserError]
		}

		/// A list of warnings that occurred during the mutation. 
		open var warnings: [Storefront.CartWarning] {
			return internalGetWarnings()
		}

		func internalGetWarnings(alias: String? = nil) -> [Storefront.CartWarning] {
			return field(field: "warnings", aliasSuffix: alias) as! [Storefront.CartWarning]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "cart":
					if let value = internalGetCart() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "userErrors":
					internalGetUserErrors().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "warnings":
					internalGetWarnings().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}
