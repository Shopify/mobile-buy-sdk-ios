//
//  Graph.RetryHandler.swift
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

public extension Graph {

    /// A structure that encapsulates a retry condition for polling or retrying `Client` operations.
    public struct RetryHandler<R: GraphQL.AbstractResponse> {

        /// A condition that signals to retry the network operation if it evaluates to `true`.
        public typealias Condition = (R?, QueryError?) -> Bool

        /// Represents the two cases for `Endurance`
        public enum Endurance {

            /// Requests should continue retrying indefinitely
            case infinite

            /// Requests are limited to a finite number of retries
            case finite(Int)

            fileprivate func canContinueFor(_ count: Int) -> Bool {
                switch self {
                case .infinite:          return true
                case .finite(let limit): return count < limit
                }
            }
        }

        /// Indicates how many times a request has been retried
        public internal(set) var repeatCount: Int = 0

        /// The endurance of the retry condition
        public let endurance: Endurance

        /// The retry condition
        public let condition: Condition

        /// The delay, in seconds, between subsequent retry attempts
        public var interval:  Double

        /// Indicates whether the current state allows for another retry operation
        public var canRetry:  Bool {
            return self.endurance.canContinueFor(self.repeatCount)
        }

        // ----------------------------------
        //  MARK: - Init -
        //
        /// Creates a new retry handler representing a condition for retrying `Client` query or mutation operations.
        ///
        /// - parameters:
        ///     - endurance: An endurance value that determines whether the retry condition will be executed indefinitely or up to a specific number of times.
        ///     - interval:  A delay, in seconds, between subsequent retry attempts.
        ///     - condition: A retry condition. The network request will continue retrying if `self.canRetry` **and** `condition` evaluates to `true`.
        ///
        public init(endurance: Endurance = .infinite, interval: Double = 2.0, condition: @escaping Condition) {
            self.endurance = endurance
            self.condition = condition
            self.interval  = interval
        }
    }
}
