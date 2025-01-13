//
//  ShopPayPaymentRequestLineItemInput.swift
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
	/// The input fields to create a line item for a Shop Pay payment request. 
	open class ShopPayPaymentRequestLineItemInput {
		/// The label of the line item. 
		open var label: Input<String>

		/// The quantity of the line item. 
		open var quantity: Int32

		/// The SKU of the line item. 
		open var sku: Input<String>

		/// Whether the line item requires shipping. 
		open var requiresShipping: Input<Bool>

		/// The image of the line item. 
		open var image: Input<ShopPayPaymentRequestImageInput>

		/// The original line price for the line item. 
		open var originalLinePrice: Input<MoneyInput>

		/// The final line price for the line item. 
		open var finalLinePrice: Input<MoneyInput>

		/// The line discounts for the line item. The input must not contain more than 
		/// `250` values. 
		open var lineDiscounts: Input<[ShopPayPaymentRequestDiscountInput]>

		/// The original item price for the line item. 
		open var originalItemPrice: Input<MoneyInput>

		/// The final item price for the line item. 
		open var finalItemPrice: Input<MoneyInput>

		/// The item discounts for the line item. The input must not contain more than 
		/// `250` values. 
		open var itemDiscounts: Input<[ShopPayPaymentRequestDiscountInput]>

		/// Creates the input object.
		///
		/// - parameters:
		///     - label: The label of the line item.
		///     - quantity: The quantity of the line item.
		///     - sku: The SKU of the line item.
		///     - requiresShipping: Whether the line item requires shipping.
		///     - image: The image of the line item.
		///     - originalLinePrice: The original line price for the line item.
		///     - finalLinePrice: The final line price for the line item.
		///     - lineDiscounts: The line discounts for the line item.  The input must not contain more than `250` values.
		///     - originalItemPrice: The original item price for the line item.
		///     - finalItemPrice: The final item price for the line item.
		///     - itemDiscounts: The item discounts for the line item.  The input must not contain more than `250` values.
		///
		public static func create(quantity: Int32, label: Input<String> = .undefined, sku: Input<String> = .undefined, requiresShipping: Input<Bool> = .undefined, image: Input<ShopPayPaymentRequestImageInput> = .undefined, originalLinePrice: Input<MoneyInput> = .undefined, finalLinePrice: Input<MoneyInput> = .undefined, lineDiscounts: Input<[ShopPayPaymentRequestDiscountInput]> = .undefined, originalItemPrice: Input<MoneyInput> = .undefined, finalItemPrice: Input<MoneyInput> = .undefined, itemDiscounts: Input<[ShopPayPaymentRequestDiscountInput]> = .undefined) -> ShopPayPaymentRequestLineItemInput {
			return ShopPayPaymentRequestLineItemInput(quantity: quantity, label: label, sku: sku, requiresShipping: requiresShipping, image: image, originalLinePrice: originalLinePrice, finalLinePrice: finalLinePrice, lineDiscounts: lineDiscounts, originalItemPrice: originalItemPrice, finalItemPrice: finalItemPrice, itemDiscounts: itemDiscounts)
		}

		private init(quantity: Int32, label: Input<String> = .undefined, sku: Input<String> = .undefined, requiresShipping: Input<Bool> = .undefined, image: Input<ShopPayPaymentRequestImageInput> = .undefined, originalLinePrice: Input<MoneyInput> = .undefined, finalLinePrice: Input<MoneyInput> = .undefined, lineDiscounts: Input<[ShopPayPaymentRequestDiscountInput]> = .undefined, originalItemPrice: Input<MoneyInput> = .undefined, finalItemPrice: Input<MoneyInput> = .undefined, itemDiscounts: Input<[ShopPayPaymentRequestDiscountInput]> = .undefined) {
			self.label = label
			self.quantity = quantity
			self.sku = sku
			self.requiresShipping = requiresShipping
			self.image = image
			self.originalLinePrice = originalLinePrice
			self.finalLinePrice = finalLinePrice
			self.lineDiscounts = lineDiscounts
			self.originalItemPrice = originalItemPrice
			self.finalItemPrice = finalItemPrice
			self.itemDiscounts = itemDiscounts
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - label: The label of the line item.
		///     - quantity: The quantity of the line item.
		///     - sku: The SKU of the line item.
		///     - requiresShipping: Whether the line item requires shipping.
		///     - image: The image of the line item.
		///     - originalLinePrice: The original line price for the line item.
		///     - finalLinePrice: The final line price for the line item.
		///     - lineDiscounts: The line discounts for the line item.  The input must not contain more than `250` values.
		///     - originalItemPrice: The original item price for the line item.
		///     - finalItemPrice: The final item price for the line item.
		///     - itemDiscounts: The item discounts for the line item.  The input must not contain more than `250` values.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(quantity: Int32, label: String? = nil, sku: String? = nil, requiresShipping: Bool? = nil, image: ShopPayPaymentRequestImageInput? = nil, originalLinePrice: MoneyInput? = nil, finalLinePrice: MoneyInput? = nil, lineDiscounts: [ShopPayPaymentRequestDiscountInput]? = nil, originalItemPrice: MoneyInput? = nil, finalItemPrice: MoneyInput? = nil, itemDiscounts: [ShopPayPaymentRequestDiscountInput]? = nil) {
			self.init(quantity: quantity, label: label.orUndefined, sku: sku.orUndefined, requiresShipping: requiresShipping.orUndefined, image: image.orUndefined, originalLinePrice: originalLinePrice.orUndefined, finalLinePrice: finalLinePrice.orUndefined, lineDiscounts: lineDiscounts.orUndefined, originalItemPrice: originalItemPrice.orUndefined, finalItemPrice: finalItemPrice.orUndefined, itemDiscounts: itemDiscounts.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch label {
				case .value(let label):
				guard let label = label else {
					fields.append("label:null")
					break
				}
				fields.append("label:\(GraphQL.quoteString(input: label))")
				case .undefined: break
			}

			fields.append("quantity:\(quantity)")

			switch sku {
				case .value(let sku):
				guard let sku = sku else {
					fields.append("sku:null")
					break
				}
				fields.append("sku:\(GraphQL.quoteString(input: sku))")
				case .undefined: break
			}

			switch requiresShipping {
				case .value(let requiresShipping):
				guard let requiresShipping = requiresShipping else {
					fields.append("requiresShipping:null")
					break
				}
				fields.append("requiresShipping:\(requiresShipping)")
				case .undefined: break
			}

			switch image {
				case .value(let image):
				guard let image = image else {
					fields.append("image:null")
					break
				}
				fields.append("image:\(image.serialize())")
				case .undefined: break
			}

			switch originalLinePrice {
				case .value(let originalLinePrice):
				guard let originalLinePrice = originalLinePrice else {
					fields.append("originalLinePrice:null")
					break
				}
				fields.append("originalLinePrice:\(originalLinePrice.serialize())")
				case .undefined: break
			}

			switch finalLinePrice {
				case .value(let finalLinePrice):
				guard let finalLinePrice = finalLinePrice else {
					fields.append("finalLinePrice:null")
					break
				}
				fields.append("finalLinePrice:\(finalLinePrice.serialize())")
				case .undefined: break
			}

			switch lineDiscounts {
				case .value(let lineDiscounts):
				guard let lineDiscounts = lineDiscounts else {
					fields.append("lineDiscounts:null")
					break
				}
				fields.append("lineDiscounts:[\(lineDiscounts.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch originalItemPrice {
				case .value(let originalItemPrice):
				guard let originalItemPrice = originalItemPrice else {
					fields.append("originalItemPrice:null")
					break
				}
				fields.append("originalItemPrice:\(originalItemPrice.serialize())")
				case .undefined: break
			}

			switch finalItemPrice {
				case .value(let finalItemPrice):
				guard let finalItemPrice = finalItemPrice else {
					fields.append("finalItemPrice:null")
					break
				}
				fields.append("finalItemPrice:\(finalItemPrice.serialize())")
				case .undefined: break
			}

			switch itemDiscounts {
				case .value(let itemDiscounts):
				guard let itemDiscounts = itemDiscounts else {
					fields.append("itemDiscounts:null")
					break
				}
				fields.append("itemDiscounts:[\(itemDiscounts.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
