//
//  NSObject+Name.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
