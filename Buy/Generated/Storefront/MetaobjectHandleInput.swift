//
//  MetaobjectHandleInput.swift
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
	/// The input fields used to retrieve a metaobject by handle. 
	open class MetaobjectHandleInput {
		/// The handle of the metaobject. 
		open var handle: String

		/// The type of the metaobject. 
		open var type: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - handle: The handle of the metaobject.
		///     - type: The type of the metaobject.
		///
		public static func create(handle: String, type: String) -> MetaobjectHandleInput {
			return MetaobjectHandleInput(handle: handle, type: type)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - handle: The handle of the metaobject.
		///     - type: The type of the metaobject.
		///
		public init(handle: String, type: String) {
			self.handle = handle
			self.type = type
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("handle:\(GraphQL.quoteString(input: handle))")

			fields.append("type:\(GraphQL.quoteString(input: type))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
