//
//  BuyerInput.swift
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
	/// The input fields for obtaining the buyer's identity. 
	open class BuyerInput {
		/// The storefront customer access token retrieved from the [Customer Accounts 
		/// API](https://shopify.dev/docs/api/customer/reference/mutations/storefrontCustomerAccessTokenCreate). 
		open var customerAccessToken: String

		/// The identifier of the company location. 
		open var companyLocationId: Input<GraphQL.ID>

		/// Creates the input object.
		///
		/// - parameters:
		///     - customerAccessToken: The storefront customer access token retrieved from the [Customer Accounts API](https://shopify.dev/docs/api/customer/reference/mutations/storefrontCustomerAccessTokenCreate).
		///     - companyLocationId: The identifier of the company location.
		///
		public static func create(customerAccessToken: String, companyLocationId: Input<GraphQL.ID> = .undefined) -> BuyerInput {
			return BuyerInput(customerAccessToken: customerAccessToken, companyLocationId: companyLocationId)
		}

		private init(customerAccessToken: String, companyLocationId: Input<GraphQL.ID> = .undefined) {
			self.customerAccessToken = customerAccessToken
			self.companyLocationId = companyLocationId
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - customerAccessToken: The storefront customer access token retrieved from the [Customer Accounts API](https://shopify.dev/docs/api/customer/reference/mutations/storefrontCustomerAccessTokenCreate).
		///     - companyLocationId: The identifier of the company location.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(customerAccessToken: String, companyLocationId: GraphQL.ID? = nil) {
			self.init(customerAccessToken: customerAccessToken, companyLocationId: companyLocationId.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			switch companyLocationId {
				case .value(let companyLocationId): 
				guard let companyLocationId = companyLocationId else {
					fields.append("companyLocationId:null")
					break
				}
				fields.append("companyLocationId:\(GraphQL.quoteString(input: "\(companyLocationId.rawValue)"))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
