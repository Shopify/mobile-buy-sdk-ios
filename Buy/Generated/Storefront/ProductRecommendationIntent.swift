//
//  ProductRecommendationIntent.swift
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
	/// The recommendation intent that is used to generate product recommendations. 
	/// You can use intent to generate product recommendations according to 
	/// different strategies. 
	public enum ProductRecommendationIntent: String {
		/// Offer customers products that are complementary to a product for which 
		/// recommendations are to be fetched. An example is add-on products that 
		/// display in a Pair it with section. 
		case complementary = "COMPLEMENTARY"

		/// Offer customers a mix of products that are similar or complementary to a 
		/// product for which recommendations are to be fetched. An example is 
		/// substitutable products that display in a You may also like section. 
		case related = "RELATED"

		case unknownValue = ""
	}
}
