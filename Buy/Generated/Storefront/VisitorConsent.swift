//
//  VisitorConsent.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2026 Shopify Inc. All rights reserved.
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
	/// The visitor's consent to data processing purposes for the shop. true means
	/// accepting the purposes, false means declining them, and null means that the
	/// visitor didn't express a preference.
	open class VisitorConsent {
		/// The visitor accepts or rejects the preferences data processing purpose.
		open var preferences: Input<Bool>

		/// The visitor accepts or rejects the analytics data processing purpose.
		open var analytics: Input<Bool>

		/// The visitor accepts or rejects the first and third party marketing data
		/// processing purposes.
		open var marketing: Input<Bool>

		/// The visitor accepts or rejects the sale or sharing of their data with third
		/// parties.
		open var saleOfData: Input<Bool>

		/// Creates the input object.
		///
		/// - parameters:
		///     - preferences: The visitor accepts or rejects the preferences data processing purpose.
		///     - analytics: The visitor accepts or rejects the analytics data processing purpose.
		///     - marketing: The visitor accepts or rejects the first and third party marketing data processing purposes.
		///     - saleOfData: The visitor accepts or rejects the sale or sharing of their data with third parties.
		///
		public static func create(preferences: Input<Bool> = .undefined, analytics: Input<Bool> = .undefined, marketing: Input<Bool> = .undefined, saleOfData: Input<Bool> = .undefined) -> VisitorConsent {
			return VisitorConsent(preferences: preferences, analytics: analytics, marketing: marketing, saleOfData: saleOfData)
		}

		private init(preferences: Input<Bool> = .undefined, analytics: Input<Bool> = .undefined, marketing: Input<Bool> = .undefined, saleOfData: Input<Bool> = .undefined) {
			self.preferences = preferences
			self.analytics = analytics
			self.marketing = marketing
			self.saleOfData = saleOfData
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - preferences: The visitor accepts or rejects the preferences data processing purpose.
		///     - analytics: The visitor accepts or rejects the analytics data processing purpose.
		///     - marketing: The visitor accepts or rejects the first and third party marketing data processing purposes.
		///     - saleOfData: The visitor accepts or rejects the sale or sharing of their data with third parties.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(preferences: Bool? = nil, analytics: Bool? = nil, marketing: Bool? = nil, saleOfData: Bool? = nil) {
			self.init(preferences: preferences.orUndefined, analytics: analytics.orUndefined, marketing: marketing.orUndefined, saleOfData: saleOfData.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch preferences {
				case .value(let preferences):
				guard let preferences = preferences else {
					fields.append("preferences:null")
					break
				}
				fields.append("preferences:\(preferences)")
				case .undefined: break
			}

			switch analytics {
				case .value(let analytics):
				guard let analytics = analytics else {
					fields.append("analytics:null")
					break
				}
				fields.append("analytics:\(analytics)")
				case .undefined: break
			}

			switch marketing {
				case .value(let marketing):
				guard let marketing = marketing else {
					fields.append("marketing:null")
					break
				}
				fields.append("marketing:\(marketing)")
				case .undefined: break
			}

			switch saleOfData {
				case .value(let saleOfData):
				guard let saleOfData = saleOfData else {
					fields.append("saleOfData:null")
					break
				}
				fields.append("saleOfData:\(saleOfData)")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
