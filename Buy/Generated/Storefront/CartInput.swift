//
//  CartInput.swift
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
	/// Specifies the input fields to create a cart. 
	open class CartInput {
		/// An array of key-value pairs that contains additional information about the 
		/// cart. 
		open var attributes: Input<[AttributeInput]>

		/// A list of merchandise lines to add to the cart. 
		open var lines: Input<[CartLineInput]>

		/// The discount codes to apply to the cart. 
		open var discountCodes: Input<[String]>

		/// A note that is associated with the cart. For example, the note can be a 
		/// personalized message to the buyer. 
		open var note: Input<String>

		/// The customer associated with the cart. 
		open var buyerIdentity: Input<CartBuyerIdentityInput>

		/// Creates the input object.
		///
		/// - parameters:
		///     - attributes: An array of key-value pairs that contains additional information about the cart.
		///     - lines: A list of merchandise lines to add to the cart.
		///     - discountCodes: The discount codes to apply to the cart.
		///     - note: A note that is associated with the cart. For example, the note can be a personalized message to the buyer.
		///     - buyerIdentity: The customer associated with the cart.
		///
		public static func create(attributes: Input<[AttributeInput]> = .undefined, lines: Input<[CartLineInput]> = .undefined, discountCodes: Input<[String]> = .undefined, note: Input<String> = .undefined, buyerIdentity: Input<CartBuyerIdentityInput> = .undefined) -> CartInput {
			return CartInput(attributes: attributes, lines: lines, discountCodes: discountCodes, note: note, buyerIdentity: buyerIdentity)
		}

		private init(attributes: Input<[AttributeInput]> = .undefined, lines: Input<[CartLineInput]> = .undefined, discountCodes: Input<[String]> = .undefined, note: Input<String> = .undefined, buyerIdentity: Input<CartBuyerIdentityInput> = .undefined) {
			self.attributes = attributes
			self.lines = lines
			self.discountCodes = discountCodes
			self.note = note
			self.buyerIdentity = buyerIdentity
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - attributes: An array of key-value pairs that contains additional information about the cart.
		///     - lines: A list of merchandise lines to add to the cart.
		///     - discountCodes: The discount codes to apply to the cart.
		///     - note: A note that is associated with the cart. For example, the note can be a personalized message to the buyer.
		///     - buyerIdentity: The customer associated with the cart.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(attributes: [AttributeInput]? = nil, lines: [CartLineInput]? = nil, discountCodes: [String]? = nil, note: String? = nil, buyerIdentity: CartBuyerIdentityInput? = nil) {
			self.init(attributes: attributes.orUndefined, lines: lines.orUndefined, discountCodes: discountCodes.orUndefined, note: note.orUndefined, buyerIdentity: buyerIdentity.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch attributes {
				case .value(let attributes): 
				guard let attributes = attributes else {
					fields.append("attributes:null")
					break
				}
				fields.append("attributes:[\(attributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch lines {
				case .value(let lines): 
				guard let lines = lines else {
					fields.append("lines:null")
					break
				}
				fields.append("lines:[\(lines.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch discountCodes {
				case .value(let discountCodes): 
				guard let discountCodes = discountCodes else {
					fields.append("discountCodes:null")
					break
				}
				fields.append("discountCodes:[\(discountCodes.map{ "\(GraphQL.quoteString(input: $0))" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch note {
				case .value(let note): 
				guard let note = note else {
					fields.append("note:null")
					break
				}
				fields.append("note:\(GraphQL.quoteString(input: note))")
				case .undefined: break
			}

			switch buyerIdentity {
				case .value(let buyerIdentity): 
				guard let buyerIdentity = buyerIdentity else {
					fields.append("buyerIdentity:null")
					break
				}
				fields.append("buyerIdentity:\(buyerIdentity.serialize())")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
