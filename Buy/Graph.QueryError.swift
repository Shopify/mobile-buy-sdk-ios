//
//  Graph.QueryError.swift
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

    /// Represents an error that was encountered somewhere in the request pipeline.
    public enum QueryError: Error {

        /// For invalid queries, a collection of `Reason`s is provided to indicate exactly where the problem occurred in the query.
        public struct Reason {

            /// The error message associated with the line and column number
            public let message: String
            
            /// Line on which the error occurred
            public let line: Int?
            
            /// The column at which the error occurred
            public let column: Int?
            
            internal init(json: JSON) {
                self.message = (json["message"] as? String) ?? "Unknown error"
                self.line    = json["line"]     as? Int
                self.column  = json["column"]   as? Int
            }
        }

        /// A non-HTTPURLResponse was received
        case request(error: Error?)

        /// A non-200 status code was received
        case http(statusCode: Int)

        /// The response contains no data
        case noData

        /// JSON deserialization failed, invalid syntax
        case jsonDeserializationFailed(data: Data?)

        /// JSON structure doesn't match expectation
        case invalidJson(json: Any)

        /// The provided query was partially or completely invalid
        case invalidQuery(reasons: [Reason])

        /// The response schema does not match expectation
        case schemaViolation(violation: SchemaViolationError)
    }
}
