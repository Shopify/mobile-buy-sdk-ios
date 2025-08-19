//
//  StripeSharedTokenPaymentMethodInput.swift
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
	/// The input fields to use when checking out a cart with a Stripe shared 
	/// token. 
	open class StripeSharedTokenPaymentMethodInput {
		/// The customer's billing address. 
		open var billingAddress: Input<MailingAddressInput>

		/// The ID of the Stripe shared token to use for the checkout. 
		open var stripeSharedTokenId: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - billingAddress: The customer's billing address.
		///     - stripeSharedTokenId: The ID of the Stripe shared token to use for the checkout.
		///
		public static func create(stripeSharedTokenId: String, billingAddress: Input<MailingAddressInput> = .undefined) -> StripeSharedTokenPaymentMethodInput {
			return StripeSharedTokenPaymentMethodInput(stripeSharedTokenId: stripeSharedTokenId, billingAddress: billingAddress)
		}

		private init(stripeSharedTokenId: String, billingAddress: Input<MailingAddressInput> = .undefined) {
			self.billingAddress = billingAddress
			self.stripeSharedTokenId = stripeSharedTokenId
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - billingAddress: The customer's billing address.
		///     - stripeSharedTokenId: The ID of the Stripe shared token to use for the checkout.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(stripeSharedTokenId: String, billingAddress: MailingAddressInput? = nil) {
			self.init(stripeSharedTokenId: stripeSharedTokenId, billingAddress: billingAddress.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch billingAddress {
				case .value(let billingAddress):
				guard let billingAddress = billingAddress else {
					fields.append("billingAddress:null")
					break
				}
				fields.append("billingAddress:\(billingAddress.serialize())")
				case .undefined: break
			}

			fields.append("stripeSharedTokenId:\(GraphQL.quoteString(input: stripeSharedTokenId))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
