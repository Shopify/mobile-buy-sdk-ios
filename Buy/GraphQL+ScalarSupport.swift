//
//  GraphQL+ScalarSupport.swift
//  Buy
//
//  Created by Dima Bart on 2017-02-23.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation

public extension GraphQL {
    static let posixLocale = Locale(identifier: "en_US_POSIX")
    
    static let iso8601DateParser: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = posixLocale
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
}
