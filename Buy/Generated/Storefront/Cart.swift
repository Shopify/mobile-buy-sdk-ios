//
//  Cart.swift
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
	/// A cart represents the merchandise that a buyer intends to purchase, and the 
	/// estimated cost associated with the cart. To learn how to interact with a 
	/// cart during a customer's session, refer to the [Cart 
	/// guide](https://shopify.dev/custom-storefronts/cart). 
	open class CartQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Cart

		/// The attributes associated with the cart. Attributes are represented as 
		/// key-value pairs. 
		@discardableResult
		open func attributes(alias: String? = nil, _ subfields: (AttributeQuery) -> Void) -> CartQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "attributes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Information about the buyer that is interacting with the cart. 
		@discardableResult
		open func buyerIdentity(alias: String? = nil, _ subfields: (CartBuyerIdentityQuery) -> Void) -> CartQuery {
			let subquery = CartBuyerIdentityQuery()
			subfields(subquery)

			addField(field: "buyerIdentity", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The URL of the checkout for the cart. 
		@discardableResult
		open func checkoutUrl(alias: String? = nil) -> CartQuery {
			addField(field: "checkoutUrl", aliasSuffix: alias)
			return self
		}

		/// The date and time when the cart was created. 
		@discardableResult
		open func createdAt(alias: String? = nil) -> CartQuery {
			addField(field: "createdAt", aliasSuffix: alias)
			return self
		}

		/// The discount codes that have been applied to the cart. 
		@discardableResult
		open func discountCodes(alias: String? = nil, _ subfields: (CartDiscountCodeQuery) -> Void) -> CartQuery {
			let subquery = CartDiscountCodeQuery()
			subfields(subquery)

			addField(field: "discountCodes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The estimated costs that the buyer will pay at checkout. The estimated 
		/// costs are subject to change and changes will be reflected at checkout. 
		@discardableResult
		open func estimatedCost(alias: String? = nil, _ subfields: (CartEstimatedCostQuery) -> Void) -> CartQuery {
			let subquery = CartEstimatedCostQuery()
			subfields(subquery)

			addField(field: "estimatedCost", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A globally-unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> CartQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// A list of lines containing information about the items the customer intends 
		/// to purchase. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func lines(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (CartLineConnectionQuery) -> Void) -> CartQuery {
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

			let subquery = CartLineConnectionQuery()
			subfields(subquery)

			addField(field: "lines", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A note that is associated with the cart. For example, the note can be a 
		/// personalized message to the buyer. 
		@discardableResult
		open func note(alias: String? = nil) -> CartQuery {
			addField(field: "note", aliasSuffix: alias)
			return self
		}

		/// The date and time when the cart was updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> CartQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}
	}

	/// A cart represents the merchandise that a buyer intends to purchase, and the 
	/// estimated cost associated with the cart. To learn how to interact with a 
	/// cart during a customer's session, refer to the [Cart 
	/// guide](https://shopify.dev/custom-storefronts/cart). 
	open class Cart: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = CartQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "attributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

				case "buyerIdentity":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try CartBuyerIdentity(fields: value)

				case "checkoutUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "discountCodes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CartDiscountCode(fields: $0) }

				case "estimatedCost":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try CartEstimatedCost(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lines":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try CartLineConnection(fields: value)

				case "note":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
			}
		}

		/// The attributes associated with the cart. Attributes are represented as 
		/// key-value pairs. 
		open var attributes: [Storefront.Attribute] {
			return internalGetAttributes()
		}

		func internalGetAttributes(alias: String? = nil) -> [Storefront.Attribute] {
			return field(field: "attributes", aliasSuffix: alias) as! [Storefront.Attribute]
		}

		/// Information about the buyer that is interacting with the cart. 
		open var buyerIdentity: Storefront.CartBuyerIdentity {
			return internalGetBuyerIdentity()
		}

		func internalGetBuyerIdentity(alias: String? = nil) -> Storefront.CartBuyerIdentity {
			return field(field: "buyerIdentity", aliasSuffix: alias) as! Storefront.CartBuyerIdentity
		}

		/// The URL of the checkout for the cart. 
		open var checkoutUrl: URL {
			return internalGetCheckoutUrl()
		}

		func internalGetCheckoutUrl(alias: String? = nil) -> URL {
			return field(field: "checkoutUrl", aliasSuffix: alias) as! URL
		}

		/// The date and time when the cart was created. 
		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(alias: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: alias) as! Date
		}

		/// The discount codes that have been applied to the cart. 
		open var discountCodes: [Storefront.CartDiscountCode] {
			return internalGetDiscountCodes()
		}

		func internalGetDiscountCodes(alias: String? = nil) -> [Storefront.CartDiscountCode] {
			return field(field: "discountCodes", aliasSuffix: alias) as! [Storefront.CartDiscountCode]
		}

		/// The estimated costs that the buyer will pay at checkout. The estimated 
		/// costs are subject to change and changes will be reflected at checkout. 
		open var estimatedCost: Storefront.CartEstimatedCost {
			return internalGetEstimatedCost()
		}

		func internalGetEstimatedCost(alias: String? = nil) -> Storefront.CartEstimatedCost {
			return field(field: "estimatedCost", aliasSuffix: alias) as! Storefront.CartEstimatedCost
		}

		/// A globally-unique identifier. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// A list of lines containing information about the items the customer intends 
		/// to purchase. 
		open var lines: Storefront.CartLineConnection {
			return internalGetLines()
		}

		open func aliasedLines(alias: String) -> Storefront.CartLineConnection {
			return internalGetLines(alias: alias)
		}

		func internalGetLines(alias: String? = nil) -> Storefront.CartLineConnection {
			return field(field: "lines", aliasSuffix: alias) as! Storefront.CartLineConnection
		}

		/// A note that is associated with the cart. For example, the note can be a 
		/// personalized message to the buyer. 
		open var note: String? {
			return internalGetNote()
		}

		func internalGetNote(alias: String? = nil) -> String? {
			return field(field: "note", aliasSuffix: alias) as! String?
		}

		/// The date and time when the cart was updated. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "attributes":
					internalGetAttributes().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "buyerIdentity":
					response.append(internalGetBuyerIdentity())
					response.append(contentsOf: internalGetBuyerIdentity().childResponseObjectMap())

					case "discountCodes":
					internalGetDiscountCodes().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "estimatedCost":
					response.append(internalGetEstimatedCost())
					response.append(contentsOf: internalGetEstimatedCost().childResponseObjectMap())

					case "lines":
					response.append(internalGetLines())
					response.append(contentsOf: internalGetLines().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
