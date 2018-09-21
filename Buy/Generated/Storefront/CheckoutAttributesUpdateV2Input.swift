//
//  CheckoutAttributesUpdateV2Input.swift
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
	/// Specifies the fields required to update a checkout's attributes. 
	open class CheckoutAttributesUpdateV2Input {
		/// The text of an optional note that a shop owner can attach to the checkout. 
		open var note: Input<String>

		/// A list of extra information that is added to the checkout. 
		open var customAttributes: Input<[AttributeInput]>

		/// Allows setting partial addresses on a Checkout, skipping the full 
		/// validation of attributes. The required attributes are city, province, and 
		/// country. Full validation of the addresses is still done at complete time. 
		open var allowPartialAddresses: Input<Bool>

		/// Creates the input object.
		///
		/// - parameters:
		///     - note: The text of an optional note that a shop owner can attach to the checkout.
		///     - customAttributes: A list of extra information that is added to the checkout.
		///     - allowPartialAddresses: Allows setting partial addresses on a Checkout, skipping the full validation of attributes. The required attributes are city, province, and country. Full validation of the addresses is still done at complete time. 
		///
		public static func create(note: Input<String> = .undefined, customAttributes: Input<[AttributeInput]> = .undefined, allowPartialAddresses: Input<Bool> = .undefined) -> CheckoutAttributesUpdateV2Input {
			return CheckoutAttributesUpdateV2Input(note: note, customAttributes: customAttributes, allowPartialAddresses: allowPartialAddresses)
		}

		private init(note: Input<String> = .undefined, customAttributes: Input<[AttributeInput]> = .undefined, allowPartialAddresses: Input<Bool> = .undefined) {
			self.note = note
			self.customAttributes = customAttributes
			self.allowPartialAddresses = allowPartialAddresses
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - note: The text of an optional note that a shop owner can attach to the checkout.
		///     - customAttributes: A list of extra information that is added to the checkout.
		///     - allowPartialAddresses: Allows setting partial addresses on a Checkout, skipping the full validation of attributes. The required attributes are city, province, and country. Full validation of the addresses is still done at complete time. 
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(note: String? = nil, customAttributes: [AttributeInput]? = nil, allowPartialAddresses: Bool? = nil) {
			self.init(note: note.orUndefined, customAttributes: customAttributes.orUndefined, allowPartialAddresses: allowPartialAddresses.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

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

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
