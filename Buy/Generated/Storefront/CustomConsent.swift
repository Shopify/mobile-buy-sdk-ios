//
//  CustomConsent.swift
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
	/// A key/value pair representing custom consent to be stored in the Consent 
	/// Management Platform. 
	open class CustomConsent {
		/// Key for the data, used to fetch it back. 
		open var key: String

		/// Value of the data. Use `null` to erase that key from storage. 
		open var value: Input<String>

		/// Creates the input object.
		///
		/// - parameters:
		///     - key: Key for the data, used to fetch it back.
		///     - value: Value of the data. Use `null` to erase that key from storage.
		///
		public static func create(key: String, value: Input<String> = .undefined) -> CustomConsent {
			return CustomConsent(key: key, value: value)
		}

		private init(key: String, value: Input<String> = .undefined) {
			self.key = key
			self.value = value
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - key: Key for the data, used to fetch it back.
		///     - value: Value of the data. Use `null` to erase that key from storage.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(key: String, value: String? = nil) {
			self.init(key: key, value: value.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("key:\(GraphQL.quoteString(input: key))")

			switch value {
				case .value(let value):
				guard let value = value else {
					fields.append("value:null")
					break
				}
				fields.append("value:\(GraphQL.quoteString(input: value))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
