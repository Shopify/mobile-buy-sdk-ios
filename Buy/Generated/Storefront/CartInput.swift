//
//  CartInput.swift
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
	/// The input fields to create a cart. 
	open class CartInput {
		/// An array of key-value pairs that contains additional information about the 
		/// cart. The input must not contain more than `250` values. 
		open var attributes: Input<[AttributeInput]>

		/// A list of merchandise lines to add to the cart. The input must not contain 
		/// more than `250` values. 
		open var lines: Input<[CartLineInput]>

		/// The case-insensitive discount codes that the customer added at checkout. 
		/// The input must not contain more than `250` values. 
		open var discountCodes: Input<[String]>

		/// The case-insensitive gift card codes. The input must not contain more than 
		/// `250` values. 
		open var giftCardCodes: Input<[String]>

		/// A note that's associated with the cart. For example, the note can be a 
		/// personalized message to the buyer. 
		open var note: Input<String>

		/// The customer associated with the cart. Used to determine [international 
		/// pricing] 
		/// (https://shopify.dev/custom-storefronts/internationalization/international-pricing). 
		/// Buyer identity should match the customer's shipping address. 
		open var buyerIdentity: Input<CartBuyerIdentityInput>

		/// The delivery-related fields for the cart. 
		open var delivery: Input<CartDeliveryInput>

		/// The metafields to associate with this cart. The input must not contain more 
		/// than `250` values. 
		open var metafields: Input<[CartInputMetafieldInput]>

		/// Creates the input object.
		///
		/// - parameters:
		///     - attributes: An array of key-value pairs that contains additional information about the cart.  The input must not contain more than `250` values.
		///     - lines: A list of merchandise lines to add to the cart.  The input must not contain more than `250` values.
		///     - discountCodes: The case-insensitive discount codes that the customer added at checkout.  The input must not contain more than `250` values.
		///     - giftCardCodes: The case-insensitive gift card codes.  The input must not contain more than `250` values.
		///     - note: A note that's associated with the cart. For example, the note can be a personalized message to the buyer. 
		///     - buyerIdentity: The customer associated with the cart. Used to determine [international pricing] (https://shopify.dev/custom-storefronts/internationalization/international-pricing). Buyer identity should match the customer's shipping address. 
		///     - delivery: The delivery-related fields for the cart.
		///     - metafields: The metafields to associate with this cart.  The input must not contain more than `250` values.
		///
		public static func create(attributes: Input<[AttributeInput]> = .undefined, lines: Input<[CartLineInput]> = .undefined, discountCodes: Input<[String]> = .undefined, giftCardCodes: Input<[String]> = .undefined, note: Input<String> = .undefined, buyerIdentity: Input<CartBuyerIdentityInput> = .undefined, delivery: Input<CartDeliveryInput> = .undefined, metafields: Input<[CartInputMetafieldInput]> = .undefined) -> CartInput {
			return CartInput(attributes: attributes, lines: lines, discountCodes: discountCodes, giftCardCodes: giftCardCodes, note: note, buyerIdentity: buyerIdentity, delivery: delivery, metafields: metafields)
		}

		private init(attributes: Input<[AttributeInput]> = .undefined, lines: Input<[CartLineInput]> = .undefined, discountCodes: Input<[String]> = .undefined, giftCardCodes: Input<[String]> = .undefined, note: Input<String> = .undefined, buyerIdentity: Input<CartBuyerIdentityInput> = .undefined, delivery: Input<CartDeliveryInput> = .undefined, metafields: Input<[CartInputMetafieldInput]> = .undefined) {
			self.attributes = attributes
			self.lines = lines
			self.discountCodes = discountCodes
			self.giftCardCodes = giftCardCodes
			self.note = note
			self.buyerIdentity = buyerIdentity
			self.delivery = delivery
			self.metafields = metafields
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - attributes: An array of key-value pairs that contains additional information about the cart.  The input must not contain more than `250` values.
		///     - lines: A list of merchandise lines to add to the cart.  The input must not contain more than `250` values.
		///     - discountCodes: The case-insensitive discount codes that the customer added at checkout.  The input must not contain more than `250` values.
		///     - giftCardCodes: The case-insensitive gift card codes.  The input must not contain more than `250` values.
		///     - note: A note that's associated with the cart. For example, the note can be a personalized message to the buyer. 
		///     - buyerIdentity: The customer associated with the cart. Used to determine [international pricing] (https://shopify.dev/custom-storefronts/internationalization/international-pricing). Buyer identity should match the customer's shipping address. 
		///     - delivery: The delivery-related fields for the cart.
		///     - metafields: The metafields to associate with this cart.  The input must not contain more than `250` values.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(attributes: [AttributeInput]? = nil, lines: [CartLineInput]? = nil, discountCodes: [String]? = nil, giftCardCodes: [String]? = nil, note: String? = nil, buyerIdentity: CartBuyerIdentityInput? = nil, delivery: CartDeliveryInput? = nil, metafields: [CartInputMetafieldInput]? = nil) {
			self.init(attributes: attributes.orUndefined, lines: lines.orUndefined, discountCodes: discountCodes.orUndefined, giftCardCodes: giftCardCodes.orUndefined, note: note.orUndefined, buyerIdentity: buyerIdentity.orUndefined, delivery: delivery.orUndefined, metafields: metafields.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch attributes {
				case .value(let attributes):
				guard let attributes = attributes else {
					fields.append("attributes:null")
					break
				}
				fields.append("attributes:[\(attributes.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch lines {
				case .value(let lines):
				guard let lines = lines else {
					fields.append("lines:null")
					break
				}
				fields.append("lines:[\(lines.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch discountCodes {
				case .value(let discountCodes):
				guard let discountCodes = discountCodes else {
					fields.append("discountCodes:null")
					break
				}
				fields.append("discountCodes:[\(discountCodes.map { "\(GraphQL.quoteString(input: $0))" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch giftCardCodes {
				case .value(let giftCardCodes):
				guard let giftCardCodes = giftCardCodes else {
					fields.append("giftCardCodes:null")
					break
				}
				fields.append("giftCardCodes:[\(giftCardCodes.map { "\(GraphQL.quoteString(input: $0))" }.joined(separator: ","))]")
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

			switch delivery {
				case .value(let delivery):
				guard let delivery = delivery else {
					fields.append("delivery:null")
					break
				}
				fields.append("delivery:\(delivery.serialize())")
				case .undefined: break
			}

			switch metafields {
				case .value(let metafields):
				guard let metafields = metafields else {
					fields.append("metafields:null")
					break
				}
				fields.append("metafields:[\(metafields.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
