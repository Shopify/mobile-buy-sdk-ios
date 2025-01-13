//
//  CartDeliveryCoordinatesPreferenceInput.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
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
	/// Preferred location used to find the closest pick up point based on 
	/// coordinates. 
	open class CartDeliveryCoordinatesPreferenceInput {
		/// The geographic latitude for a given location. Coordinates are required in 
		/// order to set pickUpHandle for pickup points. 
		open var latitude: Double

		/// The geographic longitude for a given location. Coordinates are required in 
		/// order to set pickUpHandle for pickup points. 
		open var longitude: Double

		/// The two-letter code for the country of the preferred location. For example, 
		/// US. 
		open var countryCode: CountryCode

		/// Creates the input object.
		///
		/// - parameters:
		///     - latitude: The geographic latitude for a given location. Coordinates are required in order to set pickUpHandle for pickup points.
		///     - longitude: The geographic longitude for a given location. Coordinates are required in order to set pickUpHandle for pickup points.
		///     - countryCode: The two-letter code for the country of the preferred location.  For example, US. 
		///
		public static func create(latitude: Double, longitude: Double, countryCode: CountryCode) -> CartDeliveryCoordinatesPreferenceInput {
			return CartDeliveryCoordinatesPreferenceInput(latitude: latitude, longitude: longitude, countryCode: countryCode)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - latitude: The geographic latitude for a given location. Coordinates are required in order to set pickUpHandle for pickup points.
		///     - longitude: The geographic longitude for a given location. Coordinates are required in order to set pickUpHandle for pickup points.
		///     - countryCode: The two-letter code for the country of the preferred location.  For example, US. 
		///
		public init(latitude: Double, longitude: Double, countryCode: CountryCode) {
			self.latitude = latitude
			self.longitude = longitude
			self.countryCode = countryCode
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("latitude:\(latitude)")

			fields.append("longitude:\(longitude)")

			fields.append("countryCode:\(countryCode.rawValue)")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
