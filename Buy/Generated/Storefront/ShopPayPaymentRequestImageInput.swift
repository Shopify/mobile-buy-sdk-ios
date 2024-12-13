//
//  ShopPayPaymentRequestImageInput.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2024 Shopify Inc. All rights reserved.
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
	/// The input fields to create an image for a Shop Pay payment request. 
	open class ShopPayPaymentRequestImageInput {
		/// The source URL of the image. 
		open var url: String

		/// The alt text of the image. 
		open var alt: Input<String>

		/// Creates the input object.
		///
		/// - parameters:
		///     - url: The source URL of the image.
		///     - alt: The alt text of the image.
		///
		public static func create(url: String, alt: Input<String> = .undefined) -> ShopPayPaymentRequestImageInput {
			return ShopPayPaymentRequestImageInput(url: url, alt: alt)
		}

		private init(url: String, alt: Input<String> = .undefined) {
			self.url = url
			self.alt = alt
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - url: The source URL of the image.
		///     - alt: The alt text of the image.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(url: String, alt: String? = nil) {
			self.init(url: url, alt: alt.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("url:\(GraphQL.quoteString(input: url))")

			switch alt {
				case .value(let alt):
				guard let alt = alt else {
					fields.append("alt:null")
					break
				}
				fields.append("alt:\(GraphQL.quoteString(input: alt))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
