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
	/// estimated cost associated with the cart. Learn how to [interact with a 
	/// cart](https://shopify.dev/custom-storefronts/internationalization/international-pricing) 
	/// during a customer's session. 
	open class CartQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Cart

		/// An attribute associated with the cart. 
		///
		/// - parameters:
		///     - key: The key of the attribute.
		///
		@discardableResult
		open func attribute(alias: String? = nil, key: String, _ subfields: (AttributeQuery) -> Void) -> CartQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "attribute", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The attributes associated with the cart. Attributes are represented as 
		/// key-value pairs. 
		@discardableResult
		open func attributes(alias: String? = nil, _ subfields: (AttributeQuery) -> Void) -> CartQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "attributes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Information about the buyer that's interacting with the cart. 
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

		/// The estimated costs that the buyer will pay at checkout. The costs are 
		/// subject to change and changes will be reflected at checkout. The `cost` 
		/// field uses the `buyerIdentity` field to determine [international 
		/// pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing). 
		@discardableResult
		open func cost(alias: String? = nil, _ subfields: (CartCostQuery) -> Void) -> CartQuery {
			let subquery = CartCostQuery()
			subfields(subquery)

			addField(field: "cost", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The date and time when the cart was created. 
		@discardableResult
		open func createdAt(alias: String? = nil) -> CartQuery {
			addField(field: "createdAt", aliasSuffix: alias)
			return self
		}

		/// The delivery groups available for the cart, based on the buyer identity 
		/// default delivery address preference or the default address of the logged-in 
		/// customer. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func deliveryGroups(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (CartDeliveryGroupConnectionQuery) -> Void) -> CartQuery {
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

			let subquery = CartDeliveryGroupConnectionQuery()
			subfields(subquery)

			addField(field: "deliveryGroups", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The discounts that have been applied to the entire cart. 
		@discardableResult
		open func discountAllocations(alias: String? = nil, _ subfields: (CartDiscountAllocationQuery) -> Void) -> CartQuery {
			let subquery = CartDiscountAllocationQuery()
			subfields(subquery)

			addField(field: "discountAllocations", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The case-insensitive discount codes that the customer added at checkout. 
		@discardableResult
		open func discountCodes(alias: String? = nil, _ subfields: (CartDiscountCodeQuery) -> Void) -> CartQuery {
			let subquery = CartDiscountCodeQuery()
			subfields(subquery)

			addField(field: "discountCodes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The estimated costs that the buyer will pay at checkout. The estimated 
		/// costs are subject to change and changes will be reflected at checkout. The 
		/// `estimatedCost` field uses the `buyerIdentity` field to determine 
		/// [international 
		/// pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing). 
		@available(*, deprecated, message:"Use `cost` instead.")
		@discardableResult
		open func estimatedCost(alias: String? = nil, _ subfields: (CartEstimatedCostQuery) -> Void) -> CartQuery {
			let subquery = CartEstimatedCostQuery()
			subfields(subquery)

			addField(field: "estimatedCost", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A globally-unique ID. 
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
		open func lines(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (BaseCartLineConnectionQuery) -> Void) -> CartQuery {
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

			addField(field: "lines", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a metafield found by namespace and key. 
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> CartQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		///
		/// - parameters:
		///     - identifiers: The list of metafields to retrieve by namespace and key.
		///
		@discardableResult
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> CartQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map{ "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A note that's associated with the cart. For example, the note can be a 
		/// personalized message to the buyer. 
		@discardableResult
		open func note(alias: String? = nil) -> CartQuery {
			addField(field: "note", aliasSuffix: alias)
			return self
		}

		/// The total number of items in the cart. 
		@discardableResult
		open func totalQuantity(alias: String? = nil) -> CartQuery {
			addField(field: "totalQuantity", aliasSuffix: alias)
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
	/// estimated cost associated with the cart. Learn how to [interact with a 
	/// cart](https://shopify.dev/custom-storefronts/internationalization/international-pricing) 
	/// during a customer's session. 
	open class Cart: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MetafieldParentResource, Node {
		public typealias Query = CartQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "attribute":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try Attribute(fields: value)

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

				case "cost":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try CartCost(fields: value)

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "deliveryGroups":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try CartDeliveryGroupConnection(fields: value)

				case "discountAllocations":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try UnknownCartDiscountAllocation.create(fields: $0) }

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
				return try BaseCartLineConnection(fields: value)

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

				case "note":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return value

				case "totalQuantity":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: Cart.self, field: fieldName, value: fieldValue)
			}
		}

		/// An attribute associated with the cart. 
		open var attribute: Storefront.Attribute? {
			return internalGetAttribute()
		}

		open func aliasedAttribute(alias: String) -> Storefront.Attribute? {
			return internalGetAttribute(alias: alias)
		}

		func internalGetAttribute(alias: String? = nil) -> Storefront.Attribute? {
			return field(field: "attribute", aliasSuffix: alias) as! Storefront.Attribute?
		}

		/// The attributes associated with the cart. Attributes are represented as 
		/// key-value pairs. 
		open var attributes: [Storefront.Attribute] {
			return internalGetAttributes()
		}

		func internalGetAttributes(alias: String? = nil) -> [Storefront.Attribute] {
			return field(field: "attributes", aliasSuffix: alias) as! [Storefront.Attribute]
		}

		/// Information about the buyer that's interacting with the cart. 
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

		/// The estimated costs that the buyer will pay at checkout. The costs are 
		/// subject to change and changes will be reflected at checkout. The `cost` 
		/// field uses the `buyerIdentity` field to determine [international 
		/// pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing). 
		open var cost: Storefront.CartCost {
			return internalGetCost()
		}

		func internalGetCost(alias: String? = nil) -> Storefront.CartCost {
			return field(field: "cost", aliasSuffix: alias) as! Storefront.CartCost
		}

		/// The date and time when the cart was created. 
		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(alias: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: alias) as! Date
		}

		/// The delivery groups available for the cart, based on the buyer identity 
		/// default delivery address preference or the default address of the logged-in 
		/// customer. 
		open var deliveryGroups: Storefront.CartDeliveryGroupConnection {
			return internalGetDeliveryGroups()
		}

		open func aliasedDeliveryGroups(alias: String) -> Storefront.CartDeliveryGroupConnection {
			return internalGetDeliveryGroups(alias: alias)
		}

		func internalGetDeliveryGroups(alias: String? = nil) -> Storefront.CartDeliveryGroupConnection {
			return field(field: "deliveryGroups", aliasSuffix: alias) as! Storefront.CartDeliveryGroupConnection
		}

		/// The discounts that have been applied to the entire cart. 
		open var discountAllocations: [CartDiscountAllocation] {
			return internalGetDiscountAllocations()
		}

		func internalGetDiscountAllocations(alias: String? = nil) -> [CartDiscountAllocation] {
			return field(field: "discountAllocations", aliasSuffix: alias) as! [CartDiscountAllocation]
		}

		/// The case-insensitive discount codes that the customer added at checkout. 
		open var discountCodes: [Storefront.CartDiscountCode] {
			return internalGetDiscountCodes()
		}

		func internalGetDiscountCodes(alias: String? = nil) -> [Storefront.CartDiscountCode] {
			return field(field: "discountCodes", aliasSuffix: alias) as! [Storefront.CartDiscountCode]
		}

		/// The estimated costs that the buyer will pay at checkout. The estimated 
		/// costs are subject to change and changes will be reflected at checkout. The 
		/// `estimatedCost` field uses the `buyerIdentity` field to determine 
		/// [international 
		/// pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing). 
		@available(*, deprecated, message:"Use `cost` instead.")
		open var estimatedCost: Storefront.CartEstimatedCost {
			return internalGetEstimatedCost()
		}

		func internalGetEstimatedCost(alias: String? = nil) -> Storefront.CartEstimatedCost {
			return field(field: "estimatedCost", aliasSuffix: alias) as! Storefront.CartEstimatedCost
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// A list of lines containing information about the items the customer intends 
		/// to purchase. 
		open var lines: Storefront.BaseCartLineConnection {
			return internalGetLines()
		}

		open func aliasedLines(alias: String) -> Storefront.BaseCartLineConnection {
			return internalGetLines(alias: alias)
		}

		func internalGetLines(alias: String? = nil) -> Storefront.BaseCartLineConnection {
			return field(field: "lines", aliasSuffix: alias) as! Storefront.BaseCartLineConnection
		}

		/// Returns a metafield found by namespace and key. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		open var metafields: [Storefront.Metafield?] {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> [Storefront.Metafield?] {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> [Storefront.Metafield?] {
			return field(field: "metafields", aliasSuffix: alias) as! [Storefront.Metafield?]
		}

		/// A note that's associated with the cart. For example, the note can be a 
		/// personalized message to the buyer. 
		open var note: String? {
			return internalGetNote()
		}

		func internalGetNote(alias: String? = nil) -> String? {
			return field(field: "note", aliasSuffix: alias) as! String?
		}

		/// The total number of items in the cart. 
		open var totalQuantity: Int32 {
			return internalGetTotalQuantity()
		}

		func internalGetTotalQuantity(alias: String? = nil) -> Int32 {
			return field(field: "totalQuantity", aliasSuffix: alias) as! Int32
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
					case "attribute":
					if let value = internalGetAttribute() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "attributes":
					internalGetAttributes().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "buyerIdentity":
					response.append(internalGetBuyerIdentity())
					response.append(contentsOf: internalGetBuyerIdentity().childResponseObjectMap())

					case "cost":
					response.append(internalGetCost())
					response.append(contentsOf: internalGetCost().childResponseObjectMap())

					case "deliveryGroups":
					response.append(internalGetDeliveryGroups())
					response.append(contentsOf: internalGetDeliveryGroups().childResponseObjectMap())

					case "discountAllocations":
					internalGetDiscountAllocations().forEach {
						response.append(($0 as! GraphQL.AbstractResponse))
						response.append(contentsOf: ($0 as! GraphQL.AbstractResponse).childResponseObjectMap())
					}

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

					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					internalGetMetafields().forEach {
						if let value = $0 {
							response.append(value)
							response.append(contentsOf: value.childResponseObjectMap())
						}
					}

					default:
					break
				}
			}
			return response
		}
	}
}
