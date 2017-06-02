//
//  Checkout.swift
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
	/// A container for all the information required to checkout items and pay. 
	open class CheckoutQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Checkout

		@discardableResult
		open func appliedGiftCards(alias: String? = nil, _ subfields: (AppliedGiftCardQuery) -> Void) -> CheckoutQuery {
			let subquery = AppliedGiftCardQuery()
			subfields(subquery)

			addField(field: "appliedGiftCards", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The available shipping rates for this Checkout. Should only be used when 
		/// checkout `requiresShipping` is `true` and the shipping address is valid. 
		@discardableResult
		open func availableShippingRates(alias: String? = nil, _ subfields: (AvailableShippingRatesQuery) -> Void) -> CheckoutQuery {
			let subquery = AvailableShippingRatesQuery()
			subfields(subquery)

			addField(field: "availableShippingRates", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The date and time when the checkout was completed. 
		@discardableResult
		open func completedAt(alias: String? = nil) -> CheckoutQuery {
			addField(field: "completedAt", aliasSuffix: alias)
			return self
		}

		/// The date and time when the checkout was created. 
		@discardableResult
		open func createdAt(alias: String? = nil) -> CheckoutQuery {
			addField(field: "createdAt", aliasSuffix: alias)
			return self
		}

		/// The currency code for the Checkout. 
		@discardableResult
		open func currencyCode(alias: String? = nil) -> CheckoutQuery {
			addField(field: "currencyCode", aliasSuffix: alias)
			return self
		}

		/// A list of extra information that is added to the checkout. 
		@discardableResult
		open func customAttributes(alias: String? = nil, _ subfields: (AttributeQuery) -> Void) -> CheckoutQuery {
			let subquery = AttributeQuery()
			subfields(subquery)

			addField(field: "customAttributes", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The customer associated with the checkout. 
		@discardableResult
		open func customer(alias: String? = nil, _ subfields: (CustomerQuery) -> Void) -> CheckoutQuery {
			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The email attached to this checkout. 
		@discardableResult
		open func email(alias: String? = nil) -> CheckoutQuery {
			addField(field: "email", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func id(alias: String? = nil) -> CheckoutQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// A list of line item objects, each one containing information about an item 
		/// in the checkout. 
		///
		/// - parameters:
		///     - first: No description
		///     - after: No description
		///     - reverse: No description
		///
		@discardableResult
		open func lineItems(alias: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (CheckoutLineItemConnectionQuery) -> Void) -> CheckoutQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CheckoutLineItemConnectionQuery()
			subfields(subquery)

			addField(field: "lineItems", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func note(alias: String? = nil) -> CheckoutQuery {
			addField(field: "note", aliasSuffix: alias)
			return self
		}

		/// The resulting order from a paid checkout. 
		@discardableResult
		open func order(alias: String? = nil, _ subfields: (OrderQuery) -> Void) -> CheckoutQuery {
			let subquery = OrderQuery()
			subfields(subquery)

			addField(field: "order", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The Order Status Page for this Checkout, null when checkout is not 
		/// completed. 
		@discardableResult
		open func orderStatusUrl(alias: String? = nil) -> CheckoutQuery {
			addField(field: "orderStatusUrl", aliasSuffix: alias)
			return self
		}

		/// The amount left to be paid. This is equal to the cost of the line items, 
		/// taxes and shipping minus discounts and gift cards. 
		@discardableResult
		open func paymentDue(alias: String? = nil) -> CheckoutQuery {
			addField(field: "paymentDue", aliasSuffix: alias)
			return self
		}

		/// Whether or not the Checkout is ready and can be completed. Checkouts may 
		/// have asynchronous operations that can take time to finish. If you want to 
		/// complete a checkout or ensure all the fields are populated and up to date, 
		/// polling is required until the value is true. 
		@discardableResult
		open func ready(alias: String? = nil) -> CheckoutQuery {
			addField(field: "ready", aliasSuffix: alias)
			return self
		}

		/// States whether or not the fulfillment requires shipping. 
		@discardableResult
		open func requiresShipping(alias: String? = nil) -> CheckoutQuery {
			addField(field: "requiresShipping", aliasSuffix: alias)
			return self
		}

		/// The shipping address to where the line items will be shipped. 
		@discardableResult
		open func shippingAddress(alias: String? = nil, _ subfields: (MailingAddressQuery) -> Void) -> CheckoutQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)

			addField(field: "shippingAddress", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Once a shipping rate is selected by the customer it is transitioned to a 
		/// `shipping_line` object. 
		@discardableResult
		open func shippingLine(alias: String? = nil, _ subfields: (ShippingRateQuery) -> Void) -> CheckoutQuery {
			let subquery = ShippingRateQuery()
			subfields(subquery)

			addField(field: "shippingLine", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Price of the checkout before shipping, taxes, and discounts. 
		@discardableResult
		open func subtotalPrice(alias: String? = nil) -> CheckoutQuery {
			addField(field: "subtotalPrice", aliasSuffix: alias)
			return self
		}

		/// Specifies if the Checkout is tax exempt. 
		@discardableResult
		open func taxExempt(alias: String? = nil) -> CheckoutQuery {
			addField(field: "taxExempt", aliasSuffix: alias)
			return self
		}

		/// Specifies if taxes are included in the line item and shipping line prices. 
		@discardableResult
		open func taxesIncluded(alias: String? = nil) -> CheckoutQuery {
			addField(field: "taxesIncluded", aliasSuffix: alias)
			return self
		}

		/// The sum of all the prices of all the items in the checkout, taxes and 
		/// discounts included. 
		@discardableResult
		open func totalPrice(alias: String? = nil) -> CheckoutQuery {
			addField(field: "totalPrice", aliasSuffix: alias)
			return self
		}

		/// The sum of all the taxes applied to the line items and shipping lines in 
		/// the checkout. 
		@discardableResult
		open func totalTax(alias: String? = nil) -> CheckoutQuery {
			addField(field: "totalTax", aliasSuffix: alias)
			return self
		}

		/// The date and time when the checkout was last updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> CheckoutQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}

		/// The url pointing to the checkout accessible from the web. 
		@discardableResult
		open func webUrl(alias: String? = nil) -> CheckoutQuery {
			addField(field: "webUrl", aliasSuffix: alias)
			return self
		}
	}

	/// A container for all the information required to checkout items and pay. 
	open class Checkout: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = CheckoutQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "appliedGiftCards":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try AppliedGiftCard(fields: $0) }

				case "availableShippingRates":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try AvailableShippingRates(fields: value)

				case "completedAt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "customAttributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

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
				return try CheckoutLineItemConnection(fields: value)

				case "note":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "order":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Order(fields: value)

				case "orderStatusUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "paymentDue":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "ready":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "requiresShipping":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "shippingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "shippingLine":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ShippingRate(fields: value)

				case "subtotalPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "taxExempt":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "taxesIncluded":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "totalPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "totalTax":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "webUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var appliedGiftCards: [Storefront.AppliedGiftCard] {
			return internalGetAppliedGiftCards()
		}

		func internalGetAppliedGiftCards(alias: String? = nil) -> [Storefront.AppliedGiftCard] {
			return field(field: "appliedGiftCards", aliasSuffix: alias) as! [Storefront.AppliedGiftCard]
		}

		/// The available shipping rates for this Checkout. Should only be used when 
		/// checkout `requiresShipping` is `true` and the shipping address is valid. 
		open var availableShippingRates: Storefront.AvailableShippingRates? {
			return internalGetAvailableShippingRates()
		}

		func internalGetAvailableShippingRates(alias: String? = nil) -> Storefront.AvailableShippingRates? {
			return field(field: "availableShippingRates", aliasSuffix: alias) as! Storefront.AvailableShippingRates?
		}

		/// The date and time when the checkout was completed. 
		open var completedAt: Date? {
			return internalGetCompletedAt()
		}

		func internalGetCompletedAt(alias: String? = nil) -> Date? {
			return field(field: "completedAt", aliasSuffix: alias) as! Date?
		}

		/// The date and time when the checkout was created. 
		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(alias: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: alias) as! Date
		}

		/// The currency code for the Checkout. 
		open var currencyCode: Storefront.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(alias: String? = nil) -> Storefront.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: alias) as! Storefront.CurrencyCode
		}

		/// A list of extra information that is added to the checkout. 
		open var customAttributes: [Storefront.Attribute] {
			return internalGetCustomAttributes()
		}

		func internalGetCustomAttributes(alias: String? = nil) -> [Storefront.Attribute] {
			return field(field: "customAttributes", aliasSuffix: alias) as! [Storefront.Attribute]
		}

		/// The customer associated with the checkout. 
		open var customer: Storefront.Customer? {
			return internalGetCustomer()
		}

		func internalGetCustomer(alias: String? = nil) -> Storefront.Customer? {
			return field(field: "customer", aliasSuffix: alias) as! Storefront.Customer?
		}

		/// The email attached to this checkout. 
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

		/// A list of line item objects, each one containing information about an item 
		/// in the checkout. 
		open var lineItems: Storefront.CheckoutLineItemConnection {
			return internalGetLineItems()
		}

		open func aliasedLineItems(alias: String) -> Storefront.CheckoutLineItemConnection {
			return internalGetLineItems(alias: alias)
		}

		func internalGetLineItems(alias: String? = nil) -> Storefront.CheckoutLineItemConnection {
			return field(field: "lineItems", aliasSuffix: alias) as! Storefront.CheckoutLineItemConnection
		}

		open var note: String? {
			return internalGetNote()
		}

		func internalGetNote(alias: String? = nil) -> String? {
			return field(field: "note", aliasSuffix: alias) as! String?
		}

		/// The resulting order from a paid checkout. 
		open var order: Storefront.Order? {
			return internalGetOrder()
		}

		func internalGetOrder(alias: String? = nil) -> Storefront.Order? {
			return field(field: "order", aliasSuffix: alias) as! Storefront.Order?
		}

		/// The Order Status Page for this Checkout, null when checkout is not 
		/// completed. 
		open var orderStatusUrl: URL? {
			return internalGetOrderStatusUrl()
		}

		func internalGetOrderStatusUrl(alias: String? = nil) -> URL? {
			return field(field: "orderStatusUrl", aliasSuffix: alias) as! URL?
		}

		/// The amount left to be paid. This is equal to the cost of the line items, 
		/// taxes and shipping minus discounts and gift cards. 
		open var paymentDue: Decimal {
			return internalGetPaymentDue()
		}

		func internalGetPaymentDue(alias: String? = nil) -> Decimal {
			return field(field: "paymentDue", aliasSuffix: alias) as! Decimal
		}

		/// Whether or not the Checkout is ready and can be completed. Checkouts may 
		/// have asynchronous operations that can take time to finish. If you want to 
		/// complete a checkout or ensure all the fields are populated and up to date, 
		/// polling is required until the value is true. 
		open var ready: Bool {
			return internalGetReady()
		}

		func internalGetReady(alias: String? = nil) -> Bool {
			return field(field: "ready", aliasSuffix: alias) as! Bool
		}

		/// States whether or not the fulfillment requires shipping. 
		open var requiresShipping: Bool {
			return internalGetRequiresShipping()
		}

		func internalGetRequiresShipping(alias: String? = nil) -> Bool {
			return field(field: "requiresShipping", aliasSuffix: alias) as! Bool
		}

		/// The shipping address to where the line items will be shipped. 
		open var shippingAddress: Storefront.MailingAddress? {
			return internalGetShippingAddress()
		}

		func internalGetShippingAddress(alias: String? = nil) -> Storefront.MailingAddress? {
			return field(field: "shippingAddress", aliasSuffix: alias) as! Storefront.MailingAddress?
		}

		/// Once a shipping rate is selected by the customer it is transitioned to a 
		/// `shipping_line` object. 
		open var shippingLine: Storefront.ShippingRate? {
			return internalGetShippingLine()
		}

		func internalGetShippingLine(alias: String? = nil) -> Storefront.ShippingRate? {
			return field(field: "shippingLine", aliasSuffix: alias) as! Storefront.ShippingRate?
		}

		/// Price of the checkout before shipping, taxes, and discounts. 
		open var subtotalPrice: Decimal {
			return internalGetSubtotalPrice()
		}

		func internalGetSubtotalPrice(alias: String? = nil) -> Decimal {
			return field(field: "subtotalPrice", aliasSuffix: alias) as! Decimal
		}

		/// Specifies if the Checkout is tax exempt. 
		open var taxExempt: Bool {
			return internalGetTaxExempt()
		}

		func internalGetTaxExempt(alias: String? = nil) -> Bool {
			return field(field: "taxExempt", aliasSuffix: alias) as! Bool
		}

		/// Specifies if taxes are included in the line item and shipping line prices. 
		open var taxesIncluded: Bool {
			return internalGetTaxesIncluded()
		}

		func internalGetTaxesIncluded(alias: String? = nil) -> Bool {
			return field(field: "taxesIncluded", aliasSuffix: alias) as! Bool
		}

		/// The sum of all the prices of all the items in the checkout, taxes and 
		/// discounts included. 
		open var totalPrice: Decimal {
			return internalGetTotalPrice()
		}

		func internalGetTotalPrice(alias: String? = nil) -> Decimal {
			return field(field: "totalPrice", aliasSuffix: alias) as! Decimal
		}

		/// The sum of all the taxes applied to the line items and shipping lines in 
		/// the checkout. 
		open var totalTax: Decimal {
			return internalGetTotalTax()
		}

		func internalGetTotalTax(alias: String? = nil) -> Decimal {
			return field(field: "totalTax", aliasSuffix: alias) as! Decimal
		}

		/// The date and time when the checkout was last updated. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		/// The url pointing to the checkout accessible from the web. 
		open var webUrl: URL {
			return internalGetWebUrl()
		}

		func internalGetWebUrl(alias: String? = nil) -> URL {
			return field(field: "webUrl", aliasSuffix: alias) as! URL
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "appliedGiftCards":
					internalGetAppliedGiftCards().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "availableShippingRates":
					if let value = internalGetAvailableShippingRates() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customAttributes":
					internalGetCustomAttributes().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "customer":
					if let value = internalGetCustomer() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "lineItems":
					response.append(internalGetLineItems())
					response.append(contentsOf: internalGetLineItems().childResponseObjectMap())

					case "order":
					if let value = internalGetOrder() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingAddress":
					if let value = internalGetShippingAddress() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingLine":
					if let value = internalGetShippingLine() {
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
