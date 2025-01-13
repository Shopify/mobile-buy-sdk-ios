//
//  ShopPayPaymentRequest.swift
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
	/// Represents a Shop Pay payment request. 
	open class ShopPayPaymentRequestQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayPaymentRequest

		/// The delivery methods for the payment request. 
		@discardableResult
		open func deliveryMethods(alias: String? = nil, _ subfields: (ShopPayPaymentRequestDeliveryMethodQuery) -> Void) -> ShopPayPaymentRequestQuery {
			let subquery = ShopPayPaymentRequestDeliveryMethodQuery()
			subfields(subquery)

			addField(field: "deliveryMethods", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The discount codes for the payment request. 
		@discardableResult
		open func discountCodes(alias: String? = nil) -> ShopPayPaymentRequestQuery {
			addField(field: "discountCodes", aliasSuffix: alias)
			return self
		}

		/// The discounts for the payment request order. 
		@discardableResult
		open func discounts(alias: String? = nil, _ subfields: (ShopPayPaymentRequestDiscountQuery) -> Void) -> ShopPayPaymentRequestQuery {
			let subquery = ShopPayPaymentRequestDiscountQuery()
			subfields(subquery)

			addField(field: "discounts", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The line items for the payment request. 
		@discardableResult
		open func lineItems(alias: String? = nil, _ subfields: (ShopPayPaymentRequestLineItemQuery) -> Void) -> ShopPayPaymentRequestQuery {
			let subquery = ShopPayPaymentRequestLineItemQuery()
			subfields(subquery)

			addField(field: "lineItems", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The locale for the payment request. 
		@discardableResult
		open func locale(alias: String? = nil) -> ShopPayPaymentRequestQuery {
			addField(field: "locale", aliasSuffix: alias)
			return self
		}

		/// The presentment currency for the payment request. 
		@discardableResult
		open func presentmentCurrency(alias: String? = nil) -> ShopPayPaymentRequestQuery {
			addField(field: "presentmentCurrency", aliasSuffix: alias)
			return self
		}

		/// The delivery method type for the payment request. 
		@discardableResult
		open func selectedDeliveryMethodType(alias: String? = nil) -> ShopPayPaymentRequestQuery {
			addField(field: "selectedDeliveryMethodType", aliasSuffix: alias)
			return self
		}

		/// The shipping address for the payment request. 
		@discardableResult
		open func shippingAddress(alias: String? = nil, _ subfields: (ShopPayPaymentRequestContactFieldQuery) -> Void) -> ShopPayPaymentRequestQuery {
			let subquery = ShopPayPaymentRequestContactFieldQuery()
			subfields(subquery)

			addField(field: "shippingAddress", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The shipping lines for the payment request. 
		@discardableResult
		open func shippingLines(alias: String? = nil, _ subfields: (ShopPayPaymentRequestShippingLineQuery) -> Void) -> ShopPayPaymentRequestQuery {
			let subquery = ShopPayPaymentRequestShippingLineQuery()
			subfields(subquery)

			addField(field: "shippingLines", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The subtotal amount for the payment request. 
		@discardableResult
		open func subtotal(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "subtotal", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total amount for the payment request. 
		@discardableResult
		open func total(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "total", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total shipping price for the payment request. 
		@discardableResult
		open func totalShippingPrice(alias: String? = nil, _ subfields: (ShopPayPaymentRequestTotalShippingPriceQuery) -> Void) -> ShopPayPaymentRequestQuery {
			let subquery = ShopPayPaymentRequestTotalShippingPriceQuery()
			subfields(subquery)

			addField(field: "totalShippingPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total tax for the payment request. 
		@discardableResult
		open func totalTax(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalTax", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Represents a Shop Pay payment request. 
	open class ShopPayPaymentRequest: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayPaymentRequestQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "deliveryMethods":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShopPayPaymentRequestDeliveryMethod(fields: $0) }

				case "discountCodes":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "discounts":
				if value is NSNull { return nil }
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShopPayPaymentRequestDiscount(fields: $0) }

				case "lineItems":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShopPayPaymentRequestLineItem(fields: $0) }

				case "locale":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return value

				case "presentmentCurrency":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "selectedDeliveryMethodType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return ShopPayPaymentRequestDeliveryMethodType(rawValue: value) ?? .unknownValue

				case "shippingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return try ShopPayPaymentRequestContactField(fields: value)

				case "shippingLines":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShopPayPaymentRequestShippingLine(fields: $0) }

				case "subtotal":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "total":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalShippingPrice":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return try ShopPayPaymentRequestTotalShippingPrice(fields: value)

				case "totalTax":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: ShopPayPaymentRequest.self, field: fieldName, value: fieldValue)
			}
		}

		/// The delivery methods for the payment request. 
		open var deliveryMethods: [Storefront.ShopPayPaymentRequestDeliveryMethod] {
			return internalGetDeliveryMethods()
		}

		func internalGetDeliveryMethods(alias: String? = nil) -> [Storefront.ShopPayPaymentRequestDeliveryMethod] {
			return field(field: "deliveryMethods", aliasSuffix: alias) as! [Storefront.ShopPayPaymentRequestDeliveryMethod]
		}

		/// The discount codes for the payment request. 
		open var discountCodes: [String] {
			return internalGetDiscountCodes()
		}

		func internalGetDiscountCodes(alias: String? = nil) -> [String] {
			return field(field: "discountCodes", aliasSuffix: alias) as! [String]
		}

		/// The discounts for the payment request order. 
		open var discounts: [Storefront.ShopPayPaymentRequestDiscount]? {
			return internalGetDiscounts()
		}

		func internalGetDiscounts(alias: String? = nil) -> [Storefront.ShopPayPaymentRequestDiscount]? {
			return field(field: "discounts", aliasSuffix: alias) as! [Storefront.ShopPayPaymentRequestDiscount]?
		}

		/// The line items for the payment request. 
		open var lineItems: [Storefront.ShopPayPaymentRequestLineItem] {
			return internalGetLineItems()
		}

		func internalGetLineItems(alias: String? = nil) -> [Storefront.ShopPayPaymentRequestLineItem] {
			return field(field: "lineItems", aliasSuffix: alias) as! [Storefront.ShopPayPaymentRequestLineItem]
		}

		/// The locale for the payment request. 
		open var locale: String {
			return internalGetLocale()
		}

		func internalGetLocale(alias: String? = nil) -> String {
			return field(field: "locale", aliasSuffix: alias) as! String
		}

		/// The presentment currency for the payment request. 
		open var presentmentCurrency: Storefront.CurrencyCode {
			return internalGetPresentmentCurrency()
		}

		func internalGetPresentmentCurrency(alias: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "presentmentCurrency", aliasSuffix: alias) as! Storefront.CurrencyCode
		}

		/// The delivery method type for the payment request. 
		open var selectedDeliveryMethodType: Storefront.ShopPayPaymentRequestDeliveryMethodType {
			return internalGetSelectedDeliveryMethodType()
		}

		func internalGetSelectedDeliveryMethodType(alias: String? = nil) -> Storefront.ShopPayPaymentRequestDeliveryMethodType {
			return field(field: "selectedDeliveryMethodType", aliasSuffix: alias) as! Storefront.ShopPayPaymentRequestDeliveryMethodType
		}

		/// The shipping address for the payment request. 
		open var shippingAddress: Storefront.ShopPayPaymentRequestContactField? {
			return internalGetShippingAddress()
		}

		func internalGetShippingAddress(alias: String? = nil) -> Storefront.ShopPayPaymentRequestContactField? {
			return field(field: "shippingAddress", aliasSuffix: alias) as! Storefront.ShopPayPaymentRequestContactField?
		}

		/// The shipping lines for the payment request. 
		open var shippingLines: [Storefront.ShopPayPaymentRequestShippingLine] {
			return internalGetShippingLines()
		}

		func internalGetShippingLines(alias: String? = nil) -> [Storefront.ShopPayPaymentRequestShippingLine] {
			return field(field: "shippingLines", aliasSuffix: alias) as! [Storefront.ShopPayPaymentRequestShippingLine]
		}

		/// The subtotal amount for the payment request. 
		open var subtotal: Storefront.MoneyV2 {
			return internalGetSubtotal()
		}

		func internalGetSubtotal(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "subtotal", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The total amount for the payment request. 
		open var total: Storefront.MoneyV2 {
			return internalGetTotal()
		}

		func internalGetTotal(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "total", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The total shipping price for the payment request. 
		open var totalShippingPrice: Storefront.ShopPayPaymentRequestTotalShippingPrice? {
			return internalGetTotalShippingPrice()
		}

		func internalGetTotalShippingPrice(alias: String? = nil) -> Storefront.ShopPayPaymentRequestTotalShippingPrice? {
			return field(field: "totalShippingPrice", aliasSuffix: alias) as! Storefront.ShopPayPaymentRequestTotalShippingPrice?
		}

		/// The total tax for the payment request. 
		open var totalTax: Storefront.MoneyV2? {
			return internalGetTotalTax()
		}

		func internalGetTotalTax(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "totalTax", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "deliveryMethods":
					internalGetDeliveryMethods().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "discounts":
					if let value = internalGetDiscounts() {
						value.forEach {
							response.append($0)
							response.append(contentsOf: $0.childResponseObjectMap())
						}
					}

					case "lineItems":
					internalGetLineItems().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "shippingAddress":
					if let value = internalGetShippingAddress() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingLines":
					internalGetShippingLines().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "subtotal":
					response.append(internalGetSubtotal())
					response.append(contentsOf: internalGetSubtotal().childResponseObjectMap())

					case "total":
					response.append(internalGetTotal())
					response.append(contentsOf: internalGetTotal().childResponseObjectMap())

					case "totalShippingPrice":
					if let value = internalGetTotalShippingPrice() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "totalTax":
					if let value = internalGetTotalTax() {
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
