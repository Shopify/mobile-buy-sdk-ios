//
//  OrderFulfillmentStatus.swift
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
	/// Represents the order's aggregated fulfillment status for display purposes. 
	public enum OrderFulfillmentStatus: String {
		/// Displayed as **Fulfilled**. All of the items in the order have been 
		/// fulfilled. 
		case fulfilled = "FULFILLED"

		/// Displayed as **In progress**. Some of the items in the order have been 
		/// fulfilled, or a request for fulfillment has been sent to the fulfillment 
		/// service. 
		case inProgress = "IN_PROGRESS"

		/// Displayed as **On hold**. All of the unfulfilled items in this order are on 
		/// hold. 
		case onHold = "ON_HOLD"

		/// Displayed as **Open**. None of the items in the order have been fulfilled. 
		/// Replaced by "UNFULFILLED" status. 
		case `open` = "OPEN"

		/// Displayed as **Partially fulfilled**. Some of the items in the order have 
		/// been fulfilled. 
		case partiallyFulfilled = "PARTIALLY_FULFILLED"

		/// Displayed as **Pending fulfillment**. A request for fulfillment of some 
		/// items awaits a response from the fulfillment service. Replaced by 
		/// "IN_PROGRESS" status. 
		case pendingFulfillment = "PENDING_FULFILLMENT"

		/// Displayed as **Restocked**. All of the items in the order have been 
		/// restocked. Replaced by "UNFULFILLED" status. 
		case restocked = "RESTOCKED"

		/// Displayed as **Scheduled**. All of the unfulfilled items in this order are 
		/// scheduled for fulfillment at later time. 
		case scheduled = "SCHEDULED"

		/// Displayed as **Unfulfilled**. None of the items in the order have been 
		/// fulfilled. 
		case unfulfilled = "UNFULFILLED"

		case unknownValue = ""
	}
}
