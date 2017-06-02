//
//  SelectedOptionInput.swift
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
	/// Specifies the input fields required for a selected option. 
	open class SelectedOptionInput {
		/// The product option’s name. 
		open var name: String

		/// The product option’s value. 
		open var value: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - name: The product option’s name.
		///     - value: The product option’s value.
		///
		public init(name: String, value: String) {
			self.name = name
			self.value = value
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("name:\(GraphQL.quoteString(input: name))")

			fields.append("value:\(GraphQL.quoteString(input: value))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
