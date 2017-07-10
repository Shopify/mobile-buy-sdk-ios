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

		/// The code of the currency used for the payment. 
		@discardableResult
		open func currencyCode(alias: String? = nil) -> OrderQuery {
			addField(field: "currencyCode", aliasSuffix: alias)
			return self
		}

		/// The locale code in which this specific order happened. 
		@discardableResult
		open func customerLocale(alias: String? = nil) -> OrderQuery {
			addField(field: "customerLocale", aliasSuffix: alias)
			return self
		}

		/// The order’s URL for a customer. 
		@discardableResult
		open func customerUrl(alias: String? = nil) -> OrderQuery {
			addField(field: "customerUrl", aliasSuffix: alias)
			return self
		}

		/// The customer's email address. 
		@discardableResult
		open func email(alias: String? = nil) -> OrderQuery {
			addField(field: "email", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func id(alias: String? = nil) -> OrderQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// List of the order’s line items. 
		///
		/// - parameters:
		///     - first: No description
		///     - after: No description
		///     - reverse: No description
		///
		@discardableResult
		open func lineItems(alias: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (OrderLineItemConnectionQuery) -> Void) -> OrderQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
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

		/// A unique numeric identifier for the order for use by shop owner and 
		/// customer. 
		@discardableResult
		open func orderNumber(alias: String? = nil) -> OrderQuery {
			addField(field: "orderNumber", aliasSuffix: alias)
			return self
		}

		/// The customer's phone number. 
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

		/// Price of the order before shipping and taxes. 
		@discardableResult
		open func subtotalPrice(alias: String? = nil) -> OrderQuery {
			addField(field: "subtotalPrice", aliasSuffix: alias)
			return self
		}

		/// The sum of all the prices of all the items in the order, taxes and 
		/// discounts included (must be positive). 
		@discardableResult
		open func totalPrice(alias: String? = nil) -> OrderQuery {
			addField(field: "totalPrice", aliasSuffix: alias)
			return self
		}

		/// The total amount that has been refunded. 
		@discardableResult
		open func totalRefunded(alias: String? = nil) -> OrderQuery {
			addField(field: "totalRefunded", aliasSuffix: alias)
			return self
		}

		/// The total cost of shipping. 
		@discardableResult
		open func totalShippingPrice(alias: String? = nil) -> OrderQuery {
			addField(field: "totalShippingPrice", aliasSuffix: alias)
			return self
		}

		/// The total cost of taxes. 
		@discardableResult
		open func totalTax(alias: String? = nil) -> OrderQuery {
			addField(field: "totalTax", aliasSuffix: alias)
			return self
		}
	}

	/// An order is a customer’s completed request to purchase one or more products 
	/// from a shop. An order is created when a customer completes the checkout 
	/// process, during which time they provides an email address, billing address 
	/// and payment information. 
	open class Order: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = OrderQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "customerLocale":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "customerUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "email":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lineItems":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try OrderLineItemConnection(fields: value)

				case "orderNumber":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "phone":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "processedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "shippingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "subtotalPrice":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "totalPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "totalRefunded":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "totalShippingPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "totalTax":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The code of the currency used for the payment. 
		open var currencyCode: Storefront.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(alias: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: alias) as! Storefront.CurrencyCode
		}

		/// The locale code in which this specific order happened. 
		open var customerLocale: String? {
			return internalGetCustomerLocale()
		}

		func internalGetCustomerLocale(alias: String? = nil) -> String? {
			return field(field: "customerLocale", aliasSuffix: alias) as! String?
		}

		/// The order’s URL for a customer. 
		open var customerUrl: URL? {
			return internalGetCustomerUrl()
		}

		func internalGetCustomerUrl(alias: String? = nil) -> URL? {
			return field(field: "customerUrl", aliasSuffix: alias) as! URL?
		}

		/// The customer's email address. 
		open var email: String? {
			return internalGetEmail()
		}

		func internalGetEmail(alias: String? = nil) -> String? {
			return field(field: "email", aliasSuffix: alias) as! String?
		}

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

		/// A unique numeric identifier for the order for use by shop owner and 
		/// customer. 
		open var orderNumber: Int32 {
			return internalGetOrderNumber()
		}

		func internalGetOrderNumber(alias: String? = nil) -> Int32 {
			return field(field: "orderNumber", aliasSuffix: alias) as! Int32
		}

		/// The customer's phone number. 
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

		/// Price of the order before shipping and taxes. 
		open var subtotalPrice: Decimal? {
			return internalGetSubtotalPrice()
		}

		func internalGetSubtotalPrice(alias: String? = nil) -> Decimal? {
			return field(field: "subtotalPrice", aliasSuffix: alias) as! Decimal?
		}

		/// The sum of all the prices of all the items in the order, taxes and 
		/// discounts included (must be positive). 
		open var totalPrice: Decimal {
			return internalGetTotalPrice()
		}

		func internalGetTotalPrice(alias: String? = nil) -> Decimal {
			return field(field: "totalPrice", aliasSuffix: alias) as! Decimal
		}

		/// The total amount that has been refunded. 
		open var totalRefunded: Decimal {
			return internalGetTotalRefunded()
		}

		func internalGetTotalRefunded(alias: String? = nil) -> Decimal {
			return field(field: "totalRefunded", aliasSuffix: alias) as! Decimal
		}

		/// The total cost of shipping. 
		open var totalShippingPrice: Decimal {
			return internalGetTotalShippingPrice()
		}

		func internalGetTotalShippingPrice(alias: String? = nil) -> Decimal {
			return field(field: "totalShippingPrice", aliasSuffix: alias) as! Decimal
		}

		/// The total cost of taxes. 
		open var totalTax: Decimal? {
			return internalGetTotalTax()
		}

		func internalGetTotalTax(alias: String? = nil) -> Decimal? {
			return field(field: "totalTax", aliasSuffix: alias) as! Decimal?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "lineItems":
					response.append(internalGetLineItems())
					response.append(contentsOf: internalGetLineItems().childResponseObjectMap())

					case "shippingAddress":
					if let value = internalGetShippingAddress() {
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
