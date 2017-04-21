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
    
    public struct RetryHandler<R: GraphQL.AbstractResponse> {
        
        public typealias Condition = (R?, QueryError?) -> Bool
        
        public enum Endurance {
            case infinite
            case finite(Int)
            
            fileprivate func canContinueFor(_ count: Int) -> Bool {
                switch self {
                case .infinite:          return true
                case .finite(let limit): return count < limit
                }
            }
        }
        
        public internal(set) var repeatCount: Int = 0
        
        public let endurance: Endurance
        public let condition: Condition
        
        public var interval:  Double
        public var canRetry:  Bool {
            return self.endurance.canContinueFor(self.repeatCount)
        }
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(endurance: Endurance = .infinite, interval: Double = 2.0, condition: @escaping Condition) {
            self.endurance = endurance
            self.condition = condition
            self.interval  = interval
        }
    }
}
