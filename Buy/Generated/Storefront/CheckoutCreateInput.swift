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
		open var email: String?

		/// A list of line item objects, each one containing information about an item 
		/// in the checkout. 
		open var lineItems: [CheckoutLineItemInput]?

		/// The shipping address to where the line items will be shipped. 
		open var shippingAddress: MailingAddressInput?

		/// The text of an optional note that a shop owner can attach to the checkout. 
		open var note: String?

		/// A list of extra information that is added to the checkout. 
		open var customAttributes: [AttributeInput]?

		/// Allows setting partial addresses on a Checkout, skipping the full 
		/// validation of attributes. The required attributes are city, province, and 
		/// country. Full validation of addresses is still done at complete time. 
		open var allowPartialAddresses: Bool?

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
		public init(email: String? = nil, lineItems: [CheckoutLineItemInput]? = nil, shippingAddress: MailingAddressInput? = nil, note: String? = nil, customAttributes: [AttributeInput]? = nil, allowPartialAddresses: Bool? = nil) {
			self.email = email
			self.lineItems = lineItems
			self.shippingAddress = shippingAddress
			self.note = note
			self.customAttributes = customAttributes
			self.allowPartialAddresses = allowPartialAddresses
		}

		internal func serialize() -> String {
			var fields: [String] = []

			if let email = email {
				fields.append("email:\(GraphQL.quoteString(input: email))")
			}

			if let lineItems = lineItems {
				fields.append("lineItems:[\(lineItems.map{ "\($0.serialize())" }.joined(separator: ","))]")
			}

			if let shippingAddress = shippingAddress {
				fields.append("shippingAddress:\(shippingAddress.serialize())")
			}

			if let note = note {
				fields.append("note:\(GraphQL.quoteString(input: note))")
			}

			if let customAttributes = customAttributes {
				fields.append("customAttributes:[\(customAttributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
			}

			if let allowPartialAddresses = allowPartialAddresses {
				fields.append("allowPartialAddresses:\(allowPartialAddresses)")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
