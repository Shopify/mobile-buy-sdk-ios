//
//  Mutation.swift
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
	/// The schema’s entry-point for mutations. This acts as the public, top-level 
	/// API from which all mutation queries must start. 
	open class MutationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Mutation

		open override var description: String {
			return "mutation " + super.description
		}

		/// Updates the attributes on a cart. 
		///
		/// - parameters:
		///     - attributes: An array of key-value pairs that contains additional information about the cart.
		///        
		///        The input must not contain more than `250` values.
		///     - cartId: The ID of the cart.
		///
		@discardableResult
		open func cartAttributesUpdate(alias: String? = nil, attributes: [AttributeInput], cartId: GraphQL.ID, _ subfields: (CartAttributesUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("attributes:[\(attributes.map { "\($0.serialize())" }.joined(separator: ","))]")

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartAttributesUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartAttributesUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates the billing address on the cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - billingAddress: The customer's billing address.
		///
		@discardableResult
		open func cartBillingAddressUpdate(alias: String? = nil, cartId: GraphQL.ID, billingAddress: MailingAddressInput? = nil, _ subfields: (CartBillingAddressUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			if let billingAddress = billingAddress {
				args.append("billingAddress:\(billingAddress.serialize())")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CartBillingAddressUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartBillingAddressUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates customer information associated with a cart. Buyer identity is used 
		/// to determine [international 
		/// pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing) 
		/// and should match the customer's shipping address. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - buyerIdentity: The customer associated with the cart. Used to determine
		///        [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
		///        Buyer identity should match the customer's shipping address.
		///
		@discardableResult
		open func cartBuyerIdentityUpdate(alias: String? = nil, cartId: GraphQL.ID, buyerIdentity: CartBuyerIdentityInput, _ subfields: (CartBuyerIdentityUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("buyerIdentity:\(buyerIdentity.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartBuyerIdentityUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartBuyerIdentityUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Creates a new cart. 
		///
		/// - parameters:
		///     - input: The fields used to create a cart.
		///
		@discardableResult
		open func cartCreate(alias: String? = nil, input: CartInput? = nil, _ subfields: (CartCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			if let input = input {
				args.append("input:\(input.serialize())")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CartCreatePayloadQuery()
			subfields(subquery)

			addField(field: "cartCreate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Adds delivery addresses to the cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - addresses: A list of delivery addresses to add to the cart.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartDeliveryAddressesAdd(alias: String? = nil, cartId: GraphQL.ID, addresses: [CartSelectableAddressInput], _ subfields: (CartDeliveryAddressesAddPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("addresses:[\(addresses.map { "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartDeliveryAddressesAddPayloadQuery()
			subfields(subquery)

			addField(field: "cartDeliveryAddressesAdd", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Removes delivery addresses from the cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - addressIds: A list of delivery addresses by handle to remove from the cart.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartDeliveryAddressesRemove(alias: String? = nil, cartId: GraphQL.ID, addressIds: [GraphQL.ID], _ subfields: (CartDeliveryAddressesRemovePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("addressIds:[\(addressIds.map { "\(GraphQL.quoteString(input: "\($0.rawValue)"))" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartDeliveryAddressesRemovePayloadQuery()
			subfields(subquery)

			addField(field: "cartDeliveryAddressesRemove", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates one or more delivery addresses on a cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - addresses: The delivery addresses to update.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartDeliveryAddressesUpdate(alias: String? = nil, cartId: GraphQL.ID, addresses: [CartSelectableAddressUpdateInput], _ subfields: (CartDeliveryAddressesUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("addresses:[\(addresses.map { "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartDeliveryAddressesUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartDeliveryAddressesUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates the discount codes applied to the cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - discountCodes: The case-insensitive discount codes that the customer added at checkout.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartDiscountCodesUpdate(alias: String? = nil, cartId: GraphQL.ID, discountCodes: [String]? = nil, _ subfields: (CartDiscountCodesUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			if let discountCodes = discountCodes {
				args.append("discountCodes:[\(discountCodes.map { "\(GraphQL.quoteString(input: $0))" }.joined(separator: ","))]")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CartDiscountCodesUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartDiscountCodesUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Removes the gift card codes applied to the cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - appliedGiftCardIds: The gift cards to remove.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartGiftCardCodesRemove(alias: String? = nil, cartId: GraphQL.ID, appliedGiftCardIds: [GraphQL.ID], _ subfields: (CartGiftCardCodesRemovePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("appliedGiftCardIds:[\(appliedGiftCardIds.map { "\(GraphQL.quoteString(input: "\($0.rawValue)"))" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartGiftCardCodesRemovePayloadQuery()
			subfields(subquery)

			addField(field: "cartGiftCardCodesRemove", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates the gift card codes applied to the cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - giftCardCodes: The case-insensitive gift card codes.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartGiftCardCodesUpdate(alias: String? = nil, cartId: GraphQL.ID, giftCardCodes: [String], _ subfields: (CartGiftCardCodesUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("giftCardCodes:[\(giftCardCodes.map { "\(GraphQL.quoteString(input: $0))" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartGiftCardCodesUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartGiftCardCodesUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Adds a merchandise line to the cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - lines: A list of merchandise lines to add to the cart.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartLinesAdd(alias: String? = nil, cartId: GraphQL.ID, lines: [CartLineInput], _ subfields: (CartLinesAddPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("lines:[\(lines.map { "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartLinesAddPayloadQuery()
			subfields(subquery)

			addField(field: "cartLinesAdd", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Removes one or more merchandise lines from the cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - lineIds: The merchandise line IDs to remove.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartLinesRemove(alias: String? = nil, cartId: GraphQL.ID, lineIds: [GraphQL.ID], _ subfields: (CartLinesRemovePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("lineIds:[\(lineIds.map { "\(GraphQL.quoteString(input: "\($0.rawValue)"))" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartLinesRemovePayloadQuery()
			subfields(subquery)

			addField(field: "cartLinesRemove", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates one or more merchandise lines on a cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - lines: The merchandise lines to update.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartLinesUpdate(alias: String? = nil, cartId: GraphQL.ID, lines: [CartLineUpdateInput], _ subfields: (CartLinesUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("lines:[\(lines.map { "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartLinesUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartLinesUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Deletes a cart metafield. 
		///
		/// - parameters:
		///     - input: The input fields used to delete a cart metafield.
		///
		@discardableResult
		open func cartMetafieldDelete(alias: String? = nil, input: CartMetafieldDeleteInput, _ subfields: (CartMetafieldDeletePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartMetafieldDeletePayloadQuery()
			subfields(subquery)

			addField(field: "cartMetafieldDelete", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Sets cart metafield values. Cart metafield values will be set regardless if 
		/// they were previously created or not. Allows a maximum of 25 cart metafields 
		/// to be set at a time. 
		///
		/// - parameters:
		///     - metafields: The list of Cart metafield values to set. Maximum of 25.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartMetafieldsSet(alias: String? = nil, metafields: [CartMetafieldsSetInput], _ subfields: (CartMetafieldsSetPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("metafields:[\(metafields.map { "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartMetafieldsSetPayloadQuery()
			subfields(subquery)

			addField(field: "cartMetafieldsSet", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Updates the note on the cart. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - note: The note on the cart.
		///
		@discardableResult
		open func cartNoteUpdate(alias: String? = nil, cartId: GraphQL.ID, note: String, _ subfields: (CartNoteUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("note:\(GraphQL.quoteString(input: note))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartNoteUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartNoteUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Update the customer's payment method that will be used to checkout. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - payment: The payment information for the cart that will be used at checkout.
		///
		@discardableResult
		open func cartPaymentUpdate(alias: String? = nil, cartId: GraphQL.ID, payment: CartPaymentInput, _ subfields: (CartPaymentUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("payment:\(payment.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartPaymentUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartPaymentUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Prepare the cart for cart checkout completion. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///
		@discardableResult
		open func cartPrepareForCompletion(alias: String? = nil, cartId: GraphQL.ID, _ subfields: (CartPrepareForCompletionPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartPrepareForCompletionPayloadQuery()
			subfields(subquery)

			addField(field: "cartPrepareForCompletion", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Update the selected delivery options for a delivery group. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - selectedDeliveryOptions: The selected delivery options.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func cartSelectedDeliveryOptionsUpdate(alias: String? = nil, cartId: GraphQL.ID, selectedDeliveryOptions: [CartSelectedDeliveryOptionInput], _ subfields: (CartSelectedDeliveryOptionsUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("selectedDeliveryOptions:[\(selectedDeliveryOptions.map { "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartSelectedDeliveryOptionsUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "cartSelectedDeliveryOptionsUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Submit the cart for checkout completion. 
		///
		/// - parameters:
		///     - cartId: The ID of the cart.
		///     - attemptToken: The attemptToken is used to guarantee an idempotent result.
		///        If more than one call uses the same attemptToken within a short period of time, only one will be accepted.
		///
		@discardableResult
		open func cartSubmitForCompletion(alias: String? = nil, cartId: GraphQL.ID, attemptToken: String, _ subfields: (CartSubmitForCompletionPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("cartId:\(GraphQL.quoteString(input: "\(cartId.rawValue)"))")

			args.append("attemptToken:\(GraphQL.quoteString(input: attemptToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CartSubmitForCompletionPayloadQuery()
			subfields(subquery)

			addField(field: "cartSubmitForCompletion", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Creates a customer access token. The customer access token is required to 
		/// modify the customer object in any way. 
		///
		/// - parameters:
		///     - input: The fields used to create a customer access token.
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

		/// Creates a customer access token using a [multipass 
		/// token](https://shopify.dev/api/multipass) instead of email and password. A 
		/// customer record is created if the customer doesn't exist. If a customer 
		/// record already exists but the record is disabled, then the customer record 
		/// is enabled. 
		///
		/// - parameters:
		///     - multipassToken: A valid [multipass token](https://shopify.dev/api/multipass) to be authenticated.
		///
		@discardableResult
		open func customerAccessTokenCreateWithMultipass(alias: String? = nil, multipassToken: String, _ subfields: (CustomerAccessTokenCreateWithMultipassPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("multipassToken:\(GraphQL.quoteString(input: multipassToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAccessTokenCreateWithMultipassPayloadQuery()
			subfields(subquery)

			addField(field: "customerAccessTokenCreateWithMultipass", aliasSuffix: alias, args: argsString, subfields: subquery)
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

		/// Renews a customer access token. Access token renewal must happen *before* a 
		/// token expires. If a token has already expired, a new one should be created 
		/// instead via `customerAccessTokenCreate`. 
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
		///     - input: The fields used to activate a customer.
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

		/// Activates a customer with the activation url received from 
		/// `customerCreate`. 
		///
		/// - parameters:
		///     - activationUrl: The customer activation URL.
		///     - password: A new password set during activation.
		///
		@discardableResult
		open func customerActivateByUrl(alias: String? = nil, activationUrl: URL, password: String, _ subfields: (CustomerActivateByUrlPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("activationUrl:\(GraphQL.quoteString(input: "\(activationUrl.absoluteString)"))")

			args.append("password:\(GraphQL.quoteString(input: password))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerActivateByUrlPayloadQuery()
			subfields(subquery)

			addField(field: "customerActivateByUrl", aliasSuffix: alias, args: argsString, subfields: subquery)
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
		///     - input: The fields used to create a new customer.
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

		/// Updates the default address of an existing customer. 
		///
		/// - parameters:
		///     - customerAccessToken: The access token used to identify the customer.
		///     - addressId: ID of the address to set as the new default for the customer.
		///
		@discardableResult
		open func customerDefaultAddressUpdate(alias: String? = nil, customerAccessToken: String, addressId: GraphQL.ID, _ subfields: (CustomerDefaultAddressUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			args.append("addressId:\(GraphQL.quoteString(input: "\(addressId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerDefaultAddressUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "customerDefaultAddressUpdate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Sends a reset password email to the customer. The reset password email 
		/// contains a reset password URL and token that you can pass to the 
		/// [`customerResetByUrl`](https://shopify.dev/api/storefront/latest/mutations/customerResetByUrl) 
		/// or 
		/// [`customerReset`](https://shopify.dev/api/storefront/latest/mutations/customerReset) 
		/// mutation to reset the customer password. This mutation is throttled by IP. 
		/// With private access, you can provide a 
		/// [`Shopify-Storefront-Buyer-IP`](https://shopify.dev/api/usage/authentication#optional-ip-header) 
		/// instead of the request IP. The header is case-sensitive and must be sent as 
		/// `Shopify-Storefront-Buyer-IP`. Make sure that the value provided to 
		/// `Shopify-Storefront-Buyer-IP` is trusted. Unthrottled access to this 
		/// mutation presents a security risk. 
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

		/// "Resets a customer’s password with the token received from a reset password 
		/// email. You can send a reset password email with the 
		/// [`customerRecover`](https://shopify.dev/api/storefront/latest/mutations/customerRecover) 
		/// mutation." 
		///
		/// - parameters:
		///     - id: Specifies the customer to reset.
		///     - input: The fields used to reset a customer’s password.
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

		/// "Resets a customer’s password with the reset password URL received from a 
		/// reset password email. You can send a reset password email with the 
		/// [`customerRecover`](https://shopify.dev/api/storefront/latest/mutations/customerRecover) 
		/// mutation." 
		///
		/// - parameters:
		///     - resetUrl: The customer's reset password url.
		///     - password: New password that will be set as part of the reset password process.
		///
		@discardableResult
		open func customerResetByUrl(alias: String? = nil, resetUrl: URL, password: String, _ subfields: (CustomerResetByUrlPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("resetUrl:\(GraphQL.quoteString(input: "\(resetUrl.absoluteString)"))")

			args.append("password:\(GraphQL.quoteString(input: password))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerResetByUrlPayloadQuery()
			subfields(subquery)

			addField(field: "customerResetByUrl", aliasSuffix: alias, args: argsString, subfields: subquery)
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

		/// Create a new Shop Pay payment request session. 
		///
		/// - parameters:
		///     - sourceIdentifier: A unique identifier for the payment request session.
		///     - paymentRequest: A payment request object.
		///
		@discardableResult
		open func shopPayPaymentRequestSessionCreate(alias: String? = nil, sourceIdentifier: String, paymentRequest: ShopPayPaymentRequestInput, _ subfields: (ShopPayPaymentRequestSessionCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("sourceIdentifier:\(GraphQL.quoteString(input: sourceIdentifier))")

			args.append("paymentRequest:\(paymentRequest.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ShopPayPaymentRequestSessionCreatePayloadQuery()
			subfields(subquery)

			addField(field: "shopPayPaymentRequestSessionCreate", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Submits a Shop Pay payment request session. 
		///
		/// - parameters:
		///     - token: A token representing a payment session request.
		///     - paymentRequest: The final payment request object.
		///     - idempotencyKey: The idempotency key is used to guarantee an idempotent result.
		///     - orderName: The order name to be used for the order created from the payment request.
		///
		@discardableResult
		open func shopPayPaymentRequestSessionSubmit(alias: String? = nil, token: String, paymentRequest: ShopPayPaymentRequestInput, idempotencyKey: String, orderName: String? = nil, _ subfields: (ShopPayPaymentRequestSessionSubmitPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("token:\(GraphQL.quoteString(input: token))")

			args.append("paymentRequest:\(paymentRequest.serialize())")

			args.append("idempotencyKey:\(GraphQL.quoteString(input: idempotencyKey))")

			if let orderName = orderName {
				args.append("orderName:\(GraphQL.quoteString(input: orderName))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ShopPayPaymentRequestSessionSubmitPayloadQuery()
			subfields(subquery)

			addField(field: "shopPayPaymentRequestSessionSubmit", aliasSuffix: alias, args: argsString, subfields: subquery)
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
				case "cartAttributesUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartAttributesUpdatePayload(fields: value)

				case "cartBillingAddressUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartBillingAddressUpdatePayload(fields: value)

				case "cartBuyerIdentityUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartBuyerIdentityUpdatePayload(fields: value)

				case "cartCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartCreatePayload(fields: value)

				case "cartDeliveryAddressesAdd":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartDeliveryAddressesAddPayload(fields: value)

				case "cartDeliveryAddressesRemove":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartDeliveryAddressesRemovePayload(fields: value)

				case "cartDeliveryAddressesUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartDeliveryAddressesUpdatePayload(fields: value)

				case "cartDiscountCodesUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartDiscountCodesUpdatePayload(fields: value)

				case "cartGiftCardCodesRemove":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartGiftCardCodesRemovePayload(fields: value)

				case "cartGiftCardCodesUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartGiftCardCodesUpdatePayload(fields: value)

				case "cartLinesAdd":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartLinesAddPayload(fields: value)

				case "cartLinesRemove":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartLinesRemovePayload(fields: value)

				case "cartLinesUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartLinesUpdatePayload(fields: value)

				case "cartMetafieldDelete":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartMetafieldDeletePayload(fields: value)

				case "cartMetafieldsSet":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartMetafieldsSetPayload(fields: value)

				case "cartNoteUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartNoteUpdatePayload(fields: value)

				case "cartPaymentUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartPaymentUpdatePayload(fields: value)

				case "cartPrepareForCompletion":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartPrepareForCompletionPayload(fields: value)

				case "cartSelectedDeliveryOptionsUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartSelectedDeliveryOptionsUpdatePayload(fields: value)

				case "cartSubmitForCompletion":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CartSubmitForCompletionPayload(fields: value)

				case "customerAccessTokenCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenCreatePayload(fields: value)

				case "customerAccessTokenCreateWithMultipass":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenCreateWithMultipassPayload(fields: value)

				case "customerAccessTokenDelete":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenDeletePayload(fields: value)

				case "customerAccessTokenRenew":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenRenewPayload(fields: value)

				case "customerActivate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerActivatePayload(fields: value)

				case "customerActivateByUrl":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerActivateByUrlPayload(fields: value)

				case "customerAddressCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerAddressCreatePayload(fields: value)

				case "customerAddressDelete":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerAddressDeletePayload(fields: value)

				case "customerAddressUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerAddressUpdatePayload(fields: value)

				case "customerCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerCreatePayload(fields: value)

				case "customerDefaultAddressUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerDefaultAddressUpdatePayload(fields: value)

				case "customerRecover":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerRecoverPayload(fields: value)

				case "customerReset":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerResetPayload(fields: value)

				case "customerResetByUrl":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerResetByUrlPayload(fields: value)

				case "customerUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try CustomerUpdatePayload(fields: value)

				case "shopPayPaymentRequestSessionCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try ShopPayPaymentRequestSessionCreatePayload(fields: value)

				case "shopPayPaymentRequestSessionSubmit":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
				}
				return try ShopPayPaymentRequestSessionSubmitPayload(fields: value)

				default:
				throw SchemaViolationError(type: Mutation.self, field: fieldName, value: fieldValue)
			}
		}

		/// Updates the attributes on a cart. 
		open var cartAttributesUpdate: Storefront.CartAttributesUpdatePayload? {
			return internalGetCartAttributesUpdate()
		}

		open func aliasedCartAttributesUpdate(alias: String) -> Storefront.CartAttributesUpdatePayload? {
			return internalGetCartAttributesUpdate(alias: alias)
		}

		func internalGetCartAttributesUpdate(alias: String? = nil) -> Storefront.CartAttributesUpdatePayload? {
			return field(field: "cartAttributesUpdate", aliasSuffix: alias) as! Storefront.CartAttributesUpdatePayload?
		}

		/// Updates the billing address on the cart. 
		open var cartBillingAddressUpdate: Storefront.CartBillingAddressUpdatePayload? {
			return internalGetCartBillingAddressUpdate()
		}

		open func aliasedCartBillingAddressUpdate(alias: String) -> Storefront.CartBillingAddressUpdatePayload? {
			return internalGetCartBillingAddressUpdate(alias: alias)
		}

		func internalGetCartBillingAddressUpdate(alias: String? = nil) -> Storefront.CartBillingAddressUpdatePayload? {
			return field(field: "cartBillingAddressUpdate", aliasSuffix: alias) as! Storefront.CartBillingAddressUpdatePayload?
		}

		/// Updates customer information associated with a cart. Buyer identity is used 
		/// to determine [international 
		/// pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing) 
		/// and should match the customer's shipping address. 
		open var cartBuyerIdentityUpdate: Storefront.CartBuyerIdentityUpdatePayload? {
			return internalGetCartBuyerIdentityUpdate()
		}

		open func aliasedCartBuyerIdentityUpdate(alias: String) -> Storefront.CartBuyerIdentityUpdatePayload? {
			return internalGetCartBuyerIdentityUpdate(alias: alias)
		}

		func internalGetCartBuyerIdentityUpdate(alias: String? = nil) -> Storefront.CartBuyerIdentityUpdatePayload? {
			return field(field: "cartBuyerIdentityUpdate", aliasSuffix: alias) as! Storefront.CartBuyerIdentityUpdatePayload?
		}

		/// Creates a new cart. 
		open var cartCreate: Storefront.CartCreatePayload? {
			return internalGetCartCreate()
		}

		open func aliasedCartCreate(alias: String) -> Storefront.CartCreatePayload? {
			return internalGetCartCreate(alias: alias)
		}

		func internalGetCartCreate(alias: String? = nil) -> Storefront.CartCreatePayload? {
			return field(field: "cartCreate", aliasSuffix: alias) as! Storefront.CartCreatePayload?
		}

		/// Adds delivery addresses to the cart. 
		open var cartDeliveryAddressesAdd: Storefront.CartDeliveryAddressesAddPayload? {
			return internalGetCartDeliveryAddressesAdd()
		}

		open func aliasedCartDeliveryAddressesAdd(alias: String) -> Storefront.CartDeliveryAddressesAddPayload? {
			return internalGetCartDeliveryAddressesAdd(alias: alias)
		}

		func internalGetCartDeliveryAddressesAdd(alias: String? = nil) -> Storefront.CartDeliveryAddressesAddPayload? {
			return field(field: "cartDeliveryAddressesAdd", aliasSuffix: alias) as! Storefront.CartDeliveryAddressesAddPayload?
		}

		/// Removes delivery addresses from the cart. 
		open var cartDeliveryAddressesRemove: Storefront.CartDeliveryAddressesRemovePayload? {
			return internalGetCartDeliveryAddressesRemove()
		}

		open func aliasedCartDeliveryAddressesRemove(alias: String) -> Storefront.CartDeliveryAddressesRemovePayload? {
			return internalGetCartDeliveryAddressesRemove(alias: alias)
		}

		func internalGetCartDeliveryAddressesRemove(alias: String? = nil) -> Storefront.CartDeliveryAddressesRemovePayload? {
			return field(field: "cartDeliveryAddressesRemove", aliasSuffix: alias) as! Storefront.CartDeliveryAddressesRemovePayload?
		}

		/// Updates one or more delivery addresses on a cart. 
		open var cartDeliveryAddressesUpdate: Storefront.CartDeliveryAddressesUpdatePayload? {
			return internalGetCartDeliveryAddressesUpdate()
		}

		open func aliasedCartDeliveryAddressesUpdate(alias: String) -> Storefront.CartDeliveryAddressesUpdatePayload? {
			return internalGetCartDeliveryAddressesUpdate(alias: alias)
		}

		func internalGetCartDeliveryAddressesUpdate(alias: String? = nil) -> Storefront.CartDeliveryAddressesUpdatePayload? {
			return field(field: "cartDeliveryAddressesUpdate", aliasSuffix: alias) as! Storefront.CartDeliveryAddressesUpdatePayload?
		}

		/// Updates the discount codes applied to the cart. 
		open var cartDiscountCodesUpdate: Storefront.CartDiscountCodesUpdatePayload? {
			return internalGetCartDiscountCodesUpdate()
		}

		open func aliasedCartDiscountCodesUpdate(alias: String) -> Storefront.CartDiscountCodesUpdatePayload? {
			return internalGetCartDiscountCodesUpdate(alias: alias)
		}

		func internalGetCartDiscountCodesUpdate(alias: String? = nil) -> Storefront.CartDiscountCodesUpdatePayload? {
			return field(field: "cartDiscountCodesUpdate", aliasSuffix: alias) as! Storefront.CartDiscountCodesUpdatePayload?
		}

		/// Removes the gift card codes applied to the cart. 
		open var cartGiftCardCodesRemove: Storefront.CartGiftCardCodesRemovePayload? {
			return internalGetCartGiftCardCodesRemove()
		}

		open func aliasedCartGiftCardCodesRemove(alias: String) -> Storefront.CartGiftCardCodesRemovePayload? {
			return internalGetCartGiftCardCodesRemove(alias: alias)
		}

		func internalGetCartGiftCardCodesRemove(alias: String? = nil) -> Storefront.CartGiftCardCodesRemovePayload? {
			return field(field: "cartGiftCardCodesRemove", aliasSuffix: alias) as! Storefront.CartGiftCardCodesRemovePayload?
		}

		/// Updates the gift card codes applied to the cart. 
		open var cartGiftCardCodesUpdate: Storefront.CartGiftCardCodesUpdatePayload? {
			return internalGetCartGiftCardCodesUpdate()
		}

		open func aliasedCartGiftCardCodesUpdate(alias: String) -> Storefront.CartGiftCardCodesUpdatePayload? {
			return internalGetCartGiftCardCodesUpdate(alias: alias)
		}

		func internalGetCartGiftCardCodesUpdate(alias: String? = nil) -> Storefront.CartGiftCardCodesUpdatePayload? {
			return field(field: "cartGiftCardCodesUpdate", aliasSuffix: alias) as! Storefront.CartGiftCardCodesUpdatePayload?
		}

		/// Adds a merchandise line to the cart. 
		open var cartLinesAdd: Storefront.CartLinesAddPayload? {
			return internalGetCartLinesAdd()
		}

		open func aliasedCartLinesAdd(alias: String) -> Storefront.CartLinesAddPayload? {
			return internalGetCartLinesAdd(alias: alias)
		}

		func internalGetCartLinesAdd(alias: String? = nil) -> Storefront.CartLinesAddPayload? {
			return field(field: "cartLinesAdd", aliasSuffix: alias) as! Storefront.CartLinesAddPayload?
		}

		/// Removes one or more merchandise lines from the cart. 
		open var cartLinesRemove: Storefront.CartLinesRemovePayload? {
			return internalGetCartLinesRemove()
		}

		open func aliasedCartLinesRemove(alias: String) -> Storefront.CartLinesRemovePayload? {
			return internalGetCartLinesRemove(alias: alias)
		}

		func internalGetCartLinesRemove(alias: String? = nil) -> Storefront.CartLinesRemovePayload? {
			return field(field: "cartLinesRemove", aliasSuffix: alias) as! Storefront.CartLinesRemovePayload?
		}

		/// Updates one or more merchandise lines on a cart. 
		open var cartLinesUpdate: Storefront.CartLinesUpdatePayload? {
			return internalGetCartLinesUpdate()
		}

		open func aliasedCartLinesUpdate(alias: String) -> Storefront.CartLinesUpdatePayload? {
			return internalGetCartLinesUpdate(alias: alias)
		}

		func internalGetCartLinesUpdate(alias: String? = nil) -> Storefront.CartLinesUpdatePayload? {
			return field(field: "cartLinesUpdate", aliasSuffix: alias) as! Storefront.CartLinesUpdatePayload?
		}

		/// Deletes a cart metafield. 
		open var cartMetafieldDelete: Storefront.CartMetafieldDeletePayload? {
			return internalGetCartMetafieldDelete()
		}

		open func aliasedCartMetafieldDelete(alias: String) -> Storefront.CartMetafieldDeletePayload? {
			return internalGetCartMetafieldDelete(alias: alias)
		}

		func internalGetCartMetafieldDelete(alias: String? = nil) -> Storefront.CartMetafieldDeletePayload? {
			return field(field: "cartMetafieldDelete", aliasSuffix: alias) as! Storefront.CartMetafieldDeletePayload?
		}

		/// Sets cart metafield values. Cart metafield values will be set regardless if 
		/// they were previously created or not. Allows a maximum of 25 cart metafields 
		/// to be set at a time. 
		open var cartMetafieldsSet: Storefront.CartMetafieldsSetPayload? {
			return internalGetCartMetafieldsSet()
		}

		open func aliasedCartMetafieldsSet(alias: String) -> Storefront.CartMetafieldsSetPayload? {
			return internalGetCartMetafieldsSet(alias: alias)
		}

		func internalGetCartMetafieldsSet(alias: String? = nil) -> Storefront.CartMetafieldsSetPayload? {
			return field(field: "cartMetafieldsSet", aliasSuffix: alias) as! Storefront.CartMetafieldsSetPayload?
		}

		/// Updates the note on the cart. 
		open var cartNoteUpdate: Storefront.CartNoteUpdatePayload? {
			return internalGetCartNoteUpdate()
		}

		open func aliasedCartNoteUpdate(alias: String) -> Storefront.CartNoteUpdatePayload? {
			return internalGetCartNoteUpdate(alias: alias)
		}

		func internalGetCartNoteUpdate(alias: String? = nil) -> Storefront.CartNoteUpdatePayload? {
			return field(field: "cartNoteUpdate", aliasSuffix: alias) as! Storefront.CartNoteUpdatePayload?
		}

		/// Update the customer's payment method that will be used to checkout. 
		open var cartPaymentUpdate: Storefront.CartPaymentUpdatePayload? {
			return internalGetCartPaymentUpdate()
		}

		open func aliasedCartPaymentUpdate(alias: String) -> Storefront.CartPaymentUpdatePayload? {
			return internalGetCartPaymentUpdate(alias: alias)
		}

		func internalGetCartPaymentUpdate(alias: String? = nil) -> Storefront.CartPaymentUpdatePayload? {
			return field(field: "cartPaymentUpdate", aliasSuffix: alias) as! Storefront.CartPaymentUpdatePayload?
		}

		/// Prepare the cart for cart checkout completion. 
		open var cartPrepareForCompletion: Storefront.CartPrepareForCompletionPayload? {
			return internalGetCartPrepareForCompletion()
		}

		open func aliasedCartPrepareForCompletion(alias: String) -> Storefront.CartPrepareForCompletionPayload? {
			return internalGetCartPrepareForCompletion(alias: alias)
		}

		func internalGetCartPrepareForCompletion(alias: String? = nil) -> Storefront.CartPrepareForCompletionPayload? {
			return field(field: "cartPrepareForCompletion", aliasSuffix: alias) as! Storefront.CartPrepareForCompletionPayload?
		}

		/// Update the selected delivery options for a delivery group. 
		open var cartSelectedDeliveryOptionsUpdate: Storefront.CartSelectedDeliveryOptionsUpdatePayload? {
			return internalGetCartSelectedDeliveryOptionsUpdate()
		}

		open func aliasedCartSelectedDeliveryOptionsUpdate(alias: String) -> Storefront.CartSelectedDeliveryOptionsUpdatePayload? {
			return internalGetCartSelectedDeliveryOptionsUpdate(alias: alias)
		}

		func internalGetCartSelectedDeliveryOptionsUpdate(alias: String? = nil) -> Storefront.CartSelectedDeliveryOptionsUpdatePayload? {
			return field(field: "cartSelectedDeliveryOptionsUpdate", aliasSuffix: alias) as! Storefront.CartSelectedDeliveryOptionsUpdatePayload?
		}

		/// Submit the cart for checkout completion. 
		open var cartSubmitForCompletion: Storefront.CartSubmitForCompletionPayload? {
			return internalGetCartSubmitForCompletion()
		}

		open func aliasedCartSubmitForCompletion(alias: String) -> Storefront.CartSubmitForCompletionPayload? {
			return internalGetCartSubmitForCompletion(alias: alias)
		}

		func internalGetCartSubmitForCompletion(alias: String? = nil) -> Storefront.CartSubmitForCompletionPayload? {
			return field(field: "cartSubmitForCompletion", aliasSuffix: alias) as! Storefront.CartSubmitForCompletionPayload?
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

		/// Creates a customer access token using a [multipass 
		/// token](https://shopify.dev/api/multipass) instead of email and password. A 
		/// customer record is created if the customer doesn't exist. If a customer 
		/// record already exists but the record is disabled, then the customer record 
		/// is enabled. 
		open var customerAccessTokenCreateWithMultipass: Storefront.CustomerAccessTokenCreateWithMultipassPayload? {
			return internalGetCustomerAccessTokenCreateWithMultipass()
		}

		open func aliasedCustomerAccessTokenCreateWithMultipass(alias: String) -> Storefront.CustomerAccessTokenCreateWithMultipassPayload? {
			return internalGetCustomerAccessTokenCreateWithMultipass(alias: alias)
		}

		func internalGetCustomerAccessTokenCreateWithMultipass(alias: String? = nil) -> Storefront.CustomerAccessTokenCreateWithMultipassPayload? {
			return field(field: "customerAccessTokenCreateWithMultipass", aliasSuffix: alias) as! Storefront.CustomerAccessTokenCreateWithMultipassPayload?
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

		/// Renews a customer access token. Access token renewal must happen *before* a 
		/// token expires. If a token has already expired, a new one should be created 
		/// instead via `customerAccessTokenCreate`. 
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

		/// Activates a customer with the activation url received from 
		/// `customerCreate`. 
		open var customerActivateByUrl: Storefront.CustomerActivateByUrlPayload? {
			return internalGetCustomerActivateByUrl()
		}

		open func aliasedCustomerActivateByUrl(alias: String) -> Storefront.CustomerActivateByUrlPayload? {
			return internalGetCustomerActivateByUrl(alias: alias)
		}

		func internalGetCustomerActivateByUrl(alias: String? = nil) -> Storefront.CustomerActivateByUrlPayload? {
			return field(field: "customerActivateByUrl", aliasSuffix: alias) as! Storefront.CustomerActivateByUrlPayload?
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

		/// Updates the default address of an existing customer. 
		open var customerDefaultAddressUpdate: Storefront.CustomerDefaultAddressUpdatePayload? {
			return internalGetCustomerDefaultAddressUpdate()
		}

		open func aliasedCustomerDefaultAddressUpdate(alias: String) -> Storefront.CustomerDefaultAddressUpdatePayload? {
			return internalGetCustomerDefaultAddressUpdate(alias: alias)
		}

		func internalGetCustomerDefaultAddressUpdate(alias: String? = nil) -> Storefront.CustomerDefaultAddressUpdatePayload? {
			return field(field: "customerDefaultAddressUpdate", aliasSuffix: alias) as! Storefront.CustomerDefaultAddressUpdatePayload?
		}

		/// Sends a reset password email to the customer. The reset password email 
		/// contains a reset password URL and token that you can pass to the 
		/// [`customerResetByUrl`](https://shopify.dev/api/storefront/latest/mutations/customerResetByUrl) 
		/// or 
		/// [`customerReset`](https://shopify.dev/api/storefront/latest/mutations/customerReset) 
		/// mutation to reset the customer password. This mutation is throttled by IP. 
		/// With private access, you can provide a 
		/// [`Shopify-Storefront-Buyer-IP`](https://shopify.dev/api/usage/authentication#optional-ip-header) 
		/// instead of the request IP. The header is case-sensitive and must be sent as 
		/// `Shopify-Storefront-Buyer-IP`. Make sure that the value provided to 
		/// `Shopify-Storefront-Buyer-IP` is trusted. Unthrottled access to this 
		/// mutation presents a security risk. 
		open var customerRecover: Storefront.CustomerRecoverPayload? {
			return internalGetCustomerRecover()
		}

		open func aliasedCustomerRecover(alias: String) -> Storefront.CustomerRecoverPayload? {
			return internalGetCustomerRecover(alias: alias)
		}

		func internalGetCustomerRecover(alias: String? = nil) -> Storefront.CustomerRecoverPayload? {
			return field(field: "customerRecover", aliasSuffix: alias) as! Storefront.CustomerRecoverPayload?
		}

		/// "Resets a customer’s password with the token received from a reset password 
		/// email. You can send a reset password email with the 
		/// [`customerRecover`](https://shopify.dev/api/storefront/latest/mutations/customerRecover) 
		/// mutation." 
		open var customerReset: Storefront.CustomerResetPayload? {
			return internalGetCustomerReset()
		}

		open func aliasedCustomerReset(alias: String) -> Storefront.CustomerResetPayload? {
			return internalGetCustomerReset(alias: alias)
		}

		func internalGetCustomerReset(alias: String? = nil) -> Storefront.CustomerResetPayload? {
			return field(field: "customerReset", aliasSuffix: alias) as! Storefront.CustomerResetPayload?
		}

		/// "Resets a customer’s password with the reset password URL received from a 
		/// reset password email. You can send a reset password email with the 
		/// [`customerRecover`](https://shopify.dev/api/storefront/latest/mutations/customerRecover) 
		/// mutation." 
		open var customerResetByUrl: Storefront.CustomerResetByUrlPayload? {
			return internalGetCustomerResetByUrl()
		}

		open func aliasedCustomerResetByUrl(alias: String) -> Storefront.CustomerResetByUrlPayload? {
			return internalGetCustomerResetByUrl(alias: alias)
		}

		func internalGetCustomerResetByUrl(alias: String? = nil) -> Storefront.CustomerResetByUrlPayload? {
			return field(field: "customerResetByUrl", aliasSuffix: alias) as! Storefront.CustomerResetByUrlPayload?
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

		/// Create a new Shop Pay payment request session. 
		open var shopPayPaymentRequestSessionCreate: Storefront.ShopPayPaymentRequestSessionCreatePayload? {
			return internalGetShopPayPaymentRequestSessionCreate()
		}

		open func aliasedShopPayPaymentRequestSessionCreate(alias: String) -> Storefront.ShopPayPaymentRequestSessionCreatePayload? {
			return internalGetShopPayPaymentRequestSessionCreate(alias: alias)
		}

		func internalGetShopPayPaymentRequestSessionCreate(alias: String? = nil) -> Storefront.ShopPayPaymentRequestSessionCreatePayload? {
			return field(field: "shopPayPaymentRequestSessionCreate", aliasSuffix: alias) as! Storefront.ShopPayPaymentRequestSessionCreatePayload?
		}

		/// Submits a Shop Pay payment request session. 
		open var shopPayPaymentRequestSessionSubmit: Storefront.ShopPayPaymentRequestSessionSubmitPayload? {
			return internalGetShopPayPaymentRequestSessionSubmit()
		}

		open func aliasedShopPayPaymentRequestSessionSubmit(alias: String) -> Storefront.ShopPayPaymentRequestSessionSubmitPayload? {
			return internalGetShopPayPaymentRequestSessionSubmit(alias: alias)
		}

		func internalGetShopPayPaymentRequestSessionSubmit(alias: String? = nil) -> Storefront.ShopPayPaymentRequestSessionSubmitPayload? {
			return field(field: "shopPayPaymentRequestSessionSubmit", aliasSuffix: alias) as! Storefront.ShopPayPaymentRequestSessionSubmitPayload?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "cartAttributesUpdate":
					if let value = internalGetCartAttributesUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartBillingAddressUpdate":
					if let value = internalGetCartBillingAddressUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartBuyerIdentityUpdate":
					if let value = internalGetCartBuyerIdentityUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartCreate":
					if let value = internalGetCartCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartDeliveryAddressesAdd":
					if let value = internalGetCartDeliveryAddressesAdd() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartDeliveryAddressesRemove":
					if let value = internalGetCartDeliveryAddressesRemove() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartDeliveryAddressesUpdate":
					if let value = internalGetCartDeliveryAddressesUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartDiscountCodesUpdate":
					if let value = internalGetCartDiscountCodesUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartGiftCardCodesRemove":
					if let value = internalGetCartGiftCardCodesRemove() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartGiftCardCodesUpdate":
					if let value = internalGetCartGiftCardCodesUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartLinesAdd":
					if let value = internalGetCartLinesAdd() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartLinesRemove":
					if let value = internalGetCartLinesRemove() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartLinesUpdate":
					if let value = internalGetCartLinesUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartMetafieldDelete":
					if let value = internalGetCartMetafieldDelete() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartMetafieldsSet":
					if let value = internalGetCartMetafieldsSet() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartNoteUpdate":
					if let value = internalGetCartNoteUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartPaymentUpdate":
					if let value = internalGetCartPaymentUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartPrepareForCompletion":
					if let value = internalGetCartPrepareForCompletion() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartSelectedDeliveryOptionsUpdate":
					if let value = internalGetCartSelectedDeliveryOptionsUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "cartSubmitForCompletion":
					if let value = internalGetCartSubmitForCompletion() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAccessTokenCreate":
					if let value = internalGetCustomerAccessTokenCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAccessTokenCreateWithMultipass":
					if let value = internalGetCustomerAccessTokenCreateWithMultipass() {
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

					case "customerActivateByUrl":
					if let value = internalGetCustomerActivateByUrl() {
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

					case "customerDefaultAddressUpdate":
					if let value = internalGetCustomerDefaultAddressUpdate() {
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

					case "customerResetByUrl":
					if let value = internalGetCustomerResetByUrl() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerUpdate":
					if let value = internalGetCustomerUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shopPayPaymentRequestSessionCreate":
					if let value = internalGetShopPayPaymentRequestSessionCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shopPayPaymentRequestSessionSubmit":
					if let value = internalGetShopPayPaymentRequestSessionSubmit() {
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
