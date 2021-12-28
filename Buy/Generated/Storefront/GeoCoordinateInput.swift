//
//  GeoCoordinateInput.swift
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
	/// Used to specify a geographical location. 
	open class GeoCoordinateInput {
		/// The coordinate's latitude value. 
		open var latitude: Double

		/// The coordinate's longitude value. 
		open var longitude: Double

		/// Creates the input object.
		///
		/// - parameters:
		///     - latitude: The coordinate's latitude value.
		///     - longitude: The coordinate's longitude value.
		///
		public static func create(latitude: Double, longitude: Double) -> GeoCoordinateInput {
			return GeoCoordinateInput(latitude: latitude, longitude: longitude)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - latitude: The coordinate's latitude value.
		///     - longitude: The coordinate's longitude value.
		///
		public init(latitude: Double, longitude: Double) {
			self.latitude = latitude
			self.longitude = longitude
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("latitude:\(latitude)")

			fields.append("longitude:\(longitude)")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
