//
//  CustomerErrorCode.swift
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
	/// Possible error codes that could be returned by a customer mutation. 
	public enum CustomerErrorCode: String {
		/// Customer already enabled. 
		case alreadyEnabled = "ALREADY_ENABLED"

		/// Input value is blank. 
		case blank = "BLANK"

		/// Input contains HTML tags. 
		case containsHtmlTags = "CONTAINS_HTML_TAGS"

		/// Input contains URL. 
		case containsUrl = "CONTAINS_URL"

		/// Customer is disabled. 
		case customerDisabled = "CUSTOMER_DISABLED"

		/// Input value is invalid. 
		case invalid = "INVALID"

		/// Address does not exist. 
		case notFound = "NOT_FOUND"

		/// Input password starts or ends with whitespace. 
		case passwordStartsOrEndsWithWhitespace = "PASSWORD_STARTS_OR_ENDS_WITH_WHITESPACE"

		/// Input value is already taken. 
		case taken = "TAKEN"

		/// Invalid activation token. 
		case tokenInvalid = "TOKEN_INVALID"

		/// Input value is too long. 
		case tooLong = "TOO_LONG"

		/// Input value is too short. 
		case tooShort = "TOO_SHORT"

		/// Unidentified customer. 
		case unidentifiedCustomer = "UNIDENTIFIED_CUSTOMER"

		case unknownValue = ""
	}
}
