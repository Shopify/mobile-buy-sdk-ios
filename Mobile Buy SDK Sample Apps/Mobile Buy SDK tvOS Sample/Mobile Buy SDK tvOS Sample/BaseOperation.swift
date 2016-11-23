//
//  BaseOperation.swift
//  Mobile Buy SDK tvOS Sample App
//
//  Created by Eishan Vijay on 2016-11-23.
//  Copyright © 2016 Shopify. All rights reserved.
//

import Foundation

class BaseOperation: NSObject {
    
    private var operation: Operation!
    
    func setCurrentOperation(operation: Operation) {
        if self.operation != nil {
            self.operation.cancel()
        }
        
        self.operation = operation
    }
}
