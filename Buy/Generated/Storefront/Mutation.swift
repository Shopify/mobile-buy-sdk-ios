//
//  Mutation.swift
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
	/// The schema’s entry-point for mutations. This acts as the public, top-level 
	/// API from which all mutation queries must start. 
	open class MutationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Mutation

		open override var description: String {
			return "mutation" + super.description
		}

		/// Updates the attributes of a checkout. 
		///
		/// - parameters:
		///     - checkoutId: The ID of the checkout.
		///     - input: No description
		///
		@discardableResult
		open func checkoutAttributesUpdate(alias: String? = nil, checkoutId: GraphQL.ID, input: CheckoutAttributesUpdateInput, _ subfields: (CheckoutAttributesUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutAttributesUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutAttributesUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		///
		/// - parameters:
		///     - checkoutId: The ID of the checkout.
		///
		@discardableResult
		open func checkoutCompleteFree(alias: String? = nil, checkoutId: GraphQL.ID, _ subfields: (CheckoutCompleteFreePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCompleteFreePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCompleteFree", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Completes a checkout using a credit card token from Shopify's Vault. 
		///
		/// - parameters:
		///     - checkoutId: The ID of the checkout.
		///     - payment: No description
		///
		@discardableResult
		open func checkoutCompleteWithCreditCard(alias: String? = nil, checkoutId: GraphQL.ID, payment: CreditCardPaymentInput, _ subfields: (CheckoutCompleteWithCreditCardPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("payment:\(payment.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCompleteWithCreditCardPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCompleteWithCreditCard", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Completes a checkout with a tokenized payment. 
		///
		/// - parameters:
		///     - checkoutId: The ID of the checkout.
		///     - payment: No description
		///
		@discardableResult
		open func checkoutCompleteWithTokenizedPayment(alias: String? = nil, checkoutId: GraphQL.ID, payment: TokenizedPaymentInput, _ subfields: (CheckoutCompleteWithTokenizedPaymentPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("payment:\(payment.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCompleteWithTokenizedPaymentPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCompleteWithTokenizedPayment", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Creates a new checkout. 
		///
		/// - parameters:
		///     - input: No description
		///
		@discardableResult
		open func checkoutCreate(alias: String? = nil, input: CheckoutCreateInput, _ subfields: (CheckoutCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCreatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCreate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Associates a customer to the checkout. 
		///
		/// - parameters:
		///     - checkoutId: The ID of the checkout.
		///     - customerAccessToken: The customer access token of the customer to associate.
		///
		@discardableResult
		open func checkoutCustomerAssociate(alias: String? = nil, checkoutId: GraphQL.ID, customerAccessToken: String, _ subfields: (CheckoutCustomerAssociatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCustomerAssociatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCustomerAssociate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Disassociates the current checkout customer from the checkout. 
		///
		/// - parameters:
		///     - checkoutId: The ID of the checkout.
		///
		@discardableResult
		open func checkoutCustomerDisassociate(alias: String? = nil, checkoutId: GraphQL.ID, _ subfields: (CheckoutCustomerDisassociatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCustomerDisassociatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCustomerDisassociate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates the email on an existing checkout. 
		///
		/// - parameters:
		///     - checkoutId: The ID of the checkout.
		///     - email: The email to update the checkout with.
		///
		@discardableResult
		open func checkoutEmailUpdate(alias: String? = nil, checkoutId: GraphQL.ID, email: String, _ subfields: (CheckoutEmailUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("email:\(GraphQL.quoteString(input: email))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutEmailUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutEmailUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Applies a gift card to an existing checkout using a gift card code. 
		///
		/// - parameters:
		///     - giftCardCode: The code of the gift card to apply on the checkout.
		///     - checkoutId: The ID of the checkout.
		///
		@discardableResult
		open func checkoutGiftCardApply(alias: String? = nil, giftCardCode: String, checkoutId: GraphQL.ID, _ subfields: (CheckoutGiftCardApplyPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("giftCardCode:\(GraphQL.quoteString(input: giftCardCode))")

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutGiftCardApplyPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutGiftCardApply", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Removes an applied gift card from the checkout. 
		///
		/// - parameters:
		///     - appliedGiftCardId: The ID of the Applied Gift Card to remove from the Checkout
		///     - checkoutId: The ID of the Checkout
		///
		@discardableResult
		open func checkoutGiftCardRemove(alias: String? = nil, appliedGiftCardId: GraphQL.ID, checkoutId: GraphQL.ID, _ subfields: (CheckoutGiftCardRemovePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("appliedGiftCardId:\(GraphQL.quoteString(input: "\(appliedGiftCardId.rawValue)"))")

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutGiftCardRemovePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutGiftCardRemove", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Adds a list of line items to a checkout. 
		///
		/// - parameters:
		///     - lineItems: A list of line item objects to add to the checkout.
		///     - checkoutId: The ID of the checkout.
		///
		@discardableResult
		open func checkoutLineItemsAdd(alias: String? = nil, lineItems: [CheckoutLineItemInput], checkoutId: GraphQL.ID, _ subfields: (CheckoutLineItemsAddPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("lineItems:[\(lineItems.map{ "\($0.serialize())" }.joined(separator: ","))]")

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutLineItemsAddPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutLineItemsAdd", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Removes line items from an existing checkout 
		///
		/// - parameters:
		///     - checkoutId: the checkout on which to remove line items
		///     - lineItemIds: line item ids to remove
		///
		@discardableResult
		open func checkoutLineItemsRemove(alias: String? = nil, checkoutId: GraphQL.ID, lineItemIds: [GraphQL.ID], _ subfields: (CheckoutLineItemsRemovePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("lineItemIds:[\(lineItemIds.map{ "\(GraphQL.quoteString(input: "\($0.rawValue)"))" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutLineItemsRemovePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutLineItemsRemove", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates line items on a checkout. 
		///
		/// - parameters:
		///     - checkoutId: the checkout on which to update line items.
		///     - lineItems: line items to update.
		///
		@discardableResult
		open func checkoutLineItemsUpdate(alias: String? = nil, checkoutId: GraphQL.ID, lineItems: [CheckoutLineItemUpdateInput], _ subfields: (CheckoutLineItemsUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("lineItems:[\(lineItems.map{ "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutLineItemsUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutLineItemsUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates the shipping address of an existing checkout. 
		///
		/// - parameters:
		///     - shippingAddress: The shipping address to where the line items will be shipped.
		///     - checkoutId: The ID of the checkout.
		///
		@discardableResult
		open func checkoutShippingAddressUpdate(alias: String? = nil, shippingAddress: MailingAddressInput, checkoutId: GraphQL.ID, _ subfields: (CheckoutShippingAddressUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("shippingAddress:\(shippingAddress.serialize())")

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutShippingAddressUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutShippingAddressUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates the shipping lines on an existing checkout. 
		///
		/// - parameters:
		///     - checkoutId: The ID of the checkout.
		///     - shippingRateHandle: A concatenation of a Checkout’s shipping provider, price, and title, enabling the customer to select the availableShippingRates.
		///
		@discardableResult
		open func checkoutShippingLineUpdate(alias: String? = nil, checkoutId: GraphQL.ID, shippingRateHandle: String, _ subfields: (CheckoutShippingLineUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("shippingRateHandle:\(GraphQL.quoteString(input: shippingRateHandle))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutShippingLineUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutShippingLineUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Creates a customer access token. The customer access token is required to 
		/// modify the customer object in any way. 
		///
		/// - parameters:
		///     - input: No description
		///
		@discardableResult
		open func customerAccessTokenCreate(alias: String? = nil, input: CustomerAccessTokenCreateInput, _ subfields: (CustomerAccessTokenCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAccessTokenCreatePayloadQuery()
			subfields(subquery)

			addField(field: "customerAccessTokenCreate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Permanently destroys a customer access token. 
		///
		/// - parameters:
		///     - customerAccessToken: The access token used to identify the customer.
		///
		@discardableResult
		open func customerAccessTokenDelete(alias: String? = nil, customerAccessToken: String, _ subfields: (CustomerAccessTokenDeletePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAccessTokenDeletePayloadQuery()
			subfields(subquery)

			addField(field: "customerAccessTokenDelete", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Renews a customer access token. 
		///
		/// - parameters:
		///     - customerAccessToken: The access token used to identify the customer.
		///
		@discardableResult
		open func customerAccessTokenRenew(alias: String? = nil, customerAccessToken: String, _ subfields: (CustomerAccessTokenRenewPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAccessTokenRenewPayloadQuery()
			subfields(subquery)

			addField(field: "customerAccessTokenRenew", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Activates a customer. 
		///
		/// - parameters:
		///     - id: Specifies the customer to activate.
		///     - input: No description
		///
		@discardableResult
		open func customerActivate(alias: String? = nil, id: GraphQL.ID, input: CustomerActivateInput, _ subfields: (CustomerActivatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerActivatePayloadQuery()
			subfields(subquery)

			addField(field: "customerActivate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Creates a new address for a customer. 
		///
		/// - parameters:
		///     - customerAccessToken: The access token used to identify the customer.
		///     - address: The customer mailing address to create.
		///
		@discardableResult
		open func customerAddressCreate(alias: String? = nil, customerAccessToken: String, address: MailingAddressInput, _ subfields: (CustomerAddressCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			args.append("address:\(address.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAddressCreatePayloadQuery()
			subfields(subquery)

			addField(field: "customerAddressCreate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Permanently deletes the address of an existing customer. 
		///
		/// - parameters:
		///     - id: Specifies the address to delete.
		///     - customerAccessToken: The access token used to identify the customer.
		///
		@discardableResult
		open func customerAddressDelete(alias: String? = nil, id: GraphQL.ID, customerAccessToken: String, _ subfields: (CustomerAddressDeletePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAddressDeletePayloadQuery()
			subfields(subquery)

			addField(field: "customerAddressDelete", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates the address of an existing customer. 
		///
		/// - parameters:
		///     - customerAccessToken: The access token used to identify the customer.
		///     - id: Specifies the customer address to update.
		///     - address: The customer’s mailing address.
		///
		@discardableResult
		open func customerAddressUpdate(alias: String? = nil, customerAccessToken: String, id: GraphQL.ID, address: MailingAddressInput, _ subfields: (CustomerAddressUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			args.append("address:\(address.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAddressUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "customerAddressUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Creates a new customer. 
		///
		/// - parameters:
		///     - input: No description
		///
		@discardableResult
		open func customerCreate(alias: String? = nil, input: CustomerCreateInput, _ subfields: (CustomerCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerCreatePayloadQuery()
			subfields(subquery)

			addField(field: "customerCreate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Sends a reset password email to the customer, as the first step in the 
		/// reset password process. 
		///
		/// - parameters:
		///     - email: The email address of the customer to recover.
		///
		@discardableResult
		open func customerRecover(alias: String? = nil, email: String, _ subfields: (CustomerRecoverPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("email:\(GraphQL.quoteString(input: email))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerRecoverPayloadQuery()
			subfields(subquery)

			addField(field: "customerRecover", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Resets a customer’s password with a token received from `CustomerRecover`. 
		///
		/// - parameters:
		///     - id: Specifies the customer to reset.
		///     - input: No description
		///
		@discardableResult
		open func customerReset(alias: String? = nil, id: GraphQL.ID, input: CustomerResetInput, _ subfields: (CustomerResetPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerResetPayloadQuery()
			subfields(subquery)

			addField(field: "customerReset", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates an existing customer. 
		///
		/// - parameters:
		///     - customerAccessToken: The access token used to identify the customer.
		///     - customer: The customer object input.
		///
		@discardableResult
		open func customerUpdate(alias: String? = nil, customerAccessToken: String, customer: CustomerUpdateInput, _ subfields: (CustomerUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			args.append("customer:\(customer.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "customerUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}
	}

	/// The schema’s entry-point for mutations. This acts as the public, top-level 
	/// API from which all mutation queries must start. 
	open class Mutation: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = MutationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "checkoutAttributesUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutAttributesUpdatePayload(fields: value)

				case "checkoutCompleteFree":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCompleteFreePayload(fields: value)

				case "checkoutCompleteWithCreditCard":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCompleteWithCreditCardPayload(fields: value)

				case "checkoutCompleteWithTokenizedPayment":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCompleteWithTokenizedPaymentPayload(fields: value)

				case "checkoutCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCreatePayload(fields: value)

				case "checkoutCustomerAssociate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCustomerAssociatePayload(fields: value)

				case "checkoutCustomerDisassociate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCustomerDisassociatePayload(fields: value)

				case "checkoutEmailUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutEmailUpdatePayload(fields: value)

				case "checkoutGiftCardApply":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutGiftCardApplyPayload(fields: value)

				case "checkoutGiftCardRemove":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutGiftCardRemovePayload(fields: value)

				case "checkoutLineItemsAdd":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutLineItemsAddPayload(fields: value)

				case "checkoutLineItemsRemove":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutLineItemsRemovePayload(fields: value)

				case "checkoutLineItemsUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutLineItemsUpdatePayload(fields: value)

				case "checkoutShippingAddressUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutShippingAddressUpdatePayload(fields: value)

				case "checkoutShippingLineUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutShippingLineUpdatePayload(fields: value)

				case "customerAccessTokenCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenCreatePayload(fields: value)

				case "customerAccessTokenDelete":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenDeletePayload(fields: value)

				case "customerAccessTokenRenew":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenRenewPayload(fields: value)

				case "customerActivate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerActivatePayload(fields: value)

				case "customerAddressCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAddressCreatePayload(fields: value)

				case "customerAddressDelete":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAddressDeletePayload(fields: value)

				case "customerAddressUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAddressUpdatePayload(fields: value)

				case "customerCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerCreatePayload(fields: value)

				case "customerRecover":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerRecoverPayload(fields: value)

				case "customerReset":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerResetPayload(fields: value)

				case "customerUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerUpdatePayload(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// Updates the attributes of a checkout. 
		open var checkoutAttributesUpdate: Storefront.CheckoutAttributesUpdatePayload? {
			return internalGetCheckoutAttributesUpdate()
		}

		open func aliasedCheckoutAttributesUpdate(alias: String) -> Storefront.CheckoutAttributesUpdatePayload? {
			return internalGetCheckoutAttributesUpdate(alias: alias)
		}

		func internalGetCheckoutAttributesUpdate(alias: String? = nil) -> Storefront.CheckoutAttributesUpdatePayload? {
			return field(field: "checkoutAttributesUpdate", aliasSuffix: alias) as! Storefront.CheckoutAttributesUpdatePayload?
		}

		open var checkoutCompleteFree: Storefront.CheckoutCompleteFreePayload? {
			return internalGetCheckoutCompleteFree()
		}

		open func aliasedCheckoutCompleteFree(alias: String) -> Storefront.CheckoutCompleteFreePayload? {
			return internalGetCheckoutCompleteFree(alias: alias)
		}

		func internalGetCheckoutCompleteFree(alias: String? = nil) -> Storefront.CheckoutCompleteFreePayload? {
			return field(field: "checkoutCompleteFree", aliasSuffix: alias) as! Storefront.CheckoutCompleteFreePayload?
		}

		/// Completes a checkout using a credit card token from Shopify's Vault. 
		open var checkoutCompleteWithCreditCard: Storefront.CheckoutCompleteWithCreditCardPayload? {
			return internalGetCheckoutCompleteWithCreditCard()
		}

		open func aliasedCheckoutCompleteWithCreditCard(alias: String) -> Storefront.CheckoutCompleteWithCreditCardPayload? {
			return internalGetCheckoutCompleteWithCreditCard(alias: alias)
		}

		func internalGetCheckoutCompleteWithCreditCard(alias: String? = nil) -> Storefront.CheckoutCompleteWithCreditCardPayload? {
			return field(field: "checkoutCompleteWithCreditCard", aliasSuffix: alias) as! Storefront.CheckoutCompleteWithCreditCardPayload?
		}

		/// Completes a checkout with a tokenized payment. 
		open var checkoutCompleteWithTokenizedPayment: Storefront.CheckoutCompleteWithTokenizedPaymentPayload? {
			return internalGetCheckoutCompleteWithTokenizedPayment()
		}

		open func aliasedCheckoutCompleteWithTokenizedPayment(alias: String) -> Storefront.CheckoutCompleteWithTokenizedPaymentPayload? {
			return internalGetCheckoutCompleteWithTokenizedPayment(alias: alias)
		}

		func internalGetCheckoutCompleteWithTokenizedPayment(alias: String? = nil) -> Storefront.CheckoutCompleteWithTokenizedPaymentPayload? {
			return field(field: "checkoutCompleteWithTokenizedPayment", aliasSuffix: alias) as! Storefront.CheckoutCompleteWithTokenizedPaymentPayload?
		}

		/// Creates a new checkout. 
		open var checkoutCreate: Storefront.CheckoutCreatePayload? {
			return internalGetCheckoutCreate()
		}

		open func aliasedCheckoutCreate(alias: String) -> Storefront.CheckoutCreatePayload? {
			return internalGetCheckoutCreate(alias: alias)
		}

		func internalGetCheckoutCreate(alias: String? = nil) -> Storefront.CheckoutCreatePayload? {
			return field(field: "checkoutCreate", aliasSuffix: alias) as! Storefront.CheckoutCreatePayload?
		}

		/// Associates a customer to the checkout. 
		open var checkoutCustomerAssociate: Storefront.CheckoutCustomerAssociatePayload? {
			return internalGetCheckoutCustomerAssociate()
		}

		open func aliasedCheckoutCustomerAssociate(alias: String) -> Storefront.CheckoutCustomerAssociatePayload? {
			return internalGetCheckoutCustomerAssociate(alias: alias)
		}

		func internalGetCheckoutCustomerAssociate(alias: String? = nil) -> Storefront.CheckoutCustomerAssociatePayload? {
			return field(field: "checkoutCustomerAssociate", aliasSuffix: alias) as! Storefront.CheckoutCustomerAssociatePayload?
		}

		/// Disassociates the current checkout customer from the checkout. 
		open var checkoutCustomerDisassociate: Storefront.CheckoutCustomerDisassociatePayload? {
			return internalGetCheckoutCustomerDisassociate()
		}

		open func aliasedCheckoutCustomerDisassociate(alias: String) -> Storefront.CheckoutCustomerDisassociatePayload? {
			return internalGetCheckoutCustomerDisassociate(alias: alias)
		}

		func internalGetCheckoutCustomerDisassociate(alias: String? = nil) -> Storefront.CheckoutCustomerDisassociatePayload? {
			return field(field: "checkoutCustomerDisassociate", aliasSuffix: alias) as! Storefront.CheckoutCustomerDisassociatePayload?
		}

		/// Updates the email on an existing checkout. 
		open var checkoutEmailUpdate: Storefront.CheckoutEmailUpdatePayload? {
			return internalGetCheckoutEmailUpdate()
		}

		open func aliasedCheckoutEmailUpdate(alias: String) -> Storefront.CheckoutEmailUpdatePayload? {
			return internalGetCheckoutEmailUpdate(alias: alias)
		}

		func internalGetCheckoutEmailUpdate(alias: String? = nil) -> Storefront.CheckoutEmailUpdatePayload? {
			return field(field: "checkoutEmailUpdate", aliasSuffix: alias) as! Storefront.CheckoutEmailUpdatePayload?
		}

		/// Applies a gift card to an existing checkout using a gift card code. 
		open var checkoutGiftCardApply: Storefront.CheckoutGiftCardApplyPayload? {
			return internalGetCheckoutGiftCardApply()
		}

		open func aliasedCheckoutGiftCardApply(alias: String) -> Storefront.CheckoutGiftCardApplyPayload? {
			return internalGetCheckoutGiftCardApply(alias: alias)
		}

		func internalGetCheckoutGiftCardApply(alias: String? = nil) -> Storefront.CheckoutGiftCardApplyPayload? {
			return field(field: "checkoutGiftCardApply", aliasSuffix: alias) as! Storefront.CheckoutGiftCardApplyPayload?
		}

		/// Removes an applied gift card from the checkout. 
		open var checkoutGiftCardRemove: Storefront.CheckoutGiftCardRemovePayload? {
			return internalGetCheckoutGiftCardRemove()
		}

		open func aliasedCheckoutGiftCardRemove(alias: String) -> Storefront.CheckoutGiftCardRemovePayload? {
			return internalGetCheckoutGiftCardRemove(alias: alias)
		}

		func internalGetCheckoutGiftCardRemove(alias: String? = nil) -> Storefront.CheckoutGiftCardRemovePayload? {
			return field(field: "checkoutGiftCardRemove", aliasSuffix: alias) as! Storefront.CheckoutGiftCardRemovePayload?
		}

		/// Adds a list of line items to a checkout. 
		open var checkoutLineItemsAdd: Storefront.CheckoutLineItemsAddPayload? {
			return internalGetCheckoutLineItemsAdd()
		}

		open func aliasedCheckoutLineItemsAdd(alias: String) -> Storefront.CheckoutLineItemsAddPayload? {
			return internalGetCheckoutLineItemsAdd(alias: alias)
		}

		func internalGetCheckoutLineItemsAdd(alias: String? = nil) -> Storefront.CheckoutLineItemsAddPayload? {
			return field(field: "checkoutLineItemsAdd", aliasSuffix: alias) as! Storefront.CheckoutLineItemsAddPayload?
		}

		/// Removes line items from an existing checkout 
		open var checkoutLineItemsRemove: Storefront.CheckoutLineItemsRemovePayload? {
			return internalGetCheckoutLineItemsRemove()
		}

		open func aliasedCheckoutLineItemsRemove(alias: String) -> Storefront.CheckoutLineItemsRemovePayload? {
			return internalGetCheckoutLineItemsRemove(alias: alias)
		}

		func internalGetCheckoutLineItemsRemove(alias: String? = nil) -> Storefront.CheckoutLineItemsRemovePayload? {
			return field(field: "checkoutLineItemsRemove", aliasSuffix: alias) as! Storefront.CheckoutLineItemsRemovePayload?
		}

		/// Updates line items on a checkout. 
		open var checkoutLineItemsUpdate: Storefront.CheckoutLineItemsUpdatePayload? {
			return internalGetCheckoutLineItemsUpdate()
		}

		open func aliasedCheckoutLineItemsUpdate(alias: String) -> Storefront.CheckoutLineItemsUpdatePayload? {
			return internalGetCheckoutLineItemsUpdate(alias: alias)
		}

		func internalGetCheckoutLineItemsUpdate(alias: String? = nil) -> Storefront.CheckoutLineItemsUpdatePayload? {
			return field(field: "checkoutLineItemsUpdate", aliasSuffix: alias) as! Storefront.CheckoutLineItemsUpdatePayload?
		}

		/// Updates the shipping address of an existing checkout. 
		open var checkoutShippingAddressUpdate: Storefront.CheckoutShippingAddressUpdatePayload? {
			return internalGetCheckoutShippingAddressUpdate()
		}

		open func aliasedCheckoutShippingAddressUpdate(alias: String) -> Storefront.CheckoutShippingAddressUpdatePayload? {
			return internalGetCheckoutShippingAddressUpdate(alias: alias)
		}

		func internalGetCheckoutShippingAddressUpdate(alias: String? = nil) -> Storefront.CheckoutShippingAddressUpdatePayload? {
			return field(field: "checkoutShippingAddressUpdate", aliasSuffix: alias) as! Storefront.CheckoutShippingAddressUpdatePayload?
		}

		/// Updates the shipping lines on an existing checkout. 
		open var checkoutShippingLineUpdate: Storefront.CheckoutShippingLineUpdatePayload? {
			return internalGetCheckoutShippingLineUpdate()
		}

		open func aliasedCheckoutShippingLineUpdate(alias: String) -> Storefront.CheckoutShippingLineUpdatePayload? {
			return internalGetCheckoutShippingLineUpdate(alias: alias)
		}

		func internalGetCheckoutShippingLineUpdate(alias: String? = nil) -> Storefront.CheckoutShippingLineUpdatePayload? {
			return field(field: "checkoutShippingLineUpdate", aliasSuffix: alias) as! Storefront.CheckoutShippingLineUpdatePayload?
		}

		/// Creates a customer access token. The customer access token is required to 
		/// modify the customer object in any way. 
		open var customerAccessTokenCreate: Storefront.CustomerAccessTokenCreatePayload? {
			return internalGetCustomerAccessTokenCreate()
		}

		open func aliasedCustomerAccessTokenCreate(alias: String) -> Storefront.CustomerAccessTokenCreatePayload? {
			return internalGetCustomerAccessTokenCreate(alias: alias)
		}

		func internalGetCustomerAccessTokenCreate(alias: String? = nil) -> Storefront.CustomerAccessTokenCreatePayload? {
			return field(field: "customerAccessTokenCreate", aliasSuffix: alias) as! Storefront.CustomerAccessTokenCreatePayload?
		}

		/// Permanently destroys a customer access token. 
		open var customerAccessTokenDelete: Storefront.CustomerAccessTokenDeletePayload? {
			return internalGetCustomerAccessTokenDelete()
		}

		open func aliasedCustomerAccessTokenDelete(alias: String) -> Storefront.CustomerAccessTokenDeletePayload? {
			return internalGetCustomerAccessTokenDelete(alias: alias)
		}

		func internalGetCustomerAccessTokenDelete(alias: String? = nil) -> Storefront.CustomerAccessTokenDeletePayload? {
			return field(field: "customerAccessTokenDelete", aliasSuffix: alias) as! Storefront.CustomerAccessTokenDeletePayload?
		}

		/// Renews a customer access token. 
		open var customerAccessTokenRenew: Storefront.CustomerAccessTokenRenewPayload? {
			return internalGetCustomerAccessTokenRenew()
		}

		open func aliasedCustomerAccessTokenRenew(alias: String) -> Storefront.CustomerAccessTokenRenewPayload? {
			return internalGetCustomerAccessTokenRenew(alias: alias)
		}

		func internalGetCustomerAccessTokenRenew(alias: String? = nil) -> Storefront.CustomerAccessTokenRenewPayload? {
			return field(field: "customerAccessTokenRenew", aliasSuffix: alias) as! Storefront.CustomerAccessTokenRenewPayload?
		}

		/// Activates a customer. 
		open var customerActivate: Storefront.CustomerActivatePayload? {
			return internalGetCustomerActivate()
		}

		open func aliasedCustomerActivate(alias: String) -> Storefront.CustomerActivatePayload? {
			return internalGetCustomerActivate(alias: alias)
		}

		func internalGetCustomerActivate(alias: String? = nil) -> Storefront.CustomerActivatePayload? {
			return field(field: "customerActivate", aliasSuffix: alias) as! Storefront.CustomerActivatePayload?
		}

		/// Creates a new address for a customer. 
		open var customerAddressCreate: Storefront.CustomerAddressCreatePayload? {
			return internalGetCustomerAddressCreate()
		}

		open func aliasedCustomerAddressCreate(alias: String) -> Storefront.CustomerAddressCreatePayload? {
			return internalGetCustomerAddressCreate(alias: alias)
		}

		func internalGetCustomerAddressCreate(alias: String? = nil) -> Storefront.CustomerAddressCreatePayload? {
			return field(field: "customerAddressCreate", aliasSuffix: alias) as! Storefront.CustomerAddressCreatePayload?
		}

		/// Permanently deletes the address of an existing customer. 
		open var customerAddressDelete: Storefront.CustomerAddressDeletePayload? {
			return internalGetCustomerAddressDelete()
		}

		open func aliasedCustomerAddressDelete(alias: String) -> Storefront.CustomerAddressDeletePayload? {
			return internalGetCustomerAddressDelete(alias: alias)
		}

		func internalGetCustomerAddressDelete(alias: String? = nil) -> Storefront.CustomerAddressDeletePayload? {
			return field(field: "customerAddressDelete", aliasSuffix: alias) as! Storefront.CustomerAddressDeletePayload?
		}

		/// Updates the address of an existing customer. 
		open var customerAddressUpdate: Storefront.CustomerAddressUpdatePayload? {
			return internalGetCustomerAddressUpdate()
		}

		open func aliasedCustomerAddressUpdate(alias: String) -> Storefront.CustomerAddressUpdatePayload? {
			return internalGetCustomerAddressUpdate(alias: alias)
		}

		func internalGetCustomerAddressUpdate(alias: String? = nil) -> Storefront.CustomerAddressUpdatePayload? {
			return field(field: "customerAddressUpdate", aliasSuffix: alias) as! Storefront.CustomerAddressUpdatePayload?
		}

		/// Creates a new customer. 
		open var customerCreate: Storefront.CustomerCreatePayload? {
			return internalGetCustomerCreate()
		}

		open func aliasedCustomerCreate(alias: String) -> Storefront.CustomerCreatePayload? {
			return internalGetCustomerCreate(alias: alias)
		}

		func internalGetCustomerCreate(alias: String? = nil) -> Storefront.CustomerCreatePayload? {
			return field(field: "customerCreate", aliasSuffix: alias) as! Storefront.CustomerCreatePayload?
		}

		/// Sends a reset password email to the customer, as the first step in the 
		/// reset password process. 
		open var customerRecover: Storefront.CustomerRecoverPayload? {
			return internalGetCustomerRecover()
		}

		open func aliasedCustomerRecover(alias: String) -> Storefront.CustomerRecoverPayload? {
			return internalGetCustomerRecover(alias: alias)
		}

		func internalGetCustomerRecover(alias: String? = nil) -> Storefront.CustomerRecoverPayload? {
			return field(field: "customerRecover", aliasSuffix: alias) as! Storefront.CustomerRecoverPayload?
		}

		/// Resets a customer’s password with a token received from `CustomerRecover`. 
		open var customerReset: Storefront.CustomerResetPayload? {
			return internalGetCustomerReset()
		}

		open func aliasedCustomerReset(alias: String) -> Storefront.CustomerResetPayload? {
			return internalGetCustomerReset(alias: alias)
		}

		func internalGetCustomerReset(alias: String? = nil) -> Storefront.CustomerResetPayload? {
			return field(field: "customerReset", aliasSuffix: alias) as! Storefront.CustomerResetPayload?
		}

		/// Updates an existing customer. 
		open var customerUpdate: Storefront.CustomerUpdatePayload? {
			return internalGetCustomerUpdate()
		}

		open func aliasedCustomerUpdate(alias: String) -> Storefront.CustomerUpdatePayload? {
			return internalGetCustomerUpdate(alias: alias)
		}

		func internalGetCustomerUpdate(alias: String? = nil) -> Storefront.CustomerUpdatePayload? {
			return field(field: "customerUpdate", aliasSuffix: alias) as! Storefront.CustomerUpdatePayload?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "checkoutAttributesUpdate":
					if let value = internalGetCheckoutAttributesUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCompleteFree":
					if let value = internalGetCheckoutCompleteFree() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCompleteWithCreditCard":
					if let value = internalGetCheckoutCompleteWithCreditCard() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCompleteWithTokenizedPayment":
					if let value = internalGetCheckoutCompleteWithTokenizedPayment() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCreate":
					if let value = internalGetCheckoutCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCustomerAssociate":
					if let value = internalGetCheckoutCustomerAssociate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCustomerDisassociate":
					if let value = internalGetCheckoutCustomerDisassociate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutEmailUpdate":
					if let value = internalGetCheckoutEmailUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutGiftCardApply":
					if let value = internalGetCheckoutGiftCardApply() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutGiftCardRemove":
					if let value = internalGetCheckoutGiftCardRemove() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutLineItemsAdd":
					if let value = internalGetCheckoutLineItemsAdd() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutLineItemsRemove":
					if let value = internalGetCheckoutLineItemsRemove() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutLineItemsUpdate":
					if let value = internalGetCheckoutLineItemsUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutShippingAddressUpdate":
					if let value = internalGetCheckoutShippingAddressUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutShippingLineUpdate":
					if let value = internalGetCheckoutShippingLineUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAccessTokenCreate":
					if let value = internalGetCustomerAccessTokenCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAccessTokenDelete":
					if let value = internalGetCustomerAccessTokenDelete() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAccessTokenRenew":
					if let value = internalGetCustomerAccessTokenRenew() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerActivate":
					if let value = internalGetCustomerActivate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAddressCreate":
					if let value = internalGetCustomerAddressCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAddressDelete":
					if let value = internalGetCustomerAddressDelete() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAddressUpdate":
					if let value = internalGetCustomerAddressUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerCreate":
					if let value = internalGetCustomerCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerRecover":
					if let value = internalGetCustomerRecover() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerReset":
					if let value = internalGetCustomerReset() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerUpdate":
					if let value = internalGetCustomerUpdate() {
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
