//
//  BUYClientTypes.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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

@class BUYCheckout;

/**
 *  A BUYStatus is associated with the completion of an enqueued job on Shopify.
 *  BUYStatus is equal is HTTP status codes returned from the server
 */
typedef NS_ENUM(NSUInteger, BUYStatus) {
	/**
	 *  The job is complete
	 */
	BUYStatusComplete = 200,
	/**
	 *  The job is still processing
	 */
	BUYStatusProcessing = 202,
	/**
	 *  The job is not found, please check the identifier
	 */
	BUYStatusNotFound = 404,
	/**
	 *  The precondition given in one or more of the request-header fields evaluated to false when it was tested on the server.
	 */
	BUYStatusPreconditionFailed = 412,
	/**
	 *  The request failed, refer to an NSError for details
	 */
	BUYStatusFailed = 424,
	/**
	 *  The status is unknown
	 */
	BUYStatusUnknown
};

/**
 *  Return block containing a BUYStatus and/or an NSError
 *
 *  @param status   A BUYStatus specifying the requested job's completion status
 *  @param error    Optional NSError
 */
typedef void (^BUYDataStatusBlock)(BUYStatus status, NSError * _Nullable error);

/**
 *  Return block containing a BUYCheckout and an NSError
 *
 *  @param checkout A BUYCheckout object
 *  @param error    Optional NSError
 */
typedef void (^BUYCheckoutOperationCompletion)(BUYCheckout * _Nullable checkout, NSError * _Nullable error);

/**
 *  Return block containing a BUYStatus, a BUYCheckout and/or an NSError
 *
 *  @param status   A BUYStatus specifying the requested job's completion status
 *  @param checkout A BUYCheckout object
 *  @param error    Optional NSError
 */
typedef void (^BUYCheckoutStatusOperationCompletion)(BUYStatus status, BUYCheckout * _Nullable checkout, NSError * _Nullable error);
