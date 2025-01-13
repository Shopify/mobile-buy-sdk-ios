//
//  ShopPayPaymentRequestInput.swift
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
	/// The input fields represent a Shop Pay payment request. 
	open class ShopPayPaymentRequestInput {
		/// The discount codes for the payment request. The input must not contain more 
		/// than `250` values. 
		open var discountCodes: Input<[String]>

		/// The line items for the payment request. The input must not contain more 
		/// than `250` values. 
		open var lineItems: Input<[ShopPayPaymentRequestLineItemInput]>

		/// The shipping lines for the payment request. The input must not contain more 
		/// than `250` values. 
		open var shippingLines: Input<[ShopPayPaymentRequestShippingLineInput]>

		/// The total amount for the payment request. 
		open var total: MoneyInput

		/// The subtotal amount for the payment request. 
		open var subtotal: MoneyInput

		/// The discounts for the payment request order. The input must not contain 
		/// more than `250` values. 
		open var discounts: Input<[ShopPayPaymentRequestDiscountInput]>

		/// The total shipping price for the payment request. 
		open var totalShippingPrice: Input<ShopPayPaymentRequestTotalShippingPriceInput>

		/// The total tax for the payment request. 
		open var totalTax: Input<MoneyInput>

		/// The delivery methods for the payment request. The input must not contain 
		/// more than `250` values. 
		open var deliveryMethods: Input<[ShopPayPaymentRequestDeliveryMethodInput]>

		/// The delivery method type for the payment request. 
		open var selectedDeliveryMethodType: Input<ShopPayPaymentRequestDeliveryMethodType>

		/// The locale for the payment request. 
		open var locale: String

		/// The presentment currency for the payment request. 
		open var presentmentCurrency: CurrencyCode

		/// The encrypted payment method for the payment request. 
		open var paymentMethod: Input<String>

		/// Creates the input object.
		///
		/// - parameters:
		///     - discountCodes: The discount codes for the payment request.  The input must not contain more than `250` values.
		///     - lineItems: The line items for the payment request.  The input must not contain more than `250` values.
		///     - shippingLines: The shipping lines for the payment request.  The input must not contain more than `250` values.
		///     - total: The total amount for the payment request.
		///     - subtotal: The subtotal amount for the payment request.
		///     - discounts: The discounts for the payment request order.  The input must not contain more than `250` values.
		///     - totalShippingPrice: The total shipping price for the payment request.
		///     - totalTax: The total tax for the payment request.
		///     - deliveryMethods: The delivery methods for the payment request.  The input must not contain more than `250` values.
		///     - selectedDeliveryMethodType: The delivery method type for the payment request.
		///     - locale: The locale for the payment request.
		///     - presentmentCurrency: The presentment currency for the payment request.
		///     - paymentMethod: The encrypted payment method for the payment request.
		///
		public static func create(total: MoneyInput, subtotal: MoneyInput, locale: String, presentmentCurrency: CurrencyCode, discountCodes: Input<[String]> = .undefined, lineItems: Input<[ShopPayPaymentRequestLineItemInput]> = .undefined, shippingLines: Input<[ShopPayPaymentRequestShippingLineInput]> = .undefined, discounts: Input<[ShopPayPaymentRequestDiscountInput]> = .undefined, totalShippingPrice: Input<ShopPayPaymentRequestTotalShippingPriceInput> = .undefined, totalTax: Input<MoneyInput> = .undefined, deliveryMethods: Input<[ShopPayPaymentRequestDeliveryMethodInput]> = .undefined, selectedDeliveryMethodType: Input<ShopPayPaymentRequestDeliveryMethodType> = .undefined, paymentMethod: Input<String> = .undefined) -> ShopPayPaymentRequestInput {
			return ShopPayPaymentRequestInput(total: total, subtotal: subtotal, locale: locale, presentmentCurrency: presentmentCurrency, discountCodes: discountCodes, lineItems: lineItems, shippingLines: shippingLines, discounts: discounts, totalShippingPrice: totalShippingPrice, totalTax: totalTax, deliveryMethods: deliveryMethods, selectedDeliveryMethodType: selectedDeliveryMethodType, paymentMethod: paymentMethod)
		}

		private init(total: MoneyInput, subtotal: MoneyInput, locale: String, presentmentCurrency: CurrencyCode, discountCodes: Input<[String]> = .undefined, lineItems: Input<[ShopPayPaymentRequestLineItemInput]> = .undefined, shippingLines: Input<[ShopPayPaymentRequestShippingLineInput]> = .undefined, discounts: Input<[ShopPayPaymentRequestDiscountInput]> = .undefined, totalShippingPrice: Input<ShopPayPaymentRequestTotalShippingPriceInput> = .undefined, totalTax: Input<MoneyInput> = .undefined, deliveryMethods: Input<[ShopPayPaymentRequestDeliveryMethodInput]> = .undefined, selectedDeliveryMethodType: Input<ShopPayPaymentRequestDeliveryMethodType> = .undefined, paymentMethod: Input<String> = .undefined) {
			self.discountCodes = discountCodes
			self.lineItems = lineItems
			self.shippingLines = shippingLines
			self.total = total
			self.subtotal = subtotal
			self.discounts = discounts
			self.totalShippingPrice = totalShippingPrice
			self.totalTax = totalTax
			self.deliveryMethods = deliveryMethods
			self.selectedDeliveryMethodType = selectedDeliveryMethodType
			self.locale = locale
			self.presentmentCurrency = presentmentCurrency
			self.paymentMethod = paymentMethod
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - discountCodes: The discount codes for the payment request.  The input must not contain more than `250` values.
		///     - lineItems: The line items for the payment request.  The input must not contain more than `250` values.
		///     - shippingLines: The shipping lines for the payment request.  The input must not contain more than `250` values.
		///     - total: The total amount for the payment request.
		///     - subtotal: The subtotal amount for the payment request.
		///     - discounts: The discounts for the payment request order.  The input must not contain more than `250` values.
		///     - totalShippingPrice: The total shipping price for the payment request.
		///     - totalTax: The total tax for the payment request.
		///     - deliveryMethods: The delivery methods for the payment request.  The input must not contain more than `250` values.
		///     - selectedDeliveryMethodType: The delivery method type for the payment request.
		///     - locale: The locale for the payment request.
		///     - presentmentCurrency: The presentment currency for the payment request.
		///     - paymentMethod: The encrypted payment method for the payment request.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(total: MoneyInput, subtotal: MoneyInput, locale: String, presentmentCurrency: CurrencyCode, discountCodes: [String]? = nil, lineItems: [ShopPayPaymentRequestLineItemInput]? = nil, shippingLines: [ShopPayPaymentRequestShippingLineInput]? = nil, discounts: [ShopPayPaymentRequestDiscountInput]? = nil, totalShippingPrice: ShopPayPaymentRequestTotalShippingPriceInput? = nil, totalTax: MoneyInput? = nil, deliveryMethods: [ShopPayPaymentRequestDeliveryMethodInput]? = nil, selectedDeliveryMethodType: ShopPayPaymentRequestDeliveryMethodType? = nil, paymentMethod: String? = nil) {
			self.init(total: total, subtotal: subtotal, locale: locale, presentmentCurrency: presentmentCurrency, discountCodes: discountCodes.orUndefined, lineItems: lineItems.orUndefined, shippingLines: shippingLines.orUndefined, discounts: discounts.orUndefined, totalShippingPrice: totalShippingPrice.orUndefined, totalTax: totalTax.orUndefined, deliveryMethods: deliveryMethods.orUndefined, selectedDeliveryMethodType: selectedDeliveryMethodType.orUndefined, paymentMethod: paymentMethod.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch discountCodes {
				case .value(let discountCodes):
				guard let discountCodes = discountCodes else {
					fields.append("discountCodes:null")
					break
				}
				fields.append("discountCodes:[\(discountCodes.map { "\(GraphQL.quoteString(input: $0))" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch lineItems {
				case .value(let lineItems):
				guard let lineItems = lineItems else {
					fields.append("lineItems:null")
					break
				}
				fields.append("lineItems:[\(lineItems.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch shippingLines {
				case .value(let shippingLines):
				guard let shippingLines = shippingLines else {
					fields.append("shippingLines:null")
					break
				}
				fields.append("shippingLines:[\(shippingLines.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			fields.append("total:\(total.serialize())")

			fields.append("subtotal:\(subtotal.serialize())")

			switch discounts {
				case .value(let discounts):
				guard let discounts = discounts else {
					fields.append("discounts:null")
					break
				}
				fields.append("discounts:[\(discounts.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch totalShippingPrice {
				case .value(let totalShippingPrice):
				guard let totalShippingPrice = totalShippingPrice else {
					fields.append("totalShippingPrice:null")
					break
				}
				fields.append("totalShippingPrice:\(totalShippingPrice.serialize())")
				case .undefined: break
			}

			switch totalTax {
				case .value(let totalTax):
				guard let totalTax = totalTax else {
					fields.append("totalTax:null")
					break
				}
				fields.append("totalTax:\(totalTax.serialize())")
				case .undefined: break
			}

			switch deliveryMethods {
				case .value(let deliveryMethods):
				guard let deliveryMethods = deliveryMethods else {
					fields.append("deliveryMethods:null")
					break
				}
				fields.append("deliveryMethods:[\(deliveryMethods.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch selectedDeliveryMethodType {
				case .value(let selectedDeliveryMethodType):
				guard let selectedDeliveryMethodType = selectedDeliveryMethodType else {
					fields.append("selectedDeliveryMethodType:null")
					break
				}
				fields.append("selectedDeliveryMethodType:\(selectedDeliveryMethodType.rawValue)")
				case .undefined: break
			}

			fields.append("locale:\(GraphQL.quoteString(input: locale))")

			fields.append("presentmentCurrency:\(presentmentCurrency.rawValue)")

			switch paymentMethod {
				case .value(let paymentMethod):
				guard let paymentMethod = paymentMethod else {
					fields.append("paymentMethod:null")
					break
				}
				fields.append("paymentMethod:\(GraphQL.quoteString(input: paymentMethod))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
