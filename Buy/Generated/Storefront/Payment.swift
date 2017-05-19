//
//  Payment.swift
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
	/// A payment applied to a checkout. 
	open class PaymentQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Payment

		/// The amount of the payment. 
		@discardableResult
		open func amount(alias: String? = nil) -> PaymentQuery {
			addField(field: "amount", aliasSuffix: alias)
			return self
		}

		/// The billing address for the payment. 
		@discardableResult
		open func billingAddress(alias: String? = nil, _ subfields: (MailingAddressQuery) -> Void) -> PaymentQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)

			addField(field: "billingAddress", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The checkout to which the payment belongs. 
		@discardableResult
		open func checkout(alias: String? = nil, _ subfields: (CheckoutQuery) -> Void) -> PaymentQuery {
			let subquery = CheckoutQuery()
			subfields(subquery)

			addField(field: "checkout", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The credit card used for the payment in the case of direct payments. 
		@discardableResult
		open func creditCard(alias: String? = nil, _ subfields: (CreditCardQuery) -> Void) -> PaymentQuery {
			let subquery = CreditCardQuery()
			subfields(subquery)

			addField(field: "creditCard", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// An message describing a processing error during asynchronous processing. 
		@discardableResult
		open func errorMessage(alias: String? = nil) -> PaymentQuery {
			addField(field: "errorMessage", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func id(alias: String? = nil) -> PaymentQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// A client-side generated token to identify a payment and perform idempotent 
		/// operations. 
		@discardableResult
		open func idempotencyKey(alias: String? = nil) -> PaymentQuery {
			addField(field: "idempotencyKey", aliasSuffix: alias)
			return self
		}

		/// Whether or not the payment is still processing asynchronously. 
		@discardableResult
		open func ready(alias: String? = nil) -> PaymentQuery {
			addField(field: "ready", aliasSuffix: alias)
			return self
		}

		/// A flag to indicate if the payment is to be done in test mode for gateways 
		/// that support it. 
		@discardableResult
		open func test(alias: String? = nil) -> PaymentQuery {
			addField(field: "test", aliasSuffix: alias)
			return self
		}

		/// The actual transaction recorded by Shopify after having processed the 
		/// payment with the gateway. 
		@discardableResult
		open func transaction(alias: String? = nil, _ subfields: (TransactionQuery) -> Void) -> PaymentQuery {
			let subquery = TransactionQuery()
			subfields(subquery)

			addField(field: "transaction", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// A payment applied to a checkout. 
	open class Payment: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = PaymentQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amount":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "billingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "checkout":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Checkout(fields: value)

				case "creditCard":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CreditCard(fields: value)

				case "errorMessage":
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

				case "idempotencyKey":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "ready":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "test":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "transaction":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Transaction(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The amount of the payment. 
		open var amount: Decimal {
			return internalGetAmount()
		}

		func internalGetAmount(alias: String? = nil) -> Decimal {
			return field(field: "amount", aliasSuffix: alias) as! Decimal
		}

		/// The billing address for the payment. 
		open var billingAddress: Storefront.MailingAddress? {
			return internalGetBillingAddress()
		}

		func internalGetBillingAddress(alias: String? = nil) -> Storefront.MailingAddress? {
			return field(field: "billingAddress", aliasSuffix: alias) as! Storefront.MailingAddress?
		}

		/// The checkout to which the payment belongs. 
		open var checkout: Storefront.Checkout {
			return internalGetCheckout()
		}

		func internalGetCheckout(alias: String? = nil) -> Storefront.Checkout {
			return field(field: "checkout", aliasSuffix: alias) as! Storefront.Checkout
		}

		/// The credit card used for the payment in the case of direct payments. 
		open var creditCard: Storefront.CreditCard? {
			return internalGetCreditCard()
		}

		func internalGetCreditCard(alias: String? = nil) -> Storefront.CreditCard? {
			return field(field: "creditCard", aliasSuffix: alias) as! Storefront.CreditCard?
		}

		/// An message describing a processing error during asynchronous processing. 
		open var errorMessage: String? {
			return internalGetErrorMessage()
		}

		func internalGetErrorMessage(alias: String? = nil) -> String? {
			return field(field: "errorMessage", aliasSuffix: alias) as! String?
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// A client-side generated token to identify a payment and perform idempotent 
		/// operations. 
		open var idempotencyKey: String? {
			return internalGetIdempotencyKey()
		}

		func internalGetIdempotencyKey(alias: String? = nil) -> String? {
			return field(field: "idempotencyKey", aliasSuffix: alias) as! String?
		}

		/// Whether or not the payment is still processing asynchronously. 
		open var ready: Bool {
			return internalGetReady()
		}

		func internalGetReady(alias: String? = nil) -> Bool {
			return field(field: "ready", aliasSuffix: alias) as! Bool
		}

		/// A flag to indicate if the payment is to be done in test mode for gateways 
		/// that support it. 
		open var test: Bool {
			return internalGetTest()
		}

		func internalGetTest(alias: String? = nil) -> Bool {
			return field(field: "test", aliasSuffix: alias) as! Bool
		}

		/// The actual transaction recorded by Shopify after having processed the 
		/// payment with the gateway. 
		open var transaction: Storefront.Transaction? {
			return internalGetTransaction()
		}

		func internalGetTransaction(alias: String? = nil) -> Storefront.Transaction? {
			return field(field: "transaction", aliasSuffix: alias) as! Storefront.Transaction?
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

					case "checkout":
					response.append(internalGetCheckout())
					response.append(contentsOf: internalGetCheckout().childResponseObjectMap())

					case "creditCard":
					if let value = internalGetCreditCard() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "transaction":
					if let value = internalGetTransaction() {
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
