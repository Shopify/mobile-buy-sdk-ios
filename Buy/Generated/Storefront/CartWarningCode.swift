//
//  CartWarningCode.swift
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
	/// The code for the cart warning. 
	public enum CartWarningCode: String {
		/// The discount code cannot be honored. 
		case discountCodeNotHonoured = "DISCOUNT_CODE_NOT_HONOURED"

		/// The discount is currently inactive. 
		case discountCurrentlyInactive = "DISCOUNT_CURRENTLY_INACTIVE"

		/// The customer is not eligible for this discount. 
		case discountCustomerNotEligible = "DISCOUNT_CUSTOMER_NOT_ELIGIBLE"

		/// The customer's discount usage limit has been reached. 
		case discountCustomerUsageLimitReached = "DISCOUNT_CUSTOMER_USAGE_LIMIT_REACHED"

		/// An eligible customer is missing for this discount. 
		case discountEligibleCustomerMissing = "DISCOUNT_ELIGIBLE_CUSTOMER_MISSING"

		/// The purchase type is incompatible with this discount. 
		case discountIncompatiblePurchaseType = "DISCOUNT_INCOMPATIBLE_PURCHASE_TYPE"

		/// The discount was not found. 
		case discountNotFound = "DISCOUNT_NOT_FOUND"

		/// There are no entitled line items for this discount. 
		case discountNoEntitledLineItems = "DISCOUNT_NO_ENTITLED_LINE_ITEMS"

		/// There are no entitled shipping lines for this discount. 
		case discountNoEntitledShippingLines = "DISCOUNT_NO_ENTITLED_SHIPPING_LINES"

		/// The purchase is not in range for this discount. 
		case discountPurchaseNotInRange = "DISCOUNT_PURCHASE_NOT_IN_RANGE"

		/// The quantity is not in range for this discount. 
		case discountQuantityNotInRange = "DISCOUNT_QUANTITY_NOT_IN_RANGE"

		/// The discount usage limit has been reached. 
		case discountUsageLimitReached = "DISCOUNT_USAGE_LIMIT_REACHED"

		/// A delivery address with the same details already exists on this cart. 
		case duplicateDeliveryAddress = "DUPLICATE_DELIVERY_ADDRESS"

		/// The merchandise does not have enough stock. 
		case merchandiseNotEnoughStock = "MERCHANDISE_NOT_ENOUGH_STOCK"

		/// The merchandise is out of stock. 
		case merchandiseOutOfStock = "MERCHANDISE_OUT_OF_STOCK"

		/// Gift cards are not available as a payment method. 
		case paymentsGiftCardsUnavailable = "PAYMENTS_GIFT_CARDS_UNAVAILABLE"

		case unknownValue = ""
	}
}
