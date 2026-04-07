//
//  DiscountApplicationAllocationMethod.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2026 Shopify Inc. All rights reserved.
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
	/// Controls how a discount's value is distributed across entitled lines. A
	/// discount can either spread its value across all entitled lines or apply the
	/// full value to each line individually. Used by the
	/// [`DiscountApplication`](https://shopify.dev/docs/api/storefront/current/interfaces/DiscountApplication)
	/// interface and its implementations to capture the intentions of a discount
	/// source at the time of application.
	public enum DiscountApplicationAllocationMethod: String {
		/// The value is spread across all entitled lines.
		case across = "ACROSS"

		/// The value is applied onto every entitled line.
		case each = "EACH"

		/// The value is specifically applied onto a particular line.
		@available(*, deprecated, message: "Use ACROSS instead.")
		case one = "ONE"

		case unknownValue = ""
	}
}
