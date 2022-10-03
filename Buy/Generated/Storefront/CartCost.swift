//
//  CartCost.swift
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
	/// The costs that the buyer will pay at checkout. The cart cost uses 
	/// [`CartBuyerIdentity`](https://shopify.dev/api/storefront/reference/cart/cartbuyeridentity) 
	/// to determine [international 
	/// pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing). 
	open class CartCostQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartCost

		/// The estimated amount, before taxes and discounts, for the customer to pay 
		/// at checkout. The checkout charge amount doesn't include any deferred 
		/// payments that'll be paid at a later date. If the cart has no deferred 
		/// payments, then the checkout charge amount is equivalent to 
		/// `subtotalAmount`. 
		@discardableResult
		open func checkoutChargeAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartCostQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "checkoutChargeAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The amount, before taxes and cart-level discounts, for the customer to pay. 
		@discardableResult
		open func subtotalAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartCostQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "subtotalAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Whether the subtotal amount is estimated. 
		@discardableResult
		open func subtotalAmountEstimated(alias: String? = nil) -> CartCostQuery {
			addField(field: "subtotalAmountEstimated", aliasSuffix: alias)
			return self
		}

		/// The total amount for the customer to pay. 
		@discardableResult
		open func totalAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartCostQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Whether the total amount is estimated. 
		@discardableResult
		open func totalAmountEstimated(alias: String? = nil) -> CartCostQuery {
			addField(field: "totalAmountEstimated", aliasSuffix: alias)
			return self
		}

		/// The duty amount for the customer to pay at checkout. 
		@discardableResult
		open func totalDutyAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartCostQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalDutyAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Whether the total duty amount is estimated. 
		@discardableResult
		open func totalDutyAmountEstimated(alias: String? = nil) -> CartCostQuery {
			addField(field: "totalDutyAmountEstimated", aliasSuffix: alias)
			return self
		}

		/// The tax amount for the customer to pay at checkout. 
		@discardableResult
		open func totalTaxAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CartCostQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalTaxAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Whether the total tax amount is estimated. 
		@discardableResult
		open func totalTaxAmountEstimated(alias: String? = nil) -> CartCostQuery {
			addField(field: "totalTaxAmountEstimated", aliasSuffix: alias)
			return self
		}
	}

	/// The costs that the buyer will pay at checkout. The cart cost uses 
	/// [`CartBuyerIdentity`](https://shopify.dev/api/storefront/reference/cart/cartbuyeridentity) 
	/// to determine [international 
	/// pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing). 
	open class CartCost: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartCostQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "checkoutChargeAmount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "subtotalAmount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "subtotalAmountEstimated":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
				}
				return value

				case "totalAmount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalAmountEstimated":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
				}
				return value

				case "totalDutyAmount":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalDutyAmountEstimated":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
				}
				return value

				case "totalTaxAmount":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalTaxAmountEstimated":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: CartCost.self, field: fieldName, value: fieldValue)
			}
		}

		/// The estimated amount, before taxes and discounts, for the customer to pay 
		/// at checkout. The checkout charge amount doesn't include any deferred 
		/// payments that'll be paid at a later date. If the cart has no deferred 
		/// payments, then the checkout charge amount is equivalent to 
		/// `subtotalAmount`. 
		open var checkoutChargeAmount: Storefront.MoneyV2 {
			return internalGetCheckoutChargeAmount()
		}

		func internalGetCheckoutChargeAmount(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "checkoutChargeAmount", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The amount, before taxes and cart-level discounts, for the customer to pay. 
		open var subtotalAmount: Storefront.MoneyV2 {
			return internalGetSubtotalAmount()
		}

		func internalGetSubtotalAmount(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "subtotalAmount", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// Whether the subtotal amount is estimated. 
		open var subtotalAmountEstimated: Bool {
			return internalGetSubtotalAmountEstimated()
		}

		func internalGetSubtotalAmountEstimated(alias: String? = nil) -> Bool {
			return field(field: "subtotalAmountEstimated", aliasSuffix: alias) as! Bool
		}

		/// The total amount for the customer to pay. 
		open var totalAmount: Storefront.MoneyV2 {
			return internalGetTotalAmount()
		}

		func internalGetTotalAmount(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalAmount", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// Whether the total amount is estimated. 
		open var totalAmountEstimated: Bool {
			return internalGetTotalAmountEstimated()
		}

		func internalGetTotalAmountEstimated(alias: String? = nil) -> Bool {
			return field(field: "totalAmountEstimated", aliasSuffix: alias) as! Bool
		}

		/// The duty amount for the customer to pay at checkout. 
		open var totalDutyAmount: Storefront.MoneyV2? {
			return internalGetTotalDutyAmount()
		}

		func internalGetTotalDutyAmount(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "totalDutyAmount", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// Whether the total duty amount is estimated. 
		open var totalDutyAmountEstimated: Bool {
			return internalGetTotalDutyAmountEstimated()
		}

		func internalGetTotalDutyAmountEstimated(alias: String? = nil) -> Bool {
			return field(field: "totalDutyAmountEstimated", aliasSuffix: alias) as! Bool
		}

		/// The tax amount for the customer to pay at checkout. 
		open var totalTaxAmount: Storefront.MoneyV2? {
			return internalGetTotalTaxAmount()
		}

		func internalGetTotalTaxAmount(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "totalTaxAmount", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// Whether the total tax amount is estimated. 
		open var totalTaxAmountEstimated: Bool {
			return internalGetTotalTaxAmountEstimated()
		}

		func internalGetTotalTaxAmountEstimated(alias: String? = nil) -> Bool {
			return field(field: "totalTaxAmountEstimated", aliasSuffix: alias) as! Bool
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "checkoutChargeAmount":
					response.append(internalGetCheckoutChargeAmount())
					response.append(contentsOf: internalGetCheckoutChargeAmount().childResponseObjectMap())

					case "subtotalAmount":
					response.append(internalGetSubtotalAmount())
					response.append(contentsOf: internalGetSubtotalAmount().childResponseObjectMap())

					case "totalAmount":
					response.append(internalGetTotalAmount())
					response.append(contentsOf: internalGetTotalAmount().childResponseObjectMap())

					case "totalDutyAmount":
					if let value = internalGetTotalDutyAmount() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "totalTaxAmount":
					if let value = internalGetTotalTaxAmount() {
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
