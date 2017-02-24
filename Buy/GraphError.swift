//
//  GraphError.swift
//  Buy
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation

public enum GraphQueryError: Error {
    public struct Reason {
        let fields: [String: Any]
        
        public var message: String {
            return (fields["message"] as? String) ?? "Unknown error"
        }
        
        var line: Int? {
            return fields["line"] as? Int
        }
        
        var column: Int? {
            return fields["column"] as? Int
        }
    }
    
    case requestError(error: Error?)
    case invalidHTTPResponse
    case httpError(statusCode: Int)
    case invalidJSONError(data: Data?)
    case invalidGraphQLError(json: Any)
    case schemaViolationError(violation: SchemaViolationError)
    case responseError(errors: [Reason])
    case unknownError(reason: String)
}
