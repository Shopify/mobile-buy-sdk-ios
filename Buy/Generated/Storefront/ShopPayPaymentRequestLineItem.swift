//
//  ShopPayPaymentRequestLineItem.swift
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
	/// Represents a line item for a Shop Pay payment request. 
	open class ShopPayPaymentRequestLineItemQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayPaymentRequestLineItem

		/// The final item price for the line item. 
		@discardableResult
		open func finalItemPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestLineItemQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "finalItemPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The final line price for the line item. 
		@discardableResult
		open func finalLinePrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestLineItemQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "finalLinePrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The image of the line item. 
		@discardableResult
		open func image(alias: String? = nil, _ subfields: (ShopPayPaymentRequestImageQuery) -> Void) -> ShopPayPaymentRequestLineItemQuery {
			let subquery = ShopPayPaymentRequestImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The item discounts for the line item. 
		@discardableResult
		open func itemDiscounts(alias: String? = nil, _ subfields: (ShopPayPaymentRequestDiscountQuery) -> Void) -> ShopPayPaymentRequestLineItemQuery {
			let subquery = ShopPayPaymentRequestDiscountQuery()
			subfields(subquery)

			addField(field: "itemDiscounts", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The label of the line item. 
		@discardableResult
		open func label(alias: String? = nil) -> ShopPayPaymentRequestLineItemQuery {
			addField(field: "label", aliasSuffix: alias)
			return self
		}

		/// The line discounts for the line item. 
		@discardableResult
		open func lineDiscounts(alias: String? = nil, _ subfields: (ShopPayPaymentRequestDiscountQuery) -> Void) -> ShopPayPaymentRequestLineItemQuery {
			let subquery = ShopPayPaymentRequestDiscountQuery()
			subfields(subquery)

			addField(field: "lineDiscounts", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The original item price for the line item. 
		@discardableResult
		open func originalItemPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestLineItemQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "originalItemPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The original line price for the line item. 
		@discardableResult
		open func originalLinePrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayPaymentRequestLineItemQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "originalLinePrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The quantity of the line item. 
		@discardableResult
		open func quantity(alias: String? = nil) -> ShopPayPaymentRequestLineItemQuery {
			addField(field: "quantity", aliasSuffix: alias)
			return self
		}

		/// Whether the line item requires shipping. 
		@discardableResult
		open func requiresShipping(alias: String? = nil) -> ShopPayPaymentRequestLineItemQuery {
			addField(field: "requiresShipping", aliasSuffix: alias)
			return self
		}

		/// The SKU of the line item. 
		@discardableResult
		open func sku(alias: String? = nil) -> ShopPayPaymentRequestLineItemQuery {
			addField(field: "sku", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a line item for a Shop Pay payment request. 
	open class ShopPayPaymentRequestLineItem: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayPaymentRequestLineItemQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "finalItemPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "finalLinePrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return try ShopPayPaymentRequestImage(fields: value)

				case "itemDiscounts":
				if value is NSNull { return nil }
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShopPayPaymentRequestDiscount(fields: $0) }

				case "label":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return value

				case "lineDiscounts":
				if value is NSNull { return nil }
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ShopPayPaymentRequestDiscount(fields: $0) }

				case "originalItemPrice":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "originalLinePrice":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "quantity":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "requiresShipping":
				if value is NSNull { return nil }
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return value

				case "sku":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ShopPayPaymentRequestLineItem.self, field: fieldName, value: fieldValue)
			}
		}

		/// The final item price for the line item. 
		open var finalItemPrice: Storefront.MoneyV2 {
			return internalGetFinalItemPrice()
		}

		func internalGetFinalItemPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "finalItemPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The final line price for the line item. 
		open var finalLinePrice: Storefront.MoneyV2 {
			return internalGetFinalLinePrice()
		}

		func internalGetFinalLinePrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "finalLinePrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The image of the line item. 
		open var image: Storefront.ShopPayPaymentRequestImage? {
			return internalGetImage()
		}

		func internalGetImage(alias: String? = nil) -> Storefront.ShopPayPaymentRequestImage? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.ShopPayPaymentRequestImage?
		}

		/// The item discounts for the line item. 
		open var itemDiscounts: [Storefront.ShopPayPaymentRequestDiscount]? {
			return internalGetItemDiscounts()
		}

		func internalGetItemDiscounts(alias: String? = nil) -> [Storefront.ShopPayPaymentRequestDiscount]? {
			return field(field: "itemDiscounts", aliasSuffix: alias) as! [Storefront.ShopPayPaymentRequestDiscount]?
		}

		/// The label of the line item. 
		open var label: String {
			return internalGetLabel()
		}

		func internalGetLabel(alias: String? = nil) -> String {
			return field(field: "label", aliasSuffix: alias) as! String
		}

		/// The line discounts for the line item. 
		open var lineDiscounts: [Storefront.ShopPayPaymentRequestDiscount]? {
			return internalGetLineDiscounts()
		}

		func internalGetLineDiscounts(alias: String? = nil) -> [Storefront.ShopPayPaymentRequestDiscount]? {
			return field(field: "lineDiscounts", aliasSuffix: alias) as! [Storefront.ShopPayPaymentRequestDiscount]?
		}

		/// The original item price for the line item. 
		open var originalItemPrice: Storefront.MoneyV2? {
			return internalGetOriginalItemPrice()
		}

		func internalGetOriginalItemPrice(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "originalItemPrice", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// The original line price for the line item. 
		open var originalLinePrice: Storefront.MoneyV2? {
			return internalGetOriginalLinePrice()
		}

		func internalGetOriginalLinePrice(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "originalLinePrice", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// The quantity of the line item. 
		open var quantity: Int32 {
			return internalGetQuantity()
		}

		func internalGetQuantity(alias: String? = nil) -> Int32 {
			return field(field: "quantity", aliasSuffix: alias) as! Int32
		}

		/// Whether the line item requires shipping. 
		open var requiresShipping: Bool? {
			return internalGetRequiresShipping()
		}

		func internalGetRequiresShipping(alias: String? = nil) -> Bool? {
			return field(field: "requiresShipping", aliasSuffix: alias) as! Bool?
		}

		/// The SKU of the line item. 
		open var sku: String? {
			return internalGetSku()
		}

		func internalGetSku(alias: String? = nil) -> String? {
			return field(field: "sku", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "finalItemPrice":
					response.append(internalGetFinalItemPrice())
					response.append(contentsOf: internalGetFinalItemPrice().childResponseObjectMap())

					case "finalLinePrice":
					response.append(internalGetFinalLinePrice())
					response.append(contentsOf: internalGetFinalLinePrice().childResponseObjectMap())

					case "image":
					if let value = internalGetImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "itemDiscounts":
					if let value = internalGetItemDiscounts() {
						value.forEach {
							response.append($0)
							response.append(contentsOf: $0.childResponseObjectMap())
						}
					}

					case "lineDiscounts":
					if let value = internalGetLineDiscounts() {
						value.forEach {
							response.append($0)
							response.append(contentsOf: $0.childResponseObjectMap())
						}
					}

					case "originalItemPrice":
					if let value = internalGetOriginalItemPrice() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "originalLinePrice":
					if let value = internalGetOriginalLinePrice() {
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
