//
//  UnitPriceMeasurementMeasuredUnit.swift
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
	/// The valid units of measurement for a unit price measurement. 
	public enum UnitPriceMeasurementMeasuredUnit: String {
		/// 100 centiliters equals 1 liter. 
		case cl = "CL"

		/// 100 centimeters equals 1 meter. 
		case cm = "CM"

		/// Imperial system unit of volume (U.S. customary unit). 
		case floz = "FLOZ"

		/// 1 foot equals 12 inches. 
		case ft = "FT"

		/// Imperial system unit of area. 
		case ft2 = "FT2"

		/// Metric system unit of weight. 
		case g = "G"

		/// 1 gallon equals 128 fluid ounces (U.S. customary unit). 
		case gal = "GAL"

		/// Imperial system unit of length. 
		case `in` = "IN"

		/// 1 item, a unit of count. 
		case item = "ITEM"

		/// 1 kilogram equals 1000 grams. 
		case kg = "KG"

		/// Metric system unit of volume. 
		case l = "L"

		/// Imperial system unit of weight. 
		case lb = "LB"

		/// Metric system unit of length. 
		case m = "M"

		/// Metric system unit of area. 
		case m2 = "M2"

		/// 1 cubic meter equals 1000 liters. 
		case m3 = "M3"

		/// 1000 milligrams equals 1 gram. 
		case mg = "MG"

		/// 1000 milliliters equals 1 liter. 
		case ml = "ML"

		/// 1000 millimeters equals 1 meter. 
		case mm = "MM"

		/// 16 ounces equals 1 pound. 
		case oz = "OZ"

		/// 1 pint equals 16 fluid ounces (U.S. customary unit). 
		case pt = "PT"

		/// 1 quart equals 32 fluid ounces (U.S. customary unit). 
		case qt = "QT"

		/// The unit of measurement is unknown. Upgrade to the latest version of the 
		/// API to resolve this unit. 
		case unknown = "UNKNOWN"

		/// 1 yard equals 36 inches. 
		case yd = "YD"

		case unknownValue = ""
	}
}
