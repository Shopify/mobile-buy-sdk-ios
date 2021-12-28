//
//  TransactionKind.swift
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
	/// The different kinds of order transactions. 
	public enum TransactionKind: String {
		/// An amount reserved against the cardholder's funding source. Money does not 
		/// change hands until the authorization is captured. 
		case authorization = "AUTHORIZATION"

		/// A transfer of the money that was reserved during the authorization stage. 
		case capture = "CAPTURE"

		/// Money returned to the customer when they have paid too much. 
		case change = "CHANGE"

		/// An authorization for a payment taken with an EMV credit card reader. 
		case emvAuthorization = "EMV_AUTHORIZATION"

		/// An authorization and capture performed together in a single step. 
		case sale = "SALE"

		case unknownValue = ""
	}
}
