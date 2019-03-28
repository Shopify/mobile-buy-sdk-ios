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
		@available(*, deprecated, message:"This field will always return null. If you have an authentication token for the customer, you can use the `customer` field on the query root to retrieve it.")
		@discardableResult
		open func customer(alias: String? = nil, _ subfields: (CustomerQuery) -> Void) -> CheckoutQuery {
			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Discounts that have been applied on the checkout. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func discountApplications(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (DiscountApplicationConnectionQuery) -> Void) -> CheckoutQuery {
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

		/// The email attached to this checkout. 
		@discardableResult
		open func email(alias: String? = nil) -> CheckoutQuery {
			addField(field: "email", aliasSuffix: alias)
			return self
		}

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> CheckoutQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// A list of line item objects, each one containing information about an item 
		/// in the checkout. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func lineItems(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (CheckoutLineItemConnectionQuery) -> Void) -> CheckoutQuery {
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

			let subquery = CheckoutLineItemConnectionQuery()
			subfields(subquery)

			addField(field: "lineItems", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The sum of all the prices of all the items in the checkout. Taxes, shipping 
		/// and discounts excluded. 
		@discardableResult
		open func lineItemsSubtotalPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CheckoutQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "lineItemsSubtotalPrice", aliasSuffix: alias, subfields: subquery)
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
		@available(*, deprecated, message:"Use `paymentDueV2` instead")
		@discardableResult
		open func paymentDue(alias: String? = nil) -> CheckoutQuery {
			addField(field: "paymentDue", aliasSuffix: alias)
			return self
		}

		/// The amount left to be paid. This is equal to the cost of the line items, 
		/// taxes and shipping minus discounts and gift cards. 
		@discardableResult
		open func paymentDueV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CheckoutQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "paymentDueV2", aliasSuffix: alias, subfields: subquery)
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

		/// The discounts that have been allocated onto the shipping line by discount 
		/// applications. 
		@discardableResult
		open func shippingDiscountAllocations(alias: String? = nil, _ subfields: (DiscountAllocationQuery) -> Void) -> CheckoutQuery {
			let subquery = DiscountAllocationQuery()
			subfields(subquery)

			addField(field: "shippingDiscountAllocations", aliasSuffix: alias, subfields: subquery)
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

		/// Price of the checkout before shipping and taxes. 
		@available(*, deprecated, message:"Use `subtotalPriceV2` instead")
		@discardableResult
		open func subtotalPrice(alias: String? = nil) -> CheckoutQuery {
			addField(field: "subtotalPrice", aliasSuffix: alias)
			return self
		}

		/// Price of the checkout before shipping and taxes. 
		@discardableResult
		open func subtotalPriceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CheckoutQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "subtotalPriceV2", aliasSuffix: alias, subfields: subquery)
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
		@available(*, deprecated, message:"Use `totalPriceV2` instead")
		@discardableResult
		open func totalPrice(alias: String? = nil) -> CheckoutQuery {
			addField(field: "totalPrice", aliasSuffix: alias)
			return self
		}

		/// The sum of all the prices of all the items in the checkout, taxes and 
		/// discounts included. 
		@discardableResult
		open func totalPriceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CheckoutQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalPriceV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The sum of all the taxes applied to the line items and shipping lines in 
		/// the checkout. 
		@available(*, deprecated, message:"Use `totalTaxV2` instead")
		@discardableResult
		open func totalTax(alias: String? = nil) -> CheckoutQuery {
			addField(field: "totalTax", aliasSuffix: alias)
			return self
		}

		/// The sum of all the taxes applied to the line items and shipping lines in 
		/// the checkout. 
		@discardableResult
		open func totalTaxV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> CheckoutQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "totalTaxV2", aliasSuffix: alias, subfields: subquery)
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
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try AppliedGiftCard(fields: $0) }

				case "availableShippingRates":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try AvailableShippingRates(fields: value)

				case "completedAt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "customAttributes":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Attribute(fields: $0) }

				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

				case "discountApplications":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try DiscountApplicationConnection(fields: value)

				case "email":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lineItems":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try CheckoutLineItemConnection(fields: value)

				case "lineItemsSubtotalPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "note":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return value

				case "order":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try Order(fields: value)

				case "orderStatusUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "paymentDue":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "paymentDueV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "ready":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return value

				case "requiresShipping":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return value

				case "shippingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "shippingDiscountAllocations":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try DiscountAllocation(fields: $0) }

				case "shippingLine":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try ShippingRate(fields: value)

				case "subtotalPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "subtotalPriceV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "taxExempt":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return value

				case "taxesIncluded":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return value

				case "totalPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "totalPriceV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "totalTax":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "totalTaxV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "webUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: Checkout.self, field: fieldName, value: fieldValue)
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
		@available(*, deprecated, message:"This field will always return null. If you have an authentication token for the customer, you can use the `customer` field on the query root to retrieve it.")
		open var customer: Storefront.Customer? {
			return internalGetCustomer()
		}

		func internalGetCustomer(alias: String? = nil) -> Storefront.Customer? {
			return field(field: "customer", aliasSuffix: alias) as! Storefront.Customer?
		}

		/// Discounts that have been applied on the checkout. 
		open var discountApplications: Storefront.DiscountApplicationConnection {
			return internalGetDiscountApplications()
		}

		open func aliasedDiscountApplications(alias: String) -> Storefront.DiscountApplicationConnection {
			return internalGetDiscountApplications(alias: alias)
		}

		func internalGetDiscountApplications(alias: String? = nil) -> Storefront.DiscountApplicationConnection {
			return field(field: "discountApplications", aliasSuffix: alias) as! Storefront.DiscountApplicationConnection
		}

		/// The email attached to this checkout. 
		open var email: String? {
			return internalGetEmail()
		}

		func internalGetEmail(alias: String? = nil) -> String? {
			return field(field: "email", aliasSuffix: alias) as! String?
		}

		/// Globally unique identifier. 
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

		/// The sum of all the prices of all the items in the checkout. Taxes, shipping 
		/// and discounts excluded. 
		open var lineItemsSubtotalPrice: Storefront.MoneyV2 {
			return internalGetLineItemsSubtotalPrice()
		}

		func internalGetLineItemsSubtotalPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "lineItemsSubtotalPrice", aliasSuffix: alias) as! Storefront.MoneyV2
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
		@available(*, deprecated, message:"Use `paymentDueV2` instead")
		open var paymentDue: Decimal {
			return internalGetPaymentDue()
		}

		func internalGetPaymentDue(alias: String? = nil) -> Decimal {
			return field(field: "paymentDue", aliasSuffix: alias) as! Decimal
		}

		/// The amount left to be paid. This is equal to the cost of the line items, 
		/// taxes and shipping minus discounts and gift cards. 
		open var paymentDueV2: Storefront.MoneyV2 {
			return internalGetPaymentDueV2()
		}

		func internalGetPaymentDueV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "paymentDueV2", aliasSuffix: alias) as! Storefront.MoneyV2
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

		/// The discounts that have been allocated onto the shipping line by discount 
		/// applications. 
		open var shippingDiscountAllocations: [Storefront.DiscountAllocation] {
			return internalGetShippingDiscountAllocations()
		}

		func internalGetShippingDiscountAllocations(alias: String? = nil) -> [Storefront.DiscountAllocation] {
			return field(field: "shippingDiscountAllocations", aliasSuffix: alias) as! [Storefront.DiscountAllocation]
		}

		/// Once a shipping rate is selected by the customer it is transitioned to a 
		/// `shipping_line` object. 
		open var shippingLine: Storefront.ShippingRate? {
			return internalGetShippingLine()
		}

		func internalGetShippingLine(alias: String? = nil) -> Storefront.ShippingRate? {
			return field(field: "shippingLine", aliasSuffix: alias) as! Storefront.ShippingRate?
		}

		/// Price of the checkout before shipping and taxes. 
		@available(*, deprecated, message:"Use `subtotalPriceV2` instead")
		open var subtotalPrice: Decimal {
			return internalGetSubtotalPrice()
		}

		func internalGetSubtotalPrice(alias: String? = nil) -> Decimal {
			return field(field: "subtotalPrice", aliasSuffix: alias) as! Decimal
		}

		/// Price of the checkout before shipping and taxes. 
		open var subtotalPriceV2: Storefront.MoneyV2 {
			return internalGetSubtotalPriceV2()
		}

		func internalGetSubtotalPriceV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "subtotalPriceV2", aliasSuffix: alias) as! Storefront.MoneyV2
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
		@available(*, deprecated, message:"Use `totalPriceV2` instead")
		open var totalPrice: Decimal {
			return internalGetTotalPrice()
		}

		func internalGetTotalPrice(alias: String? = nil) -> Decimal {
			return field(field: "totalPrice", aliasSuffix: alias) as! Decimal
		}

		/// The sum of all the prices of all the items in the checkout, taxes and 
		/// discounts included. 
		open var totalPriceV2: Storefront.MoneyV2 {
			return internalGetTotalPriceV2()
		}

		func internalGetTotalPriceV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalPriceV2", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The sum of all the taxes applied to the line items and shipping lines in 
		/// the checkout. 
		@available(*, deprecated, message:"Use `totalTaxV2` instead")
		open var totalTax: Decimal {
			return internalGetTotalTax()
		}

		func internalGetTotalTax(alias: String? = nil) -> Decimal {
			return field(field: "totalTax", aliasSuffix: alias) as! Decimal
		}

		/// The sum of all the taxes applied to the line items and shipping lines in 
		/// the checkout. 
		open var totalTaxV2: Storefront.MoneyV2 {
			return internalGetTotalTaxV2()
		}

		func internalGetTotalTaxV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "totalTaxV2", aliasSuffix: alias) as! Storefront.MoneyV2
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

					case "discountApplications":
					response.append(internalGetDiscountApplications())
					response.append(contentsOf: internalGetDiscountApplications().childResponseObjectMap())

					case "lineItems":
					response.append(internalGetLineItems())
					response.append(contentsOf: internalGetLineItems().childResponseObjectMap())

					case "lineItemsSubtotalPrice":
					response.append(internalGetLineItemsSubtotalPrice())
					response.append(contentsOf: internalGetLineItemsSubtotalPrice().childResponseObjectMap())

					case "order":
					if let value = internalGetOrder() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "paymentDueV2":
					response.append(internalGetPaymentDueV2())
					response.append(contentsOf: internalGetPaymentDueV2().childResponseObjectMap())

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

					case "shippingLine":
					if let value = internalGetShippingLine() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "subtotalPriceV2":
					response.append(internalGetSubtotalPriceV2())
					response.append(contentsOf: internalGetSubtotalPriceV2().childResponseObjectMap())

					case "totalPriceV2":
					response.append(internalGetTotalPriceV2())
					response.append(contentsOf: internalGetTotalPriceV2().childResponseObjectMap())

					case "totalTaxV2":
					response.append(internalGetTotalTaxV2())
					response.append(contentsOf: internalGetTotalTaxV2().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
