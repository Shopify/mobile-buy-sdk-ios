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
		open var email: InputValue<String>

		/// A list of line item objects, each one containing information about an item 
		/// in the checkout. 
		open var lineItems: InputValue<[CheckoutLineItemInput]>

		/// The shipping address to where the line items will be shipped. 
		open var shippingAddress: InputValue<MailingAddressInput>

		/// The text of an optional note that a shop owner can attach to the checkout. 
		open var note: InputValue<String>

		/// A list of extra information that is added to the checkout. 
		open var customAttributes: InputValue<[AttributeInput]>

		/// Allows setting partial addresses on a Checkout, skipping the full 
		/// validation of attributes. The required attributes are city, province, and 
		/// country. Full validation of addresses is still done at complete time. 
		open var allowPartialAddresses: InputValue<Bool>

		/// Creates the input object.
		///
		/// - parameters:
		///     - email: The email with which the customer wants to checkout.
		///     - lineItems: A list of line item objects, each one containing information about an item in the checkout.
		///     - shippingAddress: The shipping address to where the line items will be shipped.
		///     - note: The text of an optional note that a shop owner can attach to the checkout.
		///     - customAttributes: A list of extra information that is added to the checkout.
		///     - allowPartialAddresses: Allows setting partial addresses on a Checkout, skipping the full validation of attributes. The required attributes are city, province, and country. Full validation of addresses is still done at complete time. 
		///
		public init(email: InputValue<String> = .undefined, lineItems: InputValue<[CheckoutLineItemInput]> = .undefined, shippingAddress: InputValue<MailingAddressInput> = .undefined, note: InputValue<String> = .undefined, customAttributes: InputValue<[AttributeInput]> = .undefined, allowPartialAddresses: InputValue<Bool> = .undefined) {
			self.email = email
			self.lineItems = lineItems
			self.shippingAddress = shippingAddress
			self.note = note
			self.customAttributes = customAttributes
			self.allowPartialAddresses = allowPartialAddresses
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch email {
				case .some(let email): fields.append("email:\(GraphQL.quoteString(input: email))")
				case .null: fields.append("email:null")
				case .undefined: break
			}

			switch lineItems {
				case .some(let lineItems): fields.append("lineItems:[\(lineItems.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .null: fields.append("lineItems:null")
				case .undefined: break
			}

			switch shippingAddress {
				case .some(let shippingAddress): fields.append("shippingAddress:\(shippingAddress.serialize())")
				case .null: fields.append("shippingAddress:null")
				case .undefined: break
			}

			switch note {
				case .some(let note): fields.append("note:\(GraphQL.quoteString(input: note))")
				case .null: fields.append("note:null")
				case .undefined: break
			}

			switch customAttributes {
				case .some(let customAttributes): fields.append("customAttributes:[\(customAttributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .null: fields.append("customAttributes:null")
				case .undefined: break
			}

			switch allowPartialAddresses {
				case .some(let allowPartialAddresses): fields.append("allowPartialAddresses:\(allowPartialAddresses)")
				case .null: fields.append("allowPartialAddresses:null")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
