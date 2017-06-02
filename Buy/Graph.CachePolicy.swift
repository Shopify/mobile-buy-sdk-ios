//
//  Graph.CachePolicy.swift
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

extension Graph {
    
    /// The caching policy defines the method for executing the query.
    /// Some policies require an `expireIn` parameter that determines
    /// the time (in seconds) until the cache is invalidated and is
    /// considered to be stale.
    ///
    public enum CachePolicy: Equatable {
        
        /// Load from cache without loading from network
        case cacheOnly
        
        /// Load from network without loading from cache
        case networkOnly
        
        /// Load from cache if staleness interval is not exceeded, otherwise load from network
        case cacheFirst(expireIn: Int)
        
        /// Load from network but fallback to cached data if the request fails
        case networkFirst(expireIn: Int)
    }
}

extension Graph.CachePolicy {
    
    public static func ==(lhs: Graph.CachePolicy, rhs: Graph.CachePolicy) -> Bool {
        switch (lhs, rhs) {
        case (.cacheOnly,            .cacheOnly):                           return true
        case (.networkOnly,          .networkOnly):                         return true
        case (.cacheFirst(let lv),   .cacheFirst(let rv))   where lv == rv: return true
        case (.networkFirst(let lv), .networkFirst(let rv)) where lv == rv: return true
        default:
            return false
        }
    }
}
