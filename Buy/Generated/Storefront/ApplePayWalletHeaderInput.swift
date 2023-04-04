//
//  ApplePayWalletHeaderInput.swift
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
	/// The input fields for submitting wallet payment method information for 
	/// checkout. 
	open class ApplePayWalletHeaderInput {
		/// The application data for the Apple Pay wallet. 
		open var applicationData: Input<String>

		/// The ephemeral public key for the Apple Pay wallet. 
		open var ephemeralPublicKey: String

		/// The public key hash for the Apple Pay wallet. 
		open var publicKeyHash: String

		/// The transaction ID for the Apple Pay wallet. 
		open var transactionId: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - applicationData: The application data for the Apple Pay wallet.
		///     - ephemeralPublicKey: The ephemeral public key for the Apple Pay wallet.
		///     - publicKeyHash: The public key hash for the Apple Pay wallet.
		///     - transactionId: The transaction ID for the Apple Pay wallet.
		///
		public static func create(ephemeralPublicKey: String, publicKeyHash: String, transactionId: String, applicationData: Input<String> = .undefined) -> ApplePayWalletHeaderInput {
			return ApplePayWalletHeaderInput(ephemeralPublicKey: ephemeralPublicKey, publicKeyHash: publicKeyHash, transactionId: transactionId, applicationData: applicationData)
		}

		private init(ephemeralPublicKey: String, publicKeyHash: String, transactionId: String, applicationData: Input<String> = .undefined) {
			self.applicationData = applicationData
			self.ephemeralPublicKey = ephemeralPublicKey
			self.publicKeyHash = publicKeyHash
			self.transactionId = transactionId
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - applicationData: The application data for the Apple Pay wallet.
		///     - ephemeralPublicKey: The ephemeral public key for the Apple Pay wallet.
		///     - publicKeyHash: The public key hash for the Apple Pay wallet.
		///     - transactionId: The transaction ID for the Apple Pay wallet.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(ephemeralPublicKey: String, publicKeyHash: String, transactionId: String, applicationData: String? = nil) {
			self.init(ephemeralPublicKey: ephemeralPublicKey, publicKeyHash: publicKeyHash, transactionId: transactionId, applicationData: applicationData.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch applicationData {
				case .value(let applicationData): 
				guard let applicationData = applicationData else {
					fields.append("applicationData:null")
					break
				}
				fields.append("applicationData:\(GraphQL.quoteString(input: applicationData))")
				case .undefined: break
			}

			fields.append("ephemeralPublicKey:\(GraphQL.quoteString(input: ephemeralPublicKey))")

			fields.append("publicKeyHash:\(GraphQL.quoteString(input: publicKeyHash))")

			fields.append("transactionId:\(GraphQL.quoteString(input: transactionId))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
