//
//  GraphError.swift
//  Buy
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation

public enum GraphError: Error {
    
    public struct Reason {
        
        let message: String
        let line:    Int?
        let column:  Int?
        
        init(json: JSON) {
            self.message = (json["message"] as? String) ?? "Unknown error"
            self.line    = json["line"]     as? Int
            self.column  = json["column"]   as? Int
        }
    }
    
    case request(error: Error?)
    case http(statusCode: Int)
    case noData
    case jsonDeserializationFailed(data: Data?)
    case invalidJson(json: Any)
    case schemaViolationError(violation: SchemaViolationError)
    case queryError(reasons: [Reason])
}
