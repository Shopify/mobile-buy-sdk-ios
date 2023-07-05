//
//  CartLine.swift
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
	/// Represents information about the merchandise in the cart. 
	open class CartLineQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartLine

		/// An attribute associated with the cart line. 
		///
		/// - parameters:
		///     - key: The key of the attribute.
		///
		@discardableResult
		open func attribute(alias: String? = nil, key: String, _ subfields: (AttributeQuery) -> Void) -> CartLineQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "attribute", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The attributes associated with the cart line. Attributes are represented as 
		/// key-value pairs. 
		@discardableResult
		open func attributes(alias: String? = nil, _ subfields: (AttributeQuery) -> Void) -> CartLineQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "attributes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The cost of the merchandise that the buyer will pay for at checkout. The 
		/// costs are subject to change and changes will be reflected at checkout. 
		@discardableResult
		open func cost(alias: String? = nil, _ subfields: (CartLineCostQuery) -> Void) -> CartLineQuery {
			let subquery = CartLineCostQuery()
			subfields(subquery)

			addField(field: "cost", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The discounts that have been applied to the cart line. 
		@discardableResult
		open func discountAllocations(alias: String? = nil, _ subfields: (CartDiscountAllocationQuery) -> Void) -> CartLineQuery {
			let subquery = CartDiscountAllocationQuery()
			subfields(subquery)

			addField(field: "discountAllocations", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The estimated cost of the merchandise that the buyer will pay for at 
		/// checkout. The estimated costs are subject to change and changes will be 
		/// reflected at checkout. 
		@available(*, deprecated, message:"Use `cost` instead.")
		@discardableResult
		open func estimatedCost(alias: String? = nil, _ subfields: (CartLineEstimatedCostQuery) -> Void) -> CartLineQuery {
			let subquery = CartLineEstimatedCostQuery()
			subfields(subquery)

			addField(field: "estimatedCost", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> CartLineQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The merchandise that the buyer intends to purchase. 
		@discardableResult
		open func merchandise(alias: String? = nil, _ subfields: (MerchandiseQuery) -> Void) -> CartLineQuery {
			let subquery = MerchandiseQuery()
			subfields(subquery)

			addField(field: "merchandise", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The quantity of the merchandise that the customer intends to purchase. 
		@discardableResult
		open func quantity(alias: String? = nil) -> CartLineQuery {
			addField(field: "quantity", aliasSuffix: alias)
			return self
		}

		/// The selling plan associated with the cart line and the effect that each 
		/// selling plan has on variants when they're purchased. 
		@discardableResult
		open func sellingPlanAllocation(alias: String? = nil, _ subfields: (SellingPlanAllocationQuery) -> Void) -> CartLineQuery {
			let subquery = SellingPlanAllocationQuery()
			subfields(subquery)

			addField(field: "sellingPlanAllocation", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Represents information about the merchandise in the cart. 
	open class CartLine: GraphQL.AbstractResponse, GraphQLObject, BaseCartLine, Node {
		public typealias Query = CartLineQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "attribute":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
				}
				return try Attribute(fields: value)

				case "attributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

				case "cost":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
				}
				return try CartLineCost(fields: value)

				case "discountAllocations":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try UnknownCartDiscountAllocation.create(fields: $0) }

				case "estimatedCost":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
				}
				return try CartLineEstimatedCost(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "merchandise":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
				}
				return try UnknownMerchandise.create(fields: value)

				case "quantity":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "sellingPlanAllocation":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
				}
				return try SellingPlanAllocation(fields: value)

				default:
				throw SchemaViolationError(type: CartLine.self, field: fieldName, value: fieldValue)
			}
		}

		/// An attribute associated with the cart line. 
		open var attribute: Storefront.Attribute? {
			return internalGetAttribute()
		}

		open func aliasedAttribute(alias: String) -> Storefront.Attribute? {
			return internalGetAttribute(alias: alias)
		}

		func internalGetAttribute(alias: String? = nil) -> Storefront.Attribute? {
			return field(field: "attribute", aliasSuffix: alias) as! Storefront.Attribute?
		}

		/// The attributes associated with the cart line. Attributes are represented as 
		/// key-value pairs. 
		open var attributes: [Storefront.Attribute] {
			return internalGetAttributes()
		}

		func internalGetAttributes(alias: String? = nil) -> [Storefront.Attribute] {
			return field(field: "attributes", aliasSuffix: alias) as! [Storefront.Attribute]
		}

		/// The cost of the merchandise that the buyer will pay for at checkout. The 
		/// costs are subject to change and changes will be reflected at checkout. 
		open var cost: Storefront.CartLineCost {
			return internalGetCost()
		}

		func internalGetCost(alias: String? = nil) -> Storefront.CartLineCost {
			return field(field: "cost", aliasSuffix: alias) as! Storefront.CartLineCost
		}

		/// The discounts that have been applied to the cart line. 
		open var discountAllocations: [CartDiscountAllocation] {
			return internalGetDiscountAllocations()
		}

		func internalGetDiscountAllocations(alias: String? = nil) -> [CartDiscountAllocation] {
			return field(field: "discountAllocations", aliasSuffix: alias) as! [CartDiscountAllocation]
		}

		/// The estimated cost of the merchandise that the buyer will pay for at 
		/// checkout. The estimated costs are subject to change and changes will be 
		/// reflected at checkout. 
		@available(*, deprecated, message:"Use `cost` instead.")
		open var estimatedCost: Storefront.CartLineEstimatedCost {
			return internalGetEstimatedCost()
		}

		func internalGetEstimatedCost(alias: String? = nil) -> Storefront.CartLineEstimatedCost {
			return field(field: "estimatedCost", aliasSuffix: alias) as! Storefront.CartLineEstimatedCost
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The merchandise that the buyer intends to purchase. 
		open var merchandise: Merchandise {
			return internalGetMerchandise()
		}

		func internalGetMerchandise(alias: String? = nil) -> Merchandise {
			return field(field: "merchandise", aliasSuffix: alias) as! Merchandise
		}

		/// The quantity of the merchandise that the customer intends to purchase. 
		open var quantity: Int32 {
			return internalGetQuantity()
		}

		func internalGetQuantity(alias: String? = nil) -> Int32 {
			return field(field: "quantity", aliasSuffix: alias) as! Int32
		}

		/// The selling plan associated with the cart line and the effect that each 
		/// selling plan has on variants when they're purchased. 
		open var sellingPlanAllocation: Storefront.SellingPlanAllocation? {
			return internalGetSellingPlanAllocation()
		}

		func internalGetSellingPlanAllocation(alias: String? = nil) -> Storefront.SellingPlanAllocation? {
			return field(field: "sellingPlanAllocation", aliasSuffix: alias) as! Storefront.SellingPlanAllocation?
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

					case "cost":
					response.append(internalGetCost())
					response.append(contentsOf: internalGetCost().childResponseObjectMap())

					case "discountAllocations":
					internalGetDiscountAllocations().forEach {
						response.append(($0 as! GraphQL.AbstractResponse))
						response.append(contentsOf: ($0 as! GraphQL.AbstractResponse).childResponseObjectMap())
					}

					case "estimatedCost":
					response.append(internalGetEstimatedCost())
					response.append(contentsOf: internalGetEstimatedCost().childResponseObjectMap())

					case "merchandise":
					response.append((internalGetMerchandise() as! GraphQL.AbstractResponse))
					response.append(contentsOf: (internalGetMerchandise() as! GraphQL.AbstractResponse).childResponseObjectMap())

					case "sellingPlanAllocation":
					if let value = internalGetSellingPlanAllocation() {
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
