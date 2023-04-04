//
//  MetafieldsSetUserErrorCode.swift
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
	/// Possible error codes that can be returned by `MetafieldsSetUserError`. 
	public enum MetafieldsSetUserErrorCode: String {
		/// The input value is blank. 
		case blank = "BLANK"

		/// The input value isn't included in the list. 
		case inclusion = "INCLUSION"

		/// The owner ID is invalid. 
		case invalidOwner = "INVALID_OWNER"

		/// The type is invalid. 
		case invalidType = "INVALID_TYPE"

		/// The value is invalid for metafield type or for definition options. 
		case invalidValue = "INVALID_VALUE"

		/// The input value should be less than or equal to the maximum value allowed. 
		case lessThanOrEqualTo = "LESS_THAN_OR_EQUAL_TO"

		/// The input value needs to be blank. 
		case present = "PRESENT"

		/// The input value is too long. 
		case tooLong = "TOO_LONG"

		/// The input value is too short. 
		case tooShort = "TOO_SHORT"

		case unknownValue = ""
	}
}
