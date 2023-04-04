//
//  CartPaymentInput.swift
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
	/// The input fields for updating the payment method that will be used to 
	/// checkout. 
	open class CartPaymentInput {
		/// The amount that the customer will be charged at checkout. 
		open var amount: MoneyInput

		/// An ID of the order placed on the originating platform. Note that this value 
		/// doesn't correspond to the Shopify Order ID. 
		open var sourceIdentifier: Input<String>

		/// The input fields to use to checkout a cart without providing a payment 
		/// method. Use this payment method input if the total cost of the cart is 0. 
		open var freePaymentMethod: Input<CartFreePaymentMethodInput>

		/// The input fields to use when checking out a cart with a direct payment 
		/// method (like a credit card). 
		open var directPaymentMethod: Input<CartDirectPaymentMethodInput>

		/// The input fields to use when checking out a cart with a wallet payment 
		/// method (like Shop Pay or Apple Pay). 
		open var walletPaymentMethod: Input<CartWalletPaymentMethodInput>

		/// Creates the input object.
		///
		/// - parameters:
		///     - amount: The amount that the customer will be charged at checkout.
		///     - sourceIdentifier: An ID of the order placed on the originating platform. Note that this value doesn't correspond to the Shopify Order ID. 
		///     - freePaymentMethod: The input fields to use to checkout a cart without providing a payment method. Use this payment method input if the total cost of the cart is 0. 
		///     - directPaymentMethod: The input fields to use when checking out a cart with a direct payment method (like a credit card). 
		///     - walletPaymentMethod: The input fields to use when checking out a cart with a wallet payment method (like Shop Pay or Apple Pay). 
		///
		public static func create(amount: MoneyInput, sourceIdentifier: Input<String> = .undefined, freePaymentMethod: Input<CartFreePaymentMethodInput> = .undefined, directPaymentMethod: Input<CartDirectPaymentMethodInput> = .undefined, walletPaymentMethod: Input<CartWalletPaymentMethodInput> = .undefined) -> CartPaymentInput {
			return CartPaymentInput(amount: amount, sourceIdentifier: sourceIdentifier, freePaymentMethod: freePaymentMethod, directPaymentMethod: directPaymentMethod, walletPaymentMethod: walletPaymentMethod)
		}

		private init(amount: MoneyInput, sourceIdentifier: Input<String> = .undefined, freePaymentMethod: Input<CartFreePaymentMethodInput> = .undefined, directPaymentMethod: Input<CartDirectPaymentMethodInput> = .undefined, walletPaymentMethod: Input<CartWalletPaymentMethodInput> = .undefined) {
			self.amount = amount
			self.sourceIdentifier = sourceIdentifier
			self.freePaymentMethod = freePaymentMethod
			self.directPaymentMethod = directPaymentMethod
			self.walletPaymentMethod = walletPaymentMethod
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - amount: The amount that the customer will be charged at checkout.
		///     - sourceIdentifier: An ID of the order placed on the originating platform. Note that this value doesn't correspond to the Shopify Order ID. 
		///     - freePaymentMethod: The input fields to use to checkout a cart without providing a payment method. Use this payment method input if the total cost of the cart is 0. 
		///     - directPaymentMethod: The input fields to use when checking out a cart with a direct payment method (like a credit card). 
		///     - walletPaymentMethod: The input fields to use when checking out a cart with a wallet payment method (like Shop Pay or Apple Pay). 
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(amount: MoneyInput, sourceIdentifier: String? = nil, freePaymentMethod: CartFreePaymentMethodInput? = nil, directPaymentMethod: CartDirectPaymentMethodInput? = nil, walletPaymentMethod: CartWalletPaymentMethodInput? = nil) {
			self.init(amount: amount, sourceIdentifier: sourceIdentifier.orUndefined, freePaymentMethod: freePaymentMethod.orUndefined, directPaymentMethod: directPaymentMethod.orUndefined, walletPaymentMethod: walletPaymentMethod.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("amount:\(amount.serialize())")

			switch sourceIdentifier {
				case .value(let sourceIdentifier): 
				guard let sourceIdentifier = sourceIdentifier else {
					fields.append("sourceIdentifier:null")
					break
				}
				fields.append("sourceIdentifier:\(GraphQL.quoteString(input: sourceIdentifier))")
				case .undefined: break
			}

			switch freePaymentMethod {
				case .value(let freePaymentMethod): 
				guard let freePaymentMethod = freePaymentMethod else {
					fields.append("freePaymentMethod:null")
					break
				}
				fields.append("freePaymentMethod:\(freePaymentMethod.serialize())")
				case .undefined: break
			}

			switch directPaymentMethod {
				case .value(let directPaymentMethod): 
				guard let directPaymentMethod = directPaymentMethod else {
					fields.append("directPaymentMethod:null")
					break
				}
				fields.append("directPaymentMethod:\(directPaymentMethod.serialize())")
				case .undefined: break
			}

			switch walletPaymentMethod {
				case .value(let walletPaymentMethod): 
				guard let walletPaymentMethod = walletPaymentMethod else {
					fields.append("walletPaymentMethod:null")
					break
				}
				fields.append("walletPaymentMethod:\(walletPaymentMethod.serialize())")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
