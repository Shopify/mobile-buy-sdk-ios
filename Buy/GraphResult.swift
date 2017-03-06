//
//  GraphResult.swift
//  Buy
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation

public enum GraphResult<T> {
    case success(T)
    case error(Error?)
}
