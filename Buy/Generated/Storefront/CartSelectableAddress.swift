//
//  CartSelectableAddress.swift
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
	/// A selectable delivery address for a cart. 
	open class CartSelectableAddressQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartSelectableAddress

		/// The delivery address. 
		@discardableResult
		open func address(alias: String? = nil, _ subfields: (CartAddressQuery) -> Void) -> CartSelectableAddressQuery {
			let subquery = CartAddressQuery()
			subfields(subquery)

			addField(field: "address", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A unique identifier for the address, specific to this cart. 
		@discardableResult
		open func id(alias: String? = nil) -> CartSelectableAddressQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// This delivery address will not be associated with the buyer after a 
		/// successful checkout. 
		@discardableResult
		open func oneTimeUse(alias: String? = nil) -> CartSelectableAddressQuery {
			addField(field: "oneTimeUse", aliasSuffix: alias)
			return self
		}

		/// Sets exactly one address as pre-selected for the buyer. 
		@discardableResult
		open func selected(alias: String? = nil) -> CartSelectableAddressQuery {
			addField(field: "selected", aliasSuffix: alias)
			return self
		}
	}

	/// A selectable delivery address for a cart. 
	open class CartSelectableAddress: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartSelectableAddressQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "address":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartSelectableAddress.self, field: fieldName, value: fieldValue)
				}
				return try UnknownCartAddress.create(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartSelectableAddress.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "oneTimeUse":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: CartSelectableAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				case "selected":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: CartSelectableAddress.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: CartSelectableAddress.self, field: fieldName, value: fieldValue)
			}
		}

		/// The delivery address. 
		open var address: CartAddress {
			return internalGetAddress()
		}

		func internalGetAddress(alias: String? = nil) -> CartAddress {
			return field(field: "address", aliasSuffix: alias) as! CartAddress
		}

		/// A unique identifier for the address, specific to this cart. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// This delivery address will not be associated with the buyer after a 
		/// successful checkout. 
		open var oneTimeUse: Bool {
			return internalGetOneTimeUse()
		}

		func internalGetOneTimeUse(alias: String? = nil) -> Bool {
			return field(field: "oneTimeUse", aliasSuffix: alias) as! Bool
		}

		/// Sets exactly one address as pre-selected for the buyer. 
		open var selected: Bool {
			return internalGetSelected()
		}

		func internalGetSelected(alias: String? = nil) -> Bool {
			return field(field: "selected", aliasSuffix: alias) as! Bool
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}
