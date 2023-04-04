//
//  CartWalletPaymentMethodInput.swift
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
	/// The input fields for submitting wallet payment method information for 
	/// checkout. 
	open class CartWalletPaymentMethodInput {
		/// The payment method information for the Apple Pay wallet. 
		open var applePayWalletContent: Input<ApplePayWalletContentInput>

		/// The payment method information for the Shop Pay wallet. 
		open var shopPayWalletContent: Input<ShopPayWalletContentInput>

		/// Creates the input object.
		///
		/// - parameters:
		///     - applePayWalletContent: The payment method information for the Apple Pay wallet.
		///     - shopPayWalletContent: The payment method information for the Shop Pay wallet.
		///
		public static func create(applePayWalletContent: Input<ApplePayWalletContentInput> = .undefined, shopPayWalletContent: Input<ShopPayWalletContentInput> = .undefined) -> CartWalletPaymentMethodInput {
			return CartWalletPaymentMethodInput(applePayWalletContent: applePayWalletContent, shopPayWalletContent: shopPayWalletContent)
		}

		private init(applePayWalletContent: Input<ApplePayWalletContentInput> = .undefined, shopPayWalletContent: Input<ShopPayWalletContentInput> = .undefined) {
			self.applePayWalletContent = applePayWalletContent
			self.shopPayWalletContent = shopPayWalletContent
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - applePayWalletContent: The payment method information for the Apple Pay wallet.
		///     - shopPayWalletContent: The payment method information for the Shop Pay wallet.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(applePayWalletContent: ApplePayWalletContentInput? = nil, shopPayWalletContent: ShopPayWalletContentInput? = nil) {
			self.init(applePayWalletContent: applePayWalletContent.orUndefined, shopPayWalletContent: shopPayWalletContent.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch applePayWalletContent {
				case .value(let applePayWalletContent): 
				guard let applePayWalletContent = applePayWalletContent else {
					fields.append("applePayWalletContent:null")
					break
				}
				fields.append("applePayWalletContent:\(applePayWalletContent.serialize())")
				case .undefined: break
			}

			switch shopPayWalletContent {
				case .value(let shopPayWalletContent): 
				guard let shopPayWalletContent = shopPayWalletContent else {
					fields.append("shopPayWalletContent:null")
					break
				}
				fields.append("shopPayWalletContent:\(shopPayWalletContent.serialize())")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
