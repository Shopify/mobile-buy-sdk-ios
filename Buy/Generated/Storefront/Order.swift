//
//  Order.swift
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
	/// An order is a customer’s completed request to purchase one or more products 
	/// from a shop. An order is created when a customer completes the checkout 
	/// process, during which time they provides an email address, billing address 
	/// and payment information. 
	open class OrderQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Order

		/// The address associated with the payment method. 
		@discardableResult
		open func billingAddress(alias: String? = nil, _ subfields: (MailingAddressQuery) -> Void) -> OrderQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)

			addField(field: "billingAddress", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The reason for the order's cancellation. Returns `null` if the order wasn't 
		/// canceled. 
		@discardableResult
		open func cancelReason(alias: String? = nil) -> OrderQuery {
			addField(field: "cancelReason", aliasSuffix: alias)
			return self
		}

		/// The date and time when the order was canceled. Returns null if the order 
		/// wasn't canceled. 
		@discardableResult
		open func canceledAt(alias: String? = nil) -> OrderQuery {
			addField(field: "canceledAt", aliasSuffix: alias)
			return self
		}

		/// The code of the currency used for the payment. 
		@discardableResult
		open func currencyCode(alias: String? = nil) -> OrderQuery {
			addField(field: "currencyCode", aliasSuffix: alias)
			return self
		}

		/// The subtotal of line items and their discounts, excluding line items that 
		/// have been removed. Does not contain order-level discounts, duties, shipping 
		/// costs, or shipping discounts. Taxes aren't included unless the order is a 
		/// taxes-included order. 
		@discardableResult
		open func currentSubtotalPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "currentSubtotalPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total cost of duties for the order, including refunds. 
		@discardableResult
		open func currentTotalDuties(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "currentTotalDuties", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total amount of the order, including duties, taxes and discounts, minus 
		/// amounts for line items that have been removed. 
		@discardableResult
		open func currentTotalPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "currentTotalPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total of all taxes applied to the order, excluding taxes for returned 
		/// line items. 
		@discardableResult
		open func currentTotalTax(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "currentTotalTax", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of the custom attributes added to the order. 
		@discardableResult
		open func customAttributes(alias: String? = nil, _ subfields: (AttributeQuery) -> Void) -> OrderQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "customAttributes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The locale code in which this specific order happened. 
		@discardableResult
		open func customerLocale(alias: String? = nil) -> OrderQuery {
			addField(field: "customerLocale", aliasSuffix: alias)
			return self
		}

		/// The unique URL that the customer can use to access the order. 
		@discardableResult
		open func customerUrl(alias: String? = nil) -> OrderQuery {
			addField(field: "customerUrl", aliasSuffix: alias)
			return self
		}

		/// Discounts that have been applied on the order. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func discountApplications(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (DiscountApplicationConnectionQuery) -> Void) -> OrderQuery {
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

			let subquery = DiscountApplicationConnectionQuery()
			subfields(subquery)

			addField(field: "discountApplications", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Whether the order has had any edits applied or not. 
		@discardableResult
		open func edited(alias: String? = nil) -> OrderQuery {
			addField(field: "edited", aliasSuffix: alias)
			return self
		}

		/// The customer's email address. 
		@discardableResult
		open func email(alias: String? = nil) -> OrderQuery {
			addField(field: "email", aliasSuffix: alias)
			return self
		}

		/// The financial status of the order. 
		@discardableResult
		open func financialStatus(alias: String? = nil) -> OrderQuery {
			addField(field: "financialStatus", aliasSuffix: alias)
			return self
		}

		/// The fulfillment status for the order. 
		@discardableResult
		open func fulfillmentStatus(alias: String? = nil) -> OrderQuery {
			addField(field: "fulfillmentStatus", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> OrderQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// List of the order’s line items. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func lineItems(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (OrderLineItemConnectionQuery) -> Void) -> OrderQuery {
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

			let subquery = OrderLineItemConnectionQuery()
			subfields(subquery)

			addField(field: "lineItems", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Returns a metafield found by namespace and key. 
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> OrderQuery {
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
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> OrderQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map{ "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Unique identifier for the order that appears on the order. For example, 
		/// _#1000_ or _Store1001. 
		@discardableResult
		open func name(alias: String? = nil) -> OrderQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// A unique numeric identifier for the order for use by shop owner and 
		/// customer. 
		@discardableResult
		open func orderNumber(alias: String? = nil) -> OrderQuery {
			addField(field: "orderNumber", aliasSuffix: alias)
			return self
		}

		/// The total cost of duties charged at checkout. 
		@discardableResult
		open func originalTotalDuties(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "originalTotalDuties", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total price of the order before any applied edits. 
		@discardableResult
		open func originalTotalPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "originalTotalPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The customer's phone number for receiving SMS notifications. 
		@discardableResult
		open func phone(alias: String? = nil) -> OrderQuery {
			addField(field: "phone", aliasSuffix: alias)
			return self
		}

		/// The date and time when the order was imported. This value can be set to 
		/// dates in the past when importing from other systems. If no value is 
		/// provided, it will be auto-generated based on current date and time. 
		@discardableResult
		open func processedAt(alias: String? = nil) -> OrderQuery {
			addField(field: "processedAt", aliasSuffix: alias)
			return self
		}

		/// The address to where the order will be shipped. 
		@discardableResult
		open func shippingAddress(alias: String? = nil, _ subfields: (MailingAddressQuery) -> Void) -> OrderQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)

			addField(field: "shippingAddress", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The discounts that have been allocated onto the shipping line by discount 
		/// applications. 
		@discardableResult
		open func shippingDiscountAllocations(alias: String? = nil, _ subfields: (DiscountAllocationQuery) -> Void) -> OrderQuery {
			let subquery = DiscountAllocationQuery()
			subfields(subquery)

			addField(field: "shippingDiscountAllocations", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The unique URL for the order's status page. 
		@discardableResult
		open func statusUrl(alias: String? = nil) -> OrderQuery {
			addField(field: "statusUrl", aliasSuffix: alias)
			return self
		}

		/// Price of the order before shipping and taxes. 
		@discardableResult
		open func subtotalPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "subtotalPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Price of the order before duties, shipping and taxes. 
		@available(*, deprecated, message:"Use `subtotalPrice` instead.")
		@discardableResult
		open func subtotalPriceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "subtotalPriceV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// List of the order’s successful fulfillments. 
		///
		/// - parameters:
		///     - first: Truncate the array result to this size.
		///
		@discardableResult
		open func successfulFulfillments(alias: String? = nil, first: Int32? = nil, _ subfields: (FulfillmentQuery) -> Void) -> OrderQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = FulfillmentQuery()
			subfields(subquery)

			addField(field: "successfulFulfillments", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The sum of all the prices of all the items in the order, duties, taxes and 
		/// discounts included (must be positive). 
		@discardableResult
		open func totalPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The sum of all the prices of all the items in the order, duties, taxes and 
		/// discounts included (must be positive). 
		@available(*, deprecated, message:"Use `totalPrice` instead.")
		@discardableResult
		open func totalPriceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalPriceV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total amount that has been refunded. 
		@discardableResult
		open func totalRefunded(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalRefunded", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total amount that has been refunded. 
		@available(*, deprecated, message:"Use `totalRefunded` instead.")
		@discardableResult
		open func totalRefundedV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalRefundedV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total cost of shipping. 
		@discardableResult
		open func totalShippingPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalShippingPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total cost of shipping. 
		@available(*, deprecated, message:"Use `totalShippingPrice` instead.")
		@discardableResult
		open func totalShippingPriceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalShippingPriceV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total cost of taxes. 
		@discardableResult
		open func totalTax(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalTax", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The total cost of taxes. 
		@available(*, deprecated, message:"Use `totalTax` instead.")
		@discardableResult
		open func totalTaxV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> OrderQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalTaxV2", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// An order is a customer’s completed request to purchase one or more products 
	/// from a shop. An order is created when a customer completes the checkout 
	/// process, during which time they provides an email address, billing address 
	/// and payment information. 
	open class Order: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MetafieldParentResource, Node {
		public typealias Query = OrderQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "billingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "cancelReason":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return OrderCancelReason(rawValue: value) ?? .unknownValue

				case "canceledAt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "currentSubtotalPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "currentTotalDuties":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "currentTotalPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "currentTotalTax":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "customAttributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

				case "customerLocale":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return value

				case "customerUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "discountApplications":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try DiscountApplicationConnection(fields: value)

				case "edited":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return value

				case "email":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return value

				case "financialStatus":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return OrderFinancialStatus(rawValue: value) ?? .unknownValue

				case "fulfillmentStatus":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return OrderFulfillmentStatus(rawValue: value) ?? .unknownValue

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lineItems":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try OrderLineItemConnection(fields: value)

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return value

				case "orderNumber":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "originalTotalDuties":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "originalTotalPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "phone":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return value

				case "processedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "shippingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "shippingDiscountAllocations":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try DiscountAllocation(fields: $0) }

				case "statusUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "subtotalPrice":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "subtotalPriceV2":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "successfulFulfillments":
				if value is NSNull { return nil }
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Fulfillment(fields: $0) }

				case "totalPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalPriceV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalRefunded":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalRefundedV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalShippingPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalShippingPriceV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalTax":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalTaxV2":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: Order.self, field: fieldName, value: fieldValue)
			}
		}

		/// The address associated with the payment method. 
		open var billingAddress: Storefront.MailingAddress? {
			return internalGetBillingAddress()
		}

		func internalGetBillingAddress(alias: String? = nil) -> Storefront.MailingAddress? {
			return field(field: "billingAddress", aliasSuffix: alias) as! Storefront.MailingAddress?
		}

		/// The reason for the order's cancellation. Returns `null` if the order wasn't 
		/// canceled. 
		open var cancelReason: Storefront.OrderCancelReason? {
			return internalGetCancelReason()
		}

		func internalGetCancelReason(alias: String? = nil) -> Storefront.OrderCancelReason? {
			return field(field: "cancelReason", aliasSuffix: alias) as! Storefront.OrderCancelReason?
		}

		/// The date and time when the order was canceled. Returns null if the order 
		/// wasn't canceled. 
		open var canceledAt: Date? {
			return internalGetCanceledAt()
		}

		func internalGetCanceledAt(alias: String? = nil) -> Date? {
			return field(field: "canceledAt", aliasSuffix: alias) as! Date?
		}

		/// The code of the currency used for the payment. 
		open var currencyCode: Storefront.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(alias: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: alias) as! Storefront.CurrencyCode
		}

		/// The subtotal of line items and their discounts, excluding line items that 
		/// have been removed. Does not contain order-level discounts, duties, shipping 
		/// costs, or shipping discounts. Taxes aren't included unless the order is a 
		/// taxes-included order. 
		open var currentSubtotalPrice: Storefront.MoneyV2 {
			return internalGetCurrentSubtotalPrice()
		}

		func internalGetCurrentSubtotalPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "currentSubtotalPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The total cost of duties for the order, including refunds. 
		open var currentTotalDuties: Storefront.MoneyV2? {
			return internalGetCurrentTotalDuties()
		}

		func internalGetCurrentTotalDuties(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "currentTotalDuties", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// The total amount of the order, including duties, taxes and discounts, minus 
		/// amounts for line items that have been removed. 
		open var currentTotalPrice: Storefront.MoneyV2 {
			return internalGetCurrentTotalPrice()
		}

		func internalGetCurrentTotalPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "currentTotalPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The total of all taxes applied to the order, excluding taxes for returned 
		/// line items. 
		open var currentTotalTax: Storefront.MoneyV2 {
			return internalGetCurrentTotalTax()
		}

		func internalGetCurrentTotalTax(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "currentTotalTax", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// A list of the custom attributes added to the order. 
		open var customAttributes: [Storefront.Attribute] {
			return internalGetCustomAttributes()
		}

		func internalGetCustomAttributes(alias: String? = nil) -> [Storefront.Attribute] {
			return field(field: "customAttributes", aliasSuffix: alias) as! [Storefront.Attribute]
		}

		/// The locale code in which this specific order happened. 
		open var customerLocale: String? {
			return internalGetCustomerLocale()
		}

		func internalGetCustomerLocale(alias: String? = nil) -> String? {
			return field(field: "customerLocale", aliasSuffix: alias) as! String?
		}

		/// The unique URL that the customer can use to access the order. 
		open var customerUrl: URL? {
			return internalGetCustomerUrl()
		}

		func internalGetCustomerUrl(alias: String? = nil) -> URL? {
			return field(field: "customerUrl", aliasSuffix: alias) as! URL?
		}

		/// Discounts that have been applied on the order. 
		open var discountApplications: Storefront.DiscountApplicationConnection {
			return internalGetDiscountApplications()
		}

		open func aliasedDiscountApplications(alias: String) -> Storefront.DiscountApplicationConnection {
			return internalGetDiscountApplications(alias: alias)
		}

		func internalGetDiscountApplications(alias: String? = nil) -> Storefront.DiscountApplicationConnection {
			return field(field: "discountApplications", aliasSuffix: alias) as! Storefront.DiscountApplicationConnection
		}

		/// Whether the order has had any edits applied or not. 
		open var edited: Bool {
			return internalGetEdited()
		}

		func internalGetEdited(alias: String? = nil) -> Bool {
			return field(field: "edited", aliasSuffix: alias) as! Bool
		}

		/// The customer's email address. 
		open var email: String? {
			return internalGetEmail()
		}

		func internalGetEmail(alias: String? = nil) -> String? {
			return field(field: "email", aliasSuffix: alias) as! String?
		}

		/// The financial status of the order. 
		open var financialStatus: Storefront.OrderFinancialStatus? {
			return internalGetFinancialStatus()
		}

		func internalGetFinancialStatus(alias: String? = nil) -> Storefront.OrderFinancialStatus? {
			return field(field: "financialStatus", aliasSuffix: alias) as! Storefront.OrderFinancialStatus?
		}

		/// The fulfillment status for the order. 
		open var fulfillmentStatus: Storefront.OrderFulfillmentStatus {
			return internalGetFulfillmentStatus()
		}

		func internalGetFulfillmentStatus(alias: String? = nil) -> Storefront.OrderFulfillmentStatus {
			return field(field: "fulfillmentStatus", aliasSuffix: alias) as! Storefront.OrderFulfillmentStatus
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// List of the order’s line items. 
		open var lineItems: Storefront.OrderLineItemConnection {
			return internalGetLineItems()
		}

		open func aliasedLineItems(alias: String) -> Storefront.OrderLineItemConnection {
			return internalGetLineItems(alias: alias)
		}

		func internalGetLineItems(alias: String? = nil) -> Storefront.OrderLineItemConnection {
			return field(field: "lineItems", aliasSuffix: alias) as! Storefront.OrderLineItemConnection
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

		/// Unique identifier for the order that appears on the order. For example, 
		/// _#1000_ or _Store1001. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// A unique numeric identifier for the order for use by shop owner and 
		/// customer. 
		open var orderNumber: Int32 {
			return internalGetOrderNumber()
		}

		func internalGetOrderNumber(alias: String? = nil) -> Int32 {
			return field(field: "orderNumber", aliasSuffix: alias) as! Int32
		}

		/// The total cost of duties charged at checkout. 
		open var originalTotalDuties: Storefront.MoneyV2? {
			return internalGetOriginalTotalDuties()
		}

		func internalGetOriginalTotalDuties(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "originalTotalDuties", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// The total price of the order before any applied edits. 
		open var originalTotalPrice: Storefront.MoneyV2 {
			return internalGetOriginalTotalPrice()
		}

		func internalGetOriginalTotalPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "originalTotalPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The customer's phone number for receiving SMS notifications. 
		open var phone: String? {
			return internalGetPhone()
		}

		func internalGetPhone(alias: String? = nil) -> String? {
			return field(field: "phone", aliasSuffix: alias) as! String?
		}

		/// The date and time when the order was imported. This value can be set to 
		/// dates in the past when importing from other systems. If no value is 
		/// provided, it will be auto-generated based on current date and time. 
		open var processedAt: Date {
			return internalGetProcessedAt()
		}

		func internalGetProcessedAt(alias: String? = nil) -> Date {
			return field(field: "processedAt", aliasSuffix: alias) as! Date
		}

		/// The address to where the order will be shipped. 
		open var shippingAddress: Storefront.MailingAddress? {
			return internalGetShippingAddress()
		}

		func internalGetShippingAddress(alias: String? = nil) -> Storefront.MailingAddress? {
			return field(field: "shippingAddress", aliasSuffix: alias) as! Storefront.MailingAddress?
		}

		/// The discounts that have been allocated onto the shipping line by discount 
		/// applications. 
		open var shippingDiscountAllocations: [Storefront.DiscountAllocation] {
			return internalGetShippingDiscountAllocations()
		}

		func internalGetShippingDiscountAllocations(alias: String? = nil) -> [Storefront.DiscountAllocation] {
			return field(field: "shippingDiscountAllocations", aliasSuffix: alias) as! [Storefront.DiscountAllocation]
		}

		/// The unique URL for the order's status page. 
		open var statusUrl: URL {
			return internalGetStatusUrl()
		}

		func internalGetStatusUrl(alias: String? = nil) -> URL {
			return field(field: "statusUrl", aliasSuffix: alias) as! URL
		}

		/// Price of the order before shipping and taxes. 
		open var subtotalPrice: Storefront.MoneyV2? {
			return internalGetSubtotalPrice()
		}

		func internalGetSubtotalPrice(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "subtotalPrice", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// Price of the order before duties, shipping and taxes. 
		@available(*, deprecated, message:"Use `subtotalPrice` instead.")
		open var subtotalPriceV2: Storefront.MoneyV2? {
			return internalGetSubtotalPriceV2()
		}

		func internalGetSubtotalPriceV2(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "subtotalPriceV2", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// List of the order’s successful fulfillments. 
		open var successfulFulfillments: [Storefront.Fulfillment]? {
			return internalGetSuccessfulFulfillments()
		}

		open func aliasedSuccessfulFulfillments(alias: String) -> [Storefront.Fulfillment]? {
			return internalGetSuccessfulFulfillments(alias: alias)
		}

		func internalGetSuccessfulFulfillments(alias: String? = nil) -> [Storefront.Fulfillment]? {
			return field(field: "successfulFulfillments", aliasSuffix: alias) as! [Storefront.Fulfillment]?
		}

		/// The sum of all the prices of all the items in the order, duties, taxes and 
		/// discounts included (must be positive). 
		open var totalPrice: Storefront.MoneyV2 {
			return internalGetTotalPrice()
		}

		func internalGetTotalPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The sum of all the prices of all the items in the order, duties, taxes and 
		/// discounts included (must be positive). 
		@available(*, deprecated, message:"Use `totalPrice` instead.")
		open var totalPriceV2: Storefront.MoneyV2 {
			return internalGetTotalPriceV2()
		}

		func internalGetTotalPriceV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalPriceV2", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The total amount that has been refunded. 
		open var totalRefunded: Storefront.MoneyV2 {
			return internalGetTotalRefunded()
		}

		func internalGetTotalRefunded(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalRefunded", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The total amount that has been refunded. 
		@available(*, deprecated, message:"Use `totalRefunded` instead.")
		open var totalRefundedV2: Storefront.MoneyV2 {
			return internalGetTotalRefundedV2()
		}

		func internalGetTotalRefundedV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalRefundedV2", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The total cost of shipping. 
		open var totalShippingPrice: Storefront.MoneyV2 {
			return internalGetTotalShippingPrice()
		}

		func internalGetTotalShippingPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalShippingPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The total cost of shipping. 
		@available(*, deprecated, message:"Use `totalShippingPrice` instead.")
		open var totalShippingPriceV2: Storefront.MoneyV2 {
			return internalGetTotalShippingPriceV2()
		}

		func internalGetTotalShippingPriceV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalShippingPriceV2", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The total cost of taxes. 
		open var totalTax: Storefront.MoneyV2? {
			return internalGetTotalTax()
		}

		func internalGetTotalTax(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "totalTax", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// The total cost of taxes. 
		@available(*, deprecated, message:"Use `totalTax` instead.")
		open var totalTaxV2: Storefront.MoneyV2? {
			return internalGetTotalTaxV2()
		}

		func internalGetTotalTaxV2(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "totalTaxV2", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "billingAddress":
					if let value = internalGetBillingAddress() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "currentSubtotalPrice":
					response.append(internalGetCurrentSubtotalPrice())
					response.append(contentsOf: internalGetCurrentSubtotalPrice().childResponseObjectMap())

					case "currentTotalDuties":
					if let value = internalGetCurrentTotalDuties() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "currentTotalPrice":
					response.append(internalGetCurrentTotalPrice())
					response.append(contentsOf: internalGetCurrentTotalPrice().childResponseObjectMap())

					case "currentTotalTax":
					response.append(internalGetCurrentTotalTax())
					response.append(contentsOf: internalGetCurrentTotalTax().childResponseObjectMap())

					case "customAttributes":
					internalGetCustomAttributes().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "discountApplications":
					response.append(internalGetDiscountApplications())
					response.append(contentsOf: internalGetDiscountApplications().childResponseObjectMap())

					case "lineItems":
					response.append(internalGetLineItems())
					response.append(contentsOf: internalGetLineItems().childResponseObjectMap())

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

					case "originalTotalDuties":
					if let value = internalGetOriginalTotalDuties() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "originalTotalPrice":
					response.append(internalGetOriginalTotalPrice())
					response.append(contentsOf: internalGetOriginalTotalPrice().childResponseObjectMap())

					case "shippingAddress":
					if let value = internalGetShippingAddress() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingDiscountAllocations":
					internalGetShippingDiscountAllocations().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "subtotalPrice":
					if let value = internalGetSubtotalPrice() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "subtotalPriceV2":
					if let value = internalGetSubtotalPriceV2() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "successfulFulfillments":
					if let value = internalGetSuccessfulFulfillments() {
						value.forEach {
							response.append($0)
							response.append(contentsOf: $0.childResponseObjectMap())
						}
					}

					case "totalPrice":
					response.append(internalGetTotalPrice())
					response.append(contentsOf: internalGetTotalPrice().childResponseObjectMap())

					case "totalPriceV2":
					response.append(internalGetTotalPriceV2())
					response.append(contentsOf: internalGetTotalPriceV2().childResponseObjectMap())

					case "totalRefunded":
					response.append(internalGetTotalRefunded())
					response.append(contentsOf: internalGetTotalRefunded().childResponseObjectMap())

					case "totalRefundedV2":
					response.append(internalGetTotalRefundedV2())
					response.append(contentsOf: internalGetTotalRefundedV2().childResponseObjectMap())

					case "totalShippingPrice":
					response.append(internalGetTotalShippingPrice())
					response.append(contentsOf: internalGetTotalShippingPrice().childResponseObjectMap())

					case "totalShippingPriceV2":
					response.append(internalGetTotalShippingPriceV2())
					response.append(contentsOf: internalGetTotalShippingPriceV2().childResponseObjectMap())

					case "totalTax":
					if let value = internalGetTotalTax() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "totalTaxV2":
					if let value = internalGetTotalTaxV2() {
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
