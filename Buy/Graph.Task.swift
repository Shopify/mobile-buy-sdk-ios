//
//  Graph.Task.swift
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
    
    /// Provides an interface for managing the `URLSessionDataTask` created by `Graph.Client`. Since the 
    /// the underlying `URLSessionDataTask` can change (in the case of retried requests), `Task` provides
    /// a single place to `cancel()` or `resume()` this underlying task.
    ///
    public class Task {
        
        internal private(set) var task: URLSessionDataTask
        
        // ----------------------------------
        //  MARK: - Init -
        //
        internal init(representing task: URLSessionDataTask) {
            self.task = task
        }
        
        // ----------------------------------
        //  MARK: - Setters -
        //
        internal func setTask(_ task: URLSessionDataTask) {
            self.task = task
        }
        
        // ----------------------------------
        //  MARK: - Control -
        //
        
        /// Starts the underlying task
        public func resume() {
            self.task.resume()
        }
        
        /// Cancel the underlying task
        public func cancel() {
            self.task.cancel()
        }
    }
}
