//
//  BUYClient+Extensions.swift
//  Sample App Customers
//
//  Created by Dima Bart on 2016-05-03.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

import Foundation
import Buy

extension BUYClient {
    
    static var sharedClient: BUYClient {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            return delegate.client
        }
        fatalError("Could not retrieve shared BUYClient")
    }
}