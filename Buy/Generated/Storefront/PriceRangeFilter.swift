//
//  PriceRangeFilter.swift
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
	/// The input fields for a filter used to view a subset of products in a 
	/// collection matching a specific price range. 
	open class PriceRangeFilter {
		/// The minimum price in the range. Defaults to zero. 
		open var min: Input<Double>

		/// The maximum price in the range. Empty indicates no max price. 
		open var max: Input<Double>

		/// Creates the input object.
		///
		/// - parameters:
		///     - min: The minimum price in the range. Defaults to zero.
		///     - max: The maximum price in the range. Empty indicates no max price.
		///
		public static func create(min: Input<Double> = .undefined, max: Input<Double> = .undefined) -> PriceRangeFilter {
			return PriceRangeFilter(min: min, max: max)
		}

		private init(min: Input<Double> = .undefined, max: Input<Double> = .undefined) {
			self.min = min
			self.max = max
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - min: The minimum price in the range. Defaults to zero.
		///     - max: The maximum price in the range. Empty indicates no max price.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(min: Double? = nil, max: Double? = nil) {
			self.init(min: min.orUndefined, max: max.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch min {
				case .value(let min): 
				guard let min = min else {
					fields.append("min:null")
					break
				}
				fields.append("min:\(min)")
				case .undefined: break
			}

			switch max {
				case .value(let max): 
				guard let max = max else {
					fields.append("max:null")
					break
				}
				fields.append("max:\(max)")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
