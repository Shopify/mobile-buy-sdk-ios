//
//  CheckoutCreateInput.swift
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
	/// Specifies the fields required to create a checkout. 
	open class CheckoutCreateInput {
		/// The email with which the customer wants to checkout. 
		open var email: Input<String>

		/// A list of line item objects, each one containing information about an item 
		/// in the checkout. 
		open var lineItems: Input<[CheckoutLineItemInput]>

		/// The shipping address to where the line items will be shipped. 
		open var shippingAddress: Input<MailingAddressInput>

		/// The text of an optional note that a shop owner can attach to the checkout. 
		open var note: Input<String>

		/// A list of extra information that is added to the checkout. 
		open var customAttributes: Input<[AttributeInput]>

		/// Allows setting partial addresses on a Checkout, skipping the full 
		/// validation of attributes. The required attributes are city, province, and 
		/// country. Full validation of addresses is still done at complete time. 
		open var allowPartialAddresses: Input<Bool>

		/// The three-letter currency code of one of the shop's enabled presentment 
		/// currencies. Including this field creates a checkout in the specified 
		/// currency. By default, new checkouts are created in the shop's primary 
		/// currency. 
		open var presentmentCurrencyCode: Input<CurrencyCode>

		/// The identity of the customer associated with the checkout. 
		open var buyerIdentity: Input<CheckoutBuyerIdentityInput>

		/// Creates the input object.
		///
		/// - parameters:
		///     - email: The email with which the customer wants to checkout.
		///     - lineItems: A list of line item objects, each one containing information about an item in the checkout.
		///     - shippingAddress: The shipping address to where the line items will be shipped.
		///     - note: The text of an optional note that a shop owner can attach to the checkout.
		///     - customAttributes: A list of extra information that is added to the checkout.
		///     - allowPartialAddresses: Allows setting partial addresses on a Checkout, skipping the full validation of attributes. The required attributes are city, province, and country. Full validation of addresses is still done at complete time. 
		///     - presentmentCurrencyCode: The three-letter currency code of one of the shop's enabled presentment currencies. Including this field creates a checkout in the specified currency. By default, new checkouts are created in the shop's primary currency. 
		///     - buyerIdentity: The identity of the customer associated with the checkout.
		///
		public static func create(email: Input<String> = .undefined, lineItems: Input<[CheckoutLineItemInput]> = .undefined, shippingAddress: Input<MailingAddressInput> = .undefined, note: Input<String> = .undefined, customAttributes: Input<[AttributeInput]> = .undefined, allowPartialAddresses: Input<Bool> = .undefined, presentmentCurrencyCode: Input<CurrencyCode> = .undefined, buyerIdentity: Input<CheckoutBuyerIdentityInput> = .undefined) -> CheckoutCreateInput {
			return CheckoutCreateInput(email: email, lineItems: lineItems, shippingAddress: shippingAddress, note: note, customAttributes: customAttributes, allowPartialAddresses: allowPartialAddresses, presentmentCurrencyCode: presentmentCurrencyCode, buyerIdentity: buyerIdentity)
		}

		private init(email: Input<String> = .undefined, lineItems: Input<[CheckoutLineItemInput]> = .undefined, shippingAddress: Input<MailingAddressInput> = .undefined, note: Input<String> = .undefined, customAttributes: Input<[AttributeInput]> = .undefined, allowPartialAddresses: Input<Bool> = .undefined, presentmentCurrencyCode: Input<CurrencyCode> = .undefined, buyerIdentity: Input<CheckoutBuyerIdentityInput> = .undefined) {
			self.email = email
			self.lineItems = lineItems
			self.shippingAddress = shippingAddress
			self.note = note
			self.customAttributes = customAttributes
			self.allowPartialAddresses = allowPartialAddresses
			self.presentmentCurrencyCode = presentmentCurrencyCode
			self.buyerIdentity = buyerIdentity
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - email: The email with which the customer wants to checkout.
		///     - lineItems: A list of line item objects, each one containing information about an item in the checkout.
		///     - shippingAddress: The shipping address to where the line items will be shipped.
		///     - note: The text of an optional note that a shop owner can attach to the checkout.
		///     - customAttributes: A list of extra information that is added to the checkout.
		///     - allowPartialAddresses: Allows setting partial addresses on a Checkout, skipping the full validation of attributes. The required attributes are city, province, and country. Full validation of addresses is still done at complete time. 
		///     - presentmentCurrencyCode: The three-letter currency code of one of the shop's enabled presentment currencies. Including this field creates a checkout in the specified currency. By default, new checkouts are created in the shop's primary currency. 
		///     - buyerIdentity: The identity of the customer associated with the checkout.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(email: String? = nil, lineItems: [CheckoutLineItemInput]? = nil, shippingAddress: MailingAddressInput? = nil, note: String? = nil, customAttributes: [AttributeInput]? = nil, allowPartialAddresses: Bool? = nil, presentmentCurrencyCode: CurrencyCode? = nil, buyerIdentity: CheckoutBuyerIdentityInput? = nil) {
			self.init(email: email.orUndefined, lineItems: lineItems.orUndefined, shippingAddress: shippingAddress.orUndefined, note: note.orUndefined, customAttributes: customAttributes.orUndefined, allowPartialAddresses: allowPartialAddresses.orUndefined, presentmentCurrencyCode: presentmentCurrencyCode.orUndefined, buyerIdentity: buyerIdentity.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch email {
				case .value(let email): 
				guard let email = email else {
					fields.append("email:null")
					break
				}
				fields.append("email:\(GraphQL.quoteString(input: email))")
				case .undefined: break
			}

			switch lineItems {
				case .value(let lineItems): 
				guard let lineItems = lineItems else {
					fields.append("lineItems:null")
					break
				}
				fields.append("lineItems:[\(lineItems.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch shippingAddress {
				case .value(let shippingAddress): 
				guard let shippingAddress = shippingAddress else {
					fields.append("shippingAddress:null")
					break
				}
				fields.append("shippingAddress:\(shippingAddress.serialize())")
				case .undefined: break
			}

			switch note {
				case .value(let note): 
				guard let note = note else {
					fields.append("note:null")
					break
				}
				fields.append("note:\(GraphQL.quoteString(input: note))")
				case .undefined: break
			}

			switch customAttributes {
				case .value(let customAttributes): 
				guard let customAttributes = customAttributes else {
					fields.append("customAttributes:null")
					break
				}
				fields.append("customAttributes:[\(customAttributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch allowPartialAddresses {
				case .value(let allowPartialAddresses): 
				guard let allowPartialAddresses = allowPartialAddresses else {
					fields.append("allowPartialAddresses:null")
					break
				}
				fields.append("allowPartialAddresses:\(allowPartialAddresses)")
				case .undefined: break
			}

			switch presentmentCurrencyCode {
				case .value(let presentmentCurrencyCode): 
				guard let presentmentCurrencyCode = presentmentCurrencyCode else {
					fields.append("presentmentCurrencyCode:null")
					break
				}
				fields.append("presentmentCurrencyCode:\(presentmentCurrencyCode.rawValue)")
				case .undefined: break
			}

			switch buyerIdentity {
				case .value(let buyerIdentity): 
				guard let buyerIdentity = buyerIdentity else {
					fields.append("buyerIdentity:null")
					break
				}
				fields.append("buyerIdentity:\(buyerIdentity.serialize())")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
