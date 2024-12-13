//
//  OrderCancelReason.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) #{Time.now.year} Shopify Inc. All rights reserved.
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
	/// Represents the reason for the order's cancellation. 
	public enum OrderCancelReason: String {
		/// The customer wanted to cancel the order. 
		case customer = "CUSTOMER"

		/// Payment was declined. 
		case declined = "DECLINED"

		/// The order was fraudulent. 
		case fraud = "FRAUD"

		/// There was insufficient inventory. 
		case inventory = "INVENTORY"

		/// The order was canceled for an unlisted reason. 
		case other = "OTHER"

		/// Staff made an error. 
		case staff = "STAFF"

		case unknownValue = ""
	}
}
