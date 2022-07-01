//
//  DiscountApplicationTargetSelection.swift
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
	/// The lines on the order to which the discount is applied, of the type 
	/// defined by the discount application's `targetType`. For example, the value 
	/// `ENTITLED`, combined with a `targetType` of `LINE_ITEM`, applies the 
	/// discount on all line items that are entitled to the discount. The value 
	/// `ALL`, combined with a `targetType` of `SHIPPING_LINE`, applies the 
	/// discount on all shipping lines. 
	public enum DiscountApplicationTargetSelection: String {
		/// The discount is allocated onto all the lines. 
		case all = "ALL"

		/// The discount is allocated onto only the lines that it's entitled for. 
		case entitled = "ENTITLED"

		/// The discount is allocated onto explicitly chosen lines. 
		case explicit = "EXPLICIT"

		case unknownValue = ""
	}
}
