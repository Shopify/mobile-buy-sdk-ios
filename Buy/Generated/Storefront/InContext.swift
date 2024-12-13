//
//  inContext.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2024 Shopify Inc. All rights reserved.
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
	open class InContextDirective: GraphQL.AbstractDirective {
		/// Contextualizes data based on the additional information provided by the 
		/// directive. For example, you can use the `@inContext(country: CA)` directive 
		/// to [query a product's 
		/// price](https://shopify.dev/custom-storefronts/internationalization/international-pricing) 
		/// in a storefront within the context of Canada. 
		///
		/// - parameters:
		///     - country: The country code for context. For example, `CA`.
		///     - language: The language code for context. For example, `EN`.
		///     - preferredLocationId: The identifier of the customer's preferred location.
		///     - buyer: The buyer's identity.
		///
		public init(country: CountryCode? = nil, language: LanguageCode? = nil, preferredLocationId: GraphQL.ID? = nil, buyer: BuyerInput? = nil) {
			var args: [String] = []

			if let country = country {
				args.append("country:\(country.rawValue)")
			}

			if let language = language {
				args.append("language:\(language.rawValue)")
			}

			if let preferredLocationId = preferredLocationId {
				args.append("preferredLocationId:\(GraphQL.quoteString(input: "\(preferredLocationId.rawValue)"))")
			}

			if let buyer = buyer {
				args.append("buyer:\(buyer.serialize())")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			super.init(name: "inContext", args: argsString)
		}
	}
}
