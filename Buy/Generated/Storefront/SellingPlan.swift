//
//  SellingPlan.swift
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
	/// Represents how products and variants can be sold and purchased. 
	open class SellingPlanQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlan

		/// The initial payment due for the purchase. 
		@discardableResult
		open func checkoutCharge(alias: String? = nil, _ subfields: (SellingPlanCheckoutChargeQuery) -> Void) -> SellingPlanQuery {
			let subquery = SellingPlanCheckoutChargeQuery()
			subfields(subquery)

			addField(field: "checkoutCharge", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The description of the selling plan. 
		@discardableResult
		open func description(alias: String? = nil) -> SellingPlanQuery {
			addField(field: "description", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> SellingPlanQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The name of the selling plan. For example, '6 weeks of prepaid granola, 
		/// delivered weekly'. 
		@discardableResult
		open func name(alias: String? = nil) -> SellingPlanQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// The selling plan options available in the drop-down list in the storefront. 
		/// For example, 'Delivery every week' or 'Delivery every 2 weeks' specifies 
		/// the delivery frequency options for the product. Individual selling plans 
		/// contribute their options to the associated selling plan group. For example, 
		/// a selling plan group might have an option called `option1: Delivery every`. 
		/// One selling plan in that group could contribute `option1: 2 weeks` with the 
		/// pricing for that option, and another selling plan could contribute 
		/// `option1: 4 weeks`, with different pricing. 
		@discardableResult
		open func options(alias: String? = nil, _ subfields: (SellingPlanOptionQuery) -> Void) -> SellingPlanQuery {
			let subquery = SellingPlanOptionQuery()
			subfields(subquery)

			addField(field: "options", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The price adjustments that a selling plan makes when a variant is purchased 
		/// with a selling plan. 
		@discardableResult
		open func priceAdjustments(alias: String? = nil, _ subfields: (SellingPlanPriceAdjustmentQuery) -> Void) -> SellingPlanQuery {
			let subquery = SellingPlanPriceAdjustmentQuery()
			subfields(subquery)

			addField(field: "priceAdjustments", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Whether purchasing the selling plan will result in multiple deliveries. 
		@discardableResult
		open func recurringDeliveries(alias: String? = nil) -> SellingPlanQuery {
			addField(field: "recurringDeliveries", aliasSuffix: alias)
			return self
		}
	}

	/// Represents how products and variants can be sold and purchased. 
	open class SellingPlan: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SellingPlanQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "checkoutCharge":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlan.self, field: fieldName, value: fieldValue)
				}
				return try SellingPlanCheckoutCharge(fields: value)

				case "description":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: SellingPlan.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SellingPlan.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SellingPlan.self, field: fieldName, value: fieldValue)
				}
				return value

				case "options":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: SellingPlan.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try SellingPlanOption(fields: $0) }

				case "priceAdjustments":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: SellingPlan.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try SellingPlanPriceAdjustment(fields: $0) }

				case "recurringDeliveries":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: SellingPlan.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: SellingPlan.self, field: fieldName, value: fieldValue)
			}
		}

		/// The initial payment due for the purchase. 
		open var checkoutCharge: Storefront.SellingPlanCheckoutCharge {
			return internalGetCheckoutCharge()
		}

		func internalGetCheckoutCharge(alias: String? = nil) -> Storefront.SellingPlanCheckoutCharge {
			return field(field: "checkoutCharge", aliasSuffix: alias) as! Storefront.SellingPlanCheckoutCharge
		}

		/// The description of the selling plan. 
		open var description: String? {
			return internalGetDescription()
		}

		func internalGetDescription(alias: String? = nil) -> String? {
			return field(field: "description", aliasSuffix: alias) as! String?
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The name of the selling plan. For example, '6 weeks of prepaid granola, 
		/// delivered weekly'. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// The selling plan options available in the drop-down list in the storefront. 
		/// For example, 'Delivery every week' or 'Delivery every 2 weeks' specifies 
		/// the delivery frequency options for the product. Individual selling plans 
		/// contribute their options to the associated selling plan group. For example, 
		/// a selling plan group might have an option called `option1: Delivery every`. 
		/// One selling plan in that group could contribute `option1: 2 weeks` with the 
		/// pricing for that option, and another selling plan could contribute 
		/// `option1: 4 weeks`, with different pricing. 
		open var options: [Storefront.SellingPlanOption] {
			return internalGetOptions()
		}

		func internalGetOptions(alias: String? = nil) -> [Storefront.SellingPlanOption] {
			return field(field: "options", aliasSuffix: alias) as! [Storefront.SellingPlanOption]
		}

		/// The price adjustments that a selling plan makes when a variant is purchased 
		/// with a selling plan. 
		open var priceAdjustments: [Storefront.SellingPlanPriceAdjustment] {
			return internalGetPriceAdjustments()
		}

		func internalGetPriceAdjustments(alias: String? = nil) -> [Storefront.SellingPlanPriceAdjustment] {
			return field(field: "priceAdjustments", aliasSuffix: alias) as! [Storefront.SellingPlanPriceAdjustment]
		}

		/// Whether purchasing the selling plan will result in multiple deliveries. 
		open var recurringDeliveries: Bool {
			return internalGetRecurringDeliveries()
		}

		func internalGetRecurringDeliveries(alias: String? = nil) -> Bool {
			return field(field: "recurringDeliveries", aliasSuffix: alias) as! Bool
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "checkoutCharge":
					response.append(internalGetCheckoutCharge())
					response.append(contentsOf: internalGetCheckoutCharge().childResponseObjectMap())

					case "options":
					internalGetOptions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "priceAdjustments":
					internalGetPriceAdjustments().forEach {
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
