//
//  CartDeliveryGroup.swift
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
	/// Information about the options available for one or more line items to be 
	/// delivered to a specific address. 
	open class CartDeliveryGroupQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartDeliveryGroup

		/// A list of cart lines for the delivery group. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func cartLines(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (BaseCartLineConnectionQuery) -> Void) -> CartDeliveryGroupQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = BaseCartLineConnectionQuery()
			subfields(subquery)

			addField(field: "cartLines", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The destination address for the delivery group. 
		@discardableResult
		open func deliveryAddress(alias: String? = nil, _ subfields: (MailingAddressQuery) -> Void) -> CartDeliveryGroupQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)

			addField(field: "deliveryAddress", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The delivery options available for the delivery group. 
		@discardableResult
		open func deliveryOptions(alias: String? = nil, _ subfields: (CartDeliveryOptionQuery) -> Void) -> CartDeliveryGroupQuery {
			let subquery = CartDeliveryOptionQuery()
			subfields(subquery)

			addField(field: "deliveryOptions", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The ID for the delivery group. 
		@discardableResult
		open func id(alias: String? = nil) -> CartDeliveryGroupQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The selected delivery option for the delivery group. 
		@discardableResult
		open func selectedDeliveryOption(alias: String? = nil, _ subfields: (CartDeliveryOptionQuery) -> Void) -> CartDeliveryGroupQuery {
			let subquery = CartDeliveryOptionQuery()
			subfields(subquery)

			addField(field: "selectedDeliveryOption", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Information about the options available for one or more line items to be 
	/// delivered to a specific address. 
	open class CartDeliveryGroup: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartDeliveryGroupQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "cartLines":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartDeliveryGroup.self, field: fieldName, value: fieldValue)
				}
				return try BaseCartLineConnection(fields: value)

				case "deliveryAddress":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartDeliveryGroup.self, field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "deliveryOptions":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartDeliveryGroup.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CartDeliveryOption(fields: $0) }

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartDeliveryGroup.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "selectedDeliveryOption":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartDeliveryGroup.self, field: fieldName, value: fieldValue)
				}
				return try CartDeliveryOption(fields: value)

				default:
				throw SchemaViolationError(type: CartDeliveryGroup.self, field: fieldName, value: fieldValue)
			}
		}

		/// A list of cart lines for the delivery group. 
		open var cartLines: Storefront.BaseCartLineConnection {
			return internalGetCartLines()
		}

		open func aliasedCartLines(alias: String) -> Storefront.BaseCartLineConnection {
			return internalGetCartLines(alias: alias)
		}

		func internalGetCartLines(alias: String? = nil) -> Storefront.BaseCartLineConnection {
			return field(field: "cartLines", aliasSuffix: alias) as! Storefront.BaseCartLineConnection
		}

		/// The destination address for the delivery group. 
		open var deliveryAddress: Storefront.MailingAddress {
			return internalGetDeliveryAddress()
		}

		func internalGetDeliveryAddress(alias: String? = nil) -> Storefront.MailingAddress {
			return field(field: "deliveryAddress", aliasSuffix: alias) as! Storefront.MailingAddress
		}

		/// The delivery options available for the delivery group. 
		open var deliveryOptions: [Storefront.CartDeliveryOption] {
			return internalGetDeliveryOptions()
		}

		func internalGetDeliveryOptions(alias: String? = nil) -> [Storefront.CartDeliveryOption] {
			return field(field: "deliveryOptions", aliasSuffix: alias) as! [Storefront.CartDeliveryOption]
		}

		/// The ID for the delivery group. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The selected delivery option for the delivery group. 
		open var selectedDeliveryOption: Storefront.CartDeliveryOption? {
			return internalGetSelectedDeliveryOption()
		}

		func internalGetSelectedDeliveryOption(alias: String? = nil) -> Storefront.CartDeliveryOption? {
			return field(field: "selectedDeliveryOption", aliasSuffix: alias) as! Storefront.CartDeliveryOption?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "cartLines":
					response.append(internalGetCartLines())
					response.append(contentsOf: internalGetCartLines().childResponseObjectMap())

					case "deliveryAddress":
					response.append(internalGetDeliveryAddress())
					response.append(contentsOf: internalGetDeliveryAddress().childResponseObjectMap())

					case "deliveryOptions":
					internalGetDeliveryOptions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "selectedDeliveryOption":
					if let value = internalGetSelectedDeliveryOption() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}
